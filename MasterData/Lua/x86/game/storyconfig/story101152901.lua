return {
	Play115291001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 115291001
		arg_1_1.duration_ = 7.9

		local var_1_0 = {
			ja = 6.266,
			ko = 6.4,
			zh = 7.3,
			en = 7.9
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
				arg_1_0:Play115291002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_9000

			if arg_1_1.bgs_.ST22a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST22a")
				var_4_0.name = "ST22a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST22a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST22a

				arg_1_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST22a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = false

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_1_3_story_destroyed", "bgm_activity_1_3_story_destroyed")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			local var_4_15 = "1041_1"

			if arg_1_1.actors_["1041_1"] == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_16.transform:SetSiblingIndex(1)

				var_4_16.name = var_4_15

				local var_4_17 = var_4_16:GetComponent(typeof(Image))

				var_4_17.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1041_1")

				var_4_17:SetNativeSize()

				var_4_16.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_15] = var_4_16
			end

			local var_4_18 = arg_1_1.actors_["1041_1"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041_1 = var_4_18.localPosition
				var_4_18.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_4_19 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041_1, Vector3.New(440, -310, -370), (arg_1_1.time_ - 2) / var_4_19)
			end

			if arg_1_1.time_ >= 2 + var_4_19 and arg_1_1.time_ < 2 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(440, -310, -370)
			end

			local var_4_20 = "1041"

			if arg_1_1.actors_["1041"] == nil then
				local var_4_21 = Object.Instantiate(arg_1_1.imageGo_, arg_1_1.canvasGo_.transform)

				var_4_21.transform:SetSiblingIndex(1)

				var_4_21.name = var_4_20

				local var_4_22 = var_4_21:GetComponent(typeof(Image))

				var_4_22.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "1041")

				var_4_22:SetNativeSize()

				var_4_21.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_1_1.actors_[var_4_20] = var_4_21
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				local var_4_23 = arg_1_1.actors_["1041"]:GetComponent("Image")

				if var_4_23 then
					arg_1_1.var_.alphaMatValue1041 = var_4_23
					arg_1_1.var_.alphaOldValue1041 = var_4_23.color.a
				end

				arg_1_1.var_.alphaOldValue1041 = 0
			end

			local var_4_24 = 0.333333333333333

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_24 then
				if arg_1_1.var_.alphaMatValue1041 then
					arg_1_1.var_.alphaMatValue1041.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValue1041, 1, (arg_1_1.time_ - 2) / var_4_24)
					arg_1_1.var_.alphaMatValue1041.color = arg_1_1.var_.alphaMatValue1041.color
				end
			end

			if arg_1_1.time_ >= 2 + var_4_24 and arg_1_1.time_ < 2 + var_4_24 + arg_4_0 and arg_1_1.var_.alphaMatValue1041 then
				arg_1_1.var_.alphaMatValue1041.color.a = 1
				arg_1_1.var_.alphaMatValue1041.color = arg_1_1.var_.alphaMatValue1041.color
			end

			local var_4_25 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_25 + 3 and arg_1_1.time_ < var_4_25 + 3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_26 = arg_1_1.actors_["1041_1"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_26) then
				local var_4_27 = var_4_26:GetComponent("Image")

				if var_4_27 then
					arg_1_1.var_.highlightMatValue1041_1 = var_4_27
				end
			end

			local var_4_28 = 0.2

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_28 and not isNil(var_4_26) then
				if arg_1_1.var_.highlightMatValue1041_1 then
					local var_4_29 = Mathf.Lerp(0.5, 1, (arg_1_1.time_ - 2) / var_4_28)

					arg_1_1.var_.highlightMatValue1041_1.color.r = var_4_29
					arg_1_1.var_.highlightMatValue1041_1.color.g = var_4_29
					arg_1_1.var_.highlightMatValue1041_1.color.b = var_4_29
					arg_1_1.var_.highlightMatValue1041_1.color = arg_1_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_1_1.time_ >= 2 + var_4_28 and arg_1_1.time_ < 2 + var_4_28 + arg_4_0 and not isNil(var_4_26) and arg_1_1.var_.highlightMatValue1041_1 then
				var_4_26.transform:SetSiblingIndex(1)

				arg_1_1.var_.highlightMatValue1041_1.color.r = 1
				arg_1_1.var_.highlightMatValue1041_1.color.g = 1
				arg_1_1.var_.highlightMatValue1041_1.color.b = 1
				arg_1_1.var_.highlightMatValue1041_1.color = arg_1_1.var_.highlightMatValue1041_1.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_30 = arg_1_1.var_.effectYU

				if not arg_1_1.var_.effectYU then
					var_4_30 = Object.Instantiate(Asset.Load("Effect/Scene/fx_raindrop"), manager.ui.mainCamera.transform)
					var_4_30.name = "YU"
					arg_1_1.var_.effectYU = var_4_30
				else
					var_4_30.transform:SetParent(var_4_9000)
				end

				var_4_30.transform.localPosition = Vector3.New(0, 0, 0.03)
				var_4_30.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_32 = 2
			local var_4_33 = 0.525

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_32 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_34 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_34:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_35 = arg_1_1:GetWordFromCfg(115291001)
				local var_4_36 = arg_1_1:FormatText(var_4_35.content)

				arg_1_1.text_.text = var_4_36

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_38 = 21 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 21)

				if (21 <= 0 and var_4_33 or var_4_33 * (utf8.len(var_4_36) / 21)) > 0 and var_4_33 < var_4_38 then
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

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291001", "story_v_out_115291.awb") ~= 0 then
					local var_4_39 = manager.audio:GetVoiceLength("story_v_out_115291", "115291001", "story_v_out_115291.awb") / 1000

					if var_4_39 + var_4_32 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_39 + var_4_32
					end

					if var_4_35.prefab_name ~= "" and arg_1_1.actors_[var_4_35.prefab_name] ~= nil then
						local var_4_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_35.prefab_name].transform, "story_v_out_115291", "115291001", "story_v_out_115291.awb")

						arg_1_1:RecordAudio("115291001", var_4_40)
						arg_1_1:RecordAudio("115291001", var_4_40)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_115291", "115291001", "story_v_out_115291.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_115291", "115291001", "story_v_out_115291.awb")
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
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play115291002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 115291002
		arg_9_1.duration_ = 3.9

		local var_9_0 = {
			ja = 3.9,
			ko = 3.9,
			zh = 3.8,
			en = 3.533
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
				arg_9_0:Play115291003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10030"] == nil then
				local var_12_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10030")

				if not isNil(var_12_0) then
					local var_12_1 = Object.Instantiate(var_12_0, arg_9_1.canvasGo_.transform)

					var_12_1.transform:SetSiblingIndex(1)

					var_12_1.name = "10030"
					var_12_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_9_1.actors_["10030"] = var_12_1

					if arg_9_1.isInRecall_ then
						for iter_12_0, iter_12_1 in ipairs((var_12_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_12_1.color = arg_9_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_12_2 = arg_9_1.actors_["10030"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10030 = var_12_2.localPosition
				var_12_2.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10030", 2)

				for iter_12_2 = 0, var_12_2.childCount - 1 do
					local var_12_3 = var_12_2:GetChild(iter_12_2)

					if var_12_3.name == "split_1" or not string.find(var_12_3.name, "split") then
						var_12_3.gameObject:SetActive(true)
					else
						var_12_3.gameObject:SetActive(false)
					end
				end
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_2.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_9_1.time_ - 0) / var_12_4)
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_2.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_12_5 = arg_9_1.actors_["1041_1"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) then
				local var_12_6 = var_12_5:GetComponent("Image")

				if var_12_6 then
					arg_9_1.var_.highlightMatValue1041_1 = var_12_6
				end
			end

			local var_12_7 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 and not isNil(var_12_5) then
				if arg_9_1.var_.highlightMatValue1041_1 then
					local var_12_8 = Mathf.Lerp(1, 0.5, (arg_9_1.time_ - 0) / var_12_7)

					arg_9_1.var_.highlightMatValue1041_1.color.r = var_12_8
					arg_9_1.var_.highlightMatValue1041_1.color.g = var_12_8
					arg_9_1.var_.highlightMatValue1041_1.color.b = var_12_8
					arg_9_1.var_.highlightMatValue1041_1.color = arg_9_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.highlightMatValue1041_1 then
				arg_9_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_9_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_9_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_9_1.var_.highlightMatValue1041_1.color = arg_9_1.var_.highlightMatValue1041_1.color
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_9 = arg_9_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_9 then
					arg_9_1.var_.alphaOldValue10030 = var_12_9.alpha
					arg_9_1.var_.characterEffect10030 = var_12_9
				end

				arg_9_1.var_.alphaOldValue10030 = 0
			end

			local var_12_10 = 0.333333333333333

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_10 then
				if arg_9_1.var_.characterEffect10030 then
					arg_9_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10030, 1, (arg_9_1.time_ - 0) / var_12_10)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_10 and arg_9_1.time_ < 0 + var_12_10 + arg_12_0 and arg_9_1.var_.characterEffect10030 then
				arg_9_1.var_.characterEffect10030.alpha = 1
			end

			local var_12_11 = 0
			local var_12_12 = 0.325

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_11 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_13 = arg_9_1:GetWordFromCfg(115291002)
				local var_12_14 = arg_9_1:FormatText(var_12_13.content)

				arg_9_1.text_.text = var_12_14

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_16 = 13 <= 0 and var_12_12 or var_12_12 * (utf8.len(var_12_14) / 13)

				if (13 <= 0 and var_12_12 or var_12_12 * (utf8.len(var_12_14) / 13)) > 0 and var_12_12 < var_12_16 then
					arg_9_1.talkMaxDuration = var_12_16

					if var_12_16 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_11
					end
				end

				arg_9_1.text_.text = var_12_14
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291002", "story_v_out_115291.awb") ~= 0 then
					local var_12_17 = manager.audio:GetVoiceLength("story_v_out_115291", "115291002", "story_v_out_115291.awb") / 1000

					if var_12_17 + var_12_11 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_11
					end

					if var_12_13.prefab_name ~= "" and arg_9_1.actors_[var_12_13.prefab_name] ~= nil then
						local var_12_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_13.prefab_name].transform, "story_v_out_115291", "115291002", "story_v_out_115291.awb")

						arg_9_1:RecordAudio("115291002", var_12_18)
						arg_9_1:RecordAudio("115291002", var_12_18)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_115291", "115291002", "story_v_out_115291.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_115291", "115291002", "story_v_out_115291.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_19 = math.max(var_12_12, arg_9_1.talkMaxDuration)

			if var_12_11 <= arg_9_1.time_ and arg_9_1.time_ < var_12_11 + var_12_19 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_11) / var_12_19

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_11 + var_12_19 and arg_9_1.time_ < var_12_11 + var_12_19 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115291003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 115291003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play115291004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_0 = arg_13_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_16_0 then
					arg_13_1.var_.alphaOldValue10030 = var_16_0.alpha
					arg_13_1.var_.characterEffect10030 = var_16_0
				end

				arg_13_1.var_.alphaOldValue10030 = 1
			end

			local var_16_1 = 0.333333333333333

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_1 then
				if arg_13_1.var_.characterEffect10030 then
					arg_13_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_13_1.var_.alphaOldValue10030, 0, (arg_13_1.time_ - 0) / var_16_1)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_1 and arg_13_1.time_ < 0 + var_16_1 + arg_16_0 and arg_13_1.var_.characterEffect10030 then
				arg_13_1.var_.characterEffect10030.alpha = 0
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				local var_16_2 = arg_13_1.actors_["1041_1"]:GetComponent("Image")

				if var_16_2 then
					arg_13_1.var_.alphaMatValue1041_1 = var_16_2
					arg_13_1.var_.alphaOldValue1041_1 = var_16_2.color.a
				end

				arg_13_1.var_.alphaOldValue1041_1 = 1
			end

			local var_16_3 = 0.333333333333333

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_3 then
				if arg_13_1.var_.alphaMatValue1041_1 then
					arg_13_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_13_1.var_.alphaOldValue1041_1, 0, (arg_13_1.time_ - 0) / var_16_3)
					arg_13_1.var_.alphaMatValue1041_1.color = arg_13_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_13_1.time_ >= 0 + var_16_3 and arg_13_1.time_ < 0 + var_16_3 + arg_16_0 and arg_13_1.var_.alphaMatValue1041_1 then
				arg_13_1.var_.alphaMatValue1041_1.color.a = 0
				arg_13_1.var_.alphaMatValue1041_1.color = arg_13_1.var_.alphaMatValue1041_1.color
			end

			local var_16_4 = arg_13_1.actors_["10030"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10030 == nil then
				arg_13_1.var_.actorSpriteComps10030 = var_16_4:GetComponentsInChildren(typeof(Image), true)
			end

			local var_16_5 = 0.0166666666666667

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 and not isNil(var_16_4) then
				if arg_13_1.var_.actorSpriteComps10030 then
					for iter_16_0, iter_16_1 in pairs(arg_13_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_16_1 then
							if arg_13_1.isInRecall_ then
								iter_16_1.color = Color.New(Mathf.Lerp(iter_16_1.color.r, arg_13_1.hightColor2.r, (arg_13_1.time_ - 0) / var_16_5), Mathf.Lerp(iter_16_1.color.g, arg_13_1.hightColor2.g, (arg_13_1.time_ - 0) / var_16_5), (Mathf.Lerp(iter_16_1.color.b, arg_13_1.hightColor2.b, (arg_13_1.time_ - 0) / var_16_5)))
							else
								local var_16_6 = Mathf.Lerp(iter_16_1.color.r, 0.5, (arg_13_1.time_ - 0) / var_16_5)

								iter_16_1.color = Color.New(var_16_6, var_16_6, var_16_6)
							end
						end
					end
				end
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 and not isNil(var_16_4) and arg_13_1.var_.actorSpriteComps10030 then
				for iter_16_2, iter_16_3 in pairs(arg_13_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_16_3 then
						iter_16_3.color = arg_13_1.isInRecall_ and (arg_13_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_13_1.var_.actorSpriteComps10030 = nil
			end

			local var_16_7 = 0
			local var_16_8 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_7 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, false)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_9 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(115291003).content)

				arg_13_1.text_.text = var_16_9

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_11 = 18 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_9) / 18)

				if (18 <= 0 and var_16_8 or var_16_8 * (utf8.len(var_16_9) / 18)) > 0 and var_16_8 < var_16_11 then
					arg_13_1.talkMaxDuration = var_16_11

					if var_16_11 + var_16_7 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_11 + var_16_7
					end
				end

				arg_13_1.text_.text = var_16_9
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_8, arg_13_1.talkMaxDuration)

			if var_16_7 <= arg_13_1.time_ and arg_13_1.time_ < var_16_7 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_7) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_7 + var_16_12 and arg_13_1.time_ < var_16_7 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play115291004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 115291004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play115291005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			local var_20_0 = 1.125

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

				local var_20_1 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(115291004).content)

				arg_17_1.text_.text = var_20_1

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_3 = 45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 45)

				if (45 <= 0 and var_20_0 or var_20_0 * (utf8.len(var_20_1) / 45)) > 0 and var_20_0 < var_20_3 then
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
	Play115291005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 115291005
		arg_21_1.duration_ = 13.6

		local var_21_0 = {
			ja = 9.6,
			ko = 8.9,
			zh = 9.366,
			en = 13.6
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
				arg_21_0:Play115291006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1041_1 = arg_21_1.actors_["1041_1"].transform.localPosition
				arg_21_1.actors_["1041_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_21_1:CheckSpriteTmpPos("1041_1", 3)
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1041_1"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1041_1, Vector3.New(120, -310, -370), (arg_21_1.time_ - 0) / var_24_0)
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1041_1"].transform.localPosition = Vector3.New(120, -310, -370)
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("stop", "music", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")

				local var_24_3 = manager.audio:GetAudioName("se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop")

				if "" ~= "" then
					if arg_21_1.bgmTxt_.text ~= var_24_3 and arg_21_1.bgmTxt_.text ~= "" then
						if arg_21_1.bgmTxt2_.text ~= "" then
							arg_21_1.bgmTxt_.text = arg_21_1.bgmTxt2_.text
						end

						arg_21_1.bgmTxt2_.text = var_24_3

						arg_21_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_21_1.bgmTxt_.text = var_24_3
						arg_21_1.bgmTxt2_.text = var_24_3
					end

					if arg_21_1.bgmTimer then
						arg_21_1.bgmTimer:Stop()

						arg_21_1.bgmTimer = nil
					end

					if arg_21_1.settingData.show_music_name == 1 then
						arg_21_1.musicController:SetSelectedState("show")
						arg_21_1.musicAnimator_:Play("open", 0, 0)

						if arg_21_1.settingData.music_time ~= 0 then
							arg_21_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_21_1.settingData.music_time), function()
								if arg_21_1 == nil or isNil(arg_21_1.bgmTxt_) then
									return
								end

								arg_21_1.musicController:SetSelectedState("hide")
								arg_21_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_24_4 = arg_21_1.actors_["1041_1"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_4) then
				local var_24_5 = var_24_4:GetComponent("Image")

				if var_24_5 then
					arg_21_1.var_.highlightMatValue1041_1 = var_24_5
				end
			end

			local var_24_6 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_4) then
				if arg_21_1.var_.highlightMatValue1041_1 then
					local var_24_7 = Mathf.Lerp(0.5, 1, (arg_21_1.time_ - 0) / var_24_6)

					arg_21_1.var_.highlightMatValue1041_1.color.r = var_24_7
					arg_21_1.var_.highlightMatValue1041_1.color.g = var_24_7
					arg_21_1.var_.highlightMatValue1041_1.color.b = var_24_7
					arg_21_1.var_.highlightMatValue1041_1.color = arg_21_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_4) and arg_21_1.var_.highlightMatValue1041_1 then
				var_24_4.transform:SetSiblingIndex(1)

				arg_21_1.var_.highlightMatValue1041_1.color.r = 1
				arg_21_1.var_.highlightMatValue1041_1.color.g = 1
				arg_21_1.var_.highlightMatValue1041_1.color.b = 1
				arg_21_1.var_.highlightMatValue1041_1.color = arg_21_1.var_.highlightMatValue1041_1.color
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				local var_24_8 = arg_21_1.actors_["1041_1"]:GetComponent("Image")

				if var_24_8 then
					arg_21_1.var_.alphaMatValue1041_1 = var_24_8
					arg_21_1.var_.alphaOldValue1041_1 = var_24_8.color.a
				end

				arg_21_1.var_.alphaOldValue1041_1 = 0
			end

			local var_24_9 = 0.333333333333333

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_9 then
				if arg_21_1.var_.alphaMatValue1041_1 then
					arg_21_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_21_1.var_.alphaOldValue1041_1, 1, (arg_21_1.time_ - 0) / var_24_9)
					arg_21_1.var_.alphaMatValue1041_1.color = arg_21_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_21_1.time_ >= 0 + var_24_9 and arg_21_1.time_ < 0 + var_24_9 + arg_24_0 and arg_21_1.var_.alphaMatValue1041_1 then
				arg_21_1.var_.alphaMatValue1041_1.color.a = 1
				arg_21_1.var_.alphaMatValue1041_1.color = arg_21_1.var_.alphaMatValue1041_1.color
			end

			local var_24_10 = 0
			local var_24_11 = 1.075

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_10 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_12 = arg_21_1:GetWordFromCfg(115291005)
				local var_24_13 = arg_21_1:FormatText(var_24_12.content)

				arg_21_1.text_.text = var_24_13

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_15 = 43 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 43)

				if (43 <= 0 and var_24_11 or var_24_11 * (utf8.len(var_24_13) / 43)) > 0 and var_24_11 < var_24_15 then
					arg_21_1.talkMaxDuration = var_24_15

					if var_24_15 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_15 + var_24_10
					end
				end

				arg_21_1.text_.text = var_24_13
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291005", "story_v_out_115291.awb") ~= 0 then
					local var_24_16 = manager.audio:GetVoiceLength("story_v_out_115291", "115291005", "story_v_out_115291.awb") / 1000

					if var_24_16 + var_24_10 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_16 + var_24_10
					end

					if var_24_12.prefab_name ~= "" and arg_21_1.actors_[var_24_12.prefab_name] ~= nil then
						local var_24_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_12.prefab_name].transform, "story_v_out_115291", "115291005", "story_v_out_115291.awb")

						arg_21_1:RecordAudio("115291005", var_24_17)
						arg_21_1:RecordAudio("115291005", var_24_17)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_115291", "115291005", "story_v_out_115291.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_115291", "115291005", "story_v_out_115291.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_18 = math.max(var_24_11, arg_21_1.talkMaxDuration)

			if var_24_10 <= arg_21_1.time_ and arg_21_1.time_ < var_24_10 + var_24_18 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_10) / var_24_18

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_10 + var_24_18 and arg_21_1.time_ < var_24_10 + var_24_18 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play115291006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 115291006
		arg_26_1.duration_ = 14.53

		local var_26_0 = {
			ja = 14.533,
			ko = 7.733,
			zh = 6.766,
			en = 9.7
		}
		local var_26_1 = manager.audio:GetLocalizationFlag()

		if var_26_0[var_26_1] ~= nil then
			arg_26_1.duration_ = var_26_0[var_26_1]
		end

		SetActive(arg_26_1.tipsGo_, false)

		function arg_26_1.onSingleLineFinish_()
			arg_26_1.onSingleLineUpdate_ = nil
			arg_26_1.onSingleLineFinish_ = nil
			arg_26_1.state_ = "waiting"
		end

		function arg_26_1.playNext_(arg_28_0)
			if arg_28_0 == 1 then
				arg_26_0:Play115291007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			local var_29_0 = 0.825

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_1 = arg_26_1:GetWordFromCfg(115291006)
				local var_29_2 = arg_26_1:FormatText(var_29_1.content)

				arg_26_1.text_.text = var_29_2

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_4 = 33 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 33)

				if (33 <= 0 and var_29_0 or var_29_0 * (utf8.len(var_29_2) / 33)) > 0 and var_29_0 < var_29_4 then
					arg_26_1.talkMaxDuration = var_29_4

					if var_29_4 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_4 + 0
					end
				end

				arg_26_1.text_.text = var_29_2
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291006", "story_v_out_115291.awb") ~= 0 then
					local var_29_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291006", "story_v_out_115291.awb") / 1000

					if var_29_5 + 0 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_5 + 0
					end

					if var_29_1.prefab_name ~= "" and arg_26_1.actors_[var_29_1.prefab_name] ~= nil then
						local var_29_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_1.prefab_name].transform, "story_v_out_115291", "115291006", "story_v_out_115291.awb")

						arg_26_1:RecordAudio("115291006", var_29_6)
						arg_26_1:RecordAudio("115291006", var_29_6)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_115291", "115291006", "story_v_out_115291.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_115291", "115291006", "story_v_out_115291.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_7 = math.max(var_29_0, arg_26_1.talkMaxDuration)

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_7 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - 0) / var_29_7

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= 0 + var_29_7 and arg_26_1.time_ < 0 + var_29_7 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play115291007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 115291007
		arg_30_1.duration_ = 5

		SetActive(arg_30_1.tipsGo_, false)

		function arg_30_1.onSingleLineFinish_()
			arg_30_1.onSingleLineUpdate_ = nil
			arg_30_1.onSingleLineFinish_ = nil
			arg_30_1.state_ = "waiting"
		end

		function arg_30_1.playNext_(arg_32_0)
			if arg_32_0 == 1 then
				arg_30_0:Play115291008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 then
				local var_33_0 = arg_30_1.actors_["1041_1"]:GetComponent("Image")

				if var_33_0 then
					arg_30_1.var_.alphaMatValue1041_1 = var_33_0
					arg_30_1.var_.alphaOldValue1041_1 = var_33_0.color.a
				end

				arg_30_1.var_.alphaOldValue1041_1 = 1
			end

			local var_33_1 = 0.333333333333333

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_1 then
				if arg_30_1.var_.alphaMatValue1041_1 then
					arg_30_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_30_1.var_.alphaOldValue1041_1, 0, (arg_30_1.time_ - 0) / var_33_1)
					arg_30_1.var_.alphaMatValue1041_1.color = arg_30_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_30_1.time_ >= 0 + var_33_1 and arg_30_1.time_ < 0 + var_33_1 + arg_33_0 and arg_30_1.var_.alphaMatValue1041_1 then
				arg_30_1.var_.alphaMatValue1041_1.color.a = 0
				arg_30_1.var_.alphaMatValue1041_1.color = arg_30_1.var_.alphaMatValue1041_1.color
			end

			local var_33_2 = 0
			local var_33_3 = 0.9

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_2 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, false)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_4 = arg_30_1:FormatText(arg_30_1:GetWordFromCfg(115291007).content)

				arg_30_1.text_.text = var_33_4

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_6 = 36 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_4) / 36)

				if (36 <= 0 and var_33_3 or var_33_3 * (utf8.len(var_33_4) / 36)) > 0 and var_33_3 < var_33_6 then
					arg_30_1.talkMaxDuration = var_33_6

					if var_33_6 + var_33_2 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_6 + var_33_2
					end
				end

				arg_30_1.text_.text = var_33_4
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)
				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_7 = math.max(var_33_3, arg_30_1.talkMaxDuration)

			if var_33_2 <= arg_30_1.time_ and arg_30_1.time_ < var_33_2 + var_33_7 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_2) / var_33_7

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_2 + var_33_7 and arg_30_1.time_ < var_33_2 + var_33_7 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play115291008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 115291008
		arg_34_1.duration_ = 5.67

		local var_34_0 = {
			ja = 5,
			ko = 5.666,
			zh = 3.9,
			en = 5.166
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
				arg_34_0:Play115291009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos1041_1 = arg_34_1.actors_["1041_1"].transform.localPosition
				arg_34_1.actors_["1041_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_37_0 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 then
				arg_34_1.actors_["1041_1"].transform.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos1041_1, Vector3.New(440, -310, -370), (arg_34_1.time_ - 0) / var_37_0)
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 then
				arg_34_1.actors_["1041_1"].transform.localPosition = Vector3.New(440, -310, -370)
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_1 = arg_34_1.actors_["1041_1"]:GetComponent("Image")

				if var_37_1 then
					arg_34_1.var_.alphaMatValue1041_1 = var_37_1
					arg_34_1.var_.alphaOldValue1041_1 = var_37_1.color.a
				end

				arg_34_1.var_.alphaOldValue1041_1 = 0
			end

			local var_37_2 = 0.333333333333333

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_2 then
				if arg_34_1.var_.alphaMatValue1041_1 then
					arg_34_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_34_1.var_.alphaOldValue1041_1, 1, (arg_34_1.time_ - 0) / var_37_2)
					arg_34_1.var_.alphaMatValue1041_1.color = arg_34_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_34_1.time_ >= 0 + var_37_2 and arg_34_1.time_ < 0 + var_37_2 + arg_37_0 and arg_34_1.var_.alphaMatValue1041_1 then
				arg_34_1.var_.alphaMatValue1041_1.color.a = 1
				arg_34_1.var_.alphaMatValue1041_1.color = arg_34_1.var_.alphaMatValue1041_1.color
			end

			local var_37_3 = arg_34_1.actors_["10030"].transform

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				arg_34_1.var_.moveOldPos10030 = var_37_3.localPosition
				var_37_3.localScale = Vector3.New(1, 1, 1)

				arg_34_1:CheckSpriteTmpPos("10030", 2)

				for iter_37_0 = 0, var_37_3.childCount - 1 do
					local var_37_4 = var_37_3:GetChild(iter_37_0)

					if var_37_4.name == "split_3" or not string.find(var_37_4.name, "split") then
						var_37_4.gameObject:SetActive(true)
					else
						var_37_4.gameObject:SetActive(false)
					end
				end
			end

			local var_37_5 = 0.001

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_5 then
				var_37_3.localPosition = Vector3.Lerp(arg_34_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_34_1.time_ - 0) / var_37_5)
			end

			if arg_34_1.time_ >= 0 + var_37_5 and arg_34_1.time_ < 0 + var_37_5 + arg_37_0 then
				var_37_3.localPosition = Vector3.New(-390, -390, 150)
			end

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 then
				local var_37_6 = arg_34_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_37_6 then
					arg_34_1.var_.alphaOldValue10030 = var_37_6.alpha
					arg_34_1.var_.characterEffect10030 = var_37_6
				end

				arg_34_1.var_.alphaOldValue10030 = 0
			end

			local var_37_7 = 0.333333333333333

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_7 then
				if arg_34_1.var_.characterEffect10030 then
					arg_34_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_34_1.var_.alphaOldValue10030, 1, (arg_34_1.time_ - 0) / var_37_7)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_7 and arg_34_1.time_ < 0 + var_37_7 + arg_37_0 and arg_34_1.var_.characterEffect10030 then
				arg_34_1.var_.characterEffect10030.alpha = 1
			end

			local var_37_8 = arg_34_1.actors_["1041_1"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_8) then
				local var_37_9 = var_37_8:GetComponent("Image")

				if var_37_9 then
					arg_34_1.var_.highlightMatValue1041_1 = var_37_9
				end
			end

			local var_37_10 = 0.2

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_10 and not isNil(var_37_8) then
				if arg_34_1.var_.highlightMatValue1041_1 then
					local var_37_11 = Mathf.Lerp(0.5, 1, (arg_34_1.time_ - 0) / var_37_10)

					arg_34_1.var_.highlightMatValue1041_1.color.r = var_37_11
					arg_34_1.var_.highlightMatValue1041_1.color.g = var_37_11
					arg_34_1.var_.highlightMatValue1041_1.color.b = var_37_11
					arg_34_1.var_.highlightMatValue1041_1.color = arg_34_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_34_1.time_ >= 0 + var_37_10 and arg_34_1.time_ < 0 + var_37_10 + arg_37_0 and not isNil(var_37_8) and arg_34_1.var_.highlightMatValue1041_1 then
				var_37_8.transform:SetSiblingIndex(1)

				arg_34_1.var_.highlightMatValue1041_1.color.r = 1
				arg_34_1.var_.highlightMatValue1041_1.color.g = 1
				arg_34_1.var_.highlightMatValue1041_1.color.b = 1
				arg_34_1.var_.highlightMatValue1041_1.color = arg_34_1.var_.highlightMatValue1041_1.color
			end

			local var_37_12 = 0
			local var_37_13 = 0.575

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_12 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_14 = arg_34_1:GetWordFromCfg(115291008)
				local var_37_15 = arg_34_1:FormatText(var_37_14.content)

				arg_34_1.text_.text = var_37_15

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_17 = 23 <= 0 and var_37_13 or var_37_13 * (utf8.len(var_37_15) / 23)

				if (23 <= 0 and var_37_13 or var_37_13 * (utf8.len(var_37_15) / 23)) > 0 and var_37_13 < var_37_17 then
					arg_34_1.talkMaxDuration = var_37_17

					if var_37_17 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_17 + var_37_12
					end
				end

				arg_34_1.text_.text = var_37_15
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291008", "story_v_out_115291.awb") ~= 0 then
					local var_37_18 = manager.audio:GetVoiceLength("story_v_out_115291", "115291008", "story_v_out_115291.awb") / 1000

					if var_37_18 + var_37_12 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_18 + var_37_12
					end

					if var_37_14.prefab_name ~= "" and arg_34_1.actors_[var_37_14.prefab_name] ~= nil then
						local var_37_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_14.prefab_name].transform, "story_v_out_115291", "115291008", "story_v_out_115291.awb")

						arg_34_1:RecordAudio("115291008", var_37_19)
						arg_34_1:RecordAudio("115291008", var_37_19)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_115291", "115291008", "story_v_out_115291.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_115291", "115291008", "story_v_out_115291.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_20 = math.max(var_37_13, arg_34_1.talkMaxDuration)

			if var_37_12 <= arg_34_1.time_ and arg_34_1.time_ < var_37_12 + var_37_20 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_12) / var_37_20

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_12 + var_37_20 and arg_34_1.time_ < var_37_12 + var_37_20 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
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
	Play115291009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 115291009
		arg_38_1.duration_ = 10.07

		local var_38_0 = {
			ja = 5.766,
			ko = 6.6,
			zh = 6.733,
			en = 10.066
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
				arg_38_0:Play115291010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			local var_41_0 = 0.85

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_1 = arg_38_1:GetWordFromCfg(115291009)
				local var_41_2 = arg_38_1:FormatText(var_41_1.content)

				arg_38_1.text_.text = var_41_2

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_4 = 34 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 34)

				if (34 <= 0 and var_41_0 or var_41_0 * (utf8.len(var_41_2) / 34)) > 0 and var_41_0 < var_41_4 then
					arg_38_1.talkMaxDuration = var_41_4

					if var_41_4 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_4 + 0
					end
				end

				arg_38_1.text_.text = var_41_2
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291009", "story_v_out_115291.awb") ~= 0 then
					local var_41_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291009", "story_v_out_115291.awb") / 1000

					if var_41_5 + 0 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_5 + 0
					end

					if var_41_1.prefab_name ~= "" and arg_38_1.actors_[var_41_1.prefab_name] ~= nil then
						local var_41_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_1.prefab_name].transform, "story_v_out_115291", "115291009", "story_v_out_115291.awb")

						arg_38_1:RecordAudio("115291009", var_41_6)
						arg_38_1:RecordAudio("115291009", var_41_6)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_115291", "115291009", "story_v_out_115291.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_115291", "115291009", "story_v_out_115291.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_7 = math.max(var_41_0, arg_38_1.talkMaxDuration)

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_7 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - 0) / var_41_7

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= 0 + var_41_7 and arg_38_1.time_ < 0 + var_41_7 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play115291010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 115291010
		arg_42_1.duration_ = 5.23

		local var_42_0 = {
			ja = 5.233,
			ko = 3.2,
			zh = 3.266,
			en = 4.666
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
				arg_42_0:Play115291011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos10030 = arg_42_1.actors_["10030"].transform.localPosition
				arg_42_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_42_1:CheckSpriteTmpPos("10030", 2)

				for iter_45_0 = 0, arg_42_1.actors_["10030"].transform.childCount - 1 do
					local var_45_0 = arg_42_1.actors_["10030"].transform:GetChild(iter_45_0)

					if var_45_0.name == "split_3" or not string.find(var_45_0.name, "split") then
						var_45_0.gameObject:SetActive(true)
					else
						var_45_0.gameObject:SetActive(false)
					end
				end
			end

			local var_45_1 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 then
				arg_42_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_42_1.time_ - 0) / var_45_1)
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 then
				arg_42_1.actors_["10030"].transform.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_45_2 = arg_42_1.actors_["1041_1"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) then
				local var_45_3 = var_45_2:GetComponent("Image")

				if var_45_3 then
					arg_42_1.var_.highlightMatValue1041_1 = var_45_3
				end
			end

			local var_45_4 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_2) then
				if arg_42_1.var_.highlightMatValue1041_1 then
					local var_45_5 = Mathf.Lerp(1, 0.5, (arg_42_1.time_ - 0) / var_45_4)

					arg_42_1.var_.highlightMatValue1041_1.color.r = var_45_5
					arg_42_1.var_.highlightMatValue1041_1.color.g = var_45_5
					arg_42_1.var_.highlightMatValue1041_1.color.b = var_45_5
					arg_42_1.var_.highlightMatValue1041_1.color = arg_42_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.highlightMatValue1041_1 then
				arg_42_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_42_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_42_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_42_1.var_.highlightMatValue1041_1.color = arg_42_1.var_.highlightMatValue1041_1.color
			end

			local var_45_6 = arg_42_1.actors_["10030"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.actorSpriteComps10030 == nil then
				arg_42_1.var_.actorSpriteComps10030 = var_45_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_45_7 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_7 and not isNil(var_45_6) then
				if arg_42_1.var_.actorSpriteComps10030 then
					for iter_45_1, iter_45_2 in pairs(arg_42_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_45_2 then
							if arg_42_1.isInRecall_ then
								iter_45_2.color = Color.New(Mathf.Lerp(iter_45_2.color.r, arg_42_1.hightColor1.r, (arg_42_1.time_ - 0) / var_45_7), Mathf.Lerp(iter_45_2.color.g, arg_42_1.hightColor1.g, (arg_42_1.time_ - 0) / var_45_7), (Mathf.Lerp(iter_45_2.color.b, arg_42_1.hightColor1.b, (arg_42_1.time_ - 0) / var_45_7)))
							else
								local var_45_8 = Mathf.Lerp(iter_45_2.color.r, 1, (arg_42_1.time_ - 0) / var_45_7)

								iter_45_2.color = Color.New(var_45_8, var_45_8, var_45_8)
							end
						end
					end
				end
			end

			if arg_42_1.time_ >= 0 + var_45_7 and arg_42_1.time_ < 0 + var_45_7 + arg_45_0 and not isNil(var_45_6) and arg_42_1.var_.actorSpriteComps10030 then
				for iter_45_3, iter_45_4 in pairs(arg_42_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_45_4 then
						iter_45_4.color = arg_42_1.isInRecall_ and (arg_42_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_42_1.var_.actorSpriteComps10030 = nil
			end

			local var_45_9 = 0
			local var_45_10 = 0.25

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_9 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_11 = arg_42_1:GetWordFromCfg(115291010)
				local var_45_12 = arg_42_1:FormatText(var_45_11.content)

				arg_42_1.text_.text = var_45_12

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_14 = 10 <= 0 and var_45_10 or var_45_10 * (utf8.len(var_45_12) / 10)

				if (10 <= 0 and var_45_10 or var_45_10 * (utf8.len(var_45_12) / 10)) > 0 and var_45_10 < var_45_14 then
					arg_42_1.talkMaxDuration = var_45_14

					if var_45_14 + var_45_9 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_14 + var_45_9
					end
				end

				arg_42_1.text_.text = var_45_12
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291010", "story_v_out_115291.awb") ~= 0 then
					local var_45_15 = manager.audio:GetVoiceLength("story_v_out_115291", "115291010", "story_v_out_115291.awb") / 1000

					if var_45_15 + var_45_9 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_15 + var_45_9
					end

					if var_45_11.prefab_name ~= "" and arg_42_1.actors_[var_45_11.prefab_name] ~= nil then
						local var_45_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_11.prefab_name].transform, "story_v_out_115291", "115291010", "story_v_out_115291.awb")

						arg_42_1:RecordAudio("115291010", var_45_16)
						arg_42_1:RecordAudio("115291010", var_45_16)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_115291", "115291010", "story_v_out_115291.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_115291", "115291010", "story_v_out_115291.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_17 = math.max(var_45_10, arg_42_1.talkMaxDuration)

			if var_45_9 <= arg_42_1.time_ and arg_42_1.time_ < var_45_9 + var_45_17 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_9) / var_45_17

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_9 + var_45_17 and arg_42_1.time_ < var_45_9 + var_45_17 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
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
	Play115291011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 115291011
		arg_46_1.duration_ = 5

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play115291012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["10030"]) and arg_46_1.var_.actorSpriteComps10030 == nil then
				arg_46_1.var_.actorSpriteComps10030 = arg_46_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_49_0 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["10030"]) then
				if arg_46_1.var_.actorSpriteComps10030 then
					for iter_49_0, iter_49_1 in pairs(arg_46_1.var_.actorSpriteComps10030:ToTable()) do
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

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["10030"]) and arg_46_1.var_.actorSpriteComps10030 then
				for iter_49_2, iter_49_3 in pairs(arg_46_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_49_3 then
						iter_49_3.color = arg_46_1.isInRecall_ and (arg_46_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_46_1.var_.actorSpriteComps10030 = nil
			end

			local var_49_2 = 0
			local var_49_3 = 1.25

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_2 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, false)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_4 = arg_46_1:FormatText(arg_46_1:GetWordFromCfg(115291011).content)

				arg_46_1.text_.text = var_49_4

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_6 = 50 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 50)

				if (50 <= 0 and var_49_3 or var_49_3 * (utf8.len(var_49_4) / 50)) > 0 and var_49_3 < var_49_6 then
					arg_46_1.talkMaxDuration = var_49_6

					if var_49_6 + var_49_2 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_2
					end
				end

				arg_46_1.text_.text = var_49_4
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)
				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_7 = math.max(var_49_3, arg_46_1.talkMaxDuration)

			if var_49_2 <= arg_46_1.time_ and arg_46_1.time_ < var_49_2 + var_49_7 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_2) / var_49_7

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_2 + var_49_7 and arg_46_1.time_ < var_49_2 + var_49_7 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play115291012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 115291012
		arg_50_1.duration_ = 14.5

		local var_50_0 = {
			ja = 14.5,
			ko = 13.366,
			zh = 10.166,
			en = 11.1
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
				arg_50_0:Play115291013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1041_1 = arg_50_1.actors_["1041_1"].transform.localPosition
				arg_50_1.actors_["1041_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_50_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_53_0 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 then
				arg_50_1.actors_["1041_1"].transform.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1041_1, Vector3.New(440, -310, -370), (arg_50_1.time_ - 0) / var_53_0)
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 then
				arg_50_1.actors_["1041_1"].transform.localPosition = Vector3.New(440, -310, -370)
			end

			local var_53_1 = arg_50_1.actors_["1041_1"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_1) then
				local var_53_2 = var_53_1:GetComponent("Image")

				if var_53_2 then
					arg_50_1.var_.highlightMatValue1041_1 = var_53_2
				end
			end

			local var_53_3 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_1) then
				if arg_50_1.var_.highlightMatValue1041_1 then
					local var_53_4 = Mathf.Lerp(0.5, 1, (arg_50_1.time_ - 0) / var_53_3)

					arg_50_1.var_.highlightMatValue1041_1.color.r = var_53_4
					arg_50_1.var_.highlightMatValue1041_1.color.g = var_53_4
					arg_50_1.var_.highlightMatValue1041_1.color.b = var_53_4
					arg_50_1.var_.highlightMatValue1041_1.color = arg_50_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_1) and arg_50_1.var_.highlightMatValue1041_1 then
				var_53_1.transform:SetSiblingIndex(1)

				arg_50_1.var_.highlightMatValue1041_1.color.r = 1
				arg_50_1.var_.highlightMatValue1041_1.color.g = 1
				arg_50_1.var_.highlightMatValue1041_1.color.b = 1
				arg_50_1.var_.highlightMatValue1041_1.color = arg_50_1.var_.highlightMatValue1041_1.color
			end

			local var_53_5 = 0
			local var_53_6 = 1.2

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_5 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_7 = arg_50_1:GetWordFromCfg(115291012)
				local var_53_8 = arg_50_1:FormatText(var_53_7.content)

				arg_50_1.text_.text = var_53_8

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_10 = 48 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 48)

				if (48 <= 0 and var_53_6 or var_53_6 * (utf8.len(var_53_8) / 48)) > 0 and var_53_6 < var_53_10 then
					arg_50_1.talkMaxDuration = var_53_10

					if var_53_10 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_5
					end
				end

				arg_50_1.text_.text = var_53_8
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291012", "story_v_out_115291.awb") ~= 0 then
					local var_53_11 = manager.audio:GetVoiceLength("story_v_out_115291", "115291012", "story_v_out_115291.awb") / 1000

					if var_53_11 + var_53_5 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_5
					end

					if var_53_7.prefab_name ~= "" and arg_50_1.actors_[var_53_7.prefab_name] ~= nil then
						local var_53_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_7.prefab_name].transform, "story_v_out_115291", "115291012", "story_v_out_115291.awb")

						arg_50_1:RecordAudio("115291012", var_53_12)
						arg_50_1:RecordAudio("115291012", var_53_12)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_115291", "115291012", "story_v_out_115291.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_115291", "115291012", "story_v_out_115291.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_13 = math.max(var_53_6, arg_50_1.talkMaxDuration)

			if var_53_5 <= arg_50_1.time_ and arg_50_1.time_ < var_53_5 + var_53_13 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_5) / var_53_13

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_5 + var_53_13 and arg_50_1.time_ < var_53_5 + var_53_13 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_50_1:InitPlayNodeList()
	end,
	Play115291013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 115291013
		arg_54_1.duration_ = 9.63

		local var_54_0 = {
			ja = 8.5,
			ko = 6.7,
			zh = 7.033,
			en = 9.633
		}
		local var_54_1 = manager.audio:GetLocalizationFlag()

		if var_54_0[var_54_1] ~= nil then
			arg_54_1.duration_ = var_54_0[var_54_1]
		end

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play115291014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.85

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:GetWordFromCfg(115291013)
				local var_57_2 = arg_54_1:FormatText(var_57_1.content)

				arg_54_1.text_.text = var_57_2

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_4 = 34 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 34)

				if (34 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_2) / 34)) > 0 and var_57_0 < var_57_4 then
					arg_54_1.talkMaxDuration = var_57_4

					if var_57_4 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_4 + 0
					end
				end

				arg_54_1.text_.text = var_57_2
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291013", "story_v_out_115291.awb") ~= 0 then
					local var_57_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291013", "story_v_out_115291.awb") / 1000

					if var_57_5 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_5 + 0
					end

					if var_57_1.prefab_name ~= "" and arg_54_1.actors_[var_57_1.prefab_name] ~= nil then
						local var_57_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_1.prefab_name].transform, "story_v_out_115291", "115291013", "story_v_out_115291.awb")

						arg_54_1:RecordAudio("115291013", var_57_6)
						arg_54_1:RecordAudio("115291013", var_57_6)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_115291", "115291013", "story_v_out_115291.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_115291", "115291013", "story_v_out_115291.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_7 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_7 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_7

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_7 and arg_54_1.time_ < 0 + var_57_7 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play115291014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 115291014
		arg_58_1.duration_ = 5.43

		local var_58_0 = {
			ja = 5.433,
			ko = 4.666,
			zh = 3.9,
			en = 4.6
		}
		local var_58_1 = manager.audio:GetLocalizationFlag()

		if var_58_0[var_58_1] ~= nil then
			arg_58_1.duration_ = var_58_0[var_58_1]
		end

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play115291015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos10030 = arg_58_1.actors_["10030"].transform.localPosition
				arg_58_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_58_1:CheckSpriteTmpPos("10030", 2)

				for iter_61_0 = 0, arg_58_1.actors_["10030"].transform.childCount - 1 do
					local var_61_0 = arg_58_1.actors_["10030"].transform:GetChild(iter_61_0)

					if var_61_0.name == "split_3" or not string.find(var_61_0.name, "split") then
						var_61_0.gameObject:SetActive(true)
					else
						var_61_0.gameObject:SetActive(false)
					end
				end
			end

			local var_61_1 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_1 then
				arg_58_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_58_1.time_ - 0) / var_61_1)
			end

			if arg_58_1.time_ >= 0 + var_61_1 and arg_58_1.time_ < 0 + var_61_1 + arg_61_0 then
				arg_58_1.actors_["10030"].transform.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_61_2 = arg_58_1.actors_["1041_1"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) then
				local var_61_3 = var_61_2:GetComponent("Image")

				if var_61_3 then
					arg_58_1.var_.highlightMatValue1041_1 = var_61_3
				end
			end

			local var_61_4 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 and not isNil(var_61_2) then
				if arg_58_1.var_.highlightMatValue1041_1 then
					local var_61_5 = Mathf.Lerp(1, 0.5, (arg_58_1.time_ - 0) / var_61_4)

					arg_58_1.var_.highlightMatValue1041_1.color.r = var_61_5
					arg_58_1.var_.highlightMatValue1041_1.color.g = var_61_5
					arg_58_1.var_.highlightMatValue1041_1.color.b = var_61_5
					arg_58_1.var_.highlightMatValue1041_1.color = arg_58_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.highlightMatValue1041_1 then
				arg_58_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_58_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_58_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_58_1.var_.highlightMatValue1041_1.color = arg_58_1.var_.highlightMatValue1041_1.color
			end

			local var_61_6 = arg_58_1.actors_["10030"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_6) and arg_58_1.var_.actorSpriteComps10030 == nil then
				arg_58_1.var_.actorSpriteComps10030 = var_61_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_61_7 = 0.2

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_7 and not isNil(var_61_6) then
				if arg_58_1.var_.actorSpriteComps10030 then
					for iter_61_1, iter_61_2 in pairs(arg_58_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_61_2 then
							if arg_58_1.isInRecall_ then
								iter_61_2.color = Color.New(Mathf.Lerp(iter_61_2.color.r, arg_58_1.hightColor1.r, (arg_58_1.time_ - 0) / var_61_7), Mathf.Lerp(iter_61_2.color.g, arg_58_1.hightColor1.g, (arg_58_1.time_ - 0) / var_61_7), (Mathf.Lerp(iter_61_2.color.b, arg_58_1.hightColor1.b, (arg_58_1.time_ - 0) / var_61_7)))
							else
								local var_61_8 = Mathf.Lerp(iter_61_2.color.r, 1, (arg_58_1.time_ - 0) / var_61_7)

								iter_61_2.color = Color.New(var_61_8, var_61_8, var_61_8)
							end
						end
					end
				end
			end

			if arg_58_1.time_ >= 0 + var_61_7 and arg_58_1.time_ < 0 + var_61_7 + arg_61_0 and not isNil(var_61_6) and arg_58_1.var_.actorSpriteComps10030 then
				for iter_61_3, iter_61_4 in pairs(arg_58_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_61_4 then
						iter_61_4.color = arg_58_1.isInRecall_ and (arg_58_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_58_1.var_.actorSpriteComps10030 = nil
			end

			local var_61_9 = 0
			local var_61_10 = 0.35

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_9 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_11 = arg_58_1:GetWordFromCfg(115291014)
				local var_61_12 = arg_58_1:FormatText(var_61_11.content)

				arg_58_1.text_.text = var_61_12

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_14 = 14 <= 0 and var_61_10 or var_61_10 * (utf8.len(var_61_12) / 14)

				if (14 <= 0 and var_61_10 or var_61_10 * (utf8.len(var_61_12) / 14)) > 0 and var_61_10 < var_61_14 then
					arg_58_1.talkMaxDuration = var_61_14

					if var_61_14 + var_61_9 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_14 + var_61_9
					end
				end

				arg_58_1.text_.text = var_61_12
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291014", "story_v_out_115291.awb") ~= 0 then
					local var_61_15 = manager.audio:GetVoiceLength("story_v_out_115291", "115291014", "story_v_out_115291.awb") / 1000

					if var_61_15 + var_61_9 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_15 + var_61_9
					end

					if var_61_11.prefab_name ~= "" and arg_58_1.actors_[var_61_11.prefab_name] ~= nil then
						local var_61_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_11.prefab_name].transform, "story_v_out_115291", "115291014", "story_v_out_115291.awb")

						arg_58_1:RecordAudio("115291014", var_61_16)
						arg_58_1:RecordAudio("115291014", var_61_16)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_115291", "115291014", "story_v_out_115291.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_115291", "115291014", "story_v_out_115291.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_17 = math.max(var_61_10, arg_58_1.talkMaxDuration)

			if var_61_9 <= arg_58_1.time_ and arg_58_1.time_ < var_61_9 + var_61_17 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_9) / var_61_17

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_9 + var_61_17 and arg_58_1.time_ < var_61_9 + var_61_17 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_58_1:InitPlayNodeList()
	end,
	Play115291015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 115291015
		arg_62_1.duration_ = 4.5

		local var_62_0 = {
			ja = 4.333,
			ko = 4.466,
			zh = 4.3,
			en = 4.5
		}
		local var_62_1 = manager.audio:GetLocalizationFlag()

		if var_62_0[var_62_1] ~= nil then
			arg_62_1.duration_ = var_62_0[var_62_1]
		end

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play115291016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.4

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(115291015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 16 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 16)

				if (16 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 16)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291015", "story_v_out_115291.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291015", "story_v_out_115291.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_115291", "115291015", "story_v_out_115291.awb")

						arg_62_1:RecordAudio("115291015", var_65_6)
						arg_62_1:RecordAudio("115291015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_115291", "115291015", "story_v_out_115291.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_115291", "115291015", "story_v_out_115291.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_7 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_7 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_7

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_7 and arg_62_1.time_ < 0 + var_65_7 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play115291016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 115291016
		arg_66_1.duration_ = 12.47

		local var_66_0 = {
			ja = 12.2,
			ko = 10.766,
			zh = 10.1,
			en = 12.466
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play115291017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1041_1"]) then
				local var_69_0 = arg_66_1.actors_["1041_1"]:GetComponent("Image")

				if var_69_0 then
					arg_66_1.var_.highlightMatValue1041_1 = var_69_0
				end
			end

			local var_69_1 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_1 and not isNil(arg_66_1.actors_["1041_1"]) then
				if arg_66_1.var_.highlightMatValue1041_1 then
					local var_69_2 = Mathf.Lerp(0.5, 1, (arg_66_1.time_ - 0) / var_69_1)

					arg_66_1.var_.highlightMatValue1041_1.color.r = var_69_2
					arg_66_1.var_.highlightMatValue1041_1.color.g = var_69_2
					arg_66_1.var_.highlightMatValue1041_1.color.b = var_69_2
					arg_66_1.var_.highlightMatValue1041_1.color = arg_66_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_66_1.time_ >= 0 + var_69_1 and arg_66_1.time_ < 0 + var_69_1 + arg_69_0 and not isNil(arg_66_1.actors_["1041_1"]) and arg_66_1.var_.highlightMatValue1041_1 then
				arg_66_1.actors_["1041_1"].transform:SetSiblingIndex(1)

				arg_66_1.var_.highlightMatValue1041_1.color.r = 1
				arg_66_1.var_.highlightMatValue1041_1.color.g = 1
				arg_66_1.var_.highlightMatValue1041_1.color.b = 1
				arg_66_1.var_.highlightMatValue1041_1.color = arg_66_1.var_.highlightMatValue1041_1.color
			end

			local var_69_3 = arg_66_1.actors_["10030"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.actorSpriteComps10030 == nil then
				arg_66_1.var_.actorSpriteComps10030 = var_69_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_69_4 = 0.2

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 and not isNil(var_69_3) then
				if arg_66_1.var_.actorSpriteComps10030 then
					for iter_69_0, iter_69_1 in pairs(arg_66_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_69_1 then
							if arg_66_1.isInRecall_ then
								iter_69_1.color = Color.New(Mathf.Lerp(iter_69_1.color.r, arg_66_1.hightColor2.r, (arg_66_1.time_ - 0) / var_69_4), Mathf.Lerp(iter_69_1.color.g, arg_66_1.hightColor2.g, (arg_66_1.time_ - 0) / var_69_4), (Mathf.Lerp(iter_69_1.color.b, arg_66_1.hightColor2.b, (arg_66_1.time_ - 0) / var_69_4)))
							else
								local var_69_5 = Mathf.Lerp(iter_69_1.color.r, 0.5, (arg_66_1.time_ - 0) / var_69_4)

								iter_69_1.color = Color.New(var_69_5, var_69_5, var_69_5)
							end
						end
					end
				end
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 and not isNil(var_69_3) and arg_66_1.var_.actorSpriteComps10030 then
				for iter_69_2, iter_69_3 in pairs(arg_66_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_69_3 then
						iter_69_3.color = arg_66_1.isInRecall_ and (arg_66_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_66_1.var_.actorSpriteComps10030 = nil
			end

			local var_69_6 = 0
			local var_69_7 = 1.15

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_6 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_8 = arg_66_1:GetWordFromCfg(115291016)
				local var_69_9 = arg_66_1:FormatText(var_69_8.content)

				arg_66_1.text_.text = var_69_9

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_11 = 46 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 46)

				if (46 <= 0 and var_69_7 or var_69_7 * (utf8.len(var_69_9) / 46)) > 0 and var_69_7 < var_69_11 then
					arg_66_1.talkMaxDuration = var_69_11

					if var_69_11 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_11 + var_69_6
					end
				end

				arg_66_1.text_.text = var_69_9
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291016", "story_v_out_115291.awb") ~= 0 then
					local var_69_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291016", "story_v_out_115291.awb") / 1000

					if var_69_12 + var_69_6 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_12 + var_69_6
					end

					if var_69_8.prefab_name ~= "" and arg_66_1.actors_[var_69_8.prefab_name] ~= nil then
						local var_69_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_8.prefab_name].transform, "story_v_out_115291", "115291016", "story_v_out_115291.awb")

						arg_66_1:RecordAudio("115291016", var_69_13)
						arg_66_1:RecordAudio("115291016", var_69_13)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_115291", "115291016", "story_v_out_115291.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_115291", "115291016", "story_v_out_115291.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_14 = math.max(var_69_7, arg_66_1.talkMaxDuration)

			if var_69_6 <= arg_66_1.time_ and arg_66_1.time_ < var_69_6 + var_69_14 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_6) / var_69_14

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_6 + var_69_14 and arg_66_1.time_ < var_69_6 + var_69_14 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play115291017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 115291017
		arg_70_1.duration_ = 10.73

		local var_70_0 = {
			ja = 10.733,
			ko = 9.9,
			zh = 6.433,
			en = 8.966
		}
		local var_70_1 = manager.audio:GetLocalizationFlag()

		if var_70_0[var_70_1] ~= nil then
			arg_70_1.duration_ = var_70_0[var_70_1]
		end

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play115291018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 0.775

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:GetWordFromCfg(115291017)
				local var_73_2 = arg_70_1:FormatText(var_73_1.content)

				arg_70_1.text_.text = var_73_2

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_4 = 31 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 31)

				if (31 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_2) / 31)) > 0 and var_73_0 < var_73_4 then
					arg_70_1.talkMaxDuration = var_73_4

					if var_73_4 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_4 + 0
					end
				end

				arg_70_1.text_.text = var_73_2
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291017", "story_v_out_115291.awb") ~= 0 then
					local var_73_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291017", "story_v_out_115291.awb") / 1000

					if var_73_5 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_5 + 0
					end

					if var_73_1.prefab_name ~= "" and arg_70_1.actors_[var_73_1.prefab_name] ~= nil then
						local var_73_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_1.prefab_name].transform, "story_v_out_115291", "115291017", "story_v_out_115291.awb")

						arg_70_1:RecordAudio("115291017", var_73_6)
						arg_70_1:RecordAudio("115291017", var_73_6)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_115291", "115291017", "story_v_out_115291.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_115291", "115291017", "story_v_out_115291.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_7 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_7 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_7

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_7 and arg_70_1.time_ < 0 + var_73_7 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play115291018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 115291018
		arg_74_1.duration_ = 11.73

		local var_74_0 = {
			ja = 11.266,
			ko = 9.666,
			zh = 10.166,
			en = 11.733
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play115291019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 1.2

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_1 = arg_74_1:GetWordFromCfg(115291018)
				local var_77_2 = arg_74_1:FormatText(var_77_1.content)

				arg_74_1.text_.text = var_77_2

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_4 = 48 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 48)

				if (48 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_2) / 48)) > 0 and var_77_0 < var_77_4 then
					arg_74_1.talkMaxDuration = var_77_4

					if var_77_4 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_4 + 0
					end
				end

				arg_74_1.text_.text = var_77_2
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291018", "story_v_out_115291.awb") ~= 0 then
					local var_77_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291018", "story_v_out_115291.awb") / 1000

					if var_77_5 + 0 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + 0
					end

					if var_77_1.prefab_name ~= "" and arg_74_1.actors_[var_77_1.prefab_name] ~= nil then
						local var_77_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_1.prefab_name].transform, "story_v_out_115291", "115291018", "story_v_out_115291.awb")

						arg_74_1:RecordAudio("115291018", var_77_6)
						arg_74_1:RecordAudio("115291018", var_77_6)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_115291", "115291018", "story_v_out_115291.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_115291", "115291018", "story_v_out_115291.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_7 = math.max(var_77_0, arg_74_1.talkMaxDuration)

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_7 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - 0) / var_77_7

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= 0 + var_77_7 and arg_74_1.time_ < 0 + var_77_7 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play115291019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 115291019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play115291020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_0 = arg_78_1.actors_["1041_1"]:GetComponent("Image")

				if var_81_0 then
					arg_78_1.var_.alphaMatValue1041_1 = var_81_0
					arg_78_1.var_.alphaOldValue1041_1 = var_81_0.color.a
				end

				arg_78_1.var_.alphaOldValue1041_1 = 1
			end

			local var_81_1 = 0.333333333333333

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_1 then
				if arg_78_1.var_.alphaMatValue1041_1 then
					arg_78_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_78_1.var_.alphaOldValue1041_1, 0, (arg_78_1.time_ - 0) / var_81_1)
					arg_78_1.var_.alphaMatValue1041_1.color = arg_78_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_78_1.time_ >= 0 + var_81_1 and arg_78_1.time_ < 0 + var_81_1 + arg_81_0 and arg_78_1.var_.alphaMatValue1041_1 then
				arg_78_1.var_.alphaMatValue1041_1.color.a = 0
				arg_78_1.var_.alphaMatValue1041_1.color = arg_78_1.var_.alphaMatValue1041_1.color
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				local var_81_2 = arg_78_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_81_2 then
					arg_78_1.var_.alphaOldValue10030 = var_81_2.alpha
					arg_78_1.var_.characterEffect10030 = var_81_2
				end

				arg_78_1.var_.alphaOldValue10030 = 1
			end

			local var_81_3 = 0.333333333333333

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_3 then
				if arg_78_1.var_.characterEffect10030 then
					arg_78_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_78_1.var_.alphaOldValue10030, 0, (arg_78_1.time_ - 0) / var_81_3)
				end
			end

			if arg_78_1.time_ >= 0 + var_81_3 and arg_78_1.time_ < 0 + var_81_3 + arg_81_0 and arg_78_1.var_.characterEffect10030 then
				arg_78_1.var_.characterEffect10030.alpha = 0
			end

			local var_81_4 = 0
			local var_81_5 = 1

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_4 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_6 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(115291019).content)

				arg_78_1.text_.text = var_81_6

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_8 = 40 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_6) / 40)

				if (40 <= 0 and var_81_5 or var_81_5 * (utf8.len(var_81_6) / 40)) > 0 and var_81_5 < var_81_8 then
					arg_78_1.talkMaxDuration = var_81_8

					if var_81_8 + var_81_4 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_4
					end
				end

				arg_78_1.text_.text = var_81_6
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_9 = math.max(var_81_5, arg_78_1.talkMaxDuration)

			if var_81_4 <= arg_78_1.time_ and arg_78_1.time_ < var_81_4 + var_81_9 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_4) / var_81_9

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_4 + var_81_9 and arg_78_1.time_ < var_81_4 + var_81_9 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play115291020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 115291020
		arg_82_1.duration_ = 7.1

		local var_82_0 = {
			ja = 7.1,
			ko = 4.366,
			zh = 4.1,
			en = 4
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
				arg_82_0:Play115291021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos10030 = arg_82_1.actors_["10030"].transform.localPosition
				arg_82_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_82_1:CheckSpriteTmpPos("10030", 2)

				for iter_85_0 = 0, arg_82_1.actors_["10030"].transform.childCount - 1 do
					local var_85_0 = arg_82_1.actors_["10030"].transform:GetChild(iter_85_0)

					if var_85_0.name == "split_3" or not string.find(var_85_0.name, "split") then
						var_85_0.gameObject:SetActive(true)
					else
						var_85_0.gameObject:SetActive(false)
					end
				end
			end

			local var_85_1 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_1 then
				arg_82_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos10030, Vector3.New(-390, -390, 150), (arg_82_1.time_ - 0) / var_85_1)
			end

			if arg_82_1.time_ >= 0 + var_85_1 and arg_82_1.time_ < 0 + var_85_1 + arg_85_0 then
				arg_82_1.actors_["10030"].transform.localPosition = Vector3.New(-390, -390, 150)
			end

			local var_85_2 = arg_82_1.actors_["10030"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10030 == nil then
				arg_82_1.var_.actorSpriteComps10030 = var_85_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_85_3 = 0.2

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_3 and not isNil(var_85_2) then
				if arg_82_1.var_.actorSpriteComps10030 then
					for iter_85_1, iter_85_2 in pairs(arg_82_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_85_2 then
							if arg_82_1.isInRecall_ then
								iter_85_2.color = Color.New(Mathf.Lerp(iter_85_2.color.r, arg_82_1.hightColor1.r, (arg_82_1.time_ - 0) / var_85_3), Mathf.Lerp(iter_85_2.color.g, arg_82_1.hightColor1.g, (arg_82_1.time_ - 0) / var_85_3), (Mathf.Lerp(iter_85_2.color.b, arg_82_1.hightColor1.b, (arg_82_1.time_ - 0) / var_85_3)))
							else
								local var_85_4 = Mathf.Lerp(iter_85_2.color.r, 1, (arg_82_1.time_ - 0) / var_85_3)

								iter_85_2.color = Color.New(var_85_4, var_85_4, var_85_4)
							end
						end
					end
				end
			end

			if arg_82_1.time_ >= 0 + var_85_3 and arg_82_1.time_ < 0 + var_85_3 + arg_85_0 and not isNil(var_85_2) and arg_82_1.var_.actorSpriteComps10030 then
				for iter_85_3, iter_85_4 in pairs(arg_82_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_85_4 then
						iter_85_4.color = arg_82_1.isInRecall_ and (arg_82_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_82_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				local var_85_5 = arg_82_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_85_5 then
					arg_82_1.var_.alphaOldValue10030 = var_85_5.alpha
					arg_82_1.var_.characterEffect10030 = var_85_5
				end

				arg_82_1.var_.alphaOldValue10030 = 0
			end

			local var_85_6 = 0.333333333333333

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_6 then
				if arg_82_1.var_.characterEffect10030 then
					arg_82_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_82_1.var_.alphaOldValue10030, 1, (arg_82_1.time_ - 0) / var_85_6)
				end
			end

			if arg_82_1.time_ >= 0 + var_85_6 and arg_82_1.time_ < 0 + var_85_6 + arg_85_0 and arg_82_1.var_.characterEffect10030 then
				arg_82_1.var_.characterEffect10030.alpha = 1
			end

			local var_85_7 = 0
			local var_85_8 = 0.425

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_7 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_9 = arg_82_1:GetWordFromCfg(115291020)
				local var_85_10 = arg_82_1:FormatText(var_85_9.content)

				arg_82_1.text_.text = var_85_10

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_12 = 17 <= 0 and var_85_8 or var_85_8 * (utf8.len(var_85_10) / 17)

				if (17 <= 0 and var_85_8 or var_85_8 * (utf8.len(var_85_10) / 17)) > 0 and var_85_8 < var_85_12 then
					arg_82_1.talkMaxDuration = var_85_12

					if var_85_12 + var_85_7 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_12 + var_85_7
					end
				end

				arg_82_1.text_.text = var_85_10
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291020", "story_v_out_115291.awb") ~= 0 then
					local var_85_13 = manager.audio:GetVoiceLength("story_v_out_115291", "115291020", "story_v_out_115291.awb") / 1000

					if var_85_13 + var_85_7 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_7
					end

					if var_85_9.prefab_name ~= "" and arg_82_1.actors_[var_85_9.prefab_name] ~= nil then
						local var_85_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_9.prefab_name].transform, "story_v_out_115291", "115291020", "story_v_out_115291.awb")

						arg_82_1:RecordAudio("115291020", var_85_14)
						arg_82_1:RecordAudio("115291020", var_85_14)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_115291", "115291020", "story_v_out_115291.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_115291", "115291020", "story_v_out_115291.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_15 = math.max(var_85_8, arg_82_1.talkMaxDuration)

			if var_85_7 <= arg_82_1.time_ and arg_82_1.time_ < var_85_7 + var_85_15 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_7) / var_85_15

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_7 + var_85_15 and arg_82_1.time_ < var_85_7 + var_85_15 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play115291021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 115291021
		arg_86_1.duration_ = 10.3

		local var_86_0 = {
			ja = 5.766,
			ko = 7.866,
			zh = 9.433,
			en = 10.3
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play115291022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1041_1 = arg_86_1.actors_["1041_1"].transform.localPosition
				arg_86_1.actors_["1041_1"].transform.localScale = Vector3.New(1, 1, 1)

				arg_86_1:CheckSpriteTmpPos("1041_1", 4)
			end

			local var_89_0 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 then
				arg_86_1.actors_["1041_1"].transform.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1041_1, Vector3.New(440, -310, -370), (arg_86_1.time_ - 0) / var_89_0)
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 then
				arg_86_1.actors_["1041_1"].transform.localPosition = Vector3.New(440, -310, -370)
			end

			local var_89_1 = arg_86_1.actors_["10030"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.actorSpriteComps10030 == nil then
				arg_86_1.var_.actorSpriteComps10030 = var_89_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_89_2 = 0.2

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_2 and not isNil(var_89_1) then
				if arg_86_1.var_.actorSpriteComps10030 then
					for iter_89_0, iter_89_1 in pairs(arg_86_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_89_1 then
							if arg_86_1.isInRecall_ then
								iter_89_1.color = Color.New(Mathf.Lerp(iter_89_1.color.r, arg_86_1.hightColor2.r, (arg_86_1.time_ - 0) / var_89_2), Mathf.Lerp(iter_89_1.color.g, arg_86_1.hightColor2.g, (arg_86_1.time_ - 0) / var_89_2), (Mathf.Lerp(iter_89_1.color.b, arg_86_1.hightColor2.b, (arg_86_1.time_ - 0) / var_89_2)))
							else
								local var_89_3 = Mathf.Lerp(iter_89_1.color.r, 0.5, (arg_86_1.time_ - 0) / var_89_2)

								iter_89_1.color = Color.New(var_89_3, var_89_3, var_89_3)
							end
						end
					end
				end
			end

			if arg_86_1.time_ >= 0 + var_89_2 and arg_86_1.time_ < 0 + var_89_2 + arg_89_0 and not isNil(var_89_1) and arg_86_1.var_.actorSpriteComps10030 then
				for iter_89_2, iter_89_3 in pairs(arg_86_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_89_3 then
						iter_89_3.color = arg_86_1.isInRecall_ and (arg_86_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_86_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				local var_89_4 = arg_86_1.actors_["1041_1"]:GetComponent("Image")

				if var_89_4 then
					arg_86_1.var_.alphaMatValue1041_1 = var_89_4
					arg_86_1.var_.alphaOldValue1041_1 = var_89_4.color.a
				end

				arg_86_1.var_.alphaOldValue1041_1 = 0
			end

			local var_89_5 = 0.333333333333333

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_5 then
				if arg_86_1.var_.alphaMatValue1041_1 then
					arg_86_1.var_.alphaMatValue1041_1.color.a = Mathf.Lerp(arg_86_1.var_.alphaOldValue1041_1, 1, (arg_86_1.time_ - 0) / var_89_5)
					arg_86_1.var_.alphaMatValue1041_1.color = arg_86_1.var_.alphaMatValue1041_1.color
				end
			end

			if arg_86_1.time_ >= 0 + var_89_5 and arg_86_1.time_ < 0 + var_89_5 + arg_89_0 and arg_86_1.var_.alphaMatValue1041_1 then
				arg_86_1.var_.alphaMatValue1041_1.color.a = 1
				arg_86_1.var_.alphaMatValue1041_1.color = arg_86_1.var_.alphaMatValue1041_1.color
			end

			local var_89_6 = 0
			local var_89_7 = 1

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_6 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_8 = arg_86_1:GetWordFromCfg(115291021)
				local var_89_9 = arg_86_1:FormatText(var_89_8.content)

				arg_86_1.text_.text = var_89_9

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_11 = 40 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 40)

				if (40 <= 0 and var_89_7 or var_89_7 * (utf8.len(var_89_9) / 40)) > 0 and var_89_7 < var_89_11 then
					arg_86_1.talkMaxDuration = var_89_11

					if var_89_11 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_11 + var_89_6
					end
				end

				arg_86_1.text_.text = var_89_9
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291021", "story_v_out_115291.awb") ~= 0 then
					local var_89_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291021", "story_v_out_115291.awb") / 1000

					if var_89_12 + var_89_6 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_12 + var_89_6
					end

					if var_89_8.prefab_name ~= "" and arg_86_1.actors_[var_89_8.prefab_name] ~= nil then
						local var_89_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_8.prefab_name].transform, "story_v_out_115291", "115291021", "story_v_out_115291.awb")

						arg_86_1:RecordAudio("115291021", var_89_13)
						arg_86_1:RecordAudio("115291021", var_89_13)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_115291", "115291021", "story_v_out_115291.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_115291", "115291021", "story_v_out_115291.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_14 = math.max(var_89_7, arg_86_1.talkMaxDuration)

			if var_89_6 <= arg_86_1.time_ and arg_86_1.time_ < var_89_6 + var_89_14 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_6) / var_89_14

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_6 + var_89_14 and arg_86_1.time_ < var_89_6 + var_89_14 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play115291022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 115291022
		arg_90_1.duration_ = 6.13

		local var_90_0 = {
			ja = 5.833,
			ko = 5.2,
			zh = 6.133,
			en = 6.1
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play115291023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["1041_1"]) then
				local var_93_0 = arg_90_1.actors_["1041_1"]:GetComponent("Image")

				if var_93_0 then
					arg_90_1.var_.highlightMatValue1041_1 = var_93_0
				end
			end

			local var_93_1 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 and not isNil(arg_90_1.actors_["1041_1"]) then
				if arg_90_1.var_.highlightMatValue1041_1 then
					local var_93_2 = Mathf.Lerp(1, 0.5, (arg_90_1.time_ - 0) / var_93_1)

					arg_90_1.var_.highlightMatValue1041_1.color.r = var_93_2
					arg_90_1.var_.highlightMatValue1041_1.color.g = var_93_2
					arg_90_1.var_.highlightMatValue1041_1.color.b = var_93_2
					arg_90_1.var_.highlightMatValue1041_1.color = arg_90_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 and not isNil(arg_90_1.actors_["1041_1"]) and arg_90_1.var_.highlightMatValue1041_1 then
				arg_90_1.var_.highlightMatValue1041_1.color.r = 0.5
				arg_90_1.var_.highlightMatValue1041_1.color.g = 0.5
				arg_90_1.var_.highlightMatValue1041_1.color.b = 0.5
				arg_90_1.var_.highlightMatValue1041_1.color = arg_90_1.var_.highlightMatValue1041_1.color
			end

			local var_93_3 = arg_90_1.actors_["10030"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.actorSpriteComps10030 == nil then
				arg_90_1.var_.actorSpriteComps10030 = var_93_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_93_4 = 0.2

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 and not isNil(var_93_3) then
				if arg_90_1.var_.actorSpriteComps10030 then
					for iter_93_0, iter_93_1 in pairs(arg_90_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_93_1 then
							if arg_90_1.isInRecall_ then
								iter_93_1.color = Color.New(Mathf.Lerp(iter_93_1.color.r, arg_90_1.hightColor1.r, (arg_90_1.time_ - 0) / var_93_4), Mathf.Lerp(iter_93_1.color.g, arg_90_1.hightColor1.g, (arg_90_1.time_ - 0) / var_93_4), (Mathf.Lerp(iter_93_1.color.b, arg_90_1.hightColor1.b, (arg_90_1.time_ - 0) / var_93_4)))
							else
								local var_93_5 = Mathf.Lerp(iter_93_1.color.r, 1, (arg_90_1.time_ - 0) / var_93_4)

								iter_93_1.color = Color.New(var_93_5, var_93_5, var_93_5)
							end
						end
					end
				end
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.actorSpriteComps10030 then
				for iter_93_2, iter_93_3 in pairs(arg_90_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_93_3 then
						iter_93_3.color = arg_90_1.isInRecall_ and (arg_90_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_90_1.var_.actorSpriteComps10030 = nil
			end

			local var_93_6 = 0
			local var_93_7 = 0.65

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_8 = arg_90_1:GetWordFromCfg(115291022)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 26 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 26)

				if (26 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 26)) > 0 and var_93_7 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291022", "story_v_out_115291.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291022", "story_v_out_115291.awb") / 1000

					if var_93_12 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_6
					end

					if var_93_8.prefab_name ~= "" and arg_90_1.actors_[var_93_8.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_8.prefab_name].transform, "story_v_out_115291", "115291022", "story_v_out_115291.awb")

						arg_90_1:RecordAudio("115291022", var_93_13)
						arg_90_1:RecordAudio("115291022", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_115291", "115291022", "story_v_out_115291.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_115291", "115291022", "story_v_out_115291.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play115291023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 115291023
		arg_94_1.duration_ = 10.9

		local var_94_0 = {
			ja = 6,
			ko = 10.133,
			zh = 8.3,
			en = 10.9
		}
		local var_94_1 = manager.audio:GetLocalizationFlag()

		if var_94_0[var_94_1] ~= nil then
			arg_94_1.duration_ = var_94_0[var_94_1]
		end

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play115291024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["1041_1"]) then
				local var_97_0 = arg_94_1.actors_["1041_1"]:GetComponent("Image")

				if var_97_0 then
					arg_94_1.var_.highlightMatValue1041_1 = var_97_0
				end
			end

			local var_97_1 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_1 and not isNil(arg_94_1.actors_["1041_1"]) then
				if arg_94_1.var_.highlightMatValue1041_1 then
					local var_97_2 = Mathf.Lerp(0.5, 1, (arg_94_1.time_ - 0) / var_97_1)

					arg_94_1.var_.highlightMatValue1041_1.color.r = var_97_2
					arg_94_1.var_.highlightMatValue1041_1.color.g = var_97_2
					arg_94_1.var_.highlightMatValue1041_1.color.b = var_97_2
					arg_94_1.var_.highlightMatValue1041_1.color = arg_94_1.var_.highlightMatValue1041_1.color
				end
			end

			if arg_94_1.time_ >= 0 + var_97_1 and arg_94_1.time_ < 0 + var_97_1 + arg_97_0 and not isNil(arg_94_1.actors_["1041_1"]) and arg_94_1.var_.highlightMatValue1041_1 then
				arg_94_1.actors_["1041_1"].transform:SetSiblingIndex(1)

				arg_94_1.var_.highlightMatValue1041_1.color.r = 1
				arg_94_1.var_.highlightMatValue1041_1.color.g = 1
				arg_94_1.var_.highlightMatValue1041_1.color.b = 1
				arg_94_1.var_.highlightMatValue1041_1.color = arg_94_1.var_.highlightMatValue1041_1.color
			end

			local var_97_3 = arg_94_1.actors_["10030"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.actorSpriteComps10030 == nil then
				arg_94_1.var_.actorSpriteComps10030 = var_97_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_97_4 = 0.2

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.actorSpriteComps10030 then
					for iter_97_0, iter_97_1 in pairs(arg_94_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_97_1 then
							if arg_94_1.isInRecall_ then
								iter_97_1.color = Color.New(Mathf.Lerp(iter_97_1.color.r, arg_94_1.hightColor2.r, (arg_94_1.time_ - 0) / var_97_4), Mathf.Lerp(iter_97_1.color.g, arg_94_1.hightColor2.g, (arg_94_1.time_ - 0) / var_97_4), (Mathf.Lerp(iter_97_1.color.b, arg_94_1.hightColor2.b, (arg_94_1.time_ - 0) / var_97_4)))
							else
								local var_97_5 = Mathf.Lerp(iter_97_1.color.r, 0.5, (arg_94_1.time_ - 0) / var_97_4)

								iter_97_1.color = Color.New(var_97_5, var_97_5, var_97_5)
							end
						end
					end
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.actorSpriteComps10030 then
				for iter_97_2, iter_97_3 in pairs(arg_94_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_97_3 then
						iter_97_3.color = arg_94_1.isInRecall_ and (arg_94_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_94_1.var_.actorSpriteComps10030 = nil
			end

			local var_97_6 = 0
			local var_97_7 = 1.025

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_6 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_8 = arg_94_1:GetWordFromCfg(115291023)
				local var_97_9 = arg_94_1:FormatText(var_97_8.content)

				arg_94_1.text_.text = var_97_9

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_11 = 41 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 41)

				if (41 <= 0 and var_97_7 or var_97_7 * (utf8.len(var_97_9) / 41)) > 0 and var_97_7 < var_97_11 then
					arg_94_1.talkMaxDuration = var_97_11

					if var_97_11 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_11 + var_97_6
					end
				end

				arg_94_1.text_.text = var_97_9
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291023", "story_v_out_115291.awb") ~= 0 then
					local var_97_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291023", "story_v_out_115291.awb") / 1000

					if var_97_12 + var_97_6 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_12 + var_97_6
					end

					if var_97_8.prefab_name ~= "" and arg_94_1.actors_[var_97_8.prefab_name] ~= nil then
						local var_97_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_8.prefab_name].transform, "story_v_out_115291", "115291023", "story_v_out_115291.awb")

						arg_94_1:RecordAudio("115291023", var_97_13)
						arg_94_1:RecordAudio("115291023", var_97_13)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_115291", "115291023", "story_v_out_115291.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_115291", "115291023", "story_v_out_115291.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_14 = math.max(var_97_7, arg_94_1.talkMaxDuration)

			if var_97_6 <= arg_94_1.time_ and arg_94_1.time_ < var_97_6 + var_97_14 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_6) / var_97_14

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_6 + var_97_14 and arg_94_1.time_ < var_97_6 + var_97_14 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play115291024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 115291024
		arg_98_1.duration_ = 7.07

		local var_98_0 = {
			ja = 5.8,
			ko = 5.766,
			zh = 5.833,
			en = 7.066
		}
		local var_98_1 = manager.audio:GetLocalizationFlag()

		if var_98_0[var_98_1] ~= nil then
			arg_98_1.duration_ = var_98_0[var_98_1]
		end

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play115291025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.75

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_1 = arg_98_1:GetWordFromCfg(115291024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 30 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 30)

				if (30 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 30)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291024", "story_v_out_115291.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291024", "story_v_out_115291.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_115291", "115291024", "story_v_out_115291.awb")

						arg_98_1:RecordAudio("115291024", var_101_6)
						arg_98_1:RecordAudio("115291024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_115291", "115291024", "story_v_out_115291.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_115291", "115291024", "story_v_out_115291.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_7 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_7

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play115291025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 115291025
		arg_102_1.duration_ = 11.5

		local var_102_0 = {
			ja = 9.5,
			ko = 9,
			zh = 7.5,
			en = 11.5
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play115291026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				local var_105_0 = arg_102_1.bgs_.ST22a

				arg_102_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_105_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_105_1 = var_105_0:GetComponent("SpriteRenderer")

				if var_105_1 and var_105_1.sprite then
					local var_105_2 = 2 * (var_105_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_105_0.transform.localScale = Vector3.New(var_105_2 / var_105_1.sprite.bounds.size.y < var_105_2 * manager.ui.mainCameraCom_.aspect / var_105_1.sprite.bounds.size.x and var_105_2 * manager.ui.mainCameraCom_.aspect / var_105_1.sprite.bounds.size.x or var_105_2 / var_105_1.sprite.bounds.size.y, var_105_2 / var_105_1.sprite.bounds.size.y < var_105_2 * manager.ui.mainCameraCom_.aspect / var_105_1.sprite.bounds.size.x and var_105_2 * manager.ui.mainCameraCom_.aspect / var_105_1.sprite.bounds.size.x or var_105_2 / var_105_1.sprite.bounds.size.y, 0)
				end

				for iter_105_0, iter_105_1 in pairs(arg_102_1.bgs_) do
					if iter_105_0 ~= "ST22a" then
						iter_105_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_105_3 = 0

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_3 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = false

				arg_102_1:SetGaussion(false)
			end

			local var_105_4 = 2

			if var_105_3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_3 + var_105_4 then
				local var_105_5 = Color.New(0, 0, 0)

				var_105_5.a = Mathf.Lerp(0, 1, (arg_102_1.time_ - var_105_3) / var_105_4)
				arg_102_1.mask_.color = var_105_5
			end

			if arg_102_1.time_ >= var_105_3 + var_105_4 and arg_102_1.time_ < var_105_3 + var_105_4 + arg_105_0 then
				local var_105_6 = Color.New(0, 0, 0)

				var_105_6.a = 1
				arg_102_1.mask_.color = var_105_6
			end

			local var_105_7 = 2

			if 2 < arg_102_1.time_ and arg_102_1.time_ <= var_105_7 + arg_105_0 then
				arg_102_1.mask_.enabled = true
				arg_102_1.mask_.raycastTarget = false

				arg_102_1:SetGaussion(false)
			end

			local var_105_8 = 2

			if var_105_7 <= arg_102_1.time_ and arg_102_1.time_ < var_105_7 + var_105_8 then
				local var_105_9 = Color.New(0, 0, 0)

				var_105_9.a = Mathf.Lerp(1, 0, (arg_102_1.time_ - var_105_7) / var_105_8)
				arg_102_1.mask_.color = var_105_9
			end

			if arg_102_1.time_ >= var_105_7 + var_105_8 and arg_102_1.time_ < var_105_7 + var_105_8 + arg_105_0 then
				local var_105_10 = Color.New(0, 0, 0)

				arg_102_1.mask_.enabled = false
				var_105_10.a = 0
				arg_102_1.mask_.color = var_105_10
			end

			local var_105_11 = arg_102_1.actors_["1041_1"].transform

			if 2 < arg_102_1.time_ and arg_102_1.time_ <= 2 + arg_105_0 then
				arg_102_1.var_.moveOldPos1041_1 = var_105_11.localPosition
				var_105_11.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("1041_1", 7)
			end

			local var_105_12 = 0.001

			if 2 <= arg_102_1.time_ and arg_102_1.time_ < 2 + var_105_12 then
				var_105_11.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos1041_1, Vector3.New(0, -2000, -370), (arg_102_1.time_ - 2) / var_105_12)
			end

			if arg_102_1.time_ >= 2 + var_105_12 and arg_102_1.time_ < 2 + var_105_12 + arg_105_0 then
				var_105_11.localPosition = Vector3.New(0, -2000, -370)
			end

			local var_105_13 = arg_102_1.actors_["10030"].transform

			if 2 < arg_102_1.time_ and arg_102_1.time_ <= 2 + arg_105_0 then
				arg_102_1.var_.moveOldPos10030 = var_105_13.localPosition
				var_105_13.localScale = Vector3.New(1, 1, 1)

				arg_102_1:CheckSpriteTmpPos("10030", 7)

				for iter_105_2 = 0, var_105_13.childCount - 1 do
					local var_105_14 = var_105_13:GetChild(iter_105_2)

					if var_105_14.name == "split_3" or not string.find(var_105_14.name, "split") then
						var_105_14.gameObject:SetActive(true)
					else
						var_105_14.gameObject:SetActive(false)
					end
				end
			end

			local var_105_15 = 0.001

			if 2 <= arg_102_1.time_ and arg_102_1.time_ < 2 + var_105_15 then
				var_105_13.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos10030, Vector3.New(0, -2000, 150), (arg_102_1.time_ - 2) / var_105_15)
			end

			if arg_102_1.time_ >= 2 + var_105_15 and arg_102_1.time_ < 2 + var_105_15 + arg_105_0 then
				var_105_13.localPosition = Vector3.New(0, -2000, 150)
			end

			if arg_102_1.frameCnt_ <= 1 then
				arg_102_1.dialog_:SetActive(false)
			end

			local var_105_16 = 4
			local var_105_17 = 0.375

			if 4 < arg_102_1.time_ and arg_102_1.time_ <= var_105_16 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0

				arg_102_1.dialog_:SetActive(true)

				arg_102_1.dialogCg_.alpha = 0

				local var_105_18 = LeanTween.value(arg_102_1.dialog_, 0, 1, 0.3)

				var_105_18:setOnUpdate(LuaHelper.FloatAction(function(arg_106_0)
					arg_102_1.dialogCg_.alpha = arg_106_0
				end))
				var_105_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_102_1.dialog_)
					var_105_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_102_1.duration_ = arg_102_1.duration_ + 0.3

				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_19 = arg_102_1:GetWordFromCfg(115291025)
				local var_105_20 = arg_102_1:FormatText(var_105_19.content)

				arg_102_1.text_.text = var_105_20

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_22 = 15 <= 0 and var_105_17 or var_105_17 * (utf8.len(var_105_20) / 15)

				if (15 <= 0 and var_105_17 or var_105_17 * (utf8.len(var_105_20) / 15)) > 0 and var_105_17 < var_105_22 then
					arg_102_1.talkMaxDuration = var_105_22
					var_105_16 = var_105_16 + 0.3

					if var_105_22 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_22 + var_105_16
					end
				end

				arg_102_1.text_.text = var_105_20
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291025", "story_v_out_115291.awb") ~= 0 then
					local var_105_23 = manager.audio:GetVoiceLength("story_v_out_115291", "115291025", "story_v_out_115291.awb") / 1000

					if var_105_23 + var_105_16 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_23 + var_105_16
					end

					if var_105_19.prefab_name ~= "" and arg_102_1.actors_[var_105_19.prefab_name] ~= nil then
						local var_105_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_19.prefab_name].transform, "story_v_out_115291", "115291025", "story_v_out_115291.awb")

						arg_102_1:RecordAudio("115291025", var_105_24)
						arg_102_1:RecordAudio("115291025", var_105_24)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_115291", "115291025", "story_v_out_115291.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_115291", "115291025", "story_v_out_115291.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_25 = var_105_16 + 0.3
			local var_105_26 = math.max(var_105_17, arg_102_1.talkMaxDuration)

			if var_105_16 + 0.3 <= arg_102_1.time_ and arg_102_1.time_ < var_105_25 + var_105_26 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_25) / var_105_26

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_25 + var_105_26 and arg_102_1.time_ < var_105_25 + var_105_26 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041_1",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			},
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play115291026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 115291026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play115291027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_case", "")
			end

			local var_111_1 = 0
			local var_111_2 = 1.3

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, false)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_3 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(115291026).content)

				arg_108_1.text_.text = var_111_3

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_5 = 52 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 52)

				if (52 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_3) / 52)) > 0 and var_111_2 < var_111_5 then
					arg_108_1.talkMaxDuration = var_111_5

					if var_111_5 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_5 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_3
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_6 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 <= arg_108_1.time_ and arg_108_1.time_ < var_111_1 + var_111_6 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_1) / var_111_6

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_1 + var_111_6 and arg_108_1.time_ < var_111_1 + var_111_6 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play115291027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 115291027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play115291028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			local var_115_0 = 1.45

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_1 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(115291027).content)

				arg_112_1.text_.text = var_115_1

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_3 = 58 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 58)

				if (58 <= 0 and var_115_0 or var_115_0 * (utf8.len(var_115_1) / 58)) > 0 and var_115_0 < var_115_3 then
					arg_112_1.talkMaxDuration = var_115_3

					if var_115_3 + 0 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_3 + 0
					end
				end

				arg_112_1.text_.text = var_115_1
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_4 = math.max(var_115_0, arg_112_1.talkMaxDuration)

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - 0) / var_115_4

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play115291028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 115291028
		arg_116_1.duration_ = 3.17

		local var_116_0 = {
			ja = 3.133,
			ko = 2.7,
			zh = 2.633,
			en = 3.166
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
				arg_116_0:Play115291029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos10030 = arg_116_1.actors_["10030"].transform.localPosition
				arg_116_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_116_1:CheckSpriteTmpPos("10030", 3)

				for iter_119_0 = 0, arg_116_1.actors_["10030"].transform.childCount - 1 do
					local var_119_0 = arg_116_1.actors_["10030"].transform:GetChild(iter_119_0)

					if var_119_0.name == "split_5" or not string.find(var_119_0.name, "split") then
						var_119_0.gameObject:SetActive(true)
					else
						var_119_0.gameObject:SetActive(false)
					end
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_116_1.time_ - 0) / var_119_1)
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				local var_119_2 = arg_116_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_119_2 then
					arg_116_1.var_.alphaOldValue10030 = var_119_2.alpha
					arg_116_1.var_.characterEffect10030 = var_119_2
				end

				arg_116_1.var_.alphaOldValue10030 = 0
			end

			local var_119_3 = 0.333333333333333

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 then
				if arg_116_1.var_.characterEffect10030 then
					arg_116_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_116_1.var_.alphaOldValue10030, 1, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and arg_116_1.var_.characterEffect10030 then
				arg_116_1.var_.characterEffect10030.alpha = 1
			end

			local var_119_4 = 0
			local var_119_5 = 0.275

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_4 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_6 = arg_116_1:GetWordFromCfg(115291028)
				local var_119_7 = arg_116_1:FormatText(var_119_6.content)

				arg_116_1.text_.text = var_119_7

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_9 = 11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)

				if (11 <= 0 and var_119_5 or var_119_5 * (utf8.len(var_119_7) / 11)) > 0 and var_119_5 < var_119_9 then
					arg_116_1.talkMaxDuration = var_119_9

					if var_119_9 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_9 + var_119_4
					end
				end

				arg_116_1.text_.text = var_119_7
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291028", "story_v_out_115291.awb") ~= 0 then
					local var_119_10 = manager.audio:GetVoiceLength("story_v_out_115291", "115291028", "story_v_out_115291.awb") / 1000

					if var_119_10 + var_119_4 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_10 + var_119_4
					end

					if var_119_6.prefab_name ~= "" and arg_116_1.actors_[var_119_6.prefab_name] ~= nil then
						local var_119_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_6.prefab_name].transform, "story_v_out_115291", "115291028", "story_v_out_115291.awb")

						arg_116_1:RecordAudio("115291028", var_119_11)
						arg_116_1:RecordAudio("115291028", var_119_11)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_115291", "115291028", "story_v_out_115291.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_115291", "115291028", "story_v_out_115291.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_12 = math.max(var_119_5, arg_116_1.talkMaxDuration)

			if var_119_4 <= arg_116_1.time_ and arg_116_1.time_ < var_119_4 + var_119_12 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_4) / var_119_12

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_4 + var_119_12 and arg_116_1.time_ < var_119_4 + var_119_12 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play115291029 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 115291029
		arg_120_1.duration_ = 5.1

		local var_120_0 = {
			ja = 3.3,
			ko = 5.1,
			zh = 3.933,
			en = 4.633
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
				arg_120_0:Play115291030(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["10030"]) and arg_120_1.var_.actorSpriteComps10030 == nil then
				arg_120_1.var_.actorSpriteComps10030 = arg_120_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_123_0 = 0.2

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["10030"]) then
				if arg_120_1.var_.actorSpriteComps10030 then
					for iter_123_0, iter_123_1 in pairs(arg_120_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_123_1 then
							if arg_120_1.isInRecall_ then
								iter_123_1.color = Color.New(Mathf.Lerp(iter_123_1.color.r, arg_120_1.hightColor2.r, (arg_120_1.time_ - 0) / var_123_0), Mathf.Lerp(iter_123_1.color.g, arg_120_1.hightColor2.g, (arg_120_1.time_ - 0) / var_123_0), (Mathf.Lerp(iter_123_1.color.b, arg_120_1.hightColor2.b, (arg_120_1.time_ - 0) / var_123_0)))
							else
								local var_123_1 = Mathf.Lerp(iter_123_1.color.r, 0.5, (arg_120_1.time_ - 0) / var_123_0)

								iter_123_1.color = Color.New(var_123_1, var_123_1, var_123_1)
							end
						end
					end
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["10030"]) and arg_120_1.var_.actorSpriteComps10030 then
				for iter_123_2, iter_123_3 in pairs(arg_120_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_123_3 then
						iter_123_3.color = arg_120_1.isInRecall_ and (arg_120_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_120_1.var_.actorSpriteComps10030 = nil
			end

			local var_123_2 = 0
			local var_123_3 = 0.525

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_2 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[316].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenmb")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_4 = arg_120_1:GetWordFromCfg(115291029)
				local var_123_5 = arg_120_1:FormatText(var_123_4.content)

				arg_120_1.text_.text = var_123_5

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_7 = 21 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 21)

				if (21 <= 0 and var_123_3 or var_123_3 * (utf8.len(var_123_5) / 21)) > 0 and var_123_3 < var_123_7 then
					arg_120_1.talkMaxDuration = var_123_7

					if var_123_7 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_7 + var_123_2
					end
				end

				arg_120_1.text_.text = var_123_5
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291029", "story_v_out_115291.awb") ~= 0 then
					local var_123_8 = manager.audio:GetVoiceLength("story_v_out_115291", "115291029", "story_v_out_115291.awb") / 1000

					if var_123_8 + var_123_2 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_8 + var_123_2
					end

					if var_123_4.prefab_name ~= "" and arg_120_1.actors_[var_123_4.prefab_name] ~= nil then
						local var_123_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_4.prefab_name].transform, "story_v_out_115291", "115291029", "story_v_out_115291.awb")

						arg_120_1:RecordAudio("115291029", var_123_9)
						arg_120_1:RecordAudio("115291029", var_123_9)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_115291", "115291029", "story_v_out_115291.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_115291", "115291029", "story_v_out_115291.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_10 = math.max(var_123_3, arg_120_1.talkMaxDuration)

			if var_123_2 <= arg_120_1.time_ and arg_120_1.time_ < var_123_2 + var_123_10 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_2) / var_123_10

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_2 + var_123_10 and arg_120_1.time_ < var_123_2 + var_123_10 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play115291030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 115291030
		arg_124_1.duration_ = 11.37

		local var_124_0 = {
			ja = 7.766,
			ko = 6.8,
			zh = 7.633,
			en = 11.366
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
				arg_124_0:Play115291031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 1.075

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_reporterm")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:GetWordFromCfg(115291030)
				local var_127_2 = arg_124_1:FormatText(var_127_1.content)

				arg_124_1.text_.text = var_127_2

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_4 = 43 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 43)

				if (43 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_2) / 43)) > 0 and var_127_0 < var_127_4 then
					arg_124_1.talkMaxDuration = var_127_4

					if var_127_4 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_4 + 0
					end
				end

				arg_124_1.text_.text = var_127_2
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291030", "story_v_out_115291.awb") ~= 0 then
					local var_127_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291030", "story_v_out_115291.awb") / 1000

					if var_127_5 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + 0
					end

					if var_127_1.prefab_name ~= "" and arg_124_1.actors_[var_127_1.prefab_name] ~= nil then
						local var_127_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_1.prefab_name].transform, "story_v_out_115291", "115291030", "story_v_out_115291.awb")

						arg_124_1:RecordAudio("115291030", var_127_6)
						arg_124_1:RecordAudio("115291030", var_127_6)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_115291", "115291030", "story_v_out_115291.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_115291", "115291030", "story_v_out_115291.awb")
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
	Play115291031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 115291031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play115291032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				local var_131_0 = arg_128_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_131_0 then
					arg_128_1.var_.alphaOldValue10030 = var_131_0.alpha
					arg_128_1.var_.characterEffect10030 = var_131_0
				end

				arg_128_1.var_.alphaOldValue10030 = 1
			end

			local var_131_1 = 0.333333333333333

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_1 then
				if arg_128_1.var_.characterEffect10030 then
					arg_128_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_128_1.var_.alphaOldValue10030, 0, (arg_128_1.time_ - 0) / var_131_1)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_1 and arg_128_1.time_ < 0 + var_131_1 + arg_131_0 and arg_128_1.var_.characterEffect10030 then
				arg_128_1.var_.characterEffect10030.alpha = 0
			end

			local var_131_2 = 0
			local var_131_3 = 1.275

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_2 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_4 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(115291031).content)

				arg_128_1.text_.text = var_131_4

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_6 = 51 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_4) / 51)

				if (51 <= 0 and var_131_3 or var_131_3 * (utf8.len(var_131_4) / 51)) > 0 and var_131_3 < var_131_6 then
					arg_128_1.talkMaxDuration = var_131_6

					if var_131_6 + var_131_2 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_6 + var_131_2
					end
				end

				arg_128_1.text_.text = var_131_4
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_7 = math.max(var_131_3, arg_128_1.talkMaxDuration)

			if var_131_2 <= arg_128_1.time_ and arg_128_1.time_ < var_131_2 + var_131_7 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_2) / var_131_7

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_2 + var_131_7 and arg_128_1.time_ < var_131_2 + var_131_7 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play115291032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 115291032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play115291033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.675

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, false)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(115291032).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 27 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 27)

				if (27 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 27)) > 0 and var_135_0 < var_135_3 then
					arg_132_1.talkMaxDuration = var_135_3

					if var_135_3 + 0 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_3 + 0
					end
				end

				arg_132_1.text_.text = var_135_1
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)
				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_4 = math.max(var_135_0, arg_132_1.talkMaxDuration)

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_4 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - 0) / var_135_4

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= 0 + var_135_4 and arg_132_1.time_ < 0 + var_135_4 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play115291033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 115291033
		arg_136_1.duration_ = 8.73

		local var_136_0 = {
			ja = 8.2,
			ko = 8.733,
			zh = 8.1,
			en = 8.6
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
				arg_136_0:Play115291034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			local var_139_0 = 0.875

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[314].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, true)
				arg_136_1.iconController_:SetSelectedState("hero")

				arg_136_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenwb")

				arg_136_1.callingController_:SetSelectedState("normal")

				arg_136_1.keyicon_.color = Color.New(1, 1, 1)
				arg_136_1.icon_.color = Color.New(1, 1, 1)

				local var_139_1 = arg_136_1:GetWordFromCfg(115291033)
				local var_139_2 = arg_136_1:FormatText(var_139_1.content)

				arg_136_1.text_.text = var_139_2

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_4 = 35 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 35)

				if (35 <= 0 and var_139_0 or var_139_0 * (utf8.len(var_139_2) / 35)) > 0 and var_139_0 < var_139_4 then
					arg_136_1.talkMaxDuration = var_139_4

					if var_139_4 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_4 + 0
					end
				end

				arg_136_1.text_.text = var_139_2
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291033", "story_v_out_115291.awb") ~= 0 then
					local var_139_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291033", "story_v_out_115291.awb") / 1000

					if var_139_5 + 0 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_5 + 0
					end

					if var_139_1.prefab_name ~= "" and arg_136_1.actors_[var_139_1.prefab_name] ~= nil then
						local var_139_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_1.prefab_name].transform, "story_v_out_115291", "115291033", "story_v_out_115291.awb")

						arg_136_1:RecordAudio("115291033", var_139_6)
						arg_136_1:RecordAudio("115291033", var_139_6)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_115291", "115291033", "story_v_out_115291.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_115291", "115291033", "story_v_out_115291.awb")
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
	Play115291034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 115291034
		arg_140_1.duration_ = 8.2

		local var_140_0 = {
			ja = 4,
			ko = 6.5,
			zh = 5.1,
			en = 8.2
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
				arg_140_0:Play115291035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			local var_143_0 = 0.725

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_1 = arg_140_1:GetWordFromCfg(115291034)
				local var_143_2 = arg_140_1:FormatText(var_143_1.content)

				arg_140_1.text_.text = var_143_2

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_4 = 29 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 29)

				if (29 <= 0 and var_143_0 or var_143_0 * (utf8.len(var_143_2) / 29)) > 0 and var_143_0 < var_143_4 then
					arg_140_1.talkMaxDuration = var_143_4

					if var_143_4 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_4 + 0
					end
				end

				arg_140_1.text_.text = var_143_2
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291034", "story_v_out_115291.awb") ~= 0 then
					local var_143_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291034", "story_v_out_115291.awb") / 1000

					if var_143_5 + 0 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + 0
					end

					if var_143_1.prefab_name ~= "" and arg_140_1.actors_[var_143_1.prefab_name] ~= nil then
						local var_143_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_140_1.actors_[var_143_1.prefab_name].transform, "story_v_out_115291", "115291034", "story_v_out_115291.awb")

						arg_140_1:RecordAudio("115291034", var_143_6)
						arg_140_1:RecordAudio("115291034", var_143_6)
					else
						arg_140_1:AudioAction("play", "voice", "story_v_out_115291", "115291034", "story_v_out_115291.awb")
					end

					arg_140_1:RecordHistoryTalkVoice("story_v_out_115291", "115291034", "story_v_out_115291.awb")
				end

				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_7 = math.max(var_143_0, arg_140_1.talkMaxDuration)

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_7 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - 0) / var_143_7

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= 0 + var_143_7 and arg_140_1.time_ < 0 + var_143_7 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play115291035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 115291035
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play115291036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.65

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, false)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(115291035).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 26 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 26)

				if (26 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 26)) > 0 and var_147_0 < var_147_3 then
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
	Play115291036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 115291036
		arg_148_1.duration_ = 5.13

		local var_148_0 = {
			ja = 5.133,
			ko = 3,
			zh = 2.366,
			en = 3.566
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
				arg_148_0:Play115291037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			local var_151_0 = 0.25

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[315].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, true)
				arg_148_1.iconController_:SetSelectedState("hero")

				arg_148_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				arg_148_1.callingController_:SetSelectedState("normal")

				arg_148_1.keyicon_.color = Color.New(1, 1, 1)
				arg_148_1.icon_.color = Color.New(1, 1, 1)

				local var_151_1 = arg_148_1:GetWordFromCfg(115291036)
				local var_151_2 = arg_148_1:FormatText(var_151_1.content)

				arg_148_1.text_.text = var_151_2

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_4 = 10 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 10)

				if (10 <= 0 and var_151_0 or var_151_0 * (utf8.len(var_151_2) / 10)) > 0 and var_151_0 < var_151_4 then
					arg_148_1.talkMaxDuration = var_151_4

					if var_151_4 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_4 + 0
					end
				end

				arg_148_1.text_.text = var_151_2
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291036", "story_v_out_115291.awb") ~= 0 then
					local var_151_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291036", "story_v_out_115291.awb") / 1000

					if var_151_5 + 0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + 0
					end

					if var_151_1.prefab_name ~= "" and arg_148_1.actors_[var_151_1.prefab_name] ~= nil then
						local var_151_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_1.prefab_name].transform, "story_v_out_115291", "115291036", "story_v_out_115291.awb")

						arg_148_1:RecordAudio("115291036", var_151_6)
						arg_148_1:RecordAudio("115291036", var_151_6)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_115291", "115291036", "story_v_out_115291.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_115291", "115291036", "story_v_out_115291.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_7 = math.max(var_151_0, arg_148_1.talkMaxDuration)

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_7 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - 0) / var_151_7

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= 0 + var_151_7 and arg_148_1.time_ < 0 + var_151_7 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play115291037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 115291037
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play115291038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			local var_155_0 = 0.575

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, false)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_1 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(115291037).content)

				arg_152_1.text_.text = var_155_1

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_3 = 23 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 23)

				if (23 <= 0 and var_155_0 or var_155_0 * (utf8.len(var_155_1) / 23)) > 0 and var_155_0 < var_155_3 then
					arg_152_1.talkMaxDuration = var_155_3

					if var_155_3 + 0 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_3 + 0
					end
				end

				arg_152_1.text_.text = var_155_1
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_4 = math.max(var_155_0, arg_152_1.talkMaxDuration)

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - 0) / var_155_4

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play115291038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 115291038
		arg_156_1.duration_ = 6.4

		local var_156_0 = {
			ja = 3.966,
			ko = 3.833,
			zh = 4.133,
			en = 6.4
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
				arg_156_0:Play115291039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if arg_156_1.actors_["10029"] == nil then
				local var_159_0 = Object.Instantiate(arg_156_1.imageGo_, arg_156_1.canvasGo_.transform)

				var_159_0.transform:SetSiblingIndex(1)

				var_159_0.name = "10029"

				local var_159_1 = var_159_0:GetComponent(typeof(Image))

				var_159_1.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. "10029")

				var_159_1:SetNativeSize()

				var_159_0.transform.localPosition = Vector3.New(0, 100000, 0)
				arg_156_1.actors_["10029"] = var_159_0
			end

			local var_159_2 = arg_156_1.actors_["10029"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos10029 = var_159_2.localPosition
				var_159_2.localScale = Vector3.New(1, 1, 1)

				arg_156_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_159_3 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_3 then
				var_159_2.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_156_1.time_ - 0) / var_159_3)
			end

			if arg_156_1.time_ >= 0 + var_159_3 and arg_156_1.time_ < 0 + var_159_3 + arg_159_0 then
				var_159_2.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				local var_159_4 = arg_156_1.actors_["10029"]:GetComponent("Image")

				if var_159_4 then
					arg_156_1.var_.alphaMatValue10029 = var_159_4
					arg_156_1.var_.alphaOldValue10029 = var_159_4.color.a
				end

				arg_156_1.var_.alphaOldValue10029 = 0
			end

			local var_159_5 = 0.333333333333333

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_5 then
				if arg_156_1.var_.alphaMatValue10029 then
					arg_156_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_156_1.var_.alphaOldValue10029, 1, (arg_156_1.time_ - 0) / var_159_5)
					arg_156_1.var_.alphaMatValue10029.color = arg_156_1.var_.alphaMatValue10029.color
				end
			end

			if arg_156_1.time_ >= 0 + var_159_5 and arg_156_1.time_ < 0 + var_159_5 + arg_159_0 and arg_156_1.var_.alphaMatValue10029 then
				arg_156_1.var_.alphaMatValue10029.color.a = 1
				arg_156_1.var_.alphaMatValue10029.color = arg_156_1.var_.alphaMatValue10029.color
			end

			local var_159_6 = 0
			local var_159_7 = 0.425

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:GetWordFromCfg(115291038)
				local var_159_9 = arg_156_1:FormatText(var_159_8.content)

				arg_156_1.text_.text = var_159_9

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_11 = 17 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 17)

				if (17 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_9) / 17)) > 0 and var_159_7 < var_159_11 then
					arg_156_1.talkMaxDuration = var_159_11

					if var_159_11 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_11 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_9
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291038", "story_v_out_115291.awb") ~= 0 then
					local var_159_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291038", "story_v_out_115291.awb") / 1000

					if var_159_12 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_12 + var_159_6
					end

					if var_159_8.prefab_name ~= "" and arg_156_1.actors_[var_159_8.prefab_name] ~= nil then
						local var_159_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_156_1.actors_[var_159_8.prefab_name].transform, "story_v_out_115291", "115291038", "story_v_out_115291.awb")

						arg_156_1:RecordAudio("115291038", var_159_13)
						arg_156_1:RecordAudio("115291038", var_159_13)
					else
						arg_156_1:AudioAction("play", "voice", "story_v_out_115291", "115291038", "story_v_out_115291.awb")
					end

					arg_156_1:RecordHistoryTalkVoice("story_v_out_115291", "115291038", "story_v_out_115291.awb")
				end

				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_14 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_14 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_14

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_14 and arg_156_1.time_ < var_159_6 + var_159_14 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play115291039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 115291039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play115291040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				local var_163_0 = arg_160_1.actors_["10029"]:GetComponent("Image")

				if var_163_0 then
					arg_160_1.var_.alphaMatValue10029 = var_163_0
					arg_160_1.var_.alphaOldValue10029 = var_163_0.color.a
				end

				arg_160_1.var_.alphaOldValue10029 = 1
			end

			local var_163_1 = 0.333333333333333

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_1 then
				if arg_160_1.var_.alphaMatValue10029 then
					arg_160_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_160_1.var_.alphaOldValue10029, 0, (arg_160_1.time_ - 0) / var_163_1)
					arg_160_1.var_.alphaMatValue10029.color = arg_160_1.var_.alphaMatValue10029.color
				end
			end

			if arg_160_1.time_ >= 0 + var_163_1 and arg_160_1.time_ < 0 + var_163_1 + arg_163_0 and arg_160_1.var_.alphaMatValue10029 then
				arg_160_1.var_.alphaMatValue10029.color.a = 0
				arg_160_1.var_.alphaMatValue10029.color = arg_160_1.var_.alphaMatValue10029.color
			end

			local var_163_2 = 0
			local var_163_3 = 1.125

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_2 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_4 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(115291039).content)

				arg_160_1.text_.text = var_163_4

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_6 = 45 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_4) / 45)

				if (45 <= 0 and var_163_3 or var_163_3 * (utf8.len(var_163_4) / 45)) > 0 and var_163_3 < var_163_6 then
					arg_160_1.talkMaxDuration = var_163_6

					if var_163_6 + var_163_2 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_6 + var_163_2
					end
				end

				arg_160_1.text_.text = var_163_4
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_7 = math.max(var_163_3, arg_160_1.talkMaxDuration)

			if var_163_2 <= arg_160_1.time_ and arg_160_1.time_ < var_163_2 + var_163_7 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_2) / var_163_7

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_2 + var_163_7 and arg_160_1.time_ < var_163_2 + var_163_7 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {}

		arg_160_1:InitPlayNodeList()
	end,
	Play115291040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 115291040
		arg_164_1.duration_ = 12.3

		local var_164_0 = {
			ja = 11.666,
			ko = 8.1,
			zh = 11.1,
			en = 12.3
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
				arg_164_0:Play115291041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			local var_167_0 = 0.825

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, true)
				arg_164_1.iconController_:SetSelectedState("hero")

				arg_164_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_164_1.callingController_:SetSelectedState("normal")

				arg_164_1.keyicon_.color = Color.New(1, 1, 1)
				arg_164_1.icon_.color = Color.New(1, 1, 1)

				local var_167_1 = arg_164_1:GetWordFromCfg(115291040)
				local var_167_2 = arg_164_1:FormatText(var_167_1.content)

				arg_164_1.text_.text = var_167_2

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_4 = 33 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 33)

				if (33 <= 0 and var_167_0 or var_167_0 * (utf8.len(var_167_2) / 33)) > 0 and var_167_0 < var_167_4 then
					arg_164_1.talkMaxDuration = var_167_4

					if var_167_4 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_4 + 0
					end
				end

				arg_164_1.text_.text = var_167_2
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291040", "story_v_out_115291.awb") ~= 0 then
					local var_167_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291040", "story_v_out_115291.awb") / 1000

					if var_167_5 + 0 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_5 + 0
					end

					if var_167_1.prefab_name ~= "" and arg_164_1.actors_[var_167_1.prefab_name] ~= nil then
						local var_167_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_1.prefab_name].transform, "story_v_out_115291", "115291040", "story_v_out_115291.awb")

						arg_164_1:RecordAudio("115291040", var_167_6)
						arg_164_1:RecordAudio("115291040", var_167_6)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_115291", "115291040", "story_v_out_115291.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_115291", "115291040", "story_v_out_115291.awb")
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
	Play115291041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 115291041
		arg_168_1.duration_ = 6.03

		local var_168_0 = {
			ja = 6.033,
			ko = 4.666,
			zh = 2.9,
			en = 3
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
				arg_168_0:Play115291042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				local var_171_0 = arg_168_1.actors_["10029"]:GetComponent("Image")

				if var_171_0 then
					arg_168_1.var_.alphaMatValue10029 = var_171_0
					arg_168_1.var_.alphaOldValue10029 = var_171_0.color.a
				end

				arg_168_1.var_.alphaOldValue10029 = 0
			end

			local var_171_1 = 0.333333333333333

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_1 then
				if arg_168_1.var_.alphaMatValue10029 then
					arg_168_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_168_1.var_.alphaOldValue10029, 1, (arg_168_1.time_ - 0) / var_171_1)
					arg_168_1.var_.alphaMatValue10029.color = arg_168_1.var_.alphaMatValue10029.color
				end
			end

			if arg_168_1.time_ >= 0 + var_171_1 and arg_168_1.time_ < 0 + var_171_1 + arg_171_0 and arg_168_1.var_.alphaMatValue10029 then
				arg_168_1.var_.alphaMatValue10029.color.a = 1
				arg_168_1.var_.alphaMatValue10029.color = arg_168_1.var_.alphaMatValue10029.color
			end

			local var_171_2 = 0
			local var_171_3 = 0.25

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= var_171_2 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_4 = arg_168_1:GetWordFromCfg(115291041)
				local var_171_5 = arg_168_1:FormatText(var_171_4.content)

				arg_168_1.text_.text = var_171_5

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_7 = 10 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 10)

				if (10 <= 0 and var_171_3 or var_171_3 * (utf8.len(var_171_5) / 10)) > 0 and var_171_3 < var_171_7 then
					arg_168_1.talkMaxDuration = var_171_7

					if var_171_7 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_7 + var_171_2
					end
				end

				arg_168_1.text_.text = var_171_5
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291041", "story_v_out_115291.awb") ~= 0 then
					local var_171_8 = manager.audio:GetVoiceLength("story_v_out_115291", "115291041", "story_v_out_115291.awb") / 1000

					if var_171_8 + var_171_2 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_8 + var_171_2
					end

					if var_171_4.prefab_name ~= "" and arg_168_1.actors_[var_171_4.prefab_name] ~= nil then
						local var_171_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_4.prefab_name].transform, "story_v_out_115291", "115291041", "story_v_out_115291.awb")

						arg_168_1:RecordAudio("115291041", var_171_9)
						arg_168_1:RecordAudio("115291041", var_171_9)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_115291", "115291041", "story_v_out_115291.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_115291", "115291041", "story_v_out_115291.awb")
				end

				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_10 = math.max(var_171_3, arg_168_1.talkMaxDuration)

			if var_171_2 <= arg_168_1.time_ and arg_168_1.time_ < var_171_2 + var_171_10 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_2) / var_171_10

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_2 + var_171_10 and arg_168_1.time_ < var_171_2 + var_171_10 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {}

		arg_168_1:InitPlayNodeList()
	end,
	Play115291042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 115291042
		arg_172_1.duration_ = 16.3

		local var_172_0 = {
			ja = 16.3,
			ko = 11.3,
			zh = 12.4,
			en = 9.8
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
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play115291043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["10029"]) then
				local var_175_0 = arg_172_1.actors_["10029"]:GetComponent("Image")

				if var_175_0 then
					arg_172_1.var_.highlightMatValue10029 = var_175_0
				end
			end

			local var_175_1 = 0.2

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_1 and not isNil(arg_172_1.actors_["10029"]) then
				if arg_172_1.var_.highlightMatValue10029 then
					local var_175_2 = Mathf.Lerp(1, 0.5, (arg_172_1.time_ - 0) / var_175_1)

					arg_172_1.var_.highlightMatValue10029.color.r = var_175_2
					arg_172_1.var_.highlightMatValue10029.color.g = var_175_2
					arg_172_1.var_.highlightMatValue10029.color.b = var_175_2
					arg_172_1.var_.highlightMatValue10029.color = arg_172_1.var_.highlightMatValue10029.color
				end
			end

			if arg_172_1.time_ >= 0 + var_175_1 and arg_172_1.time_ < 0 + var_175_1 + arg_175_0 and not isNil(arg_172_1.actors_["10029"]) and arg_172_1.var_.highlightMatValue10029 then
				arg_172_1.var_.highlightMatValue10029.color.r = 0.5
				arg_172_1.var_.highlightMatValue10029.color.g = 0.5
				arg_172_1.var_.highlightMatValue10029.color.b = 0.5
				arg_172_1.var_.highlightMatValue10029.color = arg_172_1.var_.highlightMatValue10029.color
			end

			local var_175_3 = 0
			local var_175_4 = 0.975

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_3 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, true)

				arg_172_1.leftNameTxt_.text = arg_172_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_172_1.leftNameTxt_.transform)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1.leftNameTxt_.text)
				SetActive(arg_172_1.iconTrs_.gameObject, true)
				arg_172_1.iconController_:SetSelectedState("hero")

				arg_172_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_172_1.callingController_:SetSelectedState("normal")

				arg_172_1.keyicon_.color = Color.New(1, 1, 1)
				arg_172_1.icon_.color = Color.New(1, 1, 1)

				local var_175_5 = arg_172_1:GetWordFromCfg(115291042)
				local var_175_6 = arg_172_1:FormatText(var_175_5.content)

				arg_172_1.text_.text = var_175_6

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_8 = 37 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_6) / 37)

				if (37 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_6) / 37)) > 0 and var_175_4 < var_175_8 then
					arg_172_1.talkMaxDuration = var_175_8

					if var_175_8 + var_175_3 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_8 + var_175_3
					end
				end

				arg_172_1.text_.text = var_175_6
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291042", "story_v_out_115291.awb") ~= 0 then
					local var_175_9 = manager.audio:GetVoiceLength("story_v_out_115291", "115291042", "story_v_out_115291.awb") / 1000

					if var_175_9 + var_175_3 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_9 + var_175_3
					end

					if var_175_5.prefab_name ~= "" and arg_172_1.actors_[var_175_5.prefab_name] ~= nil then
						local var_175_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_172_1.actors_[var_175_5.prefab_name].transform, "story_v_out_115291", "115291042", "story_v_out_115291.awb")

						arg_172_1:RecordAudio("115291042", var_175_10)
						arg_172_1:RecordAudio("115291042", var_175_10)
					else
						arg_172_1:AudioAction("play", "voice", "story_v_out_115291", "115291042", "story_v_out_115291.awb")
					end

					arg_172_1:RecordHistoryTalkVoice("story_v_out_115291", "115291042", "story_v_out_115291.awb")
				end

				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_11 = math.max(var_175_4, arg_172_1.talkMaxDuration)

			if var_175_3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_3 + var_175_11 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_3) / var_175_11

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_3 + var_175_11 and arg_172_1.time_ < var_175_3 + var_175_11 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play115291043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 115291043
		arg_176_1.duration_ = 9.53

		local var_176_0 = {
			ja = 5.766,
			ko = 9.133,
			zh = 8,
			en = 9.533
		}
		local var_176_1 = manager.audio:GetLocalizationFlag()

		if var_176_0[var_176_1] ~= nil then
			arg_176_1.duration_ = var_176_0[var_176_1]
		end

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play115291044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(arg_176_1.actors_["10029"]) then
				local var_179_0 = arg_176_1.actors_["10029"]:GetComponent("Image")

				if var_179_0 then
					arg_176_1.var_.highlightMatValue10029 = var_179_0
				end
			end

			local var_179_1 = 0.2

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_1 and not isNil(arg_176_1.actors_["10029"]) then
				if arg_176_1.var_.highlightMatValue10029 then
					local var_179_2 = Mathf.Lerp(0.5, 1, (arg_176_1.time_ - 0) / var_179_1)

					arg_176_1.var_.highlightMatValue10029.color.r = var_179_2
					arg_176_1.var_.highlightMatValue10029.color.g = var_179_2
					arg_176_1.var_.highlightMatValue10029.color.b = var_179_2
					arg_176_1.var_.highlightMatValue10029.color = arg_176_1.var_.highlightMatValue10029.color
				end
			end

			if arg_176_1.time_ >= 0 + var_179_1 and arg_176_1.time_ < 0 + var_179_1 + arg_179_0 and not isNil(arg_176_1.actors_["10029"]) and arg_176_1.var_.highlightMatValue10029 then
				arg_176_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_176_1.var_.highlightMatValue10029.color.r = 1
				arg_176_1.var_.highlightMatValue10029.color.g = 1
				arg_176_1.var_.highlightMatValue10029.color.b = 1
				arg_176_1.var_.highlightMatValue10029.color = arg_176_1.var_.highlightMatValue10029.color
			end

			local var_179_3 = 0
			local var_179_4 = 0.7

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_3 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_5 = arg_176_1:GetWordFromCfg(115291043)
				local var_179_6 = arg_176_1:FormatText(var_179_5.content)

				arg_176_1.text_.text = var_179_6

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_8 = 28 <= 0 and var_179_4 or var_179_4 * (utf8.len(var_179_6) / 28)

				if (28 <= 0 and var_179_4 or var_179_4 * (utf8.len(var_179_6) / 28)) > 0 and var_179_4 < var_179_8 then
					arg_176_1.talkMaxDuration = var_179_8

					if var_179_8 + var_179_3 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_8 + var_179_3
					end
				end

				arg_176_1.text_.text = var_179_6
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291043", "story_v_out_115291.awb") ~= 0 then
					local var_179_9 = manager.audio:GetVoiceLength("story_v_out_115291", "115291043", "story_v_out_115291.awb") / 1000

					if var_179_9 + var_179_3 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_3
					end

					if var_179_5.prefab_name ~= "" and arg_176_1.actors_[var_179_5.prefab_name] ~= nil then
						local var_179_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_5.prefab_name].transform, "story_v_out_115291", "115291043", "story_v_out_115291.awb")

						arg_176_1:RecordAudio("115291043", var_179_10)
						arg_176_1:RecordAudio("115291043", var_179_10)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_115291", "115291043", "story_v_out_115291.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_115291", "115291043", "story_v_out_115291.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_11 = math.max(var_179_4, arg_176_1.talkMaxDuration)

			if var_179_3 <= arg_176_1.time_ and arg_176_1.time_ < var_179_3 + var_179_11 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_3) / var_179_11

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_3 + var_179_11 and arg_176_1.time_ < var_179_3 + var_179_11 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {}

		arg_176_1:InitPlayNodeList()
	end,
	Play115291044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 115291044
		arg_180_1.duration_ = 5.67

		local var_180_0 = {
			ja = 5.633,
			ko = 3.466,
			zh = 4.9,
			en = 5.666
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
				arg_180_0:Play115291045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(arg_180_1.actors_["10029"]) then
				local var_183_0 = arg_180_1.actors_["10029"]:GetComponent("Image")

				if var_183_0 then
					arg_180_1.var_.highlightMatValue10029 = var_183_0
				end
			end

			local var_183_1 = 0.2

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 and not isNil(arg_180_1.actors_["10029"]) then
				if arg_180_1.var_.highlightMatValue10029 then
					local var_183_2 = Mathf.Lerp(1, 0.5, (arg_180_1.time_ - 0) / var_183_1)

					arg_180_1.var_.highlightMatValue10029.color.r = var_183_2
					arg_180_1.var_.highlightMatValue10029.color.g = var_183_2
					arg_180_1.var_.highlightMatValue10029.color.b = var_183_2
					arg_180_1.var_.highlightMatValue10029.color = arg_180_1.var_.highlightMatValue10029.color
				end
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 and not isNil(arg_180_1.actors_["10029"]) and arg_180_1.var_.highlightMatValue10029 then
				arg_180_1.var_.highlightMatValue10029.color.r = 0.5
				arg_180_1.var_.highlightMatValue10029.color.g = 0.5
				arg_180_1.var_.highlightMatValue10029.color.b = 0.5
				arg_180_1.var_.highlightMatValue10029.color = arg_180_1.var_.highlightMatValue10029.color
			end

			local var_183_3 = 0
			local var_183_4 = 0.45

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_5 = arg_180_1:GetWordFromCfg(115291044)
				local var_183_6 = arg_180_1:FormatText(var_183_5.content)

				arg_180_1.text_.text = var_183_6

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_8 = 18 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_6) / 18)

				if (18 <= 0 and var_183_4 or var_183_4 * (utf8.len(var_183_6) / 18)) > 0 and var_183_4 < var_183_8 then
					arg_180_1.talkMaxDuration = var_183_8

					if var_183_8 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_8 + var_183_3
					end
				end

				arg_180_1.text_.text = var_183_6
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291044", "story_v_out_115291.awb") ~= 0 then
					local var_183_9 = manager.audio:GetVoiceLength("story_v_out_115291", "115291044", "story_v_out_115291.awb") / 1000

					if var_183_9 + var_183_3 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_9 + var_183_3
					end

					if var_183_5.prefab_name ~= "" and arg_180_1.actors_[var_183_5.prefab_name] ~= nil then
						local var_183_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_5.prefab_name].transform, "story_v_out_115291", "115291044", "story_v_out_115291.awb")

						arg_180_1:RecordAudio("115291044", var_183_10)
						arg_180_1:RecordAudio("115291044", var_183_10)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_115291", "115291044", "story_v_out_115291.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_115291", "115291044", "story_v_out_115291.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_11 = math.max(var_183_4, arg_180_1.talkMaxDuration)

			if var_183_3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_3 + var_183_11 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_3) / var_183_11

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_3 + var_183_11 and arg_180_1.time_ < var_183_3 + var_183_11 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {}

		arg_180_1:InitPlayNodeList()
	end,
	Play115291045 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 115291045
		arg_184_1.duration_ = 11.07

		local var_184_0 = {
			ja = 5.6,
			ko = 8.366,
			zh = 7.766,
			en = 11.066
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
				arg_184_0:Play115291046(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["10029"]) then
				local var_187_0 = arg_184_1.actors_["10029"]:GetComponent("Image")

				if var_187_0 then
					arg_184_1.var_.highlightMatValue10029 = var_187_0
				end
			end

			local var_187_1 = 0.2

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_1 and not isNil(arg_184_1.actors_["10029"]) then
				if arg_184_1.var_.highlightMatValue10029 then
					local var_187_2 = Mathf.Lerp(0.5, 1, (arg_184_1.time_ - 0) / var_187_1)

					arg_184_1.var_.highlightMatValue10029.color.r = var_187_2
					arg_184_1.var_.highlightMatValue10029.color.g = var_187_2
					arg_184_1.var_.highlightMatValue10029.color.b = var_187_2
					arg_184_1.var_.highlightMatValue10029.color = arg_184_1.var_.highlightMatValue10029.color
				end
			end

			if arg_184_1.time_ >= 0 + var_187_1 and arg_184_1.time_ < 0 + var_187_1 + arg_187_0 and not isNil(arg_184_1.actors_["10029"]) and arg_184_1.var_.highlightMatValue10029 then
				arg_184_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_184_1.var_.highlightMatValue10029.color.r = 1
				arg_184_1.var_.highlightMatValue10029.color.g = 1
				arg_184_1.var_.highlightMatValue10029.color.b = 1
				arg_184_1.var_.highlightMatValue10029.color = arg_184_1.var_.highlightMatValue10029.color
			end

			local var_187_3 = 0
			local var_187_4 = 0.875

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_3 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, false)
				arg_184_1.callingController_:SetSelectedState("normal")

				local var_187_5 = arg_184_1:GetWordFromCfg(115291045)
				local var_187_6 = arg_184_1:FormatText(var_187_5.content)

				arg_184_1.text_.text = var_187_6

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_8 = 32 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_6) / 32)

				if (32 <= 0 and var_187_4 or var_187_4 * (utf8.len(var_187_6) / 32)) > 0 and var_187_4 < var_187_8 then
					arg_184_1.talkMaxDuration = var_187_8

					if var_187_8 + var_187_3 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_8 + var_187_3
					end
				end

				arg_184_1.text_.text = var_187_6
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291045", "story_v_out_115291.awb") ~= 0 then
					local var_187_9 = manager.audio:GetVoiceLength("story_v_out_115291", "115291045", "story_v_out_115291.awb") / 1000

					if var_187_9 + var_187_3 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_9 + var_187_3
					end

					if var_187_5.prefab_name ~= "" and arg_184_1.actors_[var_187_5.prefab_name] ~= nil then
						local var_187_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_184_1.actors_[var_187_5.prefab_name].transform, "story_v_out_115291", "115291045", "story_v_out_115291.awb")

						arg_184_1:RecordAudio("115291045", var_187_10)
						arg_184_1:RecordAudio("115291045", var_187_10)
					else
						arg_184_1:AudioAction("play", "voice", "story_v_out_115291", "115291045", "story_v_out_115291.awb")
					end

					arg_184_1:RecordHistoryTalkVoice("story_v_out_115291", "115291045", "story_v_out_115291.awb")
				end

				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_11 = math.max(var_187_4, arg_184_1.talkMaxDuration)

			if var_187_3 <= arg_184_1.time_ and arg_184_1.time_ < var_187_3 + var_187_11 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_3) / var_187_11

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_3 + var_187_11 and arg_184_1.time_ < var_187_3 + var_187_11 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play115291046 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 115291046
		arg_188_1.duration_ = 7.3

		local var_188_0 = {
			ja = 7.066,
			ko = 3.033,
			zh = 5.933,
			en = 7.3
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
				arg_188_0:Play115291047(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["10029"]) then
				local var_191_0 = arg_188_1.actors_["10029"]:GetComponent("Image")

				if var_191_0 then
					arg_188_1.var_.highlightMatValue10029 = var_191_0
				end
			end

			local var_191_1 = 0.2

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_1 and not isNil(arg_188_1.actors_["10029"]) then
				if arg_188_1.var_.highlightMatValue10029 then
					local var_191_2 = Mathf.Lerp(1, 0.5, (arg_188_1.time_ - 0) / var_191_1)

					arg_188_1.var_.highlightMatValue10029.color.r = var_191_2
					arg_188_1.var_.highlightMatValue10029.color.g = var_191_2
					arg_188_1.var_.highlightMatValue10029.color.b = var_191_2
					arg_188_1.var_.highlightMatValue10029.color = arg_188_1.var_.highlightMatValue10029.color
				end
			end

			if arg_188_1.time_ >= 0 + var_191_1 and arg_188_1.time_ < 0 + var_191_1 + arg_191_0 and not isNil(arg_188_1.actors_["10029"]) and arg_188_1.var_.highlightMatValue10029 then
				arg_188_1.var_.highlightMatValue10029.color.r = 0.5
				arg_188_1.var_.highlightMatValue10029.color.g = 0.5
				arg_188_1.var_.highlightMatValue10029.color.b = 0.5
				arg_188_1.var_.highlightMatValue10029.color = arg_188_1.var_.highlightMatValue10029.color
			end

			local var_191_3 = 0
			local var_191_4 = 0.375

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_3 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, true)
				arg_188_1.iconController_:SetSelectedState("hero")

				arg_188_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_188_1.callingController_:SetSelectedState("normal")

				arg_188_1.keyicon_.color = Color.New(1, 1, 1)
				arg_188_1.icon_.color = Color.New(1, 1, 1)

				local var_191_5 = arg_188_1:GetWordFromCfg(115291046)
				local var_191_6 = arg_188_1:FormatText(var_191_5.content)

				arg_188_1.text_.text = var_191_6

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_8 = 15 <= 0 and var_191_4 or var_191_4 * (utf8.len(var_191_6) / 15)

				if (15 <= 0 and var_191_4 or var_191_4 * (utf8.len(var_191_6) / 15)) > 0 and var_191_4 < var_191_8 then
					arg_188_1.talkMaxDuration = var_191_8

					if var_191_8 + var_191_3 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_3
					end
				end

				arg_188_1.text_.text = var_191_6
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291046", "story_v_out_115291.awb") ~= 0 then
					local var_191_9 = manager.audio:GetVoiceLength("story_v_out_115291", "115291046", "story_v_out_115291.awb") / 1000

					if var_191_9 + var_191_3 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_9 + var_191_3
					end

					if var_191_5.prefab_name ~= "" and arg_188_1.actors_[var_191_5.prefab_name] ~= nil then
						local var_191_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_5.prefab_name].transform, "story_v_out_115291", "115291046", "story_v_out_115291.awb")

						arg_188_1:RecordAudio("115291046", var_191_10)
						arg_188_1:RecordAudio("115291046", var_191_10)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_115291", "115291046", "story_v_out_115291.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_115291", "115291046", "story_v_out_115291.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_11 = math.max(var_191_4, arg_188_1.talkMaxDuration)

			if var_191_3 <= arg_188_1.time_ and arg_188_1.time_ < var_191_3 + var_191_11 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_3) / var_191_11

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_3 + var_191_11 and arg_188_1.time_ < var_191_3 + var_191_11 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play115291047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 115291047
		arg_192_1.duration_ = 14.37

		local var_192_0 = {
			ja = 14.366,
			ko = 5.633,
			zh = 6.133,
			en = 6.2
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
				arg_192_0:Play115291048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			local var_195_0 = 0.45

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[310].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, true)
				arg_192_1.iconController_:SetSelectedState("hero")

				arg_192_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_grandpab")

				arg_192_1.callingController_:SetSelectedState("normal")

				arg_192_1.keyicon_.color = Color.New(1, 1, 1)
				arg_192_1.icon_.color = Color.New(1, 1, 1)

				local var_195_1 = arg_192_1:GetWordFromCfg(115291047)
				local var_195_2 = arg_192_1:FormatText(var_195_1.content)

				arg_192_1.text_.text = var_195_2

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_4 = 18 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 18)

				if (18 <= 0 and var_195_0 or var_195_0 * (utf8.len(var_195_2) / 18)) > 0 and var_195_0 < var_195_4 then
					arg_192_1.talkMaxDuration = var_195_4

					if var_195_4 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_4 + 0
					end
				end

				arg_192_1.text_.text = var_195_2
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291047", "story_v_out_115291.awb") ~= 0 then
					local var_195_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291047", "story_v_out_115291.awb") / 1000

					if var_195_5 + 0 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_5 + 0
					end

					if var_195_1.prefab_name ~= "" and arg_192_1.actors_[var_195_1.prefab_name] ~= nil then
						local var_195_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_1.prefab_name].transform, "story_v_out_115291", "115291047", "story_v_out_115291.awb")

						arg_192_1:RecordAudio("115291047", var_195_6)
						arg_192_1:RecordAudio("115291047", var_195_6)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_115291", "115291047", "story_v_out_115291.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_115291", "115291047", "story_v_out_115291.awb")
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
	Play115291048 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 115291048
		arg_196_1.duration_ = 5

		SetActive(arg_196_1.tipsGo_, false)

		function arg_196_1.onSingleLineFinish_()
			arg_196_1.onSingleLineUpdate_ = nil
			arg_196_1.onSingleLineFinish_ = nil
			arg_196_1.state_ = "waiting"
		end

		function arg_196_1.playNext_(arg_198_0)
			if arg_198_0 == 1 then
				arg_196_0:Play115291049(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				local var_199_0 = arg_196_1.actors_["10029"]:GetComponent("Image")

				if var_199_0 then
					arg_196_1.var_.alphaMatValue10029 = var_199_0
					arg_196_1.var_.alphaOldValue10029 = var_199_0.color.a
				end

				arg_196_1.var_.alphaOldValue10029 = 1
			end

			local var_199_1 = 0.333333333333333

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_1 then
				if arg_196_1.var_.alphaMatValue10029 then
					arg_196_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_196_1.var_.alphaOldValue10029, 0, (arg_196_1.time_ - 0) / var_199_1)
					arg_196_1.var_.alphaMatValue10029.color = arg_196_1.var_.alphaMatValue10029.color
				end
			end

			if arg_196_1.time_ >= 0 + var_199_1 and arg_196_1.time_ < 0 + var_199_1 + arg_199_0 and arg_196_1.var_.alphaMatValue10029 then
				arg_196_1.var_.alphaMatValue10029.color.a = 0
				arg_196_1.var_.alphaMatValue10029.color = arg_196_1.var_.alphaMatValue10029.color
			end

			local var_199_2 = 0
			local var_199_3 = 0.925

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_2 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, false)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_4 = arg_196_1:FormatText(arg_196_1:GetWordFromCfg(115291048).content)

				arg_196_1.text_.text = var_199_4

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_6 = 37 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_4) / 37)

				if (37 <= 0 and var_199_3 or var_199_3 * (utf8.len(var_199_4) / 37)) > 0 and var_199_3 < var_199_6 then
					arg_196_1.talkMaxDuration = var_199_6

					if var_199_6 + var_199_2 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_6 + var_199_2
					end
				end

				arg_196_1.text_.text = var_199_4
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)
				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_7 = math.max(var_199_3, arg_196_1.talkMaxDuration)

			if var_199_2 <= arg_196_1.time_ and arg_196_1.time_ < var_199_2 + var_199_7 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_2) / var_199_7

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_2 + var_199_7 and arg_196_1.time_ < var_199_2 + var_199_7 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play115291049 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 115291049
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play115291050(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			local var_203_0 = 1.075

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, false)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_200_1.iconTrs_.gameObject, false)
				arg_200_1.callingController_:SetSelectedState("normal")

				local var_203_1 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(115291049).content)

				arg_200_1.text_.text = var_203_1

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_3 = 43 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 43)

				if (43 <= 0 and var_203_0 or var_203_0 * (utf8.len(var_203_1) / 43)) > 0 and var_203_0 < var_203_3 then
					arg_200_1.talkMaxDuration = var_203_3

					if var_203_3 + 0 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_3 + 0
					end
				end

				arg_200_1.text_.text = var_203_1
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_4 = math.max(var_203_0, arg_200_1.talkMaxDuration)

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_4 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - 0) / var_203_4

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= 0 + var_203_4 and arg_200_1.time_ < 0 + var_203_4 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play115291050 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 115291050
		arg_204_1.duration_ = 2.23

		local var_204_0 = {
			ja = 2,
			ko = 2.233,
			zh = 2.166,
			en = 1.8
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
				arg_204_0:Play115291051(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1.var_.moveOldPos10029 = arg_204_1.actors_["10029"].transform.localPosition
				arg_204_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_204_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_207_0 = 0.001

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 then
				arg_204_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_204_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_204_1.time_ - 0) / var_207_0)
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 then
				arg_204_1.actors_["10029"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_207_1 = arg_204_1.actors_["10029"]

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(var_207_1) then
				local var_207_2 = var_207_1:GetComponent("Image")

				if var_207_2 then
					arg_204_1.var_.highlightMatValue10029 = var_207_2
				end
			end

			local var_207_3 = 0.2

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_3 and not isNil(var_207_1) then
				if arg_204_1.var_.highlightMatValue10029 then
					local var_207_4 = Mathf.Lerp(0.5, 1, (arg_204_1.time_ - 0) / var_207_3)

					arg_204_1.var_.highlightMatValue10029.color.r = var_207_4
					arg_204_1.var_.highlightMatValue10029.color.g = var_207_4
					arg_204_1.var_.highlightMatValue10029.color.b = var_207_4
					arg_204_1.var_.highlightMatValue10029.color = arg_204_1.var_.highlightMatValue10029.color
				end
			end

			if arg_204_1.time_ >= 0 + var_207_3 and arg_204_1.time_ < 0 + var_207_3 + arg_207_0 and not isNil(var_207_1) and arg_204_1.var_.highlightMatValue10029 then
				var_207_1.transform:SetSiblingIndex(1)

				arg_204_1.var_.highlightMatValue10029.color.r = 1
				arg_204_1.var_.highlightMatValue10029.color.g = 1
				arg_204_1.var_.highlightMatValue10029.color.b = 1
				arg_204_1.var_.highlightMatValue10029.color = arg_204_1.var_.highlightMatValue10029.color
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				local var_207_5 = arg_204_1.actors_["10029"]:GetComponent("Image")

				if var_207_5 then
					arg_204_1.var_.alphaMatValue10029 = var_207_5
					arg_204_1.var_.alphaOldValue10029 = var_207_5.color.a
				end

				arg_204_1.var_.alphaOldValue10029 = 0
			end

			local var_207_6 = 0.333333333333333

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_6 then
				if arg_204_1.var_.alphaMatValue10029 then
					arg_204_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_204_1.var_.alphaOldValue10029, 1, (arg_204_1.time_ - 0) / var_207_6)
					arg_204_1.var_.alphaMatValue10029.color = arg_204_1.var_.alphaMatValue10029.color
				end
			end

			if arg_204_1.time_ >= 0 + var_207_6 and arg_204_1.time_ < 0 + var_207_6 + arg_207_0 and arg_204_1.var_.alphaMatValue10029 then
				arg_204_1.var_.alphaMatValue10029.color.a = 1
				arg_204_1.var_.alphaMatValue10029.color = arg_204_1.var_.alphaMatValue10029.color
			end

			local var_207_7 = 0
			local var_207_8 = 0.225

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_7 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_9 = arg_204_1:GetWordFromCfg(115291050)
				local var_207_10 = arg_204_1:FormatText(var_207_9.content)

				arg_204_1.text_.text = var_207_10

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_12 = 9 <= 0 and var_207_8 or var_207_8 * (utf8.len(var_207_10) / 9)

				if (9 <= 0 and var_207_8 or var_207_8 * (utf8.len(var_207_10) / 9)) > 0 and var_207_8 < var_207_12 then
					arg_204_1.talkMaxDuration = var_207_12

					if var_207_12 + var_207_7 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_12 + var_207_7
					end
				end

				arg_204_1.text_.text = var_207_10
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291050", "story_v_out_115291.awb") ~= 0 then
					local var_207_13 = manager.audio:GetVoiceLength("story_v_out_115291", "115291050", "story_v_out_115291.awb") / 1000

					if var_207_13 + var_207_7 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_13 + var_207_7
					end

					if var_207_9.prefab_name ~= "" and arg_204_1.actors_[var_207_9.prefab_name] ~= nil then
						local var_207_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_9.prefab_name].transform, "story_v_out_115291", "115291050", "story_v_out_115291.awb")

						arg_204_1:RecordAudio("115291050", var_207_14)
						arg_204_1:RecordAudio("115291050", var_207_14)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_115291", "115291050", "story_v_out_115291.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_115291", "115291050", "story_v_out_115291.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_15 = math.max(var_207_8, arg_204_1.talkMaxDuration)

			if var_207_7 <= arg_204_1.time_ and arg_204_1.time_ < var_207_7 + var_207_15 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_7) / var_207_15

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_7 + var_207_15 and arg_204_1.time_ < var_207_7 + var_207_15 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_204_1:InitPlayNodeList()
	end,
	Play115291051 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 115291051
		arg_208_1.duration_ = 4.73

		local var_208_0 = {
			ja = 3.7,
			ko = 4.733,
			zh = 3.833,
			en = 3.566
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
				arg_208_0:Play115291052(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				arg_208_1.var_.moveOldPos10030 = arg_208_1.actors_["10030"].transform.localPosition
				arg_208_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_208_1:CheckSpriteTmpPos("10030", 4)

				for iter_211_0 = 0, arg_208_1.actors_["10030"].transform.childCount - 1 do
					local var_211_0 = arg_208_1.actors_["10030"].transform:GetChild(iter_211_0)

					if var_211_0.name == "split_3" or not string.find(var_211_0.name, "split") then
						var_211_0.gameObject:SetActive(true)
					else
						var_211_0.gameObject:SetActive(false)
					end
				end
			end

			local var_211_1 = 0.001

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_1 then
				arg_208_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_208_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_208_1.time_ - 0) / var_211_1)
			end

			if arg_208_1.time_ >= 0 + var_211_1 and arg_208_1.time_ < 0 + var_211_1 + arg_211_0 then
				arg_208_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_211_2 = arg_208_1.actors_["10029"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_2) then
				local var_211_3 = var_211_2:GetComponent("Image")

				if var_211_3 then
					arg_208_1.var_.highlightMatValue10029 = var_211_3
				end
			end

			local var_211_4 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_4 and not isNil(var_211_2) then
				if arg_208_1.var_.highlightMatValue10029 then
					local var_211_5 = Mathf.Lerp(1, 0.5, (arg_208_1.time_ - 0) / var_211_4)

					arg_208_1.var_.highlightMatValue10029.color.r = var_211_5
					arg_208_1.var_.highlightMatValue10029.color.g = var_211_5
					arg_208_1.var_.highlightMatValue10029.color.b = var_211_5
					arg_208_1.var_.highlightMatValue10029.color = arg_208_1.var_.highlightMatValue10029.color
				end
			end

			if arg_208_1.time_ >= 0 + var_211_4 and arg_208_1.time_ < 0 + var_211_4 + arg_211_0 and not isNil(var_211_2) and arg_208_1.var_.highlightMatValue10029 then
				arg_208_1.var_.highlightMatValue10029.color.r = 0.5
				arg_208_1.var_.highlightMatValue10029.color.g = 0.5
				arg_208_1.var_.highlightMatValue10029.color.b = 0.5
				arg_208_1.var_.highlightMatValue10029.color = arg_208_1.var_.highlightMatValue10029.color
			end

			local var_211_6 = arg_208_1.actors_["10030"]

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(var_211_6) and arg_208_1.var_.actorSpriteComps10030 == nil then
				arg_208_1.var_.actorSpriteComps10030 = var_211_6:GetComponentsInChildren(typeof(Image), true)
			end

			local var_211_7 = 0.2

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_7 and not isNil(var_211_6) then
				if arg_208_1.var_.actorSpriteComps10030 then
					for iter_211_1, iter_211_2 in pairs(arg_208_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_211_2 then
							if arg_208_1.isInRecall_ then
								iter_211_2.color = Color.New(Mathf.Lerp(iter_211_2.color.r, arg_208_1.hightColor1.r, (arg_208_1.time_ - 0) / var_211_7), Mathf.Lerp(iter_211_2.color.g, arg_208_1.hightColor1.g, (arg_208_1.time_ - 0) / var_211_7), (Mathf.Lerp(iter_211_2.color.b, arg_208_1.hightColor1.b, (arg_208_1.time_ - 0) / var_211_7)))
							else
								local var_211_8 = Mathf.Lerp(iter_211_2.color.r, 1, (arg_208_1.time_ - 0) / var_211_7)

								iter_211_2.color = Color.New(var_211_8, var_211_8, var_211_8)
							end
						end
					end
				end
			end

			if arg_208_1.time_ >= 0 + var_211_7 and arg_208_1.time_ < 0 + var_211_7 + arg_211_0 and not isNil(var_211_6) and arg_208_1.var_.actorSpriteComps10030 then
				for iter_211_3, iter_211_4 in pairs(arg_208_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_211_4 then
						iter_211_4.color = arg_208_1.isInRecall_ and (arg_208_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_208_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 then
				local var_211_9 = arg_208_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_211_9 then
					arg_208_1.var_.alphaOldValue10030 = var_211_9.alpha
					arg_208_1.var_.characterEffect10030 = var_211_9
				end

				arg_208_1.var_.alphaOldValue10030 = 0
			end

			local var_211_10 = 0.333333333333333

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_10 then
				if arg_208_1.var_.characterEffect10030 then
					arg_208_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_208_1.var_.alphaOldValue10030, 1, (arg_208_1.time_ - 0) / var_211_10)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_10 and arg_208_1.time_ < 0 + var_211_10 + arg_211_0 and arg_208_1.var_.characterEffect10030 then
				arg_208_1.var_.characterEffect10030.alpha = 1
			end

			local var_211_11 = 0
			local var_211_12 = 0.375

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_11 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, false)
				arg_208_1.callingController_:SetSelectedState("normal")

				local var_211_13 = arg_208_1:GetWordFromCfg(115291051)
				local var_211_14 = arg_208_1:FormatText(var_211_13.content)

				arg_208_1.text_.text = var_211_14

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_16 = 15 <= 0 and var_211_12 or var_211_12 * (utf8.len(var_211_14) / 15)

				if (15 <= 0 and var_211_12 or var_211_12 * (utf8.len(var_211_14) / 15)) > 0 and var_211_12 < var_211_16 then
					arg_208_1.talkMaxDuration = var_211_16

					if var_211_16 + var_211_11 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_16 + var_211_11
					end
				end

				arg_208_1.text_.text = var_211_14
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291051", "story_v_out_115291.awb") ~= 0 then
					local var_211_17 = manager.audio:GetVoiceLength("story_v_out_115291", "115291051", "story_v_out_115291.awb") / 1000

					if var_211_17 + var_211_11 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_17 + var_211_11
					end

					if var_211_13.prefab_name ~= "" and arg_208_1.actors_[var_211_13.prefab_name] ~= nil then
						local var_211_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_208_1.actors_[var_211_13.prefab_name].transform, "story_v_out_115291", "115291051", "story_v_out_115291.awb")

						arg_208_1:RecordAudio("115291051", var_211_18)
						arg_208_1:RecordAudio("115291051", var_211_18)
					else
						arg_208_1:AudioAction("play", "voice", "story_v_out_115291", "115291051", "story_v_out_115291.awb")
					end

					arg_208_1:RecordHistoryTalkVoice("story_v_out_115291", "115291051", "story_v_out_115291.awb")
				end

				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_19 = math.max(var_211_12, arg_208_1.talkMaxDuration)

			if var_211_11 <= arg_208_1.time_ and arg_208_1.time_ < var_211_11 + var_211_19 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_11) / var_211_19

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_11 + var_211_19 and arg_208_1.time_ < var_211_11 + var_211_19 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_208_1:InitPlayNodeList()
	end,
	Play115291052 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 115291052
		arg_212_1.duration_ = 3.7

		local var_212_0 = {
			ja = 3.7,
			ko = 2.5,
			zh = 3,
			en = 3.366
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
				arg_212_0:Play115291053(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(arg_212_1.actors_["10029"]) then
				local var_215_0 = arg_212_1.actors_["10029"]:GetComponent("Image")

				if var_215_0 then
					arg_212_1.var_.highlightMatValue10029 = var_215_0
				end
			end

			local var_215_1 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 and not isNil(arg_212_1.actors_["10029"]) then
				if arg_212_1.var_.highlightMatValue10029 then
					local var_215_2 = Mathf.Lerp(0.5, 1, (arg_212_1.time_ - 0) / var_215_1)

					arg_212_1.var_.highlightMatValue10029.color.r = var_215_2
					arg_212_1.var_.highlightMatValue10029.color.g = var_215_2
					arg_212_1.var_.highlightMatValue10029.color.b = var_215_2
					arg_212_1.var_.highlightMatValue10029.color = arg_212_1.var_.highlightMatValue10029.color
				end
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 and not isNil(arg_212_1.actors_["10029"]) and arg_212_1.var_.highlightMatValue10029 then
				arg_212_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_212_1.var_.highlightMatValue10029.color.r = 1
				arg_212_1.var_.highlightMatValue10029.color.g = 1
				arg_212_1.var_.highlightMatValue10029.color.b = 1
				arg_212_1.var_.highlightMatValue10029.color = arg_212_1.var_.highlightMatValue10029.color
			end

			local var_215_3 = arg_212_1.actors_["10030"]

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.actorSpriteComps10030 == nil then
				arg_212_1.var_.actorSpriteComps10030 = var_215_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_215_4 = 0.2

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 and not isNil(var_215_3) then
				if arg_212_1.var_.actorSpriteComps10030 then
					for iter_215_0, iter_215_1 in pairs(arg_212_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_215_1 then
							if arg_212_1.isInRecall_ then
								iter_215_1.color = Color.New(Mathf.Lerp(iter_215_1.color.r, arg_212_1.hightColor2.r, (arg_212_1.time_ - 0) / var_215_4), Mathf.Lerp(iter_215_1.color.g, arg_212_1.hightColor2.g, (arg_212_1.time_ - 0) / var_215_4), (Mathf.Lerp(iter_215_1.color.b, arg_212_1.hightColor2.b, (arg_212_1.time_ - 0) / var_215_4)))
							else
								local var_215_5 = Mathf.Lerp(iter_215_1.color.r, 0.5, (arg_212_1.time_ - 0) / var_215_4)

								iter_215_1.color = Color.New(var_215_5, var_215_5, var_215_5)
							end
						end
					end
				end
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 and not isNil(var_215_3) and arg_212_1.var_.actorSpriteComps10030 then
				for iter_215_2, iter_215_3 in pairs(arg_212_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_215_3 then
						iter_215_3.color = arg_212_1.isInRecall_ and (arg_212_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_212_1.var_.actorSpriteComps10030 = nil
			end

			local var_215_6 = 0
			local var_215_7 = 0.3

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_6 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, true)

				arg_212_1.leftNameTxt_.text = arg_212_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_212_1.leftNameTxt_.transform)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1.leftNameTxt_.text)
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_8 = arg_212_1:GetWordFromCfg(115291052)
				local var_215_9 = arg_212_1:FormatText(var_215_8.content)

				arg_212_1.text_.text = var_215_9

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 12 <= 0 and var_215_7 or var_215_7 * (utf8.len(var_215_9) / 12)

				if (12 <= 0 and var_215_7 or var_215_7 * (utf8.len(var_215_9) / 12)) > 0 and var_215_7 < var_215_11 then
					arg_212_1.talkMaxDuration = var_215_11

					if var_215_11 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_6
					end
				end

				arg_212_1.text_.text = var_215_9
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291052", "story_v_out_115291.awb") ~= 0 then
					local var_215_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291052", "story_v_out_115291.awb") / 1000

					if var_215_12 + var_215_6 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_12 + var_215_6
					end

					if var_215_8.prefab_name ~= "" and arg_212_1.actors_[var_215_8.prefab_name] ~= nil then
						local var_215_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_212_1.actors_[var_215_8.prefab_name].transform, "story_v_out_115291", "115291052", "story_v_out_115291.awb")

						arg_212_1:RecordAudio("115291052", var_215_13)
						arg_212_1:RecordAudio("115291052", var_215_13)
					else
						arg_212_1:AudioAction("play", "voice", "story_v_out_115291", "115291052", "story_v_out_115291.awb")
					end

					arg_212_1:RecordHistoryTalkVoice("story_v_out_115291", "115291052", "story_v_out_115291.awb")
				end

				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_14 = math.max(var_215_7, arg_212_1.talkMaxDuration)

			if var_215_6 <= arg_212_1.time_ and arg_212_1.time_ < var_215_6 + var_215_14 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_6) / var_215_14

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_6 + var_215_14 and arg_212_1.time_ < var_215_6 + var_215_14 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play115291053 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 115291053
		arg_216_1.duration_ = 14.9

		local var_216_0 = {
			ja = 10.866,
			ko = 11.9,
			zh = 10.7,
			en = 14.9
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
				arg_216_0:Play115291054(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 1.05

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, true)

				arg_216_1.leftNameTxt_.text = arg_216_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_216_1.leftNameTxt_.transform)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1.leftNameTxt_.text)
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:GetWordFromCfg(115291053)
				local var_219_2 = arg_216_1:FormatText(var_219_1.content)

				arg_216_1.text_.text = var_219_2

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_4 = 42 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 42)

				if (42 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_2) / 42)) > 0 and var_219_0 < var_219_4 then
					arg_216_1.talkMaxDuration = var_219_4

					if var_219_4 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_4 + 0
					end
				end

				arg_216_1.text_.text = var_219_2
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291053", "story_v_out_115291.awb") ~= 0 then
					local var_219_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291053", "story_v_out_115291.awb") / 1000

					if var_219_5 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_5 + 0
					end

					if var_219_1.prefab_name ~= "" and arg_216_1.actors_[var_219_1.prefab_name] ~= nil then
						local var_219_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_216_1.actors_[var_219_1.prefab_name].transform, "story_v_out_115291", "115291053", "story_v_out_115291.awb")

						arg_216_1:RecordAudio("115291053", var_219_6)
						arg_216_1:RecordAudio("115291053", var_219_6)
					else
						arg_216_1:AudioAction("play", "voice", "story_v_out_115291", "115291053", "story_v_out_115291.awb")
					end

					arg_216_1:RecordHistoryTalkVoice("story_v_out_115291", "115291053", "story_v_out_115291.awb")
				end

				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_7 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_7 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_7

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_7 and arg_216_1.time_ < 0 + var_219_7 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play115291054 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 115291054
		arg_220_1.duration_ = 4.1

		local var_220_0 = {
			ja = 1.266,
			ko = 1.5,
			zh = 4.1,
			en = 1.533
		}
		local var_220_1 = manager.audio:GetLocalizationFlag()

		if var_220_0[var_220_1] ~= nil then
			arg_220_1.duration_ = var_220_0[var_220_1]
		end

		SetActive(arg_220_1.tipsGo_, false)

		function arg_220_1.onSingleLineFinish_()
			arg_220_1.onSingleLineUpdate_ = nil
			arg_220_1.onSingleLineFinish_ = nil
			arg_220_1.state_ = "waiting"
		end

		function arg_220_1.playNext_(arg_222_0)
			if arg_222_0 == 1 then
				arg_220_0:Play115291055(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(arg_220_1.actors_["10029"]) then
				local var_223_0 = arg_220_1.actors_["10029"]:GetComponent("Image")

				if var_223_0 then
					arg_220_1.var_.highlightMatValue10029 = var_223_0
				end
			end

			local var_223_1 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 and not isNil(arg_220_1.actors_["10029"]) then
				if arg_220_1.var_.highlightMatValue10029 then
					local var_223_2 = Mathf.Lerp(1, 0.5, (arg_220_1.time_ - 0) / var_223_1)

					arg_220_1.var_.highlightMatValue10029.color.r = var_223_2
					arg_220_1.var_.highlightMatValue10029.color.g = var_223_2
					arg_220_1.var_.highlightMatValue10029.color.b = var_223_2
					arg_220_1.var_.highlightMatValue10029.color = arg_220_1.var_.highlightMatValue10029.color
				end
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 and not isNil(arg_220_1.actors_["10029"]) and arg_220_1.var_.highlightMatValue10029 then
				arg_220_1.var_.highlightMatValue10029.color.r = 0.5
				arg_220_1.var_.highlightMatValue10029.color.g = 0.5
				arg_220_1.var_.highlightMatValue10029.color.b = 0.5
				arg_220_1.var_.highlightMatValue10029.color = arg_220_1.var_.highlightMatValue10029.color
			end

			local var_223_3 = arg_220_1.actors_["10030"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.actorSpriteComps10030 == nil then
				arg_220_1.var_.actorSpriteComps10030 = var_223_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_223_4 = 0.2

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 and not isNil(var_223_3) then
				if arg_220_1.var_.actorSpriteComps10030 then
					for iter_223_0, iter_223_1 in pairs(arg_220_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_223_1 then
							if arg_220_1.isInRecall_ then
								iter_223_1.color = Color.New(Mathf.Lerp(iter_223_1.color.r, arg_220_1.hightColor1.r, (arg_220_1.time_ - 0) / var_223_4), Mathf.Lerp(iter_223_1.color.g, arg_220_1.hightColor1.g, (arg_220_1.time_ - 0) / var_223_4), (Mathf.Lerp(iter_223_1.color.b, arg_220_1.hightColor1.b, (arg_220_1.time_ - 0) / var_223_4)))
							else
								local var_223_5 = Mathf.Lerp(iter_223_1.color.r, 1, (arg_220_1.time_ - 0) / var_223_4)

								iter_223_1.color = Color.New(var_223_5, var_223_5, var_223_5)
							end
						end
					end
				end
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.actorSpriteComps10030 then
				for iter_223_2, iter_223_3 in pairs(arg_220_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_223_3 then
						iter_223_3.color = arg_220_1.isInRecall_ and (arg_220_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_220_1.var_.actorSpriteComps10030 = nil
			end

			local var_223_6 = 0
			local var_223_7 = 0.15

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_8 = arg_220_1:GetWordFromCfg(115291054)
				local var_223_9 = arg_220_1:FormatText(var_223_8.content)

				arg_220_1.text_.text = var_223_9

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 6 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 6)

				if (6 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 6)) > 0 and var_223_7 < var_223_11 then
					arg_220_1.talkMaxDuration = var_223_11

					if var_223_11 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_9
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291054", "story_v_out_115291.awb") ~= 0 then
					local var_223_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291054", "story_v_out_115291.awb") / 1000

					if var_223_12 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_12 + var_223_6
					end

					if var_223_8.prefab_name ~= "" and arg_220_1.actors_[var_223_8.prefab_name] ~= nil then
						local var_223_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_8.prefab_name].transform, "story_v_out_115291", "115291054", "story_v_out_115291.awb")

						arg_220_1:RecordAudio("115291054", var_223_13)
						arg_220_1:RecordAudio("115291054", var_223_13)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_115291", "115291054", "story_v_out_115291.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_115291", "115291054", "story_v_out_115291.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_14 = math.max(var_223_7, arg_220_1.talkMaxDuration)

			if var_223_6 <= arg_220_1.time_ and arg_220_1.time_ < var_223_6 + var_223_14 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_6) / var_223_14

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_6 + var_223_14 and arg_220_1.time_ < var_223_6 + var_223_14 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {}

		arg_220_1:InitPlayNodeList()
	end,
	Play115291055 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 115291055
		arg_224_1.duration_ = 9.17

		local var_224_0 = {
			ja = 7.766,
			ko = 6.466,
			zh = 7.833,
			en = 9.166
		}
		local var_224_1 = manager.audio:GetLocalizationFlag()

		if var_224_0[var_224_1] ~= nil then
			arg_224_1.duration_ = var_224_0[var_224_1]
		end

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play115291056(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["10029"]) then
				local var_227_0 = arg_224_1.actors_["10029"]:GetComponent("Image")

				if var_227_0 then
					arg_224_1.var_.highlightMatValue10029 = var_227_0
				end
			end

			local var_227_1 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_1 and not isNil(arg_224_1.actors_["10029"]) then
				if arg_224_1.var_.highlightMatValue10029 then
					local var_227_2 = Mathf.Lerp(0.5, 1, (arg_224_1.time_ - 0) / var_227_1)

					arg_224_1.var_.highlightMatValue10029.color.r = var_227_2
					arg_224_1.var_.highlightMatValue10029.color.g = var_227_2
					arg_224_1.var_.highlightMatValue10029.color.b = var_227_2
					arg_224_1.var_.highlightMatValue10029.color = arg_224_1.var_.highlightMatValue10029.color
				end
			end

			if arg_224_1.time_ >= 0 + var_227_1 and arg_224_1.time_ < 0 + var_227_1 + arg_227_0 and not isNil(arg_224_1.actors_["10029"]) and arg_224_1.var_.highlightMatValue10029 then
				arg_224_1.actors_["10029"].transform:SetSiblingIndex(1)

				arg_224_1.var_.highlightMatValue10029.color.r = 1
				arg_224_1.var_.highlightMatValue10029.color.g = 1
				arg_224_1.var_.highlightMatValue10029.color.b = 1
				arg_224_1.var_.highlightMatValue10029.color = arg_224_1.var_.highlightMatValue10029.color
			end

			local var_227_3 = arg_224_1.actors_["10030"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_3) and arg_224_1.var_.actorSpriteComps10030 == nil then
				arg_224_1.var_.actorSpriteComps10030 = var_227_3:GetComponentsInChildren(typeof(Image), true)
			end

			local var_227_4 = 0.2

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 and not isNil(var_227_3) then
				if arg_224_1.var_.actorSpriteComps10030 then
					for iter_227_0, iter_227_1 in pairs(arg_224_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_227_1 then
							if arg_224_1.isInRecall_ then
								iter_227_1.color = Color.New(Mathf.Lerp(iter_227_1.color.r, arg_224_1.hightColor2.r, (arg_224_1.time_ - 0) / var_227_4), Mathf.Lerp(iter_227_1.color.g, arg_224_1.hightColor2.g, (arg_224_1.time_ - 0) / var_227_4), (Mathf.Lerp(iter_227_1.color.b, arg_224_1.hightColor2.b, (arg_224_1.time_ - 0) / var_227_4)))
							else
								local var_227_5 = Mathf.Lerp(iter_227_1.color.r, 0.5, (arg_224_1.time_ - 0) / var_227_4)

								iter_227_1.color = Color.New(var_227_5, var_227_5, var_227_5)
							end
						end
					end
				end
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 and not isNil(var_227_3) and arg_224_1.var_.actorSpriteComps10030 then
				for iter_227_2, iter_227_3 in pairs(arg_224_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_227_3 then
						iter_227_3.color = arg_224_1.isInRecall_ and (arg_224_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_224_1.var_.actorSpriteComps10030 = nil
			end

			local var_227_6 = 0
			local var_227_7 = 0.625

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_6 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_8 = arg_224_1:GetWordFromCfg(115291055)
				local var_227_9 = arg_224_1:FormatText(var_227_8.content)

				arg_224_1.text_.text = var_227_9

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_11 = 24 <= 0 and var_227_7 or var_227_7 * (utf8.len(var_227_9) / 24)

				if (24 <= 0 and var_227_7 or var_227_7 * (utf8.len(var_227_9) / 24)) > 0 and var_227_7 < var_227_11 then
					arg_224_1.talkMaxDuration = var_227_11

					if var_227_11 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_11 + var_227_6
					end
				end

				arg_224_1.text_.text = var_227_9
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291055", "story_v_out_115291.awb") ~= 0 then
					local var_227_12 = manager.audio:GetVoiceLength("story_v_out_115291", "115291055", "story_v_out_115291.awb") / 1000

					if var_227_12 + var_227_6 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_12 + var_227_6
					end

					if var_227_8.prefab_name ~= "" and arg_224_1.actors_[var_227_8.prefab_name] ~= nil then
						local var_227_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_8.prefab_name].transform, "story_v_out_115291", "115291055", "story_v_out_115291.awb")

						arg_224_1:RecordAudio("115291055", var_227_13)
						arg_224_1:RecordAudio("115291055", var_227_13)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_115291", "115291055", "story_v_out_115291.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_115291", "115291055", "story_v_out_115291.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_14 = math.max(var_227_7, arg_224_1.talkMaxDuration)

			if var_227_6 <= arg_224_1.time_ and arg_224_1.time_ < var_227_6 + var_227_14 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_6) / var_227_14

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_6 + var_227_14 and arg_224_1.time_ < var_227_6 + var_227_14 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play115291056 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 115291056
		arg_228_1.duration_ = 17.27

		local var_228_0 = {
			ja = 14.566,
			ko = 12.266,
			zh = 12.5,
			en = 17.266
		}
		local var_228_1 = manager.audio:GetLocalizationFlag()

		if var_228_0[var_228_1] ~= nil then
			arg_228_1.duration_ = var_228_0[var_228_1]
		end

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play115291057(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1.325

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, false)
				arg_228_1.callingController_:SetSelectedState("normal")

				local var_231_1 = arg_228_1:GetWordFromCfg(115291056)
				local var_231_2 = arg_228_1:FormatText(var_231_1.content)

				arg_228_1.text_.text = var_231_2

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_4 = 53 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 53)

				if (53 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_2) / 53)) > 0 and var_231_0 < var_231_4 then
					arg_228_1.talkMaxDuration = var_231_4

					if var_231_4 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_4 + 0
					end
				end

				arg_228_1.text_.text = var_231_2
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291056", "story_v_out_115291.awb") ~= 0 then
					local var_231_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291056", "story_v_out_115291.awb") / 1000

					if var_231_5 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_5 + 0
					end

					if var_231_1.prefab_name ~= "" and arg_228_1.actors_[var_231_1.prefab_name] ~= nil then
						local var_231_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_228_1.actors_[var_231_1.prefab_name].transform, "story_v_out_115291", "115291056", "story_v_out_115291.awb")

						arg_228_1:RecordAudio("115291056", var_231_6)
						arg_228_1:RecordAudio("115291056", var_231_6)
					else
						arg_228_1:AudioAction("play", "voice", "story_v_out_115291", "115291056", "story_v_out_115291.awb")
					end

					arg_228_1:RecordHistoryTalkVoice("story_v_out_115291", "115291056", "story_v_out_115291.awb")
				end

				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_7 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_7 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_7

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_7 and arg_228_1.time_ < 0 + var_231_7 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play115291057 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 115291057
		arg_232_1.duration_ = 12.73

		local var_232_0 = {
			ja = 11.366,
			ko = 6.9,
			zh = 9,
			en = 12.733
		}
		local var_232_1 = manager.audio:GetLocalizationFlag()

		if var_232_0[var_232_1] ~= nil then
			arg_232_1.duration_ = var_232_0[var_232_1]
		end

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play115291058(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.025

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, true)

				arg_232_1.leftNameTxt_.text = arg_232_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_232_1.leftNameTxt_.transform)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1.leftNameTxt_.text)
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:GetWordFromCfg(115291057)
				local var_235_2 = arg_232_1:FormatText(var_235_1.content)

				arg_232_1.text_.text = var_235_2

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_4 = 42 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 42)

				if (42 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_2) / 42)) > 0 and var_235_0 < var_235_4 then
					arg_232_1.talkMaxDuration = var_235_4

					if var_235_4 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_4 + 0
					end
				end

				arg_232_1.text_.text = var_235_2
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291057", "story_v_out_115291.awb") ~= 0 then
					local var_235_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291057", "story_v_out_115291.awb") / 1000

					if var_235_5 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_5 + 0
					end

					if var_235_1.prefab_name ~= "" and arg_232_1.actors_[var_235_1.prefab_name] ~= nil then
						local var_235_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_232_1.actors_[var_235_1.prefab_name].transform, "story_v_out_115291", "115291057", "story_v_out_115291.awb")

						arg_232_1:RecordAudio("115291057", var_235_6)
						arg_232_1:RecordAudio("115291057", var_235_6)
					else
						arg_232_1:AudioAction("play", "voice", "story_v_out_115291", "115291057", "story_v_out_115291.awb")
					end

					arg_232_1:RecordHistoryTalkVoice("story_v_out_115291", "115291057", "story_v_out_115291.awb")
				end

				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_7 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_7 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_7

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_7 and arg_232_1.time_ < 0 + var_235_7 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play115291058 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 115291058
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play115291059(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				local var_239_0 = arg_236_1.actors_["10029"]:GetComponent("Image")

				if var_239_0 then
					arg_236_1.var_.alphaMatValue10029 = var_239_0
					arg_236_1.var_.alphaOldValue10029 = var_239_0.color.a
				end

				arg_236_1.var_.alphaOldValue10029 = 1
			end

			local var_239_1 = 0.333333333333333

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_1 then
				if arg_236_1.var_.alphaMatValue10029 then
					arg_236_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_236_1.var_.alphaOldValue10029, 0, (arg_236_1.time_ - 0) / var_239_1)
					arg_236_1.var_.alphaMatValue10029.color = arg_236_1.var_.alphaMatValue10029.color
				end
			end

			if arg_236_1.time_ >= 0 + var_239_1 and arg_236_1.time_ < 0 + var_239_1 + arg_239_0 and arg_236_1.var_.alphaMatValue10029 then
				arg_236_1.var_.alphaMatValue10029.color.a = 0
				arg_236_1.var_.alphaMatValue10029.color = arg_236_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				local var_239_2 = arg_236_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_239_2 then
					arg_236_1.var_.alphaOldValue10030 = var_239_2.alpha
					arg_236_1.var_.characterEffect10030 = var_239_2
				end

				arg_236_1.var_.alphaOldValue10030 = 1
			end

			local var_239_3 = 0.333333333333333

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_3 then
				if arg_236_1.var_.characterEffect10030 then
					arg_236_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_236_1.var_.alphaOldValue10030, 0, (arg_236_1.time_ - 0) / var_239_3)
				end
			end

			if arg_236_1.time_ >= 0 + var_239_3 and arg_236_1.time_ < 0 + var_239_3 + arg_239_0 and arg_236_1.var_.characterEffect10030 then
				arg_236_1.var_.characterEffect10030.alpha = 0
			end

			local var_239_4 = 0
			local var_239_5 = 0.725

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= var_239_4 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, false)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_236_1.iconTrs_.gameObject, false)
				arg_236_1.callingController_:SetSelectedState("normal")

				local var_239_6 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(115291058).content)

				arg_236_1.text_.text = var_239_6

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_8 = 29 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_6) / 29)

				if (29 <= 0 and var_239_5 or var_239_5 * (utf8.len(var_239_6) / 29)) > 0 and var_239_5 < var_239_8 then
					arg_236_1.talkMaxDuration = var_239_8

					if var_239_8 + var_239_4 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_8 + var_239_4
					end
				end

				arg_236_1.text_.text = var_239_6
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_9 = math.max(var_239_5, arg_236_1.talkMaxDuration)

			if var_239_4 <= arg_236_1.time_ and arg_236_1.time_ < var_239_4 + var_239_9 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - var_239_4) / var_239_9

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= var_239_4 + var_239_9 and arg_236_1.time_ < var_239_4 + var_239_9 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play115291059 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 115291059
		arg_240_1.duration_ = 7.5

		local var_240_0 = {
			ja = 7.5,
			ko = 6.366,
			zh = 7,
			en = 6.2
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
				arg_240_0:Play115291060(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1.var_.moveOldPos10030 = arg_240_1.actors_["10030"].transform.localPosition
				arg_240_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_240_1:CheckSpriteTmpPos("10030", 4)

				for iter_243_0 = 0, arg_240_1.actors_["10030"].transform.childCount - 1 do
					local var_243_0 = arg_240_1.actors_["10030"].transform:GetChild(iter_243_0)

					if var_243_0.name == "split_3" or not string.find(var_243_0.name, "split") then
						var_243_0.gameObject:SetActive(true)
					else
						var_243_0.gameObject:SetActive(false)
					end
				end
			end

			local var_243_1 = 0.001

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_1 then
				arg_240_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_240_1.var_.moveOldPos10030, Vector3.New(390, -390, 150), (arg_240_1.time_ - 0) / var_243_1)
			end

			if arg_240_1.time_ >= 0 + var_243_1 and arg_240_1.time_ < 0 + var_243_1 + arg_243_0 then
				arg_240_1.actors_["10030"].transform.localPosition = Vector3.New(390, -390, 150)
			end

			local var_243_2 = arg_240_1.actors_["10030"]

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10030 == nil then
				arg_240_1.var_.actorSpriteComps10030 = var_243_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_243_3 = 0.2

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_3 and not isNil(var_243_2) then
				if arg_240_1.var_.actorSpriteComps10030 then
					for iter_243_1, iter_243_2 in pairs(arg_240_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_243_2 then
							if arg_240_1.isInRecall_ then
								iter_243_2.color = Color.New(Mathf.Lerp(iter_243_2.color.r, arg_240_1.hightColor1.r, (arg_240_1.time_ - 0) / var_243_3), Mathf.Lerp(iter_243_2.color.g, arg_240_1.hightColor1.g, (arg_240_1.time_ - 0) / var_243_3), (Mathf.Lerp(iter_243_2.color.b, arg_240_1.hightColor1.b, (arg_240_1.time_ - 0) / var_243_3)))
							else
								local var_243_4 = Mathf.Lerp(iter_243_2.color.r, 1, (arg_240_1.time_ - 0) / var_243_3)

								iter_243_2.color = Color.New(var_243_4, var_243_4, var_243_4)
							end
						end
					end
				end
			end

			if arg_240_1.time_ >= 0 + var_243_3 and arg_240_1.time_ < 0 + var_243_3 + arg_243_0 and not isNil(var_243_2) and arg_240_1.var_.actorSpriteComps10030 then
				for iter_243_3, iter_243_4 in pairs(arg_240_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_243_4 then
						iter_243_4.color = arg_240_1.isInRecall_ and (arg_240_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_240_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				local var_243_5 = arg_240_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_243_5 then
					arg_240_1.var_.alphaOldValue10030 = var_243_5.alpha
					arg_240_1.var_.characterEffect10030 = var_243_5
				end

				arg_240_1.var_.alphaOldValue10030 = 0
			end

			local var_243_6 = 0.333333333333333

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_6 then
				if arg_240_1.var_.characterEffect10030 then
					arg_240_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_240_1.var_.alphaOldValue10030, 1, (arg_240_1.time_ - 0) / var_243_6)
				end
			end

			if arg_240_1.time_ >= 0 + var_243_6 and arg_240_1.time_ < 0 + var_243_6 + arg_243_0 and arg_240_1.var_.characterEffect10030 then
				arg_240_1.var_.characterEffect10030.alpha = 1
			end

			local var_243_7 = 0
			local var_243_8 = 0.925

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_7 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_9 = arg_240_1:GetWordFromCfg(115291059)
				local var_243_10 = arg_240_1:FormatText(var_243_9.content)

				arg_240_1.text_.text = var_243_10

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_12 = 36 <= 0 and var_243_8 or var_243_8 * (utf8.len(var_243_10) / 36)

				if (36 <= 0 and var_243_8 or var_243_8 * (utf8.len(var_243_10) / 36)) > 0 and var_243_8 < var_243_12 then
					arg_240_1.talkMaxDuration = var_243_12

					if var_243_12 + var_243_7 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_12 + var_243_7
					end
				end

				arg_240_1.text_.text = var_243_10
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291059", "story_v_out_115291.awb") ~= 0 then
					local var_243_13 = manager.audio:GetVoiceLength("story_v_out_115291", "115291059", "story_v_out_115291.awb") / 1000

					if var_243_13 + var_243_7 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_13 + var_243_7
					end

					if var_243_9.prefab_name ~= "" and arg_240_1.actors_[var_243_9.prefab_name] ~= nil then
						local var_243_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_9.prefab_name].transform, "story_v_out_115291", "115291059", "story_v_out_115291.awb")

						arg_240_1:RecordAudio("115291059", var_243_14)
						arg_240_1:RecordAudio("115291059", var_243_14)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_115291", "115291059", "story_v_out_115291.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_115291", "115291059", "story_v_out_115291.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_15 = math.max(var_243_8, arg_240_1.talkMaxDuration)

			if var_243_7 <= arg_240_1.time_ and arg_240_1.time_ < var_243_7 + var_243_15 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_7) / var_243_15

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_7 + var_243_15 and arg_240_1.time_ < var_243_7 + var_243_15 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_240_1:InitPlayNodeList()
	end,
	Play115291060 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 115291060
		arg_244_1.duration_ = 2.9

		local var_244_0 = {
			ja = 1.966,
			ko = 2,
			zh = 1.766,
			en = 2.9
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
				arg_244_0:Play115291061(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.moveOldPos10029 = arg_244_1.actors_["10029"].transform.localPosition
				arg_244_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_244_1:CheckSpriteTmpPos("10029", 2)
			end

			local var_247_0 = 0.001

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 then
				arg_244_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_244_1.var_.moveOldPos10029, Vector3.New(-390, -350, -180), (arg_244_1.time_ - 0) / var_247_0)
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 then
				arg_244_1.actors_["10029"].transform.localPosition = Vector3.New(-390, -350, -180)
			end

			local var_247_1 = arg_244_1.actors_["10030"]

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.actorSpriteComps10030 == nil then
				arg_244_1.var_.actorSpriteComps10030 = var_247_1:GetComponentsInChildren(typeof(Image), true)
			end

			local var_247_2 = 0.2

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_2 and not isNil(var_247_1) then
				if arg_244_1.var_.actorSpriteComps10030 then
					for iter_247_0, iter_247_1 in pairs(arg_244_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_247_1 then
							if arg_244_1.isInRecall_ then
								iter_247_1.color = Color.New(Mathf.Lerp(iter_247_1.color.r, arg_244_1.hightColor2.r, (arg_244_1.time_ - 0) / var_247_2), Mathf.Lerp(iter_247_1.color.g, arg_244_1.hightColor2.g, (arg_244_1.time_ - 0) / var_247_2), (Mathf.Lerp(iter_247_1.color.b, arg_244_1.hightColor2.b, (arg_244_1.time_ - 0) / var_247_2)))
							else
								local var_247_3 = Mathf.Lerp(iter_247_1.color.r, 0.5, (arg_244_1.time_ - 0) / var_247_2)

								iter_247_1.color = Color.New(var_247_3, var_247_3, var_247_3)
							end
						end
					end
				end
			end

			if arg_244_1.time_ >= 0 + var_247_2 and arg_244_1.time_ < 0 + var_247_2 + arg_247_0 and not isNil(var_247_1) and arg_244_1.var_.actorSpriteComps10030 then
				for iter_247_2, iter_247_3 in pairs(arg_244_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_247_3 then
						iter_247_3.color = arg_244_1.isInRecall_ and (arg_244_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_244_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				local var_247_4 = arg_244_1.actors_["10029"]:GetComponent("Image")

				if var_247_4 then
					arg_244_1.var_.alphaMatValue10029 = var_247_4
					arg_244_1.var_.alphaOldValue10029 = var_247_4.color.a
				end

				arg_244_1.var_.alphaOldValue10029 = 0
			end

			local var_247_5 = 0.333333333333333

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_5 then
				if arg_244_1.var_.alphaMatValue10029 then
					arg_244_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_244_1.var_.alphaOldValue10029, 1, (arg_244_1.time_ - 0) / var_247_5)
					arg_244_1.var_.alphaMatValue10029.color = arg_244_1.var_.alphaMatValue10029.color
				end
			end

			if arg_244_1.time_ >= 0 + var_247_5 and arg_244_1.time_ < 0 + var_247_5 + arg_247_0 and arg_244_1.var_.alphaMatValue10029 then
				arg_244_1.var_.alphaMatValue10029.color.a = 1
				arg_244_1.var_.alphaMatValue10029.color = arg_244_1.var_.alphaMatValue10029.color
			end

			local var_247_6 = manager.ui.mainCamera.transform

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 then
				arg_244_1.var_.shakeOldPos = var_247_6.localPosition
			end

			local var_247_7 = 0.15

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_7 then
				local var_247_8, var_247_9 = math.modf((arg_244_1.time_ - 0) / 0.066)

				var_247_6.localPosition = Vector3.New(var_247_9 * 0.13, var_247_9 * 0.13, var_247_9 * 0.13) + arg_244_1.var_.shakeOldPos
			end

			if arg_244_1.time_ >= 0 + var_247_7 and arg_244_1.time_ < 0 + var_247_7 + arg_247_0 then
				var_247_6.localPosition = arg_244_1.var_.shakeOldPos
			end

			local var_247_10 = 0
			local var_247_11 = 0.15

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_10 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, false)
				arg_244_1.callingController_:SetSelectedState("normal")

				local var_247_12 = arg_244_1:GetWordFromCfg(115291060)
				local var_247_13 = arg_244_1:FormatText(var_247_12.content)

				arg_244_1.text_.text = var_247_13

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_15 = 6 <= 0 and var_247_11 or var_247_11 * (utf8.len(var_247_13) / 6)

				if (6 <= 0 and var_247_11 or var_247_11 * (utf8.len(var_247_13) / 6)) > 0 and var_247_11 < var_247_15 then
					arg_244_1.talkMaxDuration = var_247_15

					if var_247_15 + var_247_10 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_15 + var_247_10
					end
				end

				arg_244_1.text_.text = var_247_13
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291060", "story_v_out_115291.awb") ~= 0 then
					local var_247_16 = manager.audio:GetVoiceLength("story_v_out_115291", "115291060", "story_v_out_115291.awb") / 1000

					if var_247_16 + var_247_10 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_16 + var_247_10
					end

					if var_247_12.prefab_name ~= "" and arg_244_1.actors_[var_247_12.prefab_name] ~= nil then
						local var_247_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_244_1.actors_[var_247_12.prefab_name].transform, "story_v_out_115291", "115291060", "story_v_out_115291.awb")

						arg_244_1:RecordAudio("115291060", var_247_17)
						arg_244_1:RecordAudio("115291060", var_247_17)
					else
						arg_244_1:AudioAction("play", "voice", "story_v_out_115291", "115291060", "story_v_out_115291.awb")
					end

					arg_244_1:RecordHistoryTalkVoice("story_v_out_115291", "115291060", "story_v_out_115291.awb")
				end

				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_18 = math.max(var_247_11, arg_244_1.talkMaxDuration)

			if var_247_10 <= arg_244_1.time_ and arg_244_1.time_ < var_247_10 + var_247_18 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_10) / var_247_18

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_10 + var_247_18 and arg_244_1.time_ < var_247_10 + var_247_18 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_244_1:InitPlayNodeList()
	end,
	Play115291061 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 115291061
		arg_248_1.duration_ = 5

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play115291062(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				local var_251_0 = arg_248_1.actors_["10029"]:GetComponent("Image")

				if var_251_0 then
					arg_248_1.var_.alphaMatValue10029 = var_251_0
					arg_248_1.var_.alphaOldValue10029 = var_251_0.color.a
				end

				arg_248_1.var_.alphaOldValue10029 = 1
			end

			local var_251_1 = 0.333333333333333

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				if arg_248_1.var_.alphaMatValue10029 then
					arg_248_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_248_1.var_.alphaOldValue10029, 0, (arg_248_1.time_ - 0) / var_251_1)
					arg_248_1.var_.alphaMatValue10029.color = arg_248_1.var_.alphaMatValue10029.color
				end
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 and arg_248_1.var_.alphaMatValue10029 then
				arg_248_1.var_.alphaMatValue10029.color.a = 0
				arg_248_1.var_.alphaMatValue10029.color = arg_248_1.var_.alphaMatValue10029.color
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				local var_251_2 = arg_248_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_251_2 then
					arg_248_1.var_.alphaOldValue10030 = var_251_2.alpha
					arg_248_1.var_.characterEffect10030 = var_251_2
				end

				arg_248_1.var_.alphaOldValue10030 = 1
			end

			local var_251_3 = 0.333333333333333

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_3 then
				if arg_248_1.var_.characterEffect10030 then
					arg_248_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_248_1.var_.alphaOldValue10030, 0, (arg_248_1.time_ - 0) / var_251_3)
				end
			end

			if arg_248_1.time_ >= 0 + var_251_3 and arg_248_1.time_ < 0 + var_251_3 + arg_251_0 and arg_248_1.var_.characterEffect10030 then
				arg_248_1.var_.characterEffect10030.alpha = 0
			end

			local var_251_4 = 0
			local var_251_5 = 0.625

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_4 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, false)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_6 = arg_248_1:FormatText(arg_248_1:GetWordFromCfg(115291061).content)

				arg_248_1.text_.text = var_251_6

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_8 = 25 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_6) / 25)

				if (25 <= 0 and var_251_5 or var_251_5 * (utf8.len(var_251_6) / 25)) > 0 and var_251_5 < var_251_8 then
					arg_248_1.talkMaxDuration = var_251_8

					if var_251_8 + var_251_4 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_8 + var_251_4
					end
				end

				arg_248_1.text_.text = var_251_6
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)
				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_9 = math.max(var_251_5, arg_248_1.talkMaxDuration)

			if var_251_4 <= arg_248_1.time_ and arg_248_1.time_ < var_251_4 + var_251_9 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_4) / var_251_9

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_4 + var_251_9 and arg_248_1.time_ < var_251_4 + var_251_9 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {}

		arg_248_1:InitPlayNodeList()
	end,
	Play115291062 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 115291062
		arg_252_1.duration_ = 15.73

		local var_252_0 = {
			ja = 15,
			ko = 8.7,
			zh = 8.5,
			en = 15.733
		}
		local var_252_1 = manager.audio:GetLocalizationFlag()

		if var_252_0[var_252_1] ~= nil then
			arg_252_1.duration_ = var_252_0[var_252_1]
		end

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play115291063(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos10029 = arg_252_1.actors_["10029"].transform.localPosition
				arg_252_1.actors_["10029"].transform.localScale = Vector3.New(1, 1, 1)

				arg_252_1:CheckSpriteTmpPos("10029", 3)
			end

			local var_255_0 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_0 then
				arg_252_1.actors_["10029"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos10029, Vector3.New(0, -350, -180), (arg_252_1.time_ - 0) / var_255_0)
			end

			if arg_252_1.time_ >= 0 + var_255_0 and arg_252_1.time_ < 0 + var_255_0 + arg_255_0 then
				arg_252_1.actors_["10029"].transform.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				local var_255_1 = arg_252_1.actors_["10029"]:GetComponent("Image")

				if var_255_1 then
					arg_252_1.var_.alphaMatValue10029 = var_255_1
					arg_252_1.var_.alphaOldValue10029 = var_255_1.color.a
				end

				arg_252_1.var_.alphaOldValue10029 = 0
			end

			local var_255_2 = 0.333333333333333

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_2 then
				if arg_252_1.var_.alphaMatValue10029 then
					arg_252_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_252_1.var_.alphaOldValue10029, 1, (arg_252_1.time_ - 0) / var_255_2)
					arg_252_1.var_.alphaMatValue10029.color = arg_252_1.var_.alphaMatValue10029.color
				end
			end

			if arg_252_1.time_ >= 0 + var_255_2 and arg_252_1.time_ < 0 + var_255_2 + arg_255_0 and arg_252_1.var_.alphaMatValue10029 then
				arg_252_1.var_.alphaMatValue10029.color.a = 1
				arg_252_1.var_.alphaMatValue10029.color = arg_252_1.var_.alphaMatValue10029.color
			end

			local var_255_3 = 0
			local var_255_4 = 1.075

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_3 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, true)

				arg_252_1.leftNameTxt_.text = arg_252_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_252_1.leftNameTxt_.transform)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1.leftNameTxt_.text)
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_5 = arg_252_1:GetWordFromCfg(115291062)
				local var_255_6 = arg_252_1:FormatText(var_255_5.content)

				arg_252_1.text_.text = var_255_6

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_8 = 43 <= 0 and var_255_4 or var_255_4 * (utf8.len(var_255_6) / 43)

				if (43 <= 0 and var_255_4 or var_255_4 * (utf8.len(var_255_6) / 43)) > 0 and var_255_4 < var_255_8 then
					arg_252_1.talkMaxDuration = var_255_8

					if var_255_8 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_8 + var_255_3
					end
				end

				arg_252_1.text_.text = var_255_6
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291062", "story_v_out_115291.awb") ~= 0 then
					local var_255_9 = manager.audio:GetVoiceLength("story_v_out_115291", "115291062", "story_v_out_115291.awb") / 1000

					if var_255_9 + var_255_3 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_9 + var_255_3
					end

					if var_255_5.prefab_name ~= "" and arg_252_1.actors_[var_255_5.prefab_name] ~= nil then
						local var_255_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_252_1.actors_[var_255_5.prefab_name].transform, "story_v_out_115291", "115291062", "story_v_out_115291.awb")

						arg_252_1:RecordAudio("115291062", var_255_10)
						arg_252_1:RecordAudio("115291062", var_255_10)
					else
						arg_252_1:AudioAction("play", "voice", "story_v_out_115291", "115291062", "story_v_out_115291.awb")
					end

					arg_252_1:RecordHistoryTalkVoice("story_v_out_115291", "115291062", "story_v_out_115291.awb")
				end

				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_11 = math.max(var_255_4, arg_252_1.talkMaxDuration)

			if var_255_3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_3 + var_255_11 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_3) / var_255_11

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_3 + var_255_11 and arg_252_1.time_ < var_255_3 + var_255_11 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10029",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Sprite
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play115291063 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 115291063
		arg_256_1.duration_ = 16.67

		local var_256_0 = {
			ja = 12.933,
			ko = 14.366,
			zh = 10.633,
			en = 16.666
		}
		local var_256_1 = manager.audio:GetLocalizationFlag()

		if var_256_0[var_256_1] ~= nil then
			arg_256_1.duration_ = var_256_0[var_256_1]
		end

		SetActive(arg_256_1.tipsGo_, false)

		function arg_256_1.onSingleLineFinish_()
			arg_256_1.onSingleLineUpdate_ = nil
			arg_256_1.onSingleLineFinish_ = nil
			arg_256_1.state_ = "waiting"
		end

		function arg_256_1.playNext_(arg_258_0)
			if arg_258_0 == 1 then
				arg_256_0:Play115291064(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			local var_259_0 = 1.225

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_1 = arg_256_1:GetWordFromCfg(115291063)
				local var_259_2 = arg_256_1:FormatText(var_259_1.content)

				arg_256_1.text_.text = var_259_2

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_4 = 49 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 49)

				if (49 <= 0 and var_259_0 or var_259_0 * (utf8.len(var_259_2) / 49)) > 0 and var_259_0 < var_259_4 then
					arg_256_1.talkMaxDuration = var_259_4

					if var_259_4 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_4 + 0
					end
				end

				arg_256_1.text_.text = var_259_2
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291063", "story_v_out_115291.awb") ~= 0 then
					local var_259_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291063", "story_v_out_115291.awb") / 1000

					if var_259_5 + 0 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_5 + 0
					end

					if var_259_1.prefab_name ~= "" and arg_256_1.actors_[var_259_1.prefab_name] ~= nil then
						local var_259_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_1.prefab_name].transform, "story_v_out_115291", "115291063", "story_v_out_115291.awb")

						arg_256_1:RecordAudio("115291063", var_259_6)
						arg_256_1:RecordAudio("115291063", var_259_6)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_115291", "115291063", "story_v_out_115291.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_115291", "115291063", "story_v_out_115291.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_7 = math.max(var_259_0, arg_256_1.talkMaxDuration)

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_7 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - 0) / var_259_7

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= 0 + var_259_7 and arg_256_1.time_ < 0 + var_259_7 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {}

		arg_256_1:InitPlayNodeList()
	end,
	Play115291064 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 115291064
		arg_260_1.duration_ = 13.57

		local var_260_0 = {
			ja = 11.2,
			ko = 7.433,
			zh = 8.9,
			en = 13.566
		}
		local var_260_1 = manager.audio:GetLocalizationFlag()

		if var_260_0[var_260_1] ~= nil then
			arg_260_1.duration_ = var_260_0[var_260_1]
		end

		SetActive(arg_260_1.tipsGo_, false)

		function arg_260_1.onSingleLineFinish_()
			arg_260_1.onSingleLineUpdate_ = nil
			arg_260_1.onSingleLineFinish_ = nil
			arg_260_1.state_ = "waiting"
		end

		function arg_260_1.playNext_(arg_262_0)
			if arg_262_0 == 1 then
				arg_260_0:Play115291065(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			local var_263_0 = 1.05

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_1 = arg_260_1:GetWordFromCfg(115291064)
				local var_263_2 = arg_260_1:FormatText(var_263_1.content)

				arg_260_1.text_.text = var_263_2

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_4 = 42 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 42)

				if (42 <= 0 and var_263_0 or var_263_0 * (utf8.len(var_263_2) / 42)) > 0 and var_263_0 < var_263_4 then
					arg_260_1.talkMaxDuration = var_263_4

					if var_263_4 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_4 + 0
					end
				end

				arg_260_1.text_.text = var_263_2
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291064", "story_v_out_115291.awb") ~= 0 then
					local var_263_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291064", "story_v_out_115291.awb") / 1000

					if var_263_5 + 0 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_5 + 0
					end

					if var_263_1.prefab_name ~= "" and arg_260_1.actors_[var_263_1.prefab_name] ~= nil then
						local var_263_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_1.prefab_name].transform, "story_v_out_115291", "115291064", "story_v_out_115291.awb")

						arg_260_1:RecordAudio("115291064", var_263_6)
						arg_260_1:RecordAudio("115291064", var_263_6)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_115291", "115291064", "story_v_out_115291.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_115291", "115291064", "story_v_out_115291.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_7 = math.max(var_263_0, arg_260_1.talkMaxDuration)

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_7 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - 0) / var_263_7

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= 0 + var_263_7 and arg_260_1.time_ < 0 + var_263_7 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {}

		arg_260_1:InitPlayNodeList()
	end,
	Play115291065 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 115291065
		arg_264_1.duration_ = 4.5

		local var_264_0 = {
			ja = 4.5,
			ko = 4,
			zh = 3.033,
			en = 4.3
		}
		local var_264_1 = manager.audio:GetLocalizationFlag()

		if var_264_0[var_264_1] ~= nil then
			arg_264_1.duration_ = var_264_0[var_264_1]
		end

		SetActive(arg_264_1.tipsGo_, false)

		function arg_264_1.onSingleLineFinish_()
			arg_264_1.onSingleLineUpdate_ = nil
			arg_264_1.onSingleLineFinish_ = nil
			arg_264_1.state_ = "waiting"
		end

		function arg_264_1.playNext_(arg_266_0)
			if arg_266_0 == 1 then
				arg_264_0:Play115291066(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			local var_267_0 = 0.2

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[312].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_1 = arg_264_1:GetWordFromCfg(115291065)
				local var_267_2 = arg_264_1:FormatText(var_267_1.content)

				arg_264_1.text_.text = var_267_2

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_4 = 8 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 8)

				if (8 <= 0 and var_267_0 or var_267_0 * (utf8.len(var_267_2) / 8)) > 0 and var_267_0 < var_267_4 then
					arg_264_1.talkMaxDuration = var_267_4

					if var_267_4 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_4 + 0
					end
				end

				arg_264_1.text_.text = var_267_2
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291065", "story_v_out_115291.awb") ~= 0 then
					local var_267_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291065", "story_v_out_115291.awb") / 1000

					if var_267_5 + 0 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_5 + 0
					end

					if var_267_1.prefab_name ~= "" and arg_264_1.actors_[var_267_1.prefab_name] ~= nil then
						local var_267_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_1.prefab_name].transform, "story_v_out_115291", "115291065", "story_v_out_115291.awb")

						arg_264_1:RecordAudio("115291065", var_267_6)
						arg_264_1:RecordAudio("115291065", var_267_6)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_115291", "115291065", "story_v_out_115291.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_115291", "115291065", "story_v_out_115291.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_7 = math.max(var_267_0, arg_264_1.talkMaxDuration)

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_7 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - 0) / var_267_7

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= 0 + var_267_7 and arg_264_1.time_ < 0 + var_267_7 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play115291066 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 115291066
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play115291067(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_door", "")
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1:AudioAction("play", "effect", "se_story_activity_1_5_3", "se_story_activity_1_5_3_rain_loop", "")
			end

			local var_271_2 = manager.ui.mainCamera.transform

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				arg_268_1.var_.shakeOldPos = var_271_2.localPosition
			end

			local var_271_3 = 1

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_3 then
				local var_271_4, var_271_5 = math.modf((arg_268_1.time_ - 0) / 0.066)

				var_271_2.localPosition = Vector3.New(var_271_5 * 0.13, var_271_5 * 0.13, var_271_5 * 0.13) + arg_268_1.var_.shakeOldPos
			end

			if arg_268_1.time_ >= 0 + var_271_3 and arg_268_1.time_ < 0 + var_271_3 + arg_271_0 then
				var_271_2.localPosition = arg_268_1.var_.shakeOldPos
			end

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 then
				local var_271_6 = arg_268_1.actors_["10029"]:GetComponent("Image")

				if var_271_6 then
					arg_268_1.var_.alphaMatValue10029 = var_271_6
					arg_268_1.var_.alphaOldValue10029 = var_271_6.color.a
				end

				arg_268_1.var_.alphaOldValue10029 = 1
			end

			local var_271_7 = 0.333333333333333

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_7 then
				if arg_268_1.var_.alphaMatValue10029 then
					arg_268_1.var_.alphaMatValue10029.color.a = Mathf.Lerp(arg_268_1.var_.alphaOldValue10029, 0, (arg_268_1.time_ - 0) / var_271_7)
					arg_268_1.var_.alphaMatValue10029.color = arg_268_1.var_.alphaMatValue10029.color
				end
			end

			if arg_268_1.time_ >= 0 + var_271_7 and arg_268_1.time_ < 0 + var_271_7 + arg_271_0 and arg_268_1.var_.alphaMatValue10029 then
				arg_268_1.var_.alphaMatValue10029.color.a = 0
				arg_268_1.var_.alphaMatValue10029.color = arg_268_1.var_.alphaMatValue10029.color
			end

			local var_271_8 = 0
			local var_271_9 = 1.275

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_8 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, false)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_268_1.iconTrs_.gameObject, false)
				arg_268_1.callingController_:SetSelectedState("normal")

				local var_271_10 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(115291066).content)

				arg_268_1.text_.text = var_271_10

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_12 = 51 <= 0 and var_271_9 or var_271_9 * (utf8.len(var_271_10) / 51)

				if (51 <= 0 and var_271_9 or var_271_9 * (utf8.len(var_271_10) / 51)) > 0 and var_271_9 < var_271_12 then
					arg_268_1.talkMaxDuration = var_271_12

					if var_271_12 + var_271_8 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_12 + var_271_8
					end
				end

				arg_268_1.text_.text = var_271_10
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_13 = math.max(var_271_9, arg_268_1.talkMaxDuration)

			if var_271_8 <= arg_268_1.time_ and arg_268_1.time_ < var_271_8 + var_271_13 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_8) / var_271_13

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_8 + var_271_13 and arg_268_1.time_ < var_271_8 + var_271_13 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play115291067 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 115291067
		arg_272_1.duration_ = 5

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play115291068(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			local var_275_0 = 0.575

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, false)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_1 = arg_272_1:FormatText(arg_272_1:GetWordFromCfg(115291067).content)

				arg_272_1.text_.text = var_275_1

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_3 = 23 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 23)

				if (23 <= 0 and var_275_0 or var_275_0 * (utf8.len(var_275_1) / 23)) > 0 and var_275_0 < var_275_3 then
					arg_272_1.talkMaxDuration = var_275_3

					if var_275_3 + 0 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_3 + 0
					end
				end

				arg_272_1.text_.text = var_275_1
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)
				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_4 = math.max(var_275_0, arg_272_1.talkMaxDuration)

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_4 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - 0) / var_275_4

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= 0 + var_275_4 and arg_272_1.time_ < 0 + var_275_4 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play115291068 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 115291068
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
		end

		function arg_276_1.playNext_(arg_278_0)
			if arg_278_0 == 1 then
				arg_276_0:Play115291069(arg_276_1)
			end
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			local var_279_0 = 0.8

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, false)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_276_1.iconTrs_.gameObject, false)
				arg_276_1.callingController_:SetSelectedState("normal")

				local var_279_1 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(115291068).content)

				arg_276_1.text_.text = var_279_1

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_3 = 32 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 32)

				if (32 <= 0 and var_279_0 or var_279_0 * (utf8.len(var_279_1) / 32)) > 0 and var_279_0 < var_279_3 then
					arg_276_1.talkMaxDuration = var_279_3

					if var_279_3 + 0 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_3 + 0
					end
				end

				arg_276_1.text_.text = var_279_1
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_4 = math.max(var_279_0, arg_276_1.talkMaxDuration)

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_4 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - 0) / var_279_4

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= 0 + var_279_4 and arg_276_1.time_ < 0 + var_279_4 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	Play115291069 = function(arg_280_0, arg_280_1)
		arg_280_1.time_ = 0
		arg_280_1.frameCnt_ = 0
		arg_280_1.state_ = "playing"
		arg_280_1.curTalkId_ = 115291069
		arg_280_1.duration_ = 6.4

		local var_280_0 = {
			ja = 6.4,
			ko = 3.6,
			zh = 4.6,
			en = 4.033
		}
		local var_280_1 = manager.audio:GetLocalizationFlag()

		if var_280_0[var_280_1] ~= nil then
			arg_280_1.duration_ = var_280_0[var_280_1]
		end

		SetActive(arg_280_1.tipsGo_, false)

		function arg_280_1.onSingleLineFinish_()
			arg_280_1.onSingleLineUpdate_ = nil
			arg_280_1.onSingleLineFinish_ = nil
			arg_280_1.state_ = "waiting"
		end

		function arg_280_1.playNext_(arg_282_0)
			if arg_282_0 == 1 then
				arg_280_0:Play115291070(arg_280_1)
			end
		end

		function arg_280_1.onSingleLineUpdate_(arg_283_0)
			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				arg_280_1.var_.moveOldPos10030 = arg_280_1.actors_["10030"].transform.localPosition
				arg_280_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_280_1:CheckSpriteTmpPos("10030", 3)

				for iter_283_0 = 0, arg_280_1.actors_["10030"].transform.childCount - 1 do
					local var_283_0 = arg_280_1.actors_["10030"].transform:GetChild(iter_283_0)

					if var_283_0.name == "split_3" or not string.find(var_283_0.name, "split") then
						var_283_0.gameObject:SetActive(true)
					else
						var_283_0.gameObject:SetActive(false)
					end
				end
			end

			local var_283_1 = 0.001

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_1 then
				arg_280_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_280_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_280_1.time_ - 0) / var_283_1)
			end

			if arg_280_1.time_ >= 0 + var_283_1 and arg_280_1.time_ < 0 + var_283_1 + arg_283_0 then
				arg_280_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_283_2 = arg_280_1.actors_["10030"]

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps10030 == nil then
				arg_280_1.var_.actorSpriteComps10030 = var_283_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_283_3 = 0.2

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_3 and not isNil(var_283_2) then
				if arg_280_1.var_.actorSpriteComps10030 then
					for iter_283_1, iter_283_2 in pairs(arg_280_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_283_2 then
							if arg_280_1.isInRecall_ then
								iter_283_2.color = Color.New(Mathf.Lerp(iter_283_2.color.r, arg_280_1.hightColor1.r, (arg_280_1.time_ - 0) / var_283_3), Mathf.Lerp(iter_283_2.color.g, arg_280_1.hightColor1.g, (arg_280_1.time_ - 0) / var_283_3), (Mathf.Lerp(iter_283_2.color.b, arg_280_1.hightColor1.b, (arg_280_1.time_ - 0) / var_283_3)))
							else
								local var_283_4 = Mathf.Lerp(iter_283_2.color.r, 1, (arg_280_1.time_ - 0) / var_283_3)

								iter_283_2.color = Color.New(var_283_4, var_283_4, var_283_4)
							end
						end
					end
				end
			end

			if arg_280_1.time_ >= 0 + var_283_3 and arg_280_1.time_ < 0 + var_283_3 + arg_283_0 and not isNil(var_283_2) and arg_280_1.var_.actorSpriteComps10030 then
				for iter_283_3, iter_283_4 in pairs(arg_280_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_283_4 then
						iter_283_4.color = arg_280_1.isInRecall_ and (arg_280_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_280_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= 0 + arg_283_0 then
				local var_283_5 = arg_280_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_283_5 then
					arg_280_1.var_.alphaOldValue10030 = var_283_5.alpha
					arg_280_1.var_.characterEffect10030 = var_283_5
				end

				arg_280_1.var_.alphaOldValue10030 = 0
			end

			local var_283_6 = 0.333333333333333

			if 0 <= arg_280_1.time_ and arg_280_1.time_ < 0 + var_283_6 then
				if arg_280_1.var_.characterEffect10030 then
					arg_280_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_280_1.var_.alphaOldValue10030, 1, (arg_280_1.time_ - 0) / var_283_6)
				end
			end

			if arg_280_1.time_ >= 0 + var_283_6 and arg_280_1.time_ < 0 + var_283_6 + arg_283_0 and arg_280_1.var_.characterEffect10030 then
				arg_280_1.var_.characterEffect10030.alpha = 1
			end

			local var_283_7 = 0
			local var_283_8 = 0.325

			if 0 < arg_280_1.time_ and arg_280_1.time_ <= var_283_7 + arg_283_0 then
				arg_280_1.talkMaxDuration = 0
				arg_280_1.dialogCg_.alpha = 1

				arg_280_1.dialog_:SetActive(true)
				SetActive(arg_280_1.leftNameGo_, true)

				arg_280_1.leftNameTxt_.text = arg_280_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_280_1.leftNameTxt_.transform)

				arg_280_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_280_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_280_1:RecordName(arg_280_1.leftNameTxt_.text)
				SetActive(arg_280_1.iconTrs_.gameObject, false)
				arg_280_1.callingController_:SetSelectedState("normal")

				local var_283_9 = arg_280_1:GetWordFromCfg(115291069)
				local var_283_10 = arg_280_1:FormatText(var_283_9.content)

				arg_280_1.text_.text = var_283_10

				LuaForUtil.ClearLinePrefixSymbol(arg_280_1.text_)

				local var_283_12 = 13 <= 0 and var_283_8 or var_283_8 * (utf8.len(var_283_10) / 13)

				if (13 <= 0 and var_283_8 or var_283_8 * (utf8.len(var_283_10) / 13)) > 0 and var_283_8 < var_283_12 then
					arg_280_1.talkMaxDuration = var_283_12

					if var_283_12 + var_283_7 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_12 + var_283_7
					end
				end

				arg_280_1.text_.text = var_283_10
				arg_280_1.typewritter.percent = 0

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291069", "story_v_out_115291.awb") ~= 0 then
					local var_283_13 = manager.audio:GetVoiceLength("story_v_out_115291", "115291069", "story_v_out_115291.awb") / 1000

					if var_283_13 + var_283_7 > arg_280_1.duration_ then
						arg_280_1.duration_ = var_283_13 + var_283_7
					end

					if var_283_9.prefab_name ~= "" and arg_280_1.actors_[var_283_9.prefab_name] ~= nil then
						local var_283_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_280_1.actors_[var_283_9.prefab_name].transform, "story_v_out_115291", "115291069", "story_v_out_115291.awb")

						arg_280_1:RecordAudio("115291069", var_283_14)
						arg_280_1:RecordAudio("115291069", var_283_14)
					else
						arg_280_1:AudioAction("play", "voice", "story_v_out_115291", "115291069", "story_v_out_115291.awb")
					end

					arg_280_1:RecordHistoryTalkVoice("story_v_out_115291", "115291069", "story_v_out_115291.awb")
				end

				arg_280_1:RecordContent(arg_280_1.text_.text)
			end

			local var_283_15 = math.max(var_283_8, arg_280_1.talkMaxDuration)

			if var_283_7 <= arg_280_1.time_ and arg_280_1.time_ < var_283_7 + var_283_15 then
				arg_280_1.typewritter.percent = (arg_280_1.time_ - var_283_7) / var_283_15

				arg_280_1.typewritter:SetDirty()
			end

			if arg_280_1.time_ >= var_283_7 + var_283_15 and arg_280_1.time_ < var_283_7 + var_283_15 + arg_283_0 then
				arg_280_1.typewritter.percent = 1

				arg_280_1.typewritter:SetDirty()
				arg_280_1:ShowNextGo(true)
			end
		end

		arg_280_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_280_1:InitPlayNodeList()
	end,
	Play115291070 = function(arg_284_0, arg_284_1)
		arg_284_1.time_ = 0
		arg_284_1.frameCnt_ = 0
		arg_284_1.state_ = "playing"
		arg_284_1.curTalkId_ = 115291070
		arg_284_1.duration_ = 5

		SetActive(arg_284_1.tipsGo_, false)

		function arg_284_1.onSingleLineFinish_()
			arg_284_1.onSingleLineUpdate_ = nil
			arg_284_1.onSingleLineFinish_ = nil
			arg_284_1.state_ = "waiting"
		end

		function arg_284_1.playNext_(arg_286_0)
			if arg_286_0 == 1 then
				arg_284_0:Play115291071(arg_284_1)
			end
		end

		function arg_284_1.onSingleLineUpdate_(arg_287_0)
			if 0.332666666666667 < arg_284_1.time_ and arg_284_1.time_ <= 0.332666666666667 + arg_287_0 then
				arg_284_1.var_.moveOldPos10030 = arg_284_1.actors_["10030"].transform.localPosition
				arg_284_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_284_1:CheckSpriteTmpPos("10030", 0)

				for iter_287_0 = 0, arg_284_1.actors_["10030"].transform.childCount - 1 do
					local var_287_0 = arg_284_1.actors_["10030"].transform:GetChild(iter_287_0)

					if var_287_0.name == "split_3" or not string.find(var_287_0.name, "split") then
						var_287_0.gameObject:SetActive(true)
					else
						var_287_0.gameObject:SetActive(false)
					end
				end
			end

			local var_287_1 = 0.001

			if 0.332666666666667 <= arg_284_1.time_ and arg_284_1.time_ < 0.332666666666667 + var_287_1 then
				arg_284_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_284_1.var_.moveOldPos10030, Vector3.New(-1500, -350, -180), (arg_284_1.time_ - 0.332666666666667) / var_287_1)
			end

			if arg_284_1.time_ >= 0.332666666666667 + var_287_1 and arg_284_1.time_ < 0.332666666666667 + var_287_1 + arg_287_0 then
				arg_284_1.actors_["10030"].transform.localPosition = Vector3.New(-1500, -350, -180)
			end

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= 0 + arg_287_0 then
				local var_287_2 = arg_284_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_287_2 then
					arg_284_1.var_.alphaOldValue10030 = var_287_2.alpha
					arg_284_1.var_.characterEffect10030 = var_287_2
				end

				arg_284_1.var_.alphaOldValue10030 = 1
			end

			local var_287_3 = 0.333333333333333

			if 0 <= arg_284_1.time_ and arg_284_1.time_ < 0 + var_287_3 then
				if arg_284_1.var_.characterEffect10030 then
					arg_284_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_284_1.var_.alphaOldValue10030, 0, (arg_284_1.time_ - 0) / var_287_3)
				end
			end

			if arg_284_1.time_ >= 0 + var_287_3 and arg_284_1.time_ < 0 + var_287_3 + arg_287_0 and arg_284_1.var_.characterEffect10030 then
				arg_284_1.var_.characterEffect10030.alpha = 0
			end

			local var_287_4 = 0
			local var_287_5 = 0.4

			if 0 < arg_284_1.time_ and arg_284_1.time_ <= var_287_4 + arg_287_0 then
				arg_284_1.talkMaxDuration = 0
				arg_284_1.dialogCg_.alpha = 1

				arg_284_1.dialog_:SetActive(true)
				SetActive(arg_284_1.leftNameGo_, false)

				arg_284_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_284_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_284_1:RecordName(arg_284_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_284_1.iconTrs_.gameObject, false)
				arg_284_1.callingController_:SetSelectedState("normal")

				local var_287_6 = arg_284_1:FormatText(arg_284_1:GetWordFromCfg(115291070).content)

				arg_284_1.text_.text = var_287_6

				LuaForUtil.ClearLinePrefixSymbol(arg_284_1.text_)

				local var_287_8 = 17 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_6) / 17)

				if (17 <= 0 and var_287_5 or var_287_5 * (utf8.len(var_287_6) / 17)) > 0 and var_287_5 < var_287_8 then
					arg_284_1.talkMaxDuration = var_287_8

					if var_287_8 + var_287_4 > arg_284_1.duration_ then
						arg_284_1.duration_ = var_287_8 + var_287_4
					end
				end

				arg_284_1.text_.text = var_287_6
				arg_284_1.typewritter.percent = 0

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(false)
				arg_284_1:RecordContent(arg_284_1.text_.text)
			end

			local var_287_9 = math.max(var_287_5, arg_284_1.talkMaxDuration)

			if var_287_4 <= arg_284_1.time_ and arg_284_1.time_ < var_287_4 + var_287_9 then
				arg_284_1.typewritter.percent = (arg_284_1.time_ - var_287_4) / var_287_9

				arg_284_1.typewritter:SetDirty()
			end

			if arg_284_1.time_ >= var_287_4 + var_287_9 and arg_284_1.time_ < var_287_4 + var_287_9 + arg_287_0 then
				arg_284_1.typewritter.percent = 1

				arg_284_1.typewritter:SetDirty()
				arg_284_1:ShowNextGo(true)
			end
		end

		arg_284_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.332666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_284_1:InitPlayNodeList()
	end,
	Play115291071 = function(arg_288_0, arg_288_1)
		arg_288_1.time_ = 0
		arg_288_1.frameCnt_ = 0
		arg_288_1.state_ = "playing"
		arg_288_1.curTalkId_ = 115291071
		arg_288_1.duration_ = 5

		SetActive(arg_288_1.tipsGo_, false)

		function arg_288_1.onSingleLineFinish_()
			arg_288_1.onSingleLineUpdate_ = nil
			arg_288_1.onSingleLineFinish_ = nil
			arg_288_1.state_ = "waiting"
		end

		function arg_288_1.playNext_(arg_290_0)
			if arg_290_0 == 1 then
				arg_288_0:Play115291072(arg_288_1)
			end
		end

		function arg_288_1.onSingleLineUpdate_(arg_291_0)
			local var_291_0 = 0.725

			if 0 < arg_288_1.time_ and arg_288_1.time_ <= 0 + arg_291_0 then
				arg_288_1.talkMaxDuration = 0
				arg_288_1.dialogCg_.alpha = 1

				arg_288_1.dialog_:SetActive(true)
				SetActive(arg_288_1.leftNameGo_, false)

				arg_288_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_288_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_288_1:RecordName(arg_288_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_288_1.iconTrs_.gameObject, false)
				arg_288_1.callingController_:SetSelectedState("normal")

				local var_291_1 = arg_288_1:FormatText(arg_288_1:GetWordFromCfg(115291071).content)

				arg_288_1.text_.text = var_291_1

				LuaForUtil.ClearLinePrefixSymbol(arg_288_1.text_)

				local var_291_3 = 29 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 29)

				if (29 <= 0 and var_291_0 or var_291_0 * (utf8.len(var_291_1) / 29)) > 0 and var_291_0 < var_291_3 then
					arg_288_1.talkMaxDuration = var_291_3

					if var_291_3 + 0 > arg_288_1.duration_ then
						arg_288_1.duration_ = var_291_3 + 0
					end
				end

				arg_288_1.text_.text = var_291_1
				arg_288_1.typewritter.percent = 0

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(false)
				arg_288_1:RecordContent(arg_288_1.text_.text)
			end

			local var_291_4 = math.max(var_291_0, arg_288_1.talkMaxDuration)

			if 0 <= arg_288_1.time_ and arg_288_1.time_ < 0 + var_291_4 then
				arg_288_1.typewritter.percent = (arg_288_1.time_ - 0) / var_291_4

				arg_288_1.typewritter:SetDirty()
			end

			if arg_288_1.time_ >= 0 + var_291_4 and arg_288_1.time_ < 0 + var_291_4 + arg_291_0 then
				arg_288_1.typewritter.percent = 1

				arg_288_1.typewritter:SetDirty()
				arg_288_1:ShowNextGo(true)
			end
		end

		arg_288_1.nodeConfigList_ = {}

		arg_288_1:InitPlayNodeList()
	end,
	Play115291072 = function(arg_292_0, arg_292_1)
		arg_292_1.time_ = 0
		arg_292_1.frameCnt_ = 0
		arg_292_1.state_ = "playing"
		arg_292_1.curTalkId_ = 115291072
		arg_292_1.duration_ = 8

		SetActive(arg_292_1.tipsGo_, false)

		function arg_292_1.onSingleLineFinish_()
			arg_292_1.onSingleLineUpdate_ = nil
			arg_292_1.onSingleLineFinish_ = nil
			arg_292_1.state_ = "waiting"
		end

		function arg_292_1.playNext_(arg_294_0)
			if arg_294_0 == 1 then
				arg_292_0:Play115291073(arg_292_1)
			end
		end

		function arg_292_1.onSingleLineUpdate_(arg_295_0)
			if arg_292_1.bgs_.STblack == nil then
				local var_295_0 = Object.Instantiate(arg_292_1.paintGo_)

				var_295_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_295_0.name = "STblack"
				var_295_0.transform.parent = arg_292_1.stage_.transform
				var_295_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_292_1.bgs_.STblack = var_295_0
			end

			if 1 < arg_292_1.time_ and arg_292_1.time_ <= 1 + arg_295_0 then
				local var_295_1 = arg_292_1.bgs_.STblack

				arg_292_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_295_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_295_2 = var_295_1:GetComponent("SpriteRenderer")

				if var_295_2 and var_295_2.sprite then
					local var_295_3 = 2 * (var_295_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_295_1.transform.localScale = Vector3.New(var_295_3 / var_295_2.sprite.bounds.size.y < var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x and var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x or var_295_3 / var_295_2.sprite.bounds.size.y, var_295_3 / var_295_2.sprite.bounds.size.y < var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x and var_295_3 * manager.ui.mainCameraCom_.aspect / var_295_2.sprite.bounds.size.x or var_295_3 / var_295_2.sprite.bounds.size.y, 0)
				end

				for iter_295_0, iter_295_1 in pairs(arg_292_1.bgs_) do
					if iter_295_0 ~= "STblack" then
						iter_295_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_295_4 = 0

			if 0 < arg_292_1.time_ and arg_292_1.time_ <= var_295_4 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = false

				arg_292_1:SetGaussion(false)
			end

			local var_295_5 = 1

			if var_295_4 <= arg_292_1.time_ and arg_292_1.time_ < var_295_4 + var_295_5 then
				local var_295_6 = Color.New(0, 0, 0)

				var_295_6.a = Mathf.Lerp(0, 1, (arg_292_1.time_ - var_295_4) / var_295_5)
				arg_292_1.mask_.color = var_295_6
			end

			if arg_292_1.time_ >= var_295_4 + var_295_5 and arg_292_1.time_ < var_295_4 + var_295_5 + arg_295_0 then
				local var_295_7 = Color.New(0, 0, 0)

				var_295_7.a = 1
				arg_292_1.mask_.color = var_295_7
			end

			local var_295_8 = 1

			if 1 < arg_292_1.time_ and arg_292_1.time_ <= var_295_8 + arg_295_0 then
				arg_292_1.mask_.enabled = true
				arg_292_1.mask_.raycastTarget = false

				arg_292_1:SetGaussion(false)
			end

			local var_295_9 = 2

			if var_295_8 <= arg_292_1.time_ and arg_292_1.time_ < var_295_8 + var_295_9 then
				local var_295_10 = Color.New(0, 0, 0)

				var_295_10.a = Mathf.Lerp(1, 0, (arg_292_1.time_ - var_295_8) / var_295_9)
				arg_292_1.mask_.color = var_295_10
			end

			if arg_292_1.time_ >= var_295_8 + var_295_9 and arg_292_1.time_ < var_295_8 + var_295_9 + arg_295_0 then
				local var_295_11 = Color.New(0, 0, 0)

				arg_292_1.mask_.enabled = false
				var_295_11.a = 0
				arg_292_1.mask_.color = var_295_11
			end

			if arg_292_1.frameCnt_ <= 1 then
				arg_292_1.dialog_:SetActive(false)
			end

			local var_295_12 = 3
			local var_295_13 = 1.65

			if 3 < arg_292_1.time_ and arg_292_1.time_ <= var_295_12 + arg_295_0 then
				arg_292_1.talkMaxDuration = 0

				arg_292_1.dialog_:SetActive(true)

				arg_292_1.dialogCg_.alpha = 0

				local var_295_14 = LeanTween.value(arg_292_1.dialog_, 0, 1, 0.3)

				var_295_14:setOnUpdate(LuaHelper.FloatAction(function(arg_296_0)
					arg_292_1.dialogCg_.alpha = arg_296_0
				end))
				var_295_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_292_1.dialog_)
					var_295_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_292_1.duration_ = arg_292_1.duration_ + 0.3

				SetActive(arg_292_1.leftNameGo_, false)

				arg_292_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_292_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_292_1:RecordName(arg_292_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_292_1.iconTrs_.gameObject, false)
				arg_292_1.callingController_:SetSelectedState("normal")

				local var_295_15 = arg_292_1:FormatText(arg_292_1:GetWordFromCfg(115291072).content)

				arg_292_1.text_.text = var_295_15

				LuaForUtil.ClearLinePrefixSymbol(arg_292_1.text_)

				local var_295_17 = 66 <= 0 and var_295_13 or var_295_13 * (utf8.len(var_295_15) / 66)

				if (66 <= 0 and var_295_13 or var_295_13 * (utf8.len(var_295_15) / 66)) > 0 and var_295_13 < var_295_17 then
					arg_292_1.talkMaxDuration = var_295_17
					var_295_12 = var_295_12 + 0.3

					if var_295_17 + var_295_12 > arg_292_1.duration_ then
						arg_292_1.duration_ = var_295_17 + var_295_12
					end
				end

				arg_292_1.text_.text = var_295_15
				arg_292_1.typewritter.percent = 0

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(false)
				arg_292_1:RecordContent(arg_292_1.text_.text)
			end

			local var_295_18 = var_295_12 + 0.3
			local var_295_19 = math.max(var_295_13, arg_292_1.talkMaxDuration)

			if var_295_12 + 0.3 <= arg_292_1.time_ and arg_292_1.time_ < var_295_18 + var_295_19 then
				arg_292_1.typewritter.percent = (arg_292_1.time_ - var_295_18) / var_295_19

				arg_292_1.typewritter:SetDirty()
			end

			if arg_292_1.time_ >= var_295_18 + var_295_19 and arg_292_1.time_ < var_295_18 + var_295_19 + arg_295_0 then
				arg_292_1.typewritter.percent = 1

				arg_292_1.typewritter:SetDirty()
				arg_292_1:ShowNextGo(true)
			end
		end

		arg_292_1.nodeConfigList_ = {}

		arg_292_1:InitPlayNodeList()
	end,
	Play115291073 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 115291073
		arg_298_1.duration_ = 2.13

		local var_298_0 = {
			ja = 2.133,
			ko = 1.2,
			zh = 1.933,
			en = 1.166
		}
		local var_298_1 = manager.audio:GetLocalizationFlag()

		if var_298_0[var_298_1] ~= nil then
			arg_298_1.duration_ = var_298_0[var_298_1]
		end

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play115291074(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.05

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, true)
				arg_298_1.iconController_:SetSelectedState("hero")

				arg_298_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_3")

				arg_298_1.callingController_:SetSelectedState("normal")

				arg_298_1.keyicon_.color = Color.New(1, 1, 1)
				arg_298_1.icon_.color = Color.New(1, 1, 1)

				local var_301_1 = arg_298_1:GetWordFromCfg(115291073)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 2 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 2)

				if (2 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 2)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291073", "story_v_out_115291.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291073", "story_v_out_115291.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_out_115291", "115291073", "story_v_out_115291.awb")

						arg_298_1:RecordAudio("115291073", var_301_6)
						arg_298_1:RecordAudio("115291073", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_115291", "115291073", "story_v_out_115291.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_115291", "115291073", "story_v_out_115291.awb")
				end

				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_7 = math.max(var_301_0, arg_298_1.talkMaxDuration)

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_7 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - 0) / var_301_7

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= 0 + var_301_7 and arg_298_1.time_ < 0 + var_301_7 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {}

		arg_298_1:InitPlayNodeList()
	end,
	Play115291074 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 115291074
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play115291075(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			local var_305_0 = 1.925

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, false)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_1 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(115291074).content)

				arg_302_1.text_.text = var_305_1

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_3 = 77 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 77)

				if (77 <= 0 and var_305_0 or var_305_0 * (utf8.len(var_305_1) / 77)) > 0 and var_305_0 < var_305_3 then
					arg_302_1.talkMaxDuration = var_305_3

					if var_305_3 + 0 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_3 + 0
					end
				end

				arg_302_1.text_.text = var_305_1
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_4 = math.max(var_305_0, arg_302_1.talkMaxDuration)

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - 0) / var_305_4

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {}

		arg_302_1:InitPlayNodeList()
	end,
	Play115291075 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 115291075
		arg_306_1.duration_ = 2.2

		local var_306_0 = {
			ja = 2.2,
			ko = 0.999999999999,
			zh = 2,
			en = 1.1
		}
		local var_306_1 = manager.audio:GetLocalizationFlag()

		if var_306_0[var_306_1] ~= nil then
			arg_306_1.duration_ = var_306_0[var_306_1]
		end

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
		end

		function arg_306_1.playNext_(arg_308_0)
			if arg_308_0 == 1 then
				arg_306_0:Play115291076(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			local var_309_0 = 0.05

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_3")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_1 = arg_306_1:GetWordFromCfg(115291075)
				local var_309_2 = arg_306_1:FormatText(var_309_1.content)

				arg_306_1.text_.text = var_309_2

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_4 = 2 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 2)

				if (2 <= 0 and var_309_0 or var_309_0 * (utf8.len(var_309_2) / 2)) > 0 and var_309_0 < var_309_4 then
					arg_306_1.talkMaxDuration = var_309_4

					if var_309_4 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_4 + 0
					end
				end

				arg_306_1.text_.text = var_309_2
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291075", "story_v_out_115291.awb") ~= 0 then
					local var_309_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291075", "story_v_out_115291.awb") / 1000

					if var_309_5 + 0 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + 0
					end

					if var_309_1.prefab_name ~= "" and arg_306_1.actors_[var_309_1.prefab_name] ~= nil then
						local var_309_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_1.prefab_name].transform, "story_v_out_115291", "115291075", "story_v_out_115291.awb")

						arg_306_1:RecordAudio("115291075", var_309_6)
						arg_306_1:RecordAudio("115291075", var_309_6)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_115291", "115291075", "story_v_out_115291.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_115291", "115291075", "story_v_out_115291.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_7 = math.max(var_309_0, arg_306_1.talkMaxDuration)

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_7 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - 0) / var_309_7

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= 0 + var_309_7 and arg_306_1.time_ < 0 + var_309_7 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play115291076 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 115291076
		arg_310_1.duration_ = 5

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play115291077(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			local var_313_0 = 1.875

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, false)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_1 = arg_310_1:FormatText(arg_310_1:GetWordFromCfg(115291076).content)

				arg_310_1.text_.text = var_313_1

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_3 = 75 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 75)

				if (75 <= 0 and var_313_0 or var_313_0 * (utf8.len(var_313_1) / 75)) > 0 and var_313_0 < var_313_3 then
					arg_310_1.talkMaxDuration = var_313_3

					if var_313_3 + 0 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_3 + 0
					end
				end

				arg_310_1.text_.text = var_313_1
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)
				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_4 = math.max(var_313_0, arg_310_1.talkMaxDuration)

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_4 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - 0) / var_313_4

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= 0 + var_313_4 and arg_310_1.time_ < 0 + var_313_4 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play115291077 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 115291077
		arg_314_1.duration_ = 2.4

		local var_314_0 = {
			ja = 2.4,
			ko = 1.433,
			zh = 1.866,
			en = 2
		}
		local var_314_1 = manager.audio:GetLocalizationFlag()

		if var_314_0[var_314_1] ~= nil then
			arg_314_1.duration_ = var_314_0[var_314_1]
		end

		SetActive(arg_314_1.tipsGo_, false)

		function arg_314_1.onSingleLineFinish_()
			arg_314_1.onSingleLineUpdate_ = nil
			arg_314_1.onSingleLineFinish_ = nil
			arg_314_1.state_ = "waiting"
		end

		function arg_314_1.playNext_(arg_316_0)
			if arg_316_0 == 1 then
				arg_314_0:Play115291078(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			local var_317_0 = 0.175

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, true)
				arg_314_1.iconController_:SetSelectedState("hero")

				arg_314_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10030_split_3")

				arg_314_1.callingController_:SetSelectedState("normal")

				arg_314_1.keyicon_.color = Color.New(1, 1, 1)
				arg_314_1.icon_.color = Color.New(1, 1, 1)

				local var_317_1 = arg_314_1:GetWordFromCfg(115291077)
				local var_317_2 = arg_314_1:FormatText(var_317_1.content)

				arg_314_1.text_.text = var_317_2

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_4 = 7 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 7)

				if (7 <= 0 and var_317_0 or var_317_0 * (utf8.len(var_317_2) / 7)) > 0 and var_317_0 < var_317_4 then
					arg_314_1.talkMaxDuration = var_317_4

					if var_317_4 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_4 + 0
					end
				end

				arg_314_1.text_.text = var_317_2
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291077", "story_v_out_115291.awb") ~= 0 then
					local var_317_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291077", "story_v_out_115291.awb") / 1000

					if var_317_5 + 0 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_5 + 0
					end

					if var_317_1.prefab_name ~= "" and arg_314_1.actors_[var_317_1.prefab_name] ~= nil then
						local var_317_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_1.prefab_name].transform, "story_v_out_115291", "115291077", "story_v_out_115291.awb")

						arg_314_1:RecordAudio("115291077", var_317_6)
						arg_314_1:RecordAudio("115291077", var_317_6)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_115291", "115291077", "story_v_out_115291.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_115291", "115291077", "story_v_out_115291.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_7 = math.max(var_317_0, arg_314_1.talkMaxDuration)

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_7 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - 0) / var_317_7

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= 0 + var_317_7 and arg_314_1.time_ < 0 + var_317_7 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play115291078 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 115291078
		arg_318_1.duration_ = 9

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play115291079(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 2 < arg_318_1.time_ and arg_318_1.time_ <= 2 + arg_321_0 then
				local var_321_0 = arg_318_1.bgs_.ST22a

				arg_318_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_321_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_321_1 = var_321_0:GetComponent("SpriteRenderer")

				if var_321_1 and var_321_1.sprite then
					local var_321_2 = 2 * (var_321_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_321_0.transform.localScale = Vector3.New(var_321_2 / var_321_1.sprite.bounds.size.y < var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x and var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x or var_321_2 / var_321_1.sprite.bounds.size.y, var_321_2 / var_321_1.sprite.bounds.size.y < var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x and var_321_2 * manager.ui.mainCameraCom_.aspect / var_321_1.sprite.bounds.size.x or var_321_2 / var_321_1.sprite.bounds.size.y, 0)
				end

				for iter_321_0, iter_321_1 in pairs(arg_318_1.bgs_) do
					if iter_321_0 ~= "ST22a" then
						iter_321_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_321_3 = 0

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_3 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = false

				arg_318_1:SetGaussion(false)
			end

			local var_321_4 = 2

			if var_321_3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_3 + var_321_4 then
				local var_321_5 = Color.New(0, 0, 0)

				var_321_5.a = Mathf.Lerp(0, 1, (arg_318_1.time_ - var_321_3) / var_321_4)
				arg_318_1.mask_.color = var_321_5
			end

			if arg_318_1.time_ >= var_321_3 + var_321_4 and arg_318_1.time_ < var_321_3 + var_321_4 + arg_321_0 then
				local var_321_6 = Color.New(0, 0, 0)

				var_321_6.a = 1
				arg_318_1.mask_.color = var_321_6
			end

			local var_321_7 = 2

			if 2 < arg_318_1.time_ and arg_318_1.time_ <= var_321_7 + arg_321_0 then
				arg_318_1.mask_.enabled = true
				arg_318_1.mask_.raycastTarget = false

				arg_318_1:SetGaussion(false)
			end

			local var_321_8 = 2

			if var_321_7 <= arg_318_1.time_ and arg_318_1.time_ < var_321_7 + var_321_8 then
				local var_321_9 = Color.New(0, 0, 0)

				var_321_9.a = Mathf.Lerp(1, 0, (arg_318_1.time_ - var_321_7) / var_321_8)
				arg_318_1.mask_.color = var_321_9
			end

			if arg_318_1.time_ >= var_321_7 + var_321_8 and arg_318_1.time_ < var_321_7 + var_321_8 + arg_321_0 then
				local var_321_10 = Color.New(0, 0, 0)

				arg_318_1.mask_.enabled = false
				var_321_10.a = 0
				arg_318_1.mask_.color = var_321_10
			end

			if arg_318_1.frameCnt_ <= 1 then
				arg_318_1.dialog_:SetActive(false)
			end

			local var_321_11 = 4
			local var_321_12 = 1.15

			if 4 < arg_318_1.time_ and arg_318_1.time_ <= var_321_11 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0

				arg_318_1.dialog_:SetActive(true)

				arg_318_1.dialogCg_.alpha = 0

				local var_321_13 = LeanTween.value(arg_318_1.dialog_, 0, 1, 0.3)

				var_321_13:setOnUpdate(LuaHelper.FloatAction(function(arg_322_0)
					arg_318_1.dialogCg_.alpha = arg_322_0
				end))
				var_321_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_318_1.dialog_)
					var_321_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_318_1.duration_ = arg_318_1.duration_ + 0.3

				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_14 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(115291078).content)

				arg_318_1.text_.text = var_321_14

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_16 = 46 <= 0 and var_321_12 or var_321_12 * (utf8.len(var_321_14) / 46)

				if (46 <= 0 and var_321_12 or var_321_12 * (utf8.len(var_321_14) / 46)) > 0 and var_321_12 < var_321_16 then
					arg_318_1.talkMaxDuration = var_321_16
					var_321_11 = var_321_11 + 0.3

					if var_321_16 + var_321_11 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_16 + var_321_11
					end
				end

				arg_318_1.text_.text = var_321_14
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_17 = var_321_11 + 0.3
			local var_321_18 = math.max(var_321_12, arg_318_1.talkMaxDuration)

			if var_321_11 + 0.3 <= arg_318_1.time_ and arg_318_1.time_ < var_321_17 + var_321_18 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_17) / var_321_18

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_17 + var_321_18 and arg_318_1.time_ < var_321_17 + var_321_18 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play115291079 = function(arg_324_0, arg_324_1)
		arg_324_1.time_ = 0
		arg_324_1.frameCnt_ = 0
		arg_324_1.state_ = "playing"
		arg_324_1.curTalkId_ = 115291079
		arg_324_1.duration_ = 5

		SetActive(arg_324_1.tipsGo_, false)

		function arg_324_1.onSingleLineFinish_()
			arg_324_1.onSingleLineUpdate_ = nil
			arg_324_1.onSingleLineFinish_ = nil
			arg_324_1.state_ = "waiting"
		end

		function arg_324_1.playNext_(arg_326_0)
			if arg_326_0 == 1 then
				arg_324_0:Play115291080(arg_324_1)
			end
		end

		function arg_324_1.onSingleLineUpdate_(arg_327_0)
			local var_327_0 = 1.425

			if 0 < arg_324_1.time_ and arg_324_1.time_ <= 0 + arg_327_0 then
				arg_324_1.talkMaxDuration = 0
				arg_324_1.dialogCg_.alpha = 1

				arg_324_1.dialog_:SetActive(true)
				SetActive(arg_324_1.leftNameGo_, false)

				arg_324_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_324_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_324_1:RecordName(arg_324_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_324_1.iconTrs_.gameObject, false)
				arg_324_1.callingController_:SetSelectedState("normal")

				local var_327_1 = arg_324_1:FormatText(arg_324_1:GetWordFromCfg(115291079).content)

				arg_324_1.text_.text = var_327_1

				LuaForUtil.ClearLinePrefixSymbol(arg_324_1.text_)

				local var_327_3 = 57 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 57)

				if (57 <= 0 and var_327_0 or var_327_0 * (utf8.len(var_327_1) / 57)) > 0 and var_327_0 < var_327_3 then
					arg_324_1.talkMaxDuration = var_327_3

					if var_327_3 + 0 > arg_324_1.duration_ then
						arg_324_1.duration_ = var_327_3 + 0
					end
				end

				arg_324_1.text_.text = var_327_1
				arg_324_1.typewritter.percent = 0

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(false)
				arg_324_1:RecordContent(arg_324_1.text_.text)
			end

			local var_327_4 = math.max(var_327_0, arg_324_1.talkMaxDuration)

			if 0 <= arg_324_1.time_ and arg_324_1.time_ < 0 + var_327_4 then
				arg_324_1.typewritter.percent = (arg_324_1.time_ - 0) / var_327_4

				arg_324_1.typewritter:SetDirty()
			end

			if arg_324_1.time_ >= 0 + var_327_4 and arg_324_1.time_ < 0 + var_327_4 + arg_327_0 then
				arg_324_1.typewritter.percent = 1

				arg_324_1.typewritter:SetDirty()
				arg_324_1:ShowNextGo(true)
			end
		end

		arg_324_1.nodeConfigList_ = {}

		arg_324_1:InitPlayNodeList()
	end,
	Play115291080 = function(arg_328_0, arg_328_1)
		arg_328_1.time_ = 0
		arg_328_1.frameCnt_ = 0
		arg_328_1.state_ = "playing"
		arg_328_1.curTalkId_ = 115291080
		arg_328_1.duration_ = 3.73

		local var_328_0 = {
			ja = 3.733,
			ko = 1.666,
			zh = 2.466,
			en = 2.8
		}
		local var_328_1 = manager.audio:GetLocalizationFlag()

		if var_328_0[var_328_1] ~= nil then
			arg_328_1.duration_ = var_328_0[var_328_1]
		end

		SetActive(arg_328_1.tipsGo_, false)

		function arg_328_1.onSingleLineFinish_()
			arg_328_1.onSingleLineUpdate_ = nil
			arg_328_1.onSingleLineFinish_ = nil
			arg_328_1.state_ = "waiting"
		end

		function arg_328_1.playNext_(arg_330_0)
			if arg_330_0 == 1 then
				arg_328_0:Play115291081(arg_328_1)
			end
		end

		function arg_328_1.onSingleLineUpdate_(arg_331_0)
			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				arg_328_1.var_.moveOldPos10030 = arg_328_1.actors_["10030"].transform.localPosition
				arg_328_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_328_1:CheckSpriteTmpPos("10030", 3)

				for iter_331_0 = 0, arg_328_1.actors_["10030"].transform.childCount - 1 do
					local var_331_0 = arg_328_1.actors_["10030"].transform:GetChild(iter_331_0)

					if var_331_0.name == "split_3" or not string.find(var_331_0.name, "split") then
						var_331_0.gameObject:SetActive(true)
					else
						var_331_0.gameObject:SetActive(false)
					end
				end
			end

			local var_331_1 = 0.001

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_1 then
				arg_328_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_328_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_328_1.time_ - 0) / var_331_1)
			end

			if arg_328_1.time_ >= 0 + var_331_1 and arg_328_1.time_ < 0 + var_331_1 + arg_331_0 then
				arg_328_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= 0 + arg_331_0 then
				local var_331_2 = arg_328_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_331_2 then
					arg_328_1.var_.alphaOldValue10030 = var_331_2.alpha
					arg_328_1.var_.characterEffect10030 = var_331_2
				end

				arg_328_1.var_.alphaOldValue10030 = 0
			end

			local var_331_3 = 0.333333333333333

			if 0 <= arg_328_1.time_ and arg_328_1.time_ < 0 + var_331_3 then
				if arg_328_1.var_.characterEffect10030 then
					arg_328_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_328_1.var_.alphaOldValue10030, 1, (arg_328_1.time_ - 0) / var_331_3)
				end
			end

			if arg_328_1.time_ >= 0 + var_331_3 and arg_328_1.time_ < 0 + var_331_3 + arg_331_0 and arg_328_1.var_.characterEffect10030 then
				arg_328_1.var_.characterEffect10030.alpha = 1
			end

			local var_331_4 = 0
			local var_331_5 = 0.175

			if 0 < arg_328_1.time_ and arg_328_1.time_ <= var_331_4 + arg_331_0 then
				arg_328_1.talkMaxDuration = 0
				arg_328_1.dialogCg_.alpha = 1

				arg_328_1.dialog_:SetActive(true)
				SetActive(arg_328_1.leftNameGo_, true)

				arg_328_1.leftNameTxt_.text = arg_328_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_328_1.leftNameTxt_.transform)

				arg_328_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_328_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_328_1:RecordName(arg_328_1.leftNameTxt_.text)
				SetActive(arg_328_1.iconTrs_.gameObject, false)
				arg_328_1.callingController_:SetSelectedState("normal")

				local var_331_6 = arg_328_1:GetWordFromCfg(115291080)
				local var_331_7 = arg_328_1:FormatText(var_331_6.content)

				arg_328_1.text_.text = var_331_7

				LuaForUtil.ClearLinePrefixSymbol(arg_328_1.text_)

				local var_331_9 = 7 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 7)

				if (7 <= 0 and var_331_5 or var_331_5 * (utf8.len(var_331_7) / 7)) > 0 and var_331_5 < var_331_9 then
					arg_328_1.talkMaxDuration = var_331_9

					if var_331_9 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_9 + var_331_4
					end
				end

				arg_328_1.text_.text = var_331_7
				arg_328_1.typewritter.percent = 0

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291080", "story_v_out_115291.awb") ~= 0 then
					local var_331_10 = manager.audio:GetVoiceLength("story_v_out_115291", "115291080", "story_v_out_115291.awb") / 1000

					if var_331_10 + var_331_4 > arg_328_1.duration_ then
						arg_328_1.duration_ = var_331_10 + var_331_4
					end

					if var_331_6.prefab_name ~= "" and arg_328_1.actors_[var_331_6.prefab_name] ~= nil then
						local var_331_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_328_1.actors_[var_331_6.prefab_name].transform, "story_v_out_115291", "115291080", "story_v_out_115291.awb")

						arg_328_1:RecordAudio("115291080", var_331_11)
						arg_328_1:RecordAudio("115291080", var_331_11)
					else
						arg_328_1:AudioAction("play", "voice", "story_v_out_115291", "115291080", "story_v_out_115291.awb")
					end

					arg_328_1:RecordHistoryTalkVoice("story_v_out_115291", "115291080", "story_v_out_115291.awb")
				end

				arg_328_1:RecordContent(arg_328_1.text_.text)
			end

			local var_331_12 = math.max(var_331_5, arg_328_1.talkMaxDuration)

			if var_331_4 <= arg_328_1.time_ and arg_328_1.time_ < var_331_4 + var_331_12 then
				arg_328_1.typewritter.percent = (arg_328_1.time_ - var_331_4) / var_331_12

				arg_328_1.typewritter:SetDirty()
			end

			if arg_328_1.time_ >= var_331_4 + var_331_12 and arg_328_1.time_ < var_331_4 + var_331_12 + arg_331_0 then
				arg_328_1.typewritter.percent = 1

				arg_328_1.typewritter:SetDirty()
				arg_328_1:ShowNextGo(true)
			end
		end

		arg_328_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_328_1:InitPlayNodeList()
	end,
	Play115291081 = function(arg_332_0, arg_332_1)
		arg_332_1.time_ = 0
		arg_332_1.frameCnt_ = 0
		arg_332_1.state_ = "playing"
		arg_332_1.curTalkId_ = 115291081
		arg_332_1.duration_ = 5

		SetActive(arg_332_1.tipsGo_, false)

		function arg_332_1.onSingleLineFinish_()
			arg_332_1.onSingleLineUpdate_ = nil
			arg_332_1.onSingleLineFinish_ = nil
			arg_332_1.state_ = "waiting"
		end

		function arg_332_1.playNext_(arg_334_0)
			if arg_334_0 == 1 then
				arg_332_0:Play115291082(arg_332_1)
			end
		end

		function arg_332_1.onSingleLineUpdate_(arg_335_0)
			if 0 < arg_332_1.time_ and arg_332_1.time_ <= 0 + arg_335_0 then
				local var_335_0 = arg_332_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_335_0 then
					arg_332_1.var_.alphaOldValue10030 = var_335_0.alpha
					arg_332_1.var_.characterEffect10030 = var_335_0
				end

				arg_332_1.var_.alphaOldValue10030 = 1
			end

			local var_335_1 = 0.333333333333333

			if 0 <= arg_332_1.time_ and arg_332_1.time_ < 0 + var_335_1 then
				if arg_332_1.var_.characterEffect10030 then
					arg_332_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_332_1.var_.alphaOldValue10030, 0, (arg_332_1.time_ - 0) / var_335_1)
				end
			end

			if arg_332_1.time_ >= 0 + var_335_1 and arg_332_1.time_ < 0 + var_335_1 + arg_335_0 and arg_332_1.var_.characterEffect10030 then
				arg_332_1.var_.characterEffect10030.alpha = 0
			end

			local var_335_2 = 0
			local var_335_3 = 1.25

			if 0 < arg_332_1.time_ and arg_332_1.time_ <= var_335_2 + arg_335_0 then
				arg_332_1.talkMaxDuration = 0
				arg_332_1.dialogCg_.alpha = 1

				arg_332_1.dialog_:SetActive(true)
				SetActive(arg_332_1.leftNameGo_, false)

				arg_332_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_332_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_332_1:RecordName(arg_332_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_332_1.iconTrs_.gameObject, false)
				arg_332_1.callingController_:SetSelectedState("normal")

				local var_335_4 = arg_332_1:FormatText(arg_332_1:GetWordFromCfg(115291081).content)

				arg_332_1.text_.text = var_335_4

				LuaForUtil.ClearLinePrefixSymbol(arg_332_1.text_)

				local var_335_6 = 50 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_4) / 50)

				if (50 <= 0 and var_335_3 or var_335_3 * (utf8.len(var_335_4) / 50)) > 0 and var_335_3 < var_335_6 then
					arg_332_1.talkMaxDuration = var_335_6

					if var_335_6 + var_335_2 > arg_332_1.duration_ then
						arg_332_1.duration_ = var_335_6 + var_335_2
					end
				end

				arg_332_1.text_.text = var_335_4
				arg_332_1.typewritter.percent = 0

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(false)
				arg_332_1:RecordContent(arg_332_1.text_.text)
			end

			local var_335_7 = math.max(var_335_3, arg_332_1.talkMaxDuration)

			if var_335_2 <= arg_332_1.time_ and arg_332_1.time_ < var_335_2 + var_335_7 then
				arg_332_1.typewritter.percent = (arg_332_1.time_ - var_335_2) / var_335_7

				arg_332_1.typewritter:SetDirty()
			end

			if arg_332_1.time_ >= var_335_2 + var_335_7 and arg_332_1.time_ < var_335_2 + var_335_7 + arg_335_0 then
				arg_332_1.typewritter.percent = 1

				arg_332_1.typewritter:SetDirty()
				arg_332_1:ShowNextGo(true)
			end
		end

		arg_332_1.nodeConfigList_ = {}

		arg_332_1:InitPlayNodeList()
	end,
	Play115291082 = function(arg_336_0, arg_336_1)
		arg_336_1.time_ = 0
		arg_336_1.frameCnt_ = 0
		arg_336_1.state_ = "playing"
		arg_336_1.curTalkId_ = 115291082
		arg_336_1.duration_ = 5

		SetActive(arg_336_1.tipsGo_, false)

		function arg_336_1.onSingleLineFinish_()
			arg_336_1.onSingleLineUpdate_ = nil
			arg_336_1.onSingleLineFinish_ = nil
			arg_336_1.state_ = "waiting"
		end

		function arg_336_1.playNext_(arg_338_0)
			if arg_338_0 == 1 then
				arg_336_0:Play115291083(arg_336_1)
			end
		end

		function arg_336_1.onSingleLineUpdate_(arg_339_0)
			local var_339_0 = 0.9

			if 0 < arg_336_1.time_ and arg_336_1.time_ <= 0 + arg_339_0 then
				arg_336_1.talkMaxDuration = 0
				arg_336_1.dialogCg_.alpha = 1

				arg_336_1.dialog_:SetActive(true)
				SetActive(arg_336_1.leftNameGo_, false)

				arg_336_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_336_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_336_1:RecordName(arg_336_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_336_1.iconTrs_.gameObject, false)
				arg_336_1.callingController_:SetSelectedState("normal")

				local var_339_1 = arg_336_1:FormatText(arg_336_1:GetWordFromCfg(115291082).content)

				arg_336_1.text_.text = var_339_1

				LuaForUtil.ClearLinePrefixSymbol(arg_336_1.text_)

				local var_339_3 = 36 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 36)

				if (36 <= 0 and var_339_0 or var_339_0 * (utf8.len(var_339_1) / 36)) > 0 and var_339_0 < var_339_3 then
					arg_336_1.talkMaxDuration = var_339_3

					if var_339_3 + 0 > arg_336_1.duration_ then
						arg_336_1.duration_ = var_339_3 + 0
					end
				end

				arg_336_1.text_.text = var_339_1
				arg_336_1.typewritter.percent = 0

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(false)
				arg_336_1:RecordContent(arg_336_1.text_.text)
			end

			local var_339_4 = math.max(var_339_0, arg_336_1.talkMaxDuration)

			if 0 <= arg_336_1.time_ and arg_336_1.time_ < 0 + var_339_4 then
				arg_336_1.typewritter.percent = (arg_336_1.time_ - 0) / var_339_4

				arg_336_1.typewritter:SetDirty()
			end

			if arg_336_1.time_ >= 0 + var_339_4 and arg_336_1.time_ < 0 + var_339_4 + arg_339_0 then
				arg_336_1.typewritter.percent = 1

				arg_336_1.typewritter:SetDirty()
				arg_336_1:ShowNextGo(true)
			end
		end

		arg_336_1.nodeConfigList_ = {}

		arg_336_1:InitPlayNodeList()
	end,
	Play115291083 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 115291083
		arg_340_1.duration_ = 5

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play115291084(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			local var_343_0 = 0.975

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, false)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_1 = arg_340_1:FormatText(arg_340_1:GetWordFromCfg(115291083).content)

				arg_340_1.text_.text = var_343_1

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_3 = 39 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 39)

				if (39 <= 0 and var_343_0 or var_343_0 * (utf8.len(var_343_1) / 39)) > 0 and var_343_0 < var_343_3 then
					arg_340_1.talkMaxDuration = var_343_3

					if var_343_3 + 0 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_3 + 0
					end
				end

				arg_340_1.text_.text = var_343_1
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)
				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_4 = math.max(var_343_0, arg_340_1.talkMaxDuration)

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_4 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - 0) / var_343_4

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= 0 + var_343_4 and arg_340_1.time_ < 0 + var_343_4 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play115291084 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 115291084
		arg_344_1.duration_ = 7.93

		local var_344_0 = {
			ja = 6.5,
			ko = 7.933,
			zh = 6.3,
			en = 6.533
		}
		local var_344_1 = manager.audio:GetLocalizationFlag()

		if var_344_0[var_344_1] ~= nil then
			arg_344_1.duration_ = var_344_0[var_344_1]
		end

		SetActive(arg_344_1.tipsGo_, false)

		function arg_344_1.onSingleLineFinish_()
			arg_344_1.onSingleLineUpdate_ = nil
			arg_344_1.onSingleLineFinish_ = nil
			arg_344_1.state_ = "waiting"
		end

		function arg_344_1.playNext_(arg_346_0)
			if arg_346_0 == 1 then
				arg_344_0:Play115291085(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.var_.moveOldPos10030 = arg_344_1.actors_["10030"].transform.localPosition
				arg_344_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_344_1:CheckSpriteTmpPos("10030", 3)

				for iter_347_0 = 0, arg_344_1.actors_["10030"].transform.childCount - 1 do
					local var_347_0 = arg_344_1.actors_["10030"].transform:GetChild(iter_347_0)

					if var_347_0.name == "split_3" or not string.find(var_347_0.name, "split") then
						var_347_0.gameObject:SetActive(true)
					else
						var_347_0.gameObject:SetActive(false)
					end
				end
			end

			local var_347_1 = 0.001

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_1 then
				arg_344_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_344_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_344_1.time_ - 0) / var_347_1)
			end

			if arg_344_1.time_ >= 0 + var_347_1 and arg_344_1.time_ < 0 + var_347_1 + arg_347_0 then
				arg_344_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				local var_347_2 = arg_344_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_347_2 then
					arg_344_1.var_.alphaOldValue10030 = var_347_2.alpha
					arg_344_1.var_.characterEffect10030 = var_347_2
				end

				arg_344_1.var_.alphaOldValue10030 = 0
			end

			local var_347_3 = 0.333333333333333

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_3 then
				if arg_344_1.var_.characterEffect10030 then
					arg_344_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_344_1.var_.alphaOldValue10030, 1, (arg_344_1.time_ - 0) / var_347_3)
				end
			end

			if arg_344_1.time_ >= 0 + var_347_3 and arg_344_1.time_ < 0 + var_347_3 + arg_347_0 and arg_344_1.var_.characterEffect10030 then
				arg_344_1.var_.characterEffect10030.alpha = 1
			end

			local var_347_4 = 0
			local var_347_5 = 0.55

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= var_347_4 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_6 = arg_344_1:GetWordFromCfg(115291084)
				local var_347_7 = arg_344_1:FormatText(var_347_6.content)

				arg_344_1.text_.text = var_347_7

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_9 = 25 <= 0 and var_347_5 or var_347_5 * (utf8.len(var_347_7) / 25)

				if (25 <= 0 and var_347_5 or var_347_5 * (utf8.len(var_347_7) / 25)) > 0 and var_347_5 < var_347_9 then
					arg_344_1.talkMaxDuration = var_347_9

					if var_347_9 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_9 + var_347_4
					end
				end

				arg_344_1.text_.text = var_347_7
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291084", "story_v_out_115291.awb") ~= 0 then
					local var_347_10 = manager.audio:GetVoiceLength("story_v_out_115291", "115291084", "story_v_out_115291.awb") / 1000

					if var_347_10 + var_347_4 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_10 + var_347_4
					end

					if var_347_6.prefab_name ~= "" and arg_344_1.actors_[var_347_6.prefab_name] ~= nil then
						local var_347_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_6.prefab_name].transform, "story_v_out_115291", "115291084", "story_v_out_115291.awb")

						arg_344_1:RecordAudio("115291084", var_347_11)
						arg_344_1:RecordAudio("115291084", var_347_11)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_115291", "115291084", "story_v_out_115291.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_115291", "115291084", "story_v_out_115291.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_12 = math.max(var_347_5, arg_344_1.talkMaxDuration)

			if var_347_4 <= arg_344_1.time_ and arg_344_1.time_ < var_347_4 + var_347_12 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - var_347_4) / var_347_12

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= var_347_4 + var_347_12 and arg_344_1.time_ < var_347_4 + var_347_12 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_344_1:InitPlayNodeList()
	end,
	Play115291085 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 115291085
		arg_348_1.duration_ = 8

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play115291086(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			if arg_348_1.bgs_.RO0502 == nil then
				local var_351_0 = Object.Instantiate(arg_348_1.paintGo_)

				var_351_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "RO0502")
				var_351_0.name = "RO0502"
				var_351_0.transform.parent = arg_348_1.stage_.transform
				var_351_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_348_1.bgs_.RO0502 = var_351_0
			end

			if 1 < arg_348_1.time_ and arg_348_1.time_ <= 1 + arg_351_0 then
				local var_351_1 = arg_348_1.bgs_.RO0502

				arg_348_1.bgs_.RO0502.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_351_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_351_2 = var_351_1:GetComponent("SpriteRenderer")

				if var_351_2 and var_351_2.sprite then
					local var_351_3 = 2 * (var_351_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_351_1.transform.localScale = Vector3.New(var_351_3 / var_351_2.sprite.bounds.size.y < var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x and var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x or var_351_3 / var_351_2.sprite.bounds.size.y, var_351_3 / var_351_2.sprite.bounds.size.y < var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x and var_351_3 * manager.ui.mainCameraCom_.aspect / var_351_2.sprite.bounds.size.x or var_351_3 / var_351_2.sprite.bounds.size.y, 0)
				end

				for iter_351_0, iter_351_1 in pairs(arg_348_1.bgs_) do
					if iter_351_0 ~= "RO0502" then
						iter_351_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_351_4 = 0

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= var_351_4 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = false

				arg_348_1:SetGaussion(false)
			end

			local var_351_5 = 1

			if var_351_4 <= arg_348_1.time_ and arg_348_1.time_ < var_351_4 + var_351_5 then
				local var_351_6 = Color.New(0, 0, 0)

				var_351_6.a = Mathf.Lerp(0, 1, (arg_348_1.time_ - var_351_4) / var_351_5)
				arg_348_1.mask_.color = var_351_6
			end

			if arg_348_1.time_ >= var_351_4 + var_351_5 and arg_348_1.time_ < var_351_4 + var_351_5 + arg_351_0 then
				local var_351_7 = Color.New(0, 0, 0)

				var_351_7.a = 1
				arg_348_1.mask_.color = var_351_7
			end

			local var_351_8 = 1

			if 1 < arg_348_1.time_ and arg_348_1.time_ <= var_351_8 + arg_351_0 then
				arg_348_1.mask_.enabled = true
				arg_348_1.mask_.raycastTarget = false

				arg_348_1:SetGaussion(false)
			end

			local var_351_9 = 2

			if var_351_8 <= arg_348_1.time_ and arg_348_1.time_ < var_351_8 + var_351_9 then
				local var_351_10 = Color.New(0, 0, 0)

				var_351_10.a = Mathf.Lerp(1, 0, (arg_348_1.time_ - var_351_8) / var_351_9)
				arg_348_1.mask_.color = var_351_10
			end

			if arg_348_1.time_ >= var_351_8 + var_351_9 and arg_348_1.time_ < var_351_8 + var_351_9 + arg_351_0 then
				local var_351_11 = Color.New(0, 0, 0)

				arg_348_1.mask_.enabled = false
				var_351_11.a = 0
				arg_348_1.mask_.color = var_351_11
			end

			local var_351_12 = arg_348_1.actors_["10030"].transform

			if 0.999333333333333 < arg_348_1.time_ and arg_348_1.time_ <= 0.999333333333333 + arg_351_0 then
				arg_348_1.var_.moveOldPos10030 = var_351_12.localPosition
				var_351_12.localScale = Vector3.New(1, 1, 1)

				arg_348_1:CheckSpriteTmpPos("10030", 7)

				for iter_351_2 = 0, var_351_12.childCount - 1 do
					local var_351_13 = var_351_12:GetChild(iter_351_2)

					if var_351_13.name == "split_3" or not string.find(var_351_13.name, "split") then
						var_351_13.gameObject:SetActive(true)
					else
						var_351_13.gameObject:SetActive(false)
					end
				end
			end

			local var_351_14 = 0.001

			if 0.999333333333333 <= arg_348_1.time_ and arg_348_1.time_ < 0.999333333333333 + var_351_14 then
				var_351_12.localPosition = Vector3.Lerp(arg_348_1.var_.moveOldPos10030, Vector3.New(0, -2000, 150), (arg_348_1.time_ - 0.999333333333333) / var_351_14)
			end

			if arg_348_1.time_ >= 0.999333333333333 + var_351_14 and arg_348_1.time_ < 0.999333333333333 + var_351_14 + arg_351_0 then
				var_351_12.localPosition = Vector3.New(0, -2000, 150)
			end

			if arg_348_1.frameCnt_ <= 1 then
				arg_348_1.dialog_:SetActive(false)
			end

			local var_351_15 = 3
			local var_351_16 = 1.55

			if 3 < arg_348_1.time_ and arg_348_1.time_ <= var_351_15 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0

				arg_348_1.dialog_:SetActive(true)

				arg_348_1.dialogCg_.alpha = 0

				local var_351_17 = LeanTween.value(arg_348_1.dialog_, 0, 1, 0.3)

				var_351_17:setOnUpdate(LuaHelper.FloatAction(function(arg_352_0)
					arg_348_1.dialogCg_.alpha = arg_352_0
				end))
				var_351_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_348_1.dialog_)
					var_351_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_348_1.duration_ = arg_348_1.duration_ + 0.3

				SetActive(arg_348_1.leftNameGo_, false)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_18 = arg_348_1:FormatText(arg_348_1:GetWordFromCfg(115291085).content)

				arg_348_1.text_.text = var_351_18

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_20 = 62 <= 0 and var_351_16 or var_351_16 * (utf8.len(var_351_18) / 62)

				if (62 <= 0 and var_351_16 or var_351_16 * (utf8.len(var_351_18) / 62)) > 0 and var_351_16 < var_351_20 then
					arg_348_1.talkMaxDuration = var_351_20
					var_351_15 = var_351_15 + 0.3

					if var_351_20 + var_351_15 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_20 + var_351_15
					end
				end

				arg_348_1.text_.text = var_351_18
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)
				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_21 = var_351_15 + 0.3
			local var_351_22 = math.max(var_351_16, arg_348_1.talkMaxDuration)

			if var_351_15 + 0.3 <= arg_348_1.time_ and arg_348_1.time_ < var_351_21 + var_351_22 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - var_351_21) / var_351_22

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= var_351_21 + var_351_22 and arg_348_1.time_ < var_351_21 + var_351_22 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.999333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_348_1:InitPlayNodeList()
	end,
	Play115291086 = function(arg_354_0, arg_354_1)
		arg_354_1.time_ = 0
		arg_354_1.frameCnt_ = 0
		arg_354_1.state_ = "playing"
		arg_354_1.curTalkId_ = 115291086
		arg_354_1.duration_ = 5

		SetActive(arg_354_1.tipsGo_, false)

		function arg_354_1.onSingleLineFinish_()
			arg_354_1.onSingleLineUpdate_ = nil
			arg_354_1.onSingleLineFinish_ = nil
			arg_354_1.state_ = "waiting"
		end

		function arg_354_1.playNext_(arg_356_0)
			if arg_356_0 == 1 then
				arg_354_0:Play115291087(arg_354_1)
			end
		end

		function arg_354_1.onSingleLineUpdate_(arg_357_0)
			local var_357_0 = 0.8

			if 0 < arg_354_1.time_ and arg_354_1.time_ <= 0 + arg_357_0 then
				arg_354_1.talkMaxDuration = 0
				arg_354_1.dialogCg_.alpha = 1

				arg_354_1.dialog_:SetActive(true)
				SetActive(arg_354_1.leftNameGo_, false)

				arg_354_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_354_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_354_1:RecordName(arg_354_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_354_1.iconTrs_.gameObject, false)
				arg_354_1.callingController_:SetSelectedState("normal")

				local var_357_1 = arg_354_1:FormatText(arg_354_1:GetWordFromCfg(115291086).content)

				arg_354_1.text_.text = var_357_1

				LuaForUtil.ClearLinePrefixSymbol(arg_354_1.text_)

				local var_357_3 = 32 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 32)

				if (32 <= 0 and var_357_0 or var_357_0 * (utf8.len(var_357_1) / 32)) > 0 and var_357_0 < var_357_3 then
					arg_354_1.talkMaxDuration = var_357_3

					if var_357_3 + 0 > arg_354_1.duration_ then
						arg_354_1.duration_ = var_357_3 + 0
					end
				end

				arg_354_1.text_.text = var_357_1
				arg_354_1.typewritter.percent = 0

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(false)
				arg_354_1:RecordContent(arg_354_1.text_.text)
			end

			local var_357_4 = math.max(var_357_0, arg_354_1.talkMaxDuration)

			if 0 <= arg_354_1.time_ and arg_354_1.time_ < 0 + var_357_4 then
				arg_354_1.typewritter.percent = (arg_354_1.time_ - 0) / var_357_4

				arg_354_1.typewritter:SetDirty()
			end

			if arg_354_1.time_ >= 0 + var_357_4 and arg_354_1.time_ < 0 + var_357_4 + arg_357_0 then
				arg_354_1.typewritter.percent = 1

				arg_354_1.typewritter:SetDirty()
				arg_354_1:ShowNextGo(true)
			end
		end

		arg_354_1.nodeConfigList_ = {}

		arg_354_1:InitPlayNodeList()
	end,
	Play115291087 = function(arg_358_0, arg_358_1)
		arg_358_1.time_ = 0
		arg_358_1.frameCnt_ = 0
		arg_358_1.state_ = "playing"
		arg_358_1.curTalkId_ = 115291087
		arg_358_1.duration_ = 5

		SetActive(arg_358_1.tipsGo_, false)

		function arg_358_1.onSingleLineFinish_()
			arg_358_1.onSingleLineUpdate_ = nil
			arg_358_1.onSingleLineFinish_ = nil
			arg_358_1.state_ = "waiting"
		end

		function arg_358_1.playNext_(arg_360_0)
			if arg_360_0 == 1 then
				arg_358_0:Play115291088(arg_358_1)
			end
		end

		function arg_358_1.onSingleLineUpdate_(arg_361_0)
			local var_361_0 = 0.325

			if 0 < arg_358_1.time_ and arg_358_1.time_ <= 0 + arg_361_0 then
				arg_358_1.talkMaxDuration = 0
				arg_358_1.dialogCg_.alpha = 1

				arg_358_1.dialog_:SetActive(true)
				SetActive(arg_358_1.leftNameGo_, false)

				arg_358_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_358_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_358_1:RecordName(arg_358_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_358_1.iconTrs_.gameObject, false)
				arg_358_1.callingController_:SetSelectedState("normal")

				local var_361_1 = arg_358_1:FormatText(arg_358_1:GetWordFromCfg(115291087).content)

				arg_358_1.text_.text = var_361_1

				LuaForUtil.ClearLinePrefixSymbol(arg_358_1.text_)

				local var_361_3 = 13 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 13)

				if (13 <= 0 and var_361_0 or var_361_0 * (utf8.len(var_361_1) / 13)) > 0 and var_361_0 < var_361_3 then
					arg_358_1.talkMaxDuration = var_361_3

					if var_361_3 + 0 > arg_358_1.duration_ then
						arg_358_1.duration_ = var_361_3 + 0
					end
				end

				arg_358_1.text_.text = var_361_1
				arg_358_1.typewritter.percent = 0

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(false)
				arg_358_1:RecordContent(arg_358_1.text_.text)
			end

			local var_361_4 = math.max(var_361_0, arg_358_1.talkMaxDuration)

			if 0 <= arg_358_1.time_ and arg_358_1.time_ < 0 + var_361_4 then
				arg_358_1.typewritter.percent = (arg_358_1.time_ - 0) / var_361_4

				arg_358_1.typewritter:SetDirty()
			end

			if arg_358_1.time_ >= 0 + var_361_4 and arg_358_1.time_ < 0 + var_361_4 + arg_361_0 then
				arg_358_1.typewritter.percent = 1

				arg_358_1.typewritter:SetDirty()
				arg_358_1:ShowNextGo(true)
			end
		end

		arg_358_1.nodeConfigList_ = {}

		arg_358_1:InitPlayNodeList()
	end,
	Play115291088 = function(arg_362_0, arg_362_1)
		arg_362_1.time_ = 0
		arg_362_1.frameCnt_ = 0
		arg_362_1.state_ = "playing"
		arg_362_1.curTalkId_ = 115291088
		arg_362_1.duration_ = 3

		local var_362_0 = {
			ja = 3,
			ko = 1.9,
			zh = 2.7,
			en = 1.7
		}
		local var_362_1 = manager.audio:GetLocalizationFlag()

		if var_362_0[var_362_1] ~= nil then
			arg_362_1.duration_ = var_362_0[var_362_1]
		end

		SetActive(arg_362_1.tipsGo_, false)

		function arg_362_1.onSingleLineFinish_()
			arg_362_1.onSingleLineUpdate_ = nil
			arg_362_1.onSingleLineFinish_ = nil
			arg_362_1.state_ = "waiting"
		end

		function arg_362_1.playNext_(arg_364_0)
			if arg_364_0 == 1 then
				arg_362_0:Play115291089(arg_362_1)
			end
		end

		function arg_362_1.onSingleLineUpdate_(arg_365_0)
			local var_365_0 = 0.175

			if 0 < arg_362_1.time_ and arg_362_1.time_ <= 0 + arg_365_0 then
				arg_362_1.talkMaxDuration = 0
				arg_362_1.dialogCg_.alpha = 1

				arg_362_1.dialog_:SetActive(true)
				SetActive(arg_362_1.leftNameGo_, true)

				arg_362_1.leftNameTxt_.text = arg_362_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_362_1.leftNameTxt_.transform)

				arg_362_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_362_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_362_1:RecordName(arg_362_1.leftNameTxt_.text)
				SetActive(arg_362_1.iconTrs_.gameObject, false)
				arg_362_1.callingController_:SetSelectedState("normal")

				local var_365_1 = arg_362_1:GetWordFromCfg(115291088)
				local var_365_2 = arg_362_1:FormatText(var_365_1.content)

				arg_362_1.text_.text = var_365_2

				LuaForUtil.ClearLinePrefixSymbol(arg_362_1.text_)

				local var_365_4 = 7 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 7)

				if (7 <= 0 and var_365_0 or var_365_0 * (utf8.len(var_365_2) / 7)) > 0 and var_365_0 < var_365_4 then
					arg_362_1.talkMaxDuration = var_365_4

					if var_365_4 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_4 + 0
					end
				end

				arg_362_1.text_.text = var_365_2
				arg_362_1.typewritter.percent = 0

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291088", "story_v_out_115291.awb") ~= 0 then
					local var_365_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291088", "story_v_out_115291.awb") / 1000

					if var_365_5 + 0 > arg_362_1.duration_ then
						arg_362_1.duration_ = var_365_5 + 0
					end

					if var_365_1.prefab_name ~= "" and arg_362_1.actors_[var_365_1.prefab_name] ~= nil then
						local var_365_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_362_1.actors_[var_365_1.prefab_name].transform, "story_v_out_115291", "115291088", "story_v_out_115291.awb")

						arg_362_1:RecordAudio("115291088", var_365_6)
						arg_362_1:RecordAudio("115291088", var_365_6)
					else
						arg_362_1:AudioAction("play", "voice", "story_v_out_115291", "115291088", "story_v_out_115291.awb")
					end

					arg_362_1:RecordHistoryTalkVoice("story_v_out_115291", "115291088", "story_v_out_115291.awb")
				end

				arg_362_1:RecordContent(arg_362_1.text_.text)
			end

			local var_365_7 = math.max(var_365_0, arg_362_1.talkMaxDuration)

			if 0 <= arg_362_1.time_ and arg_362_1.time_ < 0 + var_365_7 then
				arg_362_1.typewritter.percent = (arg_362_1.time_ - 0) / var_365_7

				arg_362_1.typewritter:SetDirty()
			end

			if arg_362_1.time_ >= 0 + var_365_7 and arg_362_1.time_ < 0 + var_365_7 + arg_365_0 then
				arg_362_1.typewritter.percent = 1

				arg_362_1.typewritter:SetDirty()
				arg_362_1:ShowNextGo(true)
			end
		end

		arg_362_1.nodeConfigList_ = {}

		arg_362_1:InitPlayNodeList()
	end,
	Play115291089 = function(arg_366_0, arg_366_1)
		arg_366_1.time_ = 0
		arg_366_1.frameCnt_ = 0
		arg_366_1.state_ = "playing"
		arg_366_1.curTalkId_ = 115291089
		arg_366_1.duration_ = 5

		SetActive(arg_366_1.tipsGo_, false)

		function arg_366_1.onSingleLineFinish_()
			arg_366_1.onSingleLineUpdate_ = nil
			arg_366_1.onSingleLineFinish_ = nil
			arg_366_1.state_ = "waiting"
		end

		function arg_366_1.playNext_(arg_368_0)
			if arg_368_0 == 1 then
				arg_366_0:Play115291090(arg_366_1)
			end
		end

		function arg_366_1.onSingleLineUpdate_(arg_369_0)
			local var_369_0 = 0.5

			if 0 < arg_366_1.time_ and arg_366_1.time_ <= 0 + arg_369_0 then
				arg_366_1.talkMaxDuration = 0
				arg_366_1.dialogCg_.alpha = 1

				arg_366_1.dialog_:SetActive(true)
				SetActive(arg_366_1.leftNameGo_, false)

				arg_366_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_366_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_366_1:RecordName(arg_366_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_366_1.iconTrs_.gameObject, false)
				arg_366_1.callingController_:SetSelectedState("normal")

				local var_369_1 = arg_366_1:FormatText(arg_366_1:GetWordFromCfg(115291089).content)

				arg_366_1.text_.text = var_369_1

				LuaForUtil.ClearLinePrefixSymbol(arg_366_1.text_)

				local var_369_3 = 20 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 20)

				if (20 <= 0 and var_369_0 or var_369_0 * (utf8.len(var_369_1) / 20)) > 0 and var_369_0 < var_369_3 then
					arg_366_1.talkMaxDuration = var_369_3

					if var_369_3 + 0 > arg_366_1.duration_ then
						arg_366_1.duration_ = var_369_3 + 0
					end
				end

				arg_366_1.text_.text = var_369_1
				arg_366_1.typewritter.percent = 0

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(false)
				arg_366_1:RecordContent(arg_366_1.text_.text)
			end

			local var_369_4 = math.max(var_369_0, arg_366_1.talkMaxDuration)

			if 0 <= arg_366_1.time_ and arg_366_1.time_ < 0 + var_369_4 then
				arg_366_1.typewritter.percent = (arg_366_1.time_ - 0) / var_369_4

				arg_366_1.typewritter:SetDirty()
			end

			if arg_366_1.time_ >= 0 + var_369_4 and arg_366_1.time_ < 0 + var_369_4 + arg_369_0 then
				arg_366_1.typewritter.percent = 1

				arg_366_1.typewritter:SetDirty()
				arg_366_1:ShowNextGo(true)
			end
		end

		arg_366_1.nodeConfigList_ = {}

		arg_366_1:InitPlayNodeList()
	end,
	Play115291090 = function(arg_370_0, arg_370_1)
		arg_370_1.time_ = 0
		arg_370_1.frameCnt_ = 0
		arg_370_1.state_ = "playing"
		arg_370_1.curTalkId_ = 115291090
		arg_370_1.duration_ = 5

		SetActive(arg_370_1.tipsGo_, false)

		function arg_370_1.onSingleLineFinish_()
			arg_370_1.onSingleLineUpdate_ = nil
			arg_370_1.onSingleLineFinish_ = nil
			arg_370_1.state_ = "waiting"
		end

		function arg_370_1.playNext_(arg_372_0)
			if arg_372_0 == 1 then
				arg_370_0:Play115291091(arg_370_1)
			end
		end

		function arg_370_1.onSingleLineUpdate_(arg_373_0)
			local var_373_0 = 1.475

			if 0 < arg_370_1.time_ and arg_370_1.time_ <= 0 + arg_373_0 then
				arg_370_1.talkMaxDuration = 0
				arg_370_1.dialogCg_.alpha = 1

				arg_370_1.dialog_:SetActive(true)
				SetActive(arg_370_1.leftNameGo_, false)

				arg_370_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_370_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_370_1:RecordName(arg_370_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_370_1.iconTrs_.gameObject, false)
				arg_370_1.callingController_:SetSelectedState("normal")

				local var_373_1 = arg_370_1:FormatText(arg_370_1:GetWordFromCfg(115291090).content)

				arg_370_1.text_.text = var_373_1

				LuaForUtil.ClearLinePrefixSymbol(arg_370_1.text_)

				local var_373_3 = 59 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 59)

				if (59 <= 0 and var_373_0 or var_373_0 * (utf8.len(var_373_1) / 59)) > 0 and var_373_0 < var_373_3 then
					arg_370_1.talkMaxDuration = var_373_3

					if var_373_3 + 0 > arg_370_1.duration_ then
						arg_370_1.duration_ = var_373_3 + 0
					end
				end

				arg_370_1.text_.text = var_373_1
				arg_370_1.typewritter.percent = 0

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(false)
				arg_370_1:RecordContent(arg_370_1.text_.text)
			end

			local var_373_4 = math.max(var_373_0, arg_370_1.talkMaxDuration)

			if 0 <= arg_370_1.time_ and arg_370_1.time_ < 0 + var_373_4 then
				arg_370_1.typewritter.percent = (arg_370_1.time_ - 0) / var_373_4

				arg_370_1.typewritter:SetDirty()
			end

			if arg_370_1.time_ >= 0 + var_373_4 and arg_370_1.time_ < 0 + var_373_4 + arg_373_0 then
				arg_370_1.typewritter.percent = 1

				arg_370_1.typewritter:SetDirty()
				arg_370_1:ShowNextGo(true)
			end
		end

		arg_370_1.nodeConfigList_ = {}

		arg_370_1:InitPlayNodeList()
	end,
	Play115291091 = function(arg_374_0, arg_374_1)
		arg_374_1.time_ = 0
		arg_374_1.frameCnt_ = 0
		arg_374_1.state_ = "playing"
		arg_374_1.curTalkId_ = 115291091
		arg_374_1.duration_ = 5

		SetActive(arg_374_1.tipsGo_, false)

		function arg_374_1.onSingleLineFinish_()
			arg_374_1.onSingleLineUpdate_ = nil
			arg_374_1.onSingleLineFinish_ = nil
			arg_374_1.state_ = "waiting"
		end

		function arg_374_1.playNext_(arg_376_0)
			if arg_376_0 == 1 then
				arg_374_0:Play115291092(arg_374_1)
			end
		end

		function arg_374_1.onSingleLineUpdate_(arg_377_0)
			local var_377_0 = 0.7

			if 0 < arg_374_1.time_ and arg_374_1.time_ <= 0 + arg_377_0 then
				arg_374_1.talkMaxDuration = 0
				arg_374_1.dialogCg_.alpha = 1

				arg_374_1.dialog_:SetActive(true)
				SetActive(arg_374_1.leftNameGo_, false)

				arg_374_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_374_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_374_1:RecordName(arg_374_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_374_1.iconTrs_.gameObject, false)
				arg_374_1.callingController_:SetSelectedState("normal")

				local var_377_1 = arg_374_1:FormatText(arg_374_1:GetWordFromCfg(115291091).content)

				arg_374_1.text_.text = var_377_1

				LuaForUtil.ClearLinePrefixSymbol(arg_374_1.text_)

				local var_377_3 = 28 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 28)

				if (28 <= 0 and var_377_0 or var_377_0 * (utf8.len(var_377_1) / 28)) > 0 and var_377_0 < var_377_3 then
					arg_374_1.talkMaxDuration = var_377_3

					if var_377_3 + 0 > arg_374_1.duration_ then
						arg_374_1.duration_ = var_377_3 + 0
					end
				end

				arg_374_1.text_.text = var_377_1
				arg_374_1.typewritter.percent = 0

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(false)
				arg_374_1:RecordContent(arg_374_1.text_.text)
			end

			local var_377_4 = math.max(var_377_0, arg_374_1.talkMaxDuration)

			if 0 <= arg_374_1.time_ and arg_374_1.time_ < 0 + var_377_4 then
				arg_374_1.typewritter.percent = (arg_374_1.time_ - 0) / var_377_4

				arg_374_1.typewritter:SetDirty()
			end

			if arg_374_1.time_ >= 0 + var_377_4 and arg_374_1.time_ < 0 + var_377_4 + arg_377_0 then
				arg_374_1.typewritter.percent = 1

				arg_374_1.typewritter:SetDirty()
				arg_374_1:ShowNextGo(true)
			end
		end

		arg_374_1.nodeConfigList_ = {}

		arg_374_1:InitPlayNodeList()
	end,
	Play115291092 = function(arg_378_0, arg_378_1)
		arg_378_1.time_ = 0
		arg_378_1.frameCnt_ = 0
		arg_378_1.state_ = "playing"
		arg_378_1.curTalkId_ = 115291092
		arg_378_1.duration_ = 3.7

		local var_378_0 = {
			ja = 2.5,
			ko = 1.1,
			zh = 3.7,
			en = 1.1
		}
		local var_378_1 = manager.audio:GetLocalizationFlag()

		if var_378_0[var_378_1] ~= nil then
			arg_378_1.duration_ = var_378_0[var_378_1]
		end

		SetActive(arg_378_1.tipsGo_, false)

		function arg_378_1.onSingleLineFinish_()
			arg_378_1.onSingleLineUpdate_ = nil
			arg_378_1.onSingleLineFinish_ = nil
			arg_378_1.state_ = "waiting"
		end

		function arg_378_1.playNext_(arg_380_0)
			if arg_380_0 == 1 then
				arg_378_0:Play115291093(arg_378_1)
			end
		end

		function arg_378_1.onSingleLineUpdate_(arg_381_0)
			local var_381_0 = 0.075

			if 0 < arg_378_1.time_ and arg_378_1.time_ <= 0 + arg_381_0 then
				arg_378_1.talkMaxDuration = 0
				arg_378_1.dialogCg_.alpha = 1

				arg_378_1.dialog_:SetActive(true)
				SetActive(arg_378_1.leftNameGo_, true)

				arg_378_1.leftNameTxt_.text = arg_378_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_378_1.leftNameTxt_.transform)

				arg_378_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_378_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_378_1:RecordName(arg_378_1.leftNameTxt_.text)
				SetActive(arg_378_1.iconTrs_.gameObject, false)
				arg_378_1.callingController_:SetSelectedState("normal")

				local var_381_1 = arg_378_1:GetWordFromCfg(115291092)
				local var_381_2 = arg_378_1:FormatText(var_381_1.content)

				arg_378_1.text_.text = var_381_2

				LuaForUtil.ClearLinePrefixSymbol(arg_378_1.text_)

				local var_381_4 = 3 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 3)

				if (3 <= 0 and var_381_0 or var_381_0 * (utf8.len(var_381_2) / 3)) > 0 and var_381_0 < var_381_4 then
					arg_378_1.talkMaxDuration = var_381_4

					if var_381_4 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_4 + 0
					end
				end

				arg_378_1.text_.text = var_381_2
				arg_378_1.typewritter.percent = 0

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291092", "story_v_out_115291.awb") ~= 0 then
					local var_381_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291092", "story_v_out_115291.awb") / 1000

					if var_381_5 + 0 > arg_378_1.duration_ then
						arg_378_1.duration_ = var_381_5 + 0
					end

					if var_381_1.prefab_name ~= "" and arg_378_1.actors_[var_381_1.prefab_name] ~= nil then
						local var_381_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_378_1.actors_[var_381_1.prefab_name].transform, "story_v_out_115291", "115291092", "story_v_out_115291.awb")

						arg_378_1:RecordAudio("115291092", var_381_6)
						arg_378_1:RecordAudio("115291092", var_381_6)
					else
						arg_378_1:AudioAction("play", "voice", "story_v_out_115291", "115291092", "story_v_out_115291.awb")
					end

					arg_378_1:RecordHistoryTalkVoice("story_v_out_115291", "115291092", "story_v_out_115291.awb")
				end

				arg_378_1:RecordContent(arg_378_1.text_.text)
			end

			local var_381_7 = math.max(var_381_0, arg_378_1.talkMaxDuration)

			if 0 <= arg_378_1.time_ and arg_378_1.time_ < 0 + var_381_7 then
				arg_378_1.typewritter.percent = (arg_378_1.time_ - 0) / var_381_7

				arg_378_1.typewritter:SetDirty()
			end

			if arg_378_1.time_ >= 0 + var_381_7 and arg_378_1.time_ < 0 + var_381_7 + arg_381_0 then
				arg_378_1.typewritter.percent = 1

				arg_378_1.typewritter:SetDirty()
				arg_378_1:ShowNextGo(true)
			end
		end

		arg_378_1.nodeConfigList_ = {}

		arg_378_1:InitPlayNodeList()
	end,
	Play115291093 = function(arg_382_0, arg_382_1)
		arg_382_1.time_ = 0
		arg_382_1.frameCnt_ = 0
		arg_382_1.state_ = "playing"
		arg_382_1.curTalkId_ = 115291093
		arg_382_1.duration_ = 5

		SetActive(arg_382_1.tipsGo_, false)

		function arg_382_1.onSingleLineFinish_()
			arg_382_1.onSingleLineUpdate_ = nil
			arg_382_1.onSingleLineFinish_ = nil
			arg_382_1.state_ = "waiting"
		end

		function arg_382_1.playNext_(arg_384_0)
			if arg_384_0 == 1 then
				arg_382_0:Play115291094(arg_382_1)
			end
		end

		function arg_382_1.onSingleLineUpdate_(arg_385_0)
			local var_385_0 = 0.925

			if 0 < arg_382_1.time_ and arg_382_1.time_ <= 0 + arg_385_0 then
				arg_382_1.talkMaxDuration = 0
				arg_382_1.dialogCg_.alpha = 1

				arg_382_1.dialog_:SetActive(true)
				SetActive(arg_382_1.leftNameGo_, false)

				arg_382_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_382_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_382_1:RecordName(arg_382_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_382_1.iconTrs_.gameObject, false)
				arg_382_1.callingController_:SetSelectedState("normal")

				local var_385_1 = arg_382_1:FormatText(arg_382_1:GetWordFromCfg(115291093).content)

				arg_382_1.text_.text = var_385_1

				LuaForUtil.ClearLinePrefixSymbol(arg_382_1.text_)

				local var_385_3 = 37 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 37)

				if (37 <= 0 and var_385_0 or var_385_0 * (utf8.len(var_385_1) / 37)) > 0 and var_385_0 < var_385_3 then
					arg_382_1.talkMaxDuration = var_385_3

					if var_385_3 + 0 > arg_382_1.duration_ then
						arg_382_1.duration_ = var_385_3 + 0
					end
				end

				arg_382_1.text_.text = var_385_1
				arg_382_1.typewritter.percent = 0

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(false)
				arg_382_1:RecordContent(arg_382_1.text_.text)
			end

			local var_385_4 = math.max(var_385_0, arg_382_1.talkMaxDuration)

			if 0 <= arg_382_1.time_ and arg_382_1.time_ < 0 + var_385_4 then
				arg_382_1.typewritter.percent = (arg_382_1.time_ - 0) / var_385_4

				arg_382_1.typewritter:SetDirty()
			end

			if arg_382_1.time_ >= 0 + var_385_4 and arg_382_1.time_ < 0 + var_385_4 + arg_385_0 then
				arg_382_1.typewritter.percent = 1

				arg_382_1.typewritter:SetDirty()
				arg_382_1:ShowNextGo(true)
			end
		end

		arg_382_1.nodeConfigList_ = {}

		arg_382_1:InitPlayNodeList()
	end,
	Play115291094 = function(arg_386_0, arg_386_1)
		arg_386_1.time_ = 0
		arg_386_1.frameCnt_ = 0
		arg_386_1.state_ = "playing"
		arg_386_1.curTalkId_ = 115291094
		arg_386_1.duration_ = 5

		SetActive(arg_386_1.tipsGo_, false)

		function arg_386_1.onSingleLineFinish_()
			arg_386_1.onSingleLineUpdate_ = nil
			arg_386_1.onSingleLineFinish_ = nil
			arg_386_1.state_ = "waiting"
		end

		function arg_386_1.playNext_(arg_388_0)
			if arg_388_0 == 1 then
				arg_386_0:Play115291095(arg_386_1)
			end
		end

		function arg_386_1.onSingleLineUpdate_(arg_389_0)
			local var_389_0 = 0.625

			if 0 < arg_386_1.time_ and arg_386_1.time_ <= 0 + arg_389_0 then
				arg_386_1.talkMaxDuration = 0
				arg_386_1.dialogCg_.alpha = 1

				arg_386_1.dialog_:SetActive(true)
				SetActive(arg_386_1.leftNameGo_, false)

				arg_386_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_386_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_386_1:RecordName(arg_386_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_386_1.iconTrs_.gameObject, false)
				arg_386_1.callingController_:SetSelectedState("normal")

				local var_389_1 = arg_386_1:FormatText(arg_386_1:GetWordFromCfg(115291094).content)

				arg_386_1.text_.text = var_389_1

				LuaForUtil.ClearLinePrefixSymbol(arg_386_1.text_)

				local var_389_3 = 25 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 25)

				if (25 <= 0 and var_389_0 or var_389_0 * (utf8.len(var_389_1) / 25)) > 0 and var_389_0 < var_389_3 then
					arg_386_1.talkMaxDuration = var_389_3

					if var_389_3 + 0 > arg_386_1.duration_ then
						arg_386_1.duration_ = var_389_3 + 0
					end
				end

				arg_386_1.text_.text = var_389_1
				arg_386_1.typewritter.percent = 0

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(false)
				arg_386_1:RecordContent(arg_386_1.text_.text)
			end

			local var_389_4 = math.max(var_389_0, arg_386_1.talkMaxDuration)

			if 0 <= arg_386_1.time_ and arg_386_1.time_ < 0 + var_389_4 then
				arg_386_1.typewritter.percent = (arg_386_1.time_ - 0) / var_389_4

				arg_386_1.typewritter:SetDirty()
			end

			if arg_386_1.time_ >= 0 + var_389_4 and arg_386_1.time_ < 0 + var_389_4 + arg_389_0 then
				arg_386_1.typewritter.percent = 1

				arg_386_1.typewritter:SetDirty()
				arg_386_1:ShowNextGo(true)
			end
		end

		arg_386_1.nodeConfigList_ = {}

		arg_386_1:InitPlayNodeList()
	end,
	Play115291095 = function(arg_390_0, arg_390_1)
		arg_390_1.time_ = 0
		arg_390_1.frameCnt_ = 0
		arg_390_1.state_ = "playing"
		arg_390_1.curTalkId_ = 115291095
		arg_390_1.duration_ = 5

		SetActive(arg_390_1.tipsGo_, false)

		function arg_390_1.onSingleLineFinish_()
			arg_390_1.onSingleLineUpdate_ = nil
			arg_390_1.onSingleLineFinish_ = nil
			arg_390_1.state_ = "waiting"
		end

		function arg_390_1.playNext_(arg_392_0)
			if arg_392_0 == 1 then
				arg_390_0:Play115291096(arg_390_1)
			end
		end

		function arg_390_1.onSingleLineUpdate_(arg_393_0)
			local var_393_0 = 0.2

			if 0 < arg_390_1.time_ and arg_390_1.time_ <= 0 + arg_393_0 then
				arg_390_1.talkMaxDuration = 0
				arg_390_1.dialogCg_.alpha = 1

				arg_390_1.dialog_:SetActive(true)
				SetActive(arg_390_1.leftNameGo_, false)

				arg_390_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_390_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_390_1:RecordName(arg_390_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_390_1.iconTrs_.gameObject, false)
				arg_390_1.callingController_:SetSelectedState("normal")

				local var_393_1 = arg_390_1:FormatText(arg_390_1:GetWordFromCfg(115291095).content)

				arg_390_1.text_.text = var_393_1

				LuaForUtil.ClearLinePrefixSymbol(arg_390_1.text_)

				local var_393_3 = 8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 8)

				if (8 <= 0 and var_393_0 or var_393_0 * (utf8.len(var_393_1) / 8)) > 0 and var_393_0 < var_393_3 then
					arg_390_1.talkMaxDuration = var_393_3

					if var_393_3 + 0 > arg_390_1.duration_ then
						arg_390_1.duration_ = var_393_3 + 0
					end
				end

				arg_390_1.text_.text = var_393_1
				arg_390_1.typewritter.percent = 0

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(false)
				arg_390_1:RecordContent(arg_390_1.text_.text)
			end

			local var_393_4 = math.max(var_393_0, arg_390_1.talkMaxDuration)

			if 0 <= arg_390_1.time_ and arg_390_1.time_ < 0 + var_393_4 then
				arg_390_1.typewritter.percent = (arg_390_1.time_ - 0) / var_393_4

				arg_390_1.typewritter:SetDirty()
			end

			if arg_390_1.time_ >= 0 + var_393_4 and arg_390_1.time_ < 0 + var_393_4 + arg_393_0 then
				arg_390_1.typewritter.percent = 1

				arg_390_1.typewritter:SetDirty()
				arg_390_1:ShowNextGo(true)
			end
		end

		arg_390_1.nodeConfigList_ = {}

		arg_390_1:InitPlayNodeList()
	end,
	Play115291096 = function(arg_394_0, arg_394_1)
		arg_394_1.time_ = 0
		arg_394_1.frameCnt_ = 0
		arg_394_1.state_ = "playing"
		arg_394_1.curTalkId_ = 115291096
		arg_394_1.duration_ = 6.1

		local var_394_0 = {
			ja = 6.1,
			ko = 1.3,
			zh = 2.466,
			en = 1.533
		}
		local var_394_1 = manager.audio:GetLocalizationFlag()

		if var_394_0[var_394_1] ~= nil then
			arg_394_1.duration_ = var_394_0[var_394_1]
		end

		SetActive(arg_394_1.tipsGo_, false)

		function arg_394_1.onSingleLineFinish_()
			arg_394_1.onSingleLineUpdate_ = nil
			arg_394_1.onSingleLineFinish_ = nil
			arg_394_1.state_ = "waiting"
		end

		function arg_394_1.playNext_(arg_396_0)
			if arg_396_0 == 1 then
				arg_394_0:Play115291097(arg_394_1)
			end
		end

		function arg_394_1.onSingleLineUpdate_(arg_397_0)
			local var_397_0 = 0.15

			if 0 < arg_394_1.time_ and arg_394_1.time_ <= 0 + arg_397_0 then
				arg_394_1.talkMaxDuration = 0
				arg_394_1.dialogCg_.alpha = 1

				arg_394_1.dialog_:SetActive(true)
				SetActive(arg_394_1.leftNameGo_, true)

				arg_394_1.leftNameTxt_.text = arg_394_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_394_1.leftNameTxt_.transform)

				arg_394_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_394_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_394_1:RecordName(arg_394_1.leftNameTxt_.text)
				SetActive(arg_394_1.iconTrs_.gameObject, false)
				arg_394_1.callingController_:SetSelectedState("normal")

				local var_397_1 = arg_394_1:GetWordFromCfg(115291096)
				local var_397_2 = arg_394_1:FormatText(var_397_1.content)

				arg_394_1.text_.text = var_397_2

				LuaForUtil.ClearLinePrefixSymbol(arg_394_1.text_)

				local var_397_4 = 6 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 6)

				if (6 <= 0 and var_397_0 or var_397_0 * (utf8.len(var_397_2) / 6)) > 0 and var_397_0 < var_397_4 then
					arg_394_1.talkMaxDuration = var_397_4

					if var_397_4 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_4 + 0
					end
				end

				arg_394_1.text_.text = var_397_2
				arg_394_1.typewritter.percent = 0

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291096", "story_v_out_115291.awb") ~= 0 then
					local var_397_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291096", "story_v_out_115291.awb") / 1000

					if var_397_5 + 0 > arg_394_1.duration_ then
						arg_394_1.duration_ = var_397_5 + 0
					end

					if var_397_1.prefab_name ~= "" and arg_394_1.actors_[var_397_1.prefab_name] ~= nil then
						local var_397_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_394_1.actors_[var_397_1.prefab_name].transform, "story_v_out_115291", "115291096", "story_v_out_115291.awb")

						arg_394_1:RecordAudio("115291096", var_397_6)
						arg_394_1:RecordAudio("115291096", var_397_6)
					else
						arg_394_1:AudioAction("play", "voice", "story_v_out_115291", "115291096", "story_v_out_115291.awb")
					end

					arg_394_1:RecordHistoryTalkVoice("story_v_out_115291", "115291096", "story_v_out_115291.awb")
				end

				arg_394_1:RecordContent(arg_394_1.text_.text)
			end

			local var_397_7 = math.max(var_397_0, arg_394_1.talkMaxDuration)

			if 0 <= arg_394_1.time_ and arg_394_1.time_ < 0 + var_397_7 then
				arg_394_1.typewritter.percent = (arg_394_1.time_ - 0) / var_397_7

				arg_394_1.typewritter:SetDirty()
			end

			if arg_394_1.time_ >= 0 + var_397_7 and arg_394_1.time_ < 0 + var_397_7 + arg_397_0 then
				arg_394_1.typewritter.percent = 1

				arg_394_1.typewritter:SetDirty()
				arg_394_1:ShowNextGo(true)
			end
		end

		arg_394_1.nodeConfigList_ = {}

		arg_394_1:InitPlayNodeList()
	end,
	Play115291097 = function(arg_398_0, arg_398_1)
		arg_398_1.time_ = 0
		arg_398_1.frameCnt_ = 0
		arg_398_1.state_ = "playing"
		arg_398_1.curTalkId_ = 115291097
		arg_398_1.duration_ = 9

		SetActive(arg_398_1.tipsGo_, false)

		function arg_398_1.onSingleLineFinish_()
			arg_398_1.onSingleLineUpdate_ = nil
			arg_398_1.onSingleLineFinish_ = nil
			arg_398_1.state_ = "waiting"
		end

		function arg_398_1.playNext_(arg_400_0)
			if arg_400_0 == 1 then
				arg_398_0:Play115291098(arg_398_1)
			end
		end

		function arg_398_1.onSingleLineUpdate_(arg_401_0)
			if 2 < arg_398_1.time_ and arg_398_1.time_ <= 2 + arg_401_0 then
				local var_401_0 = arg_398_1.bgs_.ST22a

				arg_398_1.bgs_.ST22a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_401_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_401_1 = var_401_0:GetComponent("SpriteRenderer")

				if var_401_1 and var_401_1.sprite then
					local var_401_2 = 2 * (var_401_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_401_0.transform.localScale = Vector3.New(var_401_2 / var_401_1.sprite.bounds.size.y < var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x and var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x or var_401_2 / var_401_1.sprite.bounds.size.y, var_401_2 / var_401_1.sprite.bounds.size.y < var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x and var_401_2 * manager.ui.mainCameraCom_.aspect / var_401_1.sprite.bounds.size.x or var_401_2 / var_401_1.sprite.bounds.size.y, 0)
				end

				for iter_401_0, iter_401_1 in pairs(arg_398_1.bgs_) do
					if iter_401_0 ~= "ST22a" then
						iter_401_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_401_3 = 0

			if 0 < arg_398_1.time_ and arg_398_1.time_ <= var_401_3 + arg_401_0 then
				arg_398_1.mask_.enabled = true
				arg_398_1.mask_.raycastTarget = false

				arg_398_1:SetGaussion(false)
			end

			local var_401_4 = 2

			if var_401_3 <= arg_398_1.time_ and arg_398_1.time_ < var_401_3 + var_401_4 then
				local var_401_5 = Color.New(0, 0, 0)

				var_401_5.a = Mathf.Lerp(0, 1, (arg_398_1.time_ - var_401_3) / var_401_4)
				arg_398_1.mask_.color = var_401_5
			end

			if arg_398_1.time_ >= var_401_3 + var_401_4 and arg_398_1.time_ < var_401_3 + var_401_4 + arg_401_0 then
				local var_401_6 = Color.New(0, 0, 0)

				var_401_6.a = 1
				arg_398_1.mask_.color = var_401_6
			end

			local var_401_7 = 2

			if 2 < arg_398_1.time_ and arg_398_1.time_ <= var_401_7 + arg_401_0 then
				arg_398_1.mask_.enabled = true
				arg_398_1.mask_.raycastTarget = false

				arg_398_1:SetGaussion(false)
			end

			local var_401_8 = 2

			if var_401_7 <= arg_398_1.time_ and arg_398_1.time_ < var_401_7 + var_401_8 then
				local var_401_9 = Color.New(0, 0, 0)

				var_401_9.a = Mathf.Lerp(1, 0, (arg_398_1.time_ - var_401_7) / var_401_8)
				arg_398_1.mask_.color = var_401_9
			end

			if arg_398_1.time_ >= var_401_7 + var_401_8 and arg_398_1.time_ < var_401_7 + var_401_8 + arg_401_0 then
				local var_401_10 = Color.New(0, 0, 0)

				arg_398_1.mask_.enabled = false
				var_401_10.a = 0
				arg_398_1.mask_.color = var_401_10
			end

			if arg_398_1.frameCnt_ <= 1 then
				arg_398_1.dialog_:SetActive(false)
			end

			local var_401_11 = 4
			local var_401_12 = 0.8

			if 4 < arg_398_1.time_ and arg_398_1.time_ <= var_401_11 + arg_401_0 then
				arg_398_1.talkMaxDuration = 0

				arg_398_1.dialog_:SetActive(true)

				arg_398_1.dialogCg_.alpha = 0

				local var_401_13 = LeanTween.value(arg_398_1.dialog_, 0, 1, 0.3)

				var_401_13:setOnUpdate(LuaHelper.FloatAction(function(arg_402_0)
					arg_398_1.dialogCg_.alpha = arg_402_0
				end))
				var_401_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_398_1.dialog_)
					var_401_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_398_1.duration_ = arg_398_1.duration_ + 0.3

				SetActive(arg_398_1.leftNameGo_, false)

				arg_398_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_398_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_398_1:RecordName(arg_398_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_398_1.iconTrs_.gameObject, false)
				arg_398_1.callingController_:SetSelectedState("normal")

				local var_401_14 = arg_398_1:FormatText(arg_398_1:GetWordFromCfg(115291097).content)

				arg_398_1.text_.text = var_401_14

				LuaForUtil.ClearLinePrefixSymbol(arg_398_1.text_)

				local var_401_16 = 32 <= 0 and var_401_12 or var_401_12 * (utf8.len(var_401_14) / 32)

				if (32 <= 0 and var_401_12 or var_401_12 * (utf8.len(var_401_14) / 32)) > 0 and var_401_12 < var_401_16 then
					arg_398_1.talkMaxDuration = var_401_16
					var_401_11 = var_401_11 + 0.3

					if var_401_16 + var_401_11 > arg_398_1.duration_ then
						arg_398_1.duration_ = var_401_16 + var_401_11
					end
				end

				arg_398_1.text_.text = var_401_14
				arg_398_1.typewritter.percent = 0

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(false)
				arg_398_1:RecordContent(arg_398_1.text_.text)
			end

			local var_401_17 = var_401_11 + 0.3
			local var_401_18 = math.max(var_401_12, arg_398_1.talkMaxDuration)

			if var_401_11 + 0.3 <= arg_398_1.time_ and arg_398_1.time_ < var_401_17 + var_401_18 then
				arg_398_1.typewritter.percent = (arg_398_1.time_ - var_401_17) / var_401_18

				arg_398_1.typewritter:SetDirty()
			end

			if arg_398_1.time_ >= var_401_17 + var_401_18 and arg_398_1.time_ < var_401_17 + var_401_18 + arg_401_0 then
				arg_398_1.typewritter.percent = 1

				arg_398_1.typewritter:SetDirty()
				arg_398_1:ShowNextGo(true)
			end
		end

		arg_398_1.nodeConfigList_ = {}

		arg_398_1:InitPlayNodeList()
	end,
	Play115291098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 115291098
		arg_404_1.duration_ = 5

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play115291099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 0.75

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, false)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:FormatText(arg_404_1:GetWordFromCfg(115291098).content)

				arg_404_1.text_.text = var_407_1

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_3 = 30 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_1) / 30)

				if (30 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_1) / 30)) > 0 and var_407_0 < var_407_3 then
					arg_404_1.talkMaxDuration = var_407_3

					if var_407_3 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_3 + 0
					end
				end

				arg_404_1.text_.text = var_407_1
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)
				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_4 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_4 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_4

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_4 and arg_404_1.time_ < 0 + var_407_4 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play115291099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 115291099
		arg_408_1.duration_ = 3.9

		local var_408_0 = {
			ja = 3.033,
			ko = 2.366,
			zh = 3.9,
			en = 2.533
		}
		local var_408_1 = manager.audio:GetLocalizationFlag()

		if var_408_0[var_408_1] ~= nil then
			arg_408_1.duration_ = var_408_0[var_408_1]
		end

		SetActive(arg_408_1.tipsGo_, false)

		function arg_408_1.onSingleLineFinish_()
			arg_408_1.onSingleLineUpdate_ = nil
			arg_408_1.onSingleLineFinish_ = nil
			arg_408_1.state_ = "waiting"
		end

		function arg_408_1.playNext_(arg_410_0)
			if arg_410_0 == 1 then
				arg_408_0:Play115291100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.var_.moveOldPos10030 = arg_408_1.actors_["10030"].transform.localPosition
				arg_408_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_408_1:CheckSpriteTmpPos("10030", 3)

				for iter_411_0 = 0, arg_408_1.actors_["10030"].transform.childCount - 1 do
					local var_411_0 = arg_408_1.actors_["10030"].transform:GetChild(iter_411_0)

					if var_411_0.name == "split_1" or not string.find(var_411_0.name, "split") then
						var_411_0.gameObject:SetActive(true)
					else
						var_411_0.gameObject:SetActive(false)
					end
				end
			end

			local var_411_1 = 0.001

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_1 then
				arg_408_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_408_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_408_1.time_ - 0) / var_411_1)
			end

			if arg_408_1.time_ >= 0 + var_411_1 and arg_408_1.time_ < 0 + var_411_1 + arg_411_0 then
				arg_408_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				local var_411_2 = arg_408_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_411_2 then
					arg_408_1.var_.alphaOldValue10030 = var_411_2.alpha
					arg_408_1.var_.characterEffect10030 = var_411_2
				end

				arg_408_1.var_.alphaOldValue10030 = 0
			end

			local var_411_3 = 0.333333333333333

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_3 then
				if arg_408_1.var_.characterEffect10030 then
					arg_408_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_408_1.var_.alphaOldValue10030, 1, (arg_408_1.time_ - 0) / var_411_3)
				end
			end

			if arg_408_1.time_ >= 0 + var_411_3 and arg_408_1.time_ < 0 + var_411_3 + arg_411_0 and arg_408_1.var_.characterEffect10030 then
				arg_408_1.var_.characterEffect10030.alpha = 1
			end

			local var_411_4 = 0
			local var_411_5 = 0.125

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= var_411_4 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_6 = arg_408_1:GetWordFromCfg(115291099)
				local var_411_7 = arg_408_1:FormatText(var_411_6.content)

				arg_408_1.text_.text = var_411_7

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_9 = 5 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 5)

				if (5 <= 0 and var_411_5 or var_411_5 * (utf8.len(var_411_7) / 5)) > 0 and var_411_5 < var_411_9 then
					arg_408_1.talkMaxDuration = var_411_9

					if var_411_9 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_9 + var_411_4
					end
				end

				arg_408_1.text_.text = var_411_7
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291099", "story_v_out_115291.awb") ~= 0 then
					local var_411_10 = manager.audio:GetVoiceLength("story_v_out_115291", "115291099", "story_v_out_115291.awb") / 1000

					if var_411_10 + var_411_4 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_10 + var_411_4
					end

					if var_411_6.prefab_name ~= "" and arg_408_1.actors_[var_411_6.prefab_name] ~= nil then
						local var_411_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_6.prefab_name].transform, "story_v_out_115291", "115291099", "story_v_out_115291.awb")

						arg_408_1:RecordAudio("115291099", var_411_11)
						arg_408_1:RecordAudio("115291099", var_411_11)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_115291", "115291099", "story_v_out_115291.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_115291", "115291099", "story_v_out_115291.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_12 = math.max(var_411_5, arg_408_1.talkMaxDuration)

			if var_411_4 <= arg_408_1.time_ and arg_408_1.time_ < var_411_4 + var_411_12 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - var_411_4) / var_411_12

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= var_411_4 + var_411_12 and arg_408_1.time_ < var_411_4 + var_411_12 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_408_1:InitPlayNodeList()
	end,
	Play115291100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 115291100
		arg_412_1.duration_ = 8.4

		local var_412_0 = {
			ja = 8.4,
			ko = 5.366,
			zh = 6.4,
			en = 6.166
		}
		local var_412_1 = manager.audio:GetLocalizationFlag()

		if var_412_0[var_412_1] ~= nil then
			arg_412_1.duration_ = var_412_0[var_412_1]
		end

		SetActive(arg_412_1.tipsGo_, false)

		function arg_412_1.onSingleLineFinish_()
			arg_412_1.onSingleLineUpdate_ = nil
			arg_412_1.onSingleLineFinish_ = nil
			arg_412_1.state_ = "waiting"
		end

		function arg_412_1.playNext_(arg_414_0)
			if arg_414_0 == 1 then
				arg_412_0:Play115291101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 and not isNil(arg_412_1.actors_["10030"]) and arg_412_1.var_.actorSpriteComps10030 == nil then
				arg_412_1.var_.actorSpriteComps10030 = arg_412_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_415_0 = 0.2

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_0 and not isNil(arg_412_1.actors_["10030"]) then
				if arg_412_1.var_.actorSpriteComps10030 then
					for iter_415_0, iter_415_1 in pairs(arg_412_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_415_1 then
							if arg_412_1.isInRecall_ then
								iter_415_1.color = Color.New(Mathf.Lerp(iter_415_1.color.r, arg_412_1.hightColor2.r, (arg_412_1.time_ - 0) / var_415_0), Mathf.Lerp(iter_415_1.color.g, arg_412_1.hightColor2.g, (arg_412_1.time_ - 0) / var_415_0), (Mathf.Lerp(iter_415_1.color.b, arg_412_1.hightColor2.b, (arg_412_1.time_ - 0) / var_415_0)))
							else
								local var_415_1 = Mathf.Lerp(iter_415_1.color.r, 0.5, (arg_412_1.time_ - 0) / var_415_0)

								iter_415_1.color = Color.New(var_415_1, var_415_1, var_415_1)
							end
						end
					end
				end
			end

			if arg_412_1.time_ >= 0 + var_415_0 and arg_412_1.time_ < 0 + var_415_0 + arg_415_0 and not isNil(arg_412_1.actors_["10030"]) and arg_412_1.var_.actorSpriteComps10030 then
				for iter_415_2, iter_415_3 in pairs(arg_412_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_415_3 then
						iter_415_3.color = arg_412_1.isInRecall_ and (arg_412_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_412_1.var_.actorSpriteComps10030 = nil
			end

			local var_415_2 = 0
			local var_415_3 = 0.55

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= var_415_2 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, true)
				arg_412_1.iconController_:SetSelectedState("hero")

				arg_412_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_412_1.callingController_:SetSelectedState("normal")

				arg_412_1.keyicon_.color = Color.New(1, 1, 1)
				arg_412_1.icon_.color = Color.New(1, 1, 1)

				local var_415_4 = arg_412_1:GetWordFromCfg(115291100)
				local var_415_5 = arg_412_1:FormatText(var_415_4.content)

				arg_412_1.text_.text = var_415_5

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_7 = 22 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_5) / 22)

				if (22 <= 0 and var_415_3 or var_415_3 * (utf8.len(var_415_5) / 22)) > 0 and var_415_3 < var_415_7 then
					arg_412_1.talkMaxDuration = var_415_7

					if var_415_7 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_7 + var_415_2
					end
				end

				arg_412_1.text_.text = var_415_5
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291100", "story_v_out_115291.awb") ~= 0 then
					local var_415_8 = manager.audio:GetVoiceLength("story_v_out_115291", "115291100", "story_v_out_115291.awb") / 1000

					if var_415_8 + var_415_2 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_8 + var_415_2
					end

					if var_415_4.prefab_name ~= "" and arg_412_1.actors_[var_415_4.prefab_name] ~= nil then
						local var_415_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_4.prefab_name].transform, "story_v_out_115291", "115291100", "story_v_out_115291.awb")

						arg_412_1:RecordAudio("115291100", var_415_9)
						arg_412_1:RecordAudio("115291100", var_415_9)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_115291", "115291100", "story_v_out_115291.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_115291", "115291100", "story_v_out_115291.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_10 = math.max(var_415_3, arg_412_1.talkMaxDuration)

			if var_415_2 <= arg_412_1.time_ and arg_412_1.time_ < var_415_2 + var_415_10 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - var_415_2) / var_415_10

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= var_415_2 + var_415_10 and arg_412_1.time_ < var_415_2 + var_415_10 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play115291101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 115291101
		arg_416_1.duration_ = 3.1

		local var_416_0 = {
			ja = 3.1,
			ko = 2.066,
			zh = 2.6,
			en = 1.066
		}
		local var_416_1 = manager.audio:GetLocalizationFlag()

		if var_416_0[var_416_1] ~= nil then
			arg_416_1.duration_ = var_416_0[var_416_1]
		end

		SetActive(arg_416_1.tipsGo_, false)

		function arg_416_1.onSingleLineFinish_()
			arg_416_1.onSingleLineUpdate_ = nil
			arg_416_1.onSingleLineFinish_ = nil
			arg_416_1.state_ = "waiting"
		end

		function arg_416_1.playNext_(arg_418_0)
			if arg_418_0 == 1 then
				arg_416_0:Play115291102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 and not isNil(arg_416_1.actors_["10030"]) and arg_416_1.var_.actorSpriteComps10030 == nil then
				arg_416_1.var_.actorSpriteComps10030 = arg_416_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_419_0 = 0.2

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_0 and not isNil(arg_416_1.actors_["10030"]) then
				if arg_416_1.var_.actorSpriteComps10030 then
					for iter_419_0, iter_419_1 in pairs(arg_416_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_419_1 then
							if arg_416_1.isInRecall_ then
								iter_419_1.color = Color.New(Mathf.Lerp(iter_419_1.color.r, arg_416_1.hightColor1.r, (arg_416_1.time_ - 0) / var_419_0), Mathf.Lerp(iter_419_1.color.g, arg_416_1.hightColor1.g, (arg_416_1.time_ - 0) / var_419_0), (Mathf.Lerp(iter_419_1.color.b, arg_416_1.hightColor1.b, (arg_416_1.time_ - 0) / var_419_0)))
							else
								local var_419_1 = Mathf.Lerp(iter_419_1.color.r, 1, (arg_416_1.time_ - 0) / var_419_0)

								iter_419_1.color = Color.New(var_419_1, var_419_1, var_419_1)
							end
						end
					end
				end
			end

			if arg_416_1.time_ >= 0 + var_419_0 and arg_416_1.time_ < 0 + var_419_0 + arg_419_0 and not isNil(arg_416_1.actors_["10030"]) and arg_416_1.var_.actorSpriteComps10030 then
				for iter_419_2, iter_419_3 in pairs(arg_416_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_419_3 then
						iter_419_3.color = arg_416_1.isInRecall_ and (arg_416_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_416_1.var_.actorSpriteComps10030 = nil
			end

			local var_419_2 = 0
			local var_419_3 = 0.1

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= var_419_2 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_4 = arg_416_1:GetWordFromCfg(115291101)
				local var_419_5 = arg_416_1:FormatText(var_419_4.content)

				arg_416_1.text_.text = var_419_5

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_7 = 4 <= 0 and var_419_3 or var_419_3 * (utf8.len(var_419_5) / 4)

				if (4 <= 0 and var_419_3 or var_419_3 * (utf8.len(var_419_5) / 4)) > 0 and var_419_3 < var_419_7 then
					arg_416_1.talkMaxDuration = var_419_7

					if var_419_7 + var_419_2 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_7 + var_419_2
					end
				end

				arg_416_1.text_.text = var_419_5
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291101", "story_v_out_115291.awb") ~= 0 then
					local var_419_8 = manager.audio:GetVoiceLength("story_v_out_115291", "115291101", "story_v_out_115291.awb") / 1000

					if var_419_8 + var_419_2 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_8 + var_419_2
					end

					if var_419_4.prefab_name ~= "" and arg_416_1.actors_[var_419_4.prefab_name] ~= nil then
						local var_419_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_4.prefab_name].transform, "story_v_out_115291", "115291101", "story_v_out_115291.awb")

						arg_416_1:RecordAudio("115291101", var_419_9)
						arg_416_1:RecordAudio("115291101", var_419_9)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_115291", "115291101", "story_v_out_115291.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_115291", "115291101", "story_v_out_115291.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_10 = math.max(var_419_3, arg_416_1.talkMaxDuration)

			if var_419_2 <= arg_416_1.time_ and arg_416_1.time_ < var_419_2 + var_419_10 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - var_419_2) / var_419_10

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= var_419_2 + var_419_10 and arg_416_1.time_ < var_419_2 + var_419_10 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play115291102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 115291102
		arg_420_1.duration_ = 3.03

		local var_420_0 = {
			ja = 2.9,
			ko = 2.6,
			zh = 3.033,
			en = 2.933
		}
		local var_420_1 = manager.audio:GetLocalizationFlag()

		if var_420_0[var_420_1] ~= nil then
			arg_420_1.duration_ = var_420_0[var_420_1]
		end

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play115291103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 and not isNil(arg_420_1.actors_["10030"]) and arg_420_1.var_.actorSpriteComps10030 == nil then
				arg_420_1.var_.actorSpriteComps10030 = arg_420_1.actors_["10030"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_423_0 = 0.2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 and not isNil(arg_420_1.actors_["10030"]) then
				if arg_420_1.var_.actorSpriteComps10030 then
					for iter_423_0, iter_423_1 in pairs(arg_420_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_423_1 then
							if arg_420_1.isInRecall_ then
								iter_423_1.color = Color.New(Mathf.Lerp(iter_423_1.color.r, arg_420_1.hightColor2.r, (arg_420_1.time_ - 0) / var_423_0), Mathf.Lerp(iter_423_1.color.g, arg_420_1.hightColor2.g, (arg_420_1.time_ - 0) / var_423_0), (Mathf.Lerp(iter_423_1.color.b, arg_420_1.hightColor2.b, (arg_420_1.time_ - 0) / var_423_0)))
							else
								local var_423_1 = Mathf.Lerp(iter_423_1.color.r, 0.5, (arg_420_1.time_ - 0) / var_423_0)

								iter_423_1.color = Color.New(var_423_1, var_423_1, var_423_1)
							end
						end
					end
				end
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 and not isNil(arg_420_1.actors_["10030"]) and arg_420_1.var_.actorSpriteComps10030 then
				for iter_423_2, iter_423_3 in pairs(arg_420_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_423_3 then
						iter_423_3.color = arg_420_1.isInRecall_ and (arg_420_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_420_1.var_.actorSpriteComps10030 = nil
			end

			local var_423_2 = 0
			local var_423_3 = 0.2

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_2 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, true)
				arg_420_1.iconController_:SetSelectedState("hero")

				arg_420_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_420_1.callingController_:SetSelectedState("normal")

				arg_420_1.keyicon_.color = Color.New(1, 1, 1)
				arg_420_1.icon_.color = Color.New(1, 1, 1)

				local var_423_4 = arg_420_1:GetWordFromCfg(115291102)
				local var_423_5 = arg_420_1:FormatText(var_423_4.content)

				arg_420_1.text_.text = var_423_5

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_7 = 8 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 8)

				if (8 <= 0 and var_423_3 or var_423_3 * (utf8.len(var_423_5) / 8)) > 0 and var_423_3 < var_423_7 then
					arg_420_1.talkMaxDuration = var_423_7

					if var_423_7 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_7 + var_423_2
					end
				end

				arg_420_1.text_.text = var_423_5
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291102", "story_v_out_115291.awb") ~= 0 then
					local var_423_8 = manager.audio:GetVoiceLength("story_v_out_115291", "115291102", "story_v_out_115291.awb") / 1000

					if var_423_8 + var_423_2 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_8 + var_423_2
					end

					if var_423_4.prefab_name ~= "" and arg_420_1.actors_[var_423_4.prefab_name] ~= nil then
						local var_423_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_4.prefab_name].transform, "story_v_out_115291", "115291102", "story_v_out_115291.awb")

						arg_420_1:RecordAudio("115291102", var_423_9)
						arg_420_1:RecordAudio("115291102", var_423_9)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_115291", "115291102", "story_v_out_115291.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_115291", "115291102", "story_v_out_115291.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_10 = math.max(var_423_3, arg_420_1.talkMaxDuration)

			if var_423_2 <= arg_420_1.time_ and arg_420_1.time_ < var_423_2 + var_423_10 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_2) / var_423_10

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_2 + var_423_10 and arg_420_1.time_ < var_423_2 + var_423_10 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {}

		arg_420_1:InitPlayNodeList()
	end,
	Play115291103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 115291103
		arg_424_1.duration_ = 5

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play115291104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				local var_427_0 = arg_424_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_427_0 then
					arg_424_1.var_.alphaOldValue10030 = var_427_0.alpha
					arg_424_1.var_.characterEffect10030 = var_427_0
				end

				arg_424_1.var_.alphaOldValue10030 = 1
			end

			local var_427_1 = 0.333333333333333

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_1 then
				if arg_424_1.var_.characterEffect10030 then
					arg_424_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_424_1.var_.alphaOldValue10030, 0, (arg_424_1.time_ - 0) / var_427_1)
				end
			end

			if arg_424_1.time_ >= 0 + var_427_1 and arg_424_1.time_ < 0 + var_427_1 + arg_427_0 and arg_424_1.var_.characterEffect10030 then
				arg_424_1.var_.characterEffect10030.alpha = 0
			end

			local var_427_2 = 0
			local var_427_3 = 0.575

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= var_427_2 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, false)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_4 = arg_424_1:FormatText(arg_424_1:GetWordFromCfg(115291103).content)

				arg_424_1.text_.text = var_427_4

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_6 = 23 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_4) / 23)

				if (23 <= 0 and var_427_3 or var_427_3 * (utf8.len(var_427_4) / 23)) > 0 and var_427_3 < var_427_6 then
					arg_424_1.talkMaxDuration = var_427_6

					if var_427_6 + var_427_2 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_6 + var_427_2
					end
				end

				arg_424_1.text_.text = var_427_4
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)
				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_3, arg_424_1.talkMaxDuration)

			if var_427_2 <= arg_424_1.time_ and arg_424_1.time_ < var_427_2 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - var_427_2) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= var_427_2 + var_427_7 and arg_424_1.time_ < var_427_2 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play115291104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 115291104
		arg_428_1.duration_ = 7.6

		local var_428_0 = {
			ja = 4.4,
			ko = 4.666,
			zh = 7.6,
			en = 5.9
		}
		local var_428_1 = manager.audio:GetLocalizationFlag()

		if var_428_0[var_428_1] ~= nil then
			arg_428_1.duration_ = var_428_0[var_428_1]
		end

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play115291105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			local var_431_0 = 0.525

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= 0 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0
				arg_428_1.dialogCg_.alpha = 1

				arg_428_1.dialog_:SetActive(true)
				SetActive(arg_428_1.leftNameGo_, true)

				arg_428_1.leftNameTxt_.text = arg_428_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_428_1.leftNameTxt_.transform)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1.leftNameTxt_.text)
				SetActive(arg_428_1.iconTrs_.gameObject, true)
				arg_428_1.iconController_:SetSelectedState("hero")

				arg_428_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_428_1.callingController_:SetSelectedState("normal")

				arg_428_1.keyicon_.color = Color.New(1, 1, 1)
				arg_428_1.icon_.color = Color.New(1, 1, 1)

				local var_431_1 = arg_428_1:GetWordFromCfg(115291104)
				local var_431_2 = arg_428_1:FormatText(var_431_1.content)

				arg_428_1.text_.text = var_431_2

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_4 = 21 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 21)

				if (21 <= 0 and var_431_0 or var_431_0 * (utf8.len(var_431_2) / 21)) > 0 and var_431_0 < var_431_4 then
					arg_428_1.talkMaxDuration = var_431_4

					if var_431_4 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_4 + 0
					end
				end

				arg_428_1.text_.text = var_431_2
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291104", "story_v_out_115291.awb") ~= 0 then
					local var_431_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291104", "story_v_out_115291.awb") / 1000

					if var_431_5 + 0 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_5 + 0
					end

					if var_431_1.prefab_name ~= "" and arg_428_1.actors_[var_431_1.prefab_name] ~= nil then
						local var_431_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_428_1.actors_[var_431_1.prefab_name].transform, "story_v_out_115291", "115291104", "story_v_out_115291.awb")

						arg_428_1:RecordAudio("115291104", var_431_6)
						arg_428_1:RecordAudio("115291104", var_431_6)
					else
						arg_428_1:AudioAction("play", "voice", "story_v_out_115291", "115291104", "story_v_out_115291.awb")
					end

					arg_428_1:RecordHistoryTalkVoice("story_v_out_115291", "115291104", "story_v_out_115291.awb")
				end

				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_7 = math.max(var_431_0, arg_428_1.talkMaxDuration)

			if 0 <= arg_428_1.time_ and arg_428_1.time_ < 0 + var_431_7 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - 0) / var_431_7

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= 0 + var_431_7 and arg_428_1.time_ < 0 + var_431_7 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play115291105 = function(arg_432_0, arg_432_1)
		arg_432_1.time_ = 0
		arg_432_1.frameCnt_ = 0
		arg_432_1.state_ = "playing"
		arg_432_1.curTalkId_ = 115291105
		arg_432_1.duration_ = 3.17

		local var_432_0 = {
			ja = 3.166,
			ko = 1.9,
			zh = 3.166,
			en = 2.1
		}
		local var_432_1 = manager.audio:GetLocalizationFlag()

		if var_432_0[var_432_1] ~= nil then
			arg_432_1.duration_ = var_432_0[var_432_1]
		end

		SetActive(arg_432_1.tipsGo_, false)

		function arg_432_1.onSingleLineFinish_()
			arg_432_1.onSingleLineUpdate_ = nil
			arg_432_1.onSingleLineFinish_ = nil
			arg_432_1.state_ = "waiting"
		end

		function arg_432_1.playNext_(arg_434_0)
			if arg_434_0 == 1 then
				arg_432_0:Play115291106(arg_432_1)
			end
		end

		function arg_432_1.onSingleLineUpdate_(arg_435_0)
			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				arg_432_1.var_.moveOldPos10030 = arg_432_1.actors_["10030"].transform.localPosition
				arg_432_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_432_1:CheckSpriteTmpPos("10030", 3)

				for iter_435_0 = 0, arg_432_1.actors_["10030"].transform.childCount - 1 do
					local var_435_0 = arg_432_1.actors_["10030"].transform:GetChild(iter_435_0)

					if var_435_0.name == "split_1" or not string.find(var_435_0.name, "split") then
						var_435_0.gameObject:SetActive(true)
					else
						var_435_0.gameObject:SetActive(false)
					end
				end
			end

			local var_435_1 = 0.001

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_1 then
				arg_432_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_432_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_432_1.time_ - 0) / var_435_1)
			end

			if arg_432_1.time_ >= 0 + var_435_1 and arg_432_1.time_ < 0 + var_435_1 + arg_435_0 then
				arg_432_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			local var_435_2 = arg_432_1.actors_["10030"]

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps10030 == nil then
				arg_432_1.var_.actorSpriteComps10030 = var_435_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_435_3 = 0.2

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_3 and not isNil(var_435_2) then
				if arg_432_1.var_.actorSpriteComps10030 then
					for iter_435_1, iter_435_2 in pairs(arg_432_1.var_.actorSpriteComps10030:ToTable()) do
						if iter_435_2 then
							if arg_432_1.isInRecall_ then
								iter_435_2.color = Color.New(Mathf.Lerp(iter_435_2.color.r, arg_432_1.hightColor1.r, (arg_432_1.time_ - 0) / var_435_3), Mathf.Lerp(iter_435_2.color.g, arg_432_1.hightColor1.g, (arg_432_1.time_ - 0) / var_435_3), (Mathf.Lerp(iter_435_2.color.b, arg_432_1.hightColor1.b, (arg_432_1.time_ - 0) / var_435_3)))
							else
								local var_435_4 = Mathf.Lerp(iter_435_2.color.r, 1, (arg_432_1.time_ - 0) / var_435_3)

								iter_435_2.color = Color.New(var_435_4, var_435_4, var_435_4)
							end
						end
					end
				end
			end

			if arg_432_1.time_ >= 0 + var_435_3 and arg_432_1.time_ < 0 + var_435_3 + arg_435_0 and not isNil(var_435_2) and arg_432_1.var_.actorSpriteComps10030 then
				for iter_435_3, iter_435_4 in pairs(arg_432_1.var_.actorSpriteComps10030:ToTable()) do
					if iter_435_4 then
						iter_435_4.color = arg_432_1.isInRecall_ and (arg_432_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_432_1.var_.actorSpriteComps10030 = nil
			end

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= 0 + arg_435_0 then
				local var_435_5 = arg_432_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_435_5 then
					arg_432_1.var_.alphaOldValue10030 = var_435_5.alpha
					arg_432_1.var_.characterEffect10030 = var_435_5
				end

				arg_432_1.var_.alphaOldValue10030 = 0
			end

			local var_435_6 = 0.333333333333333

			if 0 <= arg_432_1.time_ and arg_432_1.time_ < 0 + var_435_6 then
				if arg_432_1.var_.characterEffect10030 then
					arg_432_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_432_1.var_.alphaOldValue10030, 1, (arg_432_1.time_ - 0) / var_435_6)
				end
			end

			if arg_432_1.time_ >= 0 + var_435_6 and arg_432_1.time_ < 0 + var_435_6 + arg_435_0 and arg_432_1.var_.characterEffect10030 then
				arg_432_1.var_.characterEffect10030.alpha = 1
			end

			local var_435_7 = 0
			local var_435_8 = 0.175

			if 0 < arg_432_1.time_ and arg_432_1.time_ <= var_435_7 + arg_435_0 then
				arg_432_1.talkMaxDuration = 0
				arg_432_1.dialogCg_.alpha = 1

				arg_432_1.dialog_:SetActive(true)
				SetActive(arg_432_1.leftNameGo_, true)

				arg_432_1.leftNameTxt_.text = arg_432_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_432_1.leftNameTxt_.transform)

				arg_432_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_432_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_432_1:RecordName(arg_432_1.leftNameTxt_.text)
				SetActive(arg_432_1.iconTrs_.gameObject, false)
				arg_432_1.callingController_:SetSelectedState("normal")

				local var_435_9 = arg_432_1:GetWordFromCfg(115291105)
				local var_435_10 = arg_432_1:FormatText(var_435_9.content)

				arg_432_1.text_.text = var_435_10

				LuaForUtil.ClearLinePrefixSymbol(arg_432_1.text_)

				local var_435_12 = 7 <= 0 and var_435_8 or var_435_8 * (utf8.len(var_435_10) / 7)

				if (7 <= 0 and var_435_8 or var_435_8 * (utf8.len(var_435_10) / 7)) > 0 and var_435_8 < var_435_12 then
					arg_432_1.talkMaxDuration = var_435_12

					if var_435_12 + var_435_7 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_12 + var_435_7
					end
				end

				arg_432_1.text_.text = var_435_10
				arg_432_1.typewritter.percent = 0

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291105", "story_v_out_115291.awb") ~= 0 then
					local var_435_13 = manager.audio:GetVoiceLength("story_v_out_115291", "115291105", "story_v_out_115291.awb") / 1000

					if var_435_13 + var_435_7 > arg_432_1.duration_ then
						arg_432_1.duration_ = var_435_13 + var_435_7
					end

					if var_435_9.prefab_name ~= "" and arg_432_1.actors_[var_435_9.prefab_name] ~= nil then
						local var_435_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_432_1.actors_[var_435_9.prefab_name].transform, "story_v_out_115291", "115291105", "story_v_out_115291.awb")

						arg_432_1:RecordAudio("115291105", var_435_14)
						arg_432_1:RecordAudio("115291105", var_435_14)
					else
						arg_432_1:AudioAction("play", "voice", "story_v_out_115291", "115291105", "story_v_out_115291.awb")
					end

					arg_432_1:RecordHistoryTalkVoice("story_v_out_115291", "115291105", "story_v_out_115291.awb")
				end

				arg_432_1:RecordContent(arg_432_1.text_.text)
			end

			local var_435_15 = math.max(var_435_8, arg_432_1.talkMaxDuration)

			if var_435_7 <= arg_432_1.time_ and arg_432_1.time_ < var_435_7 + var_435_15 then
				arg_432_1.typewritter.percent = (arg_432_1.time_ - var_435_7) / var_435_15

				arg_432_1.typewritter:SetDirty()
			end

			if arg_432_1.time_ >= var_435_7 + var_435_15 and arg_432_1.time_ < var_435_7 + var_435_15 + arg_435_0 then
				arg_432_1.typewritter.percent = 1

				arg_432_1.typewritter:SetDirty()
				arg_432_1:ShowNextGo(true)
			end
		end

		arg_432_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_432_1:InitPlayNodeList()
	end,
	Play115291106 = function(arg_436_0, arg_436_1)
		arg_436_1.time_ = 0
		arg_436_1.frameCnt_ = 0
		arg_436_1.state_ = "playing"
		arg_436_1.curTalkId_ = 115291106
		arg_436_1.duration_ = 5

		SetActive(arg_436_1.tipsGo_, false)

		function arg_436_1.onSingleLineFinish_()
			arg_436_1.onSingleLineUpdate_ = nil
			arg_436_1.onSingleLineFinish_ = nil
			arg_436_1.state_ = "waiting"
		end

		function arg_436_1.playNext_(arg_438_0)
			if arg_438_0 == 1 then
				arg_436_0:Play115291107(arg_436_1)
			end
		end

		function arg_436_1.onSingleLineUpdate_(arg_439_0)
			if 0 < arg_436_1.time_ and arg_436_1.time_ <= 0 + arg_439_0 then
				local var_439_0 = arg_436_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_439_0 then
					arg_436_1.var_.alphaOldValue10030 = var_439_0.alpha
					arg_436_1.var_.characterEffect10030 = var_439_0
				end

				arg_436_1.var_.alphaOldValue10030 = 1
			end

			local var_439_1 = 0.333333333333333

			if 0 <= arg_436_1.time_ and arg_436_1.time_ < 0 + var_439_1 then
				if arg_436_1.var_.characterEffect10030 then
					arg_436_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_436_1.var_.alphaOldValue10030, 0, (arg_436_1.time_ - 0) / var_439_1)
				end
			end

			if arg_436_1.time_ >= 0 + var_439_1 and arg_436_1.time_ < 0 + var_439_1 + arg_439_0 and arg_436_1.var_.characterEffect10030 then
				arg_436_1.var_.characterEffect10030.alpha = 0
			end

			local var_439_2 = 0
			local var_439_3 = 0.525

			if 0 < arg_436_1.time_ and arg_436_1.time_ <= var_439_2 + arg_439_0 then
				arg_436_1.talkMaxDuration = 0
				arg_436_1.dialogCg_.alpha = 1

				arg_436_1.dialog_:SetActive(true)
				SetActive(arg_436_1.leftNameGo_, false)

				arg_436_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_436_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_436_1:RecordName(arg_436_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_436_1.iconTrs_.gameObject, false)
				arg_436_1.callingController_:SetSelectedState("normal")

				local var_439_4 = arg_436_1:FormatText(arg_436_1:GetWordFromCfg(115291106).content)

				arg_436_1.text_.text = var_439_4

				LuaForUtil.ClearLinePrefixSymbol(arg_436_1.text_)

				local var_439_6 = 21 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_4) / 21)

				if (21 <= 0 and var_439_3 or var_439_3 * (utf8.len(var_439_4) / 21)) > 0 and var_439_3 < var_439_6 then
					arg_436_1.talkMaxDuration = var_439_6

					if var_439_6 + var_439_2 > arg_436_1.duration_ then
						arg_436_1.duration_ = var_439_6 + var_439_2
					end
				end

				arg_436_1.text_.text = var_439_4
				arg_436_1.typewritter.percent = 0

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(false)
				arg_436_1:RecordContent(arg_436_1.text_.text)
			end

			local var_439_7 = math.max(var_439_3, arg_436_1.talkMaxDuration)

			if var_439_2 <= arg_436_1.time_ and arg_436_1.time_ < var_439_2 + var_439_7 then
				arg_436_1.typewritter.percent = (arg_436_1.time_ - var_439_2) / var_439_7

				arg_436_1.typewritter:SetDirty()
			end

			if arg_436_1.time_ >= var_439_2 + var_439_7 and arg_436_1.time_ < var_439_2 + var_439_7 + arg_439_0 then
				arg_436_1.typewritter.percent = 1

				arg_436_1.typewritter:SetDirty()
				arg_436_1:ShowNextGo(true)
			end
		end

		arg_436_1.nodeConfigList_ = {}

		arg_436_1:InitPlayNodeList()
	end,
	Play115291107 = function(arg_440_0, arg_440_1)
		arg_440_1.time_ = 0
		arg_440_1.frameCnt_ = 0
		arg_440_1.state_ = "playing"
		arg_440_1.curTalkId_ = 115291107
		arg_440_1.duration_ = 8.97

		local var_440_0 = {
			ja = 8.966,
			ko = 8.6,
			zh = 8.166,
			en = 8.9
		}
		local var_440_1 = manager.audio:GetLocalizationFlag()

		if var_440_0[var_440_1] ~= nil then
			arg_440_1.duration_ = var_440_0[var_440_1]
		end

		SetActive(arg_440_1.tipsGo_, false)

		function arg_440_1.onSingleLineFinish_()
			arg_440_1.onSingleLineUpdate_ = nil
			arg_440_1.onSingleLineFinish_ = nil
			arg_440_1.state_ = "waiting"
		end

		function arg_440_1.playNext_(arg_442_0)
			if arg_442_0 == 1 then
				arg_440_0:Play115291108(arg_440_1)
			end
		end

		function arg_440_1.onSingleLineUpdate_(arg_443_0)
			local var_443_0 = 0.675

			if 0 < arg_440_1.time_ and arg_440_1.time_ <= 0 + arg_443_0 then
				arg_440_1.talkMaxDuration = 0
				arg_440_1.dialogCg_.alpha = 1

				arg_440_1.dialog_:SetActive(true)
				SetActive(arg_440_1.leftNameGo_, true)

				arg_440_1.leftNameTxt_.text = arg_440_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_440_1.leftNameTxt_.transform)

				arg_440_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_440_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_440_1:RecordName(arg_440_1.leftNameTxt_.text)
				SetActive(arg_440_1.iconTrs_.gameObject, true)
				arg_440_1.iconController_:SetSelectedState("hero")

				arg_440_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_440_1.callingController_:SetSelectedState("normal")

				arg_440_1.keyicon_.color = Color.New(1, 1, 1)
				arg_440_1.icon_.color = Color.New(1, 1, 1)

				local var_443_1 = arg_440_1:GetWordFromCfg(115291107)
				local var_443_2 = arg_440_1:FormatText(var_443_1.content)

				arg_440_1.text_.text = var_443_2

				LuaForUtil.ClearLinePrefixSymbol(arg_440_1.text_)

				local var_443_4 = 27 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 27)

				if (27 <= 0 and var_443_0 or var_443_0 * (utf8.len(var_443_2) / 27)) > 0 and var_443_0 < var_443_4 then
					arg_440_1.talkMaxDuration = var_443_4

					if var_443_4 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_4 + 0
					end
				end

				arg_440_1.text_.text = var_443_2
				arg_440_1.typewritter.percent = 0

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291107", "story_v_out_115291.awb") ~= 0 then
					local var_443_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291107", "story_v_out_115291.awb") / 1000

					if var_443_5 + 0 > arg_440_1.duration_ then
						arg_440_1.duration_ = var_443_5 + 0
					end

					if var_443_1.prefab_name ~= "" and arg_440_1.actors_[var_443_1.prefab_name] ~= nil then
						local var_443_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_440_1.actors_[var_443_1.prefab_name].transform, "story_v_out_115291", "115291107", "story_v_out_115291.awb")

						arg_440_1:RecordAudio("115291107", var_443_6)
						arg_440_1:RecordAudio("115291107", var_443_6)
					else
						arg_440_1:AudioAction("play", "voice", "story_v_out_115291", "115291107", "story_v_out_115291.awb")
					end

					arg_440_1:RecordHistoryTalkVoice("story_v_out_115291", "115291107", "story_v_out_115291.awb")
				end

				arg_440_1:RecordContent(arg_440_1.text_.text)
			end

			local var_443_7 = math.max(var_443_0, arg_440_1.talkMaxDuration)

			if 0 <= arg_440_1.time_ and arg_440_1.time_ < 0 + var_443_7 then
				arg_440_1.typewritter.percent = (arg_440_1.time_ - 0) / var_443_7

				arg_440_1.typewritter:SetDirty()
			end

			if arg_440_1.time_ >= 0 + var_443_7 and arg_440_1.time_ < 0 + var_443_7 + arg_443_0 then
				arg_440_1.typewritter.percent = 1

				arg_440_1.typewritter:SetDirty()
				arg_440_1:ShowNextGo(true)
			end
		end

		arg_440_1.nodeConfigList_ = {}

		arg_440_1:InitPlayNodeList()
	end,
	Play115291108 = function(arg_444_0, arg_444_1)
		arg_444_1.time_ = 0
		arg_444_1.frameCnt_ = 0
		arg_444_1.state_ = "playing"
		arg_444_1.curTalkId_ = 115291108
		arg_444_1.duration_ = 5

		SetActive(arg_444_1.tipsGo_, false)

		function arg_444_1.onSingleLineFinish_()
			arg_444_1.onSingleLineUpdate_ = nil
			arg_444_1.onSingleLineFinish_ = nil
			arg_444_1.state_ = "waiting"
		end

		function arg_444_1.playNext_(arg_446_0)
			if arg_446_0 == 1 then
				arg_444_0:Play115291109(arg_444_1)
			end
		end

		function arg_444_1.onSingleLineUpdate_(arg_447_0)
			local var_447_0 = 1.225

			if 0 < arg_444_1.time_ and arg_444_1.time_ <= 0 + arg_447_0 then
				arg_444_1.talkMaxDuration = 0
				arg_444_1.dialogCg_.alpha = 1

				arg_444_1.dialog_:SetActive(true)
				SetActive(arg_444_1.leftNameGo_, false)

				arg_444_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_444_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_444_1:RecordName(arg_444_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_444_1.iconTrs_.gameObject, false)
				arg_444_1.callingController_:SetSelectedState("normal")

				local var_447_1 = arg_444_1:FormatText(arg_444_1:GetWordFromCfg(115291108).content)

				arg_444_1.text_.text = var_447_1

				LuaForUtil.ClearLinePrefixSymbol(arg_444_1.text_)

				local var_447_3 = 49 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 49)

				if (49 <= 0 and var_447_0 or var_447_0 * (utf8.len(var_447_1) / 49)) > 0 and var_447_0 < var_447_3 then
					arg_444_1.talkMaxDuration = var_447_3

					if var_447_3 + 0 > arg_444_1.duration_ then
						arg_444_1.duration_ = var_447_3 + 0
					end
				end

				arg_444_1.text_.text = var_447_1
				arg_444_1.typewritter.percent = 0

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(false)
				arg_444_1:RecordContent(arg_444_1.text_.text)
			end

			local var_447_4 = math.max(var_447_0, arg_444_1.talkMaxDuration)

			if 0 <= arg_444_1.time_ and arg_444_1.time_ < 0 + var_447_4 then
				arg_444_1.typewritter.percent = (arg_444_1.time_ - 0) / var_447_4

				arg_444_1.typewritter:SetDirty()
			end

			if arg_444_1.time_ >= 0 + var_447_4 and arg_444_1.time_ < 0 + var_447_4 + arg_447_0 then
				arg_444_1.typewritter.percent = 1

				arg_444_1.typewritter:SetDirty()
				arg_444_1:ShowNextGo(true)
			end
		end

		arg_444_1.nodeConfigList_ = {}

		arg_444_1:InitPlayNodeList()
	end,
	Play115291109 = function(arg_448_0, arg_448_1)
		arg_448_1.time_ = 0
		arg_448_1.frameCnt_ = 0
		arg_448_1.state_ = "playing"
		arg_448_1.curTalkId_ = 115291109
		arg_448_1.duration_ = 2.1

		local var_448_0 = {
			ja = 1.933,
			ko = 1.5,
			zh = 2.1,
			en = 1.866
		}
		local var_448_1 = manager.audio:GetLocalizationFlag()

		if var_448_0[var_448_1] ~= nil then
			arg_448_1.duration_ = var_448_0[var_448_1]
		end

		SetActive(arg_448_1.tipsGo_, false)

		function arg_448_1.onSingleLineFinish_()
			arg_448_1.onSingleLineUpdate_ = nil
			arg_448_1.onSingleLineFinish_ = nil
			arg_448_1.state_ = "waiting"
		end

		function arg_448_1.playNext_(arg_450_0)
			if arg_450_0 == 1 then
				arg_448_0:Play115291110(arg_448_1)
			end
		end

		function arg_448_1.onSingleLineUpdate_(arg_451_0)
			local var_451_0 = 0.15

			if 0 < arg_448_1.time_ and arg_448_1.time_ <= 0 + arg_451_0 then
				arg_448_1.talkMaxDuration = 0
				arg_448_1.dialogCg_.alpha = 1

				arg_448_1.dialog_:SetActive(true)
				SetActive(arg_448_1.leftNameGo_, true)

				arg_448_1.leftNameTxt_.text = arg_448_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_448_1.leftNameTxt_.transform)

				arg_448_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_448_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_448_1:RecordName(arg_448_1.leftNameTxt_.text)
				SetActive(arg_448_1.iconTrs_.gameObject, true)
				arg_448_1.iconController_:SetSelectedState("hero")

				arg_448_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6046")

				arg_448_1.callingController_:SetSelectedState("normal")

				arg_448_1.keyicon_.color = Color.New(1, 1, 1)
				arg_448_1.icon_.color = Color.New(1, 1, 1)

				local var_451_1 = arg_448_1:GetWordFromCfg(115291109)
				local var_451_2 = arg_448_1:FormatText(var_451_1.content)

				arg_448_1.text_.text = var_451_2

				LuaForUtil.ClearLinePrefixSymbol(arg_448_1.text_)

				local var_451_4 = 6 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 6)

				if (6 <= 0 and var_451_0 or var_451_0 * (utf8.len(var_451_2) / 6)) > 0 and var_451_0 < var_451_4 then
					arg_448_1.talkMaxDuration = var_451_4

					if var_451_4 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_4 + 0
					end
				end

				arg_448_1.text_.text = var_451_2
				arg_448_1.typewritter.percent = 0

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291109", "story_v_out_115291.awb") ~= 0 then
					local var_451_5 = manager.audio:GetVoiceLength("story_v_out_115291", "115291109", "story_v_out_115291.awb") / 1000

					if var_451_5 + 0 > arg_448_1.duration_ then
						arg_448_1.duration_ = var_451_5 + 0
					end

					if var_451_1.prefab_name ~= "" and arg_448_1.actors_[var_451_1.prefab_name] ~= nil then
						local var_451_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_448_1.actors_[var_451_1.prefab_name].transform, "story_v_out_115291", "115291109", "story_v_out_115291.awb")

						arg_448_1:RecordAudio("115291109", var_451_6)
						arg_448_1:RecordAudio("115291109", var_451_6)
					else
						arg_448_1:AudioAction("play", "voice", "story_v_out_115291", "115291109", "story_v_out_115291.awb")
					end

					arg_448_1:RecordHistoryTalkVoice("story_v_out_115291", "115291109", "story_v_out_115291.awb")
				end

				arg_448_1:RecordContent(arg_448_1.text_.text)
			end

			local var_451_7 = math.max(var_451_0, arg_448_1.talkMaxDuration)

			if 0 <= arg_448_1.time_ and arg_448_1.time_ < 0 + var_451_7 then
				arg_448_1.typewritter.percent = (arg_448_1.time_ - 0) / var_451_7

				arg_448_1.typewritter:SetDirty()
			end

			if arg_448_1.time_ >= 0 + var_451_7 and arg_448_1.time_ < 0 + var_451_7 + arg_451_0 then
				arg_448_1.typewritter.percent = 1

				arg_448_1.typewritter:SetDirty()
				arg_448_1:ShowNextGo(true)
			end
		end

		arg_448_1.nodeConfigList_ = {}

		arg_448_1:InitPlayNodeList()
	end,
	Play115291110 = function(arg_452_0, arg_452_1)
		arg_452_1.time_ = 0
		arg_452_1.frameCnt_ = 0
		arg_452_1.state_ = "playing"
		arg_452_1.curTalkId_ = 115291110
		arg_452_1.duration_ = 3.47

		local var_452_0 = {
			ja = 3.466,
			ko = 2.3,
			zh = 3.2,
			en = 2.666
		}
		local var_452_1 = manager.audio:GetLocalizationFlag()

		if var_452_0[var_452_1] ~= nil then
			arg_452_1.duration_ = var_452_0[var_452_1]
		end

		SetActive(arg_452_1.tipsGo_, false)

		function arg_452_1.onSingleLineFinish_()
			arg_452_1.onSingleLineUpdate_ = nil
			arg_452_1.onSingleLineFinish_ = nil
			arg_452_1.state_ = "waiting"
			arg_452_1.auto_ = false
		end

		function arg_452_1.playNext_(arg_454_0)
			arg_452_1.onStoryFinished_()
		end

		function arg_452_1.onSingleLineUpdate_(arg_455_0)
			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				arg_452_1.var_.moveOldPos10030 = arg_452_1.actors_["10030"].transform.localPosition
				arg_452_1.actors_["10030"].transform.localScale = Vector3.New(1, 1, 1)

				arg_452_1:CheckSpriteTmpPos("10030", 3)

				for iter_455_0 = 0, arg_452_1.actors_["10030"].transform.childCount - 1 do
					local var_455_0 = arg_452_1.actors_["10030"].transform:GetChild(iter_455_0)

					if var_455_0.name == "split_1" or not string.find(var_455_0.name, "split") then
						var_455_0.gameObject:SetActive(true)
					else
						var_455_0.gameObject:SetActive(false)
					end
				end
			end

			local var_455_1 = 0.001

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_1 then
				arg_452_1.actors_["10030"].transform.localPosition = Vector3.Lerp(arg_452_1.var_.moveOldPos10030, Vector3.New(0, -390, 150), (arg_452_1.time_ - 0) / var_455_1)
			end

			if arg_452_1.time_ >= 0 + var_455_1 and arg_452_1.time_ < 0 + var_455_1 + arg_455_0 then
				arg_452_1.actors_["10030"].transform.localPosition = Vector3.New(0, -390, 150)
			end

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= 0 + arg_455_0 then
				local var_455_2 = arg_452_1.actors_["10030"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_455_2 then
					arg_452_1.var_.alphaOldValue10030 = var_455_2.alpha
					arg_452_1.var_.characterEffect10030 = var_455_2
				end

				arg_452_1.var_.alphaOldValue10030 = 0
			end

			local var_455_3 = 0.333333333333333

			if 0 <= arg_452_1.time_ and arg_452_1.time_ < 0 + var_455_3 then
				if arg_452_1.var_.characterEffect10030 then
					arg_452_1.var_.characterEffect10030.alpha = Mathf.Lerp(arg_452_1.var_.alphaOldValue10030, 1, (arg_452_1.time_ - 0) / var_455_3)
				end
			end

			if arg_452_1.time_ >= 0 + var_455_3 and arg_452_1.time_ < 0 + var_455_3 + arg_455_0 and arg_452_1.var_.characterEffect10030 then
				arg_452_1.var_.characterEffect10030.alpha = 1
			end

			local var_455_4 = 0
			local var_455_5 = 0.225

			if 0 < arg_452_1.time_ and arg_452_1.time_ <= var_455_4 + arg_455_0 then
				arg_452_1.talkMaxDuration = 0
				arg_452_1.dialogCg_.alpha = 1

				arg_452_1.dialog_:SetActive(true)
				SetActive(arg_452_1.leftNameGo_, true)

				arg_452_1.leftNameTxt_.text = arg_452_1:FormatText(StoryNameCfg[309].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_452_1.leftNameTxt_.transform)

				arg_452_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_452_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_452_1:RecordName(arg_452_1.leftNameTxt_.text)
				SetActive(arg_452_1.iconTrs_.gameObject, false)
				arg_452_1.callingController_:SetSelectedState("normal")

				local var_455_6 = arg_452_1:GetWordFromCfg(115291110)
				local var_455_7 = arg_452_1:FormatText(var_455_6.content)

				arg_452_1.text_.text = var_455_7

				LuaForUtil.ClearLinePrefixSymbol(arg_452_1.text_)

				local var_455_9 = 9 <= 0 and var_455_5 or var_455_5 * (utf8.len(var_455_7) / 9)

				if (9 <= 0 and var_455_5 or var_455_5 * (utf8.len(var_455_7) / 9)) > 0 and var_455_5 < var_455_9 then
					arg_452_1.talkMaxDuration = var_455_9

					if var_455_9 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_9 + var_455_4
					end
				end

				arg_452_1.text_.text = var_455_7
				arg_452_1.typewritter.percent = 0

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_115291", "115291110", "story_v_out_115291.awb") ~= 0 then
					local var_455_10 = manager.audio:GetVoiceLength("story_v_out_115291", "115291110", "story_v_out_115291.awb") / 1000

					if var_455_10 + var_455_4 > arg_452_1.duration_ then
						arg_452_1.duration_ = var_455_10 + var_455_4
					end

					if var_455_6.prefab_name ~= "" and arg_452_1.actors_[var_455_6.prefab_name] ~= nil then
						local var_455_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_452_1.actors_[var_455_6.prefab_name].transform, "story_v_out_115291", "115291110", "story_v_out_115291.awb")

						arg_452_1:RecordAudio("115291110", var_455_11)
						arg_452_1:RecordAudio("115291110", var_455_11)
					else
						arg_452_1:AudioAction("play", "voice", "story_v_out_115291", "115291110", "story_v_out_115291.awb")
					end

					arg_452_1:RecordHistoryTalkVoice("story_v_out_115291", "115291110", "story_v_out_115291.awb")
				end

				arg_452_1:RecordContent(arg_452_1.text_.text)
			end

			local var_455_12 = math.max(var_455_5, arg_452_1.talkMaxDuration)

			if var_455_4 <= arg_452_1.time_ and arg_452_1.time_ < var_455_4 + var_455_12 then
				arg_452_1.typewritter.percent = (arg_452_1.time_ - var_455_4) / var_455_12

				arg_452_1.typewritter:SetDirty()
			end

			if arg_452_1.time_ >= var_455_4 + var_455_12 and arg_452_1.time_ < var_455_4 + var_455_12 + arg_455_0 then
				arg_452_1.typewritter.percent = 1

				arg_452_1.typewritter:SetDirty()
				arg_452_1:ShowNextGo(true)
			end
		end

		arg_452_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10030",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_452_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST22a",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/RO0502"
	},
	voices = {
		"story_v_out_115291.awb"
	}
}
