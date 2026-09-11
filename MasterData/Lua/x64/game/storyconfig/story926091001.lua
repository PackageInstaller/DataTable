return {
	Play926091001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 926091001
		arg_1_1.duration_ = 14.3

		local var_1_0 = {
			zh = 10.3,
			ja = 14.3
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
				arg_1_0:Play926091002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I22g == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I22g")
				var_4_0.name = "I22g"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I22g = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I22g

				arg_1_1.bgs_.I22g.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I22g" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 == nil then
				arg_1_1.var_.actorSpriteComps10144 = var_4_12:GetComponentsInChildren(typeof(Image), true)
			end

			local var_4_13 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.actorSpriteComps10144 then
					for iter_4_4, iter_4_5 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_4_5 then
							if arg_1_1.isInRecall_ then
								iter_4_5.color = Color.New(Mathf.Lerp(iter_4_5.color.r, arg_1_1.hightColor1.r, (arg_1_1.time_ - 1.8) / var_4_13), Mathf.Lerp(iter_4_5.color.g, arg_1_1.hightColor1.g, (arg_1_1.time_ - 1.8) / var_4_13), (Mathf.Lerp(iter_4_5.color.b, arg_1_1.hightColor1.b, (arg_1_1.time_ - 1.8) / var_4_13)))
							else
								local var_4_14 = Mathf.Lerp(iter_4_5.color.r, 1, (arg_1_1.time_ - 1.8) / var_4_13)

								iter_4_5.color = Color.New(var_4_14, var_4_14, var_4_14)
							end
						end
					end
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.actorSpriteComps10144 then
				for iter_4_6, iter_4_7 in pairs(arg_1_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_4_7 then
						iter_4_7.color = arg_1_1.isInRecall_ and (arg_1_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_1_1.var_.actorSpriteComps10144 = nil
			end

			local var_4_15 = arg_1_1.actors_["10144"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10144 = var_4_15.localPosition
				var_4_15.localScale = Vector3.New(1, 1, 1)

				arg_1_1:CheckSpriteTmpPos("10144", 3)

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

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_17 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_1_1.time_ - 1.8) / var_4_17)
			end

			if arg_1_1.time_ >= 1.8 + var_4_17 and arg_1_1.time_ < 1.8 + var_4_17 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_4_18 = 0

			arg_1_1.isInRecall_ = true

			if var_4_18 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.screenFilterGo_:SetActive(true)

				arg_1_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
				arg_1_1.hightColor1 = Color.New(0.82, 0.77, 0.62)
				arg_1_1.hightColor2 = Color.New(0.46, 0.43, 0.35)

				for iter_4_9, iter_4_10 in pairs(arg_1_1.actors_) do
					for iter_4_11, iter_4_12 in ipairs((iter_4_10:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_4_12.color = iter_4_12.color.r > 0.51 and Color.New(0.82, 0.77, 0.62) or Color.New(0.46, 0.43, 0.35)
					end
				end
			end

			local var_4_19 = 0.0166666666666667

			if var_4_18 <= arg_1_1.time_ and arg_1_1.time_ < var_4_18 + var_4_19 then
				arg_1_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_1_1.time_ - var_4_18) / var_4_19)
			end

			if arg_1_1.time_ >= var_4_18 + var_4_19 and arg_1_1.time_ < var_4_18 + var_4_19 + arg_4_0 then
				arg_1_1.screenFilterEffect_.weight = 1
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				local var_4_20 = arg_1_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_4_20 then
					arg_1_1.var_.alphaOldValue10144 = var_4_20.alpha
					arg_1_1.var_.characterEffect10144 = var_4_20
				end

				arg_1_1.var_.alphaOldValue10144 = 0
			end

			local var_4_21 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_21 then
				if arg_1_1.var_.characterEffect10144 then
					arg_1_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_1_1.var_.alphaOldValue10144, 1, (arg_1_1.time_ - 1.8) / var_4_21)
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_21 and arg_1_1.time_ < 1.8 + var_4_21 + arg_4_0 and arg_1_1.var_.characterEffect10144 then
				arg_1_1.var_.characterEffect10144.alpha = 1
			end

			if 0.166666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.166666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_25 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_25 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_25

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_25
						arg_1_1.bgmTxt2_.text = var_4_25
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle.awb")

				local var_4_28 = manager.audio:GetAudioName("bgm_activity_4_3_story_castle", "bgm_activity_4_3_story_castle")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_29 = 2
			local var_4_30 = 0.8

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_29 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_31 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_31:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_31:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_31:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_32 = arg_1_1:GetWordFromCfg(926091001)
				local var_4_33 = arg_1_1:FormatText(var_4_32.content)

				arg_1_1.text_.text = var_4_33

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 46 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 46)

				if (46 <= 0 and var_4_30 or var_4_30 * (utf8.len(var_4_33) / 46)) > 0 and var_4_30 < var_4_35 then
					arg_1_1.talkMaxDuration = var_4_35
					var_4_29 = var_4_29 + 0.3

					if var_4_35 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_35 + var_4_29
					end
				end

				arg_1_1.text_.text = var_4_33
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091001", "story_v_out_926091.awb") ~= 0 then
					local var_4_36 = manager.audio:GetVoiceLength("story_v_out_926091", "926091001", "story_v_out_926091.awb") / 1000

					if var_4_36 + var_4_29 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_36 + var_4_29
					end

					if var_4_32.prefab_name ~= "" and arg_1_1.actors_[var_4_32.prefab_name] ~= nil then
						local var_4_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_32.prefab_name].transform, "story_v_out_926091", "926091001", "story_v_out_926091.awb")

						arg_1_1:RecordAudio("926091001", var_4_37)
						arg_1_1:RecordAudio("926091001", var_4_37)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_926091", "926091001", "story_v_out_926091.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_926091", "926091001", "story_v_out_926091.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_29 + 0.3
			local var_4_39 = math.max(var_4_30, arg_1_1.talkMaxDuration)

			if var_4_29 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
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
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play926091002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 926091002
		arg_9_1.duration_ = 7.07

		local var_9_0 = {
			zh = 7.066,
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
				arg_9_0:Play926091003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.bgs_.ST0114 == nil then
				local var_12_0 = Object.Instantiate(arg_9_1.paintGo_)

				var_12_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0114")
				var_12_0.name = "ST0114"
				var_12_0.transform.parent = arg_9_1.stage_.transform
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.bgs_.ST0114 = var_12_0
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				local var_12_1 = arg_9_1.bgs_.ST0114

				arg_9_1.bgs_.ST0114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_12_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_12_2 = var_12_1:GetComponent("SpriteRenderer")

				if var_12_2 and var_12_2.sprite then
					local var_12_3 = 2 * (var_12_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_12_1.transform.localScale = Vector3.New(var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, var_12_3 / var_12_2.sprite.bounds.size.y < var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x and var_12_3 * manager.ui.mainCameraCom_.aspect / var_12_2.sprite.bounds.size.x or var_12_3 / var_12_2.sprite.bounds.size.y, 0)
				end

				for iter_12_0, iter_12_1 in pairs(arg_9_1.bgs_) do
					if iter_12_0 ~= "ST0114" then
						iter_12_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_12_4 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.allBtn_.enabled = false
			end

			if arg_9_1.time_ >= var_12_4 + 0.3 and arg_9_1.time_ < var_12_4 + 0.3 + arg_12_0 then
				arg_9_1.allBtn_.enabled = true
			end

			local var_12_5 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_5 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_6 = 1.434

			if var_12_5 <= arg_9_1.time_ and arg_9_1.time_ < var_12_5 + var_12_6 then
				local var_12_7 = Color.New(0, 0, 0)

				var_12_7.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_5) / var_12_6)
				arg_9_1.mask_.color = var_12_7
			end

			if arg_9_1.time_ >= var_12_5 + var_12_6 and arg_9_1.time_ < var_12_5 + var_12_6 + arg_12_0 then
				local var_12_8 = Color.New(0, 0, 0)

				arg_9_1.mask_.enabled = false
				var_12_8.a = 0
				arg_9_1.mask_.color = var_12_8
			end

			local var_12_9 = arg_9_1.actors_["10144"].transform

			if 1.26733333333333 < arg_9_1.time_ and arg_9_1.time_ <= 1.26733333333333 + arg_12_0 then
				arg_9_1.var_.moveOldPos10144 = var_12_9.localPosition
				var_12_9.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10144", 3)

				for iter_12_2 = 0, var_12_9.childCount - 1 do
					local var_12_10 = var_12_9:GetChild(iter_12_2)

					if var_12_10.name == "split_4" or not string.find(var_12_10.name, "split") then
						var_12_10.gameObject:SetActive(true)
					else
						var_12_10.gameObject:SetActive(false)
					end
				end
			end

			local var_12_11 = 0.001

			if 1.26733333333333 <= arg_9_1.time_ and arg_9_1.time_ < 1.26733333333333 + var_12_11 then
				var_12_9.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_9_1.time_ - 1.26733333333333) / var_12_11)
			end

			if arg_9_1.time_ >= 1.26733333333333 + var_12_11 and arg_9_1.time_ < 1.26733333333333 + var_12_11 + arg_12_0 then
				var_12_9.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_12_12 = arg_9_1.actors_["10144"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10144 = var_12_12.localPosition
				var_12_12.localScale = Vector3.New(1, 1, 1)

				arg_9_1:CheckSpriteTmpPos("10144", 7)

				for iter_12_3 = 0, var_12_12.childCount - 1 do
					local var_12_13 = var_12_12:GetChild(iter_12_3)

					if var_12_13.name == "" or not string.find(var_12_13.name, "split") then
						var_12_13.gameObject:SetActive(true)
					else
						var_12_13.gameObject:SetActive(false)
					end
				end
			end

			local var_12_14 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_14 then
				var_12_12.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_9_1.time_ - 0) / var_12_14)
			end

			if arg_9_1.time_ >= 0 + var_12_14 and arg_9_1.time_ < 0 + var_12_14 + arg_12_0 then
				var_12_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.26733333333333 < arg_9_1.time_ and arg_9_1.time_ <= 1.26733333333333 + arg_12_0 then
				local var_12_15 = arg_9_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_12_15 then
					arg_9_1.var_.alphaOldValue10144 = var_12_15.alpha
					arg_9_1.var_.characterEffect10144 = var_12_15
				end

				arg_9_1.var_.alphaOldValue10144 = 0
			end

			local var_12_16 = 0.166666666666667

			if 1.26733333333333 <= arg_9_1.time_ and arg_9_1.time_ < 1.26733333333333 + var_12_16 then
				if arg_9_1.var_.characterEffect10144 then
					arg_9_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_9_1.var_.alphaOldValue10144, 1, (arg_9_1.time_ - 1.26733333333333) / var_12_16)
				end
			end

			if arg_9_1.time_ >= 1.26733333333333 + var_12_16 and arg_9_1.time_ < 1.26733333333333 + var_12_16 + arg_12_0 and arg_9_1.var_.characterEffect10144 then
				arg_9_1.var_.characterEffect10144.alpha = 1
			end

			if 0.166666666666667 < arg_9_1.time_ and arg_9_1.time_ <= 0.166666666666667 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:AudioAction("stop", "effect", "se_story_activity_1_2_summer1", "se_story_activity_1_2_summer1_beachdayloop", "")
			end

			if arg_9_1.frameCnt_ <= 1 then
				arg_9_1.dialog_:SetActive(false)
			end

			local var_12_19 = 1.5
			local var_12_20 = 0.65

			if 1.5 < arg_9_1.time_ and arg_9_1.time_ <= var_12_19 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_21 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_21:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_22 = arg_9_1:GetWordFromCfg(926091002)
				local var_12_23 = arg_9_1:FormatText(var_12_22.content)

				arg_9_1.text_.text = var_12_23

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_25 = 26 <= 0 and var_12_20 or var_12_20 * (utf8.len(var_12_23) / 26)

				if (26 <= 0 and var_12_20 or var_12_20 * (utf8.len(var_12_23) / 26)) > 0 and var_12_20 < var_12_25 then
					arg_9_1.talkMaxDuration = var_12_25
					var_12_19 = var_12_19 + 0.3

					if var_12_25 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_25 + var_12_19
					end
				end

				arg_9_1.text_.text = var_12_23
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091002", "story_v_out_926091.awb") ~= 0 then
					local var_12_26 = manager.audio:GetVoiceLength("story_v_out_926091", "926091002", "story_v_out_926091.awb") / 1000

					if var_12_26 + var_12_19 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_26 + var_12_19
					end

					if var_12_22.prefab_name ~= "" and arg_9_1.actors_[var_12_22.prefab_name] ~= nil then
						local var_12_27 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_22.prefab_name].transform, "story_v_out_926091", "926091002", "story_v_out_926091.awb")

						arg_9_1:RecordAudio("926091002", var_12_27)
						arg_9_1:RecordAudio("926091002", var_12_27)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_926091", "926091002", "story_v_out_926091.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_926091", "926091002", "story_v_out_926091.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_28 = var_12_19 + 0.3
			local var_12_29 = math.max(var_12_20, arg_9_1.talkMaxDuration)

			if var_12_19 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_28 + var_12_29 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_28) / var_12_29

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_28 + var_12_29 and arg_9_1.time_ < var_12_28 + var_12_29 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.26733333333333,
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

		arg_9_1:InitPlayNodeList()
	end,
	Play926091003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 926091003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play926091004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["10144"]) and arg_15_1.var_.actorSpriteComps10144 == nil then
				arg_15_1.var_.actorSpriteComps10144 = arg_15_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_18_0 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["10144"]) then
				if arg_15_1.var_.actorSpriteComps10144 then
					for iter_18_0, iter_18_1 in pairs(arg_15_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_18_1 then
							if arg_15_1.isInRecall_ then
								iter_18_1.color = Color.New(Mathf.Lerp(iter_18_1.color.r, arg_15_1.hightColor2.r, (arg_15_1.time_ - 0) / var_18_0), Mathf.Lerp(iter_18_1.color.g, arg_15_1.hightColor2.g, (arg_15_1.time_ - 0) / var_18_0), (Mathf.Lerp(iter_18_1.color.b, arg_15_1.hightColor2.b, (arg_15_1.time_ - 0) / var_18_0)))
							else
								local var_18_1 = Mathf.Lerp(iter_18_1.color.r, 0.5, (arg_15_1.time_ - 0) / var_18_0)

								iter_18_1.color = Color.New(var_18_1, var_18_1, var_18_1)
							end
						end
					end
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["10144"]) and arg_15_1.var_.actorSpriteComps10144 then
				for iter_18_2, iter_18_3 in pairs(arg_15_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_18_3 then
						iter_18_3.color = arg_15_1.isInRecall_ and (arg_15_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_15_1.var_.actorSpriteComps10144 = nil
			end

			local var_18_2 = 0
			local var_18_3 = 0.925

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_2 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_4 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(926091003).content)

				arg_15_1.text_.text = var_18_4

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_6 = 37 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 37)

				if (37 <= 0 and var_18_3 or var_18_3 * (utf8.len(var_18_4) / 37)) > 0 and var_18_3 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_2 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_2
					end
				end

				arg_15_1.text_.text = var_18_4
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_3, arg_15_1.talkMaxDuration)

			if var_18_2 <= arg_15_1.time_ and arg_15_1.time_ < var_18_2 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_2) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_2 + var_18_7 and arg_15_1.time_ < var_18_2 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play926091004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 926091004
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play926091005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.75

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
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

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(926091004).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 30 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 30)

				if (30 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 30)) > 0 and var_22_0 < var_22_3 then
					arg_19_1.talkMaxDuration = var_22_3

					if var_22_3 + 0 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_3 + 0
					end
				end

				arg_19_1.text_.text = var_22_1
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)
				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_4 = math.max(var_22_0, arg_19_1.talkMaxDuration)

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - 0) / var_22_4

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play926091005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 926091005
		arg_23_1.duration_ = 8.04

		local var_23_0 = {
			zh = 5.108,
			ja = 8.041
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
				arg_23_0:Play926091006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				local var_26_0 = arg_23_1.bgs_.ST0114

				arg_23_1.bgs_.ST0114.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_26_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_26_1 = var_26_0:GetComponent("SpriteRenderer")

				if var_26_1 and var_26_1.sprite then
					local var_26_2 = 2 * (var_26_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_26_0.transform.localScale = Vector3.New(var_26_2 / var_26_1.sprite.bounds.size.y < var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x and var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x or var_26_2 / var_26_1.sprite.bounds.size.y, var_26_2 / var_26_1.sprite.bounds.size.y < var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x and var_26_2 * manager.ui.mainCameraCom_.aspect / var_26_1.sprite.bounds.size.x or var_26_2 / var_26_1.sprite.bounds.size.y, 0)
				end

				for iter_26_0, iter_26_1 in pairs(arg_23_1.bgs_) do
					if iter_26_0 ~= "ST0114" then
						iter_26_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_26_3 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.allBtn_.enabled = false
			end

			if arg_23_1.time_ >= var_26_3 + 0.3 and arg_23_1.time_ < var_26_3 + 0.3 + arg_26_0 then
				arg_23_1.allBtn_.enabled = true
			end

			local var_26_4 = 0

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.mask_.enabled = true
				arg_23_1.mask_.raycastTarget = true

				arg_23_1:SetGaussion(false)
			end

			local var_26_5 = 1.675

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_5 then
				local var_26_6 = Color.New(0, 0, 0)

				var_26_6.a = Mathf.Lerp(1, 0, (arg_23_1.time_ - var_26_4) / var_26_5)
				arg_23_1.mask_.color = var_26_6
			end

			if arg_23_1.time_ >= var_26_4 + var_26_5 and arg_23_1.time_ < var_26_4 + var_26_5 + arg_26_0 then
				local var_26_7 = Color.New(0, 0, 0)

				arg_23_1.mask_.enabled = false
				var_26_7.a = 0
				arg_23_1.mask_.color = var_26_7
			end

			local var_26_8 = arg_23_1.actors_["10144"]

			if 1.3 < arg_23_1.time_ and arg_23_1.time_ <= 1.3 + arg_26_0 and not isNil(var_26_8) and arg_23_1.var_.actorSpriteComps10144 == nil then
				arg_23_1.var_.actorSpriteComps10144 = var_26_8:GetComponentsInChildren(typeof(Image), true)
			end

			local var_26_9 = 0.2

			if 1.3 <= arg_23_1.time_ and arg_23_1.time_ < 1.3 + var_26_9 and not isNil(var_26_8) then
				if arg_23_1.var_.actorSpriteComps10144 then
					for iter_26_2, iter_26_3 in pairs(arg_23_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_26_3 then
							if arg_23_1.isInRecall_ then
								iter_26_3.color = Color.New(Mathf.Lerp(iter_26_3.color.r, arg_23_1.hightColor1.r, (arg_23_1.time_ - 1.3) / var_26_9), Mathf.Lerp(iter_26_3.color.g, arg_23_1.hightColor1.g, (arg_23_1.time_ - 1.3) / var_26_9), (Mathf.Lerp(iter_26_3.color.b, arg_23_1.hightColor1.b, (arg_23_1.time_ - 1.3) / var_26_9)))
							else
								local var_26_10 = Mathf.Lerp(iter_26_3.color.r, 1, (arg_23_1.time_ - 1.3) / var_26_9)

								iter_26_3.color = Color.New(var_26_10, var_26_10, var_26_10)
							end
						end
					end
				end
			end

			if arg_23_1.time_ >= 1.3 + var_26_9 and arg_23_1.time_ < 1.3 + var_26_9 + arg_26_0 and not isNil(var_26_8) and arg_23_1.var_.actorSpriteComps10144 then
				for iter_26_4, iter_26_5 in pairs(arg_23_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_26_5 then
						iter_26_5.color = arg_23_1.isInRecall_ and (arg_23_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_23_1.var_.actorSpriteComps10144 = nil
			end

			local var_26_11 = arg_23_1.actors_["10144"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos10144 = var_26_11.localPosition
				var_26_11.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10144", 7)

				for iter_26_6 = 0, var_26_11.childCount - 1 do
					local var_26_12 = var_26_11:GetChild(iter_26_6)

					if var_26_12.name == "" or not string.find(var_26_12.name, "split") then
						var_26_12.gameObject:SetActive(true)
					else
						var_26_12.gameObject:SetActive(false)
					end
				end
			end

			local var_26_13 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_13 then
				var_26_11.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_23_1.time_ - 0) / var_26_13)
			end

			if arg_23_1.time_ >= 0 + var_26_13 and arg_23_1.time_ < 0 + var_26_13 + arg_26_0 then
				var_26_11.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_26_14 = arg_23_1.actors_["10144"].transform

			if 1.3 < arg_23_1.time_ and arg_23_1.time_ <= 1.3 + arg_26_0 then
				arg_23_1.var_.moveOldPos10144 = var_26_14.localPosition
				var_26_14.localScale = Vector3.New(1, 1, 1)

				arg_23_1:CheckSpriteTmpPos("10144", 3)

				for iter_26_7 = 0, var_26_14.childCount - 1 do
					local var_26_15 = var_26_14:GetChild(iter_26_7)

					if var_26_15.name == "split_2" or not string.find(var_26_15.name, "split") then
						var_26_15.gameObject:SetActive(true)
					else
						var_26_15.gameObject:SetActive(false)
					end
				end
			end

			local var_26_16 = 0.001

			if 1.3 <= arg_23_1.time_ and arg_23_1.time_ < 1.3 + var_26_16 then
				var_26_14.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_23_1.time_ - 1.3) / var_26_16)
			end

			if arg_23_1.time_ >= 1.3 + var_26_16 and arg_23_1.time_ < 1.3 + var_26_16 + arg_26_0 then
				var_26_14.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			if 1.3 < arg_23_1.time_ and arg_23_1.time_ <= 1.3 + arg_26_0 then
				local var_26_17 = arg_23_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_26_17 then
					arg_23_1.var_.alphaOldValue10144 = var_26_17.alpha
					arg_23_1.var_.characterEffect10144 = var_26_17
				end

				arg_23_1.var_.alphaOldValue10144 = 0
			end

			local var_26_18 = 0.166666666666667

			if 1.3 <= arg_23_1.time_ and arg_23_1.time_ < 1.3 + var_26_18 then
				if arg_23_1.var_.characterEffect10144 then
					arg_23_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_23_1.var_.alphaOldValue10144, 1, (arg_23_1.time_ - 1.3) / var_26_18)
				end
			end

			if arg_23_1.time_ >= 1.3 + var_26_18 and arg_23_1.time_ < 1.3 + var_26_18 + arg_26_0 and arg_23_1.var_.characterEffect10144 then
				arg_23_1.var_.characterEffect10144.alpha = 1
			end

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_bar", "")
			end

			if 0.034 < arg_23_1.time_ and arg_23_1.time_ <= 0.034 + arg_26_0 then
				arg_23_1:AudioAction("play", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if arg_23_1.frameCnt_ <= 1 then
				arg_23_1.dialog_:SetActive(false)
			end

			local var_26_21 = 1.675
			local var_26_22 = 0.325

			if 1.675 < arg_23_1.time_ and arg_23_1.time_ <= var_26_21 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				arg_23_1.dialog_:SetActive(true)

				arg_23_1.dialogCg_.alpha = 0

				local var_26_23 = LeanTween.value(arg_23_1.dialog_, 0, 1, 0.3)

				var_26_23:setOnUpdate(LuaHelper.FloatAction(function(arg_27_0)
					arg_23_1.dialogCg_.alpha = arg_27_0
				end))
				var_26_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_23_1.dialog_)
					var_26_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_23_1.duration_ = arg_23_1.duration_ + 0.3

				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_24 = arg_23_1:GetWordFromCfg(926091005)
				local var_26_25 = arg_23_1:FormatText(var_26_24.content)

				arg_23_1.text_.text = var_26_25

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_27 = 13 <= 0 and var_26_22 or var_26_22 * (utf8.len(var_26_25) / 13)

				if (13 <= 0 and var_26_22 or var_26_22 * (utf8.len(var_26_25) / 13)) > 0 and var_26_22 < var_26_27 then
					arg_23_1.talkMaxDuration = var_26_27
					var_26_21 = var_26_21 + 0.3

					if var_26_27 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_27 + var_26_21
					end
				end

				arg_23_1.text_.text = var_26_25
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091005", "story_v_out_926091.awb") ~= 0 then
					local var_26_28 = manager.audio:GetVoiceLength("story_v_out_926091", "926091005", "story_v_out_926091.awb") / 1000

					if var_26_28 + var_26_21 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_28 + var_26_21
					end

					if var_26_24.prefab_name ~= "" and arg_23_1.actors_[var_26_24.prefab_name] ~= nil then
						local var_26_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_24.prefab_name].transform, "story_v_out_926091", "926091005", "story_v_out_926091.awb")

						arg_23_1:RecordAudio("926091005", var_26_29)
						arg_23_1:RecordAudio("926091005", var_26_29)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_926091", "926091005", "story_v_out_926091.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_926091", "926091005", "story_v_out_926091.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_30 = var_26_21 + 0.3
			local var_26_31 = math.max(var_26_22, arg_23_1.talkMaxDuration)

			if var_26_21 + 0.3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_30 + var_26_31 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_30) / var_26_31

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_30 + var_26_31 and arg_23_1.time_ < var_26_30 + var_26_31 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_23_1:InitPlayNodeList()
	end,
	Play926091006 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 926091006
		arg_29_1.duration_ = 3.97

		local var_29_0 = {
			zh = 3.966,
			ja = 3.9
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
				arg_29_0:Play926091007(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.4

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(926091006)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 16 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 16)

				if (16 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 16)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091006", "story_v_out_926091.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091006", "story_v_out_926091.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_926091", "926091006", "story_v_out_926091.awb")

						arg_29_1:RecordAudio("926091006", var_32_6)
						arg_29_1:RecordAudio("926091006", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_926091", "926091006", "story_v_out_926091.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_926091", "926091006", "story_v_out_926091.awb")
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
	Play926091007 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 926091007
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play926091008(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10144"]) and arg_33_1.var_.actorSpriteComps10144 == nil then
				arg_33_1.var_.actorSpriteComps10144 = arg_33_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_36_0 = 0.2

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10144"]) then
				if arg_33_1.var_.actorSpriteComps10144 then
					for iter_36_0, iter_36_1 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10144"]) and arg_33_1.var_.actorSpriteComps10144 then
				for iter_36_2, iter_36_3 in pairs(arg_33_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_36_3 then
						iter_36_3.color = arg_33_1.isInRecall_ and (arg_33_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_33_1.var_.actorSpriteComps10144 = nil
			end

			local var_36_2 = 0
			local var_36_3 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_2 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, true)
				arg_33_1.iconController_:SetSelectedState("hero")

				arg_33_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_33_1.callingController_:SetSelectedState("normal")

				arg_33_1.keyicon_.color = Color.New(1, 1, 1)
				arg_33_1.icon_.color = Color.New(1, 1, 1)

				local var_36_4 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(926091007).content)

				arg_33_1.text_.text = var_36_4

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_6 = 14 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 14)

				if (14 <= 0 and var_36_3 or var_36_3 * (utf8.len(var_36_4) / 14)) > 0 and var_36_3 < var_36_6 then
					arg_33_1.talkMaxDuration = var_36_6

					if var_36_6 + var_36_2 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_6 + var_36_2
					end
				end

				arg_33_1.text_.text = var_36_4
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_7 = math.max(var_36_3, arg_33_1.talkMaxDuration)

			if var_36_2 <= arg_33_1.time_ and arg_33_1.time_ < var_36_2 + var_36_7 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_2) / var_36_7

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_2 + var_36_7 and arg_33_1.time_ < var_36_2 + var_36_7 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play926091008 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 926091008
		arg_37_1.duration_ = 4.73

		local var_37_0 = {
			zh = 3.533,
			ja = 4.733
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
				arg_37_0:Play926091009(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["10144"]) and arg_37_1.var_.actorSpriteComps10144 == nil then
				arg_37_1.var_.actorSpriteComps10144 = arg_37_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_40_0 = 0.2

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["10144"]) then
				if arg_37_1.var_.actorSpriteComps10144 then
					for iter_40_0, iter_40_1 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["10144"]) and arg_37_1.var_.actorSpriteComps10144 then
				for iter_40_2, iter_40_3 in pairs(arg_37_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_40_3 then
						iter_40_3.color = arg_37_1.isInRecall_ and (arg_37_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_37_1.var_.actorSpriteComps10144 = nil
			end

			local var_40_2 = arg_37_1.actors_["10144"].transform

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos10144 = var_40_2.localPosition
				var_40_2.localScale = Vector3.New(1, 1, 1)

				arg_37_1:CheckSpriteTmpPos("10144", 3)

				for iter_40_4 = 0, var_40_2.childCount - 1 do
					local var_40_3 = var_40_2:GetChild(iter_40_4)

					if var_40_3.name == "split_1" or not string.find(var_40_3.name, "split") then
						var_40_3.gameObject:SetActive(true)
					else
						var_40_3.gameObject:SetActive(false)
					end
				end
			end

			local var_40_4 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_4 then
				var_40_2.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_37_1.time_ - 0) / var_40_4)
			end

			if arg_37_1.time_ >= 0 + var_40_4 and arg_37_1.time_ < 0 + var_40_4 + arg_40_0 then
				var_40_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_40_5 = 0
			local var_40_6 = 0.4

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_5 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_7 = arg_37_1:GetWordFromCfg(926091008)
				local var_40_8 = arg_37_1:FormatText(var_40_7.content)

				arg_37_1.text_.text = var_40_8

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_10 = 16 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 16)

				if (16 <= 0 and var_40_6 or var_40_6 * (utf8.len(var_40_8) / 16)) > 0 and var_40_6 < var_40_10 then
					arg_37_1.talkMaxDuration = var_40_10

					if var_40_10 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_10 + var_40_5
					end
				end

				arg_37_1.text_.text = var_40_8
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091008", "story_v_out_926091.awb") ~= 0 then
					local var_40_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091008", "story_v_out_926091.awb") / 1000

					if var_40_11 + var_40_5 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_5
					end

					if var_40_7.prefab_name ~= "" and arg_37_1.actors_[var_40_7.prefab_name] ~= nil then
						local var_40_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_7.prefab_name].transform, "story_v_out_926091", "926091008", "story_v_out_926091.awb")

						arg_37_1:RecordAudio("926091008", var_40_12)
						arg_37_1:RecordAudio("926091008", var_40_12)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_926091", "926091008", "story_v_out_926091.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_926091", "926091008", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091009 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 926091009
		arg_41_1.duration_ = 7.87

		local var_41_0 = {
			zh = 6.93266666666667,
			ja = 7.86666666666667
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
				arg_41_0:Play926091010(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if arg_41_1.bgs_.I21f == nil then
				local var_44_0 = Object.Instantiate(arg_41_1.paintGo_)

				var_44_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I21f")
				var_44_0.name = "I21f"
				var_44_0.transform.parent = arg_41_1.stage_.transform
				var_44_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_41_1.bgs_.I21f = var_44_0
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				local var_44_1 = arg_41_1.bgs_.I21f

				arg_41_1.bgs_.I21f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_44_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_44_2 = var_44_1:GetComponent("SpriteRenderer")

				if var_44_2 and var_44_2.sprite then
					local var_44_3 = 2 * (var_44_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_44_1.transform.localScale = Vector3.New(var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, var_44_3 / var_44_2.sprite.bounds.size.y < var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x and var_44_3 * manager.ui.mainCameraCom_.aspect / var_44_2.sprite.bounds.size.x or var_44_3 / var_44_2.sprite.bounds.size.y, 0)
				end

				for iter_44_0, iter_44_1 in pairs(arg_41_1.bgs_) do
					if iter_44_0 ~= "I21f" then
						iter_44_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_44_4 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.allBtn_.enabled = false
			end

			if arg_41_1.time_ >= var_44_4 + 0.3 and arg_41_1.time_ < var_44_4 + 0.3 + arg_44_0 then
				arg_41_1.allBtn_.enabled = true
			end

			local var_44_5 = 0

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_5 + arg_44_0 then
				arg_41_1.mask_.enabled = true
				arg_41_1.mask_.raycastTarget = true

				arg_41_1:SetGaussion(false)
			end

			local var_44_6 = 1.46666666666667

			if var_44_5 <= arg_41_1.time_ and arg_41_1.time_ < var_44_5 + var_44_6 then
				local var_44_7 = Color.New(0, 0, 0)

				var_44_7.a = Mathf.Lerp(1, 0, (arg_41_1.time_ - var_44_5) / var_44_6)
				arg_41_1.mask_.color = var_44_7
			end

			if arg_41_1.time_ >= var_44_5 + var_44_6 and arg_41_1.time_ < var_44_5 + var_44_6 + arg_44_0 then
				local var_44_8 = Color.New(0, 0, 0)

				arg_41_1.mask_.enabled = false
				var_44_8.a = 0
				arg_41_1.mask_.color = var_44_8
			end

			local var_44_9 = arg_41_1.actors_["10144"].transform

			if 1.3 < arg_41_1.time_ and arg_41_1.time_ <= 1.3 + arg_44_0 then
				arg_41_1.var_.moveOldPos10144 = var_44_9.localPosition
				var_44_9.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10144", 3)

				for iter_44_2 = 0, var_44_9.childCount - 1 do
					local var_44_10 = var_44_9:GetChild(iter_44_2)

					if var_44_10.name == "split_7" or not string.find(var_44_10.name, "split") then
						var_44_10.gameObject:SetActive(true)
					else
						var_44_10.gameObject:SetActive(false)
					end
				end
			end

			local var_44_11 = 0.001

			if 1.3 <= arg_41_1.time_ and arg_41_1.time_ < 1.3 + var_44_11 then
				var_44_9.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_41_1.time_ - 1.3) / var_44_11)
			end

			if arg_41_1.time_ >= 1.3 + var_44_11 and arg_41_1.time_ < 1.3 + var_44_11 + arg_44_0 then
				var_44_9.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_44_12 = arg_41_1.actors_["10144"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10144 = var_44_12.localPosition
				var_44_12.localScale = Vector3.New(1, 1, 1)

				arg_41_1:CheckSpriteTmpPos("10144", 7)

				for iter_44_3 = 0, var_44_12.childCount - 1 do
					local var_44_13 = var_44_12:GetChild(iter_44_3)

					if var_44_13.name == "" or not string.find(var_44_13.name, "split") then
						var_44_13.gameObject:SetActive(true)
					else
						var_44_13.gameObject:SetActive(false)
					end
				end
			end

			local var_44_14 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_14 then
				var_44_12.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_41_1.time_ - 0) / var_44_14)
			end

			if arg_41_1.time_ >= 0 + var_44_14 and arg_41_1.time_ < 0 + var_44_14 + arg_44_0 then
				var_44_12.localPosition = Vector3.New(0, -2000, 0)
			end

			if 1.3 < arg_41_1.time_ and arg_41_1.time_ <= 1.3 + arg_44_0 then
				local var_44_15 = arg_41_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_44_15 then
					arg_41_1.var_.alphaOldValue10144 = var_44_15.alpha
					arg_41_1.var_.characterEffect10144 = var_44_15
				end

				arg_41_1.var_.alphaOldValue10144 = 0
			end

			local var_44_16 = 0.166666666666667

			if 1.3 <= arg_41_1.time_ and arg_41_1.time_ < 1.3 + var_44_16 then
				if arg_41_1.var_.characterEffect10144 then
					arg_41_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_41_1.var_.alphaOldValue10144, 1, (arg_41_1.time_ - 1.3) / var_44_16)
				end
			end

			if arg_41_1.time_ >= 1.3 + var_44_16 and arg_41_1.time_ < 1.3 + var_44_16 + arg_44_0 and arg_41_1.var_.characterEffect10144 then
				arg_41_1.var_.characterEffect10144.alpha = 1
			end

			if arg_41_1.frameCnt_ <= 1 then
				arg_41_1.dialog_:SetActive(false)
			end

			local var_44_17 = 1.46666666666667
			local var_44_18 = 0.625

			if 1.46666666666667 < arg_41_1.time_ and arg_41_1.time_ <= var_44_17 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0

				arg_41_1.dialog_:SetActive(true)

				arg_41_1.dialogCg_.alpha = 0

				local var_44_19 = LeanTween.value(arg_41_1.dialog_, 0, 1, 0.3)

				var_44_19:setOnUpdate(LuaHelper.FloatAction(function(arg_45_0)
					arg_41_1.dialogCg_.alpha = arg_45_0
				end))
				var_44_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_41_1.dialog_)
					var_44_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_41_1.duration_ = arg_41_1.duration_ + 0.3

				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_20 = arg_41_1:GetWordFromCfg(926091009)
				local var_44_21 = arg_41_1:FormatText(var_44_20.content)

				arg_41_1.text_.text = var_44_21

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_23 = 25 <= 0 and var_44_18 or var_44_18 * (utf8.len(var_44_21) / 25)

				if (25 <= 0 and var_44_18 or var_44_18 * (utf8.len(var_44_21) / 25)) > 0 and var_44_18 < var_44_23 then
					arg_41_1.talkMaxDuration = var_44_23
					var_44_17 = var_44_17 + 0.3

					if var_44_23 + var_44_17 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_23 + var_44_17
					end
				end

				arg_41_1.text_.text = var_44_21
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091009", "story_v_out_926091.awb") ~= 0 then
					local var_44_24 = manager.audio:GetVoiceLength("story_v_out_926091", "926091009", "story_v_out_926091.awb") / 1000

					if var_44_24 + var_44_17 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_24 + var_44_17
					end

					if var_44_20.prefab_name ~= "" and arg_41_1.actors_[var_44_20.prefab_name] ~= nil then
						local var_44_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_20.prefab_name].transform, "story_v_out_926091", "926091009", "story_v_out_926091.awb")

						arg_41_1:RecordAudio("926091009", var_44_25)
						arg_41_1:RecordAudio("926091009", var_44_25)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_926091", "926091009", "story_v_out_926091.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_926091", "926091009", "story_v_out_926091.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_26 = var_44_17 + 0.3
			local var_44_27 = math.max(var_44_18, arg_41_1.talkMaxDuration)

			if var_44_17 + 0.3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_26 + var_44_27 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_26) / var_44_27

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_26 + var_44_27 and arg_41_1.time_ < var_44_26 + var_44_27 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.3,
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

		arg_41_1:InitPlayNodeList()
	end,
	Play926091010 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 926091010
		arg_47_1.duration_ = 5.07

		local var_47_0 = {
			zh = 3.033,
			ja = 5.066
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
				arg_47_0:Play926091011(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0.4

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_1 = arg_47_1:GetWordFromCfg(926091010)
				local var_50_2 = arg_47_1:FormatText(var_50_1.content)

				arg_47_1.text_.text = var_50_2

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_4 = 16 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 16)

				if (16 <= 0 and var_50_0 or var_50_0 * (utf8.len(var_50_2) / 16)) > 0 and var_50_0 < var_50_4 then
					arg_47_1.talkMaxDuration = var_50_4

					if var_50_4 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_4 + 0
					end
				end

				arg_47_1.text_.text = var_50_2
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091010", "story_v_out_926091.awb") ~= 0 then
					local var_50_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091010", "story_v_out_926091.awb") / 1000

					if var_50_5 + 0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + 0
					end

					if var_50_1.prefab_name ~= "" and arg_47_1.actors_[var_50_1.prefab_name] ~= nil then
						local var_50_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_1.prefab_name].transform, "story_v_out_926091", "926091010", "story_v_out_926091.awb")

						arg_47_1:RecordAudio("926091010", var_50_6)
						arg_47_1:RecordAudio("926091010", var_50_6)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_926091", "926091010", "story_v_out_926091.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_926091", "926091010", "story_v_out_926091.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_7 = math.max(var_50_0, arg_47_1.talkMaxDuration)

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_7 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - 0) / var_50_7

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= 0 + var_50_7 and arg_47_1.time_ < 0 + var_50_7 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play926091011 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 926091011
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play926091012(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10144"]) and arg_51_1.var_.actorSpriteComps10144 == nil then
				arg_51_1.var_.actorSpriteComps10144 = arg_51_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_54_0 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10144"]) then
				if arg_51_1.var_.actorSpriteComps10144 then
					for iter_54_0, iter_54_1 in pairs(arg_51_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10144"]) and arg_51_1.var_.actorSpriteComps10144 then
				for iter_54_2, iter_54_3 in pairs(arg_51_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_54_3 then
						iter_54_3.color = arg_51_1.isInRecall_ and (arg_51_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_51_1.var_.actorSpriteComps10144 = nil
			end

			local var_54_2 = 0
			local var_54_3 = 0.45

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_4 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(926091011).content)

				arg_51_1.text_.text = var_54_4

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_6 = 18 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 18)

				if (18 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_4) / 18)) > 0 and var_54_3 < var_54_6 then
					arg_51_1.talkMaxDuration = var_54_6

					if var_54_6 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_4
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_7 and arg_51_1.time_ < var_54_2 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play926091012 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 926091012
		arg_55_1.duration_ = 6.47

		local var_55_0 = {
			zh = 5.433,
			ja = 6.466
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
				arg_55_0:Play926091013(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if arg_55_1.bgs_.I20f == nil then
				local var_58_0 = Object.Instantiate(arg_55_1.paintGo_)

				var_58_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I20f")
				var_58_0.name = "I20f"
				var_58_0.transform.parent = arg_55_1.stage_.transform
				var_58_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.bgs_.I20f = var_58_0
			end

			if 1.3 < arg_55_1.time_ and arg_55_1.time_ <= 1.3 + arg_58_0 then
				local var_58_1 = arg_55_1.bgs_.I20f

				arg_55_1.bgs_.I20f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_58_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_58_2 = var_58_1:GetComponent("SpriteRenderer")

				if var_58_2 and var_58_2.sprite then
					local var_58_3 = 2 * (var_58_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_58_1.transform.localScale = Vector3.New(var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, var_58_3 / var_58_2.sprite.bounds.size.y < var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x and var_58_3 * manager.ui.mainCameraCom_.aspect / var_58_2.sprite.bounds.size.x or var_58_3 / var_58_2.sprite.bounds.size.y, 0)
				end

				for iter_58_0, iter_58_1 in pairs(arg_55_1.bgs_) do
					if iter_58_0 ~= "I20f" then
						iter_58_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_58_4 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_4 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			if arg_55_1.time_ >= var_58_4 + 0.3 and arg_55_1.time_ < var_58_4 + 0.3 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end

			local var_58_5 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_6 = 1.3

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_6 then
				local var_58_7 = Color.New(0, 0, 0)

				var_58_7.a = Mathf.Lerp(0, 1, (arg_55_1.time_ - var_58_5) / var_58_6)
				arg_55_1.mask_.color = var_58_7
			end

			if arg_55_1.time_ >= var_58_5 + var_58_6 and arg_55_1.time_ < var_58_5 + var_58_6 + arg_58_0 then
				local var_58_8 = Color.New(0, 0, 0)

				var_58_8.a = 1
				arg_55_1.mask_.color = var_58_8
			end

			local var_58_9 = 1.3

			if 1.3 < arg_55_1.time_ and arg_55_1.time_ <= var_58_9 + arg_58_0 then
				arg_55_1.mask_.enabled = true
				arg_55_1.mask_.raycastTarget = true

				arg_55_1:SetGaussion(false)
			end

			local var_58_10 = 2

			if var_58_9 <= arg_55_1.time_ and arg_55_1.time_ < var_58_9 + var_58_10 then
				local var_58_11 = Color.New(0, 0, 0)

				var_58_11.a = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_9) / var_58_10)
				arg_55_1.mask_.color = var_58_11
			end

			if arg_55_1.time_ >= var_58_9 + var_58_10 and arg_55_1.time_ < var_58_9 + var_58_10 + arg_58_0 then
				local var_58_12 = Color.New(0, 0, 0)

				arg_55_1.mask_.enabled = false
				var_58_12.a = 0
				arg_55_1.mask_.color = var_58_12
			end

			local var_58_13 = arg_55_1.actors_["10144"]

			if 2.9 < arg_55_1.time_ and arg_55_1.time_ <= 2.9 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.actorSpriteComps10144 == nil then
				arg_55_1.var_.actorSpriteComps10144 = var_58_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_58_14 = 0.2

			if 2.9 <= arg_55_1.time_ and arg_55_1.time_ < 2.9 + var_58_14 and not isNil(var_58_13) then
				if arg_55_1.var_.actorSpriteComps10144 then
					for iter_58_2, iter_58_3 in pairs(arg_55_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_58_3 then
							if arg_55_1.isInRecall_ then
								iter_58_3.color = Color.New(Mathf.Lerp(iter_58_3.color.r, arg_55_1.hightColor1.r, (arg_55_1.time_ - 2.9) / var_58_14), Mathf.Lerp(iter_58_3.color.g, arg_55_1.hightColor1.g, (arg_55_1.time_ - 2.9) / var_58_14), (Mathf.Lerp(iter_58_3.color.b, arg_55_1.hightColor1.b, (arg_55_1.time_ - 2.9) / var_58_14)))
							else
								local var_58_15 = Mathf.Lerp(iter_58_3.color.r, 1, (arg_55_1.time_ - 2.9) / var_58_14)

								iter_58_3.color = Color.New(var_58_15, var_58_15, var_58_15)
							end
						end
					end
				end
			end

			if arg_55_1.time_ >= 2.9 + var_58_14 and arg_55_1.time_ < 2.9 + var_58_14 + arg_58_0 and not isNil(var_58_13) and arg_55_1.var_.actorSpriteComps10144 then
				for iter_58_4, iter_58_5 in pairs(arg_55_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_58_5 then
						iter_58_5.color = arg_55_1.isInRecall_ and (arg_55_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_55_1.var_.actorSpriteComps10144 = nil
			end

			local var_58_16 = arg_55_1.actors_["10144"].transform

			if 1.3 < arg_55_1.time_ and arg_55_1.time_ <= 1.3 + arg_58_0 then
				arg_55_1.var_.moveOldPos10144 = var_58_16.localPosition
				var_58_16.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10144", 7)

				for iter_58_6 = 0, var_58_16.childCount - 1 do
					local var_58_17 = var_58_16:GetChild(iter_58_6)

					if var_58_17.name == "" or not string.find(var_58_17.name, "split") then
						var_58_17.gameObject:SetActive(true)
					else
						var_58_17.gameObject:SetActive(false)
					end
				end
			end

			local var_58_18 = 0.001

			if 1.3 <= arg_55_1.time_ and arg_55_1.time_ < 1.3 + var_58_18 then
				var_58_16.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_55_1.time_ - 1.3) / var_58_18)
			end

			if arg_55_1.time_ >= 1.3 + var_58_18 and arg_55_1.time_ < 1.3 + var_58_18 + arg_58_0 then
				var_58_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_58_19 = arg_55_1.actors_["10144"].transform

			if 2.9 < arg_55_1.time_ and arg_55_1.time_ <= 2.9 + arg_58_0 then
				arg_55_1.var_.moveOldPos10144 = var_58_19.localPosition
				var_58_19.localScale = Vector3.New(1, 1, 1)

				arg_55_1:CheckSpriteTmpPos("10144", 3)

				for iter_58_7 = 0, var_58_19.childCount - 1 do
					local var_58_20 = var_58_19:GetChild(iter_58_7)

					if var_58_20.name == "split_4" or not string.find(var_58_20.name, "split") then
						var_58_20.gameObject:SetActive(true)
					else
						var_58_20.gameObject:SetActive(false)
					end
				end
			end

			local var_58_21 = 0.001

			if 2.9 <= arg_55_1.time_ and arg_55_1.time_ < 2.9 + var_58_21 then
				var_58_19.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_55_1.time_ - 2.9) / var_58_21)
			end

			if arg_55_1.time_ >= 2.9 + var_58_21 and arg_55_1.time_ < 2.9 + var_58_21 + arg_58_0 then
				var_58_19.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_58_22 = 1.3

			arg_55_1.isInRecall_ = false

			if var_58_22 < arg_55_1.time_ and arg_55_1.time_ <= var_58_22 + arg_58_0 then
				arg_55_1.screenFilterGo_:SetActive(false)

				for iter_58_8, iter_58_9 in pairs(arg_55_1.actors_) do
					for iter_58_10, iter_58_11 in ipairs((iter_58_9:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_58_11.color = iter_58_11.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_58_23 = 0.0166666666666667

			if var_58_22 <= arg_55_1.time_ and arg_55_1.time_ < var_58_22 + var_58_23 then
				arg_55_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_55_1.time_ - var_58_22) / var_58_23)
			end

			if arg_55_1.time_ >= var_58_22 + var_58_23 and arg_55_1.time_ < var_58_22 + var_58_23 + arg_58_0 then
				arg_55_1.screenFilterEffect_.weight = 0
			end

			if 2.9 < arg_55_1.time_ and arg_55_1.time_ <= 2.9 + arg_58_0 then
				local var_58_24 = arg_55_1.actors_["10144"]:GetComponentInChildren(typeof(CanvasGroup))

				if var_58_24 then
					arg_55_1.var_.alphaOldValue10144 = var_58_24.alpha
					arg_55_1.var_.characterEffect10144 = var_58_24
				end

				arg_55_1.var_.alphaOldValue10144 = 0
			end

			local var_58_25 = 0.166

			if 2.9 <= arg_55_1.time_ and arg_55_1.time_ < 2.9 + var_58_25 then
				if arg_55_1.var_.characterEffect10144 then
					arg_55_1.var_.characterEffect10144.alpha = Mathf.Lerp(arg_55_1.var_.alphaOldValue10144, 1, (arg_55_1.time_ - 2.9) / var_58_25)
				end
			end

			if arg_55_1.time_ >= 2.9 + var_58_25 and arg_55_1.time_ < 2.9 + var_58_25 + arg_58_0 and arg_55_1.var_.characterEffect10144 then
				arg_55_1.var_.characterEffect10144.alpha = 1
			end

			if 0.166666666666667 < arg_55_1.time_ and arg_55_1.time_ <= 0.166666666666667 + arg_58_0 then
				arg_55_1:AudioAction("stop", "effect", "se_story_side_1058", "se_story_side_1058_forest_loop", "")
			end

			if 1 < arg_55_1.time_ and arg_55_1.time_ <= 1 + arg_58_0 then
				arg_55_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if arg_55_1.frameCnt_ <= 1 then
				arg_55_1.dialog_:SetActive(false)
			end

			local var_58_28 = 3.3
			local var_58_29 = 0.275

			if 3.3 < arg_55_1.time_ and arg_55_1.time_ <= var_58_28 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				arg_55_1.dialog_:SetActive(true)

				arg_55_1.dialogCg_.alpha = 0

				local var_58_30 = LeanTween.value(arg_55_1.dialog_, 0, 1, 0.3)

				var_58_30:setOnUpdate(LuaHelper.FloatAction(function(arg_59_0)
					arg_55_1.dialogCg_.alpha = arg_59_0
				end))
				var_58_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_55_1.dialog_)
					var_58_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_55_1.duration_ = arg_55_1.duration_ + 0.3

				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_31 = arg_55_1:GetWordFromCfg(926091012)
				local var_58_32 = arg_55_1:FormatText(var_58_31.content)

				arg_55_1.text_.text = var_58_32

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_34 = 11 <= 0 and var_58_29 or var_58_29 * (utf8.len(var_58_32) / 11)

				if (11 <= 0 and var_58_29 or var_58_29 * (utf8.len(var_58_32) / 11)) > 0 and var_58_29 < var_58_34 then
					arg_55_1.talkMaxDuration = var_58_34
					var_58_28 = var_58_28 + 0.3

					if var_58_34 + var_58_28 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_34 + var_58_28
					end
				end

				arg_55_1.text_.text = var_58_32
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091012", "story_v_out_926091.awb") ~= 0 then
					local var_58_35 = manager.audio:GetVoiceLength("story_v_out_926091", "926091012", "story_v_out_926091.awb") / 1000

					if var_58_35 + var_58_28 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_35 + var_58_28
					end

					if var_58_31.prefab_name ~= "" and arg_55_1.actors_[var_58_31.prefab_name] ~= nil then
						local var_58_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_31.prefab_name].transform, "story_v_out_926091", "926091012", "story_v_out_926091.awb")

						arg_55_1:RecordAudio("926091012", var_58_36)
						arg_55_1:RecordAudio("926091012", var_58_36)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_926091", "926091012", "story_v_out_926091.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_926091", "926091012", "story_v_out_926091.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_37 = var_58_28 + 0.3
			local var_58_38 = math.max(var_58_29, arg_55_1.talkMaxDuration)

			if var_58_28 + 0.3 <= arg_55_1.time_ and arg_55_1.time_ < var_58_37 + var_58_38 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_37) / var_58_38

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_37 + var_58_38 and arg_55_1.time_ < var_58_37 + var_58_38 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.3,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "10144",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play926091013 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 926091013
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play926091014(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10144"]) and arg_61_1.var_.actorSpriteComps10144 == nil then
				arg_61_1.var_.actorSpriteComps10144 = arg_61_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_64_0 = 0.2

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10144"]) then
				if arg_61_1.var_.actorSpriteComps10144 then
					for iter_64_0, iter_64_1 in pairs(arg_61_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_64_1 then
							if arg_61_1.isInRecall_ then
								iter_64_1.color = Color.New(Mathf.Lerp(iter_64_1.color.r, arg_61_1.hightColor2.r, (arg_61_1.time_ - 0) / var_64_0), Mathf.Lerp(iter_64_1.color.g, arg_61_1.hightColor2.g, (arg_61_1.time_ - 0) / var_64_0), (Mathf.Lerp(iter_64_1.color.b, arg_61_1.hightColor2.b, (arg_61_1.time_ - 0) / var_64_0)))
							else
								local var_64_1 = Mathf.Lerp(iter_64_1.color.r, 0.5, (arg_61_1.time_ - 0) / var_64_0)

								iter_64_1.color = Color.New(var_64_1, var_64_1, var_64_1)
							end
						end
					end
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10144"]) and arg_61_1.var_.actorSpriteComps10144 then
				for iter_64_2, iter_64_3 in pairs(arg_61_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_64_3 then
						iter_64_3.color = arg_61_1.isInRecall_ and (arg_61_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_61_1.var_.actorSpriteComps10144 = nil
			end

			local var_64_2 = 0
			local var_64_3 = 0.7

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_2 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, true)
				arg_61_1.iconController_:SetSelectedState("hero")

				arg_61_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_61_1.callingController_:SetSelectedState("normal")

				arg_61_1.keyicon_.color = Color.New(1, 1, 1)
				arg_61_1.icon_.color = Color.New(1, 1, 1)

				local var_64_4 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(926091013).content)

				arg_61_1.text_.text = var_64_4

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_6 = 28 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 28)

				if (28 <= 0 and var_64_3 or var_64_3 * (utf8.len(var_64_4) / 28)) > 0 and var_64_3 < var_64_6 then
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
	Play926091014 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 926091014
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play926091015(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			local var_68_0 = 0.45

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_1 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(926091014).content)

				arg_65_1.text_.text = var_68_1

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_3 = 18 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 18)

				if (18 <= 0 and var_68_0 or var_68_0 * (utf8.len(var_68_1) / 18)) > 0 and var_68_0 < var_68_3 then
					arg_65_1.talkMaxDuration = var_68_3

					if var_68_3 + 0 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_3 + 0
					end
				end

				arg_65_1.text_.text = var_68_1
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_4 = math.max(var_68_0, arg_65_1.talkMaxDuration)

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_4 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - 0) / var_68_4

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= 0 + var_68_4 and arg_65_1.time_ < 0 + var_68_4 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play926091015 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 926091015
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play926091016(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			local var_72_0 = 0.675

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_1 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(926091015).content)

				arg_69_1.text_.text = var_72_1

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_3 = 27 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 27)

				if (27 <= 0 and var_72_0 or var_72_0 * (utf8.len(var_72_1) / 27)) > 0 and var_72_0 < var_72_3 then
					arg_69_1.talkMaxDuration = var_72_3

					if var_72_3 + 0 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_3 + 0
					end
				end

				arg_69_1.text_.text = var_72_1
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_4 = math.max(var_72_0, arg_69_1.talkMaxDuration)

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_4 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - 0) / var_72_4

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= 0 + var_72_4 and arg_69_1.time_ < 0 + var_72_4 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play926091016 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 926091016
		arg_73_1.duration_ = 6.77

		local var_73_0 = {
			zh = 6.766,
			ja = 6.133
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
				arg_73_0:Play926091017(arg_73_1)
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
								iter_76_1.color = Color.New(Mathf.Lerp(iter_76_1.color.r, arg_73_1.hightColor1.r, (arg_73_1.time_ - 0) / var_76_0), Mathf.Lerp(iter_76_1.color.g, arg_73_1.hightColor1.g, (arg_73_1.time_ - 0) / var_76_0), (Mathf.Lerp(iter_76_1.color.b, arg_73_1.hightColor1.b, (arg_73_1.time_ - 0) / var_76_0)))
							else
								local var_76_1 = Mathf.Lerp(iter_76_1.color.r, 1, (arg_73_1.time_ - 0) / var_76_0)

								iter_76_1.color = Color.New(var_76_1, var_76_1, var_76_1)
							end
						end
					end
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10144"]) and arg_73_1.var_.actorSpriteComps10144 then
				for iter_76_2, iter_76_3 in pairs(arg_73_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_76_3 then
						iter_76_3.color = arg_73_1.isInRecall_ and (arg_73_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_73_1.var_.actorSpriteComps10144 = nil
			end

			local var_76_2 = arg_73_1.actors_["10144"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos10144 = var_76_2.localPosition
				var_76_2.localScale = Vector3.New(1, 1, 1)

				arg_73_1:CheckSpriteTmpPos("10144", 3)

				for iter_76_4 = 0, var_76_2.childCount - 1 do
					local var_76_3 = var_76_2:GetChild(iter_76_4)

					if var_76_3.name == "split_1" or not string.find(var_76_3.name, "split") then
						var_76_3.gameObject:SetActive(true)
					else
						var_76_3.gameObject:SetActive(false)
					end
				end
			end

			local var_76_4 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				var_76_2.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_73_1.time_ - 0) / var_76_4)
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				var_76_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_76_5 = 0
			local var_76_6 = 0.625

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_5 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_7 = arg_73_1:GetWordFromCfg(926091016)
				local var_76_8 = arg_73_1:FormatText(var_76_7.content)

				arg_73_1.text_.text = var_76_8

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_10 = 25 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 25)

				if (25 <= 0 and var_76_6 or var_76_6 * (utf8.len(var_76_8) / 25)) > 0 and var_76_6 < var_76_10 then
					arg_73_1.talkMaxDuration = var_76_10

					if var_76_10 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_10 + var_76_5
					end
				end

				arg_73_1.text_.text = var_76_8
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091016", "story_v_out_926091.awb") ~= 0 then
					local var_76_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091016", "story_v_out_926091.awb") / 1000

					if var_76_11 + var_76_5 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_11 + var_76_5
					end

					if var_76_7.prefab_name ~= "" and arg_73_1.actors_[var_76_7.prefab_name] ~= nil then
						local var_76_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_7.prefab_name].transform, "story_v_out_926091", "926091016", "story_v_out_926091.awb")

						arg_73_1:RecordAudio("926091016", var_76_12)
						arg_73_1:RecordAudio("926091016", var_76_12)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_926091", "926091016", "story_v_out_926091.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_926091", "926091016", "story_v_out_926091.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_13 = math.max(var_76_6, arg_73_1.talkMaxDuration)

			if var_76_5 <= arg_73_1.time_ and arg_73_1.time_ < var_76_5 + var_76_13 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_5) / var_76_13

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_5 + var_76_13 and arg_73_1.time_ < var_76_5 + var_76_13 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
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

		arg_73_1:InitPlayNodeList()
	end,
	Play926091017 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 926091017
		arg_77_1.duration_ = 6

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play926091018(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_9000

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10144"]) and arg_77_1.var_.actorSpriteComps10144 == nil then
				arg_77_1.var_.actorSpriteComps10144 = arg_77_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_80_0 = 0.2

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10144"]) then
				if arg_77_1.var_.actorSpriteComps10144 then
					for iter_80_0, iter_80_1 in pairs(arg_77_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_80_1 then
							if arg_77_1.isInRecall_ then
								iter_80_1.color = Color.New(Mathf.Lerp(iter_80_1.color.r, arg_77_1.hightColor2.r, (arg_77_1.time_ - 0) / var_80_0), Mathf.Lerp(iter_80_1.color.g, arg_77_1.hightColor2.g, (arg_77_1.time_ - 0) / var_80_0), (Mathf.Lerp(iter_80_1.color.b, arg_77_1.hightColor2.b, (arg_77_1.time_ - 0) / var_80_0)))
							else
								local var_80_1 = Mathf.Lerp(iter_80_1.color.r, 0.5, (arg_77_1.time_ - 0) / var_80_0)

								iter_80_1.color = Color.New(var_80_1, var_80_1, var_80_1)
							end
						end
					end
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10144"]) and arg_77_1.var_.actorSpriteComps10144 then
				for iter_80_2, iter_80_3 in pairs(arg_77_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_80_3 then
						iter_80_3.color = arg_77_1.isInRecall_ and (arg_77_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_77_1.var_.actorSpriteComps10144 = nil
			end

			local var_80_2 = arg_77_1.actors_["10144"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos10144 = var_80_2.localPosition
				var_80_2.localScale = Vector3.New(1, 1, 1)

				arg_77_1:CheckSpriteTmpPos("10144", 7)

				for iter_80_4 = 0, var_80_2.childCount - 1 do
					local var_80_3 = var_80_2:GetChild(iter_80_4)

					if var_80_3.name == "" or not string.find(var_80_3.name, "split") then
						var_80_3.gameObject:SetActive(true)
					else
						var_80_3.gameObject:SetActive(false)
					end
				end
			end

			local var_80_4 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				var_80_2.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_77_1.time_ - 0) / var_80_4)
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				var_80_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_80_5 = manager.ui.mainCamera.transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.shakeOldPos = var_80_5.localPosition
			end

			local var_80_6 = 0.6

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_6 then
				local var_80_7, var_80_8 = math.modf((arg_77_1.time_ - 0) / 0.066)

				var_80_5.localPosition = Vector3.New(var_80_8 * 0.13, var_80_8 * 0.13, var_80_8 * 0.13) + arg_77_1.var_.shakeOldPos
			end

			if arg_77_1.time_ >= 0 + var_80_6 and arg_77_1.time_ < 0 + var_80_6 + arg_80_0 then
				var_80_5.localPosition = arg_77_1.var_.shakeOldPos
			end

			if 0.2 < arg_77_1.time_ and arg_77_1.time_ <= 0.2 + arg_80_0 then
				local var_80_9 = arg_77_1.var_.effect89698

				if not arg_77_1.var_.effect89698 then
					var_80_9 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_piaosan"), manager.ui.mainCamera.transform)
					var_80_9.name = "89698"
					arg_77_1.var_.effect89698 = var_80_9
				else
					var_80_9.transform:SetParent(var_80_9000)
				end

				var_80_9.transform.localPosition = Vector3.New(0, 0, 0)
				var_80_9.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_80_11 = 0

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_11 + arg_80_0 then
				arg_77_1.allBtn_.enabled = false
			end

			if arg_77_1.time_ >= var_80_11 + 1.43333333333333 and arg_77_1.time_ < var_80_11 + 1.43333333333333 + arg_80_0 then
				arg_77_1.allBtn_.enabled = true
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:AudioAction("play", "effect", "se_story_143", "se_story_143_break", "")
			end

			if arg_77_1.frameCnt_ <= 1 then
				arg_77_1.dialog_:SetActive(false)
			end

			local var_80_13 = 1
			local var_80_14 = 0.825

			if 1 < arg_77_1.time_ and arg_77_1.time_ <= var_80_13 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0

				arg_77_1.dialog_:SetActive(true)

				arg_77_1.dialogCg_.alpha = 0

				local var_80_15 = LeanTween.value(arg_77_1.dialog_, 0, 1, 0.3)

				var_80_15:setOnUpdate(LuaHelper.FloatAction(function(arg_81_0)
					arg_77_1.dialogCg_.alpha = arg_81_0
				end))
				var_80_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_77_1.dialog_)
					var_80_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_77_1.duration_ = arg_77_1.duration_ + 0.3

				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_16 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(926091017).content)

				arg_77_1.text_.text = var_80_16

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_18 = 33 <= 0 and var_80_14 or var_80_14 * (utf8.len(var_80_16) / 33)

				if (33 <= 0 and var_80_14 or var_80_14 * (utf8.len(var_80_16) / 33)) > 0 and var_80_14 < var_80_18 then
					arg_77_1.talkMaxDuration = var_80_18
					var_80_13 = var_80_13 + 0.3

					if var_80_18 + var_80_13 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_18 + var_80_13
					end
				end

				arg_77_1.text_.text = var_80_16
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_19 = var_80_13 + 0.3
			local var_80_20 = math.max(var_80_14, arg_77_1.talkMaxDuration)

			if var_80_13 + 0.3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_19 + var_80_20 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_19) / var_80_20

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_19 + var_80_20 and arg_77_1.time_ < var_80_19 + var_80_20 + arg_80_0 then
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
	Play926091018 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 926091018
		arg_83_1.duration_ = 3.67

		local var_83_0 = {
			zh = 3.666,
			ja = 3
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
				arg_83_0:Play926091019(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if arg_83_1.actors_["106103"] == nil then
				local var_86_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "106103")

				if not isNil(var_86_0) then
					local var_86_1 = Object.Instantiate(var_86_0, arg_83_1.canvasGo_.transform)

					var_86_1.transform:SetSiblingIndex(1)

					var_86_1.name = "106103"
					var_86_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_83_1.actors_["106103"] = var_86_1

					if arg_83_1.isInRecall_ then
						for iter_86_0, iter_86_1 in ipairs((var_86_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_86_1.color = arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_86_2 = arg_83_1.actors_["106103"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps106103 == nil then
				arg_83_1.var_.actorSpriteComps106103 = var_86_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_86_3 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.actorSpriteComps106103 then
					for iter_86_2, iter_86_3 in pairs(arg_83_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_86_3 then
							if arg_83_1.isInRecall_ then
								iter_86_3.color = Color.New(Mathf.Lerp(iter_86_3.color.r, arg_83_1.hightColor1.r, (arg_83_1.time_ - 0) / var_86_3), Mathf.Lerp(iter_86_3.color.g, arg_83_1.hightColor1.g, (arg_83_1.time_ - 0) / var_86_3), (Mathf.Lerp(iter_86_3.color.b, arg_83_1.hightColor1.b, (arg_83_1.time_ - 0) / var_86_3)))
							else
								local var_86_4 = Mathf.Lerp(iter_86_3.color.r, 1, (arg_83_1.time_ - 0) / var_86_3)

								iter_86_3.color = Color.New(var_86_4, var_86_4, var_86_4)
							end
						end
					end
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.actorSpriteComps106103 then
				for iter_86_4, iter_86_5 in pairs(arg_83_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_86_5 then
						iter_86_5.color = arg_83_1.isInRecall_ and (arg_83_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_83_1.var_.actorSpriteComps106103 = nil
			end

			local var_86_5 = arg_83_1.actors_["106103"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos106103 = var_86_5.localPosition
				var_86_5.localScale = Vector3.New(1, 1, 1)

				arg_83_1:CheckSpriteTmpPos("106103", 3)

				for iter_86_6 = 0, var_86_5.childCount - 1 do
					local var_86_6 = var_86_5:GetChild(iter_86_6)

					if var_86_6.name == "" or not string.find(var_86_6.name, "split") then
						var_86_6.gameObject:SetActive(true)
					else
						var_86_6.gameObject:SetActive(false)
					end
				end
			end

			local var_86_7 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos106103, Vector3.New(-36.6, -398.2, -333.7), (arg_83_1.time_ - 0) / var_86_7)
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(-36.6, -398.2, -333.7)
			end

			local var_86_8 = 0
			local var_86_9 = 0.4

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_8 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_10 = arg_83_1:GetWordFromCfg(926091018)
				local var_86_11 = arg_83_1:FormatText(var_86_10.content)

				arg_83_1.text_.text = var_86_11

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_13 = 16 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 16)

				if (16 <= 0 and var_86_9 or var_86_9 * (utf8.len(var_86_11) / 16)) > 0 and var_86_9 < var_86_13 then
					arg_83_1.talkMaxDuration = var_86_13

					if var_86_13 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_13 + var_86_8
					end
				end

				arg_83_1.text_.text = var_86_11
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091018", "story_v_out_926091.awb") ~= 0 then
					local var_86_14 = manager.audio:GetVoiceLength("story_v_out_926091", "926091018", "story_v_out_926091.awb") / 1000

					if var_86_14 + var_86_8 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_14 + var_86_8
					end

					if var_86_10.prefab_name ~= "" and arg_83_1.actors_[var_86_10.prefab_name] ~= nil then
						local var_86_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_10.prefab_name].transform, "story_v_out_926091", "926091018", "story_v_out_926091.awb")

						arg_83_1:RecordAudio("926091018", var_86_15)
						arg_83_1:RecordAudio("926091018", var_86_15)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_926091", "926091018", "story_v_out_926091.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_926091", "926091018", "story_v_out_926091.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_16 = math.max(var_86_9, arg_83_1.talkMaxDuration)

			if var_86_8 <= arg_83_1.time_ and arg_83_1.time_ < var_86_8 + var_86_16 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_8) / var_86_16

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_8 + var_86_16 and arg_83_1.time_ < var_86_8 + var_86_16 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
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

		arg_83_1:InitPlayNodeList()
	end,
	Play926091019 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 926091019
		arg_87_1.duration_ = 1.77

		local var_87_0 = {
			zh = 1.133,
			ja = 1.766
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play926091020(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if arg_87_1.actors_["128404"] == nil then
				local var_90_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "128404")

				if not isNil(var_90_0) then
					local var_90_1 = Object.Instantiate(var_90_0, arg_87_1.canvasGo_.transform)

					var_90_1.transform:SetSiblingIndex(1)

					var_90_1.name = "128404"
					var_90_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_87_1.actors_["128404"] = var_90_1

					if arg_87_1.isInRecall_ then
						for iter_90_0, iter_90_1 in ipairs((var_90_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_90_1.color = arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_90_2 = arg_87_1.actors_["128404"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps128404 == nil then
				arg_87_1.var_.actorSpriteComps128404 = var_90_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_3 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.actorSpriteComps128404 then
					for iter_90_2, iter_90_3 in pairs(arg_87_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_90_3 then
							if arg_87_1.isInRecall_ then
								iter_90_3.color = Color.New(Mathf.Lerp(iter_90_3.color.r, arg_87_1.hightColor1.r, (arg_87_1.time_ - 0) / var_90_3), Mathf.Lerp(iter_90_3.color.g, arg_87_1.hightColor1.g, (arg_87_1.time_ - 0) / var_90_3), (Mathf.Lerp(iter_90_3.color.b, arg_87_1.hightColor1.b, (arg_87_1.time_ - 0) / var_90_3)))
							else
								local var_90_4 = Mathf.Lerp(iter_90_3.color.r, 1, (arg_87_1.time_ - 0) / var_90_3)

								iter_90_3.color = Color.New(var_90_4, var_90_4, var_90_4)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.actorSpriteComps128404 then
				for iter_90_4, iter_90_5 in pairs(arg_87_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_90_5 then
						iter_90_5.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_87_1.var_.actorSpriteComps128404 = nil
			end

			local var_90_5 = arg_87_1.actors_["106103"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps106103 == nil then
				arg_87_1.var_.actorSpriteComps106103 = var_90_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_90_6 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_6 and not isNil(var_90_5) then
				if arg_87_1.var_.actorSpriteComps106103 then
					for iter_90_6, iter_90_7 in pairs(arg_87_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_90_7 then
							if arg_87_1.isInRecall_ then
								iter_90_7.color = Color.New(Mathf.Lerp(iter_90_7.color.r, arg_87_1.hightColor2.r, (arg_87_1.time_ - 0) / var_90_6), Mathf.Lerp(iter_90_7.color.g, arg_87_1.hightColor2.g, (arg_87_1.time_ - 0) / var_90_6), (Mathf.Lerp(iter_90_7.color.b, arg_87_1.hightColor2.b, (arg_87_1.time_ - 0) / var_90_6)))
							else
								local var_90_7 = Mathf.Lerp(iter_90_7.color.r, 0.5, (arg_87_1.time_ - 0) / var_90_6)

								iter_90_7.color = Color.New(var_90_7, var_90_7, var_90_7)
							end
						end
					end
				end
			end

			if arg_87_1.time_ >= 0 + var_90_6 and arg_87_1.time_ < 0 + var_90_6 + arg_90_0 and not isNil(var_90_5) and arg_87_1.var_.actorSpriteComps106103 then
				for iter_90_8, iter_90_9 in pairs(arg_87_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_90_9 then
						iter_90_9.color = arg_87_1.isInRecall_ and (arg_87_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_87_1.var_.actorSpriteComps106103 = nil
			end

			local var_90_8 = arg_87_1.actors_["106103"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos106103 = var_90_8.localPosition
				var_90_8.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("106103", 7)

				for iter_90_10 = 0, var_90_8.childCount - 1 do
					local var_90_9 = var_90_8:GetChild(iter_90_10)

					if var_90_9.name == "" or not string.find(var_90_9.name, "split") then
						var_90_9.gameObject:SetActive(true)
					else
						var_90_9.gameObject:SetActive(false)
					end
				end
			end

			local var_90_10 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_10 then
				var_90_8.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_87_1.time_ - 0) / var_90_10)
			end

			if arg_87_1.time_ >= 0 + var_90_10 and arg_87_1.time_ < 0 + var_90_10 + arg_90_0 then
				var_90_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_90_11 = arg_87_1.actors_["128404"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos128404 = var_90_11.localPosition
				var_90_11.localScale = Vector3.New(1, 1, 1)

				arg_87_1:CheckSpriteTmpPos("128404", 3)

				for iter_90_11 = 0, var_90_11.childCount - 1 do
					local var_90_12 = var_90_11:GetChild(iter_90_11)

					if var_90_12.name == "split_5" or not string.find(var_90_12.name, "split") then
						var_90_12.gameObject:SetActive(true)
					else
						var_90_12.gameObject:SetActive(false)
					end
				end
			end

			local var_90_13 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_13 then
				var_90_11.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_87_1.time_ - 0) / var_90_13)
			end

			if arg_87_1.time_ >= 0 + var_90_13 and arg_87_1.time_ < 0 + var_90_13 + arg_90_0 then
				var_90_11.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_90_14 = 0
			local var_90_15 = 0.125

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_14 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_16 = arg_87_1:GetWordFromCfg(926091019)
				local var_90_17 = arg_87_1:FormatText(var_90_16.content)

				arg_87_1.text_.text = var_90_17

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_19 = 5 <= 0 and var_90_15 or var_90_15 * (utf8.len(var_90_17) / 5)

				if (5 <= 0 and var_90_15 or var_90_15 * (utf8.len(var_90_17) / 5)) > 0 and var_90_15 < var_90_19 then
					arg_87_1.talkMaxDuration = var_90_19

					if var_90_19 + var_90_14 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_19 + var_90_14
					end
				end

				arg_87_1.text_.text = var_90_17
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091019", "story_v_out_926091.awb") ~= 0 then
					local var_90_20 = manager.audio:GetVoiceLength("story_v_out_926091", "926091019", "story_v_out_926091.awb") / 1000

					if var_90_20 + var_90_14 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_20 + var_90_14
					end

					if var_90_16.prefab_name ~= "" and arg_87_1.actors_[var_90_16.prefab_name] ~= nil then
						local var_90_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_16.prefab_name].transform, "story_v_out_926091", "926091019", "story_v_out_926091.awb")

						arg_87_1:RecordAudio("926091019", var_90_21)
						arg_87_1:RecordAudio("926091019", var_90_21)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_926091", "926091019", "story_v_out_926091.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_926091", "926091019", "story_v_out_926091.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_22 = math.max(var_90_15, arg_87_1.talkMaxDuration)

			if var_90_14 <= arg_87_1.time_ and arg_87_1.time_ < var_90_14 + var_90_22 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_14) / var_90_22

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_14 + var_90_22 and arg_87_1.time_ < var_90_14 + var_90_22 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
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
				actorName = "128404",
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
	Play926091020 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 926091020
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play926091021(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["128404"]) and arg_91_1.var_.actorSpriteComps128404 == nil then
				arg_91_1.var_.actorSpriteComps128404 = arg_91_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["128404"]) then
				if arg_91_1.var_.actorSpriteComps128404 then
					for iter_94_0, iter_94_1 in pairs(arg_91_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_94_1 then
							if arg_91_1.isInRecall_ then
								iter_94_1.color = Color.New(Mathf.Lerp(iter_94_1.color.r, arg_91_1.hightColor2.r, (arg_91_1.time_ - 0) / var_94_0), Mathf.Lerp(iter_94_1.color.g, arg_91_1.hightColor2.g, (arg_91_1.time_ - 0) / var_94_0), (Mathf.Lerp(iter_94_1.color.b, arg_91_1.hightColor2.b, (arg_91_1.time_ - 0) / var_94_0)))
							else
								local var_94_1 = Mathf.Lerp(iter_94_1.color.r, 0.5, (arg_91_1.time_ - 0) / var_94_0)

								iter_94_1.color = Color.New(var_94_1, var_94_1, var_94_1)
							end
						end
					end
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["128404"]) and arg_91_1.var_.actorSpriteComps128404 then
				for iter_94_2, iter_94_3 in pairs(arg_91_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_94_3 then
						iter_94_3.color = arg_91_1.isInRecall_ and (arg_91_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_91_1.var_.actorSpriteComps128404 = nil
			end

			local var_94_2 = arg_91_1.actors_["128404"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos128404 = var_94_2.localPosition
				var_94_2.localScale = Vector3.New(1, 1, 1)

				arg_91_1:CheckSpriteTmpPos("128404", 7)

				for iter_94_4 = 0, var_94_2.childCount - 1 do
					local var_94_3 = var_94_2:GetChild(iter_94_4)

					if var_94_3.name == "" or not string.find(var_94_3.name, "split") then
						var_94_3.gameObject:SetActive(true)
					else
						var_94_3.gameObject:SetActive(false)
					end
				end
			end

			local var_94_4 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_4 then
				var_94_2.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_91_1.time_ - 0) / var_94_4)
			end

			if arg_91_1.time_ >= 0 + var_94_4 and arg_91_1.time_ < 0 + var_94_4 + arg_94_0 then
				var_94_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				if arg_91_1.var_.effect89698 then
					Object.Destroy(arg_91_1.var_.effect89698)

					arg_91_1.var_.effect89698 = nil
				end
			end

			local var_94_6

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				local var_94_7 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_94_7 then
					var_94_7.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_94_7.radialBlurScale = 0.069
					var_94_7.radialBlurGradient = 1
					var_94_7.radialBlurIntensity = 1

					if var_94_6 then
						var_94_7.radialBlurTarget = var_94_6.transform
					end
				end
			end

			local var_94_8 = 1.36666666666667

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_8 then
				local var_94_9 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_94_9 then
					var_94_9.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_94_9.radialBlurScale = Mathf.Lerp(0.069, 0.735, (arg_91_1.time_ - 0) / var_94_8)
					var_94_9.radialBlurGradient = Mathf.Lerp(1, 1, (arg_91_1.time_ - 0) / var_94_8)
					var_94_9.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_91_1.time_ - 0) / var_94_8)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_8 and arg_91_1.time_ < 0 + var_94_8 + arg_94_0 then
				local var_94_10 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_94_10 then
					var_94_10.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_94_10.radialBlurScale = 0.735
					var_94_10.radialBlurGradient = 1
					var_94_10.radialBlurIntensity = 1
				end
			end

			local var_94_11

			if 1.36666666666667 < arg_91_1.time_ and arg_91_1.time_ <= 1.36666666666667 + arg_94_0 then
				local var_94_12 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_94_12 then
					var_94_12.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_94_12.radialBlurScale = 0
					var_94_12.radialBlurGradient = 1
					var_94_12.radialBlurIntensity = 1

					if var_94_11 then
						var_94_12.radialBlurTarget = var_94_11.transform
					end
				end
			end

			local var_94_13 = 0.8

			if 1.36666666666667 <= arg_91_1.time_ and arg_91_1.time_ < 1.36666666666667 + var_94_13 then
				local var_94_14 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_94_14 then
					var_94_14.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_94_14.radialBlurScale = Mathf.Lerp(0, 0, (arg_91_1.time_ - 1.36666666666667) / var_94_13)
					var_94_14.radialBlurGradient = Mathf.Lerp(1, 1, (arg_91_1.time_ - 1.36666666666667) / var_94_13)
					var_94_14.radialBlurIntensity = Mathf.Lerp(1, 1, (arg_91_1.time_ - 1.36666666666667) / var_94_13)
				end
			end

			if arg_91_1.time_ >= 1.36666666666667 + var_94_13 and arg_91_1.time_ < 1.36666666666667 + var_94_13 + arg_94_0 then
				local var_94_15 = manager.ui.mainCamera:GetComponent("CameraExtension")

				if var_94_15 then
					var_94_15.dofType = UnityEngine.Pipelines.SimPipeline.DepthOfFieldType.BlurByBackground
					var_94_15.radialBlurScale = 0
					var_94_15.radialBlurGradient = 1
					var_94_15.radialBlurIntensity = 1
				end
			end

			local var_94_16 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_16 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			if arg_91_1.time_ >= var_94_16 + 1.36666666666667 and arg_91_1.time_ < var_94_16 + 1.36666666666667 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_17 = 0
			local var_94_18 = 0.925

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_17 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_19 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(926091020).content)

				arg_91_1.text_.text = var_94_19

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_21 = 37 <= 0 and var_94_18 or var_94_18 * (utf8.len(var_94_19) / 37)

				if (37 <= 0 and var_94_18 or var_94_18 * (utf8.len(var_94_19) / 37)) > 0 and var_94_18 < var_94_21 then
					arg_91_1.talkMaxDuration = var_94_21

					if var_94_21 + var_94_17 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_21 + var_94_17
					end
				end

				arg_91_1.text_.text = var_94_19
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_22 = math.max(var_94_18, arg_91_1.talkMaxDuration)

			if var_94_17 <= arg_91_1.time_ and arg_91_1.time_ < var_94_17 + var_94_22 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_17) / var_94_22

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_17 + var_94_22 and arg_91_1.time_ < var_94_17 + var_94_22 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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

		arg_91_1:InitPlayNodeList()
	end,
	Play926091021 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 926091021
		arg_95_1.duration_ = 5

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play926091022(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.175

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, true)
				arg_95_1.iconController_:SetSelectedState("hero")

				arg_95_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_95_1.callingController_:SetSelectedState("normal")

				arg_95_1.keyicon_.color = Color.New(1, 1, 1)
				arg_95_1.icon_.color = Color.New(1, 1, 1)

				local var_98_1 = arg_95_1:FormatText(arg_95_1:GetWordFromCfg(926091021).content)

				arg_95_1.text_.text = var_98_1

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_3 = 7 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 7)

				if (7 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_1) / 7)) > 0 and var_98_0 < var_98_3 then
					arg_95_1.talkMaxDuration = var_98_3

					if var_98_3 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_3 + 0
					end
				end

				arg_95_1.text_.text = var_98_1
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)
				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_4 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_4 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_4

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_4 and arg_95_1.time_ < 0 + var_98_4 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play926091022 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 926091022
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play926091023(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			local var_102_0 = 0.6

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, true)
				arg_99_1.iconController_:SetSelectedState("hero")

				arg_99_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_99_1.callingController_:SetSelectedState("normal")

				arg_99_1.keyicon_.color = Color.New(1, 1, 1)
				arg_99_1.icon_.color = Color.New(1, 1, 1)

				local var_102_1 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(926091022).content)

				arg_99_1.text_.text = var_102_1

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_3 = 24 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 24)

				if (24 <= 0 and var_102_0 or var_102_0 * (utf8.len(var_102_1) / 24)) > 0 and var_102_0 < var_102_3 then
					arg_99_1.talkMaxDuration = var_102_3

					if var_102_3 + 0 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_3 + 0
					end
				end

				arg_99_1.text_.text = var_102_1
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_4 = math.max(var_102_0, arg_99_1.talkMaxDuration)

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_4 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - 0) / var_102_4

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= 0 + var_102_4 and arg_99_1.time_ < 0 + var_102_4 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {}

		arg_99_1:InitPlayNodeList()
	end,
	Play926091023 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 926091023
		arg_103_1.duration_ = 4.13

		local var_103_0 = {
			zh = 3,
			ja = 4.133
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
				arg_103_0:Play926091024(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10144"]) and arg_103_1.var_.actorSpriteComps10144 == nil then
				arg_103_1.var_.actorSpriteComps10144 = arg_103_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10144"]) then
				if arg_103_1.var_.actorSpriteComps10144 then
					for iter_106_0, iter_106_1 in pairs(arg_103_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_106_1 then
							if arg_103_1.isInRecall_ then
								iter_106_1.color = Color.New(Mathf.Lerp(iter_106_1.color.r, arg_103_1.hightColor1.r, (arg_103_1.time_ - 0) / var_106_0), Mathf.Lerp(iter_106_1.color.g, arg_103_1.hightColor1.g, (arg_103_1.time_ - 0) / var_106_0), (Mathf.Lerp(iter_106_1.color.b, arg_103_1.hightColor1.b, (arg_103_1.time_ - 0) / var_106_0)))
							else
								local var_106_1 = Mathf.Lerp(iter_106_1.color.r, 1, (arg_103_1.time_ - 0) / var_106_0)

								iter_106_1.color = Color.New(var_106_1, var_106_1, var_106_1)
							end
						end
					end
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10144"]) and arg_103_1.var_.actorSpriteComps10144 then
				for iter_106_2, iter_106_3 in pairs(arg_103_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_106_3 then
						iter_106_3.color = arg_103_1.isInRecall_ and (arg_103_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_103_1.var_.actorSpriteComps10144 = nil
			end

			local var_106_2 = arg_103_1.actors_["10144"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10144 = var_106_2.localPosition
				var_106_2.localScale = Vector3.New(1, 1, 1)

				arg_103_1:CheckSpriteTmpPos("10144", 3)

				for iter_106_4 = 0, var_106_2.childCount - 1 do
					local var_106_3 = var_106_2:GetChild(iter_106_4)

					if var_106_3.name == "" or not string.find(var_106_3.name, "split") then
						var_106_3.gameObject:SetActive(true)
					else
						var_106_3.gameObject:SetActive(false)
					end
				end
			end

			local var_106_4 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_4 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_103_1.time_ - 0) / var_106_4)
			end

			if arg_103_1.time_ >= 0 + var_106_4 and arg_103_1.time_ < 0 + var_106_4 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_106_5 = 0
			local var_106_6 = 0.375

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_5 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_7 = arg_103_1:GetWordFromCfg(926091023)
				local var_106_8 = arg_103_1:FormatText(var_106_7.content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 15 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 15)

				if (15 <= 0 and var_106_6 or var_106_6 * (utf8.len(var_106_8) / 15)) > 0 and var_106_6 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_5
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091023", "story_v_out_926091.awb") ~= 0 then
					local var_106_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091023", "story_v_out_926091.awb") / 1000

					if var_106_11 + var_106_5 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_11 + var_106_5
					end

					if var_106_7.prefab_name ~= "" and arg_103_1.actors_[var_106_7.prefab_name] ~= nil then
						local var_106_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_7.prefab_name].transform, "story_v_out_926091", "926091023", "story_v_out_926091.awb")

						arg_103_1:RecordAudio("926091023", var_106_12)
						arg_103_1:RecordAudio("926091023", var_106_12)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_926091", "926091023", "story_v_out_926091.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_926091", "926091023", "story_v_out_926091.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_13 = math.max(var_106_6, arg_103_1.talkMaxDuration)

			if var_106_5 <= arg_103_1.time_ and arg_103_1.time_ < var_106_5 + var_106_13 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_5) / var_106_13

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_5 + var_106_13 and arg_103_1.time_ < var_106_5 + var_106_13 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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

		arg_103_1:InitPlayNodeList()
	end,
	Play926091024 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 926091024
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play926091025(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10144"]) and arg_107_1.var_.actorSpriteComps10144 == nil then
				arg_107_1.var_.actorSpriteComps10144 = arg_107_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10144"]) then
				if arg_107_1.var_.actorSpriteComps10144 then
					for iter_110_0, iter_110_1 in pairs(arg_107_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10144"]) and arg_107_1.var_.actorSpriteComps10144 then
				for iter_110_2, iter_110_3 in pairs(arg_107_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_110_3 then
						iter_110_3.color = arg_107_1.isInRecall_ and (arg_107_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_107_1.var_.actorSpriteComps10144 = nil
			end

			local var_110_2 = 0
			local var_110_3 = 0.35

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_2 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, true)
				arg_107_1.iconController_:SetSelectedState("hero")

				arg_107_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_107_1.callingController_:SetSelectedState("normal")

				arg_107_1.keyicon_.color = Color.New(1, 1, 1)
				arg_107_1.icon_.color = Color.New(1, 1, 1)

				local var_110_4 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(926091024).content)

				arg_107_1.text_.text = var_110_4

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_6 = 14 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 14)

				if (14 <= 0 and var_110_3 or var_110_3 * (utf8.len(var_110_4) / 14)) > 0 and var_110_3 < var_110_6 then
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
	Play926091025 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 926091025
		arg_111_1.duration_ = 7.23

		local var_111_0 = {
			zh = 6.166,
			ja = 7.233
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
				arg_111_0:Play926091026(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10144"]) and arg_111_1.var_.actorSpriteComps10144 == nil then
				arg_111_1.var_.actorSpriteComps10144 = arg_111_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10144"]) then
				if arg_111_1.var_.actorSpriteComps10144 then
					for iter_114_0, iter_114_1 in pairs(arg_111_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_114_1 then
							if arg_111_1.isInRecall_ then
								iter_114_1.color = Color.New(Mathf.Lerp(iter_114_1.color.r, arg_111_1.hightColor1.r, (arg_111_1.time_ - 0) / var_114_0), Mathf.Lerp(iter_114_1.color.g, arg_111_1.hightColor1.g, (arg_111_1.time_ - 0) / var_114_0), (Mathf.Lerp(iter_114_1.color.b, arg_111_1.hightColor1.b, (arg_111_1.time_ - 0) / var_114_0)))
							else
								local var_114_1 = Mathf.Lerp(iter_114_1.color.r, 1, (arg_111_1.time_ - 0) / var_114_0)

								iter_114_1.color = Color.New(var_114_1, var_114_1, var_114_1)
							end
						end
					end
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10144"]) and arg_111_1.var_.actorSpriteComps10144 then
				for iter_114_2, iter_114_3 in pairs(arg_111_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_114_3 then
						iter_114_3.color = arg_111_1.isInRecall_ and (arg_111_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_111_1.var_.actorSpriteComps10144 = nil
			end

			local var_114_2 = 0
			local var_114_3 = 0.775

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_2 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_4 = arg_111_1:GetWordFromCfg(926091025)
				local var_114_5 = arg_111_1:FormatText(var_114_4.content)

				arg_111_1.text_.text = var_114_5

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_7 = 31 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 31)

				if (31 <= 0 and var_114_3 or var_114_3 * (utf8.len(var_114_5) / 31)) > 0 and var_114_3 < var_114_7 then
					arg_111_1.talkMaxDuration = var_114_7

					if var_114_7 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_7 + var_114_2
					end
				end

				arg_111_1.text_.text = var_114_5
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091025", "story_v_out_926091.awb") ~= 0 then
					local var_114_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091025", "story_v_out_926091.awb") / 1000

					if var_114_8 + var_114_2 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_8 + var_114_2
					end

					if var_114_4.prefab_name ~= "" and arg_111_1.actors_[var_114_4.prefab_name] ~= nil then
						local var_114_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_4.prefab_name].transform, "story_v_out_926091", "926091025", "story_v_out_926091.awb")

						arg_111_1:RecordAudio("926091025", var_114_9)
						arg_111_1:RecordAudio("926091025", var_114_9)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_926091", "926091025", "story_v_out_926091.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_926091", "926091025", "story_v_out_926091.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_10 = math.max(var_114_3, arg_111_1.talkMaxDuration)

			if var_114_2 <= arg_111_1.time_ and arg_111_1.time_ < var_114_2 + var_114_10 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_2) / var_114_10

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_2 + var_114_10 and arg_111_1.time_ < var_114_2 + var_114_10 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play926091026 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 926091026
		arg_115_1.duration_ = 9

		local var_115_0 = {
			zh = 8.033,
			ja = 9
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
				arg_115_0:Play926091027(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = 0.975

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_1 = arg_115_1:GetWordFromCfg(926091026)
				local var_118_2 = arg_115_1:FormatText(var_118_1.content)

				arg_115_1.text_.text = var_118_2

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_4 = 39 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 39)

				if (39 <= 0 and var_118_0 or var_118_0 * (utf8.len(var_118_2) / 39)) > 0 and var_118_0 < var_118_4 then
					arg_115_1.talkMaxDuration = var_118_4

					if var_118_4 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_4 + 0
					end
				end

				arg_115_1.text_.text = var_118_2
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091026", "story_v_out_926091.awb") ~= 0 then
					local var_118_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091026", "story_v_out_926091.awb") / 1000

					if var_118_5 + 0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + 0
					end

					if var_118_1.prefab_name ~= "" and arg_115_1.actors_[var_118_1.prefab_name] ~= nil then
						local var_118_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_1.prefab_name].transform, "story_v_out_926091", "926091026", "story_v_out_926091.awb")

						arg_115_1:RecordAudio("926091026", var_118_6)
						arg_115_1:RecordAudio("926091026", var_118_6)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_926091", "926091026", "story_v_out_926091.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_926091", "926091026", "story_v_out_926091.awb")
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
	Play926091027 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 926091027
		arg_119_1.duration_ = 8.07

		local var_119_0 = {
			zh = 5.633,
			ja = 8.066
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
				arg_119_0:Play926091028(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10144 = arg_119_1.actors_["10144"].transform.localPosition
				arg_119_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_119_1:CheckSpriteTmpPos("10144", 3)

				for iter_122_0 = 0, arg_119_1.actors_["10144"].transform.childCount - 1 do
					local var_122_0 = arg_119_1.actors_["10144"].transform:GetChild(iter_122_0)

					if var_122_0.name == "split_7" or not string.find(var_122_0.name, "split") then
						var_122_0.gameObject:SetActive(true)
					else
						var_122_0.gameObject:SetActive(false)
					end
				end
			end

			local var_122_1 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_1 then
				arg_119_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_119_1.time_ - 0) / var_122_1)
			end

			if arg_119_1.time_ >= 0 + var_122_1 and arg_119_1.time_ < 0 + var_122_1 + arg_122_0 then
				arg_119_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_122_2 = 0
			local var_122_3 = 0.7

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_2 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_4 = arg_119_1:GetWordFromCfg(926091027)
				local var_122_5 = arg_119_1:FormatText(var_122_4.content)

				arg_119_1.text_.text = var_122_5

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_7 = 28 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 28)

				if (28 <= 0 and var_122_3 or var_122_3 * (utf8.len(var_122_5) / 28)) > 0 and var_122_3 < var_122_7 then
					arg_119_1.talkMaxDuration = var_122_7

					if var_122_7 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_7 + var_122_2
					end
				end

				arg_119_1.text_.text = var_122_5
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091027", "story_v_out_926091.awb") ~= 0 then
					local var_122_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091027", "story_v_out_926091.awb") / 1000

					if var_122_8 + var_122_2 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_8 + var_122_2
					end

					if var_122_4.prefab_name ~= "" and arg_119_1.actors_[var_122_4.prefab_name] ~= nil then
						local var_122_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_4.prefab_name].transform, "story_v_out_926091", "926091027", "story_v_out_926091.awb")

						arg_119_1:RecordAudio("926091027", var_122_9)
						arg_119_1:RecordAudio("926091027", var_122_9)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_926091", "926091027", "story_v_out_926091.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_926091", "926091027", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091028 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 926091028
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play926091029(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(arg_123_1.actors_["10144"]) and arg_123_1.var_.actorSpriteComps10144 == nil then
				arg_123_1.var_.actorSpriteComps10144 = arg_123_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_126_0 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 and not isNil(arg_123_1.actors_["10144"]) then
				if arg_123_1.var_.actorSpriteComps10144 then
					for iter_126_0, iter_126_1 in pairs(arg_123_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_126_1 then
							if arg_123_1.isInRecall_ then
								iter_126_1.color = Color.New(Mathf.Lerp(iter_126_1.color.r, arg_123_1.hightColor2.r, (arg_123_1.time_ - 0) / var_126_0), Mathf.Lerp(iter_126_1.color.g, arg_123_1.hightColor2.g, (arg_123_1.time_ - 0) / var_126_0), (Mathf.Lerp(iter_126_1.color.b, arg_123_1.hightColor2.b, (arg_123_1.time_ - 0) / var_126_0)))
							else
								local var_126_1 = Mathf.Lerp(iter_126_1.color.r, 0.5, (arg_123_1.time_ - 0) / var_126_0)

								iter_126_1.color = Color.New(var_126_1, var_126_1, var_126_1)
							end
						end
					end
				end
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 and not isNil(arg_123_1.actors_["10144"]) and arg_123_1.var_.actorSpriteComps10144 then
				for iter_126_2, iter_126_3 in pairs(arg_123_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_126_3 then
						iter_126_3.color = arg_123_1.isInRecall_ and (arg_123_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_123_1.var_.actorSpriteComps10144 = nil
			end

			local var_126_2 = 0
			local var_126_3 = 0.3

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_2 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, true)
				arg_123_1.iconController_:SetSelectedState("hero")

				arg_123_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_123_1.callingController_:SetSelectedState("normal")

				arg_123_1.keyicon_.color = Color.New(1, 1, 1)
				arg_123_1.icon_.color = Color.New(1, 1, 1)

				local var_126_4 = arg_123_1:FormatText(arg_123_1:GetWordFromCfg(926091028).content)

				arg_123_1.text_.text = var_126_4

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_6 = 12 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 12)

				if (12 <= 0 and var_126_3 or var_126_3 * (utf8.len(var_126_4) / 12)) > 0 and var_126_3 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_2 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_2
					end
				end

				arg_123_1.text_.text = var_126_4
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_3, arg_123_1.talkMaxDuration)

			if var_126_2 <= arg_123_1.time_ and arg_123_1.time_ < var_126_2 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_2) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_2 + var_126_7 and arg_123_1.time_ < var_126_2 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play926091029 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 926091029
		arg_127_1.duration_ = 2.3

		local var_127_0 = {
			zh = 1.833,
			ja = 2.3
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
				arg_127_0:Play926091030(arg_127_1)
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

			local var_130_2 = arg_127_1.actors_["10144"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos10144 = var_130_2.localPosition
				var_130_2.localScale = Vector3.New(1, 1, 1)

				arg_127_1:CheckSpriteTmpPos("10144", 3)

				for iter_130_4 = 0, var_130_2.childCount - 1 do
					local var_130_3 = var_130_2:GetChild(iter_130_4)

					if var_130_3.name == "split_1" or not string.find(var_130_3.name, "split") then
						var_130_3.gameObject:SetActive(true)
					else
						var_130_3.gameObject:SetActive(false)
					end
				end
			end

			local var_130_4 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 then
				var_130_2.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_127_1.time_ - 0) / var_130_4)
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 then
				var_130_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_130_5 = 0
			local var_130_6 = 0.175

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
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

				local var_130_7 = arg_127_1:GetWordFromCfg(926091029)
				local var_130_8 = arg_127_1:FormatText(var_130_7.content)

				arg_127_1.text_.text = var_130_8

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_10 = 7 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 7)

				if (7 <= 0 and var_130_6 or var_130_6 * (utf8.len(var_130_8) / 7)) > 0 and var_130_6 < var_130_10 then
					arg_127_1.talkMaxDuration = var_130_10

					if var_130_10 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_5
					end
				end

				arg_127_1.text_.text = var_130_8
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091029", "story_v_out_926091.awb") ~= 0 then
					local var_130_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091029", "story_v_out_926091.awb") / 1000

					if var_130_11 + var_130_5 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_11 + var_130_5
					end

					if var_130_7.prefab_name ~= "" and arg_127_1.actors_[var_130_7.prefab_name] ~= nil then
						local var_130_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_7.prefab_name].transform, "story_v_out_926091", "926091029", "story_v_out_926091.awb")

						arg_127_1:RecordAudio("926091029", var_130_12)
						arg_127_1:RecordAudio("926091029", var_130_12)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_926091", "926091029", "story_v_out_926091.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_926091", "926091029", "story_v_out_926091.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_13 = math.max(var_130_6, arg_127_1.talkMaxDuration)

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_13 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_5) / var_130_13

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_5 + var_130_13 and arg_127_1.time_ < var_130_5 + var_130_13 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
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
	Play926091030 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 926091030
		arg_131_1.duration_ = 3.57

		local var_131_0 = {
			zh = 3.566,
			ja = 3.433
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
				arg_131_0:Play926091031(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10144 = arg_131_1.actors_["10144"].transform.localPosition
				arg_131_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_131_1:CheckSpriteTmpPos("10144", 3)

				for iter_134_0 = 0, arg_131_1.actors_["10144"].transform.childCount - 1 do
					local var_134_0 = arg_131_1.actors_["10144"].transform:GetChild(iter_134_0)

					if var_134_0.name == "" or not string.find(var_134_0.name, "split") then
						var_134_0.gameObject:SetActive(true)
					else
						var_134_0.gameObject:SetActive(false)
					end
				end
			end

			local var_134_1 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_1 then
				arg_131_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_131_1.time_ - 0) / var_134_1)
			end

			if arg_131_1.time_ >= 0 + var_134_1 and arg_131_1.time_ < 0 + var_134_1 + arg_134_0 then
				arg_131_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_134_2 = 0
			local var_134_3 = 0.5

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(926091030)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 20 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 20)

				if (20 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 20)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091030", "story_v_out_926091.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091030", "story_v_out_926091.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_926091", "926091030", "story_v_out_926091.awb")

						arg_131_1:RecordAudio("926091030", var_134_9)
						arg_131_1:RecordAudio("926091030", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_926091", "926091030", "story_v_out_926091.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_926091", "926091030", "story_v_out_926091.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_10 = math.max(var_134_3, arg_131_1.talkMaxDuration)

			if var_134_2 <= arg_131_1.time_ and arg_131_1.time_ < var_134_2 + var_134_10 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_2) / var_134_10

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_2 + var_134_10 and arg_131_1.time_ < var_134_2 + var_134_10 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
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

		arg_131_1:InitPlayNodeList()
	end,
	Play926091031 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 926091031
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play926091032(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(arg_135_1.actors_["10144"]) and arg_135_1.var_.actorSpriteComps10144 == nil then
				arg_135_1.var_.actorSpriteComps10144 = arg_135_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_138_0 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 and not isNil(arg_135_1.actors_["10144"]) then
				if arg_135_1.var_.actorSpriteComps10144 then
					for iter_138_0, iter_138_1 in pairs(arg_135_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 and not isNil(arg_135_1.actors_["10144"]) and arg_135_1.var_.actorSpriteComps10144 then
				for iter_138_2, iter_138_3 in pairs(arg_135_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_138_3 then
						iter_138_3.color = arg_135_1.isInRecall_ and (arg_135_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_135_1.var_.actorSpriteComps10144 = nil
			end

			local var_138_2 = 0
			local var_138_3 = 0.625

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_2 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, true)
				arg_135_1.iconController_:SetSelectedState("hero")

				arg_135_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_135_1.callingController_:SetSelectedState("normal")

				arg_135_1.keyicon_.color = Color.New(1, 1, 1)
				arg_135_1.icon_.color = Color.New(1, 1, 1)

				local var_138_4 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(926091031).content)

				arg_135_1.text_.text = var_138_4

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_6 = 25 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 25)

				if (25 <= 0 and var_138_3 or var_138_3 * (utf8.len(var_138_4) / 25)) > 0 and var_138_3 < var_138_6 then
					arg_135_1.talkMaxDuration = var_138_6

					if var_138_6 + var_138_2 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_6 + var_138_2
					end
				end

				arg_135_1.text_.text = var_138_4
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_3, arg_135_1.talkMaxDuration)

			if var_138_2 <= arg_135_1.time_ and arg_135_1.time_ < var_138_2 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_2) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_2 + var_138_7 and arg_135_1.time_ < var_138_2 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play926091032 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 926091032
		arg_139_1.duration_ = 3.7

		local var_139_0 = {
			zh = 2.866,
			ja = 3.7
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
				arg_139_0:Play926091033(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10144"]) and arg_139_1.var_.actorSpriteComps10144 == nil then
				arg_139_1.var_.actorSpriteComps10144 = arg_139_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_142_0 = 0.2

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10144"]) then
				if arg_139_1.var_.actorSpriteComps10144 then
					for iter_142_0, iter_142_1 in pairs(arg_139_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10144"]) and arg_139_1.var_.actorSpriteComps10144 then
				for iter_142_2, iter_142_3 in pairs(arg_139_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_142_3 then
						iter_142_3.color = arg_139_1.isInRecall_ and (arg_139_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_139_1.var_.actorSpriteComps10144 = nil
			end

			local var_142_2 = 0
			local var_142_3 = 0.35

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_2 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_4 = arg_139_1:GetWordFromCfg(926091032)
				local var_142_5 = arg_139_1:FormatText(var_142_4.content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 14 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 14)

				if (14 <= 0 and var_142_3 or var_142_3 * (utf8.len(var_142_5) / 14)) > 0 and var_142_3 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_2
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091032", "story_v_out_926091.awb") ~= 0 then
					local var_142_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091032", "story_v_out_926091.awb") / 1000

					if var_142_8 + var_142_2 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_2
					end

					if var_142_4.prefab_name ~= "" and arg_139_1.actors_[var_142_4.prefab_name] ~= nil then
						local var_142_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_4.prefab_name].transform, "story_v_out_926091", "926091032", "story_v_out_926091.awb")

						arg_139_1:RecordAudio("926091032", var_142_9)
						arg_139_1:RecordAudio("926091032", var_142_9)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_926091", "926091032", "story_v_out_926091.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_926091", "926091032", "story_v_out_926091.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_10 = math.max(var_142_3, arg_139_1.talkMaxDuration)

			if var_142_2 <= arg_139_1.time_ and arg_139_1.time_ < var_142_2 + var_142_10 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_2) / var_142_10

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_2 + var_142_10 and arg_139_1.time_ < var_142_2 + var_142_10 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play926091033 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 926091033
		arg_143_1.duration_ = 5.3

		local var_143_0 = {
			zh = 4.333,
			ja = 5.3
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
				arg_143_0:Play926091034(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10144 = arg_143_1.actors_["10144"].transform.localPosition
				arg_143_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_143_1:CheckSpriteTmpPos("10144", 3)

				for iter_146_0 = 0, arg_143_1.actors_["10144"].transform.childCount - 1 do
					local var_146_0 = arg_143_1.actors_["10144"].transform:GetChild(iter_146_0)

					if var_146_0.name == "" or not string.find(var_146_0.name, "split") then
						var_146_0.gameObject:SetActive(true)
					else
						var_146_0.gameObject:SetActive(false)
					end
				end
			end

			local var_146_1 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_1 then
				arg_143_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_143_1.time_ - 0) / var_146_1)
			end

			if arg_143_1.time_ >= 0 + var_146_1 and arg_143_1.time_ < 0 + var_146_1 + arg_146_0 then
				arg_143_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_146_2 = 0
			local var_146_3 = 0.55

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_2 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(926091033)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_7 = 22 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 22)

				if (22 <= 0 and var_146_3 or var_146_3 * (utf8.len(var_146_5) / 22)) > 0 and var_146_3 < var_146_7 then
					arg_143_1.talkMaxDuration = var_146_7

					if var_146_7 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_7 + var_146_2
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091033", "story_v_out_926091.awb") ~= 0 then
					local var_146_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091033", "story_v_out_926091.awb") / 1000

					if var_146_8 + var_146_2 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_2
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_926091", "926091033", "story_v_out_926091.awb")

						arg_143_1:RecordAudio("926091033", var_146_9)
						arg_143_1:RecordAudio("926091033", var_146_9)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_926091", "926091033", "story_v_out_926091.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_926091", "926091033", "story_v_out_926091.awb")
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

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play926091034 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 926091034
		arg_147_1.duration_ = 6.13

		local var_147_0 = {
			zh = 4.233,
			ja = 6.133
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
				arg_147_0:Play926091035(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10144 = arg_147_1.actors_["10144"].transform.localPosition
				arg_147_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_147_1:CheckSpriteTmpPos("10144", 3)

				for iter_150_0 = 0, arg_147_1.actors_["10144"].transform.childCount - 1 do
					local var_150_0 = arg_147_1.actors_["10144"].transform:GetChild(iter_150_0)

					if var_150_0.name == "" or not string.find(var_150_0.name, "split") then
						var_150_0.gameObject:SetActive(true)
					else
						var_150_0.gameObject:SetActive(false)
					end
				end
			end

			local var_150_1 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_1 then
				arg_147_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_147_1.time_ - 0) / var_150_1)
			end

			if arg_147_1.time_ >= 0 + var_150_1 and arg_147_1.time_ < 0 + var_150_1 + arg_150_0 then
				arg_147_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_150_2 = 0
			local var_150_3 = 0.575

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_2 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_4 = arg_147_1:GetWordFromCfg(926091034)
				local var_150_5 = arg_147_1:FormatText(var_150_4.content)

				arg_147_1.text_.text = var_150_5

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_7 = 23 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 23)

				if (23 <= 0 and var_150_3 or var_150_3 * (utf8.len(var_150_5) / 23)) > 0 and var_150_3 < var_150_7 then
					arg_147_1.talkMaxDuration = var_150_7

					if var_150_7 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_7 + var_150_2
					end
				end

				arg_147_1.text_.text = var_150_5
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091034", "story_v_out_926091.awb") ~= 0 then
					local var_150_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091034", "story_v_out_926091.awb") / 1000

					if var_150_8 + var_150_2 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_8 + var_150_2
					end

					if var_150_4.prefab_name ~= "" and arg_147_1.actors_[var_150_4.prefab_name] ~= nil then
						local var_150_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_4.prefab_name].transform, "story_v_out_926091", "926091034", "story_v_out_926091.awb")

						arg_147_1:RecordAudio("926091034", var_150_9)
						arg_147_1:RecordAudio("926091034", var_150_9)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_926091", "926091034", "story_v_out_926091.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_926091", "926091034", "story_v_out_926091.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_10 = math.max(var_150_3, arg_147_1.talkMaxDuration)

			if var_150_2 <= arg_147_1.time_ and arg_147_1.time_ < var_150_2 + var_150_10 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_2) / var_150_10

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_2 + var_150_10 and arg_147_1.time_ < var_150_2 + var_150_10 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play926091035 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 926091035
		arg_151_1.duration_ = 8.8

		local var_151_0 = {
			zh = 7.9,
			ja = 8.8
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
				arg_151_0:Play926091036(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = 0.975

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_1 = arg_151_1:GetWordFromCfg(926091035)
				local var_154_2 = arg_151_1:FormatText(var_154_1.content)

				arg_151_1.text_.text = var_154_2

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_4 = 39 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 39)

				if (39 <= 0 and var_154_0 or var_154_0 * (utf8.len(var_154_2) / 39)) > 0 and var_154_0 < var_154_4 then
					arg_151_1.talkMaxDuration = var_154_4

					if var_154_4 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_4 + 0
					end
				end

				arg_151_1.text_.text = var_154_2
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091035", "story_v_out_926091.awb") ~= 0 then
					local var_154_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091035", "story_v_out_926091.awb") / 1000

					if var_154_5 + 0 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + 0
					end

					if var_154_1.prefab_name ~= "" and arg_151_1.actors_[var_154_1.prefab_name] ~= nil then
						local var_154_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_1.prefab_name].transform, "story_v_out_926091", "926091035", "story_v_out_926091.awb")

						arg_151_1:RecordAudio("926091035", var_154_6)
						arg_151_1:RecordAudio("926091035", var_154_6)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_926091", "926091035", "story_v_out_926091.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_926091", "926091035", "story_v_out_926091.awb")
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
	Play926091036 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 926091036
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play926091037(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(arg_155_1.actors_["10144"]) and arg_155_1.var_.actorSpriteComps10144 == nil then
				arg_155_1.var_.actorSpriteComps10144 = arg_155_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_158_0 = 0.2

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 and not isNil(arg_155_1.actors_["10144"]) then
				if arg_155_1.var_.actorSpriteComps10144 then
					for iter_158_0, iter_158_1 in pairs(arg_155_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_158_1 then
							if arg_155_1.isInRecall_ then
								iter_158_1.color = Color.New(Mathf.Lerp(iter_158_1.color.r, arg_155_1.hightColor2.r, (arg_155_1.time_ - 0) / var_158_0), Mathf.Lerp(iter_158_1.color.g, arg_155_1.hightColor2.g, (arg_155_1.time_ - 0) / var_158_0), (Mathf.Lerp(iter_158_1.color.b, arg_155_1.hightColor2.b, (arg_155_1.time_ - 0) / var_158_0)))
							else
								local var_158_1 = Mathf.Lerp(iter_158_1.color.r, 0.5, (arg_155_1.time_ - 0) / var_158_0)

								iter_158_1.color = Color.New(var_158_1, var_158_1, var_158_1)
							end
						end
					end
				end
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 and not isNil(arg_155_1.actors_["10144"]) and arg_155_1.var_.actorSpriteComps10144 then
				for iter_158_2, iter_158_3 in pairs(arg_155_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_158_3 then
						iter_158_3.color = arg_155_1.isInRecall_ and (arg_155_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_155_1.var_.actorSpriteComps10144 = nil
			end

			local var_158_2 = 0
			local var_158_3 = 0.15

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_2 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, true)
				arg_155_1.iconController_:SetSelectedState("hero")

				arg_155_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_155_1.callingController_:SetSelectedState("normal")

				arg_155_1.keyicon_.color = Color.New(1, 1, 1)
				arg_155_1.icon_.color = Color.New(1, 1, 1)

				local var_158_4 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(926091036).content)

				arg_155_1.text_.text = var_158_4

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_6 = 6 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_4) / 6)

				if (6 <= 0 and var_158_3 or var_158_3 * (utf8.len(var_158_4) / 6)) > 0 and var_158_3 < var_158_6 then
					arg_155_1.talkMaxDuration = var_158_6

					if var_158_6 + var_158_2 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_6 + var_158_2
					end
				end

				arg_155_1.text_.text = var_158_4
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_7 = math.max(var_158_3, arg_155_1.talkMaxDuration)

			if var_158_2 <= arg_155_1.time_ and arg_155_1.time_ < var_158_2 + var_158_7 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_2) / var_158_7

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_2 + var_158_7 and arg_155_1.time_ < var_158_2 + var_158_7 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play926091037 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 926091037
		arg_159_1.duration_ = 5.63

		local var_159_0 = {
			zh = 5.633,
			ja = 5.533
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play926091038(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["10144"]) and arg_159_1.var_.actorSpriteComps10144 == nil then
				arg_159_1.var_.actorSpriteComps10144 = arg_159_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_162_0 = 0.2

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["10144"]) then
				if arg_159_1.var_.actorSpriteComps10144 then
					for iter_162_0, iter_162_1 in pairs(arg_159_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_162_1 then
							if arg_159_1.isInRecall_ then
								iter_162_1.color = Color.New(Mathf.Lerp(iter_162_1.color.r, arg_159_1.hightColor1.r, (arg_159_1.time_ - 0) / var_162_0), Mathf.Lerp(iter_162_1.color.g, arg_159_1.hightColor1.g, (arg_159_1.time_ - 0) / var_162_0), (Mathf.Lerp(iter_162_1.color.b, arg_159_1.hightColor1.b, (arg_159_1.time_ - 0) / var_162_0)))
							else
								local var_162_1 = Mathf.Lerp(iter_162_1.color.r, 1, (arg_159_1.time_ - 0) / var_162_0)

								iter_162_1.color = Color.New(var_162_1, var_162_1, var_162_1)
							end
						end
					end
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["10144"]) and arg_159_1.var_.actorSpriteComps10144 then
				for iter_162_2, iter_162_3 in pairs(arg_159_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_162_3 then
						iter_162_3.color = arg_159_1.isInRecall_ and (arg_159_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_159_1.var_.actorSpriteComps10144 = nil
			end

			local var_162_2 = 0
			local var_162_3 = 0.75

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_2 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_4 = arg_159_1:GetWordFromCfg(926091037)
				local var_162_5 = arg_159_1:FormatText(var_162_4.content)

				arg_159_1.text_.text = var_162_5

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_7 = 30 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 30)

				if (30 <= 0 and var_162_3 or var_162_3 * (utf8.len(var_162_5) / 30)) > 0 and var_162_3 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_2
					end
				end

				arg_159_1.text_.text = var_162_5
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091037", "story_v_out_926091.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091037", "story_v_out_926091.awb") / 1000

					if var_162_8 + var_162_2 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_2
					end

					if var_162_4.prefab_name ~= "" and arg_159_1.actors_[var_162_4.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_4.prefab_name].transform, "story_v_out_926091", "926091037", "story_v_out_926091.awb")

						arg_159_1:RecordAudio("926091037", var_162_9)
						arg_159_1:RecordAudio("926091037", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_926091", "926091037", "story_v_out_926091.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_926091", "926091037", "story_v_out_926091.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_3, arg_159_1.talkMaxDuration)

			if var_162_2 <= arg_159_1.time_ and arg_159_1.time_ < var_162_2 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_2) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_2 + var_162_10 and arg_159_1.time_ < var_162_2 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play926091038 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 926091038
		arg_163_1.duration_ = 7.7

		local var_163_0 = {
			zh = 6.366,
			ja = 7.7
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
				arg_163_0:Play926091039(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos10144 = arg_163_1.actors_["10144"].transform.localPosition
				arg_163_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_163_1:CheckSpriteTmpPos("10144", 3)

				for iter_166_0 = 0, arg_163_1.actors_["10144"].transform.childCount - 1 do
					local var_166_0 = arg_163_1.actors_["10144"].transform:GetChild(iter_166_0)

					if var_166_0.name == "" or not string.find(var_166_0.name, "split") then
						var_166_0.gameObject:SetActive(true)
					else
						var_166_0.gameObject:SetActive(false)
					end
				end
			end

			local var_166_1 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_1 then
				arg_163_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_163_1.time_ - 0) / var_166_1)
			end

			if arg_163_1.time_ >= 0 + var_166_1 and arg_163_1.time_ < 0 + var_166_1 + arg_166_0 then
				arg_163_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_166_2 = 0
			local var_166_3 = 0.875

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_2 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_4 = arg_163_1:GetWordFromCfg(926091038)
				local var_166_5 = arg_163_1:FormatText(var_166_4.content)

				arg_163_1.text_.text = var_166_5

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_7 = 35 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 35)

				if (35 <= 0 and var_166_3 or var_166_3 * (utf8.len(var_166_5) / 35)) > 0 and var_166_3 < var_166_7 then
					arg_163_1.talkMaxDuration = var_166_7

					if var_166_7 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_7 + var_166_2
					end
				end

				arg_163_1.text_.text = var_166_5
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091038", "story_v_out_926091.awb") ~= 0 then
					local var_166_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091038", "story_v_out_926091.awb") / 1000

					if var_166_8 + var_166_2 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_2
					end

					if var_166_4.prefab_name ~= "" and arg_163_1.actors_[var_166_4.prefab_name] ~= nil then
						local var_166_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_4.prefab_name].transform, "story_v_out_926091", "926091038", "story_v_out_926091.awb")

						arg_163_1:RecordAudio("926091038", var_166_9)
						arg_163_1:RecordAudio("926091038", var_166_9)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_926091", "926091038", "story_v_out_926091.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_926091", "926091038", "story_v_out_926091.awb")
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

		arg_163_1.nodeConfigList_ = {
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

		arg_163_1:InitPlayNodeList()
	end,
	Play926091039 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 926091039
		arg_167_1.duration_ = 11.47

		local var_167_0 = {
			zh = 10.166,
			ja = 11.466
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
				arg_167_0:Play926091040(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.15

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:GetWordFromCfg(926091039)
				local var_170_2 = arg_167_1:FormatText(var_170_1.content)

				arg_167_1.text_.text = var_170_2

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_4 = 46 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 46)

				if (46 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_2) / 46)) > 0 and var_170_0 < var_170_4 then
					arg_167_1.talkMaxDuration = var_170_4

					if var_170_4 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_4 + 0
					end
				end

				arg_167_1.text_.text = var_170_2
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091039", "story_v_out_926091.awb") ~= 0 then
					local var_170_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091039", "story_v_out_926091.awb") / 1000

					if var_170_5 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_5 + 0
					end

					if var_170_1.prefab_name ~= "" and arg_167_1.actors_[var_170_1.prefab_name] ~= nil then
						local var_170_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_1.prefab_name].transform, "story_v_out_926091", "926091039", "story_v_out_926091.awb")

						arg_167_1:RecordAudio("926091039", var_170_6)
						arg_167_1:RecordAudio("926091039", var_170_6)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_926091", "926091039", "story_v_out_926091.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_926091", "926091039", "story_v_out_926091.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_7 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_7

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play926091040 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 926091040
		arg_171_1.duration_ = 5.8

		local var_171_0 = {
			zh = 4.366,
			ja = 5.8
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
				arg_171_0:Play926091041(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10144 = arg_171_1.actors_["10144"].transform.localPosition
				arg_171_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_171_1:CheckSpriteTmpPos("10144", 3)

				for iter_174_0 = 0, arg_171_1.actors_["10144"].transform.childCount - 1 do
					local var_174_0 = arg_171_1.actors_["10144"].transform:GetChild(iter_174_0)

					if var_174_0.name == "split_4" or not string.find(var_174_0.name, "split") then
						var_174_0.gameObject:SetActive(true)
					else
						var_174_0.gameObject:SetActive(false)
					end
				end
			end

			local var_174_1 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_1 then
				arg_171_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_171_1.time_ - 0) / var_174_1)
			end

			if arg_171_1.time_ >= 0 + var_174_1 and arg_171_1.time_ < 0 + var_174_1 + arg_174_0 then
				arg_171_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_174_2 = 0
			local var_174_3 = 0.45

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_2 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_4 = arg_171_1:GetWordFromCfg(926091040)
				local var_174_5 = arg_171_1:FormatText(var_174_4.content)

				arg_171_1.text_.text = var_174_5

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_7 = 18 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 18)

				if (18 <= 0 and var_174_3 or var_174_3 * (utf8.len(var_174_5) / 18)) > 0 and var_174_3 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_2
					end
				end

				arg_171_1.text_.text = var_174_5
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091040", "story_v_out_926091.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091040", "story_v_out_926091.awb") / 1000

					if var_174_8 + var_174_2 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_2
					end

					if var_174_4.prefab_name ~= "" and arg_171_1.actors_[var_174_4.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_4.prefab_name].transform, "story_v_out_926091", "926091040", "story_v_out_926091.awb")

						arg_171_1:RecordAudio("926091040", var_174_9)
						arg_171_1:RecordAudio("926091040", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_926091", "926091040", "story_v_out_926091.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_926091", "926091040", "story_v_out_926091.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_3, arg_171_1.talkMaxDuration)

			if var_174_2 <= arg_171_1.time_ and arg_171_1.time_ < var_174_2 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_2) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_2 + var_174_10 and arg_171_1.time_ < var_174_2 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play926091041 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 926091041
		arg_175_1.duration_ = 7.2

		local var_175_0 = {
			zh = 4.4,
			ja = 7.2
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
				arg_175_0:Play926091042(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.525

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:GetWordFromCfg(926091041)
				local var_178_2 = arg_175_1:FormatText(var_178_1.content)

				arg_175_1.text_.text = var_178_2

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_4 = 21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)

				if (21 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_2) / 21)) > 0 and var_178_0 < var_178_4 then
					arg_175_1.talkMaxDuration = var_178_4

					if var_178_4 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_4 + 0
					end
				end

				arg_175_1.text_.text = var_178_2
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091041", "story_v_out_926091.awb") ~= 0 then
					local var_178_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091041", "story_v_out_926091.awb") / 1000

					if var_178_5 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_5 + 0
					end

					if var_178_1.prefab_name ~= "" and arg_175_1.actors_[var_178_1.prefab_name] ~= nil then
						local var_178_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_1.prefab_name].transform, "story_v_out_926091", "926091041", "story_v_out_926091.awb")

						arg_175_1:RecordAudio("926091041", var_178_6)
						arg_175_1:RecordAudio("926091041", var_178_6)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_926091", "926091041", "story_v_out_926091.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_926091", "926091041", "story_v_out_926091.awb")
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
	Play926091042 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 926091042
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play926091043(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["10144"]) and arg_179_1.var_.actorSpriteComps10144 == nil then
				arg_179_1.var_.actorSpriteComps10144 = arg_179_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_182_0 = 0.2

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["10144"]) then
				if arg_179_1.var_.actorSpriteComps10144 then
					for iter_182_0, iter_182_1 in pairs(arg_179_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["10144"]) and arg_179_1.var_.actorSpriteComps10144 then
				for iter_182_2, iter_182_3 in pairs(arg_179_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_182_3 then
						iter_182_3.color = arg_179_1.isInRecall_ and (arg_179_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_179_1.var_.actorSpriteComps10144 = nil
			end

			local var_182_2 = 0
			local var_182_3 = 0.325

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_2 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, true)
				arg_179_1.iconController_:SetSelectedState("hero")

				arg_179_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_179_1.callingController_:SetSelectedState("normal")

				arg_179_1.keyicon_.color = Color.New(1, 1, 1)
				arg_179_1.icon_.color = Color.New(1, 1, 1)

				local var_182_4 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(926091042).content)

				arg_179_1.text_.text = var_182_4

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_6 = 13 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 13)

				if (13 <= 0 and var_182_3 or var_182_3 * (utf8.len(var_182_4) / 13)) > 0 and var_182_3 < var_182_6 then
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
	Play926091043 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 926091043
		arg_183_1.duration_ = 3.4

		local var_183_0 = {
			zh = 3.133,
			ja = 3.4
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
				arg_183_0:Play926091044(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10144"]) and arg_183_1.var_.actorSpriteComps10144 == nil then
				arg_183_1.var_.actorSpriteComps10144 = arg_183_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_186_0 = 0.2

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10144"]) then
				if arg_183_1.var_.actorSpriteComps10144 then
					for iter_186_0, iter_186_1 in pairs(arg_183_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_186_1 then
							if arg_183_1.isInRecall_ then
								iter_186_1.color = Color.New(Mathf.Lerp(iter_186_1.color.r, arg_183_1.hightColor1.r, (arg_183_1.time_ - 0) / var_186_0), Mathf.Lerp(iter_186_1.color.g, arg_183_1.hightColor1.g, (arg_183_1.time_ - 0) / var_186_0), (Mathf.Lerp(iter_186_1.color.b, arg_183_1.hightColor1.b, (arg_183_1.time_ - 0) / var_186_0)))
							else
								local var_186_1 = Mathf.Lerp(iter_186_1.color.r, 1, (arg_183_1.time_ - 0) / var_186_0)

								iter_186_1.color = Color.New(var_186_1, var_186_1, var_186_1)
							end
						end
					end
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10144"]) and arg_183_1.var_.actorSpriteComps10144 then
				for iter_186_2, iter_186_3 in pairs(arg_183_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_186_3 then
						iter_186_3.color = arg_183_1.isInRecall_ and (arg_183_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_183_1.var_.actorSpriteComps10144 = nil
			end

			local var_186_2 = arg_183_1.actors_["10144"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10144 = var_186_2.localPosition
				var_186_2.localScale = Vector3.New(1, 1, 1)

				arg_183_1:CheckSpriteTmpPos("10144", 3)

				for iter_186_4 = 0, var_186_2.childCount - 1 do
					local var_186_3 = var_186_2:GetChild(iter_186_4)

					if var_186_3.name == "split_6" or not string.find(var_186_3.name, "split") then
						var_186_3.gameObject:SetActive(true)
					else
						var_186_3.gameObject:SetActive(false)
					end
				end
			end

			local var_186_4 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_4 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_183_1.time_ - 0) / var_186_4)
			end

			if arg_183_1.time_ >= 0 + var_186_4 and arg_183_1.time_ < 0 + var_186_4 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_186_5 = 0
			local var_186_6 = 0.25

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_5 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_7 = arg_183_1:GetWordFromCfg(926091043)
				local var_186_8 = arg_183_1:FormatText(var_186_7.content)

				arg_183_1.text_.text = var_186_8

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_10 = 10 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 10)

				if (10 <= 0 and var_186_6 or var_186_6 * (utf8.len(var_186_8) / 10)) > 0 and var_186_6 < var_186_10 then
					arg_183_1.talkMaxDuration = var_186_10

					if var_186_10 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_5
					end
				end

				arg_183_1.text_.text = var_186_8
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091043", "story_v_out_926091.awb") ~= 0 then
					local var_186_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091043", "story_v_out_926091.awb") / 1000

					if var_186_11 + var_186_5 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_11 + var_186_5
					end

					if var_186_7.prefab_name ~= "" and arg_183_1.actors_[var_186_7.prefab_name] ~= nil then
						local var_186_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_7.prefab_name].transform, "story_v_out_926091", "926091043", "story_v_out_926091.awb")

						arg_183_1:RecordAudio("926091043", var_186_12)
						arg_183_1:RecordAudio("926091043", var_186_12)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_926091", "926091043", "story_v_out_926091.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_926091", "926091043", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091044 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 926091044
		arg_187_1.duration_ = 9.9

		local var_187_0 = {
			zh = 5.7,
			ja = 9.9
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
				arg_187_0:Play926091045(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.75

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:GetWordFromCfg(926091044)
				local var_190_2 = arg_187_1:FormatText(var_190_1.content)

				arg_187_1.text_.text = var_190_2

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_4 = 30 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 30)

				if (30 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_2) / 30)) > 0 and var_190_0 < var_190_4 then
					arg_187_1.talkMaxDuration = var_190_4

					if var_190_4 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_4 + 0
					end
				end

				arg_187_1.text_.text = var_190_2
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091044", "story_v_out_926091.awb") ~= 0 then
					local var_190_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091044", "story_v_out_926091.awb") / 1000

					if var_190_5 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_5 + 0
					end

					if var_190_1.prefab_name ~= "" and arg_187_1.actors_[var_190_1.prefab_name] ~= nil then
						local var_190_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_1.prefab_name].transform, "story_v_out_926091", "926091044", "story_v_out_926091.awb")

						arg_187_1:RecordAudio("926091044", var_190_6)
						arg_187_1:RecordAudio("926091044", var_190_6)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_926091", "926091044", "story_v_out_926091.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_926091", "926091044", "story_v_out_926091.awb")
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
	Play926091045 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 926091045
		arg_191_1.duration_ = 4.8

		local var_191_0 = {
			zh = 4.066,
			ja = 4.8
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
				arg_191_0:Play926091046(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if arg_191_1.actors_["104701"] == nil then
				local var_194_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "104701")

				if not isNil(var_194_0) then
					local var_194_1 = Object.Instantiate(var_194_0, arg_191_1.canvasGo_.transform)

					var_194_1.transform:SetSiblingIndex(1)

					var_194_1.name = "104701"
					var_194_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_191_1.actors_["104701"] = var_194_1

					if arg_191_1.isInRecall_ then
						for iter_194_0, iter_194_1 in ipairs((var_194_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_194_1.color = arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_194_2 = arg_191_1.actors_["104701"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps104701 == nil then
				arg_191_1.var_.actorSpriteComps104701 = var_194_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_3 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_3 and not isNil(var_194_2) then
				if arg_191_1.var_.actorSpriteComps104701 then
					for iter_194_2, iter_194_3 in pairs(arg_191_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_194_3 then
							if arg_191_1.isInRecall_ then
								iter_194_3.color = Color.New(Mathf.Lerp(iter_194_3.color.r, arg_191_1.hightColor1.r, (arg_191_1.time_ - 0) / var_194_3), Mathf.Lerp(iter_194_3.color.g, arg_191_1.hightColor1.g, (arg_191_1.time_ - 0) / var_194_3), (Mathf.Lerp(iter_194_3.color.b, arg_191_1.hightColor1.b, (arg_191_1.time_ - 0) / var_194_3)))
							else
								local var_194_4 = Mathf.Lerp(iter_194_3.color.r, 1, (arg_191_1.time_ - 0) / var_194_3)

								iter_194_3.color = Color.New(var_194_4, var_194_4, var_194_4)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_3 and arg_191_1.time_ < 0 + var_194_3 + arg_194_0 and not isNil(var_194_2) and arg_191_1.var_.actorSpriteComps104701 then
				for iter_194_4, iter_194_5 in pairs(arg_191_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_194_5 then
						iter_194_5.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_191_1.var_.actorSpriteComps104701 = nil
			end

			local var_194_5 = arg_191_1.actors_["10144"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.actorSpriteComps10144 == nil then
				arg_191_1.var_.actorSpriteComps10144 = var_194_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_194_6 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_6 and not isNil(var_194_5) then
				if arg_191_1.var_.actorSpriteComps10144 then
					for iter_194_6, iter_194_7 in pairs(arg_191_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_194_7 then
							if arg_191_1.isInRecall_ then
								iter_194_7.color = Color.New(Mathf.Lerp(iter_194_7.color.r, arg_191_1.hightColor2.r, (arg_191_1.time_ - 0) / var_194_6), Mathf.Lerp(iter_194_7.color.g, arg_191_1.hightColor2.g, (arg_191_1.time_ - 0) / var_194_6), (Mathf.Lerp(iter_194_7.color.b, arg_191_1.hightColor2.b, (arg_191_1.time_ - 0) / var_194_6)))
							else
								local var_194_7 = Mathf.Lerp(iter_194_7.color.r, 0.5, (arg_191_1.time_ - 0) / var_194_6)

								iter_194_7.color = Color.New(var_194_7, var_194_7, var_194_7)
							end
						end
					end
				end
			end

			if arg_191_1.time_ >= 0 + var_194_6 and arg_191_1.time_ < 0 + var_194_6 + arg_194_0 and not isNil(var_194_5) and arg_191_1.var_.actorSpriteComps10144 then
				for iter_194_8, iter_194_9 in pairs(arg_191_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_194_9 then
						iter_194_9.color = arg_191_1.isInRecall_ and (arg_191_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_191_1.var_.actorSpriteComps10144 = nil
			end

			local var_194_8 = arg_191_1.actors_["10144"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos10144 = var_194_8.localPosition
				var_194_8.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("10144", 7)

				for iter_194_10 = 0, var_194_8.childCount - 1 do
					local var_194_9 = var_194_8:GetChild(iter_194_10)

					if var_194_9.name == "" or not string.find(var_194_9.name, "split") then
						var_194_9.gameObject:SetActive(true)
					else
						var_194_9.gameObject:SetActive(false)
					end
				end
			end

			local var_194_10 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_10 then
				var_194_8.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_191_1.time_ - 0) / var_194_10)
			end

			if arg_191_1.time_ >= 0 + var_194_10 and arg_191_1.time_ < 0 + var_194_10 + arg_194_0 then
				var_194_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_194_11 = arg_191_1.actors_["104701"].transform

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos104701 = var_194_11.localPosition
				var_194_11.localScale = Vector3.New(1, 1, 1)

				arg_191_1:CheckSpriteTmpPos("104701", 3)

				for iter_194_11 = 0, var_194_11.childCount - 1 do
					local var_194_12 = var_194_11:GetChild(iter_194_11)

					if var_194_12.name == "" or not string.find(var_194_12.name, "split") then
						var_194_12.gameObject:SetActive(true)
					else
						var_194_12.gameObject:SetActive(false)
					end
				end
			end

			local var_194_13 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_13 then
				var_194_11.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_191_1.time_ - 0) / var_194_13)
			end

			if arg_191_1.time_ >= 0 + var_194_13 and arg_191_1.time_ < 0 + var_194_13 + arg_194_0 then
				var_194_11.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_194_14 = 0
			local var_194_15 = 0.5

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_16 = arg_191_1:GetWordFromCfg(926091045)
				local var_194_17 = arg_191_1:FormatText(var_194_16.content)

				arg_191_1.text_.text = var_194_17

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_19 = 20 <= 0 and var_194_15 or var_194_15 * (utf8.len(var_194_17) / 20)

				if (20 <= 0 and var_194_15 or var_194_15 * (utf8.len(var_194_17) / 20)) > 0 and var_194_15 < var_194_19 then
					arg_191_1.talkMaxDuration = var_194_19

					if var_194_19 + var_194_14 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_19 + var_194_14
					end
				end

				arg_191_1.text_.text = var_194_17
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091045", "story_v_out_926091.awb") ~= 0 then
					local var_194_20 = manager.audio:GetVoiceLength("story_v_out_926091", "926091045", "story_v_out_926091.awb") / 1000

					if var_194_20 + var_194_14 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_20 + var_194_14
					end

					if var_194_16.prefab_name ~= "" and arg_191_1.actors_[var_194_16.prefab_name] ~= nil then
						local var_194_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_16.prefab_name].transform, "story_v_out_926091", "926091045", "story_v_out_926091.awb")

						arg_191_1:RecordAudio("926091045", var_194_21)
						arg_191_1:RecordAudio("926091045", var_194_21)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_926091", "926091045", "story_v_out_926091.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_926091", "926091045", "story_v_out_926091.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_22 = math.max(var_194_15, arg_191_1.talkMaxDuration)

			if var_194_14 <= arg_191_1.time_ and arg_191_1.time_ < var_194_14 + var_194_22 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_14) / var_194_22

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_14 + var_194_22 and arg_191_1.time_ < var_194_14 + var_194_22 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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
				actorName = "104701",
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
	Play926091046 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 926091046
		arg_195_1.duration_ = 5.3

		local var_195_0 = {
			zh = 3.566,
			ja = 5.3
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
				arg_195_0:Play926091047(arg_195_1)
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

			local var_198_2 = arg_195_1.actors_["104701"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps104701 == nil then
				arg_195_1.var_.actorSpriteComps104701 = var_198_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_198_3 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.actorSpriteComps104701 then
					for iter_198_4, iter_198_5 in pairs(arg_195_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.actorSpriteComps104701 then
				for iter_198_6, iter_198_7 in pairs(arg_195_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_198_7 then
						iter_198_7.color = arg_195_1.isInRecall_ and (arg_195_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_195_1.var_.actorSpriteComps104701 = nil
			end

			local var_198_5 = arg_195_1.actors_["10144"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos10144 = var_198_5.localPosition
				var_198_5.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("10144", 3)

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
				var_198_5.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_195_1.time_ - 0) / var_198_7)
			end

			if arg_195_1.time_ >= 0 + var_198_7 and arg_195_1.time_ < 0 + var_198_7 + arg_198_0 then
				var_198_5.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_198_8 = arg_195_1.actors_["104701"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos104701 = var_198_8.localPosition
				var_198_8.localScale = Vector3.New(1, 1, 1)

				arg_195_1:CheckSpriteTmpPos("104701", 7)

				for iter_198_9 = 0, var_198_8.childCount - 1 do
					local var_198_9 = var_198_8:GetChild(iter_198_9)

					if var_198_9.name == "" or not string.find(var_198_9.name, "split") then
						var_198_9.gameObject:SetActive(true)
					else
						var_198_9.gameObject:SetActive(false)
					end
				end
			end

			local var_198_10 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_10 then
				var_198_8.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_195_1.time_ - 0) / var_198_10)
			end

			if arg_195_1.time_ >= 0 + var_198_10 and arg_195_1.time_ < 0 + var_198_10 + arg_198_0 then
				var_198_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_198_11 = 0
			local var_198_12 = 0.425

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

				local var_198_13 = arg_195_1:GetWordFromCfg(926091046)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_16 = 17 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 17)

				if (17 <= 0 and var_198_12 or var_198_12 * (utf8.len(var_198_14) / 17)) > 0 and var_198_12 < var_198_16 then
					arg_195_1.talkMaxDuration = var_198_16

					if var_198_16 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_16 + var_198_11
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091046", "story_v_out_926091.awb") ~= 0 then
					local var_198_17 = manager.audio:GetVoiceLength("story_v_out_926091", "926091046", "story_v_out_926091.awb") / 1000

					if var_198_17 + var_198_11 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_11
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_926091", "926091046", "story_v_out_926091.awb")

						arg_195_1:RecordAudio("926091046", var_198_18)
						arg_195_1:RecordAudio("926091046", var_198_18)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_926091", "926091046", "story_v_out_926091.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_926091", "926091046", "story_v_out_926091.awb")
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
				actorName = "104701",
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
	Play926091047 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 926091047
		arg_199_1.duration_ = 7.6

		local var_199_0 = {
			zh = 4.966,
			ja = 7.6
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
				arg_199_0:Play926091048(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 0.625

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_1 = arg_199_1:GetWordFromCfg(926091047)
				local var_202_2 = arg_199_1:FormatText(var_202_1.content)

				arg_199_1.text_.text = var_202_2

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_4 = 25 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 25)

				if (25 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_2) / 25)) > 0 and var_202_0 < var_202_4 then
					arg_199_1.talkMaxDuration = var_202_4

					if var_202_4 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_4 + 0
					end
				end

				arg_199_1.text_.text = var_202_2
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091047", "story_v_out_926091.awb") ~= 0 then
					local var_202_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091047", "story_v_out_926091.awb") / 1000

					if var_202_5 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + 0
					end

					if var_202_1.prefab_name ~= "" and arg_199_1.actors_[var_202_1.prefab_name] ~= nil then
						local var_202_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_1.prefab_name].transform, "story_v_out_926091", "926091047", "story_v_out_926091.awb")

						arg_199_1:RecordAudio("926091047", var_202_6)
						arg_199_1:RecordAudio("926091047", var_202_6)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_926091", "926091047", "story_v_out_926091.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_926091", "926091047", "story_v_out_926091.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_7 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_7 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_7

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_7 and arg_199_1.time_ < 0 + var_202_7 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play926091048 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 926091048
		arg_203_1.duration_ = 4.67

		local var_203_0 = {
			zh = 4.3,
			ja = 4.666
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
				arg_203_0:Play926091049(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.5

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_1 = arg_203_1:GetWordFromCfg(926091048)
				local var_206_2 = arg_203_1:FormatText(var_206_1.content)

				arg_203_1.text_.text = var_206_2

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_4 = 20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)

				if (20 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_2) / 20)) > 0 and var_206_0 < var_206_4 then
					arg_203_1.talkMaxDuration = var_206_4

					if var_206_4 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_4 + 0
					end
				end

				arg_203_1.text_.text = var_206_2
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091048", "story_v_out_926091.awb") ~= 0 then
					local var_206_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091048", "story_v_out_926091.awb") / 1000

					if var_206_5 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + 0
					end

					if var_206_1.prefab_name ~= "" and arg_203_1.actors_[var_206_1.prefab_name] ~= nil then
						local var_206_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_1.prefab_name].transform, "story_v_out_926091", "926091048", "story_v_out_926091.awb")

						arg_203_1:RecordAudio("926091048", var_206_6)
						arg_203_1:RecordAudio("926091048", var_206_6)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_926091", "926091048", "story_v_out_926091.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_926091", "926091048", "story_v_out_926091.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_7 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_7

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play926091049 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 926091049
		arg_207_1.duration_ = 11.27

		local var_207_0 = {
			zh = 6.5,
			ja = 11.266
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play926091050(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10144 = arg_207_1.actors_["10144"].transform.localPosition
				arg_207_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_207_1:CheckSpriteTmpPos("10144", 3)

				for iter_210_0 = 0, arg_207_1.actors_["10144"].transform.childCount - 1 do
					local var_210_0 = arg_207_1.actors_["10144"].transform:GetChild(iter_210_0)

					if var_210_0.name == "split_7" or not string.find(var_210_0.name, "split") then
						var_210_0.gameObject:SetActive(true)
					else
						var_210_0.gameObject:SetActive(false)
					end
				end
			end

			local var_210_1 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_1 then
				arg_207_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_207_1.time_ - 0) / var_210_1)
			end

			if arg_207_1.time_ >= 0 + var_210_1 and arg_207_1.time_ < 0 + var_210_1 + arg_210_0 then
				arg_207_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_210_2 = 0
			local var_210_3 = 0.875

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_2 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_4 = arg_207_1:GetWordFromCfg(926091049)
				local var_210_5 = arg_207_1:FormatText(var_210_4.content)

				arg_207_1.text_.text = var_210_5

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_7 = 35 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 35)

				if (35 <= 0 and var_210_3 or var_210_3 * (utf8.len(var_210_5) / 35)) > 0 and var_210_3 < var_210_7 then
					arg_207_1.talkMaxDuration = var_210_7

					if var_210_7 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_7 + var_210_2
					end
				end

				arg_207_1.text_.text = var_210_5
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091049", "story_v_out_926091.awb") ~= 0 then
					local var_210_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091049", "story_v_out_926091.awb") / 1000

					if var_210_8 + var_210_2 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_8 + var_210_2
					end

					if var_210_4.prefab_name ~= "" and arg_207_1.actors_[var_210_4.prefab_name] ~= nil then
						local var_210_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_4.prefab_name].transform, "story_v_out_926091", "926091049", "story_v_out_926091.awb")

						arg_207_1:RecordAudio("926091049", var_210_9)
						arg_207_1:RecordAudio("926091049", var_210_9)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_926091", "926091049", "story_v_out_926091.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_926091", "926091049", "story_v_out_926091.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_10 = math.max(var_210_3, arg_207_1.talkMaxDuration)

			if var_210_2 <= arg_207_1.time_ and arg_207_1.time_ < var_210_2 + var_210_10 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_2) / var_210_10

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_2 + var_210_10 and arg_207_1.time_ < var_210_2 + var_210_10 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play926091050 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 926091050
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play926091051(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["10144"]) and arg_211_1.var_.actorSpriteComps10144 == nil then
				arg_211_1.var_.actorSpriteComps10144 = arg_211_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_214_0 = 0.2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["10144"]) then
				if arg_211_1.var_.actorSpriteComps10144 then
					for iter_214_0, iter_214_1 in pairs(arg_211_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_214_1 then
							if arg_211_1.isInRecall_ then
								iter_214_1.color = Color.New(Mathf.Lerp(iter_214_1.color.r, arg_211_1.hightColor2.r, (arg_211_1.time_ - 0) / var_214_0), Mathf.Lerp(iter_214_1.color.g, arg_211_1.hightColor2.g, (arg_211_1.time_ - 0) / var_214_0), (Mathf.Lerp(iter_214_1.color.b, arg_211_1.hightColor2.b, (arg_211_1.time_ - 0) / var_214_0)))
							else
								local var_214_1 = Mathf.Lerp(iter_214_1.color.r, 0.5, (arg_211_1.time_ - 0) / var_214_0)

								iter_214_1.color = Color.New(var_214_1, var_214_1, var_214_1)
							end
						end
					end
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["10144"]) and arg_211_1.var_.actorSpriteComps10144 then
				for iter_214_2, iter_214_3 in pairs(arg_211_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_214_3 then
						iter_214_3.color = arg_211_1.isInRecall_ and (arg_211_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_211_1.var_.actorSpriteComps10144 = nil
			end

			local var_214_2 = arg_211_1.actors_["10144"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10144 = var_214_2.localPosition
				var_214_2.localScale = Vector3.New(1, 1, 1)

				arg_211_1:CheckSpriteTmpPos("10144", 7)

				for iter_214_4 = 0, var_214_2.childCount - 1 do
					local var_214_3 = var_214_2:GetChild(iter_214_4)

					if var_214_3.name == "" or not string.find(var_214_3.name, "split") then
						var_214_3.gameObject:SetActive(true)
					else
						var_214_3.gameObject:SetActive(false)
					end
				end
			end

			local var_214_4 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				var_214_2.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_211_1.time_ - 0) / var_214_4)
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_214_5 = 0
			local var_214_6 = 0.675

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_5 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_7 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(926091050).content)

				arg_211_1.text_.text = var_214_7

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_9 = 27 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_7) / 27)

				if (27 <= 0 and var_214_6 or var_214_6 * (utf8.len(var_214_7) / 27)) > 0 and var_214_6 < var_214_9 then
					arg_211_1.talkMaxDuration = var_214_9

					if var_214_9 + var_214_5 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_9 + var_214_5
					end
				end

				arg_211_1.text_.text = var_214_7
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_10 = math.max(var_214_6, arg_211_1.talkMaxDuration)

			if var_214_5 <= arg_211_1.time_ and arg_211_1.time_ < var_214_5 + var_214_10 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_5) / var_214_10

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_5 + var_214_10 and arg_211_1.time_ < var_214_5 + var_214_10 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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

		arg_211_1:InitPlayNodeList()
	end,
	Play926091051 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 926091051
		arg_215_1.duration_ = 6.1

		local var_215_0 = {
			zh = 5.933,
			ja = 6.1
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
				arg_215_0:Play926091052(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["104701"]) and arg_215_1.var_.actorSpriteComps104701 == nil then
				arg_215_1.var_.actorSpriteComps104701 = arg_215_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_218_0 = 0.2

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["104701"]) then
				if arg_215_1.var_.actorSpriteComps104701 then
					for iter_218_0, iter_218_1 in pairs(arg_215_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_218_1 then
							if arg_215_1.isInRecall_ then
								iter_218_1.color = Color.New(Mathf.Lerp(iter_218_1.color.r, arg_215_1.hightColor1.r, (arg_215_1.time_ - 0) / var_218_0), Mathf.Lerp(iter_218_1.color.g, arg_215_1.hightColor1.g, (arg_215_1.time_ - 0) / var_218_0), (Mathf.Lerp(iter_218_1.color.b, arg_215_1.hightColor1.b, (arg_215_1.time_ - 0) / var_218_0)))
							else
								local var_218_1 = Mathf.Lerp(iter_218_1.color.r, 1, (arg_215_1.time_ - 0) / var_218_0)

								iter_218_1.color = Color.New(var_218_1, var_218_1, var_218_1)
							end
						end
					end
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["104701"]) and arg_215_1.var_.actorSpriteComps104701 then
				for iter_218_2, iter_218_3 in pairs(arg_215_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_218_3 then
						iter_218_3.color = arg_215_1.isInRecall_ and (arg_215_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_215_1.var_.actorSpriteComps104701 = nil
			end

			local var_218_2 = arg_215_1.actors_["104701"].transform

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1.var_.moveOldPos104701 = var_218_2.localPosition
				var_218_2.localScale = Vector3.New(1, 1, 1)

				arg_215_1:CheckSpriteTmpPos("104701", 3)

				for iter_218_4 = 0, var_218_2.childCount - 1 do
					local var_218_3 = var_218_2:GetChild(iter_218_4)

					if var_218_3.name == "split_4" or not string.find(var_218_3.name, "split") then
						var_218_3.gameObject:SetActive(true)
					else
						var_218_3.gameObject:SetActive(false)
					end
				end
			end

			local var_218_4 = 0.001

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_4 then
				var_218_2.localPosition = Vector3.Lerp(arg_215_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_215_1.time_ - 0) / var_218_4)
			end

			if arg_215_1.time_ >= 0 + var_218_4 and arg_215_1.time_ < 0 + var_218_4 + arg_218_0 then
				var_218_2.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_218_5 = 0
			local var_218_6 = 0.6

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_5 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_7 = arg_215_1:GetWordFromCfg(926091051)
				local var_218_8 = arg_215_1:FormatText(var_218_7.content)

				arg_215_1.text_.text = var_218_8

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 24 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 24)

				if (24 <= 0 and var_218_6 or var_218_6 * (utf8.len(var_218_8) / 24)) > 0 and var_218_6 < var_218_10 then
					arg_215_1.talkMaxDuration = var_218_10

					if var_218_10 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_10 + var_218_5
					end
				end

				arg_215_1.text_.text = var_218_8
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091051", "story_v_out_926091.awb") ~= 0 then
					local var_218_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091051", "story_v_out_926091.awb") / 1000

					if var_218_11 + var_218_5 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_11 + var_218_5
					end

					if var_218_7.prefab_name ~= "" and arg_215_1.actors_[var_218_7.prefab_name] ~= nil then
						local var_218_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_7.prefab_name].transform, "story_v_out_926091", "926091051", "story_v_out_926091.awb")

						arg_215_1:RecordAudio("926091051", var_218_12)
						arg_215_1:RecordAudio("926091051", var_218_12)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_926091", "926091051", "story_v_out_926091.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_926091", "926091051", "story_v_out_926091.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_6, arg_215_1.talkMaxDuration)

			if var_218_5 <= arg_215_1.time_ and arg_215_1.time_ < var_218_5 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_5) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_5 + var_218_13 and arg_215_1.time_ < var_218_5 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {
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

		arg_215_1:InitPlayNodeList()
	end,
	Play926091052 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 926091052
		arg_219_1.duration_ = 8.27

		local var_219_0 = {
			zh = 5,
			ja = 8.266
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
				arg_219_0:Play926091053(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = 0.575

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_1 = arg_219_1:GetWordFromCfg(926091052)
				local var_222_2 = arg_219_1:FormatText(var_222_1.content)

				arg_219_1.text_.text = var_222_2

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_4 = 23 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 23)

				if (23 <= 0 and var_222_0 or var_222_0 * (utf8.len(var_222_2) / 23)) > 0 and var_222_0 < var_222_4 then
					arg_219_1.talkMaxDuration = var_222_4

					if var_222_4 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_4 + 0
					end
				end

				arg_219_1.text_.text = var_222_2
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091052", "story_v_out_926091.awb") ~= 0 then
					local var_222_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091052", "story_v_out_926091.awb") / 1000

					if var_222_5 + 0 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + 0
					end

					if var_222_1.prefab_name ~= "" and arg_219_1.actors_[var_222_1.prefab_name] ~= nil then
						local var_222_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_1.prefab_name].transform, "story_v_out_926091", "926091052", "story_v_out_926091.awb")

						arg_219_1:RecordAudio("926091052", var_222_6)
						arg_219_1:RecordAudio("926091052", var_222_6)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_926091", "926091052", "story_v_out_926091.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_926091", "926091052", "story_v_out_926091.awb")
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
	Play926091053 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 926091053
		arg_223_1.duration_ = 4.9

		local var_223_0 = {
			zh = 4.9,
			ja = 4.433
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
				arg_223_0:Play926091054(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["10144"]) and arg_223_1.var_.actorSpriteComps10144 == nil then
				arg_223_1.var_.actorSpriteComps10144 = arg_223_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_0 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["10144"]) then
				if arg_223_1.var_.actorSpriteComps10144 then
					for iter_226_0, iter_226_1 in pairs(arg_223_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_226_1 then
							if arg_223_1.isInRecall_ then
								iter_226_1.color = Color.New(Mathf.Lerp(iter_226_1.color.r, arg_223_1.hightColor1.r, (arg_223_1.time_ - 0) / var_226_0), Mathf.Lerp(iter_226_1.color.g, arg_223_1.hightColor1.g, (arg_223_1.time_ - 0) / var_226_0), (Mathf.Lerp(iter_226_1.color.b, arg_223_1.hightColor1.b, (arg_223_1.time_ - 0) / var_226_0)))
							else
								local var_226_1 = Mathf.Lerp(iter_226_1.color.r, 1, (arg_223_1.time_ - 0) / var_226_0)

								iter_226_1.color = Color.New(var_226_1, var_226_1, var_226_1)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["10144"]) and arg_223_1.var_.actorSpriteComps10144 then
				for iter_226_2, iter_226_3 in pairs(arg_223_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_226_3 then
						iter_226_3.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_223_1.var_.actorSpriteComps10144 = nil
			end

			local var_226_2 = arg_223_1.actors_["104701"]

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps104701 == nil then
				arg_223_1.var_.actorSpriteComps104701 = var_226_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_226_3 = 0.2

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_3 and not isNil(var_226_2) then
				if arg_223_1.var_.actorSpriteComps104701 then
					for iter_226_4, iter_226_5 in pairs(arg_223_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_226_5 then
							if arg_223_1.isInRecall_ then
								iter_226_5.color = Color.New(Mathf.Lerp(iter_226_5.color.r, arg_223_1.hightColor2.r, (arg_223_1.time_ - 0) / var_226_3), Mathf.Lerp(iter_226_5.color.g, arg_223_1.hightColor2.g, (arg_223_1.time_ - 0) / var_226_3), (Mathf.Lerp(iter_226_5.color.b, arg_223_1.hightColor2.b, (arg_223_1.time_ - 0) / var_226_3)))
							else
								local var_226_4 = Mathf.Lerp(iter_226_5.color.r, 0.5, (arg_223_1.time_ - 0) / var_226_3)

								iter_226_5.color = Color.New(var_226_4, var_226_4, var_226_4)
							end
						end
					end
				end
			end

			if arg_223_1.time_ >= 0 + var_226_3 and arg_223_1.time_ < 0 + var_226_3 + arg_226_0 and not isNil(var_226_2) and arg_223_1.var_.actorSpriteComps104701 then
				for iter_226_6, iter_226_7 in pairs(arg_223_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_226_7 then
						iter_226_7.color = arg_223_1.isInRecall_ and (arg_223_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_223_1.var_.actorSpriteComps104701 = nil
			end

			local var_226_5 = arg_223_1.actors_["104701"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos104701 = var_226_5.localPosition
				var_226_5.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("104701", 4)

				for iter_226_8 = 0, var_226_5.childCount - 1 do
					local var_226_6 = var_226_5:GetChild(iter_226_8)

					if var_226_6.name == "split_4" or not string.find(var_226_6.name, "split") then
						var_226_6.gameObject:SetActive(true)
					else
						var_226_6.gameObject:SetActive(false)
					end
				end
			end

			local var_226_7 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_7 then
				var_226_5.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_223_1.time_ - 0) / var_226_7)
			end

			if arg_223_1.time_ >= 0 + var_226_7 and arg_223_1.time_ < 0 + var_226_7 + arg_226_0 then
				var_226_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_226_8 = arg_223_1.actors_["10144"].transform

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.var_.moveOldPos10144 = var_226_8.localPosition
				var_226_8.localScale = Vector3.New(1, 1, 1)

				arg_223_1:CheckSpriteTmpPos("10144", 2)

				for iter_226_9 = 0, var_226_8.childCount - 1 do
					local var_226_9 = var_226_8:GetChild(iter_226_9)

					if var_226_9.name == "" or not string.find(var_226_9.name, "split") then
						var_226_9.gameObject:SetActive(true)
					else
						var_226_9.gameObject:SetActive(false)
					end
				end
			end

			local var_226_10 = 0.001

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_10 then
				var_226_8.localPosition = Vector3.Lerp(arg_223_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_223_1.time_ - 0) / var_226_10)
			end

			if arg_223_1.time_ >= 0 + var_226_10 and arg_223_1.time_ < 0 + var_226_10 + arg_226_0 then
				var_226_8.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_226_11 = 0
			local var_226_12 = 0.375

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_11 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				arg_223_1.leftNameTxt_.text = arg_223_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:GetWordFromCfg(926091053)
				local var_226_14 = arg_223_1:FormatText(var_226_13.content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_16 = 15 <= 0 and var_226_12 or var_226_12 * (utf8.len(var_226_14) / 15)

				if (15 <= 0 and var_226_12 or var_226_12 * (utf8.len(var_226_14) / 15)) > 0 and var_226_12 < var_226_16 then
					arg_223_1.talkMaxDuration = var_226_16

					if var_226_16 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_16 + var_226_11
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091053", "story_v_out_926091.awb") ~= 0 then
					local var_226_17 = manager.audio:GetVoiceLength("story_v_out_926091", "926091053", "story_v_out_926091.awb") / 1000

					if var_226_17 + var_226_11 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_17 + var_226_11
					end

					if var_226_13.prefab_name ~= "" and arg_223_1.actors_[var_226_13.prefab_name] ~= nil then
						local var_226_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_13.prefab_name].transform, "story_v_out_926091", "926091053", "story_v_out_926091.awb")

						arg_223_1:RecordAudio("926091053", var_226_18)
						arg_223_1:RecordAudio("926091053", var_226_18)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_926091", "926091053", "story_v_out_926091.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_926091", "926091053", "story_v_out_926091.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_19 = math.max(var_226_12, arg_223_1.talkMaxDuration)

			if var_226_11 <= arg_223_1.time_ and arg_223_1.time_ < var_226_11 + var_226_19 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_11) / var_226_19

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_11 + var_226_19 and arg_223_1.time_ < var_226_11 + var_226_19 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {
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
				actorName = "10144",
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
	Play926091054 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 926091054
		arg_227_1.duration_ = 13.43

		local var_227_0 = {
			zh = 7.966,
			ja = 13.433
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
				arg_227_0:Play926091055(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos10144 = arg_227_1.actors_["10144"].transform.localPosition
				arg_227_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_227_1:CheckSpriteTmpPos("10144", 2)

				for iter_230_0 = 0, arg_227_1.actors_["10144"].transform.childCount - 1 do
					local var_230_0 = arg_227_1.actors_["10144"].transform:GetChild(iter_230_0)

					if var_230_0.name == "split_2" or not string.find(var_230_0.name, "split") then
						var_230_0.gameObject:SetActive(true)
					else
						var_230_0.gameObject:SetActive(false)
					end
				end
			end

			local var_230_1 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_1 then
				arg_227_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_227_1.time_ - 0) / var_230_1)
			end

			if arg_227_1.time_ >= 0 + var_230_1 and arg_227_1.time_ < 0 + var_230_1 + arg_230_0 then
				arg_227_1.actors_["10144"].transform.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_230_2 = 0
			local var_230_3 = 1.025

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_2 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_4 = arg_227_1:GetWordFromCfg(926091054)
				local var_230_5 = arg_227_1:FormatText(var_230_4.content)

				arg_227_1.text_.text = var_230_5

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_7 = 41 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 41)

				if (41 <= 0 and var_230_3 or var_230_3 * (utf8.len(var_230_5) / 41)) > 0 and var_230_3 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_2
					end
				end

				arg_227_1.text_.text = var_230_5
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091054", "story_v_out_926091.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091054", "story_v_out_926091.awb") / 1000

					if var_230_8 + var_230_2 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_2
					end

					if var_230_4.prefab_name ~= "" and arg_227_1.actors_[var_230_4.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_4.prefab_name].transform, "story_v_out_926091", "926091054", "story_v_out_926091.awb")

						arg_227_1:RecordAudio("926091054", var_230_9)
						arg_227_1:RecordAudio("926091054", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_926091", "926091054", "story_v_out_926091.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_926091", "926091054", "story_v_out_926091.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_3, arg_227_1.talkMaxDuration)

			if var_230_2 <= arg_227_1.time_ and arg_227_1.time_ < var_230_2 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_2) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_2 + var_230_10 and arg_227_1.time_ < var_230_2 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
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

		arg_227_1:InitPlayNodeList()
	end,
	Play926091055 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 926091055
		arg_231_1.duration_ = 14.5

		local var_231_0 = {
			zh = 9.533,
			ja = 14.5
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
				arg_231_0:Play926091056(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["104701"]) and arg_231_1.var_.actorSpriteComps104701 == nil then
				arg_231_1.var_.actorSpriteComps104701 = arg_231_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_0 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["104701"]) then
				if arg_231_1.var_.actorSpriteComps104701 then
					for iter_234_0, iter_234_1 in pairs(arg_231_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["104701"]) and arg_231_1.var_.actorSpriteComps104701 then
				for iter_234_2, iter_234_3 in pairs(arg_231_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_234_3 then
						iter_234_3.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_231_1.var_.actorSpriteComps104701 = nil
			end

			local var_234_2 = arg_231_1.actors_["10144"]

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10144 == nil then
				arg_231_1.var_.actorSpriteComps10144 = var_234_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_234_3 = 0.2

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_3 and not isNil(var_234_2) then
				if arg_231_1.var_.actorSpriteComps10144 then
					for iter_234_4, iter_234_5 in pairs(arg_231_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_231_1.time_ >= 0 + var_234_3 and arg_231_1.time_ < 0 + var_234_3 + arg_234_0 and not isNil(var_234_2) and arg_231_1.var_.actorSpriteComps10144 then
				for iter_234_6, iter_234_7 in pairs(arg_231_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_234_7 then
						iter_234_7.color = arg_231_1.isInRecall_ and (arg_231_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_231_1.var_.actorSpriteComps10144 = nil
			end

			local var_234_5 = arg_231_1.actors_["104701"].transform

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1.var_.moveOldPos104701 = var_234_5.localPosition
				var_234_5.localScale = Vector3.New(1, 1, 1)

				arg_231_1:CheckSpriteTmpPos("104701", 4)

				for iter_234_8 = 0, var_234_5.childCount - 1 do
					local var_234_6 = var_234_5:GetChild(iter_234_8)

					if var_234_6.name == "split_1" or not string.find(var_234_6.name, "split") then
						var_234_6.gameObject:SetActive(true)
					else
						var_234_6.gameObject:SetActive(false)
					end
				end
			end

			local var_234_7 = 0.001

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_7 then
				var_234_5.localPosition = Vector3.Lerp(arg_231_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_231_1.time_ - 0) / var_234_7)
			end

			if arg_231_1.time_ >= 0 + var_234_7 and arg_231_1.time_ < 0 + var_234_7 + arg_234_0 then
				var_234_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_234_8 = 0
			local var_234_9 = 1.125

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_8 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_10 = arg_231_1:GetWordFromCfg(926091055)
				local var_234_11 = arg_231_1:FormatText(var_234_10.content)

				arg_231_1.text_.text = var_234_11

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_13 = 45 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 45)

				if (45 <= 0 and var_234_9 or var_234_9 * (utf8.len(var_234_11) / 45)) > 0 and var_234_9 < var_234_13 then
					arg_231_1.talkMaxDuration = var_234_13

					if var_234_13 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_13 + var_234_8
					end
				end

				arg_231_1.text_.text = var_234_11
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091055", "story_v_out_926091.awb") ~= 0 then
					local var_234_14 = manager.audio:GetVoiceLength("story_v_out_926091", "926091055", "story_v_out_926091.awb") / 1000

					if var_234_14 + var_234_8 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_14 + var_234_8
					end

					if var_234_10.prefab_name ~= "" and arg_231_1.actors_[var_234_10.prefab_name] ~= nil then
						local var_234_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_10.prefab_name].transform, "story_v_out_926091", "926091055", "story_v_out_926091.awb")

						arg_231_1:RecordAudio("926091055", var_234_15)
						arg_231_1:RecordAudio("926091055", var_234_15)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_926091", "926091055", "story_v_out_926091.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_926091", "926091055", "story_v_out_926091.awb")
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
				actorName = "104701",
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
	Play926091056 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 926091056
		arg_235_1.duration_ = 1.9

		local var_235_0 = {
			zh = 1.9,
			ja = 1.8
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
				arg_235_0:Play926091057(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["10144"]) and arg_235_1.var_.actorSpriteComps10144 == nil then
				arg_235_1.var_.actorSpriteComps10144 = arg_235_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_0 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["10144"]) then
				if arg_235_1.var_.actorSpriteComps10144 then
					for iter_238_0, iter_238_1 in pairs(arg_235_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_238_1 then
							if arg_235_1.isInRecall_ then
								iter_238_1.color = Color.New(Mathf.Lerp(iter_238_1.color.r, arg_235_1.hightColor1.r, (arg_235_1.time_ - 0) / var_238_0), Mathf.Lerp(iter_238_1.color.g, arg_235_1.hightColor1.g, (arg_235_1.time_ - 0) / var_238_0), (Mathf.Lerp(iter_238_1.color.b, arg_235_1.hightColor1.b, (arg_235_1.time_ - 0) / var_238_0)))
							else
								local var_238_1 = Mathf.Lerp(iter_238_1.color.r, 1, (arg_235_1.time_ - 0) / var_238_0)

								iter_238_1.color = Color.New(var_238_1, var_238_1, var_238_1)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["10144"]) and arg_235_1.var_.actorSpriteComps10144 then
				for iter_238_2, iter_238_3 in pairs(arg_235_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_238_3 then
						iter_238_3.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_235_1.var_.actorSpriteComps10144 = nil
			end

			local var_238_2 = arg_235_1.actors_["104701"]

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps104701 == nil then
				arg_235_1.var_.actorSpriteComps104701 = var_238_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_238_3 = 0.2

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_3 and not isNil(var_238_2) then
				if arg_235_1.var_.actorSpriteComps104701 then
					for iter_238_4, iter_238_5 in pairs(arg_235_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_238_5 then
							if arg_235_1.isInRecall_ then
								iter_238_5.color = Color.New(Mathf.Lerp(iter_238_5.color.r, arg_235_1.hightColor2.r, (arg_235_1.time_ - 0) / var_238_3), Mathf.Lerp(iter_238_5.color.g, arg_235_1.hightColor2.g, (arg_235_1.time_ - 0) / var_238_3), (Mathf.Lerp(iter_238_5.color.b, arg_235_1.hightColor2.b, (arg_235_1.time_ - 0) / var_238_3)))
							else
								local var_238_4 = Mathf.Lerp(iter_238_5.color.r, 0.5, (arg_235_1.time_ - 0) / var_238_3)

								iter_238_5.color = Color.New(var_238_4, var_238_4, var_238_4)
							end
						end
					end
				end
			end

			if arg_235_1.time_ >= 0 + var_238_3 and arg_235_1.time_ < 0 + var_238_3 + arg_238_0 and not isNil(var_238_2) and arg_235_1.var_.actorSpriteComps104701 then
				for iter_238_6, iter_238_7 in pairs(arg_235_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_238_7 then
						iter_238_7.color = arg_235_1.isInRecall_ and (arg_235_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_235_1.var_.actorSpriteComps104701 = nil
			end

			local var_238_5 = arg_235_1.actors_["10144"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10144 = var_238_5.localPosition
				var_238_5.localScale = Vector3.New(1, 1, 1)

				arg_235_1:CheckSpriteTmpPos("10144", 2)

				for iter_238_8 = 0, var_238_5.childCount - 1 do
					local var_238_6 = var_238_5:GetChild(iter_238_8)

					if var_238_6.name == "split_1" or not string.find(var_238_6.name, "split") then
						var_238_6.gameObject:SetActive(true)
					else
						var_238_6.gameObject:SetActive(false)
					end
				end
			end

			local var_238_7 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_7 then
				var_238_5.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10144, Vector3.New(-507.9, -381.1, -285.9), (arg_235_1.time_ - 0) / var_238_7)
			end

			if arg_235_1.time_ >= 0 + var_238_7 and arg_235_1.time_ < 0 + var_238_7 + arg_238_0 then
				var_238_5.localPosition = Vector3.New(-507.9, -381.1, -285.9)
			end

			local var_238_8 = 0
			local var_238_9 = 0.175

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_8 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_10 = arg_235_1:GetWordFromCfg(926091056)
				local var_238_11 = arg_235_1:FormatText(var_238_10.content)

				arg_235_1.text_.text = var_238_11

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_13 = 7 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 7)

				if (7 <= 0 and var_238_9 or var_238_9 * (utf8.len(var_238_11) / 7)) > 0 and var_238_9 < var_238_13 then
					arg_235_1.talkMaxDuration = var_238_13

					if var_238_13 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_13 + var_238_8
					end
				end

				arg_235_1.text_.text = var_238_11
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091056", "story_v_out_926091.awb") ~= 0 then
					local var_238_14 = manager.audio:GetVoiceLength("story_v_out_926091", "926091056", "story_v_out_926091.awb") / 1000

					if var_238_14 + var_238_8 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_14 + var_238_8
					end

					if var_238_10.prefab_name ~= "" and arg_235_1.actors_[var_238_10.prefab_name] ~= nil then
						local var_238_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_10.prefab_name].transform, "story_v_out_926091", "926091056", "story_v_out_926091.awb")

						arg_235_1:RecordAudio("926091056", var_238_15)
						arg_235_1:RecordAudio("926091056", var_238_15)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_926091", "926091056", "story_v_out_926091.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_926091", "926091056", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091057 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 926091057
		arg_239_1.duration_ = 5

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play926091058(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(arg_239_1.actors_["10144"]) and arg_239_1.var_.actorSpriteComps10144 == nil then
				arg_239_1.var_.actorSpriteComps10144 = arg_239_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_242_0 = 0.2

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 and not isNil(arg_239_1.actors_["10144"]) then
				if arg_239_1.var_.actorSpriteComps10144 then
					for iter_242_0, iter_242_1 in pairs(arg_239_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_242_1 then
							if arg_239_1.isInRecall_ then
								iter_242_1.color = Color.New(Mathf.Lerp(iter_242_1.color.r, arg_239_1.hightColor2.r, (arg_239_1.time_ - 0) / var_242_0), Mathf.Lerp(iter_242_1.color.g, arg_239_1.hightColor2.g, (arg_239_1.time_ - 0) / var_242_0), (Mathf.Lerp(iter_242_1.color.b, arg_239_1.hightColor2.b, (arg_239_1.time_ - 0) / var_242_0)))
							else
								local var_242_1 = Mathf.Lerp(iter_242_1.color.r, 0.5, (arg_239_1.time_ - 0) / var_242_0)

								iter_242_1.color = Color.New(var_242_1, var_242_1, var_242_1)
							end
						end
					end
				end
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 and not isNil(arg_239_1.actors_["10144"]) and arg_239_1.var_.actorSpriteComps10144 then
				for iter_242_2, iter_242_3 in pairs(arg_239_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_242_3 then
						iter_242_3.color = arg_239_1.isInRecall_ and (arg_239_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_239_1.var_.actorSpriteComps10144 = nil
			end

			local var_242_2 = 0
			local var_242_3 = 0.175

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_2 + arg_242_0 then
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

				arg_239_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_239_1.callingController_:SetSelectedState("normal")

				arg_239_1.keyicon_.color = Color.New(1, 1, 1)
				arg_239_1.icon_.color = Color.New(1, 1, 1)

				local var_242_4 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(926091057).content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_6 = 7 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 7)

				if (7 <= 0 and var_242_3 or var_242_3 * (utf8.len(var_242_4) / 7)) > 0 and var_242_3 < var_242_6 then
					arg_239_1.talkMaxDuration = var_242_6

					if var_242_6 + var_242_2 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_6 + var_242_2
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_7 = math.max(var_242_3, arg_239_1.talkMaxDuration)

			if var_242_2 <= arg_239_1.time_ and arg_239_1.time_ < var_242_2 + var_242_7 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_2) / var_242_7

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_2 + var_242_7 and arg_239_1.time_ < var_242_2 + var_242_7 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play926091058 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 926091058
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play926091059(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos10144 = arg_243_1.actors_["10144"].transform.localPosition
				arg_243_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("10144", 7)

				for iter_246_0 = 0, arg_243_1.actors_["10144"].transform.childCount - 1 do
					local var_246_0 = arg_243_1.actors_["10144"].transform:GetChild(iter_246_0)

					if var_246_0.name == "" or not string.find(var_246_0.name, "split") then
						var_246_0.gameObject:SetActive(true)
					else
						var_246_0.gameObject:SetActive(false)
					end
				end
			end

			local var_246_1 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_1 then
				arg_243_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_243_1.time_ - 0) / var_246_1)
			end

			if arg_243_1.time_ >= 0 + var_246_1 and arg_243_1.time_ < 0 + var_246_1 + arg_246_0 then
				arg_243_1.actors_["10144"].transform.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_246_2 = arg_243_1.actors_["104701"].transform

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 then
				arg_243_1.var_.moveOldPos104701 = var_246_2.localPosition
				var_246_2.localScale = Vector3.New(1, 1, 1)

				arg_243_1:CheckSpriteTmpPos("104701", 7)

				for iter_246_1 = 0, var_246_2.childCount - 1 do
					local var_246_3 = var_246_2:GetChild(iter_246_1)

					if var_246_3.name == "" or not string.find(var_246_3.name, "split") then
						var_246_3.gameObject:SetActive(true)
					else
						var_246_3.gameObject:SetActive(false)
					end
				end
			end

			local var_246_4 = 0.001

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_4 then
				var_246_2.localPosition = Vector3.Lerp(arg_243_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_243_1.time_ - 0) / var_246_4)
			end

			if arg_243_1.time_ >= 0 + var_246_4 and arg_243_1.time_ < 0 + var_246_4 + arg_246_0 then
				var_246_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_246_5 = 0
			local var_246_6 = 0.425

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_5 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, false)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_7 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(926091058).content)

				arg_243_1.text_.text = var_246_7

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_9 = 17 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_7) / 17)

				if (17 <= 0 and var_246_6 or var_246_6 * (utf8.len(var_246_7) / 17)) > 0 and var_246_6 < var_246_9 then
					arg_243_1.talkMaxDuration = var_246_9

					if var_246_9 + var_246_5 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_9 + var_246_5
					end
				end

				arg_243_1.text_.text = var_246_7
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_6, arg_243_1.talkMaxDuration)

			if var_246_5 <= arg_243_1.time_ and arg_243_1.time_ < var_246_5 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_5) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_5 + var_246_10 and arg_243_1.time_ < var_246_5 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {
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
				actorName = "104701",
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
	Play926091059 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 926091059
		arg_247_1.duration_ = 9.4

		local var_247_0 = {
			zh = 4.833,
			ja = 9.4
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
				arg_247_0:Play926091060(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 and not isNil(arg_247_1.actors_["10144"]) and arg_247_1.var_.actorSpriteComps10144 == nil then
				arg_247_1.var_.actorSpriteComps10144 = arg_247_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_250_0 = 0.2

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_0 and not isNil(arg_247_1.actors_["10144"]) then
				if arg_247_1.var_.actorSpriteComps10144 then
					for iter_250_0, iter_250_1 in pairs(arg_247_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_250_1 then
							if arg_247_1.isInRecall_ then
								iter_250_1.color = Color.New(Mathf.Lerp(iter_250_1.color.r, arg_247_1.hightColor1.r, (arg_247_1.time_ - 0) / var_250_0), Mathf.Lerp(iter_250_1.color.g, arg_247_1.hightColor1.g, (arg_247_1.time_ - 0) / var_250_0), (Mathf.Lerp(iter_250_1.color.b, arg_247_1.hightColor1.b, (arg_247_1.time_ - 0) / var_250_0)))
							else
								local var_250_1 = Mathf.Lerp(iter_250_1.color.r, 1, (arg_247_1.time_ - 0) / var_250_0)

								iter_250_1.color = Color.New(var_250_1, var_250_1, var_250_1)
							end
						end
					end
				end
			end

			if arg_247_1.time_ >= 0 + var_250_0 and arg_247_1.time_ < 0 + var_250_0 + arg_250_0 and not isNil(arg_247_1.actors_["10144"]) and arg_247_1.var_.actorSpriteComps10144 then
				for iter_250_2, iter_250_3 in pairs(arg_247_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_250_3 then
						iter_250_3.color = arg_247_1.isInRecall_ and (arg_247_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_247_1.var_.actorSpriteComps10144 = nil
			end

			local var_250_2 = arg_247_1.actors_["10144"].transform

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1.var_.moveOldPos10144 = var_250_2.localPosition
				var_250_2.localScale = Vector3.New(1, 1, 1)

				arg_247_1:CheckSpriteTmpPos("10144", 3)

				for iter_250_4 = 0, var_250_2.childCount - 1 do
					local var_250_3 = var_250_2:GetChild(iter_250_4)

					if var_250_3.name == "split_2" or not string.find(var_250_3.name, "split") then
						var_250_3.gameObject:SetActive(true)
					else
						var_250_3.gameObject:SetActive(false)
					end
				end
			end

			local var_250_4 = 0.001

			if 0 <= arg_247_1.time_ and arg_247_1.time_ < 0 + var_250_4 then
				var_250_2.localPosition = Vector3.Lerp(arg_247_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_247_1.time_ - 0) / var_250_4)
			end

			if arg_247_1.time_ >= 0 + var_250_4 and arg_247_1.time_ < 0 + var_250_4 + arg_250_0 then
				var_250_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_250_5 = 0
			local var_250_6 = 0.675

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_5 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				arg_247_1.leftNameTxt_.text = arg_247_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_7 = arg_247_1:GetWordFromCfg(926091059)
				local var_250_8 = arg_247_1:FormatText(var_250_7.content)

				arg_247_1.text_.text = var_250_8

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_10 = 27 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 27)

				if (27 <= 0 and var_250_6 or var_250_6 * (utf8.len(var_250_8) / 27)) > 0 and var_250_6 < var_250_10 then
					arg_247_1.talkMaxDuration = var_250_10

					if var_250_10 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_10 + var_250_5
					end
				end

				arg_247_1.text_.text = var_250_8
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091059", "story_v_out_926091.awb") ~= 0 then
					local var_250_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091059", "story_v_out_926091.awb") / 1000

					if var_250_11 + var_250_5 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_11 + var_250_5
					end

					if var_250_7.prefab_name ~= "" and arg_247_1.actors_[var_250_7.prefab_name] ~= nil then
						local var_250_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_7.prefab_name].transform, "story_v_out_926091", "926091059", "story_v_out_926091.awb")

						arg_247_1:RecordAudio("926091059", var_250_12)
						arg_247_1:RecordAudio("926091059", var_250_12)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_926091", "926091059", "story_v_out_926091.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_926091", "926091059", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091060 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 926091060
		arg_251_1.duration_ = 5.77

		local var_251_0 = {
			zh = 5.633,
			ja = 5.766
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
				arg_251_0:Play926091061(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = 0.775

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				arg_251_1.leftNameTxt_.text = arg_251_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_1 = arg_251_1:GetWordFromCfg(926091060)
				local var_254_2 = arg_251_1:FormatText(var_254_1.content)

				arg_251_1.text_.text = var_254_2

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_4 = 28 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 28)

				if (28 <= 0 and var_254_0 or var_254_0 * (utf8.len(var_254_2) / 28)) > 0 and var_254_0 < var_254_4 then
					arg_251_1.talkMaxDuration = var_254_4

					if var_254_4 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_4 + 0
					end
				end

				arg_251_1.text_.text = var_254_2
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091060", "story_v_out_926091.awb") ~= 0 then
					local var_254_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091060", "story_v_out_926091.awb") / 1000

					if var_254_5 + 0 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_5 + 0
					end

					if var_254_1.prefab_name ~= "" and arg_251_1.actors_[var_254_1.prefab_name] ~= nil then
						local var_254_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_1.prefab_name].transform, "story_v_out_926091", "926091060", "story_v_out_926091.awb")

						arg_251_1:RecordAudio("926091060", var_254_6)
						arg_251_1:RecordAudio("926091060", var_254_6)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_926091", "926091060", "story_v_out_926091.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_926091", "926091060", "story_v_out_926091.awb")
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
	Play926091061 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 926091061
		arg_255_1.duration_ = 5

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play926091062(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 and not isNil(arg_255_1.actors_["10144"]) and arg_255_1.var_.actorSpriteComps10144 == nil then
				arg_255_1.var_.actorSpriteComps10144 = arg_255_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_258_0 = 0.2

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_0 and not isNil(arg_255_1.actors_["10144"]) then
				if arg_255_1.var_.actorSpriteComps10144 then
					for iter_258_0, iter_258_1 in pairs(arg_255_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_258_1 then
							if arg_255_1.isInRecall_ then
								iter_258_1.color = Color.New(Mathf.Lerp(iter_258_1.color.r, arg_255_1.hightColor2.r, (arg_255_1.time_ - 0) / var_258_0), Mathf.Lerp(iter_258_1.color.g, arg_255_1.hightColor2.g, (arg_255_1.time_ - 0) / var_258_0), (Mathf.Lerp(iter_258_1.color.b, arg_255_1.hightColor2.b, (arg_255_1.time_ - 0) / var_258_0)))
							else
								local var_258_1 = Mathf.Lerp(iter_258_1.color.r, 0.5, (arg_255_1.time_ - 0) / var_258_0)

								iter_258_1.color = Color.New(var_258_1, var_258_1, var_258_1)
							end
						end
					end
				end
			end

			if arg_255_1.time_ >= 0 + var_258_0 and arg_255_1.time_ < 0 + var_258_0 + arg_258_0 and not isNil(arg_255_1.actors_["10144"]) and arg_255_1.var_.actorSpriteComps10144 then
				for iter_258_2, iter_258_3 in pairs(arg_255_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_258_3 then
						iter_258_3.color = arg_255_1.isInRecall_ and (arg_255_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_255_1.var_.actorSpriteComps10144 = nil
			end

			local var_258_2 = arg_255_1.actors_["10144"].transform

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= 0 + arg_258_0 then
				arg_255_1.var_.moveOldPos10144 = var_258_2.localPosition
				var_258_2.localScale = Vector3.New(1, 1, 1)

				arg_255_1:CheckSpriteTmpPos("10144", 7)

				for iter_258_4 = 0, var_258_2.childCount - 1 do
					local var_258_3 = var_258_2:GetChild(iter_258_4)

					if var_258_3.name == "" or not string.find(var_258_3.name, "split") then
						var_258_3.gameObject:SetActive(true)
					else
						var_258_3.gameObject:SetActive(false)
					end
				end
			end

			local var_258_4 = 0.001

			if 0 <= arg_255_1.time_ and arg_255_1.time_ < 0 + var_258_4 then
				var_258_2.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_255_1.time_ - 0) / var_258_4)
			end

			if arg_255_1.time_ >= 0 + var_258_4 and arg_255_1.time_ < 0 + var_258_4 + arg_258_0 then
				var_258_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.034 < arg_255_1.time_ and arg_255_1.time_ <= 0.034 + arg_258_0 then
				arg_255_1:AudioAction("play", "effect", "se_story_143", "se_story_143_dragon", "")
			end

			local var_258_6 = manager.ui.mainCamera.transform

			if 0.034 < arg_255_1.time_ and arg_255_1.time_ <= 0.034 + arg_258_0 then
				arg_255_1.var_.shakeOldPos = var_258_6.localPosition
			end

			local var_258_7 = 0.599333333333333

			if 0.034 <= arg_255_1.time_ and arg_255_1.time_ < 0.034 + var_258_7 then
				local var_258_8, var_258_9 = math.modf((arg_255_1.time_ - 0.034) / 0.066)

				var_258_6.localPosition = Vector3.New(var_258_9 * 0.13, var_258_9 * 0.13, var_258_9 * 0.13) + arg_255_1.var_.shakeOldPos
			end

			if arg_255_1.time_ >= 0.034 + var_258_7 and arg_255_1.time_ < 0.034 + var_258_7 + arg_258_0 then
				var_258_6.localPosition = arg_255_1.var_.shakeOldPos
			end

			local var_258_10 = 0
			local var_258_11 = 1.125

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, false)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_12 = arg_255_1:FormatText(arg_255_1:GetWordFromCfg(926091061).content)

				arg_255_1.text_.text = var_258_12

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_14 = 45 <= 0 and var_258_11 or var_258_11 * (utf8.len(var_258_12) / 45)

				if (45 <= 0 and var_258_11 or var_258_11 * (utf8.len(var_258_12) / 45)) > 0 and var_258_11 < var_258_14 then
					arg_255_1.talkMaxDuration = var_258_14

					if var_258_14 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_14 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_12
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)
				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_15 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_15 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_10) / var_258_15

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_10 + var_258_15 and arg_255_1.time_ < var_258_10 + var_258_15 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
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

		arg_255_1:InitPlayNodeList()
	end,
	Play926091062 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 926091062
		arg_259_1.duration_ = 3.17

		local var_259_0 = {
			zh = 3.133,
			ja = 3.166
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
				arg_259_0:Play926091063(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 and not isNil(arg_259_1.actors_["128404"]) and arg_259_1.var_.actorSpriteComps128404 == nil then
				arg_259_1.var_.actorSpriteComps128404 = arg_259_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_262_0 = 0.2

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_0 and not isNil(arg_259_1.actors_["128404"]) then
				if arg_259_1.var_.actorSpriteComps128404 then
					for iter_262_0, iter_262_1 in pairs(arg_259_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_259_1.time_ >= 0 + var_262_0 and arg_259_1.time_ < 0 + var_262_0 + arg_262_0 and not isNil(arg_259_1.actors_["128404"]) and arg_259_1.var_.actorSpriteComps128404 then
				for iter_262_2, iter_262_3 in pairs(arg_259_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_262_3 then
						iter_262_3.color = arg_259_1.isInRecall_ and (arg_259_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_259_1.var_.actorSpriteComps128404 = nil
			end

			local var_262_2 = arg_259_1.actors_["128404"].transform

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				arg_259_1.var_.moveOldPos128404 = var_262_2.localPosition
				var_262_2.localScale = Vector3.New(1, 1, 1)

				arg_259_1:CheckSpriteTmpPos("128404", 3)

				for iter_262_4 = 0, var_262_2.childCount - 1 do
					local var_262_3 = var_262_2:GetChild(iter_262_4)

					if var_262_3.name == "" or not string.find(var_262_3.name, "split") then
						var_262_3.gameObject:SetActive(true)
					else
						var_262_3.gameObject:SetActive(false)
					end
				end
			end

			local var_262_4 = 0.001

			if 0 <= arg_259_1.time_ and arg_259_1.time_ < 0 + var_262_4 then
				var_262_2.localPosition = Vector3.Lerp(arg_259_1.var_.moveOldPos128404, Vector3.New(-16.1, -362, -375), (arg_259_1.time_ - 0) / var_262_4)
			end

			if arg_259_1.time_ >= 0 + var_262_4 and arg_259_1.time_ < 0 + var_262_4 + arg_262_0 then
				var_262_2.localPosition = Vector3.New(-16.1, -362, -375)
			end

			local var_262_5 = 0
			local var_262_6 = 0.3

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_5 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				arg_259_1.leftNameTxt_.text = arg_259_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_7 = arg_259_1:GetWordFromCfg(926091062)
				local var_262_8 = arg_259_1:FormatText(var_262_7.content)

				arg_259_1.text_.text = var_262_8

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_10 = 12 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 12)

				if (12 <= 0 and var_262_6 or var_262_6 * (utf8.len(var_262_8) / 12)) > 0 and var_262_6 < var_262_10 then
					arg_259_1.talkMaxDuration = var_262_10

					if var_262_10 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_10 + var_262_5
					end
				end

				arg_259_1.text_.text = var_262_8
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091062", "story_v_out_926091.awb") ~= 0 then
					local var_262_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091062", "story_v_out_926091.awb") / 1000

					if var_262_11 + var_262_5 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_11 + var_262_5
					end

					if var_262_7.prefab_name ~= "" and arg_259_1.actors_[var_262_7.prefab_name] ~= nil then
						local var_262_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_7.prefab_name].transform, "story_v_out_926091", "926091062", "story_v_out_926091.awb")

						arg_259_1:RecordAudio("926091062", var_262_12)
						arg_259_1:RecordAudio("926091062", var_262_12)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_926091", "926091062", "story_v_out_926091.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_926091", "926091062", "story_v_out_926091.awb")
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
				actorName = "128404",
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
	Play926091063 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 926091063
		arg_263_1.duration_ = 5.2

		local var_263_0 = {
			zh = 3.9,
			ja = 5.2
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
				arg_263_0:Play926091064(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = 0.45

			if 0 < arg_263_1.time_ and arg_263_1.time_ <= 0 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				arg_263_1.leftNameTxt_.text = arg_263_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_1 = arg_263_1:GetWordFromCfg(926091063)
				local var_266_2 = arg_263_1:FormatText(var_266_1.content)

				arg_263_1.text_.text = var_266_2

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_4 = 18 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 18)

				if (18 <= 0 and var_266_0 or var_266_0 * (utf8.len(var_266_2) / 18)) > 0 and var_266_0 < var_266_4 then
					arg_263_1.talkMaxDuration = var_266_4

					if var_266_4 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_4 + 0
					end
				end

				arg_263_1.text_.text = var_266_2
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091063", "story_v_out_926091.awb") ~= 0 then
					local var_266_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091063", "story_v_out_926091.awb") / 1000

					if var_266_5 + 0 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_5 + 0
					end

					if var_266_1.prefab_name ~= "" and arg_263_1.actors_[var_266_1.prefab_name] ~= nil then
						local var_266_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_1.prefab_name].transform, "story_v_out_926091", "926091063", "story_v_out_926091.awb")

						arg_263_1:RecordAudio("926091063", var_266_6)
						arg_263_1:RecordAudio("926091063", var_266_6)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_926091", "926091063", "story_v_out_926091.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_926091", "926091063", "story_v_out_926091.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_7 = math.max(var_266_0, arg_263_1.talkMaxDuration)

			if 0 <= arg_263_1.time_ and arg_263_1.time_ < 0 + var_266_7 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - 0) / var_266_7

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= 0 + var_266_7 and arg_263_1.time_ < 0 + var_266_7 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end

		arg_263_1.nodeConfigList_ = {}

		arg_263_1:InitPlayNodeList()
	end,
	Play926091064 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 926091064
		arg_267_1.duration_ = 7.07

		local var_267_0 = {
			zh = 5.7,
			ja = 7.066
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
				arg_267_0:Play926091065(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(arg_267_1.actors_["106103"]) and arg_267_1.var_.actorSpriteComps106103 == nil then
				arg_267_1.var_.actorSpriteComps106103 = arg_267_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_0 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_0 and not isNil(arg_267_1.actors_["106103"]) then
				if arg_267_1.var_.actorSpriteComps106103 then
					for iter_270_0, iter_270_1 in pairs(arg_267_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_270_1 then
							if arg_267_1.isInRecall_ then
								iter_270_1.color = Color.New(Mathf.Lerp(iter_270_1.color.r, arg_267_1.hightColor1.r, (arg_267_1.time_ - 0) / var_270_0), Mathf.Lerp(iter_270_1.color.g, arg_267_1.hightColor1.g, (arg_267_1.time_ - 0) / var_270_0), (Mathf.Lerp(iter_270_1.color.b, arg_267_1.hightColor1.b, (arg_267_1.time_ - 0) / var_270_0)))
							else
								local var_270_1 = Mathf.Lerp(iter_270_1.color.r, 1, (arg_267_1.time_ - 0) / var_270_0)

								iter_270_1.color = Color.New(var_270_1, var_270_1, var_270_1)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_0 and arg_267_1.time_ < 0 + var_270_0 + arg_270_0 and not isNil(arg_267_1.actors_["106103"]) and arg_267_1.var_.actorSpriteComps106103 then
				for iter_270_2, iter_270_3 in pairs(arg_267_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_270_3 then
						iter_270_3.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_267_1.var_.actorSpriteComps106103 = nil
			end

			local var_270_2 = arg_267_1.actors_["128404"]

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps128404 == nil then
				arg_267_1.var_.actorSpriteComps128404 = var_270_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_270_3 = 0.2

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_3 and not isNil(var_270_2) then
				if arg_267_1.var_.actorSpriteComps128404 then
					for iter_270_4, iter_270_5 in pairs(arg_267_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_270_5 then
							if arg_267_1.isInRecall_ then
								iter_270_5.color = Color.New(Mathf.Lerp(iter_270_5.color.r, arg_267_1.hightColor2.r, (arg_267_1.time_ - 0) / var_270_3), Mathf.Lerp(iter_270_5.color.g, arg_267_1.hightColor2.g, (arg_267_1.time_ - 0) / var_270_3), (Mathf.Lerp(iter_270_5.color.b, arg_267_1.hightColor2.b, (arg_267_1.time_ - 0) / var_270_3)))
							else
								local var_270_4 = Mathf.Lerp(iter_270_5.color.r, 0.5, (arg_267_1.time_ - 0) / var_270_3)

								iter_270_5.color = Color.New(var_270_4, var_270_4, var_270_4)
							end
						end
					end
				end
			end

			if arg_267_1.time_ >= 0 + var_270_3 and arg_267_1.time_ < 0 + var_270_3 + arg_270_0 and not isNil(var_270_2) and arg_267_1.var_.actorSpriteComps128404 then
				for iter_270_6, iter_270_7 in pairs(arg_267_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_270_7 then
						iter_270_7.color = arg_267_1.isInRecall_ and (arg_267_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_267_1.var_.actorSpriteComps128404 = nil
			end

			local var_270_5 = arg_267_1.actors_["106103"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos106103 = var_270_5.localPosition
				var_270_5.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("106103", 4)

				for iter_270_8 = 0, var_270_5.childCount - 1 do
					local var_270_6 = var_270_5:GetChild(iter_270_8)

					if var_270_6.name == "" or not string.find(var_270_6.name, "split") then
						var_270_6.gameObject:SetActive(true)
					else
						var_270_6.gameObject:SetActive(false)
					end
				end
			end

			local var_270_7 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_7 then
				var_270_5.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos106103, Vector3.New(442.7, -398.2, -333.7), (arg_267_1.time_ - 0) / var_270_7)
			end

			if arg_267_1.time_ >= 0 + var_270_7 and arg_267_1.time_ < 0 + var_270_7 + arg_270_0 then
				var_270_5.localPosition = Vector3.New(442.7, -398.2, -333.7)
			end

			local var_270_8 = arg_267_1.actors_["128404"].transform

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= 0 + arg_270_0 then
				arg_267_1.var_.moveOldPos128404 = var_270_8.localPosition
				var_270_8.localScale = Vector3.New(1, 1, 1)

				arg_267_1:CheckSpriteTmpPos("128404", 2)

				for iter_270_9 = 0, var_270_8.childCount - 1 do
					local var_270_9 = var_270_8:GetChild(iter_270_9)

					if var_270_9.name == "" or not string.find(var_270_9.name, "split") then
						var_270_9.gameObject:SetActive(true)
					else
						var_270_9.gameObject:SetActive(false)
					end
				end
			end

			local var_270_10 = 0.001

			if 0 <= arg_267_1.time_ and arg_267_1.time_ < 0 + var_270_10 then
				var_270_8.localPosition = Vector3.Lerp(arg_267_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_267_1.time_ - 0) / var_270_10)
			end

			if arg_267_1.time_ >= 0 + var_270_10 and arg_267_1.time_ < 0 + var_270_10 + arg_270_0 then
				var_270_8.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_270_11 = 0
			local var_270_12 = 0.725

			if 0 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				arg_267_1.leftNameTxt_.text = arg_267_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_13 = arg_267_1:GetWordFromCfg(926091064)
				local var_270_14 = arg_267_1:FormatText(var_270_13.content)

				arg_267_1.text_.text = var_270_14

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_16 = 29 <= 0 and var_270_12 or var_270_12 * (utf8.len(var_270_14) / 29)

				if (29 <= 0 and var_270_12 or var_270_12 * (utf8.len(var_270_14) / 29)) > 0 and var_270_12 < var_270_16 then
					arg_267_1.talkMaxDuration = var_270_16

					if var_270_16 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_16 + var_270_11
					end
				end

				arg_267_1.text_.text = var_270_14
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091064", "story_v_out_926091.awb") ~= 0 then
					local var_270_17 = manager.audio:GetVoiceLength("story_v_out_926091", "926091064", "story_v_out_926091.awb") / 1000

					if var_270_17 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_17 + var_270_11
					end

					if var_270_13.prefab_name ~= "" and arg_267_1.actors_[var_270_13.prefab_name] ~= nil then
						local var_270_18 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_13.prefab_name].transform, "story_v_out_926091", "926091064", "story_v_out_926091.awb")

						arg_267_1:RecordAudio("926091064", var_270_18)
						arg_267_1:RecordAudio("926091064", var_270_18)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_926091", "926091064", "story_v_out_926091.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_926091", "926091064", "story_v_out_926091.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_19 = math.max(var_270_12, arg_267_1.talkMaxDuration)

			if var_270_11 <= arg_267_1.time_ and arg_267_1.time_ < var_270_11 + var_270_19 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_11) / var_270_19

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_11 + var_270_19 and arg_267_1.time_ < var_270_11 + var_270_19 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end

		arg_267_1.nodeConfigList_ = {
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
				actorName = "128404",
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
	Play926091065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 926091065
		arg_271_1.duration_ = 5.23

		local var_271_0 = {
			zh = 4.033,
			ja = 5.233
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
				arg_271_0:Play926091066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 0.475

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_1 = arg_271_1:GetWordFromCfg(926091065)
				local var_274_2 = arg_271_1:FormatText(var_274_1.content)

				arg_271_1.text_.text = var_274_2

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_4 = 19 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 19)

				if (19 <= 0 and var_274_0 or var_274_0 * (utf8.len(var_274_2) / 19)) > 0 and var_274_0 < var_274_4 then
					arg_271_1.talkMaxDuration = var_274_4

					if var_274_4 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_4 + 0
					end
				end

				arg_271_1.text_.text = var_274_2
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091065", "story_v_out_926091.awb") ~= 0 then
					local var_274_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091065", "story_v_out_926091.awb") / 1000

					if var_274_5 + 0 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_5 + 0
					end

					if var_274_1.prefab_name ~= "" and arg_271_1.actors_[var_274_1.prefab_name] ~= nil then
						local var_274_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_1.prefab_name].transform, "story_v_out_926091", "926091065", "story_v_out_926091.awb")

						arg_271_1:RecordAudio("926091065", var_274_6)
						arg_271_1:RecordAudio("926091065", var_274_6)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_926091", "926091065", "story_v_out_926091.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_926091", "926091065", "story_v_out_926091.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_7 = math.max(var_274_0, arg_271_1.talkMaxDuration)

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - 0) / var_274_7

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {}

		arg_271_1:InitPlayNodeList()
	end,
	Play926091066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 926091066
		arg_275_1.duration_ = 2.03

		local var_275_0 = {
			zh = 1.533,
			ja = 2.033
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
				arg_275_0:Play926091067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(arg_275_1.actors_["128404"]) and arg_275_1.var_.actorSpriteComps128404 == nil then
				arg_275_1.var_.actorSpriteComps128404 = arg_275_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_0 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_0 and not isNil(arg_275_1.actors_["128404"]) then
				if arg_275_1.var_.actorSpriteComps128404 then
					for iter_278_0, iter_278_1 in pairs(arg_275_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_275_1.time_ >= 0 + var_278_0 and arg_275_1.time_ < 0 + var_278_0 + arg_278_0 and not isNil(arg_275_1.actors_["128404"]) and arg_275_1.var_.actorSpriteComps128404 then
				for iter_278_2, iter_278_3 in pairs(arg_275_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_278_3 then
						iter_278_3.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_275_1.var_.actorSpriteComps128404 = nil
			end

			local var_278_2 = arg_275_1.actors_["106103"]

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps106103 == nil then
				arg_275_1.var_.actorSpriteComps106103 = var_278_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_278_3 = 0.2

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_3 and not isNil(var_278_2) then
				if arg_275_1.var_.actorSpriteComps106103 then
					for iter_278_4, iter_278_5 in pairs(arg_275_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_275_1.time_ >= 0 + var_278_3 and arg_275_1.time_ < 0 + var_278_3 + arg_278_0 and not isNil(var_278_2) and arg_275_1.var_.actorSpriteComps106103 then
				for iter_278_6, iter_278_7 in pairs(arg_275_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_278_7 then
						iter_278_7.color = arg_275_1.isInRecall_ and (arg_275_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_275_1.var_.actorSpriteComps106103 = nil
			end

			local var_278_5 = 0
			local var_278_6 = 0.15

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= var_278_5 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_7 = arg_275_1:GetWordFromCfg(926091066)
				local var_278_8 = arg_275_1:FormatText(var_278_7.content)

				arg_275_1.text_.text = var_278_8

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_10 = 6 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 6)

				if (6 <= 0 and var_278_6 or var_278_6 * (utf8.len(var_278_8) / 6)) > 0 and var_278_6 < var_278_10 then
					arg_275_1.talkMaxDuration = var_278_10

					if var_278_10 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_10 + var_278_5
					end
				end

				arg_275_1.text_.text = var_278_8
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091066", "story_v_out_926091.awb") ~= 0 then
					local var_278_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091066", "story_v_out_926091.awb") / 1000

					if var_278_11 + var_278_5 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_11 + var_278_5
					end

					if var_278_7.prefab_name ~= "" and arg_275_1.actors_[var_278_7.prefab_name] ~= nil then
						local var_278_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_7.prefab_name].transform, "story_v_out_926091", "926091066", "story_v_out_926091.awb")

						arg_275_1:RecordAudio("926091066", var_278_12)
						arg_275_1:RecordAudio("926091066", var_278_12)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_926091", "926091066", "story_v_out_926091.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_926091", "926091066", "story_v_out_926091.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_13 = math.max(var_278_6, arg_275_1.talkMaxDuration)

			if var_278_5 <= arg_275_1.time_ and arg_275_1.time_ < var_278_5 + var_278_13 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - var_278_5) / var_278_13

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= var_278_5 + var_278_13 and arg_275_1.time_ < var_278_5 + var_278_13 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play926091067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 926091067
		arg_279_1.duration_ = 9.43

		local var_279_0 = {
			zh = 7.466,
			ja = 9.433
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
				arg_279_0:Play926091068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 then
				arg_279_1.var_.moveOldPos128404 = arg_279_1.actors_["128404"].transform.localPosition
				arg_279_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_279_1:CheckSpriteTmpPos("128404", 2)

				for iter_282_0 = 0, arg_279_1.actors_["128404"].transform.childCount - 1 do
					local var_282_0 = arg_279_1.actors_["128404"].transform:GetChild(iter_282_0)

					if var_282_0.name == "split_4" or not string.find(var_282_0.name, "split") then
						var_282_0.gameObject:SetActive(true)
					else
						var_282_0.gameObject:SetActive(false)
					end
				end
			end

			local var_282_1 = 0.001

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_1 then
				arg_279_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_279_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_279_1.time_ - 0) / var_282_1)
			end

			if arg_279_1.time_ >= 0 + var_282_1 and arg_279_1.time_ < 0 + var_282_1 + arg_282_0 then
				arg_279_1.actors_["128404"].transform.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_282_2 = 0
			local var_282_3 = 0.725

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_2 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, true)

				arg_279_1.leftNameTxt_.text = arg_279_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_279_1.leftNameTxt_.transform)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1.leftNameTxt_.text)
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_4 = arg_279_1:GetWordFromCfg(926091067)
				local var_282_5 = arg_279_1:FormatText(var_282_4.content)

				arg_279_1.text_.text = var_282_5

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_7 = 29 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 29)

				if (29 <= 0 and var_282_3 or var_282_3 * (utf8.len(var_282_5) / 29)) > 0 and var_282_3 < var_282_7 then
					arg_279_1.talkMaxDuration = var_282_7

					if var_282_7 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_7 + var_282_2
					end
				end

				arg_279_1.text_.text = var_282_5
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091067", "story_v_out_926091.awb") ~= 0 then
					local var_282_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091067", "story_v_out_926091.awb") / 1000

					if var_282_8 + var_282_2 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_8 + var_282_2
					end

					if var_282_4.prefab_name ~= "" and arg_279_1.actors_[var_282_4.prefab_name] ~= nil then
						local var_282_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_279_1.actors_[var_282_4.prefab_name].transform, "story_v_out_926091", "926091067", "story_v_out_926091.awb")

						arg_279_1:RecordAudio("926091067", var_282_9)
						arg_279_1:RecordAudio("926091067", var_282_9)
					else
						arg_279_1:AudioAction("play", "voice", "story_v_out_926091", "926091067", "story_v_out_926091.awb")
					end

					arg_279_1:RecordHistoryTalkVoice("story_v_out_926091", "926091067", "story_v_out_926091.awb")
				end

				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_10 = math.max(var_282_3, arg_279_1.talkMaxDuration)

			if var_282_2 <= arg_279_1.time_ and arg_279_1.time_ < var_282_2 + var_282_10 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_2) / var_282_10

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_2 + var_282_10 and arg_279_1.time_ < var_282_2 + var_282_10 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {
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

		arg_279_1:InitPlayNodeList()
	end,
	Play926091068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 926091068
		arg_283_1.duration_ = 5.67

		local var_283_0 = {
			zh = 3.9,
			ja = 5.666
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
				arg_283_0:Play926091069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(arg_283_1.actors_["104701"]) and arg_283_1.var_.actorSpriteComps104701 == nil then
				arg_283_1.var_.actorSpriteComps104701 = arg_283_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_0 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 and not isNil(arg_283_1.actors_["104701"]) then
				if arg_283_1.var_.actorSpriteComps104701 then
					for iter_286_0, iter_286_1 in pairs(arg_283_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_286_1 then
							if arg_283_1.isInRecall_ then
								iter_286_1.color = Color.New(Mathf.Lerp(iter_286_1.color.r, arg_283_1.hightColor1.r, (arg_283_1.time_ - 0) / var_286_0), Mathf.Lerp(iter_286_1.color.g, arg_283_1.hightColor1.g, (arg_283_1.time_ - 0) / var_286_0), (Mathf.Lerp(iter_286_1.color.b, arg_283_1.hightColor1.b, (arg_283_1.time_ - 0) / var_286_0)))
							else
								local var_286_1 = Mathf.Lerp(iter_286_1.color.r, 1, (arg_283_1.time_ - 0) / var_286_0)

								iter_286_1.color = Color.New(var_286_1, var_286_1, var_286_1)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 and not isNil(arg_283_1.actors_["104701"]) and arg_283_1.var_.actorSpriteComps104701 then
				for iter_286_2, iter_286_3 in pairs(arg_283_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_286_3 then
						iter_286_3.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_283_1.var_.actorSpriteComps104701 = nil
			end

			local var_286_2 = arg_283_1.actors_["128404"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps128404 == nil then
				arg_283_1.var_.actorSpriteComps128404 = var_286_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_286_3 = 0.2

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_3 and not isNil(var_286_2) then
				if arg_283_1.var_.actorSpriteComps128404 then
					for iter_286_4, iter_286_5 in pairs(arg_283_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_286_5 then
							if arg_283_1.isInRecall_ then
								iter_286_5.color = Color.New(Mathf.Lerp(iter_286_5.color.r, arg_283_1.hightColor2.r, (arg_283_1.time_ - 0) / var_286_3), Mathf.Lerp(iter_286_5.color.g, arg_283_1.hightColor2.g, (arg_283_1.time_ - 0) / var_286_3), (Mathf.Lerp(iter_286_5.color.b, arg_283_1.hightColor2.b, (arg_283_1.time_ - 0) / var_286_3)))
							else
								local var_286_4 = Mathf.Lerp(iter_286_5.color.r, 0.5, (arg_283_1.time_ - 0) / var_286_3)

								iter_286_5.color = Color.New(var_286_4, var_286_4, var_286_4)
							end
						end
					end
				end
			end

			if arg_283_1.time_ >= 0 + var_286_3 and arg_283_1.time_ < 0 + var_286_3 + arg_286_0 and not isNil(var_286_2) and arg_283_1.var_.actorSpriteComps128404 then
				for iter_286_6, iter_286_7 in pairs(arg_283_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_286_7 then
						iter_286_7.color = arg_283_1.isInRecall_ and (arg_283_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_283_1.var_.actorSpriteComps128404 = nil
			end

			local var_286_5 = arg_283_1.actors_["128404"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos128404 = var_286_5.localPosition
				var_286_5.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("128404", 7)

				for iter_286_8 = 0, var_286_5.childCount - 1 do
					local var_286_6 = var_286_5:GetChild(iter_286_8)

					if var_286_6.name == "" or not string.find(var_286_6.name, "split") then
						var_286_6.gameObject:SetActive(true)
					else
						var_286_6.gameObject:SetActive(false)
					end
				end
			end

			local var_286_7 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 then
				var_286_5.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_283_1.time_ - 0) / var_286_7)
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 then
				var_286_5.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_8 = arg_283_1.actors_["106103"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos106103 = var_286_8.localPosition
				var_286_8.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("106103", 7)

				for iter_286_9 = 0, var_286_8.childCount - 1 do
					local var_286_9 = var_286_8:GetChild(iter_286_9)

					if var_286_9.name == "" or not string.find(var_286_9.name, "split") then
						var_286_9.gameObject:SetActive(true)
					else
						var_286_9.gameObject:SetActive(false)
					end
				end
			end

			local var_286_10 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_10 then
				var_286_8.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos106103, Vector3.New(0, -2000, 0), (arg_283_1.time_ - 0) / var_286_10)
			end

			if arg_283_1.time_ >= 0 + var_286_10 and arg_283_1.time_ < 0 + var_286_10 + arg_286_0 then
				var_286_8.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_286_11 = arg_283_1.actors_["104701"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos104701 = var_286_11.localPosition
				var_286_11.localScale = Vector3.New(1, 1, 1)

				arg_283_1:CheckSpriteTmpPos("104701", 3)

				for iter_286_10 = 0, var_286_11.childCount - 1 do
					local var_286_12 = var_286_11:GetChild(iter_286_10)

					if var_286_12.name == "" or not string.find(var_286_12.name, "split") then
						var_286_12.gameObject:SetActive(true)
					else
						var_286_12.gameObject:SetActive(false)
					end
				end
			end

			local var_286_13 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_13 then
				var_286_11.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos104701, Vector3.New(-67.4, -386.8, -295), (arg_283_1.time_ - 0) / var_286_13)
			end

			if arg_283_1.time_ >= 0 + var_286_13 and arg_283_1.time_ < 0 + var_286_13 + arg_286_0 then
				var_286_11.localPosition = Vector3.New(-67.4, -386.8, -295)
			end

			local var_286_14 = 0
			local var_286_15 = 0.5

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_14 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_16 = arg_283_1:GetWordFromCfg(926091068)
				local var_286_17 = arg_283_1:FormatText(var_286_16.content)

				arg_283_1.text_.text = var_286_17

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_19 = 20 <= 0 and var_286_15 or var_286_15 * (utf8.len(var_286_17) / 20)

				if (20 <= 0 and var_286_15 or var_286_15 * (utf8.len(var_286_17) / 20)) > 0 and var_286_15 < var_286_19 then
					arg_283_1.talkMaxDuration = var_286_19

					if var_286_19 + var_286_14 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_19 + var_286_14
					end
				end

				arg_283_1.text_.text = var_286_17
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091068", "story_v_out_926091.awb") ~= 0 then
					local var_286_20 = manager.audio:GetVoiceLength("story_v_out_926091", "926091068", "story_v_out_926091.awb") / 1000

					if var_286_20 + var_286_14 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_20 + var_286_14
					end

					if var_286_16.prefab_name ~= "" and arg_283_1.actors_[var_286_16.prefab_name] ~= nil then
						local var_286_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_16.prefab_name].transform, "story_v_out_926091", "926091068", "story_v_out_926091.awb")

						arg_283_1:RecordAudio("926091068", var_286_21)
						arg_283_1:RecordAudio("926091068", var_286_21)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_926091", "926091068", "story_v_out_926091.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_926091", "926091068", "story_v_out_926091.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_22 = math.max(var_286_15, arg_283_1.talkMaxDuration)

			if var_286_14 <= arg_283_1.time_ and arg_283_1.time_ < var_286_14 + var_286_22 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_14) / var_286_22

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_14 + var_286_22 and arg_283_1.time_ < var_286_14 + var_286_22 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
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
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play926091069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 926091069
		arg_287_1.duration_ = 2.3

		local var_287_0 = {
			zh = 1.4,
			ja = 2.3
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
				arg_287_0:Play926091070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			local var_290_0 = 0.125

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_1 = arg_287_1:GetWordFromCfg(926091069)
				local var_290_2 = arg_287_1:FormatText(var_290_1.content)

				arg_287_1.text_.text = var_290_2

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_4 = 5 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 5)

				if (5 <= 0 and var_290_0 or var_290_0 * (utf8.len(var_290_2) / 5)) > 0 and var_290_0 < var_290_4 then
					arg_287_1.talkMaxDuration = var_290_4

					if var_290_4 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_4 + 0
					end
				end

				arg_287_1.text_.text = var_290_2
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091069", "story_v_out_926091.awb") ~= 0 then
					local var_290_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091069", "story_v_out_926091.awb") / 1000

					if var_290_5 + 0 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_5 + 0
					end

					if var_290_1.prefab_name ~= "" and arg_287_1.actors_[var_290_1.prefab_name] ~= nil then
						local var_290_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_1.prefab_name].transform, "story_v_out_926091", "926091069", "story_v_out_926091.awb")

						arg_287_1:RecordAudio("926091069", var_290_6)
						arg_287_1:RecordAudio("926091069", var_290_6)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_926091", "926091069", "story_v_out_926091.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_926091", "926091069", "story_v_out_926091.awb")
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
	Play926091070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 926091070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play926091071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["104701"]) and arg_291_1.var_.actorSpriteComps104701 == nil then
				arg_291_1.var_.actorSpriteComps104701 = arg_291_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_294_0 = 0.2

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["104701"]) then
				if arg_291_1.var_.actorSpriteComps104701 then
					for iter_294_0, iter_294_1 in pairs(arg_291_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["104701"]) and arg_291_1.var_.actorSpriteComps104701 then
				for iter_294_2, iter_294_3 in pairs(arg_291_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_294_3 then
						iter_294_3.color = arg_291_1.isInRecall_ and (arg_291_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_291_1.var_.actorSpriteComps104701 = nil
			end

			local var_294_2 = arg_291_1.actors_["104701"].transform

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 then
				arg_291_1.var_.moveOldPos104701 = var_294_2.localPosition
				var_294_2.localScale = Vector3.New(1, 1, 1)

				arg_291_1:CheckSpriteTmpPos("104701", 7)

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
				var_294_2.localPosition = Vector3.Lerp(arg_291_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_291_1.time_ - 0) / var_294_4)
			end

			if arg_291_1.time_ >= 0 + var_294_4 and arg_291_1.time_ < 0 + var_294_4 + arg_294_0 then
				var_294_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_294_5 = 0
			local var_294_6 = 0.7

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_5 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_7 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(926091070).content)

				arg_291_1.text_.text = var_294_7

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_9 = 28 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_7) / 28)

				if (28 <= 0 and var_294_6 or var_294_6 * (utf8.len(var_294_7) / 28)) > 0 and var_294_6 < var_294_9 then
					arg_291_1.talkMaxDuration = var_294_9

					if var_294_9 + var_294_5 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_9 + var_294_5
					end
				end

				arg_291_1.text_.text = var_294_7
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_10 = math.max(var_294_6, arg_291_1.talkMaxDuration)

			if var_294_5 <= arg_291_1.time_ and arg_291_1.time_ < var_294_5 + var_294_10 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_5) / var_294_10

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_5 + var_294_10 and arg_291_1.time_ < var_294_5 + var_294_10 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {
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

		arg_291_1:InitPlayNodeList()
	end,
	Play926091071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 926091071
		arg_295_1.duration_ = 3.37

		local var_295_0 = {
			zh = 3.366,
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
				arg_295_0:Play926091072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(arg_295_1.actors_["128404"]) and arg_295_1.var_.actorSpriteComps128404 == nil then
				arg_295_1.var_.actorSpriteComps128404 = arg_295_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_298_0 = 0.2

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 and not isNil(arg_295_1.actors_["128404"]) then
				if arg_295_1.var_.actorSpriteComps128404 then
					for iter_298_0, iter_298_1 in pairs(arg_295_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 and not isNil(arg_295_1.actors_["128404"]) and arg_295_1.var_.actorSpriteComps128404 then
				for iter_298_2, iter_298_3 in pairs(arg_295_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_298_3 then
						iter_298_3.color = arg_295_1.isInRecall_ and (arg_295_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_295_1.var_.actorSpriteComps128404 = nil
			end

			local var_298_2 = arg_295_1.actors_["128404"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos128404 = var_298_2.localPosition
				var_298_2.localScale = Vector3.New(1, 1, 1)

				arg_295_1:CheckSpriteTmpPos("128404", 2)

				for iter_298_4 = 0, var_298_2.childCount - 1 do
					local var_298_3 = var_298_2:GetChild(iter_298_4)

					if var_298_3.name == "split_5" or not string.find(var_298_3.name, "split") then
						var_298_3.gameObject:SetActive(true)
					else
						var_298_3.gameObject:SetActive(false)
					end
				end
			end

			local var_298_4 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_4 then
				var_298_2.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_295_1.time_ - 0) / var_298_4)
			end

			if arg_295_1.time_ >= 0 + var_298_4 and arg_295_1.time_ < 0 + var_298_4 + arg_298_0 then
				var_298_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_298_5 = 0
			local var_298_6 = 0.225

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_5 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_7 = arg_295_1:GetWordFromCfg(926091071)
				local var_298_8 = arg_295_1:FormatText(var_298_7.content)

				arg_295_1.text_.text = var_298_8

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_10 = 9 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 9)

				if (9 <= 0 and var_298_6 or var_298_6 * (utf8.len(var_298_8) / 9)) > 0 and var_298_6 < var_298_10 then
					arg_295_1.talkMaxDuration = var_298_10

					if var_298_10 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_10 + var_298_5
					end
				end

				arg_295_1.text_.text = var_298_8
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091071", "story_v_out_926091.awb") ~= 0 then
					local var_298_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091071", "story_v_out_926091.awb") / 1000

					if var_298_11 + var_298_5 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_11 + var_298_5
					end

					if var_298_7.prefab_name ~= "" and arg_295_1.actors_[var_298_7.prefab_name] ~= nil then
						local var_298_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_7.prefab_name].transform, "story_v_out_926091", "926091071", "story_v_out_926091.awb")

						arg_295_1:RecordAudio("926091071", var_298_12)
						arg_295_1:RecordAudio("926091071", var_298_12)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_926091", "926091071", "story_v_out_926091.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_926091", "926091071", "story_v_out_926091.awb")
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
				actorName = "128404",
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
	Play926091072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 926091072
		arg_299_1.duration_ = 5.7

		local var_299_0 = {
			zh = 4.566,
			ja = 5.7
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
				arg_299_0:Play926091073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(arg_299_1.actors_["104701"]) and arg_299_1.var_.actorSpriteComps104701 == nil then
				arg_299_1.var_.actorSpriteComps104701 = arg_299_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_0 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 and not isNil(arg_299_1.actors_["104701"]) then
				if arg_299_1.var_.actorSpriteComps104701 then
					for iter_302_0, iter_302_1 in pairs(arg_299_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_302_1 then
							if arg_299_1.isInRecall_ then
								iter_302_1.color = Color.New(Mathf.Lerp(iter_302_1.color.r, arg_299_1.hightColor1.r, (arg_299_1.time_ - 0) / var_302_0), Mathf.Lerp(iter_302_1.color.g, arg_299_1.hightColor1.g, (arg_299_1.time_ - 0) / var_302_0), (Mathf.Lerp(iter_302_1.color.b, arg_299_1.hightColor1.b, (arg_299_1.time_ - 0) / var_302_0)))
							else
								local var_302_1 = Mathf.Lerp(iter_302_1.color.r, 1, (arg_299_1.time_ - 0) / var_302_0)

								iter_302_1.color = Color.New(var_302_1, var_302_1, var_302_1)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 and not isNil(arg_299_1.actors_["104701"]) and arg_299_1.var_.actorSpriteComps104701 then
				for iter_302_2, iter_302_3 in pairs(arg_299_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_302_3 then
						iter_302_3.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_299_1.var_.actorSpriteComps104701 = nil
			end

			local var_302_2 = arg_299_1.actors_["128404"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps128404 == nil then
				arg_299_1.var_.actorSpriteComps128404 = var_302_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_302_3 = 0.2

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_3 and not isNil(var_302_2) then
				if arg_299_1.var_.actorSpriteComps128404 then
					for iter_302_4, iter_302_5 in pairs(arg_299_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_302_5 then
							if arg_299_1.isInRecall_ then
								iter_302_5.color = Color.New(Mathf.Lerp(iter_302_5.color.r, arg_299_1.hightColor2.r, (arg_299_1.time_ - 0) / var_302_3), Mathf.Lerp(iter_302_5.color.g, arg_299_1.hightColor2.g, (arg_299_1.time_ - 0) / var_302_3), (Mathf.Lerp(iter_302_5.color.b, arg_299_1.hightColor2.b, (arg_299_1.time_ - 0) / var_302_3)))
							else
								local var_302_4 = Mathf.Lerp(iter_302_5.color.r, 0.5, (arg_299_1.time_ - 0) / var_302_3)

								iter_302_5.color = Color.New(var_302_4, var_302_4, var_302_4)
							end
						end
					end
				end
			end

			if arg_299_1.time_ >= 0 + var_302_3 and arg_299_1.time_ < 0 + var_302_3 + arg_302_0 and not isNil(var_302_2) and arg_299_1.var_.actorSpriteComps128404 then
				for iter_302_6, iter_302_7 in pairs(arg_299_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_302_7 then
						iter_302_7.color = arg_299_1.isInRecall_ and (arg_299_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_299_1.var_.actorSpriteComps128404 = nil
			end

			local var_302_5 = arg_299_1.actors_["104701"].transform

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos104701 = var_302_5.localPosition
				var_302_5.localScale = Vector3.New(1, 1, 1)

				arg_299_1:CheckSpriteTmpPos("104701", 4)

				for iter_302_8 = 0, var_302_5.childCount - 1 do
					local var_302_6 = var_302_5:GetChild(iter_302_8)

					if var_302_6.name == "" or not string.find(var_302_6.name, "split") then
						var_302_6.gameObject:SetActive(true)
					else
						var_302_6.gameObject:SetActive(false)
					end
				end
			end

			local var_302_7 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_7 then
				var_302_5.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_299_1.time_ - 0) / var_302_7)
			end

			if arg_299_1.time_ >= 0 + var_302_7 and arg_299_1.time_ < 0 + var_302_7 + arg_302_0 then
				var_302_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_302_8 = 0
			local var_302_9 = 0.525

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_8 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				arg_299_1.leftNameTxt_.text = arg_299_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_10 = arg_299_1:GetWordFromCfg(926091072)
				local var_302_11 = arg_299_1:FormatText(var_302_10.content)

				arg_299_1.text_.text = var_302_11

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_13 = 21 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 21)

				if (21 <= 0 and var_302_9 or var_302_9 * (utf8.len(var_302_11) / 21)) > 0 and var_302_9 < var_302_13 then
					arg_299_1.talkMaxDuration = var_302_13

					if var_302_13 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_13 + var_302_8
					end
				end

				arg_299_1.text_.text = var_302_11
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091072", "story_v_out_926091.awb") ~= 0 then
					local var_302_14 = manager.audio:GetVoiceLength("story_v_out_926091", "926091072", "story_v_out_926091.awb") / 1000

					if var_302_14 + var_302_8 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_14 + var_302_8
					end

					if var_302_10.prefab_name ~= "" and arg_299_1.actors_[var_302_10.prefab_name] ~= nil then
						local var_302_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_10.prefab_name].transform, "story_v_out_926091", "926091072", "story_v_out_926091.awb")

						arg_299_1:RecordAudio("926091072", var_302_15)
						arg_299_1:RecordAudio("926091072", var_302_15)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_926091", "926091072", "story_v_out_926091.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_926091", "926091072", "story_v_out_926091.awb")
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
				actorName = "104701",
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
	Play926091073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 926091073
		arg_303_1.duration_ = 5.9

		local var_303_0 = {
			zh = 5.9,
			ja = 4.9
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
				arg_303_0:Play926091074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0.625

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				arg_303_1.leftNameTxt_.text = arg_303_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:GetWordFromCfg(926091073)
				local var_306_2 = arg_303_1:FormatText(var_306_1.content)

				arg_303_1.text_.text = var_306_2

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_4 = 25 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 25)

				if (25 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_2) / 25)) > 0 and var_306_0 < var_306_4 then
					arg_303_1.talkMaxDuration = var_306_4

					if var_306_4 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_4 + 0
					end
				end

				arg_303_1.text_.text = var_306_2
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091073", "story_v_out_926091.awb") ~= 0 then
					local var_306_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091073", "story_v_out_926091.awb") / 1000

					if var_306_5 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + 0
					end

					if var_306_1.prefab_name ~= "" and arg_303_1.actors_[var_306_1.prefab_name] ~= nil then
						local var_306_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_1.prefab_name].transform, "story_v_out_926091", "926091073", "story_v_out_926091.awb")

						arg_303_1:RecordAudio("926091073", var_306_6)
						arg_303_1:RecordAudio("926091073", var_306_6)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_926091", "926091073", "story_v_out_926091.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_926091", "926091073", "story_v_out_926091.awb")
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
	Play926091074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 926091074
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play926091075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(arg_307_1.actors_["104701"]) and arg_307_1.var_.actorSpriteComps104701 == nil then
				arg_307_1.var_.actorSpriteComps104701 = arg_307_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_310_0 = 0.2

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 and not isNil(arg_307_1.actors_["104701"]) then
				if arg_307_1.var_.actorSpriteComps104701 then
					for iter_310_0, iter_310_1 in pairs(arg_307_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_310_1 then
							if arg_307_1.isInRecall_ then
								iter_310_1.color = Color.New(Mathf.Lerp(iter_310_1.color.r, arg_307_1.hightColor2.r, (arg_307_1.time_ - 0) / var_310_0), Mathf.Lerp(iter_310_1.color.g, arg_307_1.hightColor2.g, (arg_307_1.time_ - 0) / var_310_0), (Mathf.Lerp(iter_310_1.color.b, arg_307_1.hightColor2.b, (arg_307_1.time_ - 0) / var_310_0)))
							else
								local var_310_1 = Mathf.Lerp(iter_310_1.color.r, 0.5, (arg_307_1.time_ - 0) / var_310_0)

								iter_310_1.color = Color.New(var_310_1, var_310_1, var_310_1)
							end
						end
					end
				end
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 and not isNil(arg_307_1.actors_["104701"]) and arg_307_1.var_.actorSpriteComps104701 then
				for iter_310_2, iter_310_3 in pairs(arg_307_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_310_3 then
						iter_310_3.color = arg_307_1.isInRecall_ and (arg_307_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_307_1.var_.actorSpriteComps104701 = nil
			end

			local var_310_2 = 0
			local var_310_3 = 0.25

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_2 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, true)
				arg_307_1.iconController_:SetSelectedState("hero")

				arg_307_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_307_1.callingController_:SetSelectedState("normal")

				arg_307_1.keyicon_.color = Color.New(1, 1, 1)
				arg_307_1.icon_.color = Color.New(1, 1, 1)

				local var_310_4 = arg_307_1:FormatText(arg_307_1:GetWordFromCfg(926091074).content)

				arg_307_1.text_.text = var_310_4

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_6 = 10 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 10)

				if (10 <= 0 and var_310_3 or var_310_3 * (utf8.len(var_310_4) / 10)) > 0 and var_310_3 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_2 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_2
					end
				end

				arg_307_1.text_.text = var_310_4
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_3, arg_307_1.talkMaxDuration)

			if var_310_2 <= arg_307_1.time_ and arg_307_1.time_ < var_310_2 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_2) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_2 + var_310_7 and arg_307_1.time_ < var_310_2 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play926091075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 926091075
		arg_311_1.duration_ = 4.87

		local var_311_0 = {
			zh = 4.1,
			ja = 4.866
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
				arg_311_0:Play926091076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(arg_311_1.actors_["128404"]) and arg_311_1.var_.actorSpriteComps128404 == nil then
				arg_311_1.var_.actorSpriteComps128404 = arg_311_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_314_0 = 0.2

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 and not isNil(arg_311_1.actors_["128404"]) then
				if arg_311_1.var_.actorSpriteComps128404 then
					for iter_314_0, iter_314_1 in pairs(arg_311_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 and not isNil(arg_311_1.actors_["128404"]) and arg_311_1.var_.actorSpriteComps128404 then
				for iter_314_2, iter_314_3 in pairs(arg_311_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_314_3 then
						iter_314_3.color = arg_311_1.isInRecall_ and (arg_311_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_311_1.var_.actorSpriteComps128404 = nil
			end

			local var_314_2 = arg_311_1.actors_["128404"].transform

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos128404 = var_314_2.localPosition
				var_314_2.localScale = Vector3.New(1, 1, 1)

				arg_311_1:CheckSpriteTmpPos("128404", 2)

				for iter_314_4 = 0, var_314_2.childCount - 1 do
					local var_314_3 = var_314_2:GetChild(iter_314_4)

					if var_314_3.name == "split_1" or not string.find(var_314_3.name, "split") then
						var_314_3.gameObject:SetActive(true)
					else
						var_314_3.gameObject:SetActive(false)
					end
				end
			end

			local var_314_4 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_4 then
				var_314_2.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_311_1.time_ - 0) / var_314_4)
			end

			if arg_311_1.time_ >= 0 + var_314_4 and arg_311_1.time_ < 0 + var_314_4 + arg_314_0 then
				var_314_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_314_5 = 0
			local var_314_6 = 0.6

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_5 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, true)

				arg_311_1.leftNameTxt_.text = arg_311_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_311_1.leftNameTxt_.transform)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1.leftNameTxt_.text)
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_7 = arg_311_1:GetWordFromCfg(926091075)
				local var_314_8 = arg_311_1:FormatText(var_314_7.content)

				arg_311_1.text_.text = var_314_8

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_10 = 24 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 24)

				if (24 <= 0 and var_314_6 or var_314_6 * (utf8.len(var_314_8) / 24)) > 0 and var_314_6 < var_314_10 then
					arg_311_1.talkMaxDuration = var_314_10

					if var_314_10 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_10 + var_314_5
					end
				end

				arg_311_1.text_.text = var_314_8
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091075", "story_v_out_926091.awb") ~= 0 then
					local var_314_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091075", "story_v_out_926091.awb") / 1000

					if var_314_11 + var_314_5 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_11 + var_314_5
					end

					if var_314_7.prefab_name ~= "" and arg_311_1.actors_[var_314_7.prefab_name] ~= nil then
						local var_314_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_7.prefab_name].transform, "story_v_out_926091", "926091075", "story_v_out_926091.awb")

						arg_311_1:RecordAudio("926091075", var_314_12)
						arg_311_1:RecordAudio("926091075", var_314_12)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_926091", "926091075", "story_v_out_926091.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_926091", "926091075", "story_v_out_926091.awb")
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
				actorName = "128404",
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
	Play926091076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 926091076
		arg_315_1.duration_ = 5.77

		local var_315_0 = {
			zh = 5.066,
			ja = 5.766
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
				arg_315_0:Play926091077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0.575

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_1 = arg_315_1:GetWordFromCfg(926091076)
				local var_318_2 = arg_315_1:FormatText(var_318_1.content)

				arg_315_1.text_.text = var_318_2

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_4 = 23 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 23)

				if (23 <= 0 and var_318_0 or var_318_0 * (utf8.len(var_318_2) / 23)) > 0 and var_318_0 < var_318_4 then
					arg_315_1.talkMaxDuration = var_318_4

					if var_318_4 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_4 + 0
					end
				end

				arg_315_1.text_.text = var_318_2
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091076", "story_v_out_926091.awb") ~= 0 then
					local var_318_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091076", "story_v_out_926091.awb") / 1000

					if var_318_5 + 0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_5 + 0
					end

					if var_318_1.prefab_name ~= "" and arg_315_1.actors_[var_318_1.prefab_name] ~= nil then
						local var_318_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_1.prefab_name].transform, "story_v_out_926091", "926091076", "story_v_out_926091.awb")

						arg_315_1:RecordAudio("926091076", var_318_6)
						arg_315_1:RecordAudio("926091076", var_318_6)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_926091", "926091076", "story_v_out_926091.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_926091", "926091076", "story_v_out_926091.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_7 = math.max(var_318_0, arg_315_1.talkMaxDuration)

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - 0) / var_318_7

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play926091077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 926091077
		arg_319_1.duration_ = 4.8

		local var_319_0 = {
			zh = 4.6,
			ja = 4.8
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
				arg_319_0:Play926091078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.var_.moveOldPos128404 = arg_319_1.actors_["128404"].transform.localPosition
				arg_319_1.actors_["128404"].transform.localScale = Vector3.New(1, 1, 1)

				arg_319_1:CheckSpriteTmpPos("128404", 2)

				for iter_322_0 = 0, arg_319_1.actors_["128404"].transform.childCount - 1 do
					local var_322_0 = arg_319_1.actors_["128404"].transform:GetChild(iter_322_0)

					if var_322_0.name == "split_4" or not string.find(var_322_0.name, "split") then
						var_322_0.gameObject:SetActive(true)
					else
						var_322_0.gameObject:SetActive(false)
					end
				end
			end

			local var_322_1 = 0.001

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_1 then
				arg_319_1.actors_["128404"].transform.localPosition = Vector3.Lerp(arg_319_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_319_1.time_ - 0) / var_322_1)
			end

			if arg_319_1.time_ >= 0 + var_322_1 and arg_319_1.time_ < 0 + var_322_1 + arg_322_0 then
				arg_319_1.actors_["128404"].transform.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_322_2 = 0
			local var_322_3 = 0.5

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_2 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, true)

				arg_319_1.leftNameTxt_.text = arg_319_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_319_1.leftNameTxt_.transform)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1.leftNameTxt_.text)
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_4 = arg_319_1:GetWordFromCfg(926091077)
				local var_322_5 = arg_319_1:FormatText(var_322_4.content)

				arg_319_1.text_.text = var_322_5

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_7 = 20 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 20)

				if (20 <= 0 and var_322_3 or var_322_3 * (utf8.len(var_322_5) / 20)) > 0 and var_322_3 < var_322_7 then
					arg_319_1.talkMaxDuration = var_322_7

					if var_322_7 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_7 + var_322_2
					end
				end

				arg_319_1.text_.text = var_322_5
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091077", "story_v_out_926091.awb") ~= 0 then
					local var_322_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091077", "story_v_out_926091.awb") / 1000

					if var_322_8 + var_322_2 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_8 + var_322_2
					end

					if var_322_4.prefab_name ~= "" and arg_319_1.actors_[var_322_4.prefab_name] ~= nil then
						local var_322_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_319_1.actors_[var_322_4.prefab_name].transform, "story_v_out_926091", "926091077", "story_v_out_926091.awb")

						arg_319_1:RecordAudio("926091077", var_322_9)
						arg_319_1:RecordAudio("926091077", var_322_9)
					else
						arg_319_1:AudioAction("play", "voice", "story_v_out_926091", "926091077", "story_v_out_926091.awb")
					end

					arg_319_1:RecordHistoryTalkVoice("story_v_out_926091", "926091077", "story_v_out_926091.awb")
				end

				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_10 = math.max(var_322_3, arg_319_1.talkMaxDuration)

			if var_322_2 <= arg_319_1.time_ and arg_319_1.time_ < var_322_2 + var_322_10 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_2) / var_322_10

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_2 + var_322_10 and arg_319_1.time_ < var_322_2 + var_322_10 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {
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

		arg_319_1:InitPlayNodeList()
	end,
	Play926091078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 926091078
		arg_323_1.duration_ = 5.7

		local var_323_0 = {
			zh = 3.8,
			ja = 5.7
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
				arg_323_0:Play926091079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(arg_323_1.actors_["104701"]) and arg_323_1.var_.actorSpriteComps104701 == nil then
				arg_323_1.var_.actorSpriteComps104701 = arg_323_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_0 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 and not isNil(arg_323_1.actors_["104701"]) then
				if arg_323_1.var_.actorSpriteComps104701 then
					for iter_326_0, iter_326_1 in pairs(arg_323_1.var_.actorSpriteComps104701:ToTable()) do
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

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 and not isNil(arg_323_1.actors_["104701"]) and arg_323_1.var_.actorSpriteComps104701 then
				for iter_326_2, iter_326_3 in pairs(arg_323_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_326_3 then
						iter_326_3.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_323_1.var_.actorSpriteComps104701 = nil
			end

			local var_326_2 = arg_323_1.actors_["128404"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps128404 == nil then
				arg_323_1.var_.actorSpriteComps128404 = var_326_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_326_3 = 0.2

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_3 and not isNil(var_326_2) then
				if arg_323_1.var_.actorSpriteComps128404 then
					for iter_326_4, iter_326_5 in pairs(arg_323_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_323_1.time_ >= 0 + var_326_3 and arg_323_1.time_ < 0 + var_326_3 + arg_326_0 and not isNil(var_326_2) and arg_323_1.var_.actorSpriteComps128404 then
				for iter_326_6, iter_326_7 in pairs(arg_323_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_326_7 then
						iter_326_7.color = arg_323_1.isInRecall_ and (arg_323_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_323_1.var_.actorSpriteComps128404 = nil
			end

			local var_326_5 = arg_323_1.actors_["104701"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos104701 = var_326_5.localPosition
				var_326_5.localScale = Vector3.New(1, 1, 1)

				arg_323_1:CheckSpriteTmpPos("104701", 4)

				for iter_326_8 = 0, var_326_5.childCount - 1 do
					local var_326_6 = var_326_5:GetChild(iter_326_8)

					if var_326_6.name == "" or not string.find(var_326_6.name, "split") then
						var_326_6.gameObject:SetActive(true)
					else
						var_326_6.gameObject:SetActive(false)
					end
				end
			end

			local var_326_7 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 then
				var_326_5.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos104701, Vector3.New(372.4, -386.8, -295), (arg_323_1.time_ - 0) / var_326_7)
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 then
				var_326_5.localPosition = Vector3.New(372.4, -386.8, -295)
			end

			local var_326_8 = 0
			local var_326_9 = 0.4

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_8 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_10 = arg_323_1:GetWordFromCfg(926091078)
				local var_326_11 = arg_323_1:FormatText(var_326_10.content)

				arg_323_1.text_.text = var_326_11

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_13 = 16 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 16)

				if (16 <= 0 and var_326_9 or var_326_9 * (utf8.len(var_326_11) / 16)) > 0 and var_326_9 < var_326_13 then
					arg_323_1.talkMaxDuration = var_326_13

					if var_326_13 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_13 + var_326_8
					end
				end

				arg_323_1.text_.text = var_326_11
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091078", "story_v_out_926091.awb") ~= 0 then
					local var_326_14 = manager.audio:GetVoiceLength("story_v_out_926091", "926091078", "story_v_out_926091.awb") / 1000

					if var_326_14 + var_326_8 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_14 + var_326_8
					end

					if var_326_10.prefab_name ~= "" and arg_323_1.actors_[var_326_10.prefab_name] ~= nil then
						local var_326_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_10.prefab_name].transform, "story_v_out_926091", "926091078", "story_v_out_926091.awb")

						arg_323_1:RecordAudio("926091078", var_326_15)
						arg_323_1:RecordAudio("926091078", var_326_15)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_926091", "926091078", "story_v_out_926091.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_926091", "926091078", "story_v_out_926091.awb")
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
				actorName = "104701",
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
	Play926091079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 926091079
		arg_327_1.duration_ = 4.83

		local var_327_0 = {
			zh = 4.833,
			ja = 4.766
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
				arg_327_0:Play926091080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = 0.5

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_1 = arg_327_1:GetWordFromCfg(926091079)
				local var_330_2 = arg_327_1:FormatText(var_330_1.content)

				arg_327_1.text_.text = var_330_2

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_4 = 20 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 20)

				if (20 <= 0 and var_330_0 or var_330_0 * (utf8.len(var_330_2) / 20)) > 0 and var_330_0 < var_330_4 then
					arg_327_1.talkMaxDuration = var_330_4

					if var_330_4 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_4 + 0
					end
				end

				arg_327_1.text_.text = var_330_2
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091079", "story_v_out_926091.awb") ~= 0 then
					local var_330_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091079", "story_v_out_926091.awb") / 1000

					if var_330_5 + 0 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_5 + 0
					end

					if var_330_1.prefab_name ~= "" and arg_327_1.actors_[var_330_1.prefab_name] ~= nil then
						local var_330_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_1.prefab_name].transform, "story_v_out_926091", "926091079", "story_v_out_926091.awb")

						arg_327_1:RecordAudio("926091079", var_330_6)
						arg_327_1:RecordAudio("926091079", var_330_6)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_926091", "926091079", "story_v_out_926091.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_926091", "926091079", "story_v_out_926091.awb")
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
	Play926091080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 926091080
		arg_331_1.duration_ = 1

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"

			SetActive(arg_331_1.choicesGo_, true)

			for iter_332_0, iter_332_1 in ipairs(arg_331_1.choices_) do
				SetActive(iter_332_1.go, iter_332_0 <= 2)
			end

			arg_331_1.choices_[1].txt.text = arg_331_1:FormatText(StoryChoiceCfg[1335].name)
			arg_331_1.choices_[2].txt.text = arg_331_1:FormatText(StoryChoiceCfg[1336].name)
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play926091081(arg_331_1)
			end

			if arg_333_0 == 2 then
				arg_331_0:Play926091082(arg_331_1)
			end

			arg_331_1:RecordChoiceLog(926091080, 1335, 1336)
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["104701"]) and arg_331_1.var_.actorSpriteComps104701 == nil then
				arg_331_1.var_.actorSpriteComps104701 = arg_331_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_334_0 = 0.2

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["104701"]) then
				if arg_331_1.var_.actorSpriteComps104701 then
					for iter_334_0, iter_334_1 in pairs(arg_331_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_334_1 then
							if arg_331_1.isInRecall_ then
								iter_334_1.color = Color.New(Mathf.Lerp(iter_334_1.color.r, arg_331_1.hightColor2.r, (arg_331_1.time_ - 0) / var_334_0), Mathf.Lerp(iter_334_1.color.g, arg_331_1.hightColor2.g, (arg_331_1.time_ - 0) / var_334_0), (Mathf.Lerp(iter_334_1.color.b, arg_331_1.hightColor2.b, (arg_331_1.time_ - 0) / var_334_0)))
							else
								local var_334_1 = Mathf.Lerp(iter_334_1.color.r, 0.5, (arg_331_1.time_ - 0) / var_334_0)

								iter_334_1.color = Color.New(var_334_1, var_334_1, var_334_1)
							end
						end
					end
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["104701"]) and arg_331_1.var_.actorSpriteComps104701 then
				for iter_334_2, iter_334_3 in pairs(arg_331_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_334_3 then
						iter_334_3.color = arg_331_1.isInRecall_ and (arg_331_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_331_1.var_.actorSpriteComps104701 = nil
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play926091081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 926091081
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play926091083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = 0.475

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, true)
				arg_335_1.iconController_:SetSelectedState("hero")

				arg_335_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_335_1.callingController_:SetSelectedState("normal")

				arg_335_1.keyicon_.color = Color.New(1, 1, 1)
				arg_335_1.icon_.color = Color.New(1, 1, 1)

				local var_338_1 = arg_335_1:FormatText(arg_335_1:GetWordFromCfg(926091081).content)

				arg_335_1.text_.text = var_338_1

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_3 = 19 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 19)

				if (19 <= 0 and var_338_0 or var_338_0 * (utf8.len(var_338_1) / 19)) > 0 and var_338_0 < var_338_3 then
					arg_335_1.talkMaxDuration = var_338_3

					if var_338_3 + 0 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_3 + 0
					end
				end

				arg_335_1.text_.text = var_338_1
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_4 = math.max(var_338_0, arg_335_1.talkMaxDuration)

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_4 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - 0) / var_338_4

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= 0 + var_338_4 and arg_335_1.time_ < 0 + var_338_4 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play926091083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 926091083
		arg_339_1.duration_ = 3.3

		local var_339_0 = {
			zh = 3.3,
			ja = 3.1
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
				arg_339_0:Play926091084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(arg_339_1.actors_["128404"]) and arg_339_1.var_.actorSpriteComps128404 == nil then
				arg_339_1.var_.actorSpriteComps128404 = arg_339_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_342_0 = 0.2

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 and not isNil(arg_339_1.actors_["128404"]) then
				if arg_339_1.var_.actorSpriteComps128404 then
					for iter_342_0, iter_342_1 in pairs(arg_339_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 and not isNil(arg_339_1.actors_["128404"]) and arg_339_1.var_.actorSpriteComps128404 then
				for iter_342_2, iter_342_3 in pairs(arg_339_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_342_3 then
						iter_342_3.color = arg_339_1.isInRecall_ and (arg_339_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_339_1.var_.actorSpriteComps128404 = nil
			end

			local var_342_2 = arg_339_1.actors_["128404"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos128404 = var_342_2.localPosition
				var_342_2.localScale = Vector3.New(1, 1, 1)

				arg_339_1:CheckSpriteTmpPos("128404", 2)

				for iter_342_4 = 0, var_342_2.childCount - 1 do
					local var_342_3 = var_342_2:GetChild(iter_342_4)

					if var_342_3.name == "split_2" or not string.find(var_342_3.name, "split") then
						var_342_3.gameObject:SetActive(true)
					else
						var_342_3.gameObject:SetActive(false)
					end
				end
			end

			local var_342_4 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				var_342_2.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos128404, Vector3.New(-428.5, -356, -362.3), (arg_339_1.time_ - 0) / var_342_4)
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				var_342_2.localPosition = Vector3.New(-428.5, -356, -362.3)
			end

			local var_342_5 = 0
			local var_342_6 = 0.25

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_5 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				arg_339_1.leftNameTxt_.text = arg_339_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(926091083)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_10 = 10 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 10)

				if (10 <= 0 and var_342_6 or var_342_6 * (utf8.len(var_342_8) / 10)) > 0 and var_342_6 < var_342_10 then
					arg_339_1.talkMaxDuration = var_342_10

					if var_342_10 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_10 + var_342_5
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091083", "story_v_out_926091.awb") ~= 0 then
					local var_342_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091083", "story_v_out_926091.awb") / 1000

					if var_342_11 + var_342_5 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_5
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_926091", "926091083", "story_v_out_926091.awb")

						arg_339_1:RecordAudio("926091083", var_342_12)
						arg_339_1:RecordAudio("926091083", var_342_12)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_926091", "926091083", "story_v_out_926091.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_926091", "926091083", "story_v_out_926091.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_6, arg_339_1.talkMaxDuration)

			if var_342_5 <= arg_339_1.time_ and arg_339_1.time_ < var_342_5 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_5) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_5 + var_342_13 and arg_339_1.time_ < var_342_5 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
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

		arg_339_1:InitPlayNodeList()
	end,
	Play926091084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 926091084
		arg_343_1.duration_ = 9

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play926091085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			if arg_343_1.bgs_.SP92602 == nil then
				local var_346_0 = Object.Instantiate(arg_343_1.paintGo_)

				var_346_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SP92602")
				var_346_0.name = "SP92602"
				var_346_0.transform.parent = arg_343_1.stage_.transform
				var_346_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_343_1.bgs_.SP92602 = var_346_0
			end

			if 1.96666666666667 < arg_343_1.time_ and arg_343_1.time_ <= 1.96666666666667 + arg_346_0 then
				local var_346_1 = arg_343_1.bgs_.SP92602

				arg_343_1.bgs_.SP92602.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_346_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_346_2 = var_346_1:GetComponent("SpriteRenderer")

				if var_346_2 and var_346_2.sprite then
					local var_346_3 = 2 * (var_346_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_346_1.transform.localScale = Vector3.New(var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, var_346_3 / var_346_2.sprite.bounds.size.y < var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x and var_346_3 * manager.ui.mainCameraCom_.aspect / var_346_2.sprite.bounds.size.x or var_346_3 / var_346_2.sprite.bounds.size.y, 0)
				end

				for iter_346_0, iter_346_1 in pairs(arg_343_1.bgs_) do
					if iter_346_0 ~= "SP92602" then
						iter_346_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_346_4 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_4 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_4 + 0.3 and arg_343_1.time_ < var_346_4 + 0.3 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			local var_346_5 = 0

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_5 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_6 = 2

			if var_346_5 <= arg_343_1.time_ and arg_343_1.time_ < var_346_5 + var_346_6 then
				local var_346_7 = Color.New(0, 0, 0)

				var_346_7.a = Mathf.Lerp(0, 1, (arg_343_1.time_ - var_346_5) / var_346_6)
				arg_343_1.mask_.color = var_346_7
			end

			if arg_343_1.time_ >= var_346_5 + var_346_6 and arg_343_1.time_ < var_346_5 + var_346_6 + arg_346_0 then
				local var_346_8 = Color.New(0, 0, 0)

				var_346_8.a = 1
				arg_343_1.mask_.color = var_346_8
			end

			local var_346_9 = 2

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= var_346_9 + arg_346_0 then
				arg_343_1.mask_.enabled = true
				arg_343_1.mask_.raycastTarget = true

				arg_343_1:SetGaussion(false)
			end

			local var_346_10 = 1.66666666666667

			if var_346_9 <= arg_343_1.time_ and arg_343_1.time_ < var_346_9 + var_346_10 then
				local var_346_11 = Color.New(0, 0, 0)

				var_346_11.a = Mathf.Lerp(1, 0, (arg_343_1.time_ - var_346_9) / var_346_10)
				arg_343_1.mask_.color = var_346_11
			end

			if arg_343_1.time_ >= var_346_9 + var_346_10 and arg_343_1.time_ < var_346_9 + var_346_10 + arg_346_0 then
				local var_346_12 = Color.New(0, 0, 0)

				arg_343_1.mask_.enabled = false
				var_346_12.a = 0
				arg_343_1.mask_.color = var_346_12
			end

			local var_346_13 = arg_343_1.actors_["128404"]

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 and not isNil(var_346_13) and arg_343_1.var_.actorSpriteComps128404 == nil then
				arg_343_1.var_.actorSpriteComps128404 = var_346_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_346_14 = 0.2

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_14 and not isNil(var_346_13) then
				if arg_343_1.var_.actorSpriteComps128404 then
					for iter_346_2, iter_346_3 in pairs(arg_343_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_346_3 then
							if arg_343_1.isInRecall_ then
								iter_346_3.color = Color.New(Mathf.Lerp(iter_346_3.color.r, arg_343_1.hightColor2.r, (arg_343_1.time_ - 2) / var_346_14), Mathf.Lerp(iter_346_3.color.g, arg_343_1.hightColor2.g, (arg_343_1.time_ - 2) / var_346_14), (Mathf.Lerp(iter_346_3.color.b, arg_343_1.hightColor2.b, (arg_343_1.time_ - 2) / var_346_14)))
							else
								local var_346_15 = Mathf.Lerp(iter_346_3.color.r, 0.5, (arg_343_1.time_ - 2) / var_346_14)

								iter_346_3.color = Color.New(var_346_15, var_346_15, var_346_15)
							end
						end
					end
				end
			end

			if arg_343_1.time_ >= 2 + var_346_14 and arg_343_1.time_ < 2 + var_346_14 + arg_346_0 and not isNil(var_346_13) and arg_343_1.var_.actorSpriteComps128404 then
				for iter_346_4, iter_346_5 in pairs(arg_343_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_346_5 then
						iter_346_5.color = arg_343_1.isInRecall_ and (arg_343_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_343_1.var_.actorSpriteComps128404 = nil
			end

			local var_346_16 = arg_343_1.actors_["128404"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos128404 = var_346_16.localPosition
				var_346_16.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("128404", 7)

				for iter_346_6 = 0, var_346_16.childCount - 1 do
					local var_346_17 = var_346_16:GetChild(iter_346_6)

					if var_346_17.name == "" or not string.find(var_346_17.name, "split") then
						var_346_17.gameObject:SetActive(true)
					else
						var_346_17.gameObject:SetActive(false)
					end
				end
			end

			local var_346_18 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_18 then
				var_346_16.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos128404, Vector3.New(0, -2000, 0), (arg_343_1.time_ - 2) / var_346_18)
			end

			if arg_343_1.time_ >= 2 + var_346_18 and arg_343_1.time_ < 2 + var_346_18 + arg_346_0 then
				var_346_16.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_19 = arg_343_1.actors_["104701"].transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPos104701 = var_346_19.localPosition
				var_346_19.localScale = Vector3.New(1, 1, 1)

				arg_343_1:CheckSpriteTmpPos("104701", 7)

				for iter_346_7 = 0, var_346_19.childCount - 1 do
					local var_346_20 = var_346_19:GetChild(iter_346_7)

					if var_346_20.name == "" or not string.find(var_346_20.name, "split") then
						var_346_20.gameObject:SetActive(true)
					else
						var_346_20.gameObject:SetActive(false)
					end
				end
			end

			local var_346_21 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_21 then
				var_346_19.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPos104701, Vector3.New(0, -2000, 0), (arg_343_1.time_ - 2) / var_346_21)
			end

			if arg_343_1.time_ >= 2 + var_346_21 and arg_343_1.time_ < 2 + var_346_21 + arg_346_0 then
				var_346_19.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_346_22 = arg_343_1.bgs_.SP92602.transform

			if 2 < arg_343_1.time_ and arg_343_1.time_ <= 2 + arg_346_0 then
				arg_343_1.var_.moveOldPosSP92602 = var_346_22.localPosition
			end

			local var_346_23 = 0.001

			if 2 <= arg_343_1.time_ and arg_343_1.time_ < 2 + var_346_23 then
				var_346_22.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPosSP92602, Vector3.New(0, 1, 9), (arg_343_1.time_ - 2) / var_346_23)
			end

			if arg_343_1.time_ >= 2 + var_346_23 and arg_343_1.time_ < 2 + var_346_23 + arg_346_0 then
				var_346_22.localPosition = Vector3.New(0, 1, 9)
			end

			local var_346_24 = arg_343_1.bgs_.SP92602.transform

			if 2.2 < arg_343_1.time_ and arg_343_1.time_ <= 2.2 + arg_346_0 then
				arg_343_1.var_.moveOldPosSP92602 = var_346_24.localPosition
			end

			local var_346_25 = 2.3

			if 2.2 <= arg_343_1.time_ and arg_343_1.time_ < 2.2 + var_346_25 then
				var_346_24.localPosition = Vector3.Lerp(arg_343_1.var_.moveOldPosSP92602, Vector3.New(0, 0.7, 5.77), (arg_343_1.time_ - 2.2) / var_346_25)
			end

			if arg_343_1.time_ >= 2.2 + var_346_25 and arg_343_1.time_ < 2.2 + var_346_25 + arg_346_0 then
				var_346_24.localPosition = Vector3.New(0, 0.7, 5.77)
			end

			local var_346_26 = 2.9

			if 2.9 < arg_343_1.time_ and arg_343_1.time_ <= var_346_26 + arg_346_0 then
				arg_343_1.allBtn_.enabled = false
			end

			if arg_343_1.time_ >= var_346_26 + 1.66666666666667 and arg_343_1.time_ < var_346_26 + 1.66666666666667 + arg_346_0 then
				arg_343_1.allBtn_.enabled = true
			end

			if 1.63333333333333 < arg_343_1.time_ and arg_343_1.time_ <= 1.63333333333333 + arg_346_0 then
				arg_343_1:AudioAction("play", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if 0.4 < arg_343_1.time_ and arg_343_1.time_ <= 0.4 + arg_346_0 then
				arg_343_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_drone_dark", "")
			end

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_346_31 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_31 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_31

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_31
						arg_343_1.bgmTxt2_.text = var_346_31
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 1 < arg_343_1.time_ and arg_343_1.time_ <= 1 + arg_346_0 then
				arg_343_1:AudioAction("play", "music", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern.awb")

				local var_346_34 = manager.audio:GetAudioName("bgm_activity_4_3_story_tavern", "bgm_activity_4_3_story_tavern")

				if "" ~= "" then
					if arg_343_1.bgmTxt_.text ~= var_346_34 and arg_343_1.bgmTxt_.text ~= "" then
						if arg_343_1.bgmTxt2_.text ~= "" then
							arg_343_1.bgmTxt_.text = arg_343_1.bgmTxt2_.text
						end

						arg_343_1.bgmTxt2_.text = var_346_34

						arg_343_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_343_1.bgmTxt_.text = var_346_34
						arg_343_1.bgmTxt2_.text = var_346_34
					end

					if arg_343_1.bgmTimer then
						arg_343_1.bgmTimer:Stop()

						arg_343_1.bgmTimer = nil
					end

					if arg_343_1.settingData.show_music_name == 1 then
						arg_343_1.musicController:SetSelectedState("show")
						arg_343_1.musicAnimator_:Play("open", 0, 0)

						if arg_343_1.settingData.music_time ~= 0 then
							arg_343_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_343_1.settingData.music_time), function()
								if arg_343_1 == nil or isNil(arg_343_1.bgmTxt_) then
									return
								end

								arg_343_1.musicController:SetSelectedState("hide")
								arg_343_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_343_1.frameCnt_ <= 1 then
				arg_343_1.dialog_:SetActive(false)
			end

			local var_346_35 = 4
			local var_346_36 = 0.5

			if 4 < arg_343_1.time_ and arg_343_1.time_ <= var_346_35 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0

				arg_343_1.dialog_:SetActive(true)

				arg_343_1.dialogCg_.alpha = 0

				local var_346_37 = LeanTween.value(arg_343_1.dialog_, 0, 1, 0.3)

				var_346_37:setOnUpdate(LuaHelper.FloatAction(function(arg_349_0)
					arg_343_1.dialogCg_.alpha = arg_349_0
				end))
				var_346_37:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_343_1.dialog_)
					var_346_37:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_343_1.duration_ = arg_343_1.duration_ + 0.3

				SetActive(arg_343_1.leftNameGo_, true)

				arg_343_1.leftNameTxt_.text = arg_343_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_343_1.callingController_:SetSelectedState("normal")

				arg_343_1.keyicon_.color = Color.New(1, 1, 1)
				arg_343_1.icon_.color = Color.New(1, 1, 1)

				local var_346_38 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(926091084).content)

				arg_343_1.text_.text = var_346_38

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_40 = 20 <= 0 and var_346_36 or var_346_36 * (utf8.len(var_346_38) / 20)

				if (20 <= 0 and var_346_36 or var_346_36 * (utf8.len(var_346_38) / 20)) > 0 and var_346_36 < var_346_40 then
					arg_343_1.talkMaxDuration = var_346_40
					var_346_35 = var_346_35 + 0.3

					if var_346_40 + var_346_35 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_40 + var_346_35
					end
				end

				arg_343_1.text_.text = var_346_38
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_41 = var_346_35 + 0.3
			local var_346_42 = math.max(var_346_36, arg_343_1.talkMaxDuration)

			if var_346_35 + 0.3 <= arg_343_1.time_ and arg_343_1.time_ < var_346_41 + var_346_42 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_41) / var_346_42

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_41 + var_346_42 and arg_343_1.time_ < var_346_41 + var_346_42 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "128404",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "104701",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.ActorSprite
			},
			{
				assetPath = "",
				actorName = "SP92602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP92602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.3,
				className = "StoryMoveNode",
				startTime = 2.2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_343_1:InitPlayNodeList()
	end,
	Play926091085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 926091085
		arg_351_1.duration_ = 3.03

		local var_351_0 = {
			zh = 2.7,
			ja = 3.033
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
				arg_351_0:Play926091086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(arg_351_1.actors_["128404"]) and arg_351_1.var_.actorSpriteComps128404 == nil then
				arg_351_1.var_.actorSpriteComps128404 = arg_351_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_354_0 = 0.2

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 and not isNil(arg_351_1.actors_["128404"]) then
				if arg_351_1.var_.actorSpriteComps128404 then
					for iter_354_0, iter_354_1 in pairs(arg_351_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 and not isNil(arg_351_1.actors_["128404"]) and arg_351_1.var_.actorSpriteComps128404 then
				for iter_354_2, iter_354_3 in pairs(arg_351_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_354_3 then
						iter_354_3.color = arg_351_1.isInRecall_ and (arg_351_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_351_1.var_.actorSpriteComps128404 = nil
			end

			local var_354_2 = 0
			local var_354_3 = 0.35

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_2 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				arg_351_1.leftNameTxt_.text = arg_351_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_4 = arg_351_1:GetWordFromCfg(926091085)
				local var_354_5 = arg_351_1:FormatText(var_354_4.content)

				arg_351_1.text_.text = var_354_5

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_7 = 14 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 14)

				if (14 <= 0 and var_354_3 or var_354_3 * (utf8.len(var_354_5) / 14)) > 0 and var_354_3 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_2
					end
				end

				arg_351_1.text_.text = var_354_5
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091085", "story_v_out_926091.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091085", "story_v_out_926091.awb") / 1000

					if var_354_8 + var_354_2 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_2
					end

					if var_354_4.prefab_name ~= "" and arg_351_1.actors_[var_354_4.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_4.prefab_name].transform, "story_v_out_926091", "926091085", "story_v_out_926091.awb")

						arg_351_1:RecordAudio("926091085", var_354_9)
						arg_351_1:RecordAudio("926091085", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_926091", "926091085", "story_v_out_926091.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_926091", "926091085", "story_v_out_926091.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_3, arg_351_1.talkMaxDuration)

			if var_354_2 <= arg_351_1.time_ and arg_351_1.time_ < var_354_2 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_2) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_2 + var_354_10 and arg_351_1.time_ < var_354_2 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {}

		arg_351_1:InitPlayNodeList()
	end,
	Play926091086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 926091086
		arg_355_1.duration_ = 5.3

		local var_355_0 = {
			zh = 4.433,
			ja = 5.3
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
				arg_355_0:Play926091087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if arg_355_1.actors_["10022"] == nil then
				local var_358_0 = Asset.Load("Widget/System/Story/StoryExpression/" .. "10022")

				if not isNil(var_358_0) then
					local var_358_1 = Object.Instantiate(var_358_0, arg_355_1.canvasGo_.transform)

					var_358_1.transform:SetSiblingIndex(1)

					var_358_1.name = "10022"
					var_358_1.transform.localPosition = Vector3.New(0, 100000, 0)
					arg_355_1.actors_["10022"] = var_358_1

					if arg_355_1.isInRecall_ then
						for iter_358_0, iter_358_1 in ipairs((var_358_1:GetComponentsInChildren(typeof(Image), true):ToTable())) do
							iter_358_1.color = arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)
						end
					end
				end
			end

			local var_358_2 = arg_355_1.actors_["10022"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10022 == nil then
				arg_355_1.var_.actorSpriteComps10022 = var_358_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_3 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_3 and not isNil(var_358_2) then
				if arg_355_1.var_.actorSpriteComps10022 then
					for iter_358_2, iter_358_3 in pairs(arg_355_1.var_.actorSpriteComps10022:ToTable()) do
						if iter_358_3 then
							if arg_355_1.isInRecall_ then
								iter_358_3.color = Color.New(Mathf.Lerp(iter_358_3.color.r, arg_355_1.hightColor1.r, (arg_355_1.time_ - 0) / var_358_3), Mathf.Lerp(iter_358_3.color.g, arg_355_1.hightColor1.g, (arg_355_1.time_ - 0) / var_358_3), (Mathf.Lerp(iter_358_3.color.b, arg_355_1.hightColor1.b, (arg_355_1.time_ - 0) / var_358_3)))
							else
								local var_358_4 = Mathf.Lerp(iter_358_3.color.r, 1, (arg_355_1.time_ - 0) / var_358_3)

								iter_358_3.color = Color.New(var_358_4, var_358_4, var_358_4)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_3 and arg_355_1.time_ < 0 + var_358_3 + arg_358_0 and not isNil(var_358_2) and arg_355_1.var_.actorSpriteComps10022 then
				for iter_358_4, iter_358_5 in pairs(arg_355_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_358_5 then
						iter_358_5.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_355_1.var_.actorSpriteComps10022 = nil
			end

			local var_358_5 = arg_355_1.actors_["128404"]

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps128404 == nil then
				arg_355_1.var_.actorSpriteComps128404 = var_358_5:GetComponentsInChildren(typeof(Image), true)
			end

			local var_358_6 = 0.2

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_6 and not isNil(var_358_5) then
				if arg_355_1.var_.actorSpriteComps128404 then
					for iter_358_6, iter_358_7 in pairs(arg_355_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_358_7 then
							if arg_355_1.isInRecall_ then
								iter_358_7.color = Color.New(Mathf.Lerp(iter_358_7.color.r, arg_355_1.hightColor2.r, (arg_355_1.time_ - 0) / var_358_6), Mathf.Lerp(iter_358_7.color.g, arg_355_1.hightColor2.g, (arg_355_1.time_ - 0) / var_358_6), (Mathf.Lerp(iter_358_7.color.b, arg_355_1.hightColor2.b, (arg_355_1.time_ - 0) / var_358_6)))
							else
								local var_358_7 = Mathf.Lerp(iter_358_7.color.r, 0.5, (arg_355_1.time_ - 0) / var_358_6)

								iter_358_7.color = Color.New(var_358_7, var_358_7, var_358_7)
							end
						end
					end
				end
			end

			if arg_355_1.time_ >= 0 + var_358_6 and arg_355_1.time_ < 0 + var_358_6 + arg_358_0 and not isNil(var_358_5) and arg_355_1.var_.actorSpriteComps128404 then
				for iter_358_8, iter_358_9 in pairs(arg_355_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_358_9 then
						iter_358_9.color = arg_355_1.isInRecall_ and (arg_355_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_355_1.var_.actorSpriteComps128404 = nil
			end

			local var_358_8 = 0
			local var_358_9 = 0.55

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_8 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				arg_355_1.leftNameTxt_.text = arg_355_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_10 = arg_355_1:GetWordFromCfg(926091086)
				local var_358_11 = arg_355_1:FormatText(var_358_10.content)

				arg_355_1.text_.text = var_358_11

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_13 = 22 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 22)

				if (22 <= 0 and var_358_9 or var_358_9 * (utf8.len(var_358_11) / 22)) > 0 and var_358_9 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_8
					end
				end

				arg_355_1.text_.text = var_358_11
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091086", "story_v_out_926091.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_926091", "926091086", "story_v_out_926091.awb") / 1000

					if var_358_14 + var_358_8 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_8
					end

					if var_358_10.prefab_name ~= "" and arg_355_1.actors_[var_358_10.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_10.prefab_name].transform, "story_v_out_926091", "926091086", "story_v_out_926091.awb")

						arg_355_1:RecordAudio("926091086", var_358_15)
						arg_355_1:RecordAudio("926091086", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_926091", "926091086", "story_v_out_926091.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_926091", "926091086", "story_v_out_926091.awb")
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

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play926091087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 926091087
		arg_359_1.duration_ = 3.97

		local var_359_0 = {
			zh = 2.8,
			ja = 3.966
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
				arg_359_0:Play926091088(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.375

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, true)

				arg_359_1.leftNameTxt_.text = arg_359_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_359_1.leftNameTxt_.transform)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1.leftNameTxt_.text)
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:GetWordFromCfg(926091087)
				local var_362_2 = arg_359_1:FormatText(var_362_1.content)

				arg_359_1.text_.text = var_362_2

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_4 = 15 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 15)

				if (15 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_2) / 15)) > 0 and var_362_0 < var_362_4 then
					arg_359_1.talkMaxDuration = var_362_4

					if var_362_4 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_4 + 0
					end
				end

				arg_359_1.text_.text = var_362_2
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091087", "story_v_out_926091.awb") ~= 0 then
					local var_362_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091087", "story_v_out_926091.awb") / 1000

					if var_362_5 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_5 + 0
					end

					if var_362_1.prefab_name ~= "" and arg_359_1.actors_[var_362_1.prefab_name] ~= nil then
						local var_362_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_359_1.actors_[var_362_1.prefab_name].transform, "story_v_out_926091", "926091087", "story_v_out_926091.awb")

						arg_359_1:RecordAudio("926091087", var_362_6)
						arg_359_1:RecordAudio("926091087", var_362_6)
					else
						arg_359_1:AudioAction("play", "voice", "story_v_out_926091", "926091087", "story_v_out_926091.awb")
					end

					arg_359_1:RecordHistoryTalkVoice("story_v_out_926091", "926091087", "story_v_out_926091.awb")
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
	Play926091088 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 926091088
		arg_363_1.duration_ = 3.53

		local var_363_0 = {
			zh = 2.6,
			ja = 3.533
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
				arg_363_0:Play926091089(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(arg_363_1.actors_["128404"]) and arg_363_1.var_.actorSpriteComps128404 == nil then
				arg_363_1.var_.actorSpriteComps128404 = arg_363_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_0 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_0 and not isNil(arg_363_1.actors_["128404"]) then
				if arg_363_1.var_.actorSpriteComps128404 then
					for iter_366_0, iter_366_1 in pairs(arg_363_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_363_1.time_ >= 0 + var_366_0 and arg_363_1.time_ < 0 + var_366_0 + arg_366_0 and not isNil(arg_363_1.actors_["128404"]) and arg_363_1.var_.actorSpriteComps128404 then
				for iter_366_2, iter_366_3 in pairs(arg_363_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_366_3 then
						iter_366_3.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_363_1.var_.actorSpriteComps128404 = nil
			end

			local var_366_2 = arg_363_1.actors_["10022"]

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= 0 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10022 == nil then
				arg_363_1.var_.actorSpriteComps10022 = var_366_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_366_3 = 0.2

			if 0 <= arg_363_1.time_ and arg_363_1.time_ < 0 + var_366_3 and not isNil(var_366_2) then
				if arg_363_1.var_.actorSpriteComps10022 then
					for iter_366_4, iter_366_5 in pairs(arg_363_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_363_1.time_ >= 0 + var_366_3 and arg_363_1.time_ < 0 + var_366_3 + arg_366_0 and not isNil(var_366_2) and arg_363_1.var_.actorSpriteComps10022 then
				for iter_366_6, iter_366_7 in pairs(arg_363_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_366_7 then
						iter_366_7.color = arg_363_1.isInRecall_ and (arg_363_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_363_1.var_.actorSpriteComps10022 = nil
			end

			local var_366_5 = 0
			local var_366_6 = 0.175

			if 0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_5 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				arg_363_1.leftNameTxt_.text = arg_363_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, false)
				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_7 = arg_363_1:GetWordFromCfg(926091088)
				local var_366_8 = arg_363_1:FormatText(var_366_7.content)

				arg_363_1.text_.text = var_366_8

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_10 = 7 <= 0 and var_366_6 or var_366_6 * (utf8.len(var_366_8) / 7)

				if (7 <= 0 and var_366_6 or var_366_6 * (utf8.len(var_366_8) / 7)) > 0 and var_366_6 < var_366_10 then
					arg_363_1.talkMaxDuration = var_366_10

					if var_366_10 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_10 + var_366_5
					end
				end

				arg_363_1.text_.text = var_366_8
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091088", "story_v_out_926091.awb") ~= 0 then
					local var_366_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091088", "story_v_out_926091.awb") / 1000

					if var_366_11 + var_366_5 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_11 + var_366_5
					end

					if var_366_7.prefab_name ~= "" and arg_363_1.actors_[var_366_7.prefab_name] ~= nil then
						local var_366_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_7.prefab_name].transform, "story_v_out_926091", "926091088", "story_v_out_926091.awb")

						arg_363_1:RecordAudio("926091088", var_366_12)
						arg_363_1:RecordAudio("926091088", var_366_12)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_926091", "926091088", "story_v_out_926091.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_926091", "926091088", "story_v_out_926091.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_13 = math.max(var_366_6, arg_363_1.talkMaxDuration)

			if var_366_5 <= arg_363_1.time_ and arg_363_1.time_ < var_366_5 + var_366_13 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_5) / var_366_13

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_5 + var_366_13 and arg_363_1.time_ < var_366_5 + var_366_13 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end

		arg_363_1.nodeConfigList_ = {}

		arg_363_1:InitPlayNodeList()
	end,
	Play926091089 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 926091089
		arg_367_1.duration_ = 5.7

		local var_367_0 = {
			zh = 3.666,
			ja = 5.7
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
				arg_367_0:Play926091090(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(arg_367_1.actors_["106103"]) and arg_367_1.var_.actorSpriteComps106103 == nil then
				arg_367_1.var_.actorSpriteComps106103 = arg_367_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_0 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_0 and not isNil(arg_367_1.actors_["106103"]) then
				if arg_367_1.var_.actorSpriteComps106103 then
					for iter_370_0, iter_370_1 in pairs(arg_367_1.var_.actorSpriteComps106103:ToTable()) do
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

			if arg_367_1.time_ >= 0 + var_370_0 and arg_367_1.time_ < 0 + var_370_0 + arg_370_0 and not isNil(arg_367_1.actors_["106103"]) and arg_367_1.var_.actorSpriteComps106103 then
				for iter_370_2, iter_370_3 in pairs(arg_367_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_370_3 then
						iter_370_3.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_367_1.var_.actorSpriteComps106103 = nil
			end

			local var_370_2 = arg_367_1.actors_["128404"]

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= 0 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps128404 == nil then
				arg_367_1.var_.actorSpriteComps128404 = var_370_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_370_3 = 0.2

			if 0 <= arg_367_1.time_ and arg_367_1.time_ < 0 + var_370_3 and not isNil(var_370_2) then
				if arg_367_1.var_.actorSpriteComps128404 then
					for iter_370_4, iter_370_5 in pairs(arg_367_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_367_1.time_ >= 0 + var_370_3 and arg_367_1.time_ < 0 + var_370_3 + arg_370_0 and not isNil(var_370_2) and arg_367_1.var_.actorSpriteComps128404 then
				for iter_370_6, iter_370_7 in pairs(arg_367_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_370_7 then
						iter_370_7.color = arg_367_1.isInRecall_ and (arg_367_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_367_1.var_.actorSpriteComps128404 = nil
			end

			local var_370_5 = 0
			local var_370_6 = 0.425

			if 0 < arg_367_1.time_ and arg_367_1.time_ <= var_370_5 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				arg_367_1.leftNameTxt_.text = arg_367_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:GetWordFromCfg(926091089)
				local var_370_8 = arg_367_1:FormatText(var_370_7.content)

				arg_367_1.text_.text = var_370_8

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_10 = 17 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 17)

				if (17 <= 0 and var_370_6 or var_370_6 * (utf8.len(var_370_8) / 17)) > 0 and var_370_6 < var_370_10 then
					arg_367_1.talkMaxDuration = var_370_10

					if var_370_10 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_10 + var_370_5
					end
				end

				arg_367_1.text_.text = var_370_8
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091089", "story_v_out_926091.awb") ~= 0 then
					local var_370_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091089", "story_v_out_926091.awb") / 1000

					if var_370_11 + var_370_5 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_5
					end

					if var_370_7.prefab_name ~= "" and arg_367_1.actors_[var_370_7.prefab_name] ~= nil then
						local var_370_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_7.prefab_name].transform, "story_v_out_926091", "926091089", "story_v_out_926091.awb")

						arg_367_1:RecordAudio("926091089", var_370_12)
						arg_367_1:RecordAudio("926091089", var_370_12)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_926091", "926091089", "story_v_out_926091.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_926091", "926091089", "story_v_out_926091.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_13 = math.max(var_370_6, arg_367_1.talkMaxDuration)

			if var_370_5 <= arg_367_1.time_ and arg_367_1.time_ < var_370_5 + var_370_13 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_5) / var_370_13

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_5 + var_370_13 and arg_367_1.time_ < var_370_5 + var_370_13 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end

		arg_367_1.nodeConfigList_ = {}

		arg_367_1:InitPlayNodeList()
	end,
	Play926091090 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 926091090
		arg_371_1.duration_ = 3.1

		local var_371_0 = {
			zh = 2.366666666666,
			ja = 3.1
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
				arg_371_0:Play926091091(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.allBtn_.enabled = false
			end

			if arg_371_1.time_ >= 0 + 2.36666666666667 and arg_371_1.time_ < 0 + 2.36666666666667 + arg_374_0 then
				arg_371_1.allBtn_.enabled = true
			end

			local var_374_0 = arg_371_1.bgs_.SP92602.transform

			if 0 < arg_371_1.time_ and arg_371_1.time_ <= 0 + arg_374_0 then
				arg_371_1.var_.moveOldPosSP92602 = var_374_0.localPosition
			end

			local var_374_1 = 0.001

			if 0 <= arg_371_1.time_ and arg_371_1.time_ < 0 + var_374_1 then
				var_374_0.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPosSP92602, Vector3.New(0, 0.7, 5.77), (arg_371_1.time_ - 0) / var_374_1)
			end

			if arg_371_1.time_ >= 0 + var_374_1 and arg_371_1.time_ < 0 + var_374_1 + arg_374_0 then
				var_374_0.localPosition = Vector3.New(0, 0.7, 5.77)
			end

			local var_374_2 = arg_371_1.bgs_.SP92602.transform

			if 0.15 < arg_371_1.time_ and arg_371_1.time_ <= 0.15 + arg_374_0 then
				arg_371_1.var_.moveOldPosSP92602 = var_374_2.localPosition
			end

			local var_374_3 = 2.21666666666667

			if 0.15 <= arg_371_1.time_ and arg_371_1.time_ < 0.15 + var_374_3 then
				var_374_2.localPosition = Vector3.Lerp(arg_371_1.var_.moveOldPosSP92602, Vector3.New(0, 0.18, 4.07), (arg_371_1.time_ - 0.15) / var_374_3)
			end

			if arg_371_1.time_ >= 0.15 + var_374_3 and arg_371_1.time_ < 0.15 + var_374_3 + arg_374_0 then
				var_374_2.localPosition = Vector3.New(0, 0.18, 4.07)
			end

			if arg_371_1.frameCnt_ <= 1 then
				arg_371_1.dialog_:SetActive(false)
			end

			local var_374_4 = 1
			local var_374_5 = 0.15

			if 1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_4 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0

				arg_371_1.dialog_:SetActive(true)

				arg_371_1.dialogCg_.alpha = 0

				local var_374_6 = LeanTween.value(arg_371_1.dialog_, 0, 1, 0.3)

				var_374_6:setOnUpdate(LuaHelper.FloatAction(function(arg_375_0)
					arg_371_1.dialogCg_.alpha = arg_375_0
				end))
				var_374_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_371_1.dialog_)
					var_374_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_371_1.duration_ = arg_371_1.duration_ + 0.3

				SetActive(arg_371_1.leftNameGo_, true)

				arg_371_1.leftNameTxt_.text = arg_371_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, false)
				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_7 = arg_371_1:GetWordFromCfg(926091090)
				local var_374_8 = arg_371_1:FormatText(var_374_7.content)

				arg_371_1.text_.text = var_374_8

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_10 = 6 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_8) / 6)

				if (6 <= 0 and var_374_5 or var_374_5 * (utf8.len(var_374_8) / 6)) > 0 and var_374_5 < var_374_10 then
					arg_371_1.talkMaxDuration = var_374_10
					var_374_4 = var_374_4 + 0.3

					if var_374_10 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_10 + var_374_4
					end
				end

				arg_371_1.text_.text = var_374_8
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091090", "story_v_out_926091.awb") ~= 0 then
					local var_374_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091090", "story_v_out_926091.awb") / 1000

					if var_374_11 + var_374_4 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_11 + var_374_4
					end

					if var_374_7.prefab_name ~= "" and arg_371_1.actors_[var_374_7.prefab_name] ~= nil then
						local var_374_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_7.prefab_name].transform, "story_v_out_926091", "926091090", "story_v_out_926091.awb")

						arg_371_1:RecordAudio("926091090", var_374_12)
						arg_371_1:RecordAudio("926091090", var_374_12)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_926091", "926091090", "story_v_out_926091.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_926091", "926091090", "story_v_out_926091.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_13 = var_374_4 + 0.3
			local var_374_14 = math.max(var_374_5, arg_371_1.talkMaxDuration)

			if var_374_4 + 0.3 <= arg_371_1.time_ and arg_371_1.time_ < var_374_13 + var_374_14 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_13) / var_374_14

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_13 + var_374_14 and arg_371_1.time_ < var_374_13 + var_374_14 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end

		arg_371_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SP92602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SP92602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.21666666666667,
				className = "StoryMoveNode",
				startTime = 0.15,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_371_1:InitPlayNodeList()
	end,
	Play926091091 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 926091091
		arg_377_1.duration_ = 5.97

		local var_377_0 = {
			zh = 5.966,
			ja = 3.8
		}
		local var_377_1 = manager.audio:GetLocalizationFlag()

		if var_377_0[var_377_1] ~= nil then
			arg_377_1.duration_ = var_377_0[var_377_1]
		end

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play926091092(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["104701"]) and arg_377_1.var_.actorSpriteComps104701 == nil then
				arg_377_1.var_.actorSpriteComps104701 = arg_377_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_0 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["104701"]) then
				if arg_377_1.var_.actorSpriteComps104701 then
					for iter_380_0, iter_380_1 in pairs(arg_377_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_380_1 then
							if arg_377_1.isInRecall_ then
								iter_380_1.color = Color.New(Mathf.Lerp(iter_380_1.color.r, arg_377_1.hightColor1.r, (arg_377_1.time_ - 0) / var_380_0), Mathf.Lerp(iter_380_1.color.g, arg_377_1.hightColor1.g, (arg_377_1.time_ - 0) / var_380_0), (Mathf.Lerp(iter_380_1.color.b, arg_377_1.hightColor1.b, (arg_377_1.time_ - 0) / var_380_0)))
							else
								local var_380_1 = Mathf.Lerp(iter_380_1.color.r, 1, (arg_377_1.time_ - 0) / var_380_0)

								iter_380_1.color = Color.New(var_380_1, var_380_1, var_380_1)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["104701"]) and arg_377_1.var_.actorSpriteComps104701 then
				for iter_380_2, iter_380_3 in pairs(arg_377_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_380_3 then
						iter_380_3.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_377_1.var_.actorSpriteComps104701 = nil
			end

			local var_380_2 = arg_377_1.actors_["106103"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps106103 == nil then
				arg_377_1.var_.actorSpriteComps106103 = var_380_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_380_3 = 0.2

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 and not isNil(var_380_2) then
				if arg_377_1.var_.actorSpriteComps106103 then
					for iter_380_4, iter_380_5 in pairs(arg_377_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_380_5 then
							if arg_377_1.isInRecall_ then
								iter_380_5.color = Color.New(Mathf.Lerp(iter_380_5.color.r, arg_377_1.hightColor2.r, (arg_377_1.time_ - 0) / var_380_3), Mathf.Lerp(iter_380_5.color.g, arg_377_1.hightColor2.g, (arg_377_1.time_ - 0) / var_380_3), (Mathf.Lerp(iter_380_5.color.b, arg_377_1.hightColor2.b, (arg_377_1.time_ - 0) / var_380_3)))
							else
								local var_380_4 = Mathf.Lerp(iter_380_5.color.r, 0.5, (arg_377_1.time_ - 0) / var_380_3)

								iter_380_5.color = Color.New(var_380_4, var_380_4, var_380_4)
							end
						end
					end
				end
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.actorSpriteComps106103 then
				for iter_380_6, iter_380_7 in pairs(arg_377_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_380_7 then
						iter_380_7.color = arg_377_1.isInRecall_ and (arg_377_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_377_1.var_.actorSpriteComps106103 = nil
			end

			local var_380_5 = 0
			local var_380_6 = 0.625

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_5 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_7 = arg_377_1:GetWordFromCfg(926091091)
				local var_380_8 = arg_377_1:FormatText(var_380_7.content)

				arg_377_1.text_.text = var_380_8

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_10 = 25 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 25)

				if (25 <= 0 and var_380_6 or var_380_6 * (utf8.len(var_380_8) / 25)) > 0 and var_380_6 < var_380_10 then
					arg_377_1.talkMaxDuration = var_380_10

					if var_380_10 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_10 + var_380_5
					end
				end

				arg_377_1.text_.text = var_380_8
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091091", "story_v_out_926091.awb") ~= 0 then
					local var_380_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091091", "story_v_out_926091.awb") / 1000

					if var_380_11 + var_380_5 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_11 + var_380_5
					end

					if var_380_7.prefab_name ~= "" and arg_377_1.actors_[var_380_7.prefab_name] ~= nil then
						local var_380_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_377_1.actors_[var_380_7.prefab_name].transform, "story_v_out_926091", "926091091", "story_v_out_926091.awb")

						arg_377_1:RecordAudio("926091091", var_380_12)
						arg_377_1:RecordAudio("926091091", var_380_12)
					else
						arg_377_1:AudioAction("play", "voice", "story_v_out_926091", "926091091", "story_v_out_926091.awb")
					end

					arg_377_1:RecordHistoryTalkVoice("story_v_out_926091", "926091091", "story_v_out_926091.awb")
				end

				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_13 = math.max(var_380_6, arg_377_1.talkMaxDuration)

			if var_380_5 <= arg_377_1.time_ and arg_377_1.time_ < var_380_5 + var_380_13 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_5) / var_380_13

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_5 + var_380_13 and arg_377_1.time_ < var_380_5 + var_380_13 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play926091092 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 926091092
		arg_381_1.duration_ = 4.73

		local var_381_0 = {
			zh = 2.766,
			ja = 4.733
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
				arg_381_0:Play926091093(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["128404"]) and arg_381_1.var_.actorSpriteComps128404 == nil then
				arg_381_1.var_.actorSpriteComps128404 = arg_381_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_0 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["128404"]) then
				if arg_381_1.var_.actorSpriteComps128404 then
					for iter_384_0, iter_384_1 in pairs(arg_381_1.var_.actorSpriteComps128404:ToTable()) do
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

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["128404"]) and arg_381_1.var_.actorSpriteComps128404 then
				for iter_384_2, iter_384_3 in pairs(arg_381_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_384_3 then
						iter_384_3.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_381_1.var_.actorSpriteComps128404 = nil
			end

			local var_384_2 = arg_381_1.actors_["104701"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps104701 == nil then
				arg_381_1.var_.actorSpriteComps104701 = var_384_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_384_3 = 0.2

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.actorSpriteComps104701 then
					for iter_384_4, iter_384_5 in pairs(arg_381_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_384_5 then
							if arg_381_1.isInRecall_ then
								iter_384_5.color = Color.New(Mathf.Lerp(iter_384_5.color.r, arg_381_1.hightColor2.r, (arg_381_1.time_ - 0) / var_384_3), Mathf.Lerp(iter_384_5.color.g, arg_381_1.hightColor2.g, (arg_381_1.time_ - 0) / var_384_3), (Mathf.Lerp(iter_384_5.color.b, arg_381_1.hightColor2.b, (arg_381_1.time_ - 0) / var_384_3)))
							else
								local var_384_4 = Mathf.Lerp(iter_384_5.color.r, 0.5, (arg_381_1.time_ - 0) / var_384_3)

								iter_384_5.color = Color.New(var_384_4, var_384_4, var_384_4)
							end
						end
					end
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.actorSpriteComps104701 then
				for iter_384_6, iter_384_7 in pairs(arg_381_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_384_7 then
						iter_384_7.color = arg_381_1.isInRecall_ and (arg_381_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_381_1.var_.actorSpriteComps104701 = nil
			end

			local var_384_5 = 0
			local var_384_6 = 0.325

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_5 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_7 = arg_381_1:GetWordFromCfg(926091092)
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

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091092", "story_v_out_926091.awb") ~= 0 then
					local var_384_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091092", "story_v_out_926091.awb") / 1000

					if var_384_11 + var_384_5 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_11 + var_384_5
					end

					if var_384_7.prefab_name ~= "" and arg_381_1.actors_[var_384_7.prefab_name] ~= nil then
						local var_384_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_381_1.actors_[var_384_7.prefab_name].transform, "story_v_out_926091", "926091092", "story_v_out_926091.awb")

						arg_381_1:RecordAudio("926091092", var_384_12)
						arg_381_1:RecordAudio("926091092", var_384_12)
					else
						arg_381_1:AudioAction("play", "voice", "story_v_out_926091", "926091092", "story_v_out_926091.awb")
					end

					arg_381_1:RecordHistoryTalkVoice("story_v_out_926091", "926091092", "story_v_out_926091.awb")
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

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play926091093 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 926091093
		arg_385_1.duration_ = 4.33

		local var_385_0 = {
			zh = 2.2,
			ja = 4.333
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
				arg_385_0:Play926091094(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			local var_388_0 = 0.2

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_1 = arg_385_1:GetWordFromCfg(926091093)
				local var_388_2 = arg_385_1:FormatText(var_388_1.content)

				arg_385_1.text_.text = var_388_2

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_4 = 8 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 8)

				if (8 <= 0 and var_388_0 or var_388_0 * (utf8.len(var_388_2) / 8)) > 0 and var_388_0 < var_388_4 then
					arg_385_1.talkMaxDuration = var_388_4

					if var_388_4 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_4 + 0
					end
				end

				arg_385_1.text_.text = var_388_2
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091093", "story_v_out_926091.awb") ~= 0 then
					local var_388_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091093", "story_v_out_926091.awb") / 1000

					if var_388_5 + 0 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_5 + 0
					end

					if var_388_1.prefab_name ~= "" and arg_385_1.actors_[var_388_1.prefab_name] ~= nil then
						local var_388_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_385_1.actors_[var_388_1.prefab_name].transform, "story_v_out_926091", "926091093", "story_v_out_926091.awb")

						arg_385_1:RecordAudio("926091093", var_388_6)
						arg_385_1:RecordAudio("926091093", var_388_6)
					else
						arg_385_1:AudioAction("play", "voice", "story_v_out_926091", "926091093", "story_v_out_926091.awb")
					end

					arg_385_1:RecordHistoryTalkVoice("story_v_out_926091", "926091093", "story_v_out_926091.awb")
				end

				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_7 = math.max(var_388_0, arg_385_1.talkMaxDuration)

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_7 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - 0) / var_388_7

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= 0 + var_388_7 and arg_385_1.time_ < 0 + var_388_7 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play926091094 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 926091094
		arg_389_1.duration_ = 1.13

		local var_389_0 = {
			zh = 1.133,
			ja = 0.999999999999
		}
		local var_389_1 = manager.audio:GetLocalizationFlag()

		if var_389_0[var_389_1] ~= nil then
			arg_389_1.duration_ = var_389_0[var_389_1]
		end

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play926091095(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["106103"]) and arg_389_1.var_.actorSpriteComps106103 == nil then
				arg_389_1.var_.actorSpriteComps106103 = arg_389_1.actors_["106103"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_0 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["106103"]) then
				if arg_389_1.var_.actorSpriteComps106103 then
					for iter_392_0, iter_392_1 in pairs(arg_389_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_392_1 then
							if arg_389_1.isInRecall_ then
								iter_392_1.color = Color.New(Mathf.Lerp(iter_392_1.color.r, arg_389_1.hightColor1.r, (arg_389_1.time_ - 0) / var_392_0), Mathf.Lerp(iter_392_1.color.g, arg_389_1.hightColor1.g, (arg_389_1.time_ - 0) / var_392_0), (Mathf.Lerp(iter_392_1.color.b, arg_389_1.hightColor1.b, (arg_389_1.time_ - 0) / var_392_0)))
							else
								local var_392_1 = Mathf.Lerp(iter_392_1.color.r, 1, (arg_389_1.time_ - 0) / var_392_0)

								iter_392_1.color = Color.New(var_392_1, var_392_1, var_392_1)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["106103"]) and arg_389_1.var_.actorSpriteComps106103 then
				for iter_392_2, iter_392_3 in pairs(arg_389_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_392_3 then
						iter_392_3.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_389_1.var_.actorSpriteComps106103 = nil
			end

			local var_392_2 = arg_389_1.actors_["128404"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps128404 == nil then
				arg_389_1.var_.actorSpriteComps128404 = var_392_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_392_3 = 0.2

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.actorSpriteComps128404 then
					for iter_392_4, iter_392_5 in pairs(arg_389_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_392_5 then
							if arg_389_1.isInRecall_ then
								iter_392_5.color = Color.New(Mathf.Lerp(iter_392_5.color.r, arg_389_1.hightColor2.r, (arg_389_1.time_ - 0) / var_392_3), Mathf.Lerp(iter_392_5.color.g, arg_389_1.hightColor2.g, (arg_389_1.time_ - 0) / var_392_3), (Mathf.Lerp(iter_392_5.color.b, arg_389_1.hightColor2.b, (arg_389_1.time_ - 0) / var_392_3)))
							else
								local var_392_4 = Mathf.Lerp(iter_392_5.color.r, 0.5, (arg_389_1.time_ - 0) / var_392_3)

								iter_392_5.color = Color.New(var_392_4, var_392_4, var_392_4)
							end
						end
					end
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.actorSpriteComps128404 then
				for iter_392_6, iter_392_7 in pairs(arg_389_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_392_7 then
						iter_392_7.color = arg_389_1.isInRecall_ and (arg_389_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_389_1.var_.actorSpriteComps128404 = nil
			end

			local var_392_5 = 0
			local var_392_6 = 0.075

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_5 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_7 = arg_389_1:GetWordFromCfg(926091094)
				local var_392_8 = arg_389_1:FormatText(var_392_7.content)

				arg_389_1.text_.text = var_392_8

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_10 = 3 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 3)

				if (3 <= 0 and var_392_6 or var_392_6 * (utf8.len(var_392_8) / 3)) > 0 and var_392_6 < var_392_10 then
					arg_389_1.talkMaxDuration = var_392_10

					if var_392_10 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_10 + var_392_5
					end
				end

				arg_389_1.text_.text = var_392_8
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091094", "story_v_out_926091.awb") ~= 0 then
					local var_392_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091094", "story_v_out_926091.awb") / 1000

					if var_392_11 + var_392_5 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_11 + var_392_5
					end

					if var_392_7.prefab_name ~= "" and arg_389_1.actors_[var_392_7.prefab_name] ~= nil then
						local var_392_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_389_1.actors_[var_392_7.prefab_name].transform, "story_v_out_926091", "926091094", "story_v_out_926091.awb")

						arg_389_1:RecordAudio("926091094", var_392_12)
						arg_389_1:RecordAudio("926091094", var_392_12)
					else
						arg_389_1:AudioAction("play", "voice", "story_v_out_926091", "926091094", "story_v_out_926091.awb")
					end

					arg_389_1:RecordHistoryTalkVoice("story_v_out_926091", "926091094", "story_v_out_926091.awb")
				end

				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_13 = math.max(var_392_6, arg_389_1.talkMaxDuration)

			if var_392_5 <= arg_389_1.time_ and arg_389_1.time_ < var_392_5 + var_392_13 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_5) / var_392_13

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_5 + var_392_13 and arg_389_1.time_ < var_392_5 + var_392_13 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play926091095 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 926091095
		arg_393_1.duration_ = 1.2

		local var_393_0 = {
			zh = 1.2,
			ja = 0.999999999999
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
				arg_393_0:Play926091096(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["10022"]) and arg_393_1.var_.actorSpriteComps10022 == nil then
				arg_393_1.var_.actorSpriteComps10022 = arg_393_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_0 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["10022"]) then
				if arg_393_1.var_.actorSpriteComps10022 then
					for iter_396_0, iter_396_1 in pairs(arg_393_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["10022"]) and arg_393_1.var_.actorSpriteComps10022 then
				for iter_396_2, iter_396_3 in pairs(arg_393_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_396_3 then
						iter_396_3.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_393_1.var_.actorSpriteComps10022 = nil
			end

			local var_396_2 = arg_393_1.actors_["106103"]

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps106103 == nil then
				arg_393_1.var_.actorSpriteComps106103 = var_396_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_396_3 = 0.2

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_3 and not isNil(var_396_2) then
				if arg_393_1.var_.actorSpriteComps106103 then
					for iter_396_4, iter_396_5 in pairs(arg_393_1.var_.actorSpriteComps106103:ToTable()) do
						if iter_396_5 then
							if arg_393_1.isInRecall_ then
								iter_396_5.color = Color.New(Mathf.Lerp(iter_396_5.color.r, arg_393_1.hightColor2.r, (arg_393_1.time_ - 0) / var_396_3), Mathf.Lerp(iter_396_5.color.g, arg_393_1.hightColor2.g, (arg_393_1.time_ - 0) / var_396_3), (Mathf.Lerp(iter_396_5.color.b, arg_393_1.hightColor2.b, (arg_393_1.time_ - 0) / var_396_3)))
							else
								local var_396_4 = Mathf.Lerp(iter_396_5.color.r, 0.5, (arg_393_1.time_ - 0) / var_396_3)

								iter_396_5.color = Color.New(var_396_4, var_396_4, var_396_4)
							end
						end
					end
				end
			end

			if arg_393_1.time_ >= 0 + var_396_3 and arg_393_1.time_ < 0 + var_396_3 + arg_396_0 and not isNil(var_396_2) and arg_393_1.var_.actorSpriteComps106103 then
				for iter_396_6, iter_396_7 in pairs(arg_393_1.var_.actorSpriteComps106103:ToTable()) do
					if iter_396_7 then
						iter_396_7.color = arg_393_1.isInRecall_ and (arg_393_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_393_1.var_.actorSpriteComps106103 = nil
			end

			local var_396_5 = 0
			local var_396_6 = 0.075

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_5 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, true)

				arg_393_1.leftNameTxt_.text = arg_393_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_393_1.leftNameTxt_.transform)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1.leftNameTxt_.text)
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_7 = arg_393_1:GetWordFromCfg(926091095)
				local var_396_8 = arg_393_1:FormatText(var_396_7.content)

				arg_393_1.text_.text = var_396_8

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_10 = 3 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 3)

				if (3 <= 0 and var_396_6 or var_396_6 * (utf8.len(var_396_8) / 3)) > 0 and var_396_6 < var_396_10 then
					arg_393_1.talkMaxDuration = var_396_10

					if var_396_10 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_10 + var_396_5
					end
				end

				arg_393_1.text_.text = var_396_8
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091095", "story_v_out_926091.awb") ~= 0 then
					local var_396_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091095", "story_v_out_926091.awb") / 1000

					if var_396_11 + var_396_5 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_11 + var_396_5
					end

					if var_396_7.prefab_name ~= "" and arg_393_1.actors_[var_396_7.prefab_name] ~= nil then
						local var_396_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_393_1.actors_[var_396_7.prefab_name].transform, "story_v_out_926091", "926091095", "story_v_out_926091.awb")

						arg_393_1:RecordAudio("926091095", var_396_12)
						arg_393_1:RecordAudio("926091095", var_396_12)
					else
						arg_393_1:AudioAction("play", "voice", "story_v_out_926091", "926091095", "story_v_out_926091.awb")
					end

					arg_393_1:RecordHistoryTalkVoice("story_v_out_926091", "926091095", "story_v_out_926091.awb")
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

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play926091096 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 926091096
		arg_397_1.duration_ = 3.43

		local var_397_0 = {
			zh = 3.39966666666667,
			ja = 3.43266666666667
		}
		local var_397_1 = manager.audio:GetLocalizationFlag()

		if var_397_0[var_397_1] ~= nil then
			arg_397_1.duration_ = var_397_0[var_397_1]
		end

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play926091097(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			local var_400_9000

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["10022"]) and arg_397_1.var_.actorSpriteComps10022 == nil then
				arg_397_1.var_.actorSpriteComps10022 = arg_397_1.actors_["10022"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_400_0 = 0.2

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["10022"]) then
				if arg_397_1.var_.actorSpriteComps10022 then
					for iter_400_0, iter_400_1 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
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

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["10022"]) and arg_397_1.var_.actorSpriteComps10022 then
				for iter_400_2, iter_400_3 in pairs(arg_397_1.var_.actorSpriteComps10022:ToTable()) do
					if iter_400_3 then
						iter_400_3.color = arg_397_1.isInRecall_ and (arg_397_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_397_1.var_.actorSpriteComps10022 = nil
			end

			local var_400_2 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.mask_.enabled = true
				arg_397_1.mask_.raycastTarget = true

				arg_397_1:SetGaussion(false)
			end

			local var_400_3 = 1.26666666666667

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_3 then
				local var_400_4 = Color.New(1, 1, 1)

				var_400_4.a = Mathf.Lerp(1, 0, (arg_397_1.time_ - var_400_2) / var_400_3)
				arg_397_1.mask_.color = var_400_4
			end

			if arg_397_1.time_ >= var_400_2 + var_400_3 and arg_397_1.time_ < var_400_2 + var_400_3 + arg_400_0 then
				local var_400_5 = Color.New(1, 1, 1)

				arg_397_1.mask_.enabled = false
				var_400_5.a = 0
				arg_397_1.mask_.color = var_400_5
			end

			local var_400_6 = arg_397_1.bgs_.SP92602.transform

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1.var_.moveOldPosSP92602 = var_400_6.localPosition
			end

			local var_400_7 = 0.001

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_7 then
				var_400_6.localPosition = Vector3.Lerp(arg_397_1.var_.moveOldPosSP92602, Vector3.New(0, 1, 10), (arg_397_1.time_ - 0) / var_400_7)
			end

			if arg_397_1.time_ >= 0 + var_400_7 and arg_397_1.time_ < 0 + var_400_7 + arg_400_0 then
				var_400_6.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				local var_400_8 = arg_397_1.var_.effect243

				if not arg_397_1.var_.effect243 then
					var_400_8 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_xishan"), manager.ui.mainCamera.transform)
					var_400_8.name = "243"
					arg_397_1.var_.effect243 = var_400_8
				else
					var_400_8.transform:SetParent(var_400_9000)
				end

				var_400_8.transform.localPosition = Vector3.New(0, 0, 0)
				var_400_8.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_400_10 = Mathf.Tan(12.5 * Mathf.Deg2Rad) / Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

				for iter_400_4, iter_400_5 in ipairs((var_400_8.transform:GetComponentsInChildren(typeof(Transform), true):ToTable())) do
					iter_400_5.transform.localScale = Vector3.New(iter_400_5.transform.localScale.x / var_400_10 * ((1.7777777777777777 < manager.ui.mainCameraCom_.aspect or nil) and 2 * 15 * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad) * manager.ui.mainCameraCom_.aspect / (2 * 15 * Mathf.Tan(15 * Mathf.Deg2Rad) * 1.7777777777777777)), iter_400_5.transform.localScale.y / var_400_10, iter_400_5.transform.localScale.z)
				end
			end

			local var_400_12 = 0

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_12 + arg_400_0 then
				arg_397_1.allBtn_.enabled = false
			end

			if arg_397_1.time_ >= var_400_12 + 1.841666666666 and arg_397_1.time_ < var_400_12 + 1.841666666666 + arg_400_0 then
				arg_397_1.allBtn_.enabled = true
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:AudioAction("play", "effect", "se_story_143", "se_story_143_bell04", "")
			end

			if arg_397_1.frameCnt_ <= 1 then
				arg_397_1.dialog_:SetActive(false)
			end

			local var_400_14 = 1.26666666666667
			local var_400_15 = 0.175

			if 1.26666666666667 < arg_397_1.time_ and arg_397_1.time_ <= var_400_14 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0

				arg_397_1.dialog_:SetActive(true)

				arg_397_1.dialogCg_.alpha = 0

				local var_400_16 = LeanTween.value(arg_397_1.dialog_, 0, 1, 0.3)

				var_400_16:setOnUpdate(LuaHelper.FloatAction(function(arg_401_0)
					arg_397_1.dialogCg_.alpha = arg_401_0
				end))
				var_400_16:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_397_1.dialog_)
					var_400_16:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_397_1.duration_ = arg_397_1.duration_ + 0.3

				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[330].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_17 = arg_397_1:GetWordFromCfg(926091096)
				local var_400_18 = arg_397_1:FormatText(var_400_17.content)

				arg_397_1.text_.text = var_400_18

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_20 = 7 <= 0 and var_400_15 or var_400_15 * (utf8.len(var_400_18) / 7)

				if (7 <= 0 and var_400_15 or var_400_15 * (utf8.len(var_400_18) / 7)) > 0 and var_400_15 < var_400_20 then
					arg_397_1.talkMaxDuration = var_400_20
					var_400_14 = var_400_14 + 0.3

					if var_400_20 + var_400_14 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_20 + var_400_14
					end
				end

				arg_397_1.text_.text = var_400_18
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091096", "story_v_out_926091.awb") ~= 0 then
					local var_400_21 = manager.audio:GetVoiceLength("story_v_out_926091", "926091096", "story_v_out_926091.awb") / 1000

					if var_400_21 + var_400_14 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_21 + var_400_14
					end

					if var_400_17.prefab_name ~= "" and arg_397_1.actors_[var_400_17.prefab_name] ~= nil then
						local var_400_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_397_1.actors_[var_400_17.prefab_name].transform, "story_v_out_926091", "926091096", "story_v_out_926091.awb")

						arg_397_1:RecordAudio("926091096", var_400_22)
						arg_397_1:RecordAudio("926091096", var_400_22)
					else
						arg_397_1:AudioAction("play", "voice", "story_v_out_926091", "926091096", "story_v_out_926091.awb")
					end

					arg_397_1:RecordHistoryTalkVoice("story_v_out_926091", "926091096", "story_v_out_926091.awb")
				end

				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_23 = var_400_14 + 0.3
			local var_400_24 = math.max(var_400_15, arg_397_1.talkMaxDuration)

			if var_400_14 + 0.3 <= arg_397_1.time_ and arg_397_1.time_ < var_400_23 + var_400_24 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_23) / var_400_24

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_23 + var_400_24 and arg_397_1.time_ < var_400_23 + var_400_24 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SP92602",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0333333333333332,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_397_1:InitPlayNodeList()
	end,
	Play926091097 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 926091097
		arg_403_1.duration_ = 1

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"

			SetActive(arg_403_1.choicesGo_, true)

			for iter_404_0, iter_404_1 in ipairs(arg_403_1.choices_) do
				SetActive(iter_404_1.go, iter_404_0 <= 1)
			end

			arg_403_1.choices_[1].txt.text = arg_403_1:FormatText(StoryChoiceCfg[1337].name)
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play926091098(arg_403_1)
			end

			arg_403_1:RecordChoiceLog(926091097, 1337)
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			return
		end

		arg_403_1.nodeConfigList_ = {}

		arg_403_1:InitPlayNodeList()
	end,
	Play926091098 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 926091098
		arg_407_1.duration_ = 3.23

		local var_407_0 = {
			zh = 2.6,
			ja = 3.233
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
				arg_407_0:Play926091099(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			if 0 < arg_407_1.time_ and arg_407_1.time_ <= 0 + arg_410_0 and not isNil(arg_407_1.actors_["104701"]) and arg_407_1.var_.actorSpriteComps104701 == nil then
				arg_407_1.var_.actorSpriteComps104701 = arg_407_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_410_0 = 0.2

			if 0 <= arg_407_1.time_ and arg_407_1.time_ < 0 + var_410_0 and not isNil(arg_407_1.actors_["104701"]) then
				if arg_407_1.var_.actorSpriteComps104701 then
					for iter_410_0, iter_410_1 in pairs(arg_407_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_410_1 then
							if arg_407_1.isInRecall_ then
								iter_410_1.color = Color.New(Mathf.Lerp(iter_410_1.color.r, arg_407_1.hightColor1.r, (arg_407_1.time_ - 0) / var_410_0), Mathf.Lerp(iter_410_1.color.g, arg_407_1.hightColor1.g, (arg_407_1.time_ - 0) / var_410_0), (Mathf.Lerp(iter_410_1.color.b, arg_407_1.hightColor1.b, (arg_407_1.time_ - 0) / var_410_0)))
							else
								local var_410_1 = Mathf.Lerp(iter_410_1.color.r, 1, (arg_407_1.time_ - 0) / var_410_0)

								iter_410_1.color = Color.New(var_410_1, var_410_1, var_410_1)
							end
						end
					end
				end
			end

			if arg_407_1.time_ >= 0 + var_410_0 and arg_407_1.time_ < 0 + var_410_0 + arg_410_0 and not isNil(arg_407_1.actors_["104701"]) and arg_407_1.var_.actorSpriteComps104701 then
				for iter_410_2, iter_410_3 in pairs(arg_407_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_410_3 then
						iter_410_3.color = arg_407_1.isInRecall_ and (arg_407_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_407_1.var_.actorSpriteComps104701 = nil
			end

			local var_410_2 = 0
			local var_410_3 = 0.3

			if 0 < arg_407_1.time_ and arg_407_1.time_ <= var_410_2 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				arg_407_1.leftNameTxt_.text = arg_407_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_4 = arg_407_1:GetWordFromCfg(926091098)
				local var_410_5 = arg_407_1:FormatText(var_410_4.content)

				arg_407_1.text_.text = var_410_5

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_7 = 12 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 12)

				if (12 <= 0 and var_410_3 or var_410_3 * (utf8.len(var_410_5) / 12)) > 0 and var_410_3 < var_410_7 then
					arg_407_1.talkMaxDuration = var_410_7

					if var_410_7 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_7 + var_410_2
					end
				end

				arg_407_1.text_.text = var_410_5
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091098", "story_v_out_926091.awb") ~= 0 then
					local var_410_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091098", "story_v_out_926091.awb") / 1000

					if var_410_8 + var_410_2 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_8 + var_410_2
					end

					if var_410_4.prefab_name ~= "" and arg_407_1.actors_[var_410_4.prefab_name] ~= nil then
						local var_410_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_4.prefab_name].transform, "story_v_out_926091", "926091098", "story_v_out_926091.awb")

						arg_407_1:RecordAudio("926091098", var_410_9)
						arg_407_1:RecordAudio("926091098", var_410_9)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_926091", "926091098", "story_v_out_926091.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_926091", "926091098", "story_v_out_926091.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_10 = math.max(var_410_3, arg_407_1.talkMaxDuration)

			if var_410_2 <= arg_407_1.time_ and arg_407_1.time_ < var_410_2 + var_410_10 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_2) / var_410_10

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_2 + var_410_10 and arg_407_1.time_ < var_410_2 + var_410_10 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end

		arg_407_1.nodeConfigList_ = {}

		arg_407_1:InitPlayNodeList()
	end,
	Play926091099 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 926091099
		arg_411_1.duration_ = 5

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play926091100(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			if 0 < arg_411_1.time_ and arg_411_1.time_ <= 0 + arg_414_0 and not isNil(arg_411_1.actors_["104701"]) and arg_411_1.var_.actorSpriteComps104701 == nil then
				arg_411_1.var_.actorSpriteComps104701 = arg_411_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_414_0 = 0.2

			if 0 <= arg_411_1.time_ and arg_411_1.time_ < 0 + var_414_0 and not isNil(arg_411_1.actors_["104701"]) then
				if arg_411_1.var_.actorSpriteComps104701 then
					for iter_414_0, iter_414_1 in pairs(arg_411_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_414_1 then
							if arg_411_1.isInRecall_ then
								iter_414_1.color = Color.New(Mathf.Lerp(iter_414_1.color.r, arg_411_1.hightColor2.r, (arg_411_1.time_ - 0) / var_414_0), Mathf.Lerp(iter_414_1.color.g, arg_411_1.hightColor2.g, (arg_411_1.time_ - 0) / var_414_0), (Mathf.Lerp(iter_414_1.color.b, arg_411_1.hightColor2.b, (arg_411_1.time_ - 0) / var_414_0)))
							else
								local var_414_1 = Mathf.Lerp(iter_414_1.color.r, 0.5, (arg_411_1.time_ - 0) / var_414_0)

								iter_414_1.color = Color.New(var_414_1, var_414_1, var_414_1)
							end
						end
					end
				end
			end

			if arg_411_1.time_ >= 0 + var_414_0 and arg_411_1.time_ < 0 + var_414_0 + arg_414_0 and not isNil(arg_411_1.actors_["104701"]) and arg_411_1.var_.actorSpriteComps104701 then
				for iter_414_2, iter_414_3 in pairs(arg_411_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_414_3 then
						iter_414_3.color = arg_411_1.isInRecall_ and (arg_411_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_411_1.var_.actorSpriteComps104701 = nil
			end

			local var_414_2 = 0
			local var_414_3 = 0.225

			if 0 < arg_411_1.time_ and arg_411_1.time_ <= var_414_2 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				arg_411_1.leftNameTxt_.text = arg_411_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_411_1.callingController_:SetSelectedState("normal")

				arg_411_1.keyicon_.color = Color.New(1, 1, 1)
				arg_411_1.icon_.color = Color.New(1, 1, 1)

				local var_414_4 = arg_411_1:FormatText(arg_411_1:GetWordFromCfg(926091099).content)

				arg_411_1.text_.text = var_414_4

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_6 = 9 <= 0 and var_414_3 or var_414_3 * (utf8.len(var_414_4) / 9)

				if (9 <= 0 and var_414_3 or var_414_3 * (utf8.len(var_414_4) / 9)) > 0 and var_414_3 < var_414_6 then
					arg_411_1.talkMaxDuration = var_414_6

					if var_414_6 + var_414_2 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_6 + var_414_2
					end
				end

				arg_411_1.text_.text = var_414_4
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)
				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_7 = math.max(var_414_3, arg_411_1.talkMaxDuration)

			if var_414_2 <= arg_411_1.time_ and arg_411_1.time_ < var_414_2 + var_414_7 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_2) / var_414_7

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_2 + var_414_7 and arg_411_1.time_ < var_414_2 + var_414_7 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end

		arg_411_1.nodeConfigList_ = {}

		arg_411_1:InitPlayNodeList()
	end,
	Play926091100 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 926091100
		arg_415_1.duration_ = 5

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play926091101(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = 0.4

			if 0 < arg_415_1.time_ and arg_415_1.time_ <= 0 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				arg_415_1.leftNameTxt_.text = arg_415_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, true)
				arg_415_1.iconController_:SetSelectedState("hero")

				arg_415_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_415_1.callingController_:SetSelectedState("normal")

				arg_415_1.keyicon_.color = Color.New(1, 1, 1)
				arg_415_1.icon_.color = Color.New(1, 1, 1)

				local var_418_1 = arg_415_1:FormatText(arg_415_1:GetWordFromCfg(926091100).content)

				arg_415_1.text_.text = var_418_1

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_3 = 16 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 16)

				if (16 <= 0 and var_418_0 or var_418_0 * (utf8.len(var_418_1) / 16)) > 0 and var_418_0 < var_418_3 then
					arg_415_1.talkMaxDuration = var_418_3

					if var_418_3 + 0 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_3 + 0
					end
				end

				arg_415_1.text_.text = var_418_1
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)
				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_4 = math.max(var_418_0, arg_415_1.talkMaxDuration)

			if 0 <= arg_415_1.time_ and arg_415_1.time_ < 0 + var_418_4 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - 0) / var_418_4

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= 0 + var_418_4 and arg_415_1.time_ < 0 + var_418_4 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end

		arg_415_1.nodeConfigList_ = {}

		arg_415_1:InitPlayNodeList()
	end,
	Play926091101 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 926091101
		arg_419_1.duration_ = 3.33

		local var_419_0 = {
			zh = 2.966,
			ja = 3.333
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
				arg_419_0:Play926091102(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			if 0 < arg_419_1.time_ and arg_419_1.time_ <= 0 + arg_422_0 and not isNil(arg_419_1.actors_["128404"]) and arg_419_1.var_.actorSpriteComps128404 == nil then
				arg_419_1.var_.actorSpriteComps128404 = arg_419_1.actors_["128404"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_422_0 = 0.2

			if 0 <= arg_419_1.time_ and arg_419_1.time_ < 0 + var_422_0 and not isNil(arg_419_1.actors_["128404"]) then
				if arg_419_1.var_.actorSpriteComps128404 then
					for iter_422_0, iter_422_1 in pairs(arg_419_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_422_1 then
							if arg_419_1.isInRecall_ then
								iter_422_1.color = Color.New(Mathf.Lerp(iter_422_1.color.r, arg_419_1.hightColor1.r, (arg_419_1.time_ - 0) / var_422_0), Mathf.Lerp(iter_422_1.color.g, arg_419_1.hightColor1.g, (arg_419_1.time_ - 0) / var_422_0), (Mathf.Lerp(iter_422_1.color.b, arg_419_1.hightColor1.b, (arg_419_1.time_ - 0) / var_422_0)))
							else
								local var_422_1 = Mathf.Lerp(iter_422_1.color.r, 1, (arg_419_1.time_ - 0) / var_422_0)

								iter_422_1.color = Color.New(var_422_1, var_422_1, var_422_1)
							end
						end
					end
				end
			end

			if arg_419_1.time_ >= 0 + var_422_0 and arg_419_1.time_ < 0 + var_422_0 + arg_422_0 and not isNil(arg_419_1.actors_["128404"]) and arg_419_1.var_.actorSpriteComps128404 then
				for iter_422_2, iter_422_3 in pairs(arg_419_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_422_3 then
						iter_422_3.color = arg_419_1.isInRecall_ and (arg_419_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_419_1.var_.actorSpriteComps128404 = nil
			end

			local var_422_2 = 0
			local var_422_3 = 0.4

			if 0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_2 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				arg_419_1.leftNameTxt_.text = arg_419_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_4 = arg_419_1:GetWordFromCfg(926091101)
				local var_422_5 = arg_419_1:FormatText(var_422_4.content)

				arg_419_1.text_.text = var_422_5

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_7 = 16 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 16)

				if (16 <= 0 and var_422_3 or var_422_3 * (utf8.len(var_422_5) / 16)) > 0 and var_422_3 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_2
					end
				end

				arg_419_1.text_.text = var_422_5
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091101", "story_v_out_926091.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091101", "story_v_out_926091.awb") / 1000

					if var_422_8 + var_422_2 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_2
					end

					if var_422_4.prefab_name ~= "" and arg_419_1.actors_[var_422_4.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_4.prefab_name].transform, "story_v_out_926091", "926091101", "story_v_out_926091.awb")

						arg_419_1:RecordAudio("926091101", var_422_9)
						arg_419_1:RecordAudio("926091101", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_926091", "926091101", "story_v_out_926091.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_926091", "926091101", "story_v_out_926091.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_3, arg_419_1.talkMaxDuration)

			if var_422_2 <= arg_419_1.time_ and arg_419_1.time_ < var_422_2 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_2) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_2 + var_422_10 and arg_419_1.time_ < var_422_2 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end

		arg_419_1.nodeConfigList_ = {}

		arg_419_1:InitPlayNodeList()
	end,
	Play926091102 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 926091102
		arg_423_1.duration_ = 2

		local var_423_0 = {
			zh = 1.066,
			ja = 2
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
				arg_423_0:Play926091103(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(arg_423_1.actors_["104701"]) and arg_423_1.var_.actorSpriteComps104701 == nil then
				arg_423_1.var_.actorSpriteComps104701 = arg_423_1.actors_["104701"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_0 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_0 and not isNil(arg_423_1.actors_["104701"]) then
				if arg_423_1.var_.actorSpriteComps104701 then
					for iter_426_0, iter_426_1 in pairs(arg_423_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_426_1 then
							if arg_423_1.isInRecall_ then
								iter_426_1.color = Color.New(Mathf.Lerp(iter_426_1.color.r, arg_423_1.hightColor1.r, (arg_423_1.time_ - 0) / var_426_0), Mathf.Lerp(iter_426_1.color.g, arg_423_1.hightColor1.g, (arg_423_1.time_ - 0) / var_426_0), (Mathf.Lerp(iter_426_1.color.b, arg_423_1.hightColor1.b, (arg_423_1.time_ - 0) / var_426_0)))
							else
								local var_426_1 = Mathf.Lerp(iter_426_1.color.r, 1, (arg_423_1.time_ - 0) / var_426_0)

								iter_426_1.color = Color.New(var_426_1, var_426_1, var_426_1)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_0 and arg_423_1.time_ < 0 + var_426_0 + arg_426_0 and not isNil(arg_423_1.actors_["104701"]) and arg_423_1.var_.actorSpriteComps104701 then
				for iter_426_2, iter_426_3 in pairs(arg_423_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_426_3 then
						iter_426_3.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_423_1.var_.actorSpriteComps104701 = nil
			end

			local var_426_2 = arg_423_1.actors_["128404"]

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= 0 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.actorSpriteComps128404 == nil then
				arg_423_1.var_.actorSpriteComps128404 = var_426_2:GetComponentsInChildren(typeof(Image), true)
			end

			local var_426_3 = 0.2

			if 0 <= arg_423_1.time_ and arg_423_1.time_ < 0 + var_426_3 and not isNil(var_426_2) then
				if arg_423_1.var_.actorSpriteComps128404 then
					for iter_426_4, iter_426_5 in pairs(arg_423_1.var_.actorSpriteComps128404:ToTable()) do
						if iter_426_5 then
							if arg_423_1.isInRecall_ then
								iter_426_5.color = Color.New(Mathf.Lerp(iter_426_5.color.r, arg_423_1.hightColor2.r, (arg_423_1.time_ - 0) / var_426_3), Mathf.Lerp(iter_426_5.color.g, arg_423_1.hightColor2.g, (arg_423_1.time_ - 0) / var_426_3), (Mathf.Lerp(iter_426_5.color.b, arg_423_1.hightColor2.b, (arg_423_1.time_ - 0) / var_426_3)))
							else
								local var_426_4 = Mathf.Lerp(iter_426_5.color.r, 0.5, (arg_423_1.time_ - 0) / var_426_3)

								iter_426_5.color = Color.New(var_426_4, var_426_4, var_426_4)
							end
						end
					end
				end
			end

			if arg_423_1.time_ >= 0 + var_426_3 and arg_423_1.time_ < 0 + var_426_3 + arg_426_0 and not isNil(var_426_2) and arg_423_1.var_.actorSpriteComps128404 then
				for iter_426_6, iter_426_7 in pairs(arg_423_1.var_.actorSpriteComps128404:ToTable()) do
					if iter_426_7 then
						iter_426_7.color = arg_423_1.isInRecall_ and (arg_423_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_423_1.var_.actorSpriteComps128404 = nil
			end

			local var_426_5 = 0
			local var_426_6 = 0.075

			if 0 < arg_423_1.time_ and arg_423_1.time_ <= var_426_5 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, true)

				arg_423_1.leftNameTxt_.text = arg_423_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_423_1.leftNameTxt_.transform)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1.leftNameTxt_.text)
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_7 = arg_423_1:GetWordFromCfg(926091102)
				local var_426_8 = arg_423_1:FormatText(var_426_7.content)

				arg_423_1.text_.text = var_426_8

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_10 = 3 <= 0 and var_426_6 or var_426_6 * (utf8.len(var_426_8) / 3)

				if (3 <= 0 and var_426_6 or var_426_6 * (utf8.len(var_426_8) / 3)) > 0 and var_426_6 < var_426_10 then
					arg_423_1.talkMaxDuration = var_426_10

					if var_426_10 + var_426_5 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_10 + var_426_5
					end
				end

				arg_423_1.text_.text = var_426_8
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091102", "story_v_out_926091.awb") ~= 0 then
					local var_426_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091102", "story_v_out_926091.awb") / 1000

					if var_426_11 + var_426_5 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_11 + var_426_5
					end

					if var_426_7.prefab_name ~= "" and arg_423_1.actors_[var_426_7.prefab_name] ~= nil then
						local var_426_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_423_1.actors_[var_426_7.prefab_name].transform, "story_v_out_926091", "926091102", "story_v_out_926091.awb")

						arg_423_1:RecordAudio("926091102", var_426_12)
						arg_423_1:RecordAudio("926091102", var_426_12)
					else
						arg_423_1:AudioAction("play", "voice", "story_v_out_926091", "926091102", "story_v_out_926091.awb")
					end

					arg_423_1:RecordHistoryTalkVoice("story_v_out_926091", "926091102", "story_v_out_926091.awb")
				end

				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_13 = math.max(var_426_6, arg_423_1.talkMaxDuration)

			if var_426_5 <= arg_423_1.time_ and arg_423_1.time_ < var_426_5 + var_426_13 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_5) / var_426_13

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_5 + var_426_13 and arg_423_1.time_ < var_426_5 + var_426_13 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end

		arg_423_1.nodeConfigList_ = {}

		arg_423_1:InitPlayNodeList()
	end,
	Play926091103 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 926091103
		arg_427_1.duration_ = 8.7

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play926091104(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			if arg_427_1.bgs_.ST0108a == nil then
				local var_430_0 = Object.Instantiate(arg_427_1.paintGo_)

				var_430_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST0108a")
				var_430_0.name = "ST0108a"
				var_430_0.transform.parent = arg_427_1.stage_.transform
				var_430_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_427_1.bgs_.ST0108a = var_430_0
			end

			if 2 < arg_427_1.time_ and arg_427_1.time_ <= 2 + arg_430_0 then
				local var_430_1 = arg_427_1.bgs_.ST0108a

				arg_427_1.bgs_.ST0108a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_430_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_430_2 = var_430_1:GetComponent("SpriteRenderer")

				if var_430_2 and var_430_2.sprite then
					local var_430_3 = 2 * (var_430_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_430_1.transform.localScale = Vector3.New(var_430_3 / var_430_2.sprite.bounds.size.y < var_430_3 * manager.ui.mainCameraCom_.aspect / var_430_2.sprite.bounds.size.x and var_430_3 * manager.ui.mainCameraCom_.aspect / var_430_2.sprite.bounds.size.x or var_430_3 / var_430_2.sprite.bounds.size.y, var_430_3 / var_430_2.sprite.bounds.size.y < var_430_3 * manager.ui.mainCameraCom_.aspect / var_430_2.sprite.bounds.size.x and var_430_3 * manager.ui.mainCameraCom_.aspect / var_430_2.sprite.bounds.size.x or var_430_3 / var_430_2.sprite.bounds.size.y, 0)
				end

				for iter_430_0, iter_430_1 in pairs(arg_427_1.bgs_) do
					if iter_430_0 ~= "ST0108a" then
						iter_430_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_430_4 = 0

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1.allBtn_.enabled = false
			end

			if arg_427_1.time_ >= var_430_4 + 0.3 and arg_427_1.time_ < var_430_4 + 0.3 + arg_430_0 then
				arg_427_1.allBtn_.enabled = true
			end

			local var_430_5 = 0

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1.mask_.enabled = true
				arg_427_1.mask_.raycastTarget = true

				arg_427_1:SetGaussion(false)
			end

			local var_430_6 = 2

			if var_430_5 <= arg_427_1.time_ and arg_427_1.time_ < var_430_5 + var_430_6 then
				local var_430_7 = Color.New(0, 0, 0)

				var_430_7.a = Mathf.Lerp(0, 1, (arg_427_1.time_ - var_430_5) / var_430_6)
				arg_427_1.mask_.color = var_430_7
			end

			if arg_427_1.time_ >= var_430_5 + var_430_6 and arg_427_1.time_ < var_430_5 + var_430_6 + arg_430_0 then
				local var_430_8 = Color.New(0, 0, 0)

				var_430_8.a = 1
				arg_427_1.mask_.color = var_430_8
			end

			local var_430_9 = 2

			if 2 < arg_427_1.time_ and arg_427_1.time_ <= var_430_9 + arg_430_0 then
				arg_427_1.mask_.enabled = true
				arg_427_1.mask_.raycastTarget = true

				arg_427_1:SetGaussion(false)
			end

			local var_430_10 = 2

			if var_430_9 <= arg_427_1.time_ and arg_427_1.time_ < var_430_9 + var_430_10 then
				local var_430_11 = Color.New(0, 0, 0)

				var_430_11.a = Mathf.Lerp(1, 0, (arg_427_1.time_ - var_430_9) / var_430_10)
				arg_427_1.mask_.color = var_430_11
			end

			if arg_427_1.time_ >= var_430_9 + var_430_10 and arg_427_1.time_ < var_430_9 + var_430_10 + arg_430_0 then
				local var_430_12 = Color.New(0, 0, 0)

				arg_427_1.mask_.enabled = false
				var_430_12.a = 0
				arg_427_1.mask_.color = var_430_12
			end

			local var_430_13 = arg_427_1.actors_["104701"]

			if 0 < arg_427_1.time_ and arg_427_1.time_ <= 0 + arg_430_0 and not isNil(var_430_13) and arg_427_1.var_.actorSpriteComps104701 == nil then
				arg_427_1.var_.actorSpriteComps104701 = var_430_13:GetComponentsInChildren(typeof(Image), true)
			end

			local var_430_14 = 0.2

			if 0 <= arg_427_1.time_ and arg_427_1.time_ < 0 + var_430_14 and not isNil(var_430_13) then
				if arg_427_1.var_.actorSpriteComps104701 then
					for iter_430_2, iter_430_3 in pairs(arg_427_1.var_.actorSpriteComps104701:ToTable()) do
						if iter_430_3 then
							if arg_427_1.isInRecall_ then
								iter_430_3.color = Color.New(Mathf.Lerp(iter_430_3.color.r, arg_427_1.hightColor2.r, (arg_427_1.time_ - 0) / var_430_14), Mathf.Lerp(iter_430_3.color.g, arg_427_1.hightColor2.g, (arg_427_1.time_ - 0) / var_430_14), (Mathf.Lerp(iter_430_3.color.b, arg_427_1.hightColor2.b, (arg_427_1.time_ - 0) / var_430_14)))
							else
								local var_430_15 = Mathf.Lerp(iter_430_3.color.r, 0.5, (arg_427_1.time_ - 0) / var_430_14)

								iter_430_3.color = Color.New(var_430_15, var_430_15, var_430_15)
							end
						end
					end
				end
			end

			if arg_427_1.time_ >= 0 + var_430_14 and arg_427_1.time_ < 0 + var_430_14 + arg_430_0 and not isNil(var_430_13) and arg_427_1.var_.actorSpriteComps104701 then
				for iter_430_4, iter_430_5 in pairs(arg_427_1.var_.actorSpriteComps104701:ToTable()) do
					if iter_430_5 then
						iter_430_5.color = arg_427_1.isInRecall_ and (arg_427_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_427_1.var_.actorSpriteComps104701 = nil
			end

			if 2 < arg_427_1.time_ and arg_427_1.time_ <= 2 + arg_430_0 then
				if arg_427_1.var_.effect243 then
					Object.Destroy(arg_427_1.var_.effect243)

					arg_427_1.var_.effect243 = nil
				end
			end

			if 0.166666666666667 < arg_427_1.time_ and arg_427_1.time_ <= 0.166666666666667 + arg_430_0 then
				arg_427_1:AudioAction("stop", "effect", "se_story_140", "se_story_140_amb_chinese restaurant", "")
			end

			if 1.56666666666667 < arg_427_1.time_ and arg_427_1.time_ <= 1.56666666666667 + arg_430_0 then
				arg_427_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_town", "")
			end

			if 3.16666666666667 < arg_427_1.time_ and arg_427_1.time_ <= 3.16666666666667 + arg_430_0 then
				arg_427_1:AudioAction("play", "effect", "se_story_143", "se_story_143_door02", "")
			end

			if arg_427_1.frameCnt_ <= 1 then
				arg_427_1.dialog_:SetActive(false)
			end

			local var_430_20 = 3.7
			local var_430_21 = 0.3

			if 3.7 < arg_427_1.time_ and arg_427_1.time_ <= var_430_20 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0

				arg_427_1.dialog_:SetActive(true)

				arg_427_1.dialogCg_.alpha = 0

				local var_430_22 = LeanTween.value(arg_427_1.dialog_, 0, 1, 0.3)

				var_430_22:setOnUpdate(LuaHelper.FloatAction(function(arg_431_0)
					arg_427_1.dialogCg_.alpha = arg_431_0
				end))
				var_430_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_427_1.dialog_)
					var_430_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_427_1.duration_ = arg_427_1.duration_ + 0.3

				SetActive(arg_427_1.leftNameGo_, true)

				arg_427_1.leftNameTxt_.text = arg_427_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, true)
				arg_427_1.iconController_:SetSelectedState("hero")

				arg_427_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_427_1.callingController_:SetSelectedState("normal")

				arg_427_1.keyicon_.color = Color.New(1, 1, 1)
				arg_427_1.icon_.color = Color.New(1, 1, 1)

				local var_430_23 = arg_427_1:FormatText(arg_427_1:GetWordFromCfg(926091103).content)

				arg_427_1.text_.text = var_430_23

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_25 = 12 <= 0 and var_430_21 or var_430_21 * (utf8.len(var_430_23) / 12)

				if (12 <= 0 and var_430_21 or var_430_21 * (utf8.len(var_430_23) / 12)) > 0 and var_430_21 < var_430_25 then
					arg_427_1.talkMaxDuration = var_430_25
					var_430_20 = var_430_20 + 0.3

					if var_430_25 + var_430_20 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_25 + var_430_20
					end
				end

				arg_427_1.text_.text = var_430_23
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)
				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_26 = var_430_20 + 0.3
			local var_430_27 = math.max(var_430_21, arg_427_1.talkMaxDuration)

			if var_430_20 + 0.3 <= arg_427_1.time_ and arg_427_1.time_ < var_430_26 + var_430_27 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_26) / var_430_27

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_26 + var_430_27 and arg_427_1.time_ < var_430_26 + var_430_27 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end

		arg_427_1.nodeConfigList_ = {}

		arg_427_1:InitPlayNodeList()
	end,
	Play926091104 = function(arg_433_0, arg_433_1)
		arg_433_1.time_ = 0
		arg_433_1.frameCnt_ = 0
		arg_433_1.state_ = "playing"
		arg_433_1.curTalkId_ = 926091104
		arg_433_1.duration_ = 5

		SetActive(arg_433_1.tipsGo_, false)

		function arg_433_1.onSingleLineFinish_()
			arg_433_1.onSingleLineUpdate_ = nil
			arg_433_1.onSingleLineFinish_ = nil
			arg_433_1.state_ = "waiting"
		end

		function arg_433_1.playNext_(arg_435_0)
			if arg_435_0 == 1 then
				arg_433_0:Play926091105(arg_433_1)
			end
		end

		function arg_433_1.onSingleLineUpdate_(arg_436_0)
			if 0.2 < arg_433_1.time_ and arg_433_1.time_ <= 0.2 + arg_436_0 then
				arg_433_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_walk02", "")
			end

			local var_436_1 = 0
			local var_436_2 = 0.75

			if 0 < arg_433_1.time_ and arg_433_1.time_ <= var_436_1 + arg_436_0 then
				arg_433_1.talkMaxDuration = 0
				arg_433_1.dialogCg_.alpha = 1

				arg_433_1.dialog_:SetActive(true)
				SetActive(arg_433_1.leftNameGo_, false)

				arg_433_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_433_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_433_1:RecordName(arg_433_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_433_1.iconTrs_.gameObject, false)
				arg_433_1.callingController_:SetSelectedState("normal")

				local var_436_3 = arg_433_1:FormatText(arg_433_1:GetWordFromCfg(926091104).content)

				arg_433_1.text_.text = var_436_3

				LuaForUtil.ClearLinePrefixSymbol(arg_433_1.text_)

				local var_436_5 = 30 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 30)

				if (30 <= 0 and var_436_2 or var_436_2 * (utf8.len(var_436_3) / 30)) > 0 and var_436_2 < var_436_5 then
					arg_433_1.talkMaxDuration = var_436_5

					if var_436_5 + var_436_1 > arg_433_1.duration_ then
						arg_433_1.duration_ = var_436_5 + var_436_1
					end
				end

				arg_433_1.text_.text = var_436_3
				arg_433_1.typewritter.percent = 0

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(false)
				arg_433_1:RecordContent(arg_433_1.text_.text)
			end

			local var_436_6 = math.max(var_436_2, arg_433_1.talkMaxDuration)

			if var_436_1 <= arg_433_1.time_ and arg_433_1.time_ < var_436_1 + var_436_6 then
				arg_433_1.typewritter.percent = (arg_433_1.time_ - var_436_1) / var_436_6

				arg_433_1.typewritter:SetDirty()
			end

			if arg_433_1.time_ >= var_436_1 + var_436_6 and arg_433_1.time_ < var_436_1 + var_436_6 + arg_436_0 then
				arg_433_1.typewritter.percent = 1

				arg_433_1.typewritter:SetDirty()
				arg_433_1:ShowNextGo(true)
			end
		end

		arg_433_1.nodeConfigList_ = {}

		arg_433_1:InitPlayNodeList()
	end,
	Play926091105 = function(arg_437_0, arg_437_1)
		arg_437_1.time_ = 0
		arg_437_1.frameCnt_ = 0
		arg_437_1.state_ = "playing"
		arg_437_1.curTalkId_ = 926091105
		arg_437_1.duration_ = 2.93

		local var_437_0 = {
			zh = 1.8,
			ja = 2.933
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
				arg_437_0:Play926091106(arg_437_1)
			end
		end

		function arg_437_1.onSingleLineUpdate_(arg_440_0)
			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 and not isNil(arg_437_1.actors_["10144"]) and arg_437_1.var_.actorSpriteComps10144 == nil then
				arg_437_1.var_.actorSpriteComps10144 = arg_437_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_440_0 = 0.2

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_0 and not isNil(arg_437_1.actors_["10144"]) then
				if arg_437_1.var_.actorSpriteComps10144 then
					for iter_440_0, iter_440_1 in pairs(arg_437_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_440_1 then
							if arg_437_1.isInRecall_ then
								iter_440_1.color = Color.New(Mathf.Lerp(iter_440_1.color.r, arg_437_1.hightColor1.r, (arg_437_1.time_ - 0) / var_440_0), Mathf.Lerp(iter_440_1.color.g, arg_437_1.hightColor1.g, (arg_437_1.time_ - 0) / var_440_0), (Mathf.Lerp(iter_440_1.color.b, arg_437_1.hightColor1.b, (arg_437_1.time_ - 0) / var_440_0)))
							else
								local var_440_1 = Mathf.Lerp(iter_440_1.color.r, 1, (arg_437_1.time_ - 0) / var_440_0)

								iter_440_1.color = Color.New(var_440_1, var_440_1, var_440_1)
							end
						end
					end
				end
			end

			if arg_437_1.time_ >= 0 + var_440_0 and arg_437_1.time_ < 0 + var_440_0 + arg_440_0 and not isNil(arg_437_1.actors_["10144"]) and arg_437_1.var_.actorSpriteComps10144 then
				for iter_440_2, iter_440_3 in pairs(arg_437_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_440_3 then
						iter_440_3.color = arg_437_1.isInRecall_ and (arg_437_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_437_1.var_.actorSpriteComps10144 = nil
			end

			local var_440_2 = arg_437_1.actors_["10144"].transform

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= 0 + arg_440_0 then
				arg_437_1.var_.moveOldPos10144 = var_440_2.localPosition
				var_440_2.localScale = Vector3.New(1, 1, 1)

				arg_437_1:CheckSpriteTmpPos("10144", 3)

				for iter_440_4 = 0, var_440_2.childCount - 1 do
					local var_440_3 = var_440_2:GetChild(iter_440_4)

					if var_440_3.name == "" or not string.find(var_440_3.name, "split") then
						var_440_3.gameObject:SetActive(true)
					else
						var_440_3.gameObject:SetActive(false)
					end
				end
			end

			local var_440_4 = 0.001

			if 0 <= arg_437_1.time_ and arg_437_1.time_ < 0 + var_440_4 then
				var_440_2.localPosition = Vector3.Lerp(arg_437_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_437_1.time_ - 0) / var_440_4)
			end

			if arg_437_1.time_ >= 0 + var_440_4 and arg_437_1.time_ < 0 + var_440_4 + arg_440_0 then
				var_440_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_440_5 = 0
			local var_440_6 = 0.175

			if 0 < arg_437_1.time_ and arg_437_1.time_ <= var_440_5 + arg_440_0 then
				arg_437_1.talkMaxDuration = 0
				arg_437_1.dialogCg_.alpha = 1

				arg_437_1.dialog_:SetActive(true)
				SetActive(arg_437_1.leftNameGo_, true)

				arg_437_1.leftNameTxt_.text = arg_437_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_437_1.leftNameTxt_.transform)

				arg_437_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_437_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_437_1:RecordName(arg_437_1.leftNameTxt_.text)
				SetActive(arg_437_1.iconTrs_.gameObject, false)
				arg_437_1.callingController_:SetSelectedState("normal")

				local var_440_7 = arg_437_1:GetWordFromCfg(926091105)
				local var_440_8 = arg_437_1:FormatText(var_440_7.content)

				arg_437_1.text_.text = var_440_8

				LuaForUtil.ClearLinePrefixSymbol(arg_437_1.text_)

				local var_440_10 = 7 <= 0 and var_440_6 or var_440_6 * (utf8.len(var_440_8) / 7)

				if (7 <= 0 and var_440_6 or var_440_6 * (utf8.len(var_440_8) / 7)) > 0 and var_440_6 < var_440_10 then
					arg_437_1.talkMaxDuration = var_440_10

					if var_440_10 + var_440_5 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_10 + var_440_5
					end
				end

				arg_437_1.text_.text = var_440_8
				arg_437_1.typewritter.percent = 0

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091105", "story_v_out_926091.awb") ~= 0 then
					local var_440_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091105", "story_v_out_926091.awb") / 1000

					if var_440_11 + var_440_5 > arg_437_1.duration_ then
						arg_437_1.duration_ = var_440_11 + var_440_5
					end

					if var_440_7.prefab_name ~= "" and arg_437_1.actors_[var_440_7.prefab_name] ~= nil then
						local var_440_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_437_1.actors_[var_440_7.prefab_name].transform, "story_v_out_926091", "926091105", "story_v_out_926091.awb")

						arg_437_1:RecordAudio("926091105", var_440_12)
						arg_437_1:RecordAudio("926091105", var_440_12)
					else
						arg_437_1:AudioAction("play", "voice", "story_v_out_926091", "926091105", "story_v_out_926091.awb")
					end

					arg_437_1:RecordHistoryTalkVoice("story_v_out_926091", "926091105", "story_v_out_926091.awb")
				end

				arg_437_1:RecordContent(arg_437_1.text_.text)
			end

			local var_440_13 = math.max(var_440_6, arg_437_1.talkMaxDuration)

			if var_440_5 <= arg_437_1.time_ and arg_437_1.time_ < var_440_5 + var_440_13 then
				arg_437_1.typewritter.percent = (arg_437_1.time_ - var_440_5) / var_440_13

				arg_437_1.typewritter:SetDirty()
			end

			if arg_437_1.time_ >= var_440_5 + var_440_13 and arg_437_1.time_ < var_440_5 + var_440_13 + arg_440_0 then
				arg_437_1.typewritter.percent = 1

				arg_437_1.typewritter:SetDirty()
				arg_437_1:ShowNextGo(true)
			end
		end

		arg_437_1.nodeConfigList_ = {
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

		arg_437_1:InitPlayNodeList()
	end,
	Play926091106 = function(arg_441_0, arg_441_1)
		arg_441_1.time_ = 0
		arg_441_1.frameCnt_ = 0
		arg_441_1.state_ = "playing"
		arg_441_1.curTalkId_ = 926091106
		arg_441_1.duration_ = 5

		SetActive(arg_441_1.tipsGo_, false)

		function arg_441_1.onSingleLineFinish_()
			arg_441_1.onSingleLineUpdate_ = nil
			arg_441_1.onSingleLineFinish_ = nil
			arg_441_1.state_ = "waiting"
		end

		function arg_441_1.playNext_(arg_443_0)
			if arg_443_0 == 1 then
				arg_441_0:Play926091107(arg_441_1)
			end
		end

		function arg_441_1.onSingleLineUpdate_(arg_444_0)
			if 0 < arg_441_1.time_ and arg_441_1.time_ <= 0 + arg_444_0 and not isNil(arg_441_1.actors_["10144"]) and arg_441_1.var_.actorSpriteComps10144 == nil then
				arg_441_1.var_.actorSpriteComps10144 = arg_441_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_444_0 = 0.2

			if 0 <= arg_441_1.time_ and arg_441_1.time_ < 0 + var_444_0 and not isNil(arg_441_1.actors_["10144"]) then
				if arg_441_1.var_.actorSpriteComps10144 then
					for iter_444_0, iter_444_1 in pairs(arg_441_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_444_1 then
							if arg_441_1.isInRecall_ then
								iter_444_1.color = Color.New(Mathf.Lerp(iter_444_1.color.r, arg_441_1.hightColor2.r, (arg_441_1.time_ - 0) / var_444_0), Mathf.Lerp(iter_444_1.color.g, arg_441_1.hightColor2.g, (arg_441_1.time_ - 0) / var_444_0), (Mathf.Lerp(iter_444_1.color.b, arg_441_1.hightColor2.b, (arg_441_1.time_ - 0) / var_444_0)))
							else
								local var_444_1 = Mathf.Lerp(iter_444_1.color.r, 0.5, (arg_441_1.time_ - 0) / var_444_0)

								iter_444_1.color = Color.New(var_444_1, var_444_1, var_444_1)
							end
						end
					end
				end
			end

			if arg_441_1.time_ >= 0 + var_444_0 and arg_441_1.time_ < 0 + var_444_0 + arg_444_0 and not isNil(arg_441_1.actors_["10144"]) and arg_441_1.var_.actorSpriteComps10144 then
				for iter_444_2, iter_444_3 in pairs(arg_441_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_444_3 then
						iter_444_3.color = arg_441_1.isInRecall_ and (arg_441_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_441_1.var_.actorSpriteComps10144 = nil
			end

			local var_444_2 = 0
			local var_444_3 = 0.275

			if 0 < arg_441_1.time_ and arg_441_1.time_ <= var_444_2 + arg_444_0 then
				arg_441_1.talkMaxDuration = 0
				arg_441_1.dialogCg_.alpha = 1

				arg_441_1.dialog_:SetActive(true)
				SetActive(arg_441_1.leftNameGo_, true)

				arg_441_1.leftNameTxt_.text = arg_441_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_441_1.leftNameTxt_.transform)

				arg_441_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_441_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_441_1:RecordName(arg_441_1.leftNameTxt_.text)
				SetActive(arg_441_1.iconTrs_.gameObject, true)
				arg_441_1.iconController_:SetSelectedState("hero")

				arg_441_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_441_1.callingController_:SetSelectedState("normal")

				arg_441_1.keyicon_.color = Color.New(1, 1, 1)
				arg_441_1.icon_.color = Color.New(1, 1, 1)

				local var_444_4 = arg_441_1:FormatText(arg_441_1:GetWordFromCfg(926091106).content)

				arg_441_1.text_.text = var_444_4

				LuaForUtil.ClearLinePrefixSymbol(arg_441_1.text_)

				local var_444_6 = 11 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_4) / 11)

				if (11 <= 0 and var_444_3 or var_444_3 * (utf8.len(var_444_4) / 11)) > 0 and var_444_3 < var_444_6 then
					arg_441_1.talkMaxDuration = var_444_6

					if var_444_6 + var_444_2 > arg_441_1.duration_ then
						arg_441_1.duration_ = var_444_6 + var_444_2
					end
				end

				arg_441_1.text_.text = var_444_4
				arg_441_1.typewritter.percent = 0

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(false)
				arg_441_1:RecordContent(arg_441_1.text_.text)
			end

			local var_444_7 = math.max(var_444_3, arg_441_1.talkMaxDuration)

			if var_444_2 <= arg_441_1.time_ and arg_441_1.time_ < var_444_2 + var_444_7 then
				arg_441_1.typewritter.percent = (arg_441_1.time_ - var_444_2) / var_444_7

				arg_441_1.typewritter:SetDirty()
			end

			if arg_441_1.time_ >= var_444_2 + var_444_7 and arg_441_1.time_ < var_444_2 + var_444_7 + arg_444_0 then
				arg_441_1.typewritter.percent = 1

				arg_441_1.typewritter:SetDirty()
				arg_441_1:ShowNextGo(true)
			end
		end

		arg_441_1.nodeConfigList_ = {}

		arg_441_1:InitPlayNodeList()
	end,
	Play926091107 = function(arg_445_0, arg_445_1)
		arg_445_1.time_ = 0
		arg_445_1.frameCnt_ = 0
		arg_445_1.state_ = "playing"
		arg_445_1.curTalkId_ = 926091107
		arg_445_1.duration_ = 3.9

		local var_445_0 = {
			zh = 3.133,
			ja = 3.9
		}
		local var_445_1 = manager.audio:GetLocalizationFlag()

		if var_445_0[var_445_1] ~= nil then
			arg_445_1.duration_ = var_445_0[var_445_1]
		end

		SetActive(arg_445_1.tipsGo_, false)

		function arg_445_1.onSingleLineFinish_()
			arg_445_1.onSingleLineUpdate_ = nil
			arg_445_1.onSingleLineFinish_ = nil
			arg_445_1.state_ = "waiting"
		end

		function arg_445_1.playNext_(arg_447_0)
			if arg_447_0 == 1 then
				arg_445_0:Play926091108(arg_445_1)
			end
		end

		function arg_445_1.onSingleLineUpdate_(arg_448_0)
			if 0 < arg_445_1.time_ and arg_445_1.time_ <= 0 + arg_448_0 and not isNil(arg_445_1.actors_["10144"]) and arg_445_1.var_.actorSpriteComps10144 == nil then
				arg_445_1.var_.actorSpriteComps10144 = arg_445_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_448_0 = 0.2

			if 0 <= arg_445_1.time_ and arg_445_1.time_ < 0 + var_448_0 and not isNil(arg_445_1.actors_["10144"]) then
				if arg_445_1.var_.actorSpriteComps10144 then
					for iter_448_0, iter_448_1 in pairs(arg_445_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_448_1 then
							if arg_445_1.isInRecall_ then
								iter_448_1.color = Color.New(Mathf.Lerp(iter_448_1.color.r, arg_445_1.hightColor1.r, (arg_445_1.time_ - 0) / var_448_0), Mathf.Lerp(iter_448_1.color.g, arg_445_1.hightColor1.g, (arg_445_1.time_ - 0) / var_448_0), (Mathf.Lerp(iter_448_1.color.b, arg_445_1.hightColor1.b, (arg_445_1.time_ - 0) / var_448_0)))
							else
								local var_448_1 = Mathf.Lerp(iter_448_1.color.r, 1, (arg_445_1.time_ - 0) / var_448_0)

								iter_448_1.color = Color.New(var_448_1, var_448_1, var_448_1)
							end
						end
					end
				end
			end

			if arg_445_1.time_ >= 0 + var_448_0 and arg_445_1.time_ < 0 + var_448_0 + arg_448_0 and not isNil(arg_445_1.actors_["10144"]) and arg_445_1.var_.actorSpriteComps10144 then
				for iter_448_2, iter_448_3 in pairs(arg_445_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_448_3 then
						iter_448_3.color = arg_445_1.isInRecall_ and (arg_445_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_445_1.var_.actorSpriteComps10144 = nil
			end

			local var_448_2 = 0
			local var_448_3 = 0.45

			if 0 < arg_445_1.time_ and arg_445_1.time_ <= var_448_2 + arg_448_0 then
				arg_445_1.talkMaxDuration = 0
				arg_445_1.dialogCg_.alpha = 1

				arg_445_1.dialog_:SetActive(true)
				SetActive(arg_445_1.leftNameGo_, true)

				arg_445_1.leftNameTxt_.text = arg_445_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_445_1.leftNameTxt_.transform)

				arg_445_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_445_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_445_1:RecordName(arg_445_1.leftNameTxt_.text)
				SetActive(arg_445_1.iconTrs_.gameObject, false)
				arg_445_1.callingController_:SetSelectedState("normal")

				local var_448_4 = arg_445_1:GetWordFromCfg(926091107)
				local var_448_5 = arg_445_1:FormatText(var_448_4.content)

				arg_445_1.text_.text = var_448_5

				LuaForUtil.ClearLinePrefixSymbol(arg_445_1.text_)

				local var_448_7 = 18 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 18)

				if (18 <= 0 and var_448_3 or var_448_3 * (utf8.len(var_448_5) / 18)) > 0 and var_448_3 < var_448_7 then
					arg_445_1.talkMaxDuration = var_448_7

					if var_448_7 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_7 + var_448_2
					end
				end

				arg_445_1.text_.text = var_448_5
				arg_445_1.typewritter.percent = 0

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091107", "story_v_out_926091.awb") ~= 0 then
					local var_448_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091107", "story_v_out_926091.awb") / 1000

					if var_448_8 + var_448_2 > arg_445_1.duration_ then
						arg_445_1.duration_ = var_448_8 + var_448_2
					end

					if var_448_4.prefab_name ~= "" and arg_445_1.actors_[var_448_4.prefab_name] ~= nil then
						local var_448_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_445_1.actors_[var_448_4.prefab_name].transform, "story_v_out_926091", "926091107", "story_v_out_926091.awb")

						arg_445_1:RecordAudio("926091107", var_448_9)
						arg_445_1:RecordAudio("926091107", var_448_9)
					else
						arg_445_1:AudioAction("play", "voice", "story_v_out_926091", "926091107", "story_v_out_926091.awb")
					end

					arg_445_1:RecordHistoryTalkVoice("story_v_out_926091", "926091107", "story_v_out_926091.awb")
				end

				arg_445_1:RecordContent(arg_445_1.text_.text)
			end

			local var_448_10 = math.max(var_448_3, arg_445_1.talkMaxDuration)

			if var_448_2 <= arg_445_1.time_ and arg_445_1.time_ < var_448_2 + var_448_10 then
				arg_445_1.typewritter.percent = (arg_445_1.time_ - var_448_2) / var_448_10

				arg_445_1.typewritter:SetDirty()
			end

			if arg_445_1.time_ >= var_448_2 + var_448_10 and arg_445_1.time_ < var_448_2 + var_448_10 + arg_448_0 then
				arg_445_1.typewritter.percent = 1

				arg_445_1.typewritter:SetDirty()
				arg_445_1:ShowNextGo(true)
			end
		end

		arg_445_1.nodeConfigList_ = {}

		arg_445_1:InitPlayNodeList()
	end,
	Play926091108 = function(arg_449_0, arg_449_1)
		arg_449_1.time_ = 0
		arg_449_1.frameCnt_ = 0
		arg_449_1.state_ = "playing"
		arg_449_1.curTalkId_ = 926091108
		arg_449_1.duration_ = 3.27

		local var_449_0 = {
			zh = 1.666,
			ja = 3.266
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
				arg_449_0:Play926091109(arg_449_1)
			end
		end

		function arg_449_1.onSingleLineUpdate_(arg_452_0)
			local var_452_0 = 0.175

			if 0 < arg_449_1.time_ and arg_449_1.time_ <= 0 + arg_452_0 then
				arg_449_1.talkMaxDuration = 0
				arg_449_1.dialogCg_.alpha = 1

				arg_449_1.dialog_:SetActive(true)
				SetActive(arg_449_1.leftNameGo_, true)

				arg_449_1.leftNameTxt_.text = arg_449_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_449_1.leftNameTxt_.transform)

				arg_449_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_449_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_449_1:RecordName(arg_449_1.leftNameTxt_.text)
				SetActive(arg_449_1.iconTrs_.gameObject, false)
				arg_449_1.callingController_:SetSelectedState("normal")

				local var_452_1 = arg_449_1:GetWordFromCfg(926091108)
				local var_452_2 = arg_449_1:FormatText(var_452_1.content)

				arg_449_1.text_.text = var_452_2

				LuaForUtil.ClearLinePrefixSymbol(arg_449_1.text_)

				local var_452_4 = 7 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 7)

				if (7 <= 0 and var_452_0 or var_452_0 * (utf8.len(var_452_2) / 7)) > 0 and var_452_0 < var_452_4 then
					arg_449_1.talkMaxDuration = var_452_4

					if var_452_4 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_4 + 0
					end
				end

				arg_449_1.text_.text = var_452_2
				arg_449_1.typewritter.percent = 0

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091108", "story_v_out_926091.awb") ~= 0 then
					local var_452_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091108", "story_v_out_926091.awb") / 1000

					if var_452_5 + 0 > arg_449_1.duration_ then
						arg_449_1.duration_ = var_452_5 + 0
					end

					if var_452_1.prefab_name ~= "" and arg_449_1.actors_[var_452_1.prefab_name] ~= nil then
						local var_452_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_449_1.actors_[var_452_1.prefab_name].transform, "story_v_out_926091", "926091108", "story_v_out_926091.awb")

						arg_449_1:RecordAudio("926091108", var_452_6)
						arg_449_1:RecordAudio("926091108", var_452_6)
					else
						arg_449_1:AudioAction("play", "voice", "story_v_out_926091", "926091108", "story_v_out_926091.awb")
					end

					arg_449_1:RecordHistoryTalkVoice("story_v_out_926091", "926091108", "story_v_out_926091.awb")
				end

				arg_449_1:RecordContent(arg_449_1.text_.text)
			end

			local var_452_7 = math.max(var_452_0, arg_449_1.talkMaxDuration)

			if 0 <= arg_449_1.time_ and arg_449_1.time_ < 0 + var_452_7 then
				arg_449_1.typewritter.percent = (arg_449_1.time_ - 0) / var_452_7

				arg_449_1.typewritter:SetDirty()
			end

			if arg_449_1.time_ >= 0 + var_452_7 and arg_449_1.time_ < 0 + var_452_7 + arg_452_0 then
				arg_449_1.typewritter.percent = 1

				arg_449_1.typewritter:SetDirty()
				arg_449_1:ShowNextGo(true)
			end
		end

		arg_449_1.nodeConfigList_ = {}

		arg_449_1:InitPlayNodeList()
	end,
	Play926091109 = function(arg_453_0, arg_453_1)
		arg_453_1.time_ = 0
		arg_453_1.frameCnt_ = 0
		arg_453_1.state_ = "playing"
		arg_453_1.curTalkId_ = 926091109
		arg_453_1.duration_ = 5

		SetActive(arg_453_1.tipsGo_, false)

		function arg_453_1.onSingleLineFinish_()
			arg_453_1.onSingleLineUpdate_ = nil
			arg_453_1.onSingleLineFinish_ = nil
			arg_453_1.state_ = "waiting"
		end

		function arg_453_1.playNext_(arg_455_0)
			if arg_455_0 == 1 then
				arg_453_0:Play926091110(arg_453_1)
			end
		end

		function arg_453_1.onSingleLineUpdate_(arg_456_0)
			if 0 < arg_453_1.time_ and arg_453_1.time_ <= 0 + arg_456_0 and not isNil(arg_453_1.actors_["10144"]) and arg_453_1.var_.actorSpriteComps10144 == nil then
				arg_453_1.var_.actorSpriteComps10144 = arg_453_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_456_0 = 0.2

			if 0 <= arg_453_1.time_ and arg_453_1.time_ < 0 + var_456_0 and not isNil(arg_453_1.actors_["10144"]) then
				if arg_453_1.var_.actorSpriteComps10144 then
					for iter_456_0, iter_456_1 in pairs(arg_453_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_453_1.time_ >= 0 + var_456_0 and arg_453_1.time_ < 0 + var_456_0 + arg_456_0 and not isNil(arg_453_1.actors_["10144"]) and arg_453_1.var_.actorSpriteComps10144 then
				for iter_456_2, iter_456_3 in pairs(arg_453_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_456_3 then
						iter_456_3.color = arg_453_1.isInRecall_ and (arg_453_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_453_1.var_.actorSpriteComps10144 = nil
			end

			local var_456_2 = 0
			local var_456_3 = 0.075

			if 0 < arg_453_1.time_ and arg_453_1.time_ <= var_456_2 + arg_456_0 then
				arg_453_1.talkMaxDuration = 0
				arg_453_1.dialogCg_.alpha = 1

				arg_453_1.dialog_:SetActive(true)
				SetActive(arg_453_1.leftNameGo_, true)

				arg_453_1.leftNameTxt_.text = arg_453_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_453_1.leftNameTxt_.transform)

				arg_453_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_453_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_453_1:RecordName(arg_453_1.leftNameTxt_.text)
				SetActive(arg_453_1.iconTrs_.gameObject, true)
				arg_453_1.iconController_:SetSelectedState("hero")

				arg_453_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_453_1.callingController_:SetSelectedState("normal")

				arg_453_1.keyicon_.color = Color.New(1, 1, 1)
				arg_453_1.icon_.color = Color.New(1, 1, 1)

				local var_456_4 = arg_453_1:FormatText(arg_453_1:GetWordFromCfg(926091109).content)

				arg_453_1.text_.text = var_456_4

				LuaForUtil.ClearLinePrefixSymbol(arg_453_1.text_)

				local var_456_6 = 3 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 3)

				if (3 <= 0 and var_456_3 or var_456_3 * (utf8.len(var_456_4) / 3)) > 0 and var_456_3 < var_456_6 then
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
	Play926091110 = function(arg_457_0, arg_457_1)
		arg_457_1.time_ = 0
		arg_457_1.frameCnt_ = 0
		arg_457_1.state_ = "playing"
		arg_457_1.curTalkId_ = 926091110
		arg_457_1.duration_ = 4.4

		local var_457_0 = {
			zh = 2.4,
			ja = 4.4
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
				arg_457_0:Play926091111(arg_457_1)
			end
		end

		function arg_457_1.onSingleLineUpdate_(arg_460_0)
			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 and not isNil(arg_457_1.actors_["10144"]) and arg_457_1.var_.actorSpriteComps10144 == nil then
				arg_457_1.var_.actorSpriteComps10144 = arg_457_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_460_0 = 0.2

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_0 and not isNil(arg_457_1.actors_["10144"]) then
				if arg_457_1.var_.actorSpriteComps10144 then
					for iter_460_0, iter_460_1 in pairs(arg_457_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_457_1.time_ >= 0 + var_460_0 and arg_457_1.time_ < 0 + var_460_0 + arg_460_0 and not isNil(arg_457_1.actors_["10144"]) and arg_457_1.var_.actorSpriteComps10144 then
				for iter_460_2, iter_460_3 in pairs(arg_457_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_460_3 then
						iter_460_3.color = arg_457_1.isInRecall_ and (arg_457_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_457_1.var_.actorSpriteComps10144 = nil
			end

			local var_460_2 = arg_457_1.actors_["10144"].transform

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= 0 + arg_460_0 then
				arg_457_1.var_.moveOldPos10144 = var_460_2.localPosition
				var_460_2.localScale = Vector3.New(1, 1, 1)

				arg_457_1:CheckSpriteTmpPos("10144", 3)

				for iter_460_4 = 0, var_460_2.childCount - 1 do
					local var_460_3 = var_460_2:GetChild(iter_460_4)

					if var_460_3.name == "" or not string.find(var_460_3.name, "split") then
						var_460_3.gameObject:SetActive(true)
					else
						var_460_3.gameObject:SetActive(false)
					end
				end
			end

			local var_460_4 = 0.001

			if 0 <= arg_457_1.time_ and arg_457_1.time_ < 0 + var_460_4 then
				var_460_2.localPosition = Vector3.Lerp(arg_457_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_457_1.time_ - 0) / var_460_4)
			end

			if arg_457_1.time_ >= 0 + var_460_4 and arg_457_1.time_ < 0 + var_460_4 + arg_460_0 then
				var_460_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_460_5 = 0
			local var_460_6 = 0.3

			if 0 < arg_457_1.time_ and arg_457_1.time_ <= var_460_5 + arg_460_0 then
				arg_457_1.talkMaxDuration = 0
				arg_457_1.dialogCg_.alpha = 1

				arg_457_1.dialog_:SetActive(true)
				SetActive(arg_457_1.leftNameGo_, true)

				arg_457_1.leftNameTxt_.text = arg_457_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_457_1.leftNameTxt_.transform)

				arg_457_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_457_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_457_1:RecordName(arg_457_1.leftNameTxt_.text)
				SetActive(arg_457_1.iconTrs_.gameObject, false)
				arg_457_1.callingController_:SetSelectedState("normal")

				local var_460_7 = arg_457_1:GetWordFromCfg(926091110)
				local var_460_8 = arg_457_1:FormatText(var_460_7.content)

				arg_457_1.text_.text = var_460_8

				LuaForUtil.ClearLinePrefixSymbol(arg_457_1.text_)

				local var_460_10 = 12 <= 0 and var_460_6 or var_460_6 * (utf8.len(var_460_8) / 12)

				if (12 <= 0 and var_460_6 or var_460_6 * (utf8.len(var_460_8) / 12)) > 0 and var_460_6 < var_460_10 then
					arg_457_1.talkMaxDuration = var_460_10

					if var_460_10 + var_460_5 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_10 + var_460_5
					end
				end

				arg_457_1.text_.text = var_460_8
				arg_457_1.typewritter.percent = 0

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091110", "story_v_out_926091.awb") ~= 0 then
					local var_460_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091110", "story_v_out_926091.awb") / 1000

					if var_460_11 + var_460_5 > arg_457_1.duration_ then
						arg_457_1.duration_ = var_460_11 + var_460_5
					end

					if var_460_7.prefab_name ~= "" and arg_457_1.actors_[var_460_7.prefab_name] ~= nil then
						local var_460_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_457_1.actors_[var_460_7.prefab_name].transform, "story_v_out_926091", "926091110", "story_v_out_926091.awb")

						arg_457_1:RecordAudio("926091110", var_460_12)
						arg_457_1:RecordAudio("926091110", var_460_12)
					else
						arg_457_1:AudioAction("play", "voice", "story_v_out_926091", "926091110", "story_v_out_926091.awb")
					end

					arg_457_1:RecordHistoryTalkVoice("story_v_out_926091", "926091110", "story_v_out_926091.awb")
				end

				arg_457_1:RecordContent(arg_457_1.text_.text)
			end

			local var_460_13 = math.max(var_460_6, arg_457_1.talkMaxDuration)

			if var_460_5 <= arg_457_1.time_ and arg_457_1.time_ < var_460_5 + var_460_13 then
				arg_457_1.typewritter.percent = (arg_457_1.time_ - var_460_5) / var_460_13

				arg_457_1.typewritter:SetDirty()
			end

			if arg_457_1.time_ >= var_460_5 + var_460_13 and arg_457_1.time_ < var_460_5 + var_460_13 + arg_460_0 then
				arg_457_1.typewritter.percent = 1

				arg_457_1.typewritter:SetDirty()
				arg_457_1:ShowNextGo(true)
			end
		end

		arg_457_1.nodeConfigList_ = {
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

		arg_457_1:InitPlayNodeList()
	end,
	Play926091111 = function(arg_461_0, arg_461_1)
		arg_461_1.time_ = 0
		arg_461_1.frameCnt_ = 0
		arg_461_1.state_ = "playing"
		arg_461_1.curTalkId_ = 926091111
		arg_461_1.duration_ = 5

		SetActive(arg_461_1.tipsGo_, false)

		function arg_461_1.onSingleLineFinish_()
			arg_461_1.onSingleLineUpdate_ = nil
			arg_461_1.onSingleLineFinish_ = nil
			arg_461_1.state_ = "waiting"
		end

		function arg_461_1.playNext_(arg_463_0)
			if arg_463_0 == 1 then
				arg_461_0:Play926091112(arg_461_1)
			end
		end

		function arg_461_1.onSingleLineUpdate_(arg_464_0)
			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 and not isNil(arg_461_1.actors_["10144"]) and arg_461_1.var_.actorSpriteComps10144 == nil then
				arg_461_1.var_.actorSpriteComps10144 = arg_461_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_464_0 = 0.2

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_0 and not isNil(arg_461_1.actors_["10144"]) then
				if arg_461_1.var_.actorSpriteComps10144 then
					for iter_464_0, iter_464_1 in pairs(arg_461_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_464_1 then
							if arg_461_1.isInRecall_ then
								iter_464_1.color = Color.New(Mathf.Lerp(iter_464_1.color.r, arg_461_1.hightColor2.r, (arg_461_1.time_ - 0) / var_464_0), Mathf.Lerp(iter_464_1.color.g, arg_461_1.hightColor2.g, (arg_461_1.time_ - 0) / var_464_0), (Mathf.Lerp(iter_464_1.color.b, arg_461_1.hightColor2.b, (arg_461_1.time_ - 0) / var_464_0)))
							else
								local var_464_1 = Mathf.Lerp(iter_464_1.color.r, 0.5, (arg_461_1.time_ - 0) / var_464_0)

								iter_464_1.color = Color.New(var_464_1, var_464_1, var_464_1)
							end
						end
					end
				end
			end

			if arg_461_1.time_ >= 0 + var_464_0 and arg_461_1.time_ < 0 + var_464_0 + arg_464_0 and not isNil(arg_461_1.actors_["10144"]) and arg_461_1.var_.actorSpriteComps10144 then
				for iter_464_2, iter_464_3 in pairs(arg_461_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_464_3 then
						iter_464_3.color = arg_461_1.isInRecall_ and (arg_461_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_461_1.var_.actorSpriteComps10144 = nil
			end

			local var_464_2 = arg_461_1.actors_["10144"].transform

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= 0 + arg_464_0 then
				arg_461_1.var_.moveOldPos10144 = var_464_2.localPosition
				var_464_2.localScale = Vector3.New(1, 1, 1)

				arg_461_1:CheckSpriteTmpPos("10144", 7)

				for iter_464_4 = 0, var_464_2.childCount - 1 do
					local var_464_3 = var_464_2:GetChild(iter_464_4)

					if var_464_3.name == "" or not string.find(var_464_3.name, "split") then
						var_464_3.gameObject:SetActive(true)
					else
						var_464_3.gameObject:SetActive(false)
					end
				end
			end

			local var_464_4 = 0.001

			if 0 <= arg_461_1.time_ and arg_461_1.time_ < 0 + var_464_4 then
				var_464_2.localPosition = Vector3.Lerp(arg_461_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_461_1.time_ - 0) / var_464_4)
			end

			if arg_461_1.time_ >= 0 + var_464_4 and arg_461_1.time_ < 0 + var_464_4 + arg_464_0 then
				var_464_2.localPosition = Vector3.New(0, -2000, 0)
			end

			local var_464_5 = 0
			local var_464_6 = 0.725

			if 0 < arg_461_1.time_ and arg_461_1.time_ <= var_464_5 + arg_464_0 then
				arg_461_1.talkMaxDuration = 0
				arg_461_1.dialogCg_.alpha = 1

				arg_461_1.dialog_:SetActive(true)
				SetActive(arg_461_1.leftNameGo_, false)

				arg_461_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_461_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_461_1:RecordName(arg_461_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_461_1.iconTrs_.gameObject, false)
				arg_461_1.callingController_:SetSelectedState("normal")

				local var_464_7 = arg_461_1:FormatText(arg_461_1:GetWordFromCfg(926091111).content)

				arg_461_1.text_.text = var_464_7

				LuaForUtil.ClearLinePrefixSymbol(arg_461_1.text_)

				local var_464_9 = 29 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_7) / 29)

				if (29 <= 0 and var_464_6 or var_464_6 * (utf8.len(var_464_7) / 29)) > 0 and var_464_6 < var_464_9 then
					arg_461_1.talkMaxDuration = var_464_9

					if var_464_9 + var_464_5 > arg_461_1.duration_ then
						arg_461_1.duration_ = var_464_9 + var_464_5
					end
				end

				arg_461_1.text_.text = var_464_7
				arg_461_1.typewritter.percent = 0

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(false)
				arg_461_1:RecordContent(arg_461_1.text_.text)
			end

			local var_464_10 = math.max(var_464_6, arg_461_1.talkMaxDuration)

			if var_464_5 <= arg_461_1.time_ and arg_461_1.time_ < var_464_5 + var_464_10 then
				arg_461_1.typewritter.percent = (arg_461_1.time_ - var_464_5) / var_464_10

				arg_461_1.typewritter:SetDirty()
			end

			if arg_461_1.time_ >= var_464_5 + var_464_10 and arg_461_1.time_ < var_464_5 + var_464_10 + arg_464_0 then
				arg_461_1.typewritter.percent = 1

				arg_461_1.typewritter:SetDirty()
				arg_461_1:ShowNextGo(true)
			end
		end

		arg_461_1.nodeConfigList_ = {
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

		arg_461_1:InitPlayNodeList()
	end,
	Play926091112 = function(arg_465_0, arg_465_1)
		arg_465_1.time_ = 0
		arg_465_1.frameCnt_ = 0
		arg_465_1.state_ = "playing"
		arg_465_1.curTalkId_ = 926091112
		arg_465_1.duration_ = 5

		SetActive(arg_465_1.tipsGo_, false)

		function arg_465_1.onSingleLineFinish_()
			arg_465_1.onSingleLineUpdate_ = nil
			arg_465_1.onSingleLineFinish_ = nil
			arg_465_1.state_ = "waiting"
		end

		function arg_465_1.playNext_(arg_467_0)
			if arg_467_0 == 1 then
				arg_465_0:Play926091113(arg_465_1)
			end
		end

		function arg_465_1.onSingleLineUpdate_(arg_468_0)
			local var_468_0 = 0.1

			if 0 < arg_465_1.time_ and arg_465_1.time_ <= 0 + arg_468_0 then
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

				arg_465_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_465_1.callingController_:SetSelectedState("normal")

				arg_465_1.keyicon_.color = Color.New(1, 1, 1)
				arg_465_1.icon_.color = Color.New(1, 1, 1)

				local var_468_1 = arg_465_1:FormatText(arg_465_1:GetWordFromCfg(926091112).content)

				arg_465_1.text_.text = var_468_1

				LuaForUtil.ClearLinePrefixSymbol(arg_465_1.text_)

				local var_468_3 = 4 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 4)

				if (4 <= 0 and var_468_0 or var_468_0 * (utf8.len(var_468_1) / 4)) > 0 and var_468_0 < var_468_3 then
					arg_465_1.talkMaxDuration = var_468_3

					if var_468_3 + 0 > arg_465_1.duration_ then
						arg_465_1.duration_ = var_468_3 + 0
					end
				end

				arg_465_1.text_.text = var_468_1
				arg_465_1.typewritter.percent = 0

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(false)
				arg_465_1:RecordContent(arg_465_1.text_.text)
			end

			local var_468_4 = math.max(var_468_0, arg_465_1.talkMaxDuration)

			if 0 <= arg_465_1.time_ and arg_465_1.time_ < 0 + var_468_4 then
				arg_465_1.typewritter.percent = (arg_465_1.time_ - 0) / var_468_4

				arg_465_1.typewritter:SetDirty()
			end

			if arg_465_1.time_ >= 0 + var_468_4 and arg_465_1.time_ < 0 + var_468_4 + arg_468_0 then
				arg_465_1.typewritter.percent = 1

				arg_465_1.typewritter:SetDirty()
				arg_465_1:ShowNextGo(true)
			end
		end

		arg_465_1.nodeConfigList_ = {}

		arg_465_1:InitPlayNodeList()
	end,
	Play926091113 = function(arg_469_0, arg_469_1)
		arg_469_1.time_ = 0
		arg_469_1.frameCnt_ = 0
		arg_469_1.state_ = "playing"
		arg_469_1.curTalkId_ = 926091113
		arg_469_1.duration_ = 7.1

		local var_469_0 = {
			zh = 5.366,
			ja = 7.1
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
				arg_469_0:Play926091114(arg_469_1)
			end
		end

		function arg_469_1.onSingleLineUpdate_(arg_472_0)
			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 and not isNil(arg_469_1.actors_["10144"]) and arg_469_1.var_.actorSpriteComps10144 == nil then
				arg_469_1.var_.actorSpriteComps10144 = arg_469_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_472_0 = 0.2

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_0 and not isNil(arg_469_1.actors_["10144"]) then
				if arg_469_1.var_.actorSpriteComps10144 then
					for iter_472_0, iter_472_1 in pairs(arg_469_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_469_1.time_ >= 0 + var_472_0 and arg_469_1.time_ < 0 + var_472_0 + arg_472_0 and not isNil(arg_469_1.actors_["10144"]) and arg_469_1.var_.actorSpriteComps10144 then
				for iter_472_2, iter_472_3 in pairs(arg_469_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_472_3 then
						iter_472_3.color = arg_469_1.isInRecall_ and (arg_469_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_469_1.var_.actorSpriteComps10144 = nil
			end

			local var_472_2 = arg_469_1.actors_["10144"].transform

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= 0 + arg_472_0 then
				arg_469_1.var_.moveOldPos10144 = var_472_2.localPosition
				var_472_2.localScale = Vector3.New(1, 1, 1)

				arg_469_1:CheckSpriteTmpPos("10144", 3)

				for iter_472_4 = 0, var_472_2.childCount - 1 do
					local var_472_3 = var_472_2:GetChild(iter_472_4)

					if var_472_3.name == "split_7" or not string.find(var_472_3.name, "split") then
						var_472_3.gameObject:SetActive(true)
					else
						var_472_3.gameObject:SetActive(false)
					end
				end
			end

			local var_472_4 = 0.001

			if 0 <= arg_469_1.time_ and arg_469_1.time_ < 0 + var_472_4 then
				var_472_2.localPosition = Vector3.Lerp(arg_469_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_469_1.time_ - 0) / var_472_4)
			end

			if arg_469_1.time_ >= 0 + var_472_4 and arg_469_1.time_ < 0 + var_472_4 + arg_472_0 then
				var_472_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_472_5 = 0
			local var_472_6 = 0.7

			if 0 < arg_469_1.time_ and arg_469_1.time_ <= var_472_5 + arg_472_0 then
				arg_469_1.talkMaxDuration = 0
				arg_469_1.dialogCg_.alpha = 1

				arg_469_1.dialog_:SetActive(true)
				SetActive(arg_469_1.leftNameGo_, true)

				arg_469_1.leftNameTxt_.text = arg_469_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_469_1.leftNameTxt_.transform)

				arg_469_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_469_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_469_1:RecordName(arg_469_1.leftNameTxt_.text)
				SetActive(arg_469_1.iconTrs_.gameObject, false)
				arg_469_1.callingController_:SetSelectedState("normal")

				local var_472_7 = arg_469_1:GetWordFromCfg(926091113)
				local var_472_8 = arg_469_1:FormatText(var_472_7.content)

				arg_469_1.text_.text = var_472_8

				LuaForUtil.ClearLinePrefixSymbol(arg_469_1.text_)

				local var_472_10 = 28 <= 0 and var_472_6 or var_472_6 * (utf8.len(var_472_8) / 28)

				if (28 <= 0 and var_472_6 or var_472_6 * (utf8.len(var_472_8) / 28)) > 0 and var_472_6 < var_472_10 then
					arg_469_1.talkMaxDuration = var_472_10

					if var_472_10 + var_472_5 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_10 + var_472_5
					end
				end

				arg_469_1.text_.text = var_472_8
				arg_469_1.typewritter.percent = 0

				arg_469_1.typewritter:SetDirty()
				arg_469_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091113", "story_v_out_926091.awb") ~= 0 then
					local var_472_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091113", "story_v_out_926091.awb") / 1000

					if var_472_11 + var_472_5 > arg_469_1.duration_ then
						arg_469_1.duration_ = var_472_11 + var_472_5
					end

					if var_472_7.prefab_name ~= "" and arg_469_1.actors_[var_472_7.prefab_name] ~= nil then
						local var_472_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_469_1.actors_[var_472_7.prefab_name].transform, "story_v_out_926091", "926091113", "story_v_out_926091.awb")

						arg_469_1:RecordAudio("926091113", var_472_12)
						arg_469_1:RecordAudio("926091113", var_472_12)
					else
						arg_469_1:AudioAction("play", "voice", "story_v_out_926091", "926091113", "story_v_out_926091.awb")
					end

					arg_469_1:RecordHistoryTalkVoice("story_v_out_926091", "926091113", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091114 = function(arg_473_0, arg_473_1)
		arg_473_1.time_ = 0
		arg_473_1.frameCnt_ = 0
		arg_473_1.state_ = "playing"
		arg_473_1.curTalkId_ = 926091114
		arg_473_1.duration_ = 6.43

		local var_473_0 = {
			zh = 3.5,
			ja = 6.433
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
				arg_473_0:Play926091115(arg_473_1)
			end
		end

		function arg_473_1.onSingleLineUpdate_(arg_476_0)
			local var_476_0 = 0.525

			if 0 < arg_473_1.time_ and arg_473_1.time_ <= 0 + arg_476_0 then
				arg_473_1.talkMaxDuration = 0
				arg_473_1.dialogCg_.alpha = 1

				arg_473_1.dialog_:SetActive(true)
				SetActive(arg_473_1.leftNameGo_, true)

				arg_473_1.leftNameTxt_.text = arg_473_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_473_1.leftNameTxt_.transform)

				arg_473_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_473_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_473_1:RecordName(arg_473_1.leftNameTxt_.text)
				SetActive(arg_473_1.iconTrs_.gameObject, false)
				arg_473_1.callingController_:SetSelectedState("normal")

				local var_476_1 = arg_473_1:GetWordFromCfg(926091114)
				local var_476_2 = arg_473_1:FormatText(var_476_1.content)

				arg_473_1.text_.text = var_476_2

				LuaForUtil.ClearLinePrefixSymbol(arg_473_1.text_)

				local var_476_4 = 21 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 21)

				if (21 <= 0 and var_476_0 or var_476_0 * (utf8.len(var_476_2) / 21)) > 0 and var_476_0 < var_476_4 then
					arg_473_1.talkMaxDuration = var_476_4

					if var_476_4 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_4 + 0
					end
				end

				arg_473_1.text_.text = var_476_2
				arg_473_1.typewritter.percent = 0

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091114", "story_v_out_926091.awb") ~= 0 then
					local var_476_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091114", "story_v_out_926091.awb") / 1000

					if var_476_5 + 0 > arg_473_1.duration_ then
						arg_473_1.duration_ = var_476_5 + 0
					end

					if var_476_1.prefab_name ~= "" and arg_473_1.actors_[var_476_1.prefab_name] ~= nil then
						local var_476_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_473_1.actors_[var_476_1.prefab_name].transform, "story_v_out_926091", "926091114", "story_v_out_926091.awb")

						arg_473_1:RecordAudio("926091114", var_476_6)
						arg_473_1:RecordAudio("926091114", var_476_6)
					else
						arg_473_1:AudioAction("play", "voice", "story_v_out_926091", "926091114", "story_v_out_926091.awb")
					end

					arg_473_1:RecordHistoryTalkVoice("story_v_out_926091", "926091114", "story_v_out_926091.awb")
				end

				arg_473_1:RecordContent(arg_473_1.text_.text)
			end

			local var_476_7 = math.max(var_476_0, arg_473_1.talkMaxDuration)

			if 0 <= arg_473_1.time_ and arg_473_1.time_ < 0 + var_476_7 then
				arg_473_1.typewritter.percent = (arg_473_1.time_ - 0) / var_476_7

				arg_473_1.typewritter:SetDirty()
			end

			if arg_473_1.time_ >= 0 + var_476_7 and arg_473_1.time_ < 0 + var_476_7 + arg_476_0 then
				arg_473_1.typewritter.percent = 1

				arg_473_1.typewritter:SetDirty()
				arg_473_1:ShowNextGo(true)
			end
		end

		arg_473_1.nodeConfigList_ = {}

		arg_473_1:InitPlayNodeList()
	end,
	Play926091115 = function(arg_477_0, arg_477_1)
		arg_477_1.time_ = 0
		arg_477_1.frameCnt_ = 0
		arg_477_1.state_ = "playing"
		arg_477_1.curTalkId_ = 926091115
		arg_477_1.duration_ = 5

		SetActive(arg_477_1.tipsGo_, false)

		function arg_477_1.onSingleLineFinish_()
			arg_477_1.onSingleLineUpdate_ = nil
			arg_477_1.onSingleLineFinish_ = nil
			arg_477_1.state_ = "waiting"
		end

		function arg_477_1.playNext_(arg_479_0)
			if arg_479_0 == 1 then
				arg_477_0:Play926091116(arg_477_1)
			end
		end

		function arg_477_1.onSingleLineUpdate_(arg_480_0)
			if 0 < arg_477_1.time_ and arg_477_1.time_ <= 0 + arg_480_0 and not isNil(arg_477_1.actors_["10144"]) and arg_477_1.var_.actorSpriteComps10144 == nil then
				arg_477_1.var_.actorSpriteComps10144 = arg_477_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_480_0 = 0.2

			if 0 <= arg_477_1.time_ and arg_477_1.time_ < 0 + var_480_0 and not isNil(arg_477_1.actors_["10144"]) then
				if arg_477_1.var_.actorSpriteComps10144 then
					for iter_480_0, iter_480_1 in pairs(arg_477_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_477_1.time_ >= 0 + var_480_0 and arg_477_1.time_ < 0 + var_480_0 + arg_480_0 and not isNil(arg_477_1.actors_["10144"]) and arg_477_1.var_.actorSpriteComps10144 then
				for iter_480_2, iter_480_3 in pairs(arg_477_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_480_3 then
						iter_480_3.color = arg_477_1.isInRecall_ and (arg_477_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_477_1.var_.actorSpriteComps10144 = nil
			end

			local var_480_2 = 0
			local var_480_3 = 0.475

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

				arg_477_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_477_1.callingController_:SetSelectedState("normal")

				arg_477_1.keyicon_.color = Color.New(1, 1, 1)
				arg_477_1.icon_.color = Color.New(1, 1, 1)

				local var_480_4 = arg_477_1:FormatText(arg_477_1:GetWordFromCfg(926091115).content)

				arg_477_1.text_.text = var_480_4

				LuaForUtil.ClearLinePrefixSymbol(arg_477_1.text_)

				local var_480_6 = 19 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_4) / 19)

				if (19 <= 0 and var_480_3 or var_480_3 * (utf8.len(var_480_4) / 19)) > 0 and var_480_3 < var_480_6 then
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
	Play926091116 = function(arg_481_0, arg_481_1)
		arg_481_1.time_ = 0
		arg_481_1.frameCnt_ = 0
		arg_481_1.state_ = "playing"
		arg_481_1.curTalkId_ = 926091116
		arg_481_1.duration_ = 6.07

		local var_481_0 = {
			zh = 4.4,
			ja = 6.066
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
				arg_481_0:Play926091117(arg_481_1)
			end
		end

		function arg_481_1.onSingleLineUpdate_(arg_484_0)
			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 and not isNil(arg_481_1.actors_["10144"]) and arg_481_1.var_.actorSpriteComps10144 == nil then
				arg_481_1.var_.actorSpriteComps10144 = arg_481_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_484_0 = 0.2

			if 0 <= arg_481_1.time_ and arg_481_1.time_ < 0 + var_484_0 and not isNil(arg_481_1.actors_["10144"]) then
				if arg_481_1.var_.actorSpriteComps10144 then
					for iter_484_0, iter_484_1 in pairs(arg_481_1.var_.actorSpriteComps10144:ToTable()) do
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

			if arg_481_1.time_ >= 0 + var_484_0 and arg_481_1.time_ < 0 + var_484_0 + arg_484_0 and not isNil(arg_481_1.actors_["10144"]) and arg_481_1.var_.actorSpriteComps10144 then
				for iter_484_2, iter_484_3 in pairs(arg_481_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_484_3 then
						iter_484_3.color = arg_481_1.isInRecall_ and (arg_481_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_481_1.var_.actorSpriteComps10144 = nil
			end

			local var_484_2 = arg_481_1.actors_["10144"].transform

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= 0 + arg_484_0 then
				arg_481_1.var_.moveOldPos10144 = var_484_2.localPosition
				var_484_2.localScale = Vector3.New(1, 1, 1)

				arg_481_1:CheckSpriteTmpPos("10144", 3)

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
				var_484_2.localPosition = Vector3.Lerp(arg_481_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_481_1.time_ - 0) / var_484_4)
			end

			if arg_481_1.time_ >= 0 + var_484_4 and arg_481_1.time_ < 0 + var_484_4 + arg_484_0 then
				var_484_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_484_5 = 0
			local var_484_6 = 0.425

			if 0 < arg_481_1.time_ and arg_481_1.time_ <= var_484_5 + arg_484_0 then
				arg_481_1.talkMaxDuration = 0
				arg_481_1.dialogCg_.alpha = 1

				arg_481_1.dialog_:SetActive(true)
				SetActive(arg_481_1.leftNameGo_, true)

				arg_481_1.leftNameTxt_.text = arg_481_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_481_1.leftNameTxt_.transform)

				arg_481_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_481_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_481_1:RecordName(arg_481_1.leftNameTxt_.text)
				SetActive(arg_481_1.iconTrs_.gameObject, false)
				arg_481_1.callingController_:SetSelectedState("normal")

				local var_484_7 = arg_481_1:GetWordFromCfg(926091116)
				local var_484_8 = arg_481_1:FormatText(var_484_7.content)

				arg_481_1.text_.text = var_484_8

				LuaForUtil.ClearLinePrefixSymbol(arg_481_1.text_)

				local var_484_10 = 17 <= 0 and var_484_6 or var_484_6 * (utf8.len(var_484_8) / 17)

				if (17 <= 0 and var_484_6 or var_484_6 * (utf8.len(var_484_8) / 17)) > 0 and var_484_6 < var_484_10 then
					arg_481_1.talkMaxDuration = var_484_10

					if var_484_10 + var_484_5 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_10 + var_484_5
					end
				end

				arg_481_1.text_.text = var_484_8
				arg_481_1.typewritter.percent = 0

				arg_481_1.typewritter:SetDirty()
				arg_481_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091116", "story_v_out_926091.awb") ~= 0 then
					local var_484_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091116", "story_v_out_926091.awb") / 1000

					if var_484_11 + var_484_5 > arg_481_1.duration_ then
						arg_481_1.duration_ = var_484_11 + var_484_5
					end

					if var_484_7.prefab_name ~= "" and arg_481_1.actors_[var_484_7.prefab_name] ~= nil then
						local var_484_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_481_1.actors_[var_484_7.prefab_name].transform, "story_v_out_926091", "926091116", "story_v_out_926091.awb")

						arg_481_1:RecordAudio("926091116", var_484_12)
						arg_481_1:RecordAudio("926091116", var_484_12)
					else
						arg_481_1:AudioAction("play", "voice", "story_v_out_926091", "926091116", "story_v_out_926091.awb")
					end

					arg_481_1:RecordHistoryTalkVoice("story_v_out_926091", "926091116", "story_v_out_926091.awb")
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
				actorName = "10144",
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
	Play926091117 = function(arg_485_0, arg_485_1)
		arg_485_1.time_ = 0
		arg_485_1.frameCnt_ = 0
		arg_485_1.state_ = "playing"
		arg_485_1.curTalkId_ = 926091117
		arg_485_1.duration_ = 12.33

		local var_485_0 = {
			zh = 7.6,
			ja = 12.333
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
				arg_485_0:Play926091118(arg_485_1)
			end
		end

		function arg_485_1.onSingleLineUpdate_(arg_488_0)
			local var_488_0 = 1.05

			if 0 < arg_485_1.time_ and arg_485_1.time_ <= 0 + arg_488_0 then
				arg_485_1.talkMaxDuration = 0
				arg_485_1.dialogCg_.alpha = 1

				arg_485_1.dialog_:SetActive(true)
				SetActive(arg_485_1.leftNameGo_, true)

				arg_485_1.leftNameTxt_.text = arg_485_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_485_1.leftNameTxt_.transform)

				arg_485_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_485_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_485_1:RecordName(arg_485_1.leftNameTxt_.text)
				SetActive(arg_485_1.iconTrs_.gameObject, false)
				arg_485_1.callingController_:SetSelectedState("normal")

				local var_488_1 = arg_485_1:GetWordFromCfg(926091117)
				local var_488_2 = arg_485_1:FormatText(var_488_1.content)

				arg_485_1.text_.text = var_488_2

				LuaForUtil.ClearLinePrefixSymbol(arg_485_1.text_)

				local var_488_4 = 42 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 42)

				if (42 <= 0 and var_488_0 or var_488_0 * (utf8.len(var_488_2) / 42)) > 0 and var_488_0 < var_488_4 then
					arg_485_1.talkMaxDuration = var_488_4

					if var_488_4 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_4 + 0
					end
				end

				arg_485_1.text_.text = var_488_2
				arg_485_1.typewritter.percent = 0

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091117", "story_v_out_926091.awb") ~= 0 then
					local var_488_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091117", "story_v_out_926091.awb") / 1000

					if var_488_5 + 0 > arg_485_1.duration_ then
						arg_485_1.duration_ = var_488_5 + 0
					end

					if var_488_1.prefab_name ~= "" and arg_485_1.actors_[var_488_1.prefab_name] ~= nil then
						local var_488_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_485_1.actors_[var_488_1.prefab_name].transform, "story_v_out_926091", "926091117", "story_v_out_926091.awb")

						arg_485_1:RecordAudio("926091117", var_488_6)
						arg_485_1:RecordAudio("926091117", var_488_6)
					else
						arg_485_1:AudioAction("play", "voice", "story_v_out_926091", "926091117", "story_v_out_926091.awb")
					end

					arg_485_1:RecordHistoryTalkVoice("story_v_out_926091", "926091117", "story_v_out_926091.awb")
				end

				arg_485_1:RecordContent(arg_485_1.text_.text)
			end

			local var_488_7 = math.max(var_488_0, arg_485_1.talkMaxDuration)

			if 0 <= arg_485_1.time_ and arg_485_1.time_ < 0 + var_488_7 then
				arg_485_1.typewritter.percent = (arg_485_1.time_ - 0) / var_488_7

				arg_485_1.typewritter:SetDirty()
			end

			if arg_485_1.time_ >= 0 + var_488_7 and arg_485_1.time_ < 0 + var_488_7 + arg_488_0 then
				arg_485_1.typewritter.percent = 1

				arg_485_1.typewritter:SetDirty()
				arg_485_1:ShowNextGo(true)
			end
		end

		arg_485_1.nodeConfigList_ = {}

		arg_485_1:InitPlayNodeList()
	end,
	Play926091118 = function(arg_489_0, arg_489_1)
		arg_489_1.time_ = 0
		arg_489_1.frameCnt_ = 0
		arg_489_1.state_ = "playing"
		arg_489_1.curTalkId_ = 926091118
		arg_489_1.duration_ = 6.2

		local var_489_0 = {
			zh = 5.766,
			ja = 6.2
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
				arg_489_0:Play926091119(arg_489_1)
			end
		end

		function arg_489_1.onSingleLineUpdate_(arg_492_0)
			local var_492_0 = 0.675

			if 0 < arg_489_1.time_ and arg_489_1.time_ <= 0 + arg_492_0 then
				arg_489_1.talkMaxDuration = 0
				arg_489_1.dialogCg_.alpha = 1

				arg_489_1.dialog_:SetActive(true)
				SetActive(arg_489_1.leftNameGo_, true)

				arg_489_1.leftNameTxt_.text = arg_489_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_489_1.leftNameTxt_.transform)

				arg_489_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_489_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_489_1:RecordName(arg_489_1.leftNameTxt_.text)
				SetActive(arg_489_1.iconTrs_.gameObject, false)
				arg_489_1.callingController_:SetSelectedState("normal")

				local var_492_1 = arg_489_1:GetWordFromCfg(926091118)
				local var_492_2 = arg_489_1:FormatText(var_492_1.content)

				arg_489_1.text_.text = var_492_2

				LuaForUtil.ClearLinePrefixSymbol(arg_489_1.text_)

				local var_492_4 = 27 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 27)

				if (27 <= 0 and var_492_0 or var_492_0 * (utf8.len(var_492_2) / 27)) > 0 and var_492_0 < var_492_4 then
					arg_489_1.talkMaxDuration = var_492_4

					if var_492_4 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_4 + 0
					end
				end

				arg_489_1.text_.text = var_492_2
				arg_489_1.typewritter.percent = 0

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091118", "story_v_out_926091.awb") ~= 0 then
					local var_492_5 = manager.audio:GetVoiceLength("story_v_out_926091", "926091118", "story_v_out_926091.awb") / 1000

					if var_492_5 + 0 > arg_489_1.duration_ then
						arg_489_1.duration_ = var_492_5 + 0
					end

					if var_492_1.prefab_name ~= "" and arg_489_1.actors_[var_492_1.prefab_name] ~= nil then
						local var_492_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_489_1.actors_[var_492_1.prefab_name].transform, "story_v_out_926091", "926091118", "story_v_out_926091.awb")

						arg_489_1:RecordAudio("926091118", var_492_6)
						arg_489_1:RecordAudio("926091118", var_492_6)
					else
						arg_489_1:AudioAction("play", "voice", "story_v_out_926091", "926091118", "story_v_out_926091.awb")
					end

					arg_489_1:RecordHistoryTalkVoice("story_v_out_926091", "926091118", "story_v_out_926091.awb")
				end

				arg_489_1:RecordContent(arg_489_1.text_.text)
			end

			local var_492_7 = math.max(var_492_0, arg_489_1.talkMaxDuration)

			if 0 <= arg_489_1.time_ and arg_489_1.time_ < 0 + var_492_7 then
				arg_489_1.typewritter.percent = (arg_489_1.time_ - 0) / var_492_7

				arg_489_1.typewritter:SetDirty()
			end

			if arg_489_1.time_ >= 0 + var_492_7 and arg_489_1.time_ < 0 + var_492_7 + arg_492_0 then
				arg_489_1.typewritter.percent = 1

				arg_489_1.typewritter:SetDirty()
				arg_489_1:ShowNextGo(true)
			end
		end

		arg_489_1.nodeConfigList_ = {}

		arg_489_1:InitPlayNodeList()
	end,
	Play926091119 = function(arg_493_0, arg_493_1)
		arg_493_1.time_ = 0
		arg_493_1.frameCnt_ = 0
		arg_493_1.state_ = "playing"
		arg_493_1.curTalkId_ = 926091119
		arg_493_1.duration_ = 5.97

		local var_493_0 = {
			zh = 5.966,
			ja = 5.366
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
				arg_493_0:Play926091120(arg_493_1)
			end
		end

		function arg_493_1.onSingleLineUpdate_(arg_496_0)
			if 0 < arg_493_1.time_ and arg_493_1.time_ <= 0 + arg_496_0 then
				arg_493_1.var_.moveOldPos10144 = arg_493_1.actors_["10144"].transform.localPosition
				arg_493_1.actors_["10144"].transform.localScale = Vector3.New(1, 1, 1)

				arg_493_1:CheckSpriteTmpPos("10144", 3)

				for iter_496_0 = 0, arg_493_1.actors_["10144"].transform.childCount - 1 do
					local var_496_0 = arg_493_1.actors_["10144"].transform:GetChild(iter_496_0)

					if var_496_0.name == "split_2" or not string.find(var_496_0.name, "split") then
						var_496_0.gameObject:SetActive(true)
					else
						var_496_0.gameObject:SetActive(false)
					end
				end
			end

			local var_496_1 = 0.001

			if 0 <= arg_493_1.time_ and arg_493_1.time_ < 0 + var_496_1 then
				arg_493_1.actors_["10144"].transform.localPosition = Vector3.Lerp(arg_493_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_493_1.time_ - 0) / var_496_1)
			end

			if arg_493_1.time_ >= 0 + var_496_1 and arg_493_1.time_ < 0 + var_496_1 + arg_496_0 then
				arg_493_1.actors_["10144"].transform.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_496_2 = 0
			local var_496_3 = 0.675

			if 0 < arg_493_1.time_ and arg_493_1.time_ <= var_496_2 + arg_496_0 then
				arg_493_1.talkMaxDuration = 0
				arg_493_1.dialogCg_.alpha = 1

				arg_493_1.dialog_:SetActive(true)
				SetActive(arg_493_1.leftNameGo_, true)

				arg_493_1.leftNameTxt_.text = arg_493_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_493_1.leftNameTxt_.transform)

				arg_493_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_493_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_493_1:RecordName(arg_493_1.leftNameTxt_.text)
				SetActive(arg_493_1.iconTrs_.gameObject, false)
				arg_493_1.callingController_:SetSelectedState("normal")

				local var_496_4 = arg_493_1:GetWordFromCfg(926091119)
				local var_496_5 = arg_493_1:FormatText(var_496_4.content)

				arg_493_1.text_.text = var_496_5

				LuaForUtil.ClearLinePrefixSymbol(arg_493_1.text_)

				local var_496_7 = 27 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_5) / 27)

				if (27 <= 0 and var_496_3 or var_496_3 * (utf8.len(var_496_5) / 27)) > 0 and var_496_3 < var_496_7 then
					arg_493_1.talkMaxDuration = var_496_7

					if var_496_7 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_7 + var_496_2
					end
				end

				arg_493_1.text_.text = var_496_5
				arg_493_1.typewritter.percent = 0

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091119", "story_v_out_926091.awb") ~= 0 then
					local var_496_8 = manager.audio:GetVoiceLength("story_v_out_926091", "926091119", "story_v_out_926091.awb") / 1000

					if var_496_8 + var_496_2 > arg_493_1.duration_ then
						arg_493_1.duration_ = var_496_8 + var_496_2
					end

					if var_496_4.prefab_name ~= "" and arg_493_1.actors_[var_496_4.prefab_name] ~= nil then
						local var_496_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_493_1.actors_[var_496_4.prefab_name].transform, "story_v_out_926091", "926091119", "story_v_out_926091.awb")

						arg_493_1:RecordAudio("926091119", var_496_9)
						arg_493_1:RecordAudio("926091119", var_496_9)
					else
						arg_493_1:AudioAction("play", "voice", "story_v_out_926091", "926091119", "story_v_out_926091.awb")
					end

					arg_493_1:RecordHistoryTalkVoice("story_v_out_926091", "926091119", "story_v_out_926091.awb")
				end

				arg_493_1:RecordContent(arg_493_1.text_.text)
			end

			local var_496_10 = math.max(var_496_3, arg_493_1.talkMaxDuration)

			if var_496_2 <= arg_493_1.time_ and arg_493_1.time_ < var_496_2 + var_496_10 then
				arg_493_1.typewritter.percent = (arg_493_1.time_ - var_496_2) / var_496_10

				arg_493_1.typewritter:SetDirty()
			end

			if arg_493_1.time_ >= var_496_2 + var_496_10 and arg_493_1.time_ < var_496_2 + var_496_10 + arg_496_0 then
				arg_493_1.typewritter.percent = 1

				arg_493_1.typewritter:SetDirty()
				arg_493_1:ShowNextGo(true)
			end
		end

		arg_493_1.nodeConfigList_ = {
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

		arg_493_1:InitPlayNodeList()
	end,
	Play926091120 = function(arg_497_0, arg_497_1)
		arg_497_1.time_ = 0
		arg_497_1.frameCnt_ = 0
		arg_497_1.state_ = "playing"
		arg_497_1.curTalkId_ = 926091120
		arg_497_1.duration_ = 1

		SetActive(arg_497_1.tipsGo_, false)

		function arg_497_1.onSingleLineFinish_()
			arg_497_1.onSingleLineUpdate_ = nil
			arg_497_1.onSingleLineFinish_ = nil
			arg_497_1.state_ = "waiting"

			SetActive(arg_497_1.choicesGo_, true)

			for iter_498_0, iter_498_1 in ipairs(arg_497_1.choices_) do
				SetActive(iter_498_1.go, iter_498_0 <= 2)
			end

			arg_497_1.choices_[1].txt.text = arg_497_1:FormatText(StoryChoiceCfg[1338].name)
			arg_497_1.choices_[2].txt.text = arg_497_1:FormatText(StoryChoiceCfg[1339].name)
		end

		function arg_497_1.playNext_(arg_499_0)
			if arg_499_0 == 1 then
				arg_497_0:Play926091121(arg_497_1)
			end

			if arg_499_0 == 2 then
				arg_497_0:Play926091121(arg_497_1)
			end

			arg_497_1:RecordChoiceLog(926091120, 1338, 1339)
		end

		function arg_497_1.onSingleLineUpdate_(arg_500_0)
			if 0 < arg_497_1.time_ and arg_497_1.time_ <= 0 + arg_500_0 and not isNil(arg_497_1.actors_["10144"]) and arg_497_1.var_.actorSpriteComps10144 == nil then
				arg_497_1.var_.actorSpriteComps10144 = arg_497_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_500_0 = 0.2

			if 0 <= arg_497_1.time_ and arg_497_1.time_ < 0 + var_500_0 and not isNil(arg_497_1.actors_["10144"]) then
				if arg_497_1.var_.actorSpriteComps10144 then
					for iter_500_0, iter_500_1 in pairs(arg_497_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_500_1 then
							if arg_497_1.isInRecall_ then
								iter_500_1.color = Color.New(Mathf.Lerp(iter_500_1.color.r, arg_497_1.hightColor2.r, (arg_497_1.time_ - 0) / var_500_0), Mathf.Lerp(iter_500_1.color.g, arg_497_1.hightColor2.g, (arg_497_1.time_ - 0) / var_500_0), (Mathf.Lerp(iter_500_1.color.b, arg_497_1.hightColor2.b, (arg_497_1.time_ - 0) / var_500_0)))
							else
								local var_500_1 = Mathf.Lerp(iter_500_1.color.r, 0.5, (arg_497_1.time_ - 0) / var_500_0)

								iter_500_1.color = Color.New(var_500_1, var_500_1, var_500_1)
							end
						end
					end
				end
			end

			if arg_497_1.time_ >= 0 + var_500_0 and arg_497_1.time_ < 0 + var_500_0 + arg_500_0 and not isNil(arg_497_1.actors_["10144"]) and arg_497_1.var_.actorSpriteComps10144 then
				for iter_500_2, iter_500_3 in pairs(arg_497_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_500_3 then
						iter_500_3.color = arg_497_1.isInRecall_ and (arg_497_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_497_1.var_.actorSpriteComps10144 = nil
			end
		end

		arg_497_1.nodeConfigList_ = {}

		arg_497_1:InitPlayNodeList()
	end,
	Play926091121 = function(arg_501_0, arg_501_1)
		arg_501_1.time_ = 0
		arg_501_1.frameCnt_ = 0
		arg_501_1.state_ = "playing"
		arg_501_1.curTalkId_ = 926091121
		arg_501_1.duration_ = 4

		local var_501_0 = {
			zh = 3.866,
			ja = 4
		}
		local var_501_1 = manager.audio:GetLocalizationFlag()

		if var_501_0[var_501_1] ~= nil then
			arg_501_1.duration_ = var_501_0[var_501_1]
		end

		SetActive(arg_501_1.tipsGo_, false)

		function arg_501_1.onSingleLineFinish_()
			arg_501_1.onSingleLineUpdate_ = nil
			arg_501_1.onSingleLineFinish_ = nil
			arg_501_1.state_ = "waiting"
		end

		function arg_501_1.playNext_(arg_503_0)
			if arg_503_0 == 1 then
				arg_501_0:Play926091122(arg_501_1)
			end
		end

		function arg_501_1.onSingleLineUpdate_(arg_504_0)
			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 and not isNil(arg_501_1.actors_["10144"]) and arg_501_1.var_.actorSpriteComps10144 == nil then
				arg_501_1.var_.actorSpriteComps10144 = arg_501_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_504_0 = 0.2

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_0 and not isNil(arg_501_1.actors_["10144"]) then
				if arg_501_1.var_.actorSpriteComps10144 then
					for iter_504_0, iter_504_1 in pairs(arg_501_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_504_1 then
							if arg_501_1.isInRecall_ then
								iter_504_1.color = Color.New(Mathf.Lerp(iter_504_1.color.r, arg_501_1.hightColor1.r, (arg_501_1.time_ - 0) / var_504_0), Mathf.Lerp(iter_504_1.color.g, arg_501_1.hightColor1.g, (arg_501_1.time_ - 0) / var_504_0), (Mathf.Lerp(iter_504_1.color.b, arg_501_1.hightColor1.b, (arg_501_1.time_ - 0) / var_504_0)))
							else
								local var_504_1 = Mathf.Lerp(iter_504_1.color.r, 1, (arg_501_1.time_ - 0) / var_504_0)

								iter_504_1.color = Color.New(var_504_1, var_504_1, var_504_1)
							end
						end
					end
				end
			end

			if arg_501_1.time_ >= 0 + var_504_0 and arg_501_1.time_ < 0 + var_504_0 + arg_504_0 and not isNil(arg_501_1.actors_["10144"]) and arg_501_1.var_.actorSpriteComps10144 then
				for iter_504_2, iter_504_3 in pairs(arg_501_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_504_3 then
						iter_504_3.color = arg_501_1.isInRecall_ and (arg_501_1.hightColor1 or Color.New(0.82, 0.77, 0.62)) or Color.New(1, 1, 1)
					end
				end

				arg_501_1.var_.actorSpriteComps10144 = nil
			end

			local var_504_2 = arg_501_1.actors_["10144"].transform

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= 0 + arg_504_0 then
				arg_501_1.var_.moveOldPos10144 = var_504_2.localPosition
				var_504_2.localScale = Vector3.New(1, 1, 1)

				arg_501_1:CheckSpriteTmpPos("10144", 3)

				for iter_504_4 = 0, var_504_2.childCount - 1 do
					local var_504_3 = var_504_2:GetChild(iter_504_4)

					if var_504_3.name == "" or not string.find(var_504_3.name, "split") then
						var_504_3.gameObject:SetActive(true)
					else
						var_504_3.gameObject:SetActive(false)
					end
				end
			end

			local var_504_4 = 0.001

			if 0 <= arg_501_1.time_ and arg_501_1.time_ < 0 + var_504_4 then
				var_504_2.localPosition = Vector3.Lerp(arg_501_1.var_.moveOldPos10144, Vector3.New(-31.5, -381.1, -285.9), (arg_501_1.time_ - 0) / var_504_4)
			end

			if arg_501_1.time_ >= 0 + var_504_4 and arg_501_1.time_ < 0 + var_504_4 + arg_504_0 then
				var_504_2.localPosition = Vector3.New(-31.5, -381.1, -285.9)
			end

			local var_504_5 = 0
			local var_504_6 = 0.3

			if 0 < arg_501_1.time_ and arg_501_1.time_ <= var_504_5 + arg_504_0 then
				arg_501_1.talkMaxDuration = 0
				arg_501_1.dialogCg_.alpha = 1

				arg_501_1.dialog_:SetActive(true)
				SetActive(arg_501_1.leftNameGo_, true)

				arg_501_1.leftNameTxt_.text = arg_501_1:FormatText(StoryNameCfg[1297].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_501_1.leftNameTxt_.transform)

				arg_501_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_501_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_501_1:RecordName(arg_501_1.leftNameTxt_.text)
				SetActive(arg_501_1.iconTrs_.gameObject, false)
				arg_501_1.callingController_:SetSelectedState("normal")

				local var_504_7 = arg_501_1:GetWordFromCfg(926091121)
				local var_504_8 = arg_501_1:FormatText(var_504_7.content)

				arg_501_1.text_.text = var_504_8

				LuaForUtil.ClearLinePrefixSymbol(arg_501_1.text_)

				local var_504_10 = 12 <= 0 and var_504_6 or var_504_6 * (utf8.len(var_504_8) / 12)

				if (12 <= 0 and var_504_6 or var_504_6 * (utf8.len(var_504_8) / 12)) > 0 and var_504_6 < var_504_10 then
					arg_501_1.talkMaxDuration = var_504_10

					if var_504_10 + var_504_5 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_10 + var_504_5
					end
				end

				arg_501_1.text_.text = var_504_8
				arg_501_1.typewritter.percent = 0

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_926091", "926091121", "story_v_out_926091.awb") ~= 0 then
					local var_504_11 = manager.audio:GetVoiceLength("story_v_out_926091", "926091121", "story_v_out_926091.awb") / 1000

					if var_504_11 + var_504_5 > arg_501_1.duration_ then
						arg_501_1.duration_ = var_504_11 + var_504_5
					end

					if var_504_7.prefab_name ~= "" and arg_501_1.actors_[var_504_7.prefab_name] ~= nil then
						local var_504_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_501_1.actors_[var_504_7.prefab_name].transform, "story_v_out_926091", "926091121", "story_v_out_926091.awb")

						arg_501_1:RecordAudio("926091121", var_504_12)
						arg_501_1:RecordAudio("926091121", var_504_12)
					else
						arg_501_1:AudioAction("play", "voice", "story_v_out_926091", "926091121", "story_v_out_926091.awb")
					end

					arg_501_1:RecordHistoryTalkVoice("story_v_out_926091", "926091121", "story_v_out_926091.awb")
				end

				arg_501_1:RecordContent(arg_501_1.text_.text)
			end

			local var_504_13 = math.max(var_504_6, arg_501_1.talkMaxDuration)

			if var_504_5 <= arg_501_1.time_ and arg_501_1.time_ < var_504_5 + var_504_13 then
				arg_501_1.typewritter.percent = (arg_501_1.time_ - var_504_5) / var_504_13

				arg_501_1.typewritter:SetDirty()
			end

			if arg_501_1.time_ >= var_504_5 + var_504_13 and arg_501_1.time_ < var_504_5 + var_504_13 + arg_504_0 then
				arg_501_1.typewritter.percent = 1

				arg_501_1.typewritter:SetDirty()
				arg_501_1:ShowNextGo(true)
			end
		end

		arg_501_1.nodeConfigList_ = {
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

		arg_501_1:InitPlayNodeList()
	end,
	Play926091122 = function(arg_505_0, arg_505_1)
		arg_505_1.time_ = 0
		arg_505_1.frameCnt_ = 0
		arg_505_1.state_ = "playing"
		arg_505_1.curTalkId_ = 926091122
		arg_505_1.duration_ = 5

		SetActive(arg_505_1.tipsGo_, false)

		function arg_505_1.onSingleLineFinish_()
			arg_505_1.onSingleLineUpdate_ = nil
			arg_505_1.onSingleLineFinish_ = nil
			arg_505_1.state_ = "waiting"
		end

		function arg_505_1.playNext_(arg_507_0)
			if arg_507_0 == 1 then
				arg_505_0:Play926091123(arg_505_1)
			end
		end

		function arg_505_1.onSingleLineUpdate_(arg_508_0)
			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 and not isNil(arg_505_1.actors_["10144"]) and arg_505_1.var_.actorSpriteComps10144 == nil then
				arg_505_1.var_.actorSpriteComps10144 = arg_505_1.actors_["10144"]:GetComponentsInChildren(typeof(Image), true)
			end

			local var_508_0 = 0.2

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_0 and not isNil(arg_505_1.actors_["10144"]) then
				if arg_505_1.var_.actorSpriteComps10144 then
					for iter_508_0, iter_508_1 in pairs(arg_505_1.var_.actorSpriteComps10144:ToTable()) do
						if iter_508_1 then
							if arg_505_1.isInRecall_ then
								iter_508_1.color = Color.New(Mathf.Lerp(iter_508_1.color.r, arg_505_1.hightColor2.r, (arg_505_1.time_ - 0) / var_508_0), Mathf.Lerp(iter_508_1.color.g, arg_505_1.hightColor2.g, (arg_505_1.time_ - 0) / var_508_0), (Mathf.Lerp(iter_508_1.color.b, arg_505_1.hightColor2.b, (arg_505_1.time_ - 0) / var_508_0)))
							else
								local var_508_1 = Mathf.Lerp(iter_508_1.color.r, 0.5, (arg_505_1.time_ - 0) / var_508_0)

								iter_508_1.color = Color.New(var_508_1, var_508_1, var_508_1)
							end
						end
					end
				end
			end

			if arg_505_1.time_ >= 0 + var_508_0 and arg_505_1.time_ < 0 + var_508_0 + arg_508_0 and not isNil(arg_505_1.actors_["10144"]) and arg_505_1.var_.actorSpriteComps10144 then
				for iter_508_2, iter_508_3 in pairs(arg_505_1.var_.actorSpriteComps10144:ToTable()) do
					if iter_508_3 then
						iter_508_3.color = arg_505_1.isInRecall_ and (arg_505_1.hightColor2 or Color.New(0.46, 0.43, 0.35)) or Color.New(0.5, 0.5, 0.5)
					end
				end

				arg_505_1.var_.actorSpriteComps10144 = nil
			end

			local var_508_2 = arg_505_1.actors_["10144"].transform

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= 0 + arg_508_0 then
				arg_505_1.var_.moveOldPos10144 = var_508_2.localPosition
				var_508_2.localScale = Vector3.New(1, 1, 1)

				arg_505_1:CheckSpriteTmpPos("10144", 7)

				for iter_508_4 = 0, var_508_2.childCount - 1 do
					local var_508_3 = var_508_2:GetChild(iter_508_4)

					if var_508_3.name == "" or not string.find(var_508_3.name, "split") then
						var_508_3.gameObject:SetActive(true)
					else
						var_508_3.gameObject:SetActive(false)
					end
				end
			end

			local var_508_4 = 0.001

			if 0 <= arg_505_1.time_ and arg_505_1.time_ < 0 + var_508_4 then
				var_508_2.localPosition = Vector3.Lerp(arg_505_1.var_.moveOldPos10144, Vector3.New(0, -2000, 0), (arg_505_1.time_ - 0) / var_508_4)
			end

			if arg_505_1.time_ >= 0 + var_508_4 and arg_505_1.time_ < 0 + var_508_4 + arg_508_0 then
				var_508_2.localPosition = Vector3.New(0, -2000, 0)
			end

			if 0.3 < arg_505_1.time_ and arg_505_1.time_ <= 0.3 + arg_508_0 then
				arg_505_1:AudioAction("play", "effect", "se_story_143", "se_story_143_fly", "")
			end

			local var_508_6 = 0
			local var_508_7 = 1.05

			if 0 < arg_505_1.time_ and arg_505_1.time_ <= var_508_6 + arg_508_0 then
				arg_505_1.talkMaxDuration = 0
				arg_505_1.dialogCg_.alpha = 1

				arg_505_1.dialog_:SetActive(true)
				SetActive(arg_505_1.leftNameGo_, false)

				arg_505_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_505_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_505_1:RecordName(arg_505_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_505_1.iconTrs_.gameObject, false)
				arg_505_1.callingController_:SetSelectedState("normal")

				local var_508_8 = arg_505_1:FormatText(arg_505_1:GetWordFromCfg(926091122).content)

				arg_505_1.text_.text = var_508_8

				LuaForUtil.ClearLinePrefixSymbol(arg_505_1.text_)

				local var_508_10 = 42 <= 0 and var_508_7 or var_508_7 * (utf8.len(var_508_8) / 42)

				if (42 <= 0 and var_508_7 or var_508_7 * (utf8.len(var_508_8) / 42)) > 0 and var_508_7 < var_508_10 then
					arg_505_1.talkMaxDuration = var_508_10

					if var_508_10 + var_508_6 > arg_505_1.duration_ then
						arg_505_1.duration_ = var_508_10 + var_508_6
					end
				end

				arg_505_1.text_.text = var_508_8
				arg_505_1.typewritter.percent = 0

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(false)
				arg_505_1:RecordContent(arg_505_1.text_.text)
			end

			local var_508_11 = math.max(var_508_7, arg_505_1.talkMaxDuration)

			if var_508_6 <= arg_505_1.time_ and arg_505_1.time_ < var_508_6 + var_508_11 then
				arg_505_1.typewritter.percent = (arg_505_1.time_ - var_508_6) / var_508_11

				arg_505_1.typewritter:SetDirty()
			end

			if arg_505_1.time_ >= var_508_6 + var_508_11 and arg_505_1.time_ < var_508_6 + var_508_11 + arg_508_0 then
				arg_505_1.typewritter.percent = 1

				arg_505_1.typewritter:SetDirty()
				arg_505_1:ShowNextGo(true)
			end
		end

		arg_505_1.nodeConfigList_ = {
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

		arg_505_1:InitPlayNodeList()
	end,
	Play926091123 = function(arg_509_0, arg_509_1)
		arg_509_1.time_ = 0
		arg_509_1.frameCnt_ = 0
		arg_509_1.state_ = "playing"
		arg_509_1.curTalkId_ = 926091123
		arg_509_1.duration_ = 5

		SetActive(arg_509_1.tipsGo_, false)

		function arg_509_1.onSingleLineFinish_()
			arg_509_1.onSingleLineUpdate_ = nil
			arg_509_1.onSingleLineFinish_ = nil
			arg_509_1.state_ = "waiting"
		end

		function arg_509_1.playNext_(arg_511_0)
			if arg_511_0 == 1 then
				arg_509_0:Play926091124(arg_509_1)
			end
		end

		function arg_509_1.onSingleLineUpdate_(arg_512_0)
			local var_512_0 = 1.4

			if 0 < arg_509_1.time_ and arg_509_1.time_ <= 0 + arg_512_0 then
				arg_509_1.talkMaxDuration = 0
				arg_509_1.dialogCg_.alpha = 1

				arg_509_1.dialog_:SetActive(true)
				SetActive(arg_509_1.leftNameGo_, false)

				arg_509_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_509_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_509_1:RecordName(arg_509_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_509_1.iconTrs_.gameObject, false)
				arg_509_1.callingController_:SetSelectedState("normal")

				local var_512_1 = arg_509_1:FormatText(arg_509_1:GetWordFromCfg(926091123).content)

				arg_509_1.text_.text = var_512_1

				LuaForUtil.ClearLinePrefixSymbol(arg_509_1.text_)

				local var_512_3 = 56 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 56)

				if (56 <= 0 and var_512_0 or var_512_0 * (utf8.len(var_512_1) / 56)) > 0 and var_512_0 < var_512_3 then
					arg_509_1.talkMaxDuration = var_512_3

					if var_512_3 + 0 > arg_509_1.duration_ then
						arg_509_1.duration_ = var_512_3 + 0
					end
				end

				arg_509_1.text_.text = var_512_1
				arg_509_1.typewritter.percent = 0

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(false)
				arg_509_1:RecordContent(arg_509_1.text_.text)
			end

			local var_512_4 = math.max(var_512_0, arg_509_1.talkMaxDuration)

			if 0 <= arg_509_1.time_ and arg_509_1.time_ < 0 + var_512_4 then
				arg_509_1.typewritter.percent = (arg_509_1.time_ - 0) / var_512_4

				arg_509_1.typewritter:SetDirty()
			end

			if arg_509_1.time_ >= 0 + var_512_4 and arg_509_1.time_ < 0 + var_512_4 + arg_512_0 then
				arg_509_1.typewritter.percent = 1

				arg_509_1.typewritter:SetDirty()
				arg_509_1:ShowNextGo(true)
			end
		end

		arg_509_1.nodeConfigList_ = {}

		arg_509_1:InitPlayNodeList()
	end,
	Play926091124 = function(arg_513_0, arg_513_1)
		arg_513_1.time_ = 0
		arg_513_1.frameCnt_ = 0
		arg_513_1.state_ = "playing"
		arg_513_1.curTalkId_ = 926091124
		arg_513_1.duration_ = 6.3

		SetActive(arg_513_1.tipsGo_, false)

		function arg_513_1.onSingleLineFinish_()
			arg_513_1.onSingleLineUpdate_ = nil
			arg_513_1.onSingleLineFinish_ = nil
			arg_513_1.state_ = "waiting"
		end

		function arg_513_1.playNext_(arg_515_0)
			if arg_515_0 == 1 then
				arg_513_0:Play926091125(arg_513_1)
			end
		end

		function arg_513_1.onSingleLineUpdate_(arg_516_0)
			if 0 < arg_513_1.time_ and arg_513_1.time_ <= 0 + arg_516_0 then
				arg_513_1.var_.moveOldPosST0108a = arg_513_1.bgs_.ST0108a.transform.localPosition
			end

			local var_516_0 = 0.1

			if 0 <= arg_513_1.time_ and arg_513_1.time_ < 0 + var_516_0 then
				arg_513_1.bgs_.ST0108a.transform.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPosST0108a, Vector3.New(0, 1, 10), (arg_513_1.time_ - 0) / var_516_0)
			end

			if arg_513_1.time_ >= 0 + var_516_0 and arg_513_1.time_ < 0 + var_516_0 + arg_516_0 then
				arg_513_1.bgs_.ST0108a.transform.localPosition = Vector3.New(0, 1, 10)
			end

			local var_516_1 = arg_513_1.bgs_.ST0108a.transform

			if 0.1 < arg_513_1.time_ and arg_513_1.time_ <= 0.1 + arg_516_0 then
				arg_513_1.var_.moveOldPosST0108a = var_516_1.localPosition
			end

			local var_516_2 = 2.93333333333333

			if 0.1 <= arg_513_1.time_ and arg_513_1.time_ < 0.1 + var_516_2 then
				var_516_1.localPosition = Vector3.Lerp(arg_513_1.var_.moveOldPosST0108a, Vector3.New(0, 1, 5.76), (arg_513_1.time_ - 0.1) / var_516_2)
			end

			if arg_513_1.time_ >= 0.1 + var_516_2 and arg_513_1.time_ < 0.1 + var_516_2 + arg_516_0 then
				var_516_1.localPosition = Vector3.New(0, 1, 5.76)
			end

			local var_516_3 = 0

			if 0 < arg_513_1.time_ and arg_513_1.time_ <= var_516_3 + arg_516_0 then
				arg_513_1.allBtn_.enabled = false
			end

			if arg_513_1.time_ >= var_516_3 + 3.033333333332 and arg_513_1.time_ < var_516_3 + 3.033333333332 + arg_516_0 then
				arg_513_1.allBtn_.enabled = true
			end

			if arg_513_1.frameCnt_ <= 1 then
				arg_513_1.dialog_:SetActive(false)
			end

			local var_516_4 = 1.3
			local var_516_5 = 0.725

			if 1.3 < arg_513_1.time_ and arg_513_1.time_ <= var_516_4 + arg_516_0 then
				arg_513_1.talkMaxDuration = 0

				arg_513_1.dialog_:SetActive(true)

				arg_513_1.dialogCg_.alpha = 0

				local var_516_6 = LeanTween.value(arg_513_1.dialog_, 0, 1, 0.3)

				var_516_6:setOnUpdate(LuaHelper.FloatAction(function(arg_517_0)
					arg_513_1.dialogCg_.alpha = arg_517_0
				end))
				var_516_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_513_1.dialog_)
					var_516_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_513_1.duration_ = arg_513_1.duration_ + 0.3

				SetActive(arg_513_1.leftNameGo_, false)

				arg_513_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_513_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_513_1:RecordName(arg_513_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_513_1.iconTrs_.gameObject, false)
				arg_513_1.callingController_:SetSelectedState("normal")

				local var_516_7 = arg_513_1:FormatText(arg_513_1:GetWordFromCfg(926091124).content)

				arg_513_1.text_.text = var_516_7

				LuaForUtil.ClearLinePrefixSymbol(arg_513_1.text_)

				local var_516_9 = 29 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 29)

				if (29 <= 0 and var_516_5 or var_516_5 * (utf8.len(var_516_7) / 29)) > 0 and var_516_5 < var_516_9 then
					arg_513_1.talkMaxDuration = var_516_9
					var_516_4 = var_516_4 + 0.3

					if var_516_9 + var_516_4 > arg_513_1.duration_ then
						arg_513_1.duration_ = var_516_9 + var_516_4
					end
				end

				arg_513_1.text_.text = var_516_7
				arg_513_1.typewritter.percent = 0

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(false)
				arg_513_1:RecordContent(arg_513_1.text_.text)
			end

			local var_516_10 = var_516_4 + 0.3
			local var_516_11 = math.max(var_516_5, arg_513_1.talkMaxDuration)

			if var_516_4 + 0.3 <= arg_513_1.time_ and arg_513_1.time_ < var_516_10 + var_516_11 then
				arg_513_1.typewritter.percent = (arg_513_1.time_ - var_516_10) / var_516_11

				arg_513_1.typewritter:SetDirty()
			end

			if arg_513_1.time_ >= var_516_10 + var_516_11 and arg_513_1.time_ < var_516_10 + var_516_11 + arg_516_0 then
				arg_513_1.typewritter.percent = 1

				arg_513_1.typewritter:SetDirty()
				arg_513_1:ShowNextGo(true)
			end
		end

		arg_513_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ST0108a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ST0108a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 2.93333333333333,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_513_1:InitPlayNodeList()
	end,
	Play926091125 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 926091125
		arg_519_1.duration_ = 5

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play926091126(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 1.1

			if 0 < arg_519_1.time_ and arg_519_1.time_ <= 0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, false)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_1 = arg_519_1:FormatText(arg_519_1:GetWordFromCfg(926091125).content)

				arg_519_1.text_.text = var_522_1

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_3 = 44 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 44)

				if (44 <= 0 and var_522_0 or var_522_0 * (utf8.len(var_522_1) / 44)) > 0 and var_522_0 < var_522_3 then
					arg_519_1.talkMaxDuration = var_522_3

					if var_522_3 + 0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_3 + 0
					end
				end

				arg_519_1.text_.text = var_522_1
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)
				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_4 = math.max(var_522_0, arg_519_1.talkMaxDuration)

			if 0 <= arg_519_1.time_ and arg_519_1.time_ < 0 + var_522_4 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - 0) / var_522_4

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= 0 + var_522_4 and arg_519_1.time_ < 0 + var_522_4 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end

		arg_519_1.nodeConfigList_ = {}

		arg_519_1:InitPlayNodeList()
	end,
	Play926091126 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 926091126
		arg_523_1.duration_ = 5

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
			local var_526_0 = 0.15

			if 0 < arg_523_1.time_ and arg_523_1.time_ <= 0 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				arg_523_1.leftNameTxt_.text = arg_523_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_523_1.callingController_:SetSelectedState("normal")

				arg_523_1.keyicon_.color = Color.New(1, 1, 1)
				arg_523_1.icon_.color = Color.New(1, 1, 1)

				local var_526_1 = arg_523_1:FormatText(arg_523_1:GetWordFromCfg(926091126).content)

				arg_523_1.text_.text = var_526_1

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_3 = 6 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 6)

				if (6 <= 0 and var_526_0 or var_526_0 * (utf8.len(var_526_1) / 6)) > 0 and var_526_0 < var_526_3 then
					arg_523_1.talkMaxDuration = var_526_3

					if var_526_3 + 0 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_3 + 0
					end
				end

				arg_523_1.text_.text = var_526_1
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)
				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_4 = math.max(var_526_0, arg_523_1.talkMaxDuration)

			if 0 <= arg_523_1.time_ and arg_523_1.time_ < 0 + var_526_4 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - 0) / var_526_4

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= 0 + var_526_4 and arg_523_1.time_ < 0 + var_526_4 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end

		arg_523_1.nodeConfigList_ = {}

		arg_523_1:InitPlayNodeList()
	end,
	Play926091082 = function(arg_527_0, arg_527_1)
		arg_527_1.time_ = 0
		arg_527_1.frameCnt_ = 0
		arg_527_1.state_ = "playing"
		arg_527_1.curTalkId_ = 926091082
		arg_527_1.duration_ = 5

		SetActive(arg_527_1.tipsGo_, false)

		function arg_527_1.onSingleLineFinish_()
			arg_527_1.onSingleLineUpdate_ = nil
			arg_527_1.onSingleLineFinish_ = nil
			arg_527_1.state_ = "waiting"
		end

		function arg_527_1.playNext_(arg_529_0)
			if arg_529_0 == 1 then
				arg_527_0:Play926091083(arg_527_1)
			end
		end

		function arg_527_1.onSingleLineUpdate_(arg_530_0)
			local var_530_0 = 0.55

			if 0 < arg_527_1.time_ and arg_527_1.time_ <= 0 + arg_530_0 then
				arg_527_1.talkMaxDuration = 0
				arg_527_1.dialogCg_.alpha = 1

				arg_527_1.dialog_:SetActive(true)
				SetActive(arg_527_1.leftNameGo_, true)

				arg_527_1.leftNameTxt_.text = arg_527_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_527_1.leftNameTxt_.transform)

				arg_527_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_527_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_527_1:RecordName(arg_527_1.leftNameTxt_.text)
				SetActive(arg_527_1.iconTrs_.gameObject, true)
				arg_527_1.iconController_:SetSelectedState("hero")

				arg_527_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_527_1.callingController_:SetSelectedState("normal")

				arg_527_1.keyicon_.color = Color.New(1, 1, 1)
				arg_527_1.icon_.color = Color.New(1, 1, 1)

				local var_530_1 = arg_527_1:FormatText(arg_527_1:GetWordFromCfg(926091082).content)

				arg_527_1.text_.text = var_530_1

				LuaForUtil.ClearLinePrefixSymbol(arg_527_1.text_)

				local var_530_3 = 22 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 22)

				if (22 <= 0 and var_530_0 or var_530_0 * (utf8.len(var_530_1) / 22)) > 0 and var_530_0 < var_530_3 then
					arg_527_1.talkMaxDuration = var_530_3

					if var_530_3 + 0 > arg_527_1.duration_ then
						arg_527_1.duration_ = var_530_3 + 0
					end
				end

				arg_527_1.text_.text = var_530_1
				arg_527_1.typewritter.percent = 0

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(false)
				arg_527_1:RecordContent(arg_527_1.text_.text)
			end

			local var_530_4 = math.max(var_530_0, arg_527_1.talkMaxDuration)

			if 0 <= arg_527_1.time_ and arg_527_1.time_ < 0 + var_530_4 then
				arg_527_1.typewritter.percent = (arg_527_1.time_ - 0) / var_530_4

				arg_527_1.typewritter:SetDirty()
			end

			if arg_527_1.time_ >= 0 + var_530_4 and arg_527_1.time_ < 0 + var_530_4 + arg_530_0 then
				arg_527_1.typewritter.percent = 1

				arg_527_1.typewritter:SetDirty()
				arg_527_1:ShowNextGo(true)
			end
		end

		arg_527_1.nodeConfigList_ = {}

		arg_527_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I22g",
		"TextureConfig/Background/ST0114",
		"TextureConfig/Background/I21f",
		"TextureConfig/Background/I20f",
		"TextureConfig/Background/SP92602",
		"TextureConfig/Background/ST0108a"
	},
	voices = {
		"story_v_out_926091.awb"
	}
}
