return {
	Play324072001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324072001
		arg_1_1.duration_ = 3.83

		local var_1_0 = {
			zh = 3.4,
			ja = 3.833
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
				arg_1_0:Play324072002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.MS2403 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2403")
				var_4_0.name = "MS2403"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.MS2403 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.MS2403

				arg_1_1.bgs_.MS2403.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2403" then
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

			local var_4_5 = 1.7

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

			local var_4_8 = "1070ui_story"

			if arg_1_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_1_1.stage_.transform)

				var_4_9.name = var_4_8
				var_4_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_8] = var_4_9

				local var_4_10 = var_4_9:GetComponentInChildren(typeof(CharacterEffect))

				var_4_10.enabled = true

				local var_4_11 = GameObjectTools.GetOrAddComponent(var_4_9, typeof(DynamicBoneHelper))

				if var_4_11 then
					var_4_11:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_10.transform, false)

				arg_1_1.var_[var_4_8 .. "Animator"] = var_4_10.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_8 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_8 .. "LipSync"] = var_4_10.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_12 = arg_1_1.actors_["1070ui_story"]

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect1070ui_story == nil then
				arg_1_1.var_.characterEffect1070ui_story = var_4_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_13 = 0.200000002980232

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 and not isNil(var_4_12) then
				if arg_1_1.var_.characterEffect1070ui_story and not isNil(var_4_12) then
					arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and not isNil(var_4_12) and arg_1_1.var_.characterEffect1070ui_story then
				arg_1_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_4_15 = arg_1_1.bgs_.MS2403.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2403 = var_4_15.localPosition
			end

			local var_4_16 = 0.8

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_16 then
				var_4_15.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2403, Vector3.New(-4.16, 2.29, 0.54), (arg_1_1.time_ - 0) / var_4_16)
			end

			if arg_1_1.time_ >= 0 + var_4_16 and arg_1_1.time_ < 0 + var_4_16 + arg_4_0 then
				var_4_15.localPosition = Vector3.New(-4.16, 2.29, 0.54)
			end

			local var_4_17 = arg_1_1.bgs_.MS2403.transform

			if 0.8 < arg_1_1.time_ and arg_1_1.time_ <= 0.8 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2403 = var_4_17.localPosition
			end

			local var_4_18 = 1.79166666666667

			if 0.8 <= arg_1_1.time_ and arg_1_1.time_ < 0.8 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2403, Vector3.New(-3.23, 0.61, 1.64), (arg_1_1.time_ - 0.8) / var_4_18)
			end

			if arg_1_1.time_ >= 0.8 + var_4_18 and arg_1_1.time_ < 0.8 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(-3.23, 0.61, 1.64)
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_5_0_story_qiulingong", "bgm_activity_5_0_story_qiulingong")

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

			local var_4_24 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_24 + 2.591666666666 and arg_1_1.time_ < var_4_24 + 2.591666666666 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2.1
			local var_4_26 = 0.075

			if 2.1 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_27 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_27:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_27:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_27:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, true)
				arg_1_1.iconController_:SetSelectedState("hero")

				arg_1_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_1_1.callingController_:SetSelectedState("normal")

				arg_1_1.keyicon_.color = Color.New(1, 1, 1)
				arg_1_1.icon_.color = Color.New(1, 1, 1)

				local var_4_28 = arg_1_1:GetWordFromCfg(324072001)
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

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072001", "story_v_out_324072.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_324072", "324072001", "story_v_out_324072.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_324072", "324072001", "story_v_out_324072.awb")

						arg_1_1:RecordAudio("324072001", var_4_33)
						arg_1_1:RecordAudio("324072001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_324072", "324072001", "story_v_out_324072.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_324072", "324072001", "story_v_out_324072.awb")
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
				needEase = true,
				actorName = "MS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.8,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-4.16, 2.29, 0.54),
					endPos = Vector3.New(-4.16, 2.29, 0.54),
					easeType = LeanTweenType.easeInOutExpo
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 0.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-4.16, 2.29, 0.54),
					endPos = Vector3.New(-3.23, 0.61, 1.64),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324072002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324072002
		arg_8_1.duration_ = 3.43

		local var_8_0 = {
			zh = 3.4,
			ja = 3.433
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
				arg_8_0:Play324072003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1036ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1036ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1036ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1036ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1036ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1070ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1070ui_story == nil then
				arg_8_1.var_.characterEffect1070ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect1070ui_story and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1070ui_story then
				arg_8_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_11_8 = 0
			local var_11_9 = 0.45

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_8 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_10 = arg_8_1:GetWordFromCfg(324072002)
				local var_11_11 = arg_8_1:FormatText(var_11_10.content)

				arg_8_1.text_.text = var_11_11

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_13 = 18 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 18)

				if (18 <= 0 and var_11_9 or var_11_9 * (utf8.len(var_11_11) / 18)) > 0 and var_11_9 < var_11_13 then
					arg_8_1.talkMaxDuration = var_11_13

					if var_11_13 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_13 + var_11_8
					end
				end

				arg_8_1.text_.text = var_11_11
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072002", "story_v_out_324072.awb") ~= 0 then
					local var_11_14 = manager.audio:GetVoiceLength("story_v_out_324072", "324072002", "story_v_out_324072.awb") / 1000

					if var_11_14 + var_11_8 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_14 + var_11_8
					end

					if var_11_10.prefab_name ~= "" and arg_8_1.actors_[var_11_10.prefab_name] ~= nil then
						local var_11_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_10.prefab_name].transform, "story_v_out_324072", "324072002", "story_v_out_324072.awb")

						arg_8_1:RecordAudio("324072002", var_11_15)
						arg_8_1:RecordAudio("324072002", var_11_15)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324072", "324072002", "story_v_out_324072.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324072", "324072002", "story_v_out_324072.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_16 = math.max(var_11_9, arg_8_1.talkMaxDuration)

			if var_11_8 <= arg_8_1.time_ and arg_8_1.time_ < var_11_8 + var_11_16 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_8) / var_11_16

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_8 + var_11_16 and arg_8_1.time_ < var_11_8 + var_11_16 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324072003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324072003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324072004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1036ui_story"]) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = arg_12_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1036ui_story"]) then
				if arg_12_1.var_.characterEffect1036ui_story and not isNil(arg_12_1.actors_["1036ui_story"]) then
					arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1036ui_story"]) and arg_12_1.var_.characterEffect1036ui_story then
				arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.05

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("calling")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324072003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 2 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 2)

				if (2 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 2)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play324072004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324072004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324072005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 1.45

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(324072004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 58 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 58)

				if (58 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 58)) > 0 and var_19_0 < var_19_3 then
					arg_16_1.talkMaxDuration = var_19_3

					if var_19_3 + 0 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_3 + 0
					end
				end

				arg_16_1.text_.text = var_19_1
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_4 = math.max(var_19_0, arg_16_1.talkMaxDuration)

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - 0) / var_19_4

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play324072005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324072005
		arg_20_1.duration_ = 3.95

		local var_20_0 = {
			zh = 3.61245079673827,
			ja = 3.94545079673827
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
				arg_20_0:Play324072006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if arg_20_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_23_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_20_1.stage_.transform)

				var_23_0.name = "1037ui_story"
				var_23_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_20_1.actors_["1037ui_story"] = var_23_0

				local var_23_1 = var_23_0:GetComponentInChildren(typeof(CharacterEffect))

				var_23_1.enabled = true

				local var_23_2 = GameObjectTools.GetOrAddComponent(var_23_0, typeof(DynamicBoneHelper))

				if var_23_2 then
					var_23_2:EnableDynamicBone(false)
				end

				arg_20_1:ShowWeapon(var_23_1.transform, false)

				arg_20_1.var_["1037ui_story" .. "Animator"] = var_23_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_20_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_20_1.var_["1037ui_story" .. "LipSync"] = var_23_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_23_3 = arg_20_1.actors_["1037ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1037ui_story == nil then
				arg_20_1.var_.characterEffect1037ui_story = var_23_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_4 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 and not isNil(var_23_3) then
				if arg_20_1.var_.characterEffect1037ui_story and not isNil(var_23_3) then
					arg_20_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 and not isNil(var_23_3) and arg_20_1.var_.characterEffect1037ui_story then
				arg_20_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_23_6 = arg_20_1.bgs_.MS2403.transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPosMS2403 = var_23_6.localPosition
			end

			local var_23_7 = 1.79166666666667

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPosMS2403, Vector3.New(1.35, 0, 5), (arg_20_1.time_ - 0) / var_23_7)
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(1.35, 0, 5)
			end

			local var_23_8 = 0

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.allBtn_.enabled = false
			end

			if arg_20_1.time_ >= var_23_8 + 1.71245079673827 and arg_20_1.time_ < var_23_8 + 1.71245079673827 + arg_23_0 then
				arg_20_1.allBtn_.enabled = true
			end

			if arg_20_1.frameCnt_ <= 1 then
				arg_20_1.dialog_:SetActive(false)
			end

			local var_23_9 = 1.51245079673827
			local var_23_10 = 0.2

			if 1.51245079673827 < arg_20_1.time_ and arg_20_1.time_ <= var_23_9 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0

				arg_20_1.dialog_:SetActive(true)

				arg_20_1.dialogCg_.alpha = 0

				local var_23_11 = LeanTween.value(arg_20_1.dialog_, 0, 1, 0.3)

				var_23_11:setOnUpdate(LuaHelper.FloatAction(function(arg_24_0)
					arg_20_1.dialogCg_.alpha = arg_24_0
				end))
				var_23_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_20_1.dialog_)
					var_23_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_20_1.duration_ = arg_20_1.duration_ + 0.3

				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_12 = arg_20_1:GetWordFromCfg(324072005)
				local var_23_13 = arg_20_1:FormatText(var_23_12.content)

				arg_20_1.text_.text = var_23_13

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_15 = 8 <= 0 and var_23_10 or var_23_10 * (utf8.len(var_23_13) / 8)

				if (8 <= 0 and var_23_10 or var_23_10 * (utf8.len(var_23_13) / 8)) > 0 and var_23_10 < var_23_15 then
					arg_20_1.talkMaxDuration = var_23_15
					var_23_9 = var_23_9 + 0.3

					if var_23_15 + var_23_9 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_15 + var_23_9
					end
				end

				arg_20_1.text_.text = var_23_13
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072005", "story_v_out_324072.awb") ~= 0 then
					local var_23_16 = manager.audio:GetVoiceLength("story_v_out_324072", "324072005", "story_v_out_324072.awb") / 1000

					if var_23_16 + var_23_9 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_16 + var_23_9
					end

					if var_23_12.prefab_name ~= "" and arg_20_1.actors_[var_23_12.prefab_name] ~= nil then
						local var_23_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_12.prefab_name].transform, "story_v_out_324072", "324072005", "story_v_out_324072.awb")

						arg_20_1:RecordAudio("324072005", var_23_17)
						arg_20_1:RecordAudio("324072005", var_23_17)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_324072", "324072005", "story_v_out_324072.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_324072", "324072005", "story_v_out_324072.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_18 = var_23_9 + 0.3
			local var_23_19 = math.max(var_23_10, arg_20_1.talkMaxDuration)

			if var_23_9 + 0.3 <= arg_20_1.time_ and arg_20_1.time_ < var_23_18 + var_23_19 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_18) / var_23_19

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_18 + var_23_19 and arg_20_1.time_ < var_23_18 + var_23_19 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(-3.23, 0.61, 1.64),
					endPos = Vector3.New(1.35, 0, 5),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play324072006 = function(arg_26_0, arg_26_1)
		arg_26_1.time_ = 0
		arg_26_1.frameCnt_ = 0
		arg_26_1.state_ = "playing"
		arg_26_1.curTalkId_ = 324072006
		arg_26_1.duration_ = 3.83

		local var_26_0 = {
			zh = 3.7,
			ja = 3.833
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
				arg_26_0:Play324072007(arg_26_1)
			end
		end

		function arg_26_1.onSingleLineUpdate_(arg_29_0)
			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(arg_26_1.actors_["1036ui_story"]) and arg_26_1.var_.characterEffect1036ui_story == nil then
				arg_26_1.var_.characterEffect1036ui_story = arg_26_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_0 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_0 and not isNil(arg_26_1.actors_["1036ui_story"]) then
				if arg_26_1.var_.characterEffect1036ui_story and not isNil(arg_26_1.actors_["1036ui_story"]) then
					arg_26_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_26_1.time_ >= 0 + var_29_0 and arg_26_1.time_ < 0 + var_29_0 + arg_29_0 and not isNil(arg_26_1.actors_["1036ui_story"]) and arg_26_1.var_.characterEffect1036ui_story then
				arg_26_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_29_2 = arg_26_1.actors_["1037ui_story"]

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= 0 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.characterEffect1037ui_story == nil then
				arg_26_1.var_.characterEffect1037ui_story = var_29_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_29_3 = 0.200000002980232

			if 0 <= arg_26_1.time_ and arg_26_1.time_ < 0 + var_29_3 and not isNil(var_29_2) then
				if arg_26_1.var_.characterEffect1037ui_story and not isNil(var_29_2) then
					arg_26_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_26_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_26_1.time_ - 0) / var_29_3)
				end
			end

			if arg_26_1.time_ >= 0 + var_29_3 and arg_26_1.time_ < 0 + var_29_3 + arg_29_0 and not isNil(var_29_2) and arg_26_1.var_.characterEffect1037ui_story then
				arg_26_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_26_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_29_4 = 0
			local var_29_5 = 0.3

			if 0 < arg_26_1.time_ and arg_26_1.time_ <= var_29_4 + arg_29_0 then
				arg_26_1.talkMaxDuration = 0
				arg_26_1.dialogCg_.alpha = 1

				arg_26_1.dialog_:SetActive(true)
				SetActive(arg_26_1.leftNameGo_, true)

				arg_26_1.leftNameTxt_.text = arg_26_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_26_1.leftNameTxt_.transform)

				arg_26_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_26_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_26_1:RecordName(arg_26_1.leftNameTxt_.text)
				SetActive(arg_26_1.iconTrs_.gameObject, false)
				arg_26_1.callingController_:SetSelectedState("normal")

				local var_29_6 = arg_26_1:GetWordFromCfg(324072006)
				local var_29_7 = arg_26_1:FormatText(var_29_6.content)

				arg_26_1.text_.text = var_29_7

				LuaForUtil.ClearLinePrefixSymbol(arg_26_1.text_)

				local var_29_9 = 12 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 12)

				if (12 <= 0 and var_29_5 or var_29_5 * (utf8.len(var_29_7) / 12)) > 0 and var_29_5 < var_29_9 then
					arg_26_1.talkMaxDuration = var_29_9

					if var_29_9 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_9 + var_29_4
					end
				end

				arg_26_1.text_.text = var_29_7
				arg_26_1.typewritter.percent = 0

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072006", "story_v_out_324072.awb") ~= 0 then
					local var_29_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072006", "story_v_out_324072.awb") / 1000

					if var_29_10 + var_29_4 > arg_26_1.duration_ then
						arg_26_1.duration_ = var_29_10 + var_29_4
					end

					if var_29_6.prefab_name ~= "" and arg_26_1.actors_[var_29_6.prefab_name] ~= nil then
						local var_29_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_26_1.actors_[var_29_6.prefab_name].transform, "story_v_out_324072", "324072006", "story_v_out_324072.awb")

						arg_26_1:RecordAudio("324072006", var_29_11)
						arg_26_1:RecordAudio("324072006", var_29_11)
					else
						arg_26_1:AudioAction("play", "voice", "story_v_out_324072", "324072006", "story_v_out_324072.awb")
					end

					arg_26_1:RecordHistoryTalkVoice("story_v_out_324072", "324072006", "story_v_out_324072.awb")
				end

				arg_26_1:RecordContent(arg_26_1.text_.text)
			end

			local var_29_12 = math.max(var_29_5, arg_26_1.talkMaxDuration)

			if var_29_4 <= arg_26_1.time_ and arg_26_1.time_ < var_29_4 + var_29_12 then
				arg_26_1.typewritter.percent = (arg_26_1.time_ - var_29_4) / var_29_12

				arg_26_1.typewritter:SetDirty()
			end

			if arg_26_1.time_ >= var_29_4 + var_29_12 and arg_26_1.time_ < var_29_4 + var_29_12 + arg_29_0 then
				arg_26_1.typewritter.percent = 1

				arg_26_1.typewritter:SetDirty()
				arg_26_1:ShowNextGo(true)
			end
		end

		arg_26_1.nodeConfigList_ = {}

		arg_26_1:InitPlayNodeList()
	end,
	Play324072007 = function(arg_30_0, arg_30_1)
		arg_30_1.time_ = 0
		arg_30_1.frameCnt_ = 0
		arg_30_1.state_ = "playing"
		arg_30_1.curTalkId_ = 324072007
		arg_30_1.duration_ = 9.17

		local var_30_0 = {
			zh = 8,
			ja = 9.166
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
				arg_30_0:Play324072008(arg_30_1)
			end
		end

		function arg_30_1.onSingleLineUpdate_(arg_33_0)
			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(arg_30_1.actors_["1037ui_story"]) and arg_30_1.var_.characterEffect1037ui_story == nil then
				arg_30_1.var_.characterEffect1037ui_story = arg_30_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_0 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_0 and not isNil(arg_30_1.actors_["1037ui_story"]) then
				if arg_30_1.var_.characterEffect1037ui_story and not isNil(arg_30_1.actors_["1037ui_story"]) then
					arg_30_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_30_1.time_ >= 0 + var_33_0 and arg_30_1.time_ < 0 + var_33_0 + arg_33_0 and not isNil(arg_30_1.actors_["1037ui_story"]) and arg_30_1.var_.characterEffect1037ui_story then
				arg_30_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_33_2 = arg_30_1.actors_["1036ui_story"]

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= 0 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.characterEffect1036ui_story == nil then
				arg_30_1.var_.characterEffect1036ui_story = var_33_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_33_3 = 0.200000002980232

			if 0 <= arg_30_1.time_ and arg_30_1.time_ < 0 + var_33_3 and not isNil(var_33_2) then
				if arg_30_1.var_.characterEffect1036ui_story and not isNil(var_33_2) then
					arg_30_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_30_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_30_1.time_ - 0) / var_33_3)
				end
			end

			if arg_30_1.time_ >= 0 + var_33_3 and arg_30_1.time_ < 0 + var_33_3 + arg_33_0 and not isNil(var_33_2) and arg_30_1.var_.characterEffect1036ui_story then
				arg_30_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_30_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_33_4 = 0
			local var_33_5 = 0.95

			if 0 < arg_30_1.time_ and arg_30_1.time_ <= var_33_4 + arg_33_0 then
				arg_30_1.talkMaxDuration = 0
				arg_30_1.dialogCg_.alpha = 1

				arg_30_1.dialog_:SetActive(true)
				SetActive(arg_30_1.leftNameGo_, true)

				arg_30_1.leftNameTxt_.text = arg_30_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_30_1.leftNameTxt_.transform)

				arg_30_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_30_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_30_1:RecordName(arg_30_1.leftNameTxt_.text)
				SetActive(arg_30_1.iconTrs_.gameObject, false)
				arg_30_1.callingController_:SetSelectedState("normal")

				local var_33_6 = arg_30_1:GetWordFromCfg(324072007)
				local var_33_7 = arg_30_1:FormatText(var_33_6.content)

				arg_30_1.text_.text = var_33_7

				LuaForUtil.ClearLinePrefixSymbol(arg_30_1.text_)

				local var_33_9 = 38 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 38)

				if (38 <= 0 and var_33_5 or var_33_5 * (utf8.len(var_33_7) / 38)) > 0 and var_33_5 < var_33_9 then
					arg_30_1.talkMaxDuration = var_33_9

					if var_33_9 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_9 + var_33_4
					end
				end

				arg_30_1.text_.text = var_33_7
				arg_30_1.typewritter.percent = 0

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072007", "story_v_out_324072.awb") ~= 0 then
					local var_33_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072007", "story_v_out_324072.awb") / 1000

					if var_33_10 + var_33_4 > arg_30_1.duration_ then
						arg_30_1.duration_ = var_33_10 + var_33_4
					end

					if var_33_6.prefab_name ~= "" and arg_30_1.actors_[var_33_6.prefab_name] ~= nil then
						local var_33_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_30_1.actors_[var_33_6.prefab_name].transform, "story_v_out_324072", "324072007", "story_v_out_324072.awb")

						arg_30_1:RecordAudio("324072007", var_33_11)
						arg_30_1:RecordAudio("324072007", var_33_11)
					else
						arg_30_1:AudioAction("play", "voice", "story_v_out_324072", "324072007", "story_v_out_324072.awb")
					end

					arg_30_1:RecordHistoryTalkVoice("story_v_out_324072", "324072007", "story_v_out_324072.awb")
				end

				arg_30_1:RecordContent(arg_30_1.text_.text)
			end

			local var_33_12 = math.max(var_33_5, arg_30_1.talkMaxDuration)

			if var_33_4 <= arg_30_1.time_ and arg_30_1.time_ < var_33_4 + var_33_12 then
				arg_30_1.typewritter.percent = (arg_30_1.time_ - var_33_4) / var_33_12

				arg_30_1.typewritter:SetDirty()
			end

			if arg_30_1.time_ >= var_33_4 + var_33_12 and arg_30_1.time_ < var_33_4 + var_33_12 + arg_33_0 then
				arg_30_1.typewritter.percent = 1

				arg_30_1.typewritter:SetDirty()
				arg_30_1:ShowNextGo(true)
			end
		end

		arg_30_1.nodeConfigList_ = {}

		arg_30_1:InitPlayNodeList()
	end,
	Play324072008 = function(arg_34_0, arg_34_1)
		arg_34_1.time_ = 0
		arg_34_1.frameCnt_ = 0
		arg_34_1.state_ = "playing"
		arg_34_1.curTalkId_ = 324072008
		arg_34_1.duration_ = 2.9

		local var_34_0 = {
			zh = 2.166,
			ja = 2.9
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
				arg_34_0:Play324072009(arg_34_1)
			end
		end

		function arg_34_1.onSingleLineUpdate_(arg_37_0)
			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(arg_34_1.actors_["1036ui_story"]) and arg_34_1.var_.characterEffect1036ui_story == nil then
				arg_34_1.var_.characterEffect1036ui_story = arg_34_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_0 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_0 and not isNil(arg_34_1.actors_["1036ui_story"]) then
				if arg_34_1.var_.characterEffect1036ui_story and not isNil(arg_34_1.actors_["1036ui_story"]) then
					arg_34_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_34_1.time_ >= 0 + var_37_0 and arg_34_1.time_ < 0 + var_37_0 + arg_37_0 and not isNil(arg_34_1.actors_["1036ui_story"]) and arg_34_1.var_.characterEffect1036ui_story then
				arg_34_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_37_2 = arg_34_1.actors_["1037ui_story"]

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= 0 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect1037ui_story == nil then
				arg_34_1.var_.characterEffect1037ui_story = var_37_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_37_3 = 0.200000002980232

			if 0 <= arg_34_1.time_ and arg_34_1.time_ < 0 + var_37_3 and not isNil(var_37_2) then
				if arg_34_1.var_.characterEffect1037ui_story and not isNil(var_37_2) then
					arg_34_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_34_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_34_1.time_ - 0) / var_37_3)
				end
			end

			if arg_34_1.time_ >= 0 + var_37_3 and arg_34_1.time_ < 0 + var_37_3 + arg_37_0 and not isNil(var_37_2) and arg_34_1.var_.characterEffect1037ui_story then
				arg_34_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_34_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_37_4 = 0
			local var_37_5 = 0.25

			if 0 < arg_34_1.time_ and arg_34_1.time_ <= var_37_4 + arg_37_0 then
				arg_34_1.talkMaxDuration = 0
				arg_34_1.dialogCg_.alpha = 1

				arg_34_1.dialog_:SetActive(true)
				SetActive(arg_34_1.leftNameGo_, true)

				arg_34_1.leftNameTxt_.text = arg_34_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_34_1.leftNameTxt_.transform)

				arg_34_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_34_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_34_1:RecordName(arg_34_1.leftNameTxt_.text)
				SetActive(arg_34_1.iconTrs_.gameObject, false)
				arg_34_1.callingController_:SetSelectedState("normal")

				local var_37_6 = arg_34_1:GetWordFromCfg(324072008)
				local var_37_7 = arg_34_1:FormatText(var_37_6.content)

				arg_34_1.text_.text = var_37_7

				LuaForUtil.ClearLinePrefixSymbol(arg_34_1.text_)

				local var_37_9 = 10 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 10)

				if (10 <= 0 and var_37_5 or var_37_5 * (utf8.len(var_37_7) / 10)) > 0 and var_37_5 < var_37_9 then
					arg_34_1.talkMaxDuration = var_37_9

					if var_37_9 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_9 + var_37_4
					end
				end

				arg_34_1.text_.text = var_37_7
				arg_34_1.typewritter.percent = 0

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072008", "story_v_out_324072.awb") ~= 0 then
					local var_37_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072008", "story_v_out_324072.awb") / 1000

					if var_37_10 + var_37_4 > arg_34_1.duration_ then
						arg_34_1.duration_ = var_37_10 + var_37_4
					end

					if var_37_6.prefab_name ~= "" and arg_34_1.actors_[var_37_6.prefab_name] ~= nil then
						local var_37_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_34_1.actors_[var_37_6.prefab_name].transform, "story_v_out_324072", "324072008", "story_v_out_324072.awb")

						arg_34_1:RecordAudio("324072008", var_37_11)
						arg_34_1:RecordAudio("324072008", var_37_11)
					else
						arg_34_1:AudioAction("play", "voice", "story_v_out_324072", "324072008", "story_v_out_324072.awb")
					end

					arg_34_1:RecordHistoryTalkVoice("story_v_out_324072", "324072008", "story_v_out_324072.awb")
				end

				arg_34_1:RecordContent(arg_34_1.text_.text)
			end

			local var_37_12 = math.max(var_37_5, arg_34_1.talkMaxDuration)

			if var_37_4 <= arg_34_1.time_ and arg_34_1.time_ < var_37_4 + var_37_12 then
				arg_34_1.typewritter.percent = (arg_34_1.time_ - var_37_4) / var_37_12

				arg_34_1.typewritter:SetDirty()
			end

			if arg_34_1.time_ >= var_37_4 + var_37_12 and arg_34_1.time_ < var_37_4 + var_37_12 + arg_37_0 then
				arg_34_1.typewritter.percent = 1

				arg_34_1.typewritter:SetDirty()
				arg_34_1:ShowNextGo(true)
			end
		end

		arg_34_1.nodeConfigList_ = {}

		arg_34_1:InitPlayNodeList()
	end,
	Play324072009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 324072009
		arg_38_1.duration_ = 6.1

		local var_38_0 = {
			zh = 4.033,
			ja = 6.1
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
				arg_38_0:Play324072010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(arg_38_1.actors_["1037ui_story"]) and arg_38_1.var_.characterEffect1037ui_story == nil then
				arg_38_1.var_.characterEffect1037ui_story = arg_38_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_0 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_0 and not isNil(arg_38_1.actors_["1037ui_story"]) then
				if arg_38_1.var_.characterEffect1037ui_story and not isNil(arg_38_1.actors_["1037ui_story"]) then
					arg_38_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_0 and arg_38_1.time_ < 0 + var_41_0 + arg_41_0 and not isNil(arg_38_1.actors_["1037ui_story"]) and arg_38_1.var_.characterEffect1037ui_story then
				arg_38_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_41_2 = arg_38_1.actors_["1036ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1036ui_story == nil then
				arg_38_1.var_.characterEffect1036ui_story = var_41_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_3 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_3 and not isNil(var_41_2) then
				if arg_38_1.var_.characterEffect1036ui_story and not isNil(var_41_2) then
					arg_38_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_3)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_3 and arg_38_1.time_ < 0 + var_41_3 + arg_41_0 and not isNil(var_41_2) and arg_38_1.var_.characterEffect1036ui_story then
				arg_38_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_41_4 = 0
			local var_41_5 = 0.4

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_4 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_6 = arg_38_1:GetWordFromCfg(324072009)
				local var_41_7 = arg_38_1:FormatText(var_41_6.content)

				arg_38_1.text_.text = var_41_7

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_9 = 16 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 16)

				if (16 <= 0 and var_41_5 or var_41_5 * (utf8.len(var_41_7) / 16)) > 0 and var_41_5 < var_41_9 then
					arg_38_1.talkMaxDuration = var_41_9

					if var_41_9 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_9 + var_41_4
					end
				end

				arg_38_1.text_.text = var_41_7
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072009", "story_v_out_324072.awb") ~= 0 then
					local var_41_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072009", "story_v_out_324072.awb") / 1000

					if var_41_10 + var_41_4 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_4
					end

					if var_41_6.prefab_name ~= "" and arg_38_1.actors_[var_41_6.prefab_name] ~= nil then
						local var_41_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_6.prefab_name].transform, "story_v_out_324072", "324072009", "story_v_out_324072.awb")

						arg_38_1:RecordAudio("324072009", var_41_11)
						arg_38_1:RecordAudio("324072009", var_41_11)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_324072", "324072009", "story_v_out_324072.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_324072", "324072009", "story_v_out_324072.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_12 = math.max(var_41_5, arg_38_1.talkMaxDuration)

			if var_41_4 <= arg_38_1.time_ and arg_38_1.time_ < var_41_4 + var_41_12 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_4) / var_41_12

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_4 + var_41_12 and arg_38_1.time_ < var_41_4 + var_41_12 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play324072010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 324072010
		arg_42_1.duration_ = 1.93

		local var_42_0 = {
			zh = 1.166,
			ja = 1.933
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
				arg_42_0:Play324072011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(arg_42_1.actors_["1070ui_story"]) and arg_42_1.var_.characterEffect1070ui_story == nil then
				arg_42_1.var_.characterEffect1070ui_story = arg_42_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_0 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 and not isNil(arg_42_1.actors_["1070ui_story"]) then
				if arg_42_1.var_.characterEffect1070ui_story and not isNil(arg_42_1.actors_["1070ui_story"]) then
					arg_42_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 and not isNil(arg_42_1.actors_["1070ui_story"]) and arg_42_1.var_.characterEffect1070ui_story then
				arg_42_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_45_2 = arg_42_1.actors_["1037ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect1037ui_story == nil then
				arg_42_1.var_.characterEffect1037ui_story = var_45_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_3 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_3 and not isNil(var_45_2) then
				if arg_42_1.var_.characterEffect1037ui_story and not isNil(var_45_2) then
					arg_42_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_42_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_3)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_3 and arg_42_1.time_ < 0 + var_45_3 + arg_45_0 and not isNil(var_45_2) and arg_42_1.var_.characterEffect1037ui_story then
				arg_42_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_42_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_45_4 = 0
			local var_45_5 = 0.125

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_4 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, true)
				arg_42_1.iconController_:SetSelectedState("hero")

				arg_42_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_42_1.callingController_:SetSelectedState("normal")

				arg_42_1.keyicon_.color = Color.New(1, 1, 1)
				arg_42_1.icon_.color = Color.New(1, 1, 1)

				local var_45_6 = arg_42_1:GetWordFromCfg(324072010)
				local var_45_7 = arg_42_1:FormatText(var_45_6.content)

				arg_42_1.text_.text = var_45_7

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_9 = 5 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 5)

				if (5 <= 0 and var_45_5 or var_45_5 * (utf8.len(var_45_7) / 5)) > 0 and var_45_5 < var_45_9 then
					arg_42_1.talkMaxDuration = var_45_9

					if var_45_9 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_9 + var_45_4
					end
				end

				arg_42_1.text_.text = var_45_7
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072010", "story_v_out_324072.awb") ~= 0 then
					local var_45_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072010", "story_v_out_324072.awb") / 1000

					if var_45_10 + var_45_4 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_4
					end

					if var_45_6.prefab_name ~= "" and arg_42_1.actors_[var_45_6.prefab_name] ~= nil then
						local var_45_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_6.prefab_name].transform, "story_v_out_324072", "324072010", "story_v_out_324072.awb")

						arg_42_1:RecordAudio("324072010", var_45_11)
						arg_42_1:RecordAudio("324072010", var_45_11)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_324072", "324072010", "story_v_out_324072.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_324072", "324072010", "story_v_out_324072.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_12 = math.max(var_45_5, arg_42_1.talkMaxDuration)

			if var_45_4 <= arg_42_1.time_ and arg_42_1.time_ < var_45_4 + var_45_12 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_4) / var_45_12

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_4 + var_45_12 and arg_42_1.time_ < var_45_4 + var_45_12 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play324072011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 324072011
		arg_46_1.duration_ = 4

		local var_46_0 = {
			zh = 3.5,
			ja = 4
		}
		local var_46_1 = manager.audio:GetLocalizationFlag()

		if var_46_0[var_46_1] ~= nil then
			arg_46_1.duration_ = var_46_0[var_46_1]
		end

		SetActive(arg_46_1.tipsGo_, false)

		function arg_46_1.onSingleLineFinish_()
			arg_46_1.onSingleLineUpdate_ = nil
			arg_46_1.onSingleLineFinish_ = nil
			arg_46_1.state_ = "waiting"
		end

		function arg_46_1.playNext_(arg_48_0)
			if arg_48_0 == 1 then
				arg_46_0:Play324072012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(arg_46_1.actors_["1036ui_story"]) and arg_46_1.var_.characterEffect1036ui_story == nil then
				arg_46_1.var_.characterEffect1036ui_story = arg_46_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_0 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_0 and not isNil(arg_46_1.actors_["1036ui_story"]) then
				if arg_46_1.var_.characterEffect1036ui_story and not isNil(arg_46_1.actors_["1036ui_story"]) then
					arg_46_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_0 and arg_46_1.time_ < 0 + var_49_0 + arg_49_0 and not isNil(arg_46_1.actors_["1036ui_story"]) and arg_46_1.var_.characterEffect1036ui_story then
				arg_46_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_49_2 = arg_46_1.actors_["1070ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.characterEffect1070ui_story == nil then
				arg_46_1.var_.characterEffect1070ui_story = var_49_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_3 = 0.200000002980232

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_3 and not isNil(var_49_2) then
				if arg_46_1.var_.characterEffect1070ui_story and not isNil(var_49_2) then
					arg_46_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_3)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_3 and arg_46_1.time_ < 0 + var_49_3 + arg_49_0 and not isNil(var_49_2) and arg_46_1.var_.characterEffect1070ui_story then
				arg_46_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_49_4 = 0
			local var_49_5 = 0.35

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_4 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_6 = arg_46_1:GetWordFromCfg(324072011)
				local var_49_7 = arg_46_1:FormatText(var_49_6.content)

				arg_46_1.text_.text = var_49_7

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_9 = 14 <= 0 and var_49_5 or var_49_5 * (utf8.len(var_49_7) / 14)

				if (14 <= 0 and var_49_5 or var_49_5 * (utf8.len(var_49_7) / 14)) > 0 and var_49_5 < var_49_9 then
					arg_46_1.talkMaxDuration = var_49_9

					if var_49_9 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_9 + var_49_4
					end
				end

				arg_46_1.text_.text = var_49_7
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072011", "story_v_out_324072.awb") ~= 0 then
					local var_49_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072011", "story_v_out_324072.awb") / 1000

					if var_49_10 + var_49_4 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_10 + var_49_4
					end

					if var_49_6.prefab_name ~= "" and arg_46_1.actors_[var_49_6.prefab_name] ~= nil then
						local var_49_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_6.prefab_name].transform, "story_v_out_324072", "324072011", "story_v_out_324072.awb")

						arg_46_1:RecordAudio("324072011", var_49_11)
						arg_46_1:RecordAudio("324072011", var_49_11)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_324072", "324072011", "story_v_out_324072.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_324072", "324072011", "story_v_out_324072.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_12 = math.max(var_49_5, arg_46_1.talkMaxDuration)

			if var_49_4 <= arg_46_1.time_ and arg_46_1.time_ < var_49_4 + var_49_12 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_4) / var_49_12

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_4 + var_49_12 and arg_46_1.time_ < var_49_4 + var_49_12 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play324072012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 324072012
		arg_50_1.duration_ = 7.73

		local var_50_0 = {
			zh = 7.7,
			ja = 7.733
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
				arg_50_0:Play324072013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1037ui_story"]) and arg_50_1.var_.characterEffect1037ui_story == nil then
				arg_50_1.var_.characterEffect1037ui_story = arg_50_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1037ui_story"]) then
				if arg_50_1.var_.characterEffect1037ui_story and not isNil(arg_50_1.actors_["1037ui_story"]) then
					arg_50_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1037ui_story"]) and arg_50_1.var_.characterEffect1037ui_story then
				arg_50_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_53_2 = arg_50_1.actors_["1036ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1036ui_story == nil then
				arg_50_1.var_.characterEffect1036ui_story = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_3 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.characterEffect1036ui_story and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_3)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1036ui_story then
				arg_50_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_53_4 = 0
			local var_53_5 = 0.875

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_4 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_6 = arg_50_1:GetWordFromCfg(324072012)
				local var_53_7 = arg_50_1:FormatText(var_53_6.content)

				arg_50_1.text_.text = var_53_7

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_9 = 35 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 35)

				if (35 <= 0 and var_53_5 or var_53_5 * (utf8.len(var_53_7) / 35)) > 0 and var_53_5 < var_53_9 then
					arg_50_1.talkMaxDuration = var_53_9

					if var_53_9 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_9 + var_53_4
					end
				end

				arg_50_1.text_.text = var_53_7
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072012", "story_v_out_324072.awb") ~= 0 then
					local var_53_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072012", "story_v_out_324072.awb") / 1000

					if var_53_10 + var_53_4 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_10 + var_53_4
					end

					if var_53_6.prefab_name ~= "" and arg_50_1.actors_[var_53_6.prefab_name] ~= nil then
						local var_53_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_6.prefab_name].transform, "story_v_out_324072", "324072012", "story_v_out_324072.awb")

						arg_50_1:RecordAudio("324072012", var_53_11)
						arg_50_1:RecordAudio("324072012", var_53_11)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_324072", "324072012", "story_v_out_324072.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_324072", "324072012", "story_v_out_324072.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_5, arg_50_1.talkMaxDuration)

			if var_53_4 <= arg_50_1.time_ and arg_50_1.time_ < var_53_4 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_4) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_4 + var_53_12 and arg_50_1.time_ < var_53_4 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play324072013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324072013
		arg_54_1.duration_ = 3.1

		local var_54_0 = {
			zh = 2.1,
			ja = 3.1
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
				arg_54_0:Play324072014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(arg_54_1.actors_["1036ui_story"]) and arg_54_1.var_.characterEffect1036ui_story == nil then
				arg_54_1.var_.characterEffect1036ui_story = arg_54_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_0 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_0 and not isNil(arg_54_1.actors_["1036ui_story"]) then
				if arg_54_1.var_.characterEffect1036ui_story and not isNil(arg_54_1.actors_["1036ui_story"]) then
					arg_54_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_54_1.time_ >= 0 + var_57_0 and arg_54_1.time_ < 0 + var_57_0 + arg_57_0 and not isNil(arg_54_1.actors_["1036ui_story"]) and arg_54_1.var_.characterEffect1036ui_story then
				arg_54_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_57_2 = arg_54_1.actors_["1037ui_story"]

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect1037ui_story == nil then
				arg_54_1.var_.characterEffect1037ui_story = var_57_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_57_3 = 0.200000002980232

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_3 and not isNil(var_57_2) then
				if arg_54_1.var_.characterEffect1037ui_story and not isNil(var_57_2) then
					arg_54_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_54_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_54_1.time_ - 0) / var_57_3)
				end
			end

			if arg_54_1.time_ >= 0 + var_57_3 and arg_54_1.time_ < 0 + var_57_3 + arg_57_0 and not isNil(var_57_2) and arg_54_1.var_.characterEffect1037ui_story then
				arg_54_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_54_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_57_4 = 0
			local var_57_5 = 0.15

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= var_57_4 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_6 = arg_54_1:GetWordFromCfg(324072013)
				local var_57_7 = arg_54_1:FormatText(var_57_6.content)

				arg_54_1.text_.text = var_57_7

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_9 = 6 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 6)

				if (6 <= 0 and var_57_5 or var_57_5 * (utf8.len(var_57_7) / 6)) > 0 and var_57_5 < var_57_9 then
					arg_54_1.talkMaxDuration = var_57_9

					if var_57_9 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_9 + var_57_4
					end
				end

				arg_54_1.text_.text = var_57_7
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072013", "story_v_out_324072.awb") ~= 0 then
					local var_57_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072013", "story_v_out_324072.awb") / 1000

					if var_57_10 + var_57_4 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_10 + var_57_4
					end

					if var_57_6.prefab_name ~= "" and arg_54_1.actors_[var_57_6.prefab_name] ~= nil then
						local var_57_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_54_1.actors_[var_57_6.prefab_name].transform, "story_v_out_324072", "324072013", "story_v_out_324072.awb")

						arg_54_1:RecordAudio("324072013", var_57_11)
						arg_54_1:RecordAudio("324072013", var_57_11)
					else
						arg_54_1:AudioAction("play", "voice", "story_v_out_324072", "324072013", "story_v_out_324072.awb")
					end

					arg_54_1:RecordHistoryTalkVoice("story_v_out_324072", "324072013", "story_v_out_324072.awb")
				end

				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_12 = math.max(var_57_5, arg_54_1.talkMaxDuration)

			if var_57_4 <= arg_54_1.time_ and arg_54_1.time_ < var_57_4 + var_57_12 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - var_57_4) / var_57_12

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= var_57_4 + var_57_12 and arg_54_1.time_ < var_57_4 + var_57_12 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324072014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324072014
		arg_58_1.duration_ = 7.9

		local var_58_0 = {
			zh = 6.033,
			ja = 7.9
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
				arg_58_0:Play324072015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(arg_58_1.actors_["1037ui_story"]) and arg_58_1.var_.characterEffect1037ui_story == nil then
				arg_58_1.var_.characterEffect1037ui_story = arg_58_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_0 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 and not isNil(arg_58_1.actors_["1037ui_story"]) then
				if arg_58_1.var_.characterEffect1037ui_story and not isNil(arg_58_1.actors_["1037ui_story"]) then
					arg_58_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 and not isNil(arg_58_1.actors_["1037ui_story"]) and arg_58_1.var_.characterEffect1037ui_story then
				arg_58_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_61_2 = arg_58_1.actors_["1036ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1036ui_story == nil then
				arg_58_1.var_.characterEffect1036ui_story = var_61_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_3 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_3 and not isNil(var_61_2) then
				if arg_58_1.var_.characterEffect1036ui_story and not isNil(var_61_2) then
					arg_58_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_58_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_58_1.time_ - 0) / var_61_3)
				end
			end

			if arg_58_1.time_ >= 0 + var_61_3 and arg_58_1.time_ < 0 + var_61_3 + arg_61_0 and not isNil(var_61_2) and arg_58_1.var_.characterEffect1036ui_story then
				arg_58_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_58_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_61_4 = 0
			local var_61_5 = 0.5

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:GetWordFromCfg(324072014)
				local var_61_7 = arg_58_1:FormatText(var_61_6.content)

				arg_58_1.text_.text = var_61_7

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 20 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 20)

				if (20 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 20)) > 0 and var_61_5 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_7
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072014", "story_v_out_324072.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072014", "story_v_out_324072.awb") / 1000

					if var_61_10 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_4
					end

					if var_61_6.prefab_name ~= "" and arg_58_1.actors_[var_61_6.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_6.prefab_name].transform, "story_v_out_324072", "324072014", "story_v_out_324072.awb")

						arg_58_1:RecordAudio("324072014", var_61_11)
						arg_58_1:RecordAudio("324072014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_324072", "324072014", "story_v_out_324072.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_324072", "324072014", "story_v_out_324072.awb")
				end

				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_12 = math.max(var_61_5, arg_58_1.talkMaxDuration)

			if var_61_4 <= arg_58_1.time_ and arg_58_1.time_ < var_61_4 + var_61_12 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - var_61_4) / var_61_12

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= var_61_4 + var_61_12 and arg_58_1.time_ < var_61_4 + var_61_12 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play324072015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324072015
		arg_62_1.duration_ = 1.67

		local var_62_0 = {
			zh = 1.466,
			ja = 1.666
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
				arg_62_0:Play324072016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(arg_62_1.actors_["1070ui_story"]) and arg_62_1.var_.characterEffect1070ui_story == nil then
				arg_62_1.var_.characterEffect1070ui_story = arg_62_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_0 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_0 and not isNil(arg_62_1.actors_["1070ui_story"]) then
				if arg_62_1.var_.characterEffect1070ui_story and not isNil(arg_62_1.actors_["1070ui_story"]) then
					arg_62_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_0 and arg_62_1.time_ < 0 + var_65_0 + arg_65_0 and not isNil(arg_62_1.actors_["1070ui_story"]) and arg_62_1.var_.characterEffect1070ui_story then
				arg_62_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_65_2 = arg_62_1.actors_["1037ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1037ui_story == nil then
				arg_62_1.var_.characterEffect1037ui_story = var_65_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_3 = 0.200000002980232

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_3 and not isNil(var_65_2) then
				if arg_62_1.var_.characterEffect1037ui_story and not isNil(var_65_2) then
					arg_62_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_3)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_3 and arg_62_1.time_ < 0 + var_65_3 + arg_65_0 and not isNil(var_65_2) and arg_62_1.var_.characterEffect1037ui_story then
				arg_62_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_65_4 = 0
			local var_65_5 = 0.125

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_4 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, true)
				arg_62_1.iconController_:SetSelectedState("hero")

				arg_62_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_62_1.callingController_:SetSelectedState("normal")

				arg_62_1.keyicon_.color = Color.New(1, 1, 1)
				arg_62_1.icon_.color = Color.New(1, 1, 1)

				local var_65_6 = arg_62_1:GetWordFromCfg(324072015)
				local var_65_7 = arg_62_1:FormatText(var_65_6.content)

				arg_62_1.text_.text = var_65_7

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_9 = 5 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 5)

				if (5 <= 0 and var_65_5 or var_65_5 * (utf8.len(var_65_7) / 5)) > 0 and var_65_5 < var_65_9 then
					arg_62_1.talkMaxDuration = var_65_9

					if var_65_9 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_9 + var_65_4
					end
				end

				arg_62_1.text_.text = var_65_7
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072015", "story_v_out_324072.awb") ~= 0 then
					local var_65_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072015", "story_v_out_324072.awb") / 1000

					if var_65_10 + var_65_4 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_10 + var_65_4
					end

					if var_65_6.prefab_name ~= "" and arg_62_1.actors_[var_65_6.prefab_name] ~= nil then
						local var_65_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_6.prefab_name].transform, "story_v_out_324072", "324072015", "story_v_out_324072.awb")

						arg_62_1:RecordAudio("324072015", var_65_11)
						arg_62_1:RecordAudio("324072015", var_65_11)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_324072", "324072015", "story_v_out_324072.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_324072", "324072015", "story_v_out_324072.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_12 = math.max(var_65_5, arg_62_1.talkMaxDuration)

			if var_65_4 <= arg_62_1.time_ and arg_62_1.time_ < var_65_4 + var_65_12 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_4) / var_65_12

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_4 + var_65_12 and arg_62_1.time_ < var_65_4 + var_65_12 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324072016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324072016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play324072017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1070ui_story"]) and arg_66_1.var_.characterEffect1070ui_story == nil then
				arg_66_1.var_.characterEffect1070ui_story = arg_66_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1070ui_story"]) then
				if arg_66_1.var_.characterEffect1070ui_story and not isNil(arg_66_1.actors_["1070ui_story"]) then
					arg_66_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1070ui_story"]) and arg_66_1.var_.characterEffect1070ui_story then
				arg_66_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.7

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_66_1.callingController_:SetSelectedState("calling")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(324072016).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 28 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 28)

				if (28 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 28)) > 0 and var_69_2 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_6 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_6 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_6

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_6 and arg_66_1.time_ < var_69_1 + var_69_6 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play324072017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324072017
		arg_70_1.duration_ = 7.07

		local var_70_0 = {
			zh = 5.299666666666,
			ja = 7.066666666666
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
				arg_70_0:Play324072018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1037ui_story"]) and arg_70_1.var_.characterEffect1037ui_story == nil then
				arg_70_1.var_.characterEffect1037ui_story = arg_70_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1037ui_story"]) then
				if arg_70_1.var_.characterEffect1037ui_story and not isNil(arg_70_1.actors_["1037ui_story"]) then
					arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1037ui_story"]) and arg_70_1.var_.characterEffect1037ui_story then
				arg_70_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_73_2 = 0

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.allBtn_.enabled = false
			end

			if arg_70_1.time_ >= var_73_2 + 1.63333333333333 and arg_70_1.time_ < var_73_2 + 1.63333333333333 + arg_73_0 then
				arg_70_1.allBtn_.enabled = true
			end

			local var_73_3 = arg_70_1.bgs_.MS2403.transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPosMS2403 = var_73_3.localPosition
			end

			local var_73_4 = 1.79166666666667

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				var_73_3.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPosMS2403, Vector3.New(1.35, -0.8, 3.62), (arg_70_1.time_ - 0) / var_73_4)
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				var_73_3.localPosition = Vector3.New(1.35, -0.8, 3.62)
			end

			if arg_70_1.frameCnt_ <= 1 then
				arg_70_1.dialog_:SetActive(false)
			end

			local var_73_5 = 1.366666666666
			local var_73_6 = 0.425

			if 1.366666666666 < arg_70_1.time_ and arg_70_1.time_ <= var_73_5 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0

				arg_70_1.dialog_:SetActive(true)

				arg_70_1.dialogCg_.alpha = 0

				local var_73_7 = LeanTween.value(arg_70_1.dialog_, 0, 1, 0.3)

				var_73_7:setOnUpdate(LuaHelper.FloatAction(function(arg_74_0)
					arg_70_1.dialogCg_.alpha = arg_74_0
				end))
				var_73_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_70_1.dialog_)
					var_73_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_70_1.duration_ = arg_70_1.duration_ + 0.3

				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(324072017)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 17 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_9) / 17)

				if (17 <= 0 and var_73_6 or var_73_6 * (utf8.len(var_73_9) / 17)) > 0 and var_73_6 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11
					var_73_5 = var_73_5 + 0.3

					if var_73_11 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_5
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072017", "story_v_out_324072.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_324072", "324072017", "story_v_out_324072.awb") / 1000

					if var_73_12 + var_73_5 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_5
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_324072", "324072017", "story_v_out_324072.awb")

						arg_70_1:RecordAudio("324072017", var_73_13)
						arg_70_1:RecordAudio("324072017", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_324072", "324072017", "story_v_out_324072.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_324072", "324072017", "story_v_out_324072.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = var_73_5 + 0.3
			local var_73_15 = math.max(var_73_6, arg_70_1.talkMaxDuration)

			if var_73_5 + 0.3 <= arg_70_1.time_ and arg_70_1.time_ < var_73_14 + var_73_15 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_14) / var_73_15

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_14 + var_73_15 and arg_70_1.time_ < var_73_14 + var_73_15 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.79166666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1.35, 0, 5),
					endPos = Vector3.New(1.35, -0.8, 3.62),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play324072018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 324072018
		arg_76_1.duration_ = 8.6

		local var_76_0 = {
			zh = 5.666,
			ja = 8.6
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
				arg_76_0:Play324072019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) and arg_76_1.var_.characterEffect1070ui_story == nil then
				arg_76_1.var_.characterEffect1070ui_story = arg_76_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) then
				if arg_76_1.var_.characterEffect1070ui_story and not isNil(arg_76_1.actors_["1070ui_story"]) then
					arg_76_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1070ui_story"]) and arg_76_1.var_.characterEffect1070ui_story then
				arg_76_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1037ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1037ui_story == nil then
				arg_76_1.var_.characterEffect1037ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1037ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1037ui_story then
				arg_76_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_79_4 = 0
			local var_79_5 = 0.825

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_4 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_6 = arg_76_1:GetWordFromCfg(324072018)
				local var_79_7 = arg_76_1:FormatText(var_79_6.content)

				arg_76_1.text_.text = var_79_7

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_9 = 33 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 33)

				if (33 <= 0 and var_79_5 or var_79_5 * (utf8.len(var_79_7) / 33)) > 0 and var_79_5 < var_79_9 then
					arg_76_1.talkMaxDuration = var_79_9

					if var_79_9 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_9 + var_79_4
					end
				end

				arg_76_1.text_.text = var_79_7
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072018", "story_v_out_324072.awb") ~= 0 then
					local var_79_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072018", "story_v_out_324072.awb") / 1000

					if var_79_10 + var_79_4 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_10 + var_79_4
					end

					if var_79_6.prefab_name ~= "" and arg_76_1.actors_[var_79_6.prefab_name] ~= nil then
						local var_79_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_6.prefab_name].transform, "story_v_out_324072", "324072018", "story_v_out_324072.awb")

						arg_76_1:RecordAudio("324072018", var_79_11)
						arg_76_1:RecordAudio("324072018", var_79_11)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_324072", "324072018", "story_v_out_324072.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_324072", "324072018", "story_v_out_324072.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_12 = math.max(var_79_5, arg_76_1.talkMaxDuration)

			if var_79_4 <= arg_76_1.time_ and arg_76_1.time_ < var_79_4 + var_79_12 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_4) / var_79_12

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_4 + var_79_12 and arg_76_1.time_ < var_79_4 + var_79_12 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play324072019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 324072019
		arg_80_1.duration_ = 5.4

		local var_80_0 = {
			zh = 5.3,
			ja = 5.4
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
				arg_80_0:Play324072020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1036ui_story"]) and arg_80_1.var_.characterEffect1036ui_story == nil then
				arg_80_1.var_.characterEffect1036ui_story = arg_80_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1036ui_story"]) then
				if arg_80_1.var_.characterEffect1036ui_story and not isNil(arg_80_1.actors_["1036ui_story"]) then
					arg_80_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1036ui_story"]) and arg_80_1.var_.characterEffect1036ui_story then
				arg_80_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1070ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1070ui_story == nil then
				arg_80_1.var_.characterEffect1070ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect1070ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect1070ui_story then
				arg_80_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_83_4 = 0
			local var_83_5 = 0.5

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(324072019)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 20 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 20)

				if (20 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 20)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072019", "story_v_out_324072.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072019", "story_v_out_324072.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_324072", "324072019", "story_v_out_324072.awb")

						arg_80_1:RecordAudio("324072019", var_83_11)
						arg_80_1:RecordAudio("324072019", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_324072", "324072019", "story_v_out_324072.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_324072", "324072019", "story_v_out_324072.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play324072020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 324072020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play324072021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1036ui_story"]) and arg_84_1.var_.characterEffect1036ui_story == nil then
				arg_84_1.var_.characterEffect1036ui_story = arg_84_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1036ui_story"]) then
				if arg_84_1.var_.characterEffect1036ui_story and not isNil(arg_84_1.actors_["1036ui_story"]) then
					arg_84_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1036ui_story"]) and arg_84_1.var_.characterEffect1036ui_story then
				arg_84_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_87_1 = 0
			local var_87_2 = 0.2

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_1 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_84_1.callingController_:SetSelectedState("calling")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_3 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(324072020).content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 8 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 8)

				if (8 <= 0 and var_87_2 or var_87_2 * (utf8.len(var_87_3) / 8)) > 0 and var_87_2 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_1 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_1
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_6 = math.max(var_87_2, arg_84_1.talkMaxDuration)

			if var_87_1 <= arg_84_1.time_ and arg_84_1.time_ < var_87_1 + var_87_6 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_1) / var_87_6

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_1 + var_87_6 and arg_84_1.time_ < var_87_1 + var_87_6 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play324072021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 324072021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play324072022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			local var_91_0 = 0.25

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, true)
				arg_88_1.iconController_:SetSelectedState("hero")

				arg_88_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_88_1.callingController_:SetSelectedState("calling")

				arg_88_1.keyicon_.color = Color.New(1, 1, 1)
				arg_88_1.icon_.color = Color.New(1, 1, 1)

				local var_91_1 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(324072021).content)

				arg_88_1.text_.text = var_91_1

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_3 = 10 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 10)

				if (10 <= 0 and var_91_0 or var_91_0 * (utf8.len(var_91_1) / 10)) > 0 and var_91_0 < var_91_3 then
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
	Play324072022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 324072022
		arg_92_1.duration_ = 5.17

		local var_92_0 = {
			zh = 4.3,
			ja = 5.166
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
				arg_92_0:Play324072023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1037ui_story"]) and arg_92_1.var_.characterEffect1037ui_story == nil then
				arg_92_1.var_.characterEffect1037ui_story = arg_92_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1037ui_story"]) then
				if arg_92_1.var_.characterEffect1037ui_story and not isNil(arg_92_1.actors_["1037ui_story"]) then
					arg_92_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1037ui_story"]) and arg_92_1.var_.characterEffect1037ui_story then
				arg_92_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_95_2 = 0
			local var_95_3 = 0.55

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_2 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_4 = arg_92_1:GetWordFromCfg(324072022)
				local var_95_5 = arg_92_1:FormatText(var_95_4.content)

				arg_92_1.text_.text = var_95_5

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_7 = 22 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 22)

				if (22 <= 0 and var_95_3 or var_95_3 * (utf8.len(var_95_5) / 22)) > 0 and var_95_3 < var_95_7 then
					arg_92_1.talkMaxDuration = var_95_7

					if var_95_7 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_7 + var_95_2
					end
				end

				arg_92_1.text_.text = var_95_5
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072022", "story_v_out_324072.awb") ~= 0 then
					local var_95_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072022", "story_v_out_324072.awb") / 1000

					if var_95_8 + var_95_2 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_8 + var_95_2
					end

					if var_95_4.prefab_name ~= "" and arg_92_1.actors_[var_95_4.prefab_name] ~= nil then
						local var_95_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_4.prefab_name].transform, "story_v_out_324072", "324072022", "story_v_out_324072.awb")

						arg_92_1:RecordAudio("324072022", var_95_9)
						arg_92_1:RecordAudio("324072022", var_95_9)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_324072", "324072022", "story_v_out_324072.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_324072", "324072022", "story_v_out_324072.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_10 = math.max(var_95_3, arg_92_1.talkMaxDuration)

			if var_95_2 <= arg_92_1.time_ and arg_92_1.time_ < var_95_2 + var_95_10 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_2) / var_95_10

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_2 + var_95_10 and arg_92_1.time_ < var_95_2 + var_95_10 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play324072023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 324072023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play324072024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["1037ui_story"]) and arg_96_1.var_.characterEffect1037ui_story == nil then
				arg_96_1.var_.characterEffect1037ui_story = arg_96_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["1037ui_story"]) then
				if arg_96_1.var_.characterEffect1037ui_story and not isNil(arg_96_1.actors_["1037ui_story"]) then
					arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_0)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["1037ui_story"]) and arg_96_1.var_.characterEffect1037ui_story then
				arg_96_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_99_1 = 0
			local var_99_2 = 0.475

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_1 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_96_1.callingController_:SetSelectedState("calling")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_3 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(324072023).content)

				arg_96_1.text_.text = var_99_3

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_5 = 19 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 19)

				if (19 <= 0 and var_99_2 or var_99_2 * (utf8.len(var_99_3) / 19)) > 0 and var_99_2 < var_99_5 then
					arg_96_1.talkMaxDuration = var_99_5

					if var_99_5 + var_99_1 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_5 + var_99_1
					end
				end

				arg_96_1.text_.text = var_99_3
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_6 = math.max(var_99_2, arg_96_1.talkMaxDuration)

			if var_99_1 <= arg_96_1.time_ and arg_96_1.time_ < var_99_1 + var_99_6 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_1) / var_99_6

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_1 + var_99_6 and arg_96_1.time_ < var_99_1 + var_99_6 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play324072024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 324072024
		arg_100_1.duration_ = 9.47

		local var_100_0 = {
			zh = 6.633,
			ja = 9.466
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play324072025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1037ui_story"]) and arg_100_1.var_.characterEffect1037ui_story == nil then
				arg_100_1.var_.characterEffect1037ui_story = arg_100_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1037ui_story"]) then
				if arg_100_1.var_.characterEffect1037ui_story and not isNil(arg_100_1.actors_["1037ui_story"]) then
					arg_100_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1037ui_story"]) and arg_100_1.var_.characterEffect1037ui_story then
				arg_100_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_103_2 = 0
			local var_103_3 = 0.8

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_2 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_4 = arg_100_1:GetWordFromCfg(324072024)
				local var_103_5 = arg_100_1:FormatText(var_103_4.content)

				arg_100_1.text_.text = var_103_5

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_7 = 32 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 32)

				if (32 <= 0 and var_103_3 or var_103_3 * (utf8.len(var_103_5) / 32)) > 0 and var_103_3 < var_103_7 then
					arg_100_1.talkMaxDuration = var_103_7

					if var_103_7 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_7 + var_103_2
					end
				end

				arg_100_1.text_.text = var_103_5
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072024", "story_v_out_324072.awb") ~= 0 then
					local var_103_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072024", "story_v_out_324072.awb") / 1000

					if var_103_8 + var_103_2 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_8 + var_103_2
					end

					if var_103_4.prefab_name ~= "" and arg_100_1.actors_[var_103_4.prefab_name] ~= nil then
						local var_103_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_4.prefab_name].transform, "story_v_out_324072", "324072024", "story_v_out_324072.awb")

						arg_100_1:RecordAudio("324072024", var_103_9)
						arg_100_1:RecordAudio("324072024", var_103_9)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_324072", "324072024", "story_v_out_324072.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_324072", "324072024", "story_v_out_324072.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_10 = math.max(var_103_3, arg_100_1.talkMaxDuration)

			if var_103_2 <= arg_100_1.time_ and arg_100_1.time_ < var_103_2 + var_103_10 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_2) / var_103_10

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_2 + var_103_10 and arg_100_1.time_ < var_103_2 + var_103_10 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play324072025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 324072025
		arg_104_1.duration_ = 8.5

		local var_104_0 = {
			zh = 6.633,
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
				arg_104_0:Play324072026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.85

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_1 = arg_104_1:GetWordFromCfg(324072025)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 34 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 34)

				if (34 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 34)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072025", "story_v_out_324072.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_324072", "324072025", "story_v_out_324072.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_324072", "324072025", "story_v_out_324072.awb")

						arg_104_1:RecordAudio("324072025", var_107_6)
						arg_104_1:RecordAudio("324072025", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_324072", "324072025", "story_v_out_324072.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_324072", "324072025", "story_v_out_324072.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play324072026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 324072026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play324072027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1037ui_story"]) and arg_108_1.var_.characterEffect1037ui_story == nil then
				arg_108_1.var_.characterEffect1037ui_story = arg_108_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1037ui_story"]) then
				if arg_108_1.var_.characterEffect1037ui_story and not isNil(arg_108_1.actors_["1037ui_story"]) then
					arg_108_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_108_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_0)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1037ui_story"]) and arg_108_1.var_.characterEffect1037ui_story then
				arg_108_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_108_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_111_1 = 0
			local var_111_2 = 0.575

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_1 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0

				arg_108_1.dialog_:SetActive(true)

				arg_108_1.dialogCg_.alpha = 0

				local var_111_3 = LeanTween.value(arg_108_1.dialog_, 0, 1, 0.3)

				var_111_3:setOnUpdate(LuaHelper.FloatAction(function(arg_112_0)
					arg_108_1.dialogCg_.alpha = arg_112_0
				end))
				var_111_3:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_108_1.dialog_)
					var_111_3:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_108_1.duration_ = arg_108_1.duration_ + 0.3

				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_4 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(324072026).content)

				arg_108_1.text_.text = var_111_4

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_6 = 23 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 23)

				if (23 <= 0 and var_111_2 or var_111_2 * (utf8.len(var_111_4) / 23)) > 0 and var_111_2 < var_111_6 then
					arg_108_1.talkMaxDuration = var_111_6
					var_111_1 = var_111_1 + 0.3

					if var_111_6 + var_111_1 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_6 + var_111_1
					end
				end

				arg_108_1.text_.text = var_111_4
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_7 = var_111_1 + 0.3
			local var_111_8 = math.max(var_111_2, arg_108_1.talkMaxDuration)

			if var_111_1 + 0.3 <= arg_108_1.time_ and arg_108_1.time_ < var_111_7 + var_111_8 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_7) / var_111_8

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_7 + var_111_8 and arg_108_1.time_ < var_111_7 + var_111_8 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play324072027 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324072027
		arg_114_1.duration_ = 11.57

		local var_114_0 = {
			zh = 8.066,
			ja = 11.566
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324072028(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1037ui_story"]) and arg_114_1.var_.characterEffect1037ui_story == nil then
				arg_114_1.var_.characterEffect1037ui_story = arg_114_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1037ui_story"]) then
				if arg_114_1.var_.characterEffect1037ui_story and not isNil(arg_114_1.actors_["1037ui_story"]) then
					arg_114_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1037ui_story"]) and arg_114_1.var_.characterEffect1037ui_story then
				arg_114_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_117_2 = 0
			local var_117_3 = 1

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_2 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_4 = arg_114_1:GetWordFromCfg(324072027)
				local var_117_5 = arg_114_1:FormatText(var_117_4.content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 40 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 40)

				if (40 <= 0 and var_117_3 or var_117_3 * (utf8.len(var_117_5) / 40)) > 0 and var_117_3 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_2
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072027", "story_v_out_324072.awb") ~= 0 then
					local var_117_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072027", "story_v_out_324072.awb") / 1000

					if var_117_8 + var_117_2 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_8 + var_117_2
					end

					if var_117_4.prefab_name ~= "" and arg_114_1.actors_[var_117_4.prefab_name] ~= nil then
						local var_117_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_4.prefab_name].transform, "story_v_out_324072", "324072027", "story_v_out_324072.awb")

						arg_114_1:RecordAudio("324072027", var_117_9)
						arg_114_1:RecordAudio("324072027", var_117_9)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_324072", "324072027", "story_v_out_324072.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_324072", "324072027", "story_v_out_324072.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_10 = math.max(var_117_3, arg_114_1.talkMaxDuration)

			if var_117_2 <= arg_114_1.time_ and arg_114_1.time_ < var_117_2 + var_117_10 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_2) / var_117_10

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_2 + var_117_10 and arg_114_1.time_ < var_117_2 + var_117_10 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play324072028 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324072028
		arg_118_1.duration_ = 5.83

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324072029(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["1037ui_story"]) and arg_118_1.var_.characterEffect1037ui_story == nil then
				arg_118_1.var_.characterEffect1037ui_story = arg_118_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["1037ui_story"]) then
				if arg_118_1.var_.characterEffect1037ui_story and not isNil(arg_118_1.actors_["1037ui_story"]) then
					arg_118_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_118_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_0)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["1037ui_story"]) and arg_118_1.var_.characterEffect1037ui_story then
				arg_118_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_118_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_121_1 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_1 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_1 + 0.833333333333333 and arg_118_1.time_ < var_121_1 + 0.833333333333333 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_2 = arg_118_1.bgs_.MS2403.transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPosMS2403 = var_121_2.localPosition
			end

			local var_121_3 = 0.383333333333333

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 then
				var_121_2.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosMS2403, Vector3.New(1.35, -0.8, 5.29), (arg_118_1.time_ - 0) / var_121_3)
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 then
				var_121_2.localPosition = Vector3.New(1.35, -0.8, 5.29)
			end

			local var_121_4 = arg_118_1.bgs_.MS2403.transform

			if 0.383333333333333 < arg_118_1.time_ and arg_118_1.time_ <= 0.383333333333333 + arg_121_0 then
				arg_118_1.var_.moveOldPosMS2403 = var_121_4.localPosition
			end

			local var_121_5 = 0.45

			if 0.383333333333333 <= arg_118_1.time_ and arg_118_1.time_ < 0.383333333333333 + var_121_5 then
				var_121_4.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPosMS2403, Vector3.New(1.35, -0.8, 4.42), (arg_118_1.time_ - 0.383333333333333) / var_121_5)
			end

			if arg_118_1.time_ >= 0.383333333333333 + var_121_5 and arg_118_1.time_ < 0.383333333333333 + var_121_5 + arg_121_0 then
				var_121_4.localPosition = Vector3.New(1.35, -0.8, 4.42)
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_6 = 0.833333333333333
			local var_121_7 = 0.85

			if 0.833333333333333 < arg_118_1.time_ and arg_118_1.time_ <= var_121_6 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_8 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_8:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_9 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(324072028).content)

				arg_118_1.text_.text = var_121_9

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_11 = 34 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 34)

				if (34 <= 0 and var_121_7 or var_121_7 * (utf8.len(var_121_9) / 34)) > 0 and var_121_7 < var_121_11 then
					arg_118_1.talkMaxDuration = var_121_11
					var_121_6 = var_121_6 + 0.3

					if var_121_11 + var_121_6 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_11 + var_121_6
					end
				end

				arg_118_1.text_.text = var_121_9
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_12 = var_121_6 + 0.3
			local var_121_13 = math.max(var_121_7, arg_118_1.talkMaxDuration)

			if var_121_6 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_12 + var_121_13 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_12) / var_121_13

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_12 + var_121_13 and arg_118_1.time_ < var_121_12 + var_121_13 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.383333333333333,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1.35, -0.8, 3.62),
					endPos = Vector3.New(1.35, -0.8, 5.29),
					easeType = LeanTweenType.easeInSine
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2403",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 0.45,
				startTime = 0.383333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(1.35, -0.8, 5.29),
					endPos = Vector3.New(1.35, -0.8, 4.42),
					easeType = LeanTweenType.easeOutBack
				}
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play324072029 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 324072029
		arg_124_1.duration_ = 2.93

		local var_124_0 = {
			zh = 2.533,
			ja = 2.933
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
				arg_124_0:Play324072030(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1036ui_story"]) and arg_124_1.var_.characterEffect1036ui_story == nil then
				arg_124_1.var_.characterEffect1036ui_story = arg_124_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.200000002980232

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1036ui_story"]) then
				if arg_124_1.var_.characterEffect1036ui_story and not isNil(arg_124_1.actors_["1036ui_story"]) then
					arg_124_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1036ui_story"]) and arg_124_1.var_.characterEffect1036ui_story then
				arg_124_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_127_2 = 0
			local var_127_3 = 0.15

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_2 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_4 = arg_124_1:GetWordFromCfg(324072029)
				local var_127_5 = arg_124_1:FormatText(var_127_4.content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 6 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 6)

				if (6 <= 0 and var_127_3 or var_127_3 * (utf8.len(var_127_5) / 6)) > 0 and var_127_3 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_2
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072029", "story_v_out_324072.awb") ~= 0 then
					local var_127_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072029", "story_v_out_324072.awb") / 1000

					if var_127_8 + var_127_2 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_8 + var_127_2
					end

					if var_127_4.prefab_name ~= "" and arg_124_1.actors_[var_127_4.prefab_name] ~= nil then
						local var_127_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_4.prefab_name].transform, "story_v_out_324072", "324072029", "story_v_out_324072.awb")

						arg_124_1:RecordAudio("324072029", var_127_9)
						arg_124_1:RecordAudio("324072029", var_127_9)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_324072", "324072029", "story_v_out_324072.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_324072", "324072029", "story_v_out_324072.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_10 = math.max(var_127_3, arg_124_1.talkMaxDuration)

			if var_127_2 <= arg_124_1.time_ and arg_124_1.time_ < var_127_2 + var_127_10 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_2) / var_127_10

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_2 + var_127_10 and arg_124_1.time_ < var_127_2 + var_127_10 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play324072030 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 324072030
		arg_128_1.duration_ = 4.3

		local var_128_0 = {
			zh = 3.233,
			ja = 4.3
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
				arg_128_0:Play324072031(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1037ui_story"]) and arg_128_1.var_.characterEffect1037ui_story == nil then
				arg_128_1.var_.characterEffect1037ui_story = arg_128_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1037ui_story"]) then
				if arg_128_1.var_.characterEffect1037ui_story and not isNil(arg_128_1.actors_["1037ui_story"]) then
					arg_128_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1037ui_story"]) and arg_128_1.var_.characterEffect1037ui_story then
				arg_128_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1036ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1036ui_story == nil then
				arg_128_1.var_.characterEffect1036ui_story = var_131_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_3 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 and not isNil(var_131_2) then
				if arg_128_1.var_.characterEffect1036ui_story and not isNil(var_131_2) then
					arg_128_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_3)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 and not isNil(var_131_2) and arg_128_1.var_.characterEffect1036ui_story then
				arg_128_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_131_4 = 0
			local var_131_5 = 0.3

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(324072030)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 12 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 12)

				if (12 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 12)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072030", "story_v_out_324072.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072030", "story_v_out_324072.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_324072", "324072030", "story_v_out_324072.awb")

						arg_128_1:RecordAudio("324072030", var_131_11)
						arg_128_1:RecordAudio("324072030", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_324072", "324072030", "story_v_out_324072.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_324072", "324072030", "story_v_out_324072.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {}

		arg_128_1:InitPlayNodeList()
	end,
	Play324072031 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 324072031
		arg_132_1.duration_ = 1.4

		local var_132_0 = {
			zh = 1.4,
			ja = 0.999999999999
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
				arg_132_0:Play324072032(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1036ui_story"]) and arg_132_1.var_.characterEffect1036ui_story == nil then
				arg_132_1.var_.characterEffect1036ui_story = arg_132_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1036ui_story"]) then
				if arg_132_1.var_.characterEffect1036ui_story and not isNil(arg_132_1.actors_["1036ui_story"]) then
					arg_132_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1036ui_story"]) and arg_132_1.var_.characterEffect1036ui_story then
				arg_132_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_135_2 = arg_132_1.actors_["1037ui_story"]

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1037ui_story == nil then
				arg_132_1.var_.characterEffect1037ui_story = var_135_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_3 = 0.200000002980232

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_3 and not isNil(var_135_2) then
				if arg_132_1.var_.characterEffect1037ui_story and not isNil(var_135_2) then
					arg_132_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_3)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_3 and arg_132_1.time_ < 0 + var_135_3 + arg_135_0 and not isNil(var_135_2) and arg_132_1.var_.characterEffect1037ui_story then
				arg_132_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_135_4 = 0
			local var_135_5 = 0.075

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_4 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, false)
				arg_132_1.callingController_:SetSelectedState("normal")

				local var_135_6 = arg_132_1:GetWordFromCfg(324072031)
				local var_135_7 = arg_132_1:FormatText(var_135_6.content)

				arg_132_1.text_.text = var_135_7

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_9 = 3 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 3)

				if (3 <= 0 and var_135_5 or var_135_5 * (utf8.len(var_135_7) / 3)) > 0 and var_135_5 < var_135_9 then
					arg_132_1.talkMaxDuration = var_135_9

					if var_135_9 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_9 + var_135_4
					end
				end

				arg_132_1.text_.text = var_135_7
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072031", "story_v_out_324072.awb") ~= 0 then
					local var_135_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072031", "story_v_out_324072.awb") / 1000

					if var_135_10 + var_135_4 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_10 + var_135_4
					end

					if var_135_6.prefab_name ~= "" and arg_132_1.actors_[var_135_6.prefab_name] ~= nil then
						local var_135_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_6.prefab_name].transform, "story_v_out_324072", "324072031", "story_v_out_324072.awb")

						arg_132_1:RecordAudio("324072031", var_135_11)
						arg_132_1:RecordAudio("324072031", var_135_11)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_324072", "324072031", "story_v_out_324072.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_324072", "324072031", "story_v_out_324072.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_12 = math.max(var_135_5, arg_132_1.talkMaxDuration)

			if var_135_4 <= arg_132_1.time_ and arg_132_1.time_ < var_135_4 + var_135_12 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_4) / var_135_12

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_4 + var_135_12 and arg_132_1.time_ < var_135_4 + var_135_12 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play324072032 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 324072032
		arg_136_1.duration_ = 4.1

		local var_136_0 = {
			zh = 1.766,
			ja = 4.1
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
				arg_136_0:Play324072033(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1037ui_story"]) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = arg_136_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1037ui_story"]) then
				if arg_136_1.var_.characterEffect1037ui_story and not isNil(arg_136_1.actors_["1037ui_story"]) then
					arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1037ui_story"]) and arg_136_1.var_.characterEffect1037ui_story then
				arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_139_2 = arg_136_1.actors_["1036ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1036ui_story == nil then
				arg_136_1.var_.characterEffect1036ui_story = var_139_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_3 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_3 and not isNil(var_139_2) then
				if arg_136_1.var_.characterEffect1036ui_story and not isNil(var_139_2) then
					arg_136_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_136_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_136_1.time_ - 0) / var_139_3)
				end
			end

			if arg_136_1.time_ >= 0 + var_139_3 and arg_136_1.time_ < 0 + var_139_3 + arg_139_0 and not isNil(var_139_2) and arg_136_1.var_.characterEffect1036ui_story then
				arg_136_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_136_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_139_4 = 0
			local var_139_5 = 0.175

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(324072032)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 7 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 7)

				if (7 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 7)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072032", "story_v_out_324072.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072032", "story_v_out_324072.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_324072", "324072032", "story_v_out_324072.awb")

						arg_136_1:RecordAudio("324072032", var_139_11)
						arg_136_1:RecordAudio("324072032", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_324072", "324072032", "story_v_out_324072.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_324072", "324072032", "story_v_out_324072.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_12 = math.max(var_139_5, arg_136_1.talkMaxDuration)

			if var_139_4 <= arg_136_1.time_ and arg_136_1.time_ < var_139_4 + var_139_12 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_4) / var_139_12

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_4 + var_139_12 and arg_136_1.time_ < var_139_4 + var_139_12 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play324072033 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 324072033
		arg_140_1.duration_ = 6.9

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play324072034(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if arg_140_1.bgs_.ST2008 == nil then
				local var_143_0 = Object.Instantiate(arg_140_1.paintGo_)

				var_143_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2008")
				var_143_0.name = "ST2008"
				var_143_0.transform.parent = arg_140_1.stage_.transform
				var_143_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.bgs_.ST2008 = var_143_0
			end

			if 1.13333333333333 < arg_140_1.time_ and arg_140_1.time_ <= 1.13333333333333 + arg_143_0 then
				local var_143_1 = arg_140_1.bgs_.ST2008

				arg_140_1.bgs_.ST2008.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_143_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_143_2 = var_143_1:GetComponent("SpriteRenderer")

				if var_143_2 and var_143_2.sprite then
					local var_143_3 = 2 * (var_143_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_143_1.transform.localScale = Vector3.New(var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, var_143_3 / var_143_2.sprite.bounds.size.y < var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x and var_143_3 * manager.ui.mainCameraCom_.aspect / var_143_2.sprite.bounds.size.x or var_143_3 / var_143_2.sprite.bounds.size.y, 0)
				end

				for iter_143_0, iter_143_1 in pairs(arg_140_1.bgs_) do
					if iter_143_0 ~= "ST2008" then
						iter_143_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_143_4 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_4 + arg_143_0 then
				arg_140_1.allBtn_.enabled = false
			end

			if arg_140_1.time_ >= var_143_4 + 0.3 and arg_140_1.time_ < var_143_4 + 0.3 + arg_143_0 then
				arg_140_1.allBtn_.enabled = true
			end

			local var_143_5 = 0

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_5 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_6 = 1.13333333333333

			if var_143_5 <= arg_140_1.time_ and arg_140_1.time_ < var_143_5 + var_143_6 then
				local var_143_7 = Color.New(0, 0, 0)

				var_143_7.a = Mathf.Lerp(0, 1, (arg_140_1.time_ - var_143_5) / var_143_6)
				arg_140_1.mask_.color = var_143_7
			end

			if arg_140_1.time_ >= var_143_5 + var_143_6 and arg_140_1.time_ < var_143_5 + var_143_6 + arg_143_0 then
				local var_143_8 = Color.New(0, 0, 0)

				var_143_8.a = 1
				arg_140_1.mask_.color = var_143_8
			end

			local var_143_9 = 1.13333333333333

			if 1.13333333333333 < arg_140_1.time_ and arg_140_1.time_ <= var_143_9 + arg_143_0 then
				arg_140_1.mask_.enabled = true
				arg_140_1.mask_.raycastTarget = true

				arg_140_1:SetGaussion(false)
			end

			local var_143_10 = 1.13333333333333

			if var_143_9 <= arg_140_1.time_ and arg_140_1.time_ < var_143_9 + var_143_10 then
				local var_143_11 = Color.New(0, 0, 0)

				var_143_11.a = Mathf.Lerp(1, 0, (arg_140_1.time_ - var_143_9) / var_143_10)
				arg_140_1.mask_.color = var_143_11
			end

			if arg_140_1.time_ >= var_143_9 + var_143_10 and arg_140_1.time_ < var_143_9 + var_143_10 + arg_143_0 then
				local var_143_12 = Color.New(0, 0, 0)

				arg_140_1.mask_.enabled = false
				var_143_12.a = 0
				arg_140_1.mask_.color = var_143_12
			end

			local var_143_13 = arg_140_1.actors_["1037ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_13) and arg_140_1.var_.characterEffect1037ui_story == nil then
				arg_140_1.var_.characterEffect1037ui_story = var_143_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_14 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_14 and not isNil(var_143_13) then
				if arg_140_1.var_.characterEffect1037ui_story and not isNil(var_143_13) then
					arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_14)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_14 and arg_140_1.time_ < 0 + var_143_14 + arg_143_0 and not isNil(var_143_13) and arg_140_1.var_.characterEffect1037ui_story then
				arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_140_1.time_ and arg_140_1.time_ <= 1.2 + arg_143_0 then
				arg_140_1:AudioAction("play", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 0.1 < arg_140_1.time_ and arg_140_1.time_ <= 0.1 + arg_143_0 then
				arg_140_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if arg_140_1.frameCnt_ <= 1 then
				arg_140_1.dialog_:SetActive(false)
			end

			local var_143_17 = 1.9
			local var_143_18 = 1.6

			if 1.9 < arg_140_1.time_ and arg_140_1.time_ <= var_143_17 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0

				arg_140_1.dialog_:SetActive(true)

				arg_140_1.dialogCg_.alpha = 0

				local var_143_19 = LeanTween.value(arg_140_1.dialog_, 0, 1, 0.3)

				var_143_19:setOnUpdate(LuaHelper.FloatAction(function(arg_144_0)
					arg_140_1.dialogCg_.alpha = arg_144_0
				end))
				var_143_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_140_1.dialog_)
					var_143_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_140_1.duration_ = arg_140_1.duration_ + 0.3

				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_20 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(324072033).content)

				arg_140_1.text_.text = var_143_20

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_22 = 64 <= 0 and var_143_18 or var_143_18 * (utf8.len(var_143_20) / 64)

				if (64 <= 0 and var_143_18 or var_143_18 * (utf8.len(var_143_20) / 64)) > 0 and var_143_18 < var_143_22 then
					arg_140_1.talkMaxDuration = var_143_22
					var_143_17 = var_143_17 + 0.3

					if var_143_22 + var_143_17 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_22 + var_143_17
					end
				end

				arg_140_1.text_.text = var_143_20
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_23 = var_143_17 + 0.3
			local var_143_24 = math.max(var_143_18, arg_140_1.talkMaxDuration)

			if var_143_17 + 0.3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_23 + var_143_24 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_23) / var_143_24

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_23 + var_143_24 and arg_140_1.time_ < var_143_23 + var_143_24 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {}

		arg_140_1:InitPlayNodeList()
	end,
	Play324072034 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324072034
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324072035(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.075

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, true)
				arg_146_1.iconController_:SetSelectedState("hero")

				arg_146_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_146_1.callingController_:SetSelectedState("normal")

				arg_146_1.keyicon_.color = Color.New(1, 1, 1)
				arg_146_1.icon_.color = Color.New(1, 1, 1)

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(324072034).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 43 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 43)

				if (43 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 43)) > 0 and var_149_0 < var_149_3 then
					arg_146_1.talkMaxDuration = var_149_3

					if var_149_3 + 0 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_3 + 0
					end
				end

				arg_146_1.text_.text = var_149_1
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_4 = math.max(var_149_0, arg_146_1.talkMaxDuration)

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_4 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - 0) / var_149_4

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= 0 + var_149_4 and arg_146_1.time_ < 0 + var_149_4 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play324072035 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 324072035
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play324072036(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 0.325

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, true)
				arg_150_1.iconController_:SetSelectedState("hero")

				arg_150_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_150_1.callingController_:SetSelectedState("normal")

				arg_150_1.keyicon_.color = Color.New(1, 1, 1)
				arg_150_1.icon_.color = Color.New(1, 1, 1)

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(324072035).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 13 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 13)

				if (13 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 13)) > 0 and var_153_0 < var_153_3 then
					arg_150_1.talkMaxDuration = var_153_3

					if var_153_3 + 0 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_3 + 0
					end
				end

				arg_150_1.text_.text = var_153_1
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)
				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_4 = math.max(var_153_0, arg_150_1.talkMaxDuration)

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_4 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - 0) / var_153_4

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= 0 + var_153_4 and arg_150_1.time_ < 0 + var_153_4 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play324072036 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 324072036
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play324072037(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0.1 < arg_154_1.time_ and arg_154_1.time_ <= 0.1 + arg_157_0 then
				arg_154_1:AudioAction("play", "effect", "se_story_140", "se_story_140_door02", "")
			end

			local var_157_1 = 0
			local var_157_2 = 1.35

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, false)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(324072036).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 54 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 54)

				if (54 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 54)) > 0 and var_157_2 < var_157_5 then
					arg_154_1.talkMaxDuration = var_157_5

					if var_157_5 + var_157_1 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_5 + var_157_1
					end
				end

				arg_154_1.text_.text = var_157_3
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_6 = math.max(var_157_2, arg_154_1.talkMaxDuration)

			if var_157_1 <= arg_154_1.time_ and arg_154_1.time_ < var_157_1 + var_157_6 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_1) / var_157_6

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_1 + var_157_6 and arg_154_1.time_ < var_157_1 + var_157_6 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play324072037 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 324072037
		arg_158_1.duration_ = 2.6

		local var_158_0 = {
			zh = 1.999999999999,
			ja = 2.6
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play324072038(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if arg_158_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_161_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_158_1.stage_.transform)

				var_161_0.name = "1054ui_story"
				var_161_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_158_1.actors_["1054ui_story"] = var_161_0

				local var_161_1 = var_161_0:GetComponentInChildren(typeof(CharacterEffect))

				var_161_1.enabled = true

				local var_161_2 = GameObjectTools.GetOrAddComponent(var_161_0, typeof(DynamicBoneHelper))

				if var_161_2 then
					var_161_2:EnableDynamicBone(false)
				end

				arg_158_1:ShowWeapon(var_161_1.transform, false)

				arg_158_1.var_["1054ui_story" .. "Animator"] = var_161_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_158_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_158_1.var_["1054ui_story" .. "LipSync"] = var_161_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_161_3 = arg_158_1.actors_["1054ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos1054ui_story = var_161_3.localPosition

				local var_161_4 = GameObjectTools.GetOrAddComponent(var_161_3.gameObject, typeof(DynamicBoneHelper))

				if var_161_4 then
					var_161_4:EnableDynamicBone(false)
				end
			end

			local var_161_5 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_5 then
				var_161_3.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_158_1.time_ - 0) / var_161_5)
				var_161_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_3.position).x, (manager.ui.mainCamera.transform.position - var_161_3.position).y, (manager.ui.mainCamera.transform.position - var_161_3.position).z)
				var_161_3.localEulerAngles.z = 0
				var_161_3.localEulerAngles.x = 0
				var_161_3.localEulerAngles = var_161_3.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_5 and arg_158_1.time_ < 0 + var_161_5 + arg_161_0 then
				var_161_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_161_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_3.position).x, (manager.ui.mainCamera.transform.position - var_161_3.position).y, (manager.ui.mainCamera.transform.position - var_161_3.position).z)
				var_161_3.localEulerAngles.z = 0
				var_161_3.localEulerAngles.x = 0
				var_161_3.localEulerAngles = var_161_3.localEulerAngles

				local var_161_6 = GameObjectTools.GetOrAddComponent(var_161_3.gameObject, typeof(DynamicBoneHelper))

				if var_161_6 then
					var_161_6:EnableDynamicBone(true)
				end
			end

			local var_161_7 = arg_158_1.actors_["1054ui_story"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_7) and arg_158_1.var_.characterEffect1054ui_story == nil then
				arg_158_1.var_.characterEffect1054ui_story = var_161_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_8 = 0.200000002980232

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_8 and not isNil(var_161_7) then
				if arg_158_1.var_.characterEffect1054ui_story and not isNil(var_161_7) then
					arg_158_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_8 and arg_158_1.time_ < 0 + var_161_8 + arg_161_0 and not isNil(var_161_7) and arg_158_1.var_.characterEffect1054ui_story then
				arg_158_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_161_10 = 0
			local var_161_11 = 0.1

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_10 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_12 = arg_158_1:GetWordFromCfg(324072037)
				local var_161_13 = arg_158_1:FormatText(var_161_12.content)

				arg_158_1.text_.text = var_161_13

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_15 = 4 <= 0 and var_161_11 or var_161_11 * (utf8.len(var_161_13) / 4)

				if (4 <= 0 and var_161_11 or var_161_11 * (utf8.len(var_161_13) / 4)) > 0 and var_161_11 < var_161_15 then
					arg_158_1.talkMaxDuration = var_161_15

					if var_161_15 + var_161_10 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_15 + var_161_10
					end
				end

				arg_158_1.text_.text = var_161_13
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072037", "story_v_out_324072.awb") ~= 0 then
					local var_161_16 = manager.audio:GetVoiceLength("story_v_out_324072", "324072037", "story_v_out_324072.awb") / 1000

					if var_161_16 + var_161_10 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_16 + var_161_10
					end

					if var_161_12.prefab_name ~= "" and arg_158_1.actors_[var_161_12.prefab_name] ~= nil then
						local var_161_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_12.prefab_name].transform, "story_v_out_324072", "324072037", "story_v_out_324072.awb")

						arg_158_1:RecordAudio("324072037", var_161_17)
						arg_158_1:RecordAudio("324072037", var_161_17)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_324072", "324072037", "story_v_out_324072.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_324072", "324072037", "story_v_out_324072.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_18 = math.max(var_161_11, arg_158_1.talkMaxDuration)

			if var_161_10 <= arg_158_1.time_ and arg_158_1.time_ < var_161_10 + var_161_18 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_10) / var_161_18

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_10 + var_161_18 and arg_158_1.time_ < var_161_10 + var_161_18 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play324072038 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 324072038
		arg_162_1.duration_ = 2.53

		local var_162_0 = {
			zh = 1.999999999999,
			ja = 2.533
		}
		local var_162_1 = manager.audio:GetLocalizationFlag()

		if var_162_0[var_162_1] ~= nil then
			arg_162_1.duration_ = var_162_0[var_162_1]
		end

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play324072039(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if arg_162_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_165_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_162_1.stage_.transform)

				var_165_0.name = "6148ui_story"
				var_165_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_162_1.actors_["6148ui_story"] = var_165_0

				local var_165_1 = var_165_0:GetComponentInChildren(typeof(CharacterEffect))

				var_165_1.enabled = true

				local var_165_2 = GameObjectTools.GetOrAddComponent(var_165_0, typeof(DynamicBoneHelper))

				if var_165_2 then
					var_165_2:EnableDynamicBone(false)
				end

				arg_162_1:ShowWeapon(var_165_1.transform, false)

				arg_162_1.var_["6148ui_story" .. "Animator"] = var_165_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_162_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_162_1.var_["6148ui_story" .. "LipSync"] = var_165_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_165_3 = arg_162_1.actors_["6148ui_story"].transform

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.var_.moveOldPos6148ui_story = var_165_3.localPosition

				local var_165_4 = GameObjectTools.GetOrAddComponent(var_165_3.gameObject, typeof(DynamicBoneHelper))

				if var_165_4 then
					var_165_4:EnableDynamicBone(false)
				end
			end

			local var_165_5 = 0.001

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_5 then
				var_165_3.localPosition = Vector3.Lerp(arg_162_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_162_1.time_ - 0) / var_165_5)
				var_165_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_3.position).x, (manager.ui.mainCamera.transform.position - var_165_3.position).y, (manager.ui.mainCamera.transform.position - var_165_3.position).z)
				var_165_3.localEulerAngles.z = 0
				var_165_3.localEulerAngles.x = 0
				var_165_3.localEulerAngles = var_165_3.localEulerAngles
			end

			if arg_162_1.time_ >= 0 + var_165_5 and arg_162_1.time_ < 0 + var_165_5 + arg_165_0 then
				var_165_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_165_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_165_3.position).x, (manager.ui.mainCamera.transform.position - var_165_3.position).y, (manager.ui.mainCamera.transform.position - var_165_3.position).z)
				var_165_3.localEulerAngles.z = 0
				var_165_3.localEulerAngles.x = 0
				var_165_3.localEulerAngles = var_165_3.localEulerAngles

				local var_165_6 = GameObjectTools.GetOrAddComponent(var_165_3.gameObject, typeof(DynamicBoneHelper))

				if var_165_6 then
					var_165_6:EnableDynamicBone(true)
				end
			end

			local var_165_7 = arg_162_1.actors_["6148ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.characterEffect6148ui_story == nil then
				arg_162_1.var_.characterEffect6148ui_story = var_165_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_8 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_8 and not isNil(var_165_7) then
				if arg_162_1.var_.characterEffect6148ui_story and not isNil(var_165_7) then
					arg_162_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_8 and arg_162_1.time_ < 0 + var_165_8 + arg_165_0 and not isNil(var_165_7) and arg_162_1.var_.characterEffect6148ui_story then
				arg_162_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_165_10 = arg_162_1.actors_["1054ui_story"]

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(var_165_10) and arg_162_1.var_.characterEffect1054ui_story == nil then
				arg_162_1.var_.characterEffect1054ui_story = var_165_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_11 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_11 and not isNil(var_165_10) then
				if arg_162_1.var_.characterEffect1054ui_story and not isNil(var_165_10) then
					arg_162_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_162_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_11)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_11 and arg_162_1.time_ < 0 + var_165_11 + arg_165_0 and not isNil(var_165_10) and arg_162_1.var_.characterEffect1054ui_story then
				arg_162_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_162_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action5_1")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_165_12 = 0
			local var_165_13 = 0.175

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_12 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_14 = arg_162_1:GetWordFromCfg(324072038)
				local var_165_15 = arg_162_1:FormatText(var_165_14.content)

				arg_162_1.text_.text = var_165_15

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_17 = 7 <= 0 and var_165_13 or var_165_13 * (utf8.len(var_165_15) / 7)

				if (7 <= 0 and var_165_13 or var_165_13 * (utf8.len(var_165_15) / 7)) > 0 and var_165_13 < var_165_17 then
					arg_162_1.talkMaxDuration = var_165_17

					if var_165_17 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_17 + var_165_12
					end
				end

				arg_162_1.text_.text = var_165_15
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072038", "story_v_out_324072.awb") ~= 0 then
					local var_165_18 = manager.audio:GetVoiceLength("story_v_out_324072", "324072038", "story_v_out_324072.awb") / 1000

					if var_165_18 + var_165_12 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_18 + var_165_12
					end

					if var_165_14.prefab_name ~= "" and arg_162_1.actors_[var_165_14.prefab_name] ~= nil then
						local var_165_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_14.prefab_name].transform, "story_v_out_324072", "324072038", "story_v_out_324072.awb")

						arg_162_1:RecordAudio("324072038", var_165_19)
						arg_162_1:RecordAudio("324072038", var_165_19)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_324072", "324072038", "story_v_out_324072.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_324072", "324072038", "story_v_out_324072.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_20 = math.max(var_165_13, arg_162_1.talkMaxDuration)

			if var_165_12 <= arg_162_1.time_ and arg_162_1.time_ < var_165_12 + var_165_20 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_12) / var_165_20

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_12 + var_165_20 and arg_162_1.time_ < var_165_12 + var_165_20 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_162_1:InitPlayNodeList()
	end,
	Play324072039 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 324072039
		arg_166_1.duration_ = 8.32

		local var_166_0 = {
			zh = 8.31666666666667,
			ja = 8.14966666666667
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
				arg_166_0:Play324072040(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.bgs_.ST2007 == nil then
				local var_169_0 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2007")
				var_169_0.name = "ST2007"
				var_169_0.transform.parent = arg_166_1.stage_.transform
				var_169_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_.ST2007 = var_169_0
			end

			if 1.61666666666667 < arg_166_1.time_ and arg_166_1.time_ <= 1.61666666666667 + arg_169_0 then
				local var_169_1 = arg_166_1.bgs_.ST2007

				arg_166_1.bgs_.ST2007.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_2 = var_169_1:GetComponent("SpriteRenderer")

				if var_169_2 and var_169_2.sprite then
					local var_169_3 = 2 * (var_169_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_1.transform.localScale = Vector3.New(var_169_3 / var_169_2.sprite.bounds.size.y < var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x and var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x or var_169_3 / var_169_2.sprite.bounds.size.y, var_169_3 / var_169_2.sprite.bounds.size.y < var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x and var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x or var_169_3 / var_169_2.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "ST2007" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_4 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_4 + arg_169_0 then
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

			local var_169_6 = 1.61666666666667

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

			local var_169_9 = 1.61666666666667

			if 1.61666666666667 < arg_166_1.time_ and arg_166_1.time_ <= var_169_9 + arg_169_0 then
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

			local var_169_13 = arg_166_1.actors_["6148ui_story"].transform

			if 1.61666666666667 < arg_166_1.time_ and arg_166_1.time_ <= 1.61666666666667 + arg_169_0 then
				arg_166_1.var_.moveOldPos6148ui_story = var_169_13.localPosition

				local var_169_14 = GameObjectTools.GetOrAddComponent(var_169_13.gameObject, typeof(DynamicBoneHelper))

				if var_169_14 then
					var_169_14:EnableDynamicBone(false)
				end
			end

			local var_169_15 = 0.001

			if 1.61666666666667 <= arg_166_1.time_ and arg_166_1.time_ < 1.61666666666667 + var_169_15 then
				var_169_13.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 1.61666666666667) / var_169_15)
				var_169_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_13.position).x, (manager.ui.mainCamera.transform.position - var_169_13.position).y, (manager.ui.mainCamera.transform.position - var_169_13.position).z)
				var_169_13.localEulerAngles.z = 0
				var_169_13.localEulerAngles.x = 0
				var_169_13.localEulerAngles = var_169_13.localEulerAngles
			end

			if arg_166_1.time_ >= 1.61666666666667 + var_169_15 and arg_166_1.time_ < 1.61666666666667 + var_169_15 + arg_169_0 then
				var_169_13.localPosition = Vector3.New(0, 100, 0)
				var_169_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_13.position).x, (manager.ui.mainCamera.transform.position - var_169_13.position).y, (manager.ui.mainCamera.transform.position - var_169_13.position).z)
				var_169_13.localEulerAngles.z = 0
				var_169_13.localEulerAngles.x = 0
				var_169_13.localEulerAngles = var_169_13.localEulerAngles

				local var_169_16 = GameObjectTools.GetOrAddComponent(var_169_13.gameObject, typeof(DynamicBoneHelper))

				if var_169_16 then
					var_169_16:EnableDynamicBone(true)
				end
			end

			local var_169_17 = arg_166_1.actors_["1054ui_story"].transform

			if 1.61666666666667 < arg_166_1.time_ and arg_166_1.time_ <= 1.61666666666667 + arg_169_0 then
				arg_166_1.var_.moveOldPos1054ui_story = var_169_17.localPosition

				local var_169_18 = GameObjectTools.GetOrAddComponent(var_169_17.gameObject, typeof(DynamicBoneHelper))

				if var_169_18 then
					var_169_18:EnableDynamicBone(false)
				end
			end

			local var_169_19 = 0.001

			if 1.61666666666667 <= arg_166_1.time_ and arg_166_1.time_ < 1.61666666666667 + var_169_19 then
				var_169_17.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_166_1.time_ - 1.61666666666667) / var_169_19)
				var_169_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_17.position).x, (manager.ui.mainCamera.transform.position - var_169_17.position).y, (manager.ui.mainCamera.transform.position - var_169_17.position).z)
				var_169_17.localEulerAngles.z = 0
				var_169_17.localEulerAngles.x = 0
				var_169_17.localEulerAngles = var_169_17.localEulerAngles
			end

			if arg_166_1.time_ >= 1.61666666666667 + var_169_19 and arg_166_1.time_ < 1.61666666666667 + var_169_19 + arg_169_0 then
				var_169_17.localPosition = Vector3.New(0, 100, 0)
				var_169_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_17.position).x, (manager.ui.mainCamera.transform.position - var_169_17.position).y, (manager.ui.mainCamera.transform.position - var_169_17.position).z)
				var_169_17.localEulerAngles.z = 0
				var_169_17.localEulerAngles.x = 0
				var_169_17.localEulerAngles = var_169_17.localEulerAngles

				local var_169_20 = GameObjectTools.GetOrAddComponent(var_169_17.gameObject, typeof(DynamicBoneHelper))

				if var_169_20 then
					var_169_20:EnableDynamicBone(true)
				end
			end

			if 1.2 < arg_166_1.time_ and arg_166_1.time_ <= 1.2 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.1 < arg_166_1.time_ and arg_166_1.time_ <= 0.1 + arg_169_0 then
				arg_166_1:AudioAction("stop", "effect", "se_story_birthday4", "se_story_birthday4_amb_room_tone_2", "")
			end

			if 1 < arg_166_1.time_ and arg_166_1.time_ <= 1 + arg_169_0 then
				arg_166_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_teacup02", "")
			end

			if arg_166_1.frameCnt_ <= 1 then
				arg_166_1.dialog_:SetActive(false)
			end

			local var_169_24 = 3.11666666666667
			local var_169_25 = 0.5

			if 3.11666666666667 < arg_166_1.time_ and arg_166_1.time_ <= var_169_24 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				arg_166_1.dialog_:SetActive(true)

				arg_166_1.dialogCg_.alpha = 0

				local var_169_26 = LeanTween.value(arg_166_1.dialog_, 0, 1, 0.3)

				var_169_26:setOnUpdate(LuaHelper.FloatAction(function(arg_170_0)
					arg_166_1.dialogCg_.alpha = arg_170_0
				end))
				var_169_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_166_1.dialog_)
					var_169_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_166_1.duration_ = arg_166_1.duration_ + 0.3

				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6148")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_27 = arg_166_1:GetWordFromCfg(324072039)
				local var_169_28 = arg_166_1:FormatText(var_169_27.content)

				arg_166_1.text_.text = var_169_28

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_30 = 20 <= 0 and var_169_25 or var_169_25 * (utf8.len(var_169_28) / 20)

				if (20 <= 0 and var_169_25 or var_169_25 * (utf8.len(var_169_28) / 20)) > 0 and var_169_25 < var_169_30 then
					arg_166_1.talkMaxDuration = var_169_30
					var_169_24 = var_169_24 + 0.3

					if var_169_30 + var_169_24 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_30 + var_169_24
					end
				end

				arg_166_1.text_.text = var_169_28
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072039", "story_v_out_324072.awb") ~= 0 then
					local var_169_31 = manager.audio:GetVoiceLength("story_v_out_324072", "324072039", "story_v_out_324072.awb") / 1000

					if var_169_31 + var_169_24 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_31 + var_169_24
					end

					if var_169_27.prefab_name ~= "" and arg_166_1.actors_[var_169_27.prefab_name] ~= nil then
						local var_169_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_27.prefab_name].transform, "story_v_out_324072", "324072039", "story_v_out_324072.awb")

						arg_166_1:RecordAudio("324072039", var_169_32)
						arg_166_1:RecordAudio("324072039", var_169_32)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_324072", "324072039", "story_v_out_324072.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_324072", "324072039", "story_v_out_324072.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_33 = var_169_24 + 0.3
			local var_169_34 = math.max(var_169_25, arg_166_1.talkMaxDuration)

			if var_169_24 + 0.3 <= arg_166_1.time_ and arg_166_1.time_ < var_169_33 + var_169_34 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_33) / var_169_34

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_33 + var_169_34 and arg_166_1.time_ < var_169_33 + var_169_34 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.61666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.61666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play324072040 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 324072040
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play324072041(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(arg_172_1.actors_["6148ui_story"]) and arg_172_1.var_.characterEffect6148ui_story == nil then
				arg_172_1.var_.characterEffect6148ui_story = arg_172_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_0 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 and not isNil(arg_172_1.actors_["6148ui_story"]) then
				if arg_172_1.var_.characterEffect6148ui_story and not isNil(arg_172_1.actors_["6148ui_story"]) then
					arg_172_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_172_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_0)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 and not isNil(arg_172_1.actors_["6148ui_story"]) and arg_172_1.var_.characterEffect6148ui_story then
				arg_172_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_172_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_175_1 = 0
			local var_175_2 = 1.5

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_1 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_3 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(324072040).content)

				arg_172_1.text_.text = var_175_3

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_5 = 60 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 60)

				if (60 <= 0 and var_175_2 or var_175_2 * (utf8.len(var_175_3) / 60)) > 0 and var_175_2 < var_175_5 then
					arg_172_1.talkMaxDuration = var_175_5

					if var_175_5 + var_175_1 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_5 + var_175_1
					end
				end

				arg_172_1.text_.text = var_175_3
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_6 = math.max(var_175_2, arg_172_1.talkMaxDuration)

			if var_175_1 <= arg_172_1.time_ and arg_172_1.time_ < var_175_1 + var_175_6 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_1) / var_175_6

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_1 + var_175_6 and arg_172_1.time_ < var_175_1 + var_175_6 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {}

		arg_172_1:InitPlayNodeList()
	end,
	Play324072041 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 324072041
		arg_176_1.duration_ = 5

		SetActive(arg_176_1.tipsGo_, false)

		function arg_176_1.onSingleLineFinish_()
			arg_176_1.onSingleLineUpdate_ = nil
			arg_176_1.onSingleLineFinish_ = nil
			arg_176_1.state_ = "waiting"
		end

		function arg_176_1.playNext_(arg_178_0)
			if arg_178_0 == 1 then
				arg_176_0:Play324072042(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			local var_179_0 = 0.3

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

				local var_179_1 = arg_176_1:FormatText(arg_176_1:GetWordFromCfg(324072041).content)

				arg_176_1.text_.text = var_179_1

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_3 = 12 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 12)

				if (12 <= 0 and var_179_0 or var_179_0 * (utf8.len(var_179_1) / 12)) > 0 and var_179_0 < var_179_3 then
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
	Play324072042 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 324072042
		arg_180_1.duration_ = 6.43

		local var_180_0 = {
			zh = 6.333,
			ja = 6.433
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
				arg_180_0:Play324072043(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1.var_.moveOldPos1054ui_story = arg_180_1.actors_["1054ui_story"].transform.localPosition

				local var_183_0 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_0 then
					var_183_0:EnableDynamicBone(false)
				end
			end

			local var_183_1 = 0.001

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_1 then
				arg_180_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_180_1.time_ - 0) / var_183_1)
				arg_180_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1054ui_story"].transform.position).z)
				arg_180_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1054ui_story"].transform.localEulerAngles = arg_180_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_180_1.time_ >= 0 + var_183_1 and arg_180_1.time_ < 0 + var_183_1 + arg_183_0 then
				arg_180_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_180_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_180_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_180_1.actors_["1054ui_story"].transform.position).z)
				arg_180_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_180_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_180_1.actors_["1054ui_story"].transform.localEulerAngles = arg_180_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_183_2 = GameObjectTools.GetOrAddComponent(arg_180_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_183_2 then
					var_183_2:EnableDynamicBone(true)
				end
			end

			local var_183_3 = arg_180_1.actors_["1054ui_story"]

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect1054ui_story == nil then
				arg_180_1.var_.characterEffect1054ui_story = var_183_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_4 = 0.200000002980232

			if 0 <= arg_180_1.time_ and arg_180_1.time_ < 0 + var_183_4 and not isNil(var_183_3) then
				if arg_180_1.var_.characterEffect1054ui_story and not isNil(var_183_3) then
					arg_180_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_180_1.time_ >= 0 + var_183_4 and arg_180_1.time_ < 0 + var_183_4 + arg_183_0 and not isNil(var_183_3) and arg_180_1.var_.characterEffect1054ui_story then
				arg_180_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= 0 + arg_183_0 then
				arg_180_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_183_6 = 0
			local var_183_7 = 0.55

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_6 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0
				arg_180_1.dialogCg_.alpha = 1

				arg_180_1.dialog_:SetActive(true)
				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, false)
				arg_180_1.callingController_:SetSelectedState("normal")

				local var_183_8 = arg_180_1:GetWordFromCfg(324072042)
				local var_183_9 = arg_180_1:FormatText(var_183_8.content)

				arg_180_1.text_.text = var_183_9

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_11 = 22 <= 0 and var_183_7 or var_183_7 * (utf8.len(var_183_9) / 22)

				if (22 <= 0 and var_183_7 or var_183_7 * (utf8.len(var_183_9) / 22)) > 0 and var_183_7 < var_183_11 then
					arg_180_1.talkMaxDuration = var_183_11

					if var_183_11 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_11 + var_183_6
					end
				end

				arg_180_1.text_.text = var_183_9
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072042", "story_v_out_324072.awb") ~= 0 then
					local var_183_12 = manager.audio:GetVoiceLength("story_v_out_324072", "324072042", "story_v_out_324072.awb") / 1000

					if var_183_12 + var_183_6 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_12 + var_183_6
					end

					if var_183_8.prefab_name ~= "" and arg_180_1.actors_[var_183_8.prefab_name] ~= nil then
						local var_183_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_180_1.actors_[var_183_8.prefab_name].transform, "story_v_out_324072", "324072042", "story_v_out_324072.awb")

						arg_180_1:RecordAudio("324072042", var_183_13)
						arg_180_1:RecordAudio("324072042", var_183_13)
					else
						arg_180_1:AudioAction("play", "voice", "story_v_out_324072", "324072042", "story_v_out_324072.awb")
					end

					arg_180_1:RecordHistoryTalkVoice("story_v_out_324072", "324072042", "story_v_out_324072.awb")
				end

				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_14 = math.max(var_183_7, arg_180_1.talkMaxDuration)

			if var_183_6 <= arg_180_1.time_ and arg_180_1.time_ < var_183_6 + var_183_14 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_6) / var_183_14

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_6 + var_183_14 and arg_180_1.time_ < var_183_6 + var_183_14 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play324072043 = function(arg_184_0, arg_184_1)
		arg_184_1.time_ = 0
		arg_184_1.frameCnt_ = 0
		arg_184_1.state_ = "playing"
		arg_184_1.curTalkId_ = 324072043
		arg_184_1.duration_ = 5

		SetActive(arg_184_1.tipsGo_, false)

		function arg_184_1.onSingleLineFinish_()
			arg_184_1.onSingleLineUpdate_ = nil
			arg_184_1.onSingleLineFinish_ = nil
			arg_184_1.state_ = "waiting"
		end

		function arg_184_1.playNext_(arg_186_0)
			if arg_186_0 == 1 then
				arg_184_0:Play324072044(arg_184_1)
			end
		end

		function arg_184_1.onSingleLineUpdate_(arg_187_0)
			if 0 < arg_184_1.time_ and arg_184_1.time_ <= 0 + arg_187_0 and not isNil(arg_184_1.actors_["1054ui_story"]) and arg_184_1.var_.characterEffect1054ui_story == nil then
				arg_184_1.var_.characterEffect1054ui_story = arg_184_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_187_0 = 0.200000002980232

			if 0 <= arg_184_1.time_ and arg_184_1.time_ < 0 + var_187_0 and not isNil(arg_184_1.actors_["1054ui_story"]) then
				if arg_184_1.var_.characterEffect1054ui_story and not isNil(arg_184_1.actors_["1054ui_story"]) then
					arg_184_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_184_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_184_1.time_ - 0) / var_187_0)
				end
			end

			if arg_184_1.time_ >= 0 + var_187_0 and arg_184_1.time_ < 0 + var_187_0 + arg_187_0 and not isNil(arg_184_1.actors_["1054ui_story"]) and arg_184_1.var_.characterEffect1054ui_story then
				arg_184_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_184_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_187_1 = 0
			local var_187_2 = 0.85

			if 0 < arg_184_1.time_ and arg_184_1.time_ <= var_187_1 + arg_187_0 then
				arg_184_1.talkMaxDuration = 0
				arg_184_1.dialogCg_.alpha = 1

				arg_184_1.dialog_:SetActive(true)
				SetActive(arg_184_1.leftNameGo_, true)

				arg_184_1.leftNameTxt_.text = arg_184_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_184_1.leftNameTxt_.transform)

				arg_184_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_184_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_184_1:RecordName(arg_184_1.leftNameTxt_.text)
				SetActive(arg_184_1.iconTrs_.gameObject, true)
				arg_184_1.iconController_:SetSelectedState("hero")

				arg_184_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_184_1.callingController_:SetSelectedState("normal")

				arg_184_1.keyicon_.color = Color.New(1, 1, 1)
				arg_184_1.icon_.color = Color.New(1, 1, 1)

				local var_187_3 = arg_184_1:FormatText(arg_184_1:GetWordFromCfg(324072043).content)

				arg_184_1.text_.text = var_187_3

				LuaForUtil.ClearLinePrefixSymbol(arg_184_1.text_)

				local var_187_5 = 34 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 34)

				if (34 <= 0 and var_187_2 or var_187_2 * (utf8.len(var_187_3) / 34)) > 0 and var_187_2 < var_187_5 then
					arg_184_1.talkMaxDuration = var_187_5

					if var_187_5 + var_187_1 > arg_184_1.duration_ then
						arg_184_1.duration_ = var_187_5 + var_187_1
					end
				end

				arg_184_1.text_.text = var_187_3
				arg_184_1.typewritter.percent = 0

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(false)
				arg_184_1:RecordContent(arg_184_1.text_.text)
			end

			local var_187_6 = math.max(var_187_2, arg_184_1.talkMaxDuration)

			if var_187_1 <= arg_184_1.time_ and arg_184_1.time_ < var_187_1 + var_187_6 then
				arg_184_1.typewritter.percent = (arg_184_1.time_ - var_187_1) / var_187_6

				arg_184_1.typewritter:SetDirty()
			end

			if arg_184_1.time_ >= var_187_1 + var_187_6 and arg_184_1.time_ < var_187_1 + var_187_6 + arg_187_0 then
				arg_184_1.typewritter.percent = 1

				arg_184_1.typewritter:SetDirty()
				arg_184_1:ShowNextGo(true)
			end
		end

		arg_184_1.nodeConfigList_ = {}

		arg_184_1:InitPlayNodeList()
	end,
	Play324072044 = function(arg_188_0, arg_188_1)
		arg_188_1.time_ = 0
		arg_188_1.frameCnt_ = 0
		arg_188_1.state_ = "playing"
		arg_188_1.curTalkId_ = 324072044
		arg_188_1.duration_ = 5.67

		local var_188_0 = {
			zh = 3.8,
			ja = 5.666
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
				arg_188_0:Play324072045(arg_188_1)
			end
		end

		function arg_188_1.onSingleLineUpdate_(arg_191_0)
			if 0 < arg_188_1.time_ and arg_188_1.time_ <= 0 + arg_191_0 and not isNil(arg_188_1.actors_["1054ui_story"]) and arg_188_1.var_.characterEffect1054ui_story == nil then
				arg_188_1.var_.characterEffect1054ui_story = arg_188_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_191_0 = 0.200000002980232

			if 0 <= arg_188_1.time_ and arg_188_1.time_ < 0 + var_191_0 and not isNil(arg_188_1.actors_["1054ui_story"]) then
				if arg_188_1.var_.characterEffect1054ui_story and not isNil(arg_188_1.actors_["1054ui_story"]) then
					arg_188_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_188_1.time_ >= 0 + var_191_0 and arg_188_1.time_ < 0 + var_191_0 + arg_191_0 and not isNil(arg_188_1.actors_["1054ui_story"]) and arg_188_1.var_.characterEffect1054ui_story then
				arg_188_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_191_2 = 0
			local var_191_3 = 0.3

			if 0 < arg_188_1.time_ and arg_188_1.time_ <= var_191_2 + arg_191_0 then
				arg_188_1.talkMaxDuration = 0
				arg_188_1.dialogCg_.alpha = 1

				arg_188_1.dialog_:SetActive(true)
				SetActive(arg_188_1.leftNameGo_, true)

				arg_188_1.leftNameTxt_.text = arg_188_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_188_1.leftNameTxt_.transform)

				arg_188_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_188_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_188_1:RecordName(arg_188_1.leftNameTxt_.text)
				SetActive(arg_188_1.iconTrs_.gameObject, false)
				arg_188_1.callingController_:SetSelectedState("normal")

				local var_191_4 = arg_188_1:GetWordFromCfg(324072044)
				local var_191_5 = arg_188_1:FormatText(var_191_4.content)

				arg_188_1.text_.text = var_191_5

				LuaForUtil.ClearLinePrefixSymbol(arg_188_1.text_)

				local var_191_7 = 12 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 12)

				if (12 <= 0 and var_191_3 or var_191_3 * (utf8.len(var_191_5) / 12)) > 0 and var_191_3 < var_191_7 then
					arg_188_1.talkMaxDuration = var_191_7

					if var_191_7 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_7 + var_191_2
					end
				end

				arg_188_1.text_.text = var_191_5
				arg_188_1.typewritter.percent = 0

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072044", "story_v_out_324072.awb") ~= 0 then
					local var_191_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072044", "story_v_out_324072.awb") / 1000

					if var_191_8 + var_191_2 > arg_188_1.duration_ then
						arg_188_1.duration_ = var_191_8 + var_191_2
					end

					if var_191_4.prefab_name ~= "" and arg_188_1.actors_[var_191_4.prefab_name] ~= nil then
						local var_191_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_188_1.actors_[var_191_4.prefab_name].transform, "story_v_out_324072", "324072044", "story_v_out_324072.awb")

						arg_188_1:RecordAudio("324072044", var_191_9)
						arg_188_1:RecordAudio("324072044", var_191_9)
					else
						arg_188_1:AudioAction("play", "voice", "story_v_out_324072", "324072044", "story_v_out_324072.awb")
					end

					arg_188_1:RecordHistoryTalkVoice("story_v_out_324072", "324072044", "story_v_out_324072.awb")
				end

				arg_188_1:RecordContent(arg_188_1.text_.text)
			end

			local var_191_10 = math.max(var_191_3, arg_188_1.talkMaxDuration)

			if var_191_2 <= arg_188_1.time_ and arg_188_1.time_ < var_191_2 + var_191_10 then
				arg_188_1.typewritter.percent = (arg_188_1.time_ - var_191_2) / var_191_10

				arg_188_1.typewritter:SetDirty()
			end

			if arg_188_1.time_ >= var_191_2 + var_191_10 and arg_188_1.time_ < var_191_2 + var_191_10 + arg_191_0 then
				arg_188_1.typewritter.percent = 1

				arg_188_1.typewritter:SetDirty()
				arg_188_1:ShowNextGo(true)
			end
		end

		arg_188_1.nodeConfigList_ = {}

		arg_188_1:InitPlayNodeList()
	end,
	Play324072045 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 324072045
		arg_192_1.duration_ = 6.87

		local var_192_0 = {
			zh = 5.8,
			ja = 6.866
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
				arg_192_0:Play324072046(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos1054ui_story = arg_192_1.actors_["1054ui_story"].transform.localPosition

				local var_195_0 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_0 then
					var_195_0:EnableDynamicBone(false)
				end
			end

			local var_195_1 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_1 then
				arg_192_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_192_1.time_ - 0) / var_195_1)
				arg_192_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1054ui_story"].transform.position).z)
				arg_192_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1054ui_story"].transform.localEulerAngles = arg_192_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_1 and arg_192_1.time_ < 0 + var_195_1 + arg_195_0 then
				arg_192_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_192_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_192_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_192_1.actors_["1054ui_story"].transform.position).z)
				arg_192_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_192_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_192_1.actors_["1054ui_story"].transform.localEulerAngles = arg_192_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_195_2 = GameObjectTools.GetOrAddComponent(arg_192_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_195_2 then
					var_195_2:EnableDynamicBone(true)
				end
			end

			local var_195_3 = arg_192_1.actors_["6148ui_story"].transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.moveOldPos6148ui_story = var_195_3.localPosition

				local var_195_4 = GameObjectTools.GetOrAddComponent(var_195_3.gameObject, typeof(DynamicBoneHelper))

				if var_195_4 then
					var_195_4:EnableDynamicBone(false)
				end
			end

			local var_195_5 = 0.001

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_5 then
				var_195_3.localPosition = Vector3.Lerp(arg_192_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_192_1.time_ - 0) / var_195_5)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles
			end

			if arg_192_1.time_ >= 0 + var_195_5 and arg_192_1.time_ < 0 + var_195_5 + arg_195_0 then
				var_195_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_195_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_195_3.position).x, (manager.ui.mainCamera.transform.position - var_195_3.position).y, (manager.ui.mainCamera.transform.position - var_195_3.position).z)
				var_195_3.localEulerAngles.z = 0
				var_195_3.localEulerAngles.x = 0
				var_195_3.localEulerAngles = var_195_3.localEulerAngles

				local var_195_6 = GameObjectTools.GetOrAddComponent(var_195_3.gameObject, typeof(DynamicBoneHelper))

				if var_195_6 then
					var_195_6:EnableDynamicBone(true)
				end
			end

			local var_195_7 = arg_192_1.actors_["6148ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.characterEffect6148ui_story == nil then
				arg_192_1.var_.characterEffect6148ui_story = var_195_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_8 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_8 and not isNil(var_195_7) then
				if arg_192_1.var_.characterEffect6148ui_story and not isNil(var_195_7) then
					arg_192_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_192_1.time_ >= 0 + var_195_8 and arg_192_1.time_ < 0 + var_195_8 + arg_195_0 and not isNil(var_195_7) and arg_192_1.var_.characterEffect6148ui_story then
				arg_192_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_195_10 = arg_192_1.actors_["1054ui_story"]

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 and not isNil(var_195_10) and arg_192_1.var_.characterEffect1054ui_story == nil then
				arg_192_1.var_.characterEffect1054ui_story = var_195_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_195_11 = 0.200000002980232

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_11 and not isNil(var_195_10) then
				if arg_192_1.var_.characterEffect1054ui_story and not isNil(var_195_10) then
					arg_192_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_192_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_192_1.time_ - 0) / var_195_11)
				end
			end

			if arg_192_1.time_ >= 0 + var_195_11 and arg_192_1.time_ < 0 + var_195_11 + arg_195_0 and not isNil(var_195_10) and arg_192_1.var_.characterEffect1054ui_story then
				arg_192_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_192_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148actionlink/6148action452")
			end

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_195_12 = 0
			local var_195_13 = 0.675

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_12 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0
				arg_192_1.dialogCg_.alpha = 1

				arg_192_1.dialog_:SetActive(true)
				SetActive(arg_192_1.leftNameGo_, true)

				arg_192_1.leftNameTxt_.text = arg_192_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_192_1.leftNameTxt_.transform)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1.leftNameTxt_.text)
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_14 = arg_192_1:GetWordFromCfg(324072045)
				local var_195_15 = arg_192_1:FormatText(var_195_14.content)

				arg_192_1.text_.text = var_195_15

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_17 = 27 <= 0 and var_195_13 or var_195_13 * (utf8.len(var_195_15) / 27)

				if (27 <= 0 and var_195_13 or var_195_13 * (utf8.len(var_195_15) / 27)) > 0 and var_195_13 < var_195_17 then
					arg_192_1.talkMaxDuration = var_195_17

					if var_195_17 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_17 + var_195_12
					end
				end

				arg_192_1.text_.text = var_195_15
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072045", "story_v_out_324072.awb") ~= 0 then
					local var_195_18 = manager.audio:GetVoiceLength("story_v_out_324072", "324072045", "story_v_out_324072.awb") / 1000

					if var_195_18 + var_195_12 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_18 + var_195_12
					end

					if var_195_14.prefab_name ~= "" and arg_192_1.actors_[var_195_14.prefab_name] ~= nil then
						local var_195_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_192_1.actors_[var_195_14.prefab_name].transform, "story_v_out_324072", "324072045", "story_v_out_324072.awb")

						arg_192_1:RecordAudio("324072045", var_195_19)
						arg_192_1:RecordAudio("324072045", var_195_19)
					else
						arg_192_1:AudioAction("play", "voice", "story_v_out_324072", "324072045", "story_v_out_324072.awb")
					end

					arg_192_1:RecordHistoryTalkVoice("story_v_out_324072", "324072045", "story_v_out_324072.awb")
				end

				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_20 = math.max(var_195_13, arg_192_1.talkMaxDuration)

			if var_195_12 <= arg_192_1.time_ and arg_192_1.time_ < var_195_12 + var_195_20 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_12) / var_195_20

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_12 + var_195_20 and arg_192_1.time_ < var_195_12 + var_195_20 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_192_1:InitPlayNodeList()
	end,
	Play324072046 = function(arg_196_0, arg_196_1)
		arg_196_1.time_ = 0
		arg_196_1.frameCnt_ = 0
		arg_196_1.state_ = "playing"
		arg_196_1.curTalkId_ = 324072046
		arg_196_1.duration_ = 2.3

		local var_196_0 = {
			zh = 1.999999999999,
			ja = 2.3
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
				arg_196_0:Play324072047(arg_196_1)
			end
		end

		function arg_196_1.onSingleLineUpdate_(arg_199_0)
			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(arg_196_1.actors_["1054ui_story"]) and arg_196_1.var_.characterEffect1054ui_story == nil then
				arg_196_1.var_.characterEffect1054ui_story = arg_196_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_0 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_0 and not isNil(arg_196_1.actors_["1054ui_story"]) then
				if arg_196_1.var_.characterEffect1054ui_story and not isNil(arg_196_1.actors_["1054ui_story"]) then
					arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_196_1.time_ >= 0 + var_199_0 and arg_196_1.time_ < 0 + var_199_0 + arg_199_0 and not isNil(arg_196_1.actors_["1054ui_story"]) and arg_196_1.var_.characterEffect1054ui_story then
				arg_196_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_199_2 = arg_196_1.actors_["6148ui_story"]

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect6148ui_story == nil then
				arg_196_1.var_.characterEffect6148ui_story = var_199_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_199_3 = 0.200000002980232

			if 0 <= arg_196_1.time_ and arg_196_1.time_ < 0 + var_199_3 and not isNil(var_199_2) then
				if arg_196_1.var_.characterEffect6148ui_story and not isNil(var_199_2) then
					arg_196_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_196_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_196_1.time_ - 0) / var_199_3)
				end
			end

			if arg_196_1.time_ >= 0 + var_199_3 and arg_196_1.time_ < 0 + var_199_3 + arg_199_0 and not isNil(var_199_2) and arg_196_1.var_.characterEffect6148ui_story then
				arg_196_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_196_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action6_1")
			end

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= 0 + arg_199_0 then
				arg_196_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			local var_199_4 = 0
			local var_199_5 = 0.075

			if 0 < arg_196_1.time_ and arg_196_1.time_ <= var_199_4 + arg_199_0 then
				arg_196_1.talkMaxDuration = 0
				arg_196_1.dialogCg_.alpha = 1

				arg_196_1.dialog_:SetActive(true)
				SetActive(arg_196_1.leftNameGo_, true)

				arg_196_1.leftNameTxt_.text = arg_196_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_196_1.leftNameTxt_.transform)

				arg_196_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_196_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_196_1:RecordName(arg_196_1.leftNameTxt_.text)
				SetActive(arg_196_1.iconTrs_.gameObject, false)
				arg_196_1.callingController_:SetSelectedState("normal")

				local var_199_6 = arg_196_1:GetWordFromCfg(324072046)
				local var_199_7 = arg_196_1:FormatText(var_199_6.content)

				arg_196_1.text_.text = var_199_7

				LuaForUtil.ClearLinePrefixSymbol(arg_196_1.text_)

				local var_199_9 = 3 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 3)

				if (3 <= 0 and var_199_5 or var_199_5 * (utf8.len(var_199_7) / 3)) > 0 and var_199_5 < var_199_9 then
					arg_196_1.talkMaxDuration = var_199_9

					if var_199_9 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_9 + var_199_4
					end
				end

				arg_196_1.text_.text = var_199_7
				arg_196_1.typewritter.percent = 0

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072046", "story_v_out_324072.awb") ~= 0 then
					local var_199_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072046", "story_v_out_324072.awb") / 1000

					if var_199_10 + var_199_4 > arg_196_1.duration_ then
						arg_196_1.duration_ = var_199_10 + var_199_4
					end

					if var_199_6.prefab_name ~= "" and arg_196_1.actors_[var_199_6.prefab_name] ~= nil then
						local var_199_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_196_1.actors_[var_199_6.prefab_name].transform, "story_v_out_324072", "324072046", "story_v_out_324072.awb")

						arg_196_1:RecordAudio("324072046", var_199_11)
						arg_196_1:RecordAudio("324072046", var_199_11)
					else
						arg_196_1:AudioAction("play", "voice", "story_v_out_324072", "324072046", "story_v_out_324072.awb")
					end

					arg_196_1:RecordHistoryTalkVoice("story_v_out_324072", "324072046", "story_v_out_324072.awb")
				end

				arg_196_1:RecordContent(arg_196_1.text_.text)
			end

			local var_199_12 = math.max(var_199_5, arg_196_1.talkMaxDuration)

			if var_199_4 <= arg_196_1.time_ and arg_196_1.time_ < var_199_4 + var_199_12 then
				arg_196_1.typewritter.percent = (arg_196_1.time_ - var_199_4) / var_199_12

				arg_196_1.typewritter:SetDirty()
			end

			if arg_196_1.time_ >= var_199_4 + var_199_12 and arg_196_1.time_ < var_199_4 + var_199_12 + arg_199_0 then
				arg_196_1.typewritter.percent = 1

				arg_196_1.typewritter:SetDirty()
				arg_196_1:ShowNextGo(true)
			end
		end

		arg_196_1.nodeConfigList_ = {}

		arg_196_1:InitPlayNodeList()
	end,
	Play324072047 = function(arg_200_0, arg_200_1)
		arg_200_1.time_ = 0
		arg_200_1.frameCnt_ = 0
		arg_200_1.state_ = "playing"
		arg_200_1.curTalkId_ = 324072047
		arg_200_1.duration_ = 5

		SetActive(arg_200_1.tipsGo_, false)

		function arg_200_1.onSingleLineFinish_()
			arg_200_1.onSingleLineUpdate_ = nil
			arg_200_1.onSingleLineFinish_ = nil
			arg_200_1.state_ = "waiting"
		end

		function arg_200_1.playNext_(arg_202_0)
			if arg_202_0 == 1 then
				arg_200_0:Play324072048(arg_200_1)
			end
		end

		function arg_200_1.onSingleLineUpdate_(arg_203_0)
			if 0 < arg_200_1.time_ and arg_200_1.time_ <= 0 + arg_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) and arg_200_1.var_.characterEffect1054ui_story == nil then
				arg_200_1.var_.characterEffect1054ui_story = arg_200_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_203_0 = 0.200000002980232

			if 0 <= arg_200_1.time_ and arg_200_1.time_ < 0 + var_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) then
				if arg_200_1.var_.characterEffect1054ui_story and not isNil(arg_200_1.actors_["1054ui_story"]) then
					arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_200_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_200_1.time_ - 0) / var_203_0)
				end
			end

			if arg_200_1.time_ >= 0 + var_203_0 and arg_200_1.time_ < 0 + var_203_0 + arg_203_0 and not isNil(arg_200_1.actors_["1054ui_story"]) and arg_200_1.var_.characterEffect1054ui_story then
				arg_200_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_200_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_203_1 = 0
			local var_203_2 = 0.125

			if 0 < arg_200_1.time_ and arg_200_1.time_ <= var_203_1 + arg_203_0 then
				arg_200_1.talkMaxDuration = 0
				arg_200_1.dialogCg_.alpha = 1

				arg_200_1.dialog_:SetActive(true)
				SetActive(arg_200_1.leftNameGo_, true)

				arg_200_1.leftNameTxt_.text = arg_200_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_200_1.leftNameTxt_.transform)

				arg_200_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_200_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_200_1:RecordName(arg_200_1.leftNameTxt_.text)
				SetActive(arg_200_1.iconTrs_.gameObject, true)
				arg_200_1.iconController_:SetSelectedState("hero")

				arg_200_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_200_1.callingController_:SetSelectedState("normal")

				arg_200_1.keyicon_.color = Color.New(1, 1, 1)
				arg_200_1.icon_.color = Color.New(1, 1, 1)

				local var_203_3 = arg_200_1:FormatText(arg_200_1:GetWordFromCfg(324072047).content)

				arg_200_1.text_.text = var_203_3

				LuaForUtil.ClearLinePrefixSymbol(arg_200_1.text_)

				local var_203_5 = 5 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 5)

				if (5 <= 0 and var_203_2 or var_203_2 * (utf8.len(var_203_3) / 5)) > 0 and var_203_2 < var_203_5 then
					arg_200_1.talkMaxDuration = var_203_5

					if var_203_5 + var_203_1 > arg_200_1.duration_ then
						arg_200_1.duration_ = var_203_5 + var_203_1
					end
				end

				arg_200_1.text_.text = var_203_3
				arg_200_1.typewritter.percent = 0

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(false)
				arg_200_1:RecordContent(arg_200_1.text_.text)
			end

			local var_203_6 = math.max(var_203_2, arg_200_1.talkMaxDuration)

			if var_203_1 <= arg_200_1.time_ and arg_200_1.time_ < var_203_1 + var_203_6 then
				arg_200_1.typewritter.percent = (arg_200_1.time_ - var_203_1) / var_203_6

				arg_200_1.typewritter:SetDirty()
			end

			if arg_200_1.time_ >= var_203_1 + var_203_6 and arg_200_1.time_ < var_203_1 + var_203_6 + arg_203_0 then
				arg_200_1.typewritter.percent = 1

				arg_200_1.typewritter:SetDirty()
				arg_200_1:ShowNextGo(true)
			end
		end

		arg_200_1.nodeConfigList_ = {}

		arg_200_1:InitPlayNodeList()
	end,
	Play324072048 = function(arg_204_0, arg_204_1)
		arg_204_1.time_ = 0
		arg_204_1.frameCnt_ = 0
		arg_204_1.state_ = "playing"
		arg_204_1.curTalkId_ = 324072048
		arg_204_1.duration_ = 7.2

		local var_204_0 = {
			zh = 7.2,
			ja = 4.666
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
				arg_204_0:Play324072049(arg_204_1)
			end
		end

		function arg_204_1.onSingleLineUpdate_(arg_207_0)
			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 and not isNil(arg_204_1.actors_["1054ui_story"]) and arg_204_1.var_.characterEffect1054ui_story == nil then
				arg_204_1.var_.characterEffect1054ui_story = arg_204_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_207_0 = 0.200000002980232

			if 0 <= arg_204_1.time_ and arg_204_1.time_ < 0 + var_207_0 and not isNil(arg_204_1.actors_["1054ui_story"]) then
				if arg_204_1.var_.characterEffect1054ui_story and not isNil(arg_204_1.actors_["1054ui_story"]) then
					arg_204_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_204_1.time_ >= 0 + var_207_0 and arg_204_1.time_ < 0 + var_207_0 + arg_207_0 and not isNil(arg_204_1.actors_["1054ui_story"]) and arg_204_1.var_.characterEffect1054ui_story then
				arg_204_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= 0 + arg_207_0 then
				arg_204_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054actionlink/1054action467")
			end

			local var_207_2 = 0
			local var_207_3 = 0.5

			if 0 < arg_204_1.time_ and arg_204_1.time_ <= var_207_2 + arg_207_0 then
				arg_204_1.talkMaxDuration = 0
				arg_204_1.dialogCg_.alpha = 1

				arg_204_1.dialog_:SetActive(true)
				SetActive(arg_204_1.leftNameGo_, true)

				arg_204_1.leftNameTxt_.text = arg_204_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_204_1.leftNameTxt_.transform)

				arg_204_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_204_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_204_1:RecordName(arg_204_1.leftNameTxt_.text)
				SetActive(arg_204_1.iconTrs_.gameObject, false)
				arg_204_1.callingController_:SetSelectedState("normal")

				local var_207_4 = arg_204_1:GetWordFromCfg(324072048)
				local var_207_5 = arg_204_1:FormatText(var_207_4.content)

				arg_204_1.text_.text = var_207_5

				LuaForUtil.ClearLinePrefixSymbol(arg_204_1.text_)

				local var_207_7 = 20 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 20)

				if (20 <= 0 and var_207_3 or var_207_3 * (utf8.len(var_207_5) / 20)) > 0 and var_207_3 < var_207_7 then
					arg_204_1.talkMaxDuration = var_207_7

					if var_207_7 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_7 + var_207_2
					end
				end

				arg_204_1.text_.text = var_207_5
				arg_204_1.typewritter.percent = 0

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072048", "story_v_out_324072.awb") ~= 0 then
					local var_207_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072048", "story_v_out_324072.awb") / 1000

					if var_207_8 + var_207_2 > arg_204_1.duration_ then
						arg_204_1.duration_ = var_207_8 + var_207_2
					end

					if var_207_4.prefab_name ~= "" and arg_204_1.actors_[var_207_4.prefab_name] ~= nil then
						local var_207_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_204_1.actors_[var_207_4.prefab_name].transform, "story_v_out_324072", "324072048", "story_v_out_324072.awb")

						arg_204_1:RecordAudio("324072048", var_207_9)
						arg_204_1:RecordAudio("324072048", var_207_9)
					else
						arg_204_1:AudioAction("play", "voice", "story_v_out_324072", "324072048", "story_v_out_324072.awb")
					end

					arg_204_1:RecordHistoryTalkVoice("story_v_out_324072", "324072048", "story_v_out_324072.awb")
				end

				arg_204_1:RecordContent(arg_204_1.text_.text)
			end

			local var_207_10 = math.max(var_207_3, arg_204_1.talkMaxDuration)

			if var_207_2 <= arg_204_1.time_ and arg_204_1.time_ < var_207_2 + var_207_10 then
				arg_204_1.typewritter.percent = (arg_204_1.time_ - var_207_2) / var_207_10

				arg_204_1.typewritter:SetDirty()
			end

			if arg_204_1.time_ >= var_207_2 + var_207_10 and arg_204_1.time_ < var_207_2 + var_207_10 + arg_207_0 then
				arg_204_1.typewritter.percent = 1

				arg_204_1.typewritter:SetDirty()
				arg_204_1:ShowNextGo(true)
			end
		end

		arg_204_1.nodeConfigList_ = {}

		arg_204_1:InitPlayNodeList()
	end,
	Play324072049 = function(arg_208_0, arg_208_1)
		arg_208_1.time_ = 0
		arg_208_1.frameCnt_ = 0
		arg_208_1.state_ = "playing"
		arg_208_1.curTalkId_ = 324072049
		arg_208_1.duration_ = 5

		SetActive(arg_208_1.tipsGo_, false)

		function arg_208_1.onSingleLineFinish_()
			arg_208_1.onSingleLineUpdate_ = nil
			arg_208_1.onSingleLineFinish_ = nil
			arg_208_1.state_ = "waiting"
		end

		function arg_208_1.playNext_(arg_210_0)
			if arg_210_0 == 1 then
				arg_208_0:Play324072050(arg_208_1)
			end
		end

		function arg_208_1.onSingleLineUpdate_(arg_211_0)
			if 0 < arg_208_1.time_ and arg_208_1.time_ <= 0 + arg_211_0 and not isNil(arg_208_1.actors_["1054ui_story"]) and arg_208_1.var_.characterEffect1054ui_story == nil then
				arg_208_1.var_.characterEffect1054ui_story = arg_208_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_211_0 = 0.200000002980232

			if 0 <= arg_208_1.time_ and arg_208_1.time_ < 0 + var_211_0 and not isNil(arg_208_1.actors_["1054ui_story"]) then
				if arg_208_1.var_.characterEffect1054ui_story and not isNil(arg_208_1.actors_["1054ui_story"]) then
					arg_208_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_208_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_208_1.time_ - 0) / var_211_0)
				end
			end

			if arg_208_1.time_ >= 0 + var_211_0 and arg_208_1.time_ < 0 + var_211_0 + arg_211_0 and not isNil(arg_208_1.actors_["1054ui_story"]) and arg_208_1.var_.characterEffect1054ui_story then
				arg_208_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_208_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_211_1 = 0
			local var_211_2 = 0.575

			if 0 < arg_208_1.time_ and arg_208_1.time_ <= var_211_1 + arg_211_0 then
				arg_208_1.talkMaxDuration = 0
				arg_208_1.dialogCg_.alpha = 1

				arg_208_1.dialog_:SetActive(true)
				SetActive(arg_208_1.leftNameGo_, true)

				arg_208_1.leftNameTxt_.text = arg_208_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_208_1.leftNameTxt_.transform)

				arg_208_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_208_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_208_1:RecordName(arg_208_1.leftNameTxt_.text)
				SetActive(arg_208_1.iconTrs_.gameObject, true)
				arg_208_1.iconController_:SetSelectedState("hero")

				arg_208_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_208_1.callingController_:SetSelectedState("normal")

				arg_208_1.keyicon_.color = Color.New(1, 1, 1)
				arg_208_1.icon_.color = Color.New(1, 1, 1)

				local var_211_3 = arg_208_1:FormatText(arg_208_1:GetWordFromCfg(324072049).content)

				arg_208_1.text_.text = var_211_3

				LuaForUtil.ClearLinePrefixSymbol(arg_208_1.text_)

				local var_211_5 = 23 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 23)

				if (23 <= 0 and var_211_2 or var_211_2 * (utf8.len(var_211_3) / 23)) > 0 and var_211_2 < var_211_5 then
					arg_208_1.talkMaxDuration = var_211_5

					if var_211_5 + var_211_1 > arg_208_1.duration_ then
						arg_208_1.duration_ = var_211_5 + var_211_1
					end
				end

				arg_208_1.text_.text = var_211_3
				arg_208_1.typewritter.percent = 0

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(false)
				arg_208_1:RecordContent(arg_208_1.text_.text)
			end

			local var_211_6 = math.max(var_211_2, arg_208_1.talkMaxDuration)

			if var_211_1 <= arg_208_1.time_ and arg_208_1.time_ < var_211_1 + var_211_6 then
				arg_208_1.typewritter.percent = (arg_208_1.time_ - var_211_1) / var_211_6

				arg_208_1.typewritter:SetDirty()
			end

			if arg_208_1.time_ >= var_211_1 + var_211_6 and arg_208_1.time_ < var_211_1 + var_211_6 + arg_211_0 then
				arg_208_1.typewritter.percent = 1

				arg_208_1.typewritter:SetDirty()
				arg_208_1:ShowNextGo(true)
			end
		end

		arg_208_1.nodeConfigList_ = {}

		arg_208_1:InitPlayNodeList()
	end,
	Play324072050 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 324072050
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play324072051(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos1054ui_story = arg_212_1.actors_["1054ui_story"].transform.localPosition

				local var_215_0 = GameObjectTools.GetOrAddComponent(arg_212_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_215_0 then
					var_215_0:EnableDynamicBone(false)
				end
			end

			local var_215_1 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_1 then
				arg_212_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_1)
				arg_212_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1054ui_story"].transform.position).z)
				arg_212_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1054ui_story"].transform.localEulerAngles = arg_212_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_1 and arg_212_1.time_ < 0 + var_215_1 + arg_215_0 then
				arg_212_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_212_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_212_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_212_1.actors_["1054ui_story"].transform.position).z)
				arg_212_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_212_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_212_1.actors_["1054ui_story"].transform.localEulerAngles = arg_212_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_215_2 = GameObjectTools.GetOrAddComponent(arg_212_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_215_2 then
					var_215_2:EnableDynamicBone(true)
				end
			end

			local var_215_3 = arg_212_1.actors_["6148ui_story"].transform

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.var_.moveOldPos6148ui_story = var_215_3.localPosition

				local var_215_4 = GameObjectTools.GetOrAddComponent(var_215_3.gameObject, typeof(DynamicBoneHelper))

				if var_215_4 then
					var_215_4:EnableDynamicBone(false)
				end
			end

			local var_215_5 = 0.001

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_5 then
				var_215_3.localPosition = Vector3.Lerp(arg_212_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_212_1.time_ - 0) / var_215_5)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles
			end

			if arg_212_1.time_ >= 0 + var_215_5 and arg_212_1.time_ < 0 + var_215_5 + arg_215_0 then
				var_215_3.localPosition = Vector3.New(0, 100, 0)
				var_215_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_215_3.position).x, (manager.ui.mainCamera.transform.position - var_215_3.position).y, (manager.ui.mainCamera.transform.position - var_215_3.position).z)
				var_215_3.localEulerAngles.z = 0
				var_215_3.localEulerAngles.x = 0
				var_215_3.localEulerAngles = var_215_3.localEulerAngles

				local var_215_6 = GameObjectTools.GetOrAddComponent(var_215_3.gameObject, typeof(DynamicBoneHelper))

				if var_215_6 then
					var_215_6:EnableDynamicBone(true)
				end
			end

			local var_215_7 = 0
			local var_215_8 = 1.225

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= var_215_7 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_9 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(324072050).content)

				arg_212_1.text_.text = var_215_9

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_11 = 49 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_9) / 49)

				if (49 <= 0 and var_215_8 or var_215_8 * (utf8.len(var_215_9) / 49)) > 0 and var_215_8 < var_215_11 then
					arg_212_1.talkMaxDuration = var_215_11

					if var_215_11 + var_215_7 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_11 + var_215_7
					end
				end

				arg_212_1.text_.text = var_215_9
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_12 = math.max(var_215_8, arg_212_1.talkMaxDuration)

			if var_215_7 <= arg_212_1.time_ and arg_212_1.time_ < var_215_7 + var_215_12 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - var_215_7) / var_215_12

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= var_215_7 + var_215_12 and arg_212_1.time_ < var_215_7 + var_215_12 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_212_1:InitPlayNodeList()
	end,
	Play324072051 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 324072051
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play324072052(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 0.975

			if 0 < arg_216_1.time_ and arg_216_1.time_ <= 0 + arg_219_0 then
				arg_216_1.talkMaxDuration = 0
				arg_216_1.dialogCg_.alpha = 1

				arg_216_1.dialog_:SetActive(true)
				SetActive(arg_216_1.leftNameGo_, false)

				arg_216_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_216_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_216_1:RecordName(arg_216_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_216_1.iconTrs_.gameObject, false)
				arg_216_1.callingController_:SetSelectedState("normal")

				local var_219_1 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(324072051).content)

				arg_216_1.text_.text = var_219_1

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_3 = 39 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 39)

				if (39 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 39)) > 0 and var_219_0 < var_219_3 then
					arg_216_1.talkMaxDuration = var_219_3

					if var_219_3 + 0 > arg_216_1.duration_ then
						arg_216_1.duration_ = var_219_3 + 0
					end
				end

				arg_216_1.text_.text = var_219_1
				arg_216_1.typewritter.percent = 0

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(false)
				arg_216_1:RecordContent(arg_216_1.text_.text)
			end

			local var_219_4 = math.max(var_219_0, arg_216_1.talkMaxDuration)

			if 0 <= arg_216_1.time_ and arg_216_1.time_ < 0 + var_219_4 then
				arg_216_1.typewritter.percent = (arg_216_1.time_ - 0) / var_219_4

				arg_216_1.typewritter:SetDirty()
			end

			if arg_216_1.time_ >= 0 + var_219_4 and arg_216_1.time_ < 0 + var_219_4 + arg_219_0 then
				arg_216_1.typewritter.percent = 1

				arg_216_1.typewritter:SetDirty()
				arg_216_1:ShowNextGo(true)
			end
		end

		arg_216_1.nodeConfigList_ = {}

		arg_216_1:InitPlayNodeList()
	end,
	Play324072052 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 324072052
		arg_220_1.duration_ = 4.8

		local var_220_0 = {
			zh = 4.533,
			ja = 4.8
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
				arg_220_0:Play324072053(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos6148ui_story = arg_220_1.actors_["6148ui_story"].transform.localPosition

				local var_223_0 = GameObjectTools.GetOrAddComponent(arg_220_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_223_0 then
					var_223_0:EnableDynamicBone(false)
				end
			end

			local var_223_1 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_1 then
				arg_220_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_220_1.time_ - 0) / var_223_1)
				arg_220_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).z)
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles = arg_220_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_1 and arg_220_1.time_ < 0 + var_223_1 + arg_223_0 then
				arg_220_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_220_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["6148ui_story"].transform.position).z)
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["6148ui_story"].transform.localEulerAngles = arg_220_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_223_2 = GameObjectTools.GetOrAddComponent(arg_220_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_223_2 then
					var_223_2:EnableDynamicBone(true)
				end
			end

			local var_223_3 = arg_220_1.actors_["6148ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect6148ui_story == nil then
				arg_220_1.var_.characterEffect6148ui_story = var_223_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_4 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_4 and not isNil(var_223_3) then
				if arg_220_1.var_.characterEffect6148ui_story and not isNil(var_223_3) then
					arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_4 and arg_220_1.time_ < 0 + var_223_4 + arg_223_0 and not isNil(var_223_3) and arg_220_1.var_.characterEffect6148ui_story then
				arg_220_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action2_2")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_223_6 = 0
			local var_223_7 = 0.425

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_6 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_8 = arg_220_1:GetWordFromCfg(324072052)
				local var_223_9 = arg_220_1:FormatText(var_223_8.content)

				arg_220_1.text_.text = var_223_9

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_11 = 17 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 17)

				if (17 <= 0 and var_223_7 or var_223_7 * (utf8.len(var_223_9) / 17)) > 0 and var_223_7 < var_223_11 then
					arg_220_1.talkMaxDuration = var_223_11

					if var_223_11 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_11 + var_223_6
					end
				end

				arg_220_1.text_.text = var_223_9
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072052", "story_v_out_324072.awb") ~= 0 then
					local var_223_12 = manager.audio:GetVoiceLength("story_v_out_324072", "324072052", "story_v_out_324072.awb") / 1000

					if var_223_12 + var_223_6 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_12 + var_223_6
					end

					if var_223_8.prefab_name ~= "" and arg_220_1.actors_[var_223_8.prefab_name] ~= nil then
						local var_223_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_8.prefab_name].transform, "story_v_out_324072", "324072052", "story_v_out_324072.awb")

						arg_220_1:RecordAudio("324072052", var_223_13)
						arg_220_1:RecordAudio("324072052", var_223_13)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_324072", "324072052", "story_v_out_324072.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_324072", "324072052", "story_v_out_324072.awb")
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

		arg_220_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_220_1:InitPlayNodeList()
	end,
	Play324072053 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 324072053
		arg_224_1.duration_ = 5

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play324072054(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(arg_224_1.actors_["6148ui_story"]) and arg_224_1.var_.characterEffect6148ui_story == nil then
				arg_224_1.var_.characterEffect6148ui_story = arg_224_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_0 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_0 and not isNil(arg_224_1.actors_["6148ui_story"]) then
				if arg_224_1.var_.characterEffect6148ui_story and not isNil(arg_224_1.actors_["6148ui_story"]) then
					arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_224_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_0)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_0 and arg_224_1.time_ < 0 + var_227_0 + arg_227_0 and not isNil(arg_224_1.actors_["6148ui_story"]) and arg_224_1.var_.characterEffect6148ui_story then
				arg_224_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_224_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_227_1 = 0
			local var_227_2 = 1.275

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_1 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, true)
				arg_224_1.iconController_:SetSelectedState("hero")

				arg_224_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_224_1.callingController_:SetSelectedState("normal")

				arg_224_1.keyicon_.color = Color.New(1, 1, 1)
				arg_224_1.icon_.color = Color.New(1, 1, 1)

				local var_227_3 = arg_224_1:FormatText(arg_224_1:GetWordFromCfg(324072053).content)

				arg_224_1.text_.text = var_227_3

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_5 = 51 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 51)

				if (51 <= 0 and var_227_2 or var_227_2 * (utf8.len(var_227_3) / 51)) > 0 and var_227_2 < var_227_5 then
					arg_224_1.talkMaxDuration = var_227_5

					if var_227_5 + var_227_1 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_5 + var_227_1
					end
				end

				arg_224_1.text_.text = var_227_3
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)
				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_6 = math.max(var_227_2, arg_224_1.talkMaxDuration)

			if var_227_1 <= arg_224_1.time_ and arg_224_1.time_ < var_227_1 + var_227_6 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_1) / var_227_6

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_1 + var_227_6 and arg_224_1.time_ < var_227_1 + var_227_6 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {}

		arg_224_1:InitPlayNodeList()
	end,
	Play324072054 = function(arg_228_0, arg_228_1)
		arg_228_1.time_ = 0
		arg_228_1.frameCnt_ = 0
		arg_228_1.state_ = "playing"
		arg_228_1.curTalkId_ = 324072054
		arg_228_1.duration_ = 5

		SetActive(arg_228_1.tipsGo_, false)

		function arg_228_1.onSingleLineFinish_()
			arg_228_1.onSingleLineUpdate_ = nil
			arg_228_1.onSingleLineFinish_ = nil
			arg_228_1.state_ = "waiting"
		end

		function arg_228_1.playNext_(arg_230_0)
			if arg_230_0 == 1 then
				arg_228_0:Play324072055(arg_228_1)
			end
		end

		function arg_228_1.onSingleLineUpdate_(arg_231_0)
			local var_231_0 = 1

			if 0 < arg_228_1.time_ and arg_228_1.time_ <= 0 + arg_231_0 then
				arg_228_1.talkMaxDuration = 0
				arg_228_1.dialogCg_.alpha = 1

				arg_228_1.dialog_:SetActive(true)
				SetActive(arg_228_1.leftNameGo_, true)

				arg_228_1.leftNameTxt_.text = arg_228_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_228_1.leftNameTxt_.transform)

				arg_228_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_228_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_228_1:RecordName(arg_228_1.leftNameTxt_.text)
				SetActive(arg_228_1.iconTrs_.gameObject, true)
				arg_228_1.iconController_:SetSelectedState("hero")

				arg_228_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_228_1.callingController_:SetSelectedState("normal")

				arg_228_1.keyicon_.color = Color.New(1, 1, 1)
				arg_228_1.icon_.color = Color.New(1, 1, 1)

				local var_231_1 = arg_228_1:FormatText(arg_228_1:GetWordFromCfg(324072054).content)

				arg_228_1.text_.text = var_231_1

				LuaForUtil.ClearLinePrefixSymbol(arg_228_1.text_)

				local var_231_3 = 40 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 40)

				if (40 <= 0 and var_231_0 or var_231_0 * (utf8.len(var_231_1) / 40)) > 0 and var_231_0 < var_231_3 then
					arg_228_1.talkMaxDuration = var_231_3

					if var_231_3 + 0 > arg_228_1.duration_ then
						arg_228_1.duration_ = var_231_3 + 0
					end
				end

				arg_228_1.text_.text = var_231_1
				arg_228_1.typewritter.percent = 0

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(false)
				arg_228_1:RecordContent(arg_228_1.text_.text)
			end

			local var_231_4 = math.max(var_231_0, arg_228_1.talkMaxDuration)

			if 0 <= arg_228_1.time_ and arg_228_1.time_ < 0 + var_231_4 then
				arg_228_1.typewritter.percent = (arg_228_1.time_ - 0) / var_231_4

				arg_228_1.typewritter:SetDirty()
			end

			if arg_228_1.time_ >= 0 + var_231_4 and arg_228_1.time_ < 0 + var_231_4 + arg_231_0 then
				arg_228_1.typewritter.percent = 1

				arg_228_1.typewritter:SetDirty()
				arg_228_1:ShowNextGo(true)
			end
		end

		arg_228_1.nodeConfigList_ = {}

		arg_228_1:InitPlayNodeList()
	end,
	Play324072055 = function(arg_232_0, arg_232_1)
		arg_232_1.time_ = 0
		arg_232_1.frameCnt_ = 0
		arg_232_1.state_ = "playing"
		arg_232_1.curTalkId_ = 324072055
		arg_232_1.duration_ = 5

		SetActive(arg_232_1.tipsGo_, false)

		function arg_232_1.onSingleLineFinish_()
			arg_232_1.onSingleLineUpdate_ = nil
			arg_232_1.onSingleLineFinish_ = nil
			arg_232_1.state_ = "waiting"
		end

		function arg_232_1.playNext_(arg_234_0)
			if arg_234_0 == 1 then
				arg_232_0:Play324072056(arg_232_1)
			end
		end

		function arg_232_1.onSingleLineUpdate_(arg_235_0)
			local var_235_0 = 1.3

			if 0 < arg_232_1.time_ and arg_232_1.time_ <= 0 + arg_235_0 then
				arg_232_1.talkMaxDuration = 0
				arg_232_1.dialogCg_.alpha = 1

				arg_232_1.dialog_:SetActive(true)
				SetActive(arg_232_1.leftNameGo_, false)

				arg_232_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_232_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_232_1:RecordName(arg_232_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_232_1.iconTrs_.gameObject, false)
				arg_232_1.callingController_:SetSelectedState("normal")

				local var_235_1 = arg_232_1:FormatText(arg_232_1:GetWordFromCfg(324072055).content)

				arg_232_1.text_.text = var_235_1

				LuaForUtil.ClearLinePrefixSymbol(arg_232_1.text_)

				local var_235_3 = 52 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 52)

				if (52 <= 0 and var_235_0 or var_235_0 * (utf8.len(var_235_1) / 52)) > 0 and var_235_0 < var_235_3 then
					arg_232_1.talkMaxDuration = var_235_3

					if var_235_3 + 0 > arg_232_1.duration_ then
						arg_232_1.duration_ = var_235_3 + 0
					end
				end

				arg_232_1.text_.text = var_235_1
				arg_232_1.typewritter.percent = 0

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(false)
				arg_232_1:RecordContent(arg_232_1.text_.text)
			end

			local var_235_4 = math.max(var_235_0, arg_232_1.talkMaxDuration)

			if 0 <= arg_232_1.time_ and arg_232_1.time_ < 0 + var_235_4 then
				arg_232_1.typewritter.percent = (arg_232_1.time_ - 0) / var_235_4

				arg_232_1.typewritter:SetDirty()
			end

			if arg_232_1.time_ >= 0 + var_235_4 and arg_232_1.time_ < 0 + var_235_4 + arg_235_0 then
				arg_232_1.typewritter.percent = 1

				arg_232_1.typewritter:SetDirty()
				arg_232_1:ShowNextGo(true)
			end
		end

		arg_232_1.nodeConfigList_ = {}

		arg_232_1:InitPlayNodeList()
	end,
	Play324072056 = function(arg_236_0, arg_236_1)
		arg_236_1.time_ = 0
		arg_236_1.frameCnt_ = 0
		arg_236_1.state_ = "playing"
		arg_236_1.curTalkId_ = 324072056
		arg_236_1.duration_ = 5

		SetActive(arg_236_1.tipsGo_, false)

		function arg_236_1.onSingleLineFinish_()
			arg_236_1.onSingleLineUpdate_ = nil
			arg_236_1.onSingleLineFinish_ = nil
			arg_236_1.state_ = "waiting"
		end

		function arg_236_1.playNext_(arg_238_0)
			if arg_238_0 == 1 then
				arg_236_0:Play324072057(arg_236_1)
			end
		end

		function arg_236_1.onSingleLineUpdate_(arg_239_0)
			local var_239_0 = 0.2

			if 0 < arg_236_1.time_ and arg_236_1.time_ <= 0 + arg_239_0 then
				arg_236_1.talkMaxDuration = 0
				arg_236_1.dialogCg_.alpha = 1

				arg_236_1.dialog_:SetActive(true)
				SetActive(arg_236_1.leftNameGo_, true)

				arg_236_1.leftNameTxt_.text = arg_236_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_236_1.leftNameTxt_.transform)

				arg_236_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_236_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_236_1:RecordName(arg_236_1.leftNameTxt_.text)
				SetActive(arg_236_1.iconTrs_.gameObject, true)
				arg_236_1.iconController_:SetSelectedState("hero")

				arg_236_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_236_1.callingController_:SetSelectedState("normal")

				arg_236_1.keyicon_.color = Color.New(1, 1, 1)
				arg_236_1.icon_.color = Color.New(1, 1, 1)

				local var_239_1 = arg_236_1:FormatText(arg_236_1:GetWordFromCfg(324072056).content)

				arg_236_1.text_.text = var_239_1

				LuaForUtil.ClearLinePrefixSymbol(arg_236_1.text_)

				local var_239_3 = 8 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 8)

				if (8 <= 0 and var_239_0 or var_239_0 * (utf8.len(var_239_1) / 8)) > 0 and var_239_0 < var_239_3 then
					arg_236_1.talkMaxDuration = var_239_3

					if var_239_3 + 0 > arg_236_1.duration_ then
						arg_236_1.duration_ = var_239_3 + 0
					end
				end

				arg_236_1.text_.text = var_239_1
				arg_236_1.typewritter.percent = 0

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(false)
				arg_236_1:RecordContent(arg_236_1.text_.text)
			end

			local var_239_4 = math.max(var_239_0, arg_236_1.talkMaxDuration)

			if 0 <= arg_236_1.time_ and arg_236_1.time_ < 0 + var_239_4 then
				arg_236_1.typewritter.percent = (arg_236_1.time_ - 0) / var_239_4

				arg_236_1.typewritter:SetDirty()
			end

			if arg_236_1.time_ >= 0 + var_239_4 and arg_236_1.time_ < 0 + var_239_4 + arg_239_0 then
				arg_236_1.typewritter.percent = 1

				arg_236_1.typewritter:SetDirty()
				arg_236_1:ShowNextGo(true)
			end
		end

		arg_236_1.nodeConfigList_ = {}

		arg_236_1:InitPlayNodeList()
	end,
	Play324072057 = function(arg_240_0, arg_240_1)
		arg_240_1.time_ = 0
		arg_240_1.frameCnt_ = 0
		arg_240_1.state_ = "playing"
		arg_240_1.curTalkId_ = 324072057
		arg_240_1.duration_ = 2.7

		local var_240_0 = {
			zh = 1.999999999999,
			ja = 2.7
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
				arg_240_0:Play324072058(arg_240_1)
			end
		end

		function arg_240_1.onSingleLineUpdate_(arg_243_0)
			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 and not isNil(arg_240_1.actors_["6148ui_story"]) and arg_240_1.var_.characterEffect6148ui_story == nil then
				arg_240_1.var_.characterEffect6148ui_story = arg_240_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_243_0 = 0.200000002980232

			if 0 <= arg_240_1.time_ and arg_240_1.time_ < 0 + var_243_0 and not isNil(arg_240_1.actors_["6148ui_story"]) then
				if arg_240_1.var_.characterEffect6148ui_story and not isNil(arg_240_1.actors_["6148ui_story"]) then
					arg_240_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_240_1.time_ >= 0 + var_243_0 and arg_240_1.time_ < 0 + var_243_0 + arg_243_0 and not isNil(arg_240_1.actors_["6148ui_story"]) and arg_240_1.var_.characterEffect6148ui_story then
				arg_240_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_1")
			end

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= 0 + arg_243_0 then
				arg_240_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_243_2 = 0
			local var_243_3 = 0.15

			if 0 < arg_240_1.time_ and arg_240_1.time_ <= var_243_2 + arg_243_0 then
				arg_240_1.talkMaxDuration = 0
				arg_240_1.dialogCg_.alpha = 1

				arg_240_1.dialog_:SetActive(true)
				SetActive(arg_240_1.leftNameGo_, true)

				arg_240_1.leftNameTxt_.text = arg_240_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_240_1.leftNameTxt_.transform)

				arg_240_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_240_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_240_1:RecordName(arg_240_1.leftNameTxt_.text)
				SetActive(arg_240_1.iconTrs_.gameObject, false)
				arg_240_1.callingController_:SetSelectedState("normal")

				local var_243_4 = arg_240_1:GetWordFromCfg(324072057)
				local var_243_5 = arg_240_1:FormatText(var_243_4.content)

				arg_240_1.text_.text = var_243_5

				LuaForUtil.ClearLinePrefixSymbol(arg_240_1.text_)

				local var_243_7 = 6 <= 0 and var_243_3 or var_243_3 * (utf8.len(var_243_5) / 6)

				if (6 <= 0 and var_243_3 or var_243_3 * (utf8.len(var_243_5) / 6)) > 0 and var_243_3 < var_243_7 then
					arg_240_1.talkMaxDuration = var_243_7

					if var_243_7 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_7 + var_243_2
					end
				end

				arg_240_1.text_.text = var_243_5
				arg_240_1.typewritter.percent = 0

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072057", "story_v_out_324072.awb") ~= 0 then
					local var_243_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072057", "story_v_out_324072.awb") / 1000

					if var_243_8 + var_243_2 > arg_240_1.duration_ then
						arg_240_1.duration_ = var_243_8 + var_243_2
					end

					if var_243_4.prefab_name ~= "" and arg_240_1.actors_[var_243_4.prefab_name] ~= nil then
						local var_243_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_240_1.actors_[var_243_4.prefab_name].transform, "story_v_out_324072", "324072057", "story_v_out_324072.awb")

						arg_240_1:RecordAudio("324072057", var_243_9)
						arg_240_1:RecordAudio("324072057", var_243_9)
					else
						arg_240_1:AudioAction("play", "voice", "story_v_out_324072", "324072057", "story_v_out_324072.awb")
					end

					arg_240_1:RecordHistoryTalkVoice("story_v_out_324072", "324072057", "story_v_out_324072.awb")
				end

				arg_240_1:RecordContent(arg_240_1.text_.text)
			end

			local var_243_10 = math.max(var_243_3, arg_240_1.talkMaxDuration)

			if var_243_2 <= arg_240_1.time_ and arg_240_1.time_ < var_243_2 + var_243_10 then
				arg_240_1.typewritter.percent = (arg_240_1.time_ - var_243_2) / var_243_10

				arg_240_1.typewritter:SetDirty()
			end

			if arg_240_1.time_ >= var_243_2 + var_243_10 and arg_240_1.time_ < var_243_2 + var_243_10 + arg_243_0 then
				arg_240_1.typewritter.percent = 1

				arg_240_1.typewritter:SetDirty()
				arg_240_1:ShowNextGo(true)
			end
		end

		arg_240_1.nodeConfigList_ = {}

		arg_240_1:InitPlayNodeList()
	end,
	Play324072058 = function(arg_244_0, arg_244_1)
		arg_244_1.time_ = 0
		arg_244_1.frameCnt_ = 0
		arg_244_1.state_ = "playing"
		arg_244_1.curTalkId_ = 324072058
		arg_244_1.duration_ = 5

		SetActive(arg_244_1.tipsGo_, false)

		function arg_244_1.onSingleLineFinish_()
			arg_244_1.onSingleLineUpdate_ = nil
			arg_244_1.onSingleLineFinish_ = nil
			arg_244_1.state_ = "waiting"
		end

		function arg_244_1.playNext_(arg_246_0)
			if arg_246_0 == 1 then
				arg_244_0:Play324072059(arg_244_1)
			end
		end

		function arg_244_1.onSingleLineUpdate_(arg_247_0)
			if 0 < arg_244_1.time_ and arg_244_1.time_ <= 0 + arg_247_0 and not isNil(arg_244_1.actors_["6148ui_story"]) and arg_244_1.var_.characterEffect6148ui_story == nil then
				arg_244_1.var_.characterEffect6148ui_story = arg_244_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_247_0 = 0.200000002980232

			if 0 <= arg_244_1.time_ and arg_244_1.time_ < 0 + var_247_0 and not isNil(arg_244_1.actors_["6148ui_story"]) then
				if arg_244_1.var_.characterEffect6148ui_story and not isNil(arg_244_1.actors_["6148ui_story"]) then
					arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_244_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_244_1.time_ - 0) / var_247_0)
				end
			end

			if arg_244_1.time_ >= 0 + var_247_0 and arg_244_1.time_ < 0 + var_247_0 + arg_247_0 and not isNil(arg_244_1.actors_["6148ui_story"]) and arg_244_1.var_.characterEffect6148ui_story then
				arg_244_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_244_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_247_1 = 0
			local var_247_2 = 0.05

			if 0 < arg_244_1.time_ and arg_244_1.time_ <= var_247_1 + arg_247_0 then
				arg_244_1.talkMaxDuration = 0
				arg_244_1.dialogCg_.alpha = 1

				arg_244_1.dialog_:SetActive(true)
				SetActive(arg_244_1.leftNameGo_, true)

				arg_244_1.leftNameTxt_.text = arg_244_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_244_1.leftNameTxt_.transform)

				arg_244_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_244_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_244_1:RecordName(arg_244_1.leftNameTxt_.text)
				SetActive(arg_244_1.iconTrs_.gameObject, true)
				arg_244_1.iconController_:SetSelectedState("hero")

				arg_244_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_244_1.callingController_:SetSelectedState("normal")

				arg_244_1.keyicon_.color = Color.New(1, 1, 1)
				arg_244_1.icon_.color = Color.New(1, 1, 1)

				local var_247_3 = arg_244_1:FormatText(arg_244_1:GetWordFromCfg(324072058).content)

				arg_244_1.text_.text = var_247_3

				LuaForUtil.ClearLinePrefixSymbol(arg_244_1.text_)

				local var_247_5 = 2 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 2)

				if (2 <= 0 and var_247_2 or var_247_2 * (utf8.len(var_247_3) / 2)) > 0 and var_247_2 < var_247_5 then
					arg_244_1.talkMaxDuration = var_247_5

					if var_247_5 + var_247_1 > arg_244_1.duration_ then
						arg_244_1.duration_ = var_247_5 + var_247_1
					end
				end

				arg_244_1.text_.text = var_247_3
				arg_244_1.typewritter.percent = 0

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(false)
				arg_244_1:RecordContent(arg_244_1.text_.text)
			end

			local var_247_6 = math.max(var_247_2, arg_244_1.talkMaxDuration)

			if var_247_1 <= arg_244_1.time_ and arg_244_1.time_ < var_247_1 + var_247_6 then
				arg_244_1.typewritter.percent = (arg_244_1.time_ - var_247_1) / var_247_6

				arg_244_1.typewritter:SetDirty()
			end

			if arg_244_1.time_ >= var_247_1 + var_247_6 and arg_244_1.time_ < var_247_1 + var_247_6 + arg_247_0 then
				arg_244_1.typewritter.percent = 1

				arg_244_1.typewritter:SetDirty()
				arg_244_1:ShowNextGo(true)
			end
		end

		arg_244_1.nodeConfigList_ = {}

		arg_244_1:InitPlayNodeList()
	end,
	Play324072059 = function(arg_248_0, arg_248_1)
		arg_248_1.time_ = 0
		arg_248_1.frameCnt_ = 0
		arg_248_1.state_ = "playing"
		arg_248_1.curTalkId_ = 324072059
		arg_248_1.duration_ = 3.17

		local var_248_0 = {
			zh = 3.066,
			ja = 3.166
		}
		local var_248_1 = manager.audio:GetLocalizationFlag()

		if var_248_0[var_248_1] ~= nil then
			arg_248_1.duration_ = var_248_0[var_248_1]
		end

		SetActive(arg_248_1.tipsGo_, false)

		function arg_248_1.onSingleLineFinish_()
			arg_248_1.onSingleLineUpdate_ = nil
			arg_248_1.onSingleLineFinish_ = nil
			arg_248_1.state_ = "waiting"
		end

		function arg_248_1.playNext_(arg_250_0)
			if arg_250_0 == 1 then
				arg_248_0:Play324072060(arg_248_1)
			end
		end

		function arg_248_1.onSingleLineUpdate_(arg_251_0)
			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos6148ui_story = arg_248_1.actors_["6148ui_story"].transform.localPosition

				local var_251_0 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_0 then
					var_251_0:EnableDynamicBone(false)
				end
			end

			local var_251_1 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_1 then
				arg_248_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_248_1.time_ - 0) / var_251_1)
				arg_248_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["6148ui_story"].transform.position).z)
				arg_248_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["6148ui_story"].transform.localEulerAngles = arg_248_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_1 and arg_248_1.time_ < 0 + var_251_1 + arg_251_0 then
				arg_248_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_248_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_248_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_248_1.actors_["6148ui_story"].transform.position).z)
				arg_248_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_248_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_248_1.actors_["6148ui_story"].transform.localEulerAngles = arg_248_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_251_2 = GameObjectTools.GetOrAddComponent(arg_248_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_251_2 then
					var_251_2:EnableDynamicBone(true)
				end
			end

			local var_251_3 = arg_248_1.actors_["1054ui_story"].transform

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1.var_.moveOldPos1054ui_story = var_251_3.localPosition

				local var_251_4 = GameObjectTools.GetOrAddComponent(var_251_3.gameObject, typeof(DynamicBoneHelper))

				if var_251_4 then
					var_251_4:EnableDynamicBone(false)
				end
			end

			local var_251_5 = 0.001

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_5 then
				var_251_3.localPosition = Vector3.Lerp(arg_248_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_248_1.time_ - 0) / var_251_5)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles
			end

			if arg_248_1.time_ >= 0 + var_251_5 and arg_248_1.time_ < 0 + var_251_5 + arg_251_0 then
				var_251_3.localPosition = Vector3.New(0, -0.985, -6)
				var_251_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_251_3.position).x, (manager.ui.mainCamera.transform.position - var_251_3.position).y, (manager.ui.mainCamera.transform.position - var_251_3.position).z)
				var_251_3.localEulerAngles.z = 0
				var_251_3.localEulerAngles.x = 0
				var_251_3.localEulerAngles = var_251_3.localEulerAngles

				local var_251_6 = GameObjectTools.GetOrAddComponent(var_251_3.gameObject, typeof(DynamicBoneHelper))

				if var_251_6 then
					var_251_6:EnableDynamicBone(true)
				end
			end

			local var_251_7 = arg_248_1.actors_["1054ui_story"]

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.characterEffect1054ui_story == nil then
				arg_248_1.var_.characterEffect1054ui_story = var_251_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_251_8 = 0.200000002980232

			if 0 <= arg_248_1.time_ and arg_248_1.time_ < 0 + var_251_8 and not isNil(var_251_7) then
				if arg_248_1.var_.characterEffect1054ui_story and not isNil(var_251_7) then
					arg_248_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_248_1.time_ >= 0 + var_251_8 and arg_248_1.time_ < 0 + var_251_8 + arg_251_0 and not isNil(var_251_7) and arg_248_1.var_.characterEffect1054ui_story then
				arg_248_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action7_2")
			end

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= 0 + arg_251_0 then
				arg_248_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_251_10 = 0
			local var_251_11 = 0.25

			if 0 < arg_248_1.time_ and arg_248_1.time_ <= var_251_10 + arg_251_0 then
				arg_248_1.talkMaxDuration = 0
				arg_248_1.dialogCg_.alpha = 1

				arg_248_1.dialog_:SetActive(true)
				SetActive(arg_248_1.leftNameGo_, true)

				arg_248_1.leftNameTxt_.text = arg_248_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_248_1.leftNameTxt_.transform)

				arg_248_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_248_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_248_1:RecordName(arg_248_1.leftNameTxt_.text)
				SetActive(arg_248_1.iconTrs_.gameObject, false)
				arg_248_1.callingController_:SetSelectedState("normal")

				local var_251_12 = arg_248_1:GetWordFromCfg(324072059)
				local var_251_13 = arg_248_1:FormatText(var_251_12.content)

				arg_248_1.text_.text = var_251_13

				LuaForUtil.ClearLinePrefixSymbol(arg_248_1.text_)

				local var_251_15 = 10 <= 0 and var_251_11 or var_251_11 * (utf8.len(var_251_13) / 10)

				if (10 <= 0 and var_251_11 or var_251_11 * (utf8.len(var_251_13) / 10)) > 0 and var_251_11 < var_251_15 then
					arg_248_1.talkMaxDuration = var_251_15

					if var_251_15 + var_251_10 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_15 + var_251_10
					end
				end

				arg_248_1.text_.text = var_251_13
				arg_248_1.typewritter.percent = 0

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072059", "story_v_out_324072.awb") ~= 0 then
					local var_251_16 = manager.audio:GetVoiceLength("story_v_out_324072", "324072059", "story_v_out_324072.awb") / 1000

					if var_251_16 + var_251_10 > arg_248_1.duration_ then
						arg_248_1.duration_ = var_251_16 + var_251_10
					end

					if var_251_12.prefab_name ~= "" and arg_248_1.actors_[var_251_12.prefab_name] ~= nil then
						local var_251_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_248_1.actors_[var_251_12.prefab_name].transform, "story_v_out_324072", "324072059", "story_v_out_324072.awb")

						arg_248_1:RecordAudio("324072059", var_251_17)
						arg_248_1:RecordAudio("324072059", var_251_17)
					else
						arg_248_1:AudioAction("play", "voice", "story_v_out_324072", "324072059", "story_v_out_324072.awb")
					end

					arg_248_1:RecordHistoryTalkVoice("story_v_out_324072", "324072059", "story_v_out_324072.awb")
				end

				arg_248_1:RecordContent(arg_248_1.text_.text)
			end

			local var_251_18 = math.max(var_251_11, arg_248_1.talkMaxDuration)

			if var_251_10 <= arg_248_1.time_ and arg_248_1.time_ < var_251_10 + var_251_18 then
				arg_248_1.typewritter.percent = (arg_248_1.time_ - var_251_10) / var_251_18

				arg_248_1.typewritter:SetDirty()
			end

			if arg_248_1.time_ >= var_251_10 + var_251_18 and arg_248_1.time_ < var_251_10 + var_251_18 + arg_251_0 then
				arg_248_1.typewritter.percent = 1

				arg_248_1.typewritter:SetDirty()
				arg_248_1:ShowNextGo(true)
			end
		end

		arg_248_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_248_1:InitPlayNodeList()
	end,
	Play324072060 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 324072060
		arg_252_1.duration_ = 5

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play324072061(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				arg_252_1.var_.moveOldPos1054ui_story = arg_252_1.actors_["1054ui_story"].transform.localPosition

				local var_255_0 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_0 then
					var_255_0:EnableDynamicBone(false)
				end
			end

			local var_255_1 = 0.001

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_1 then
				arg_252_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_252_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_252_1.time_ - 0) / var_255_1)
				arg_252_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).z)
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles = arg_252_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_252_1.time_ >= 0 + var_255_1 and arg_252_1.time_ < 0 + var_255_1 + arg_255_0 then
				arg_252_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_252_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_252_1.actors_["1054ui_story"].transform.position).z)
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_252_1.actors_["1054ui_story"].transform.localEulerAngles = arg_252_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_255_2 = GameObjectTools.GetOrAddComponent(arg_252_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_255_2 then
					var_255_2:EnableDynamicBone(true)
				end
			end

			local var_255_3 = arg_252_1.actors_["1054ui_story"]

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect1054ui_story == nil then
				arg_252_1.var_.characterEffect1054ui_story = var_255_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_255_4 = 0.200000002980232

			if 0 <= arg_252_1.time_ and arg_252_1.time_ < 0 + var_255_4 and not isNil(var_255_3) then
				if arg_252_1.var_.characterEffect1054ui_story and not isNil(var_255_3) then
					arg_252_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_252_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_252_1.time_ - 0) / var_255_4)
				end
			end

			if arg_252_1.time_ >= 0 + var_255_4 and arg_252_1.time_ < 0 + var_255_4 + arg_255_0 and not isNil(var_255_3) and arg_252_1.var_.characterEffect1054ui_story then
				arg_252_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_252_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0.1 < arg_252_1.time_ and arg_252_1.time_ <= 0.1 + arg_255_0 then
				arg_252_1:AudioAction("play", "effect", "se_story_150", "se_story_150_tea_cup", "")
			end

			local var_255_6 = 0
			local var_255_7 = 1.65

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_6 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0
				arg_252_1.dialogCg_.alpha = 1

				arg_252_1.dialog_:SetActive(true)
				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(324072060).content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 66 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_8) / 66)

				if (66 <= 0 and var_255_7 or var_255_7 * (utf8.len(var_255_8) / 66)) > 0 and var_255_7 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10

					if var_255_10 + var_255_6 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_6
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_11 = math.max(var_255_7, arg_252_1.talkMaxDuration)

			if var_255_6 <= arg_252_1.time_ and arg_252_1.time_ < var_255_6 + var_255_11 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_6) / var_255_11

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_6 + var_255_11 and arg_252_1.time_ < var_255_6 + var_255_11 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_252_1:InitPlayNodeList()
	end,
	Play324072061 = function(arg_256_0, arg_256_1)
		arg_256_1.time_ = 0
		arg_256_1.frameCnt_ = 0
		arg_256_1.state_ = "playing"
		arg_256_1.curTalkId_ = 324072061
		arg_256_1.duration_ = 6.5

		local var_256_0 = {
			zh = 5.4,
			ja = 6.5
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
				arg_256_0:Play324072062(arg_256_1)
			end
		end

		function arg_256_1.onSingleLineUpdate_(arg_259_0)
			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1.var_.moveOldPos1070ui_story = arg_256_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_259_0 = 0.001

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_0 then
				arg_256_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_256_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_256_1.time_ - 0) / var_259_0)
				arg_256_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1070ui_story"].transform.position).z)
				arg_256_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1070ui_story"].transform.localEulerAngles = arg_256_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_256_1.time_ >= 0 + var_259_0 and arg_256_1.time_ < 0 + var_259_0 + arg_259_0 then
				arg_256_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_256_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_256_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_256_1.actors_["1070ui_story"].transform.position).z)
				arg_256_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_256_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_256_1.actors_["1070ui_story"].transform.localEulerAngles = arg_256_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_259_1 = arg_256_1.actors_["1070ui_story"]

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1070ui_story == nil then
				arg_256_1.var_.characterEffect1070ui_story = var_259_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_259_2 = 0.200000002980232

			if 0 <= arg_256_1.time_ and arg_256_1.time_ < 0 + var_259_2 and not isNil(var_259_1) then
				if arg_256_1.var_.characterEffect1070ui_story and not isNil(var_259_1) then
					arg_256_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_256_1.time_ >= 0 + var_259_2 and arg_256_1.time_ < 0 + var_259_2 + arg_259_0 and not isNil(var_259_1) and arg_256_1.var_.characterEffect1070ui_story then
				arg_256_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_1")
			end

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= 0 + arg_259_0 then
				arg_256_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_259_4 = 0
			local var_259_5 = 0.575

			if 0 < arg_256_1.time_ and arg_256_1.time_ <= var_259_4 + arg_259_0 then
				arg_256_1.talkMaxDuration = 0
				arg_256_1.dialogCg_.alpha = 1

				arg_256_1.dialog_:SetActive(true)
				SetActive(arg_256_1.leftNameGo_, true)

				arg_256_1.leftNameTxt_.text = arg_256_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_256_1.leftNameTxt_.transform)

				arg_256_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_256_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_256_1:RecordName(arg_256_1.leftNameTxt_.text)
				SetActive(arg_256_1.iconTrs_.gameObject, false)
				arg_256_1.callingController_:SetSelectedState("normal")

				local var_259_6 = arg_256_1:GetWordFromCfg(324072061)
				local var_259_7 = arg_256_1:FormatText(var_259_6.content)

				arg_256_1.text_.text = var_259_7

				LuaForUtil.ClearLinePrefixSymbol(arg_256_1.text_)

				local var_259_9 = 23 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 23)

				if (23 <= 0 and var_259_5 or var_259_5 * (utf8.len(var_259_7) / 23)) > 0 and var_259_5 < var_259_9 then
					arg_256_1.talkMaxDuration = var_259_9

					if var_259_9 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_9 + var_259_4
					end
				end

				arg_256_1.text_.text = var_259_7
				arg_256_1.typewritter.percent = 0

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072061", "story_v_out_324072.awb") ~= 0 then
					local var_259_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072061", "story_v_out_324072.awb") / 1000

					if var_259_10 + var_259_4 > arg_256_1.duration_ then
						arg_256_1.duration_ = var_259_10 + var_259_4
					end

					if var_259_6.prefab_name ~= "" and arg_256_1.actors_[var_259_6.prefab_name] ~= nil then
						local var_259_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_256_1.actors_[var_259_6.prefab_name].transform, "story_v_out_324072", "324072061", "story_v_out_324072.awb")

						arg_256_1:RecordAudio("324072061", var_259_11)
						arg_256_1:RecordAudio("324072061", var_259_11)
					else
						arg_256_1:AudioAction("play", "voice", "story_v_out_324072", "324072061", "story_v_out_324072.awb")
					end

					arg_256_1:RecordHistoryTalkVoice("story_v_out_324072", "324072061", "story_v_out_324072.awb")
				end

				arg_256_1:RecordContent(arg_256_1.text_.text)
			end

			local var_259_12 = math.max(var_259_5, arg_256_1.talkMaxDuration)

			if var_259_4 <= arg_256_1.time_ and arg_256_1.time_ < var_259_4 + var_259_12 then
				arg_256_1.typewritter.percent = (arg_256_1.time_ - var_259_4) / var_259_12

				arg_256_1.typewritter:SetDirty()
			end

			if arg_256_1.time_ >= var_259_4 + var_259_12 and arg_256_1.time_ < var_259_4 + var_259_12 + arg_259_0 then
				arg_256_1.typewritter.percent = 1

				arg_256_1.typewritter:SetDirty()
				arg_256_1:ShowNextGo(true)
			end
		end

		arg_256_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_256_1:InitPlayNodeList()
	end,
	Play324072062 = function(arg_260_0, arg_260_1)
		arg_260_1.time_ = 0
		arg_260_1.frameCnt_ = 0
		arg_260_1.state_ = "playing"
		arg_260_1.curTalkId_ = 324072062
		arg_260_1.duration_ = 2.5

		local var_260_0 = {
			zh = 2.5,
			ja = 2
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
				arg_260_0:Play324072063(arg_260_1)
			end
		end

		function arg_260_1.onSingleLineUpdate_(arg_263_0)
			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos6148ui_story = arg_260_1.actors_["6148ui_story"].transform.localPosition

				local var_263_0 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_0 then
					var_263_0:EnableDynamicBone(false)
				end
			end

			local var_263_1 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_1 then
				arg_260_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_260_1.time_ - 0) / var_263_1)
				arg_260_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["6148ui_story"].transform.position).z)
				arg_260_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["6148ui_story"].transform.localEulerAngles = arg_260_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_1 and arg_260_1.time_ < 0 + var_263_1 + arg_263_0 then
				arg_260_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_260_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_260_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_260_1.actors_["6148ui_story"].transform.position).z)
				arg_260_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_260_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_260_1.actors_["6148ui_story"].transform.localEulerAngles = arg_260_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_263_2 = GameObjectTools.GetOrAddComponent(arg_260_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_263_2 then
					var_263_2:EnableDynamicBone(true)
				end
			end

			local var_263_3 = arg_260_1.actors_["1070ui_story"].transform

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1.var_.moveOldPos1070ui_story = var_263_3.localPosition
			end

			local var_263_4 = 0.001

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_4 then
				var_263_3.localPosition = Vector3.Lerp(arg_260_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_260_1.time_ - 0) / var_263_4)
				var_263_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_3.position).x, (manager.ui.mainCamera.transform.position - var_263_3.position).y, (manager.ui.mainCamera.transform.position - var_263_3.position).z)
				var_263_3.localEulerAngles.z = 0
				var_263_3.localEulerAngles.x = 0
				var_263_3.localEulerAngles = var_263_3.localEulerAngles
			end

			if arg_260_1.time_ >= 0 + var_263_4 and arg_260_1.time_ < 0 + var_263_4 + arg_263_0 then
				var_263_3.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_263_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_263_3.position).x, (manager.ui.mainCamera.transform.position - var_263_3.position).y, (manager.ui.mainCamera.transform.position - var_263_3.position).z)
				var_263_3.localEulerAngles.z = 0
				var_263_3.localEulerAngles.x = 0
				var_263_3.localEulerAngles = var_263_3.localEulerAngles
			end

			local var_263_5 = arg_260_1.actors_["6148ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_5) and arg_260_1.var_.characterEffect6148ui_story == nil then
				arg_260_1.var_.characterEffect6148ui_story = var_263_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_6 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_6 and not isNil(var_263_5) then
				if arg_260_1.var_.characterEffect6148ui_story and not isNil(var_263_5) then
					arg_260_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_260_1.time_ >= 0 + var_263_6 and arg_260_1.time_ < 0 + var_263_6 + arg_263_0 and not isNil(var_263_5) and arg_260_1.var_.characterEffect6148ui_story then
				arg_260_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_263_8 = arg_260_1.actors_["1070ui_story"]

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 and not isNil(var_263_8) and arg_260_1.var_.characterEffect1070ui_story == nil then
				arg_260_1.var_.characterEffect1070ui_story = var_263_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_263_9 = 0.200000002980232

			if 0 <= arg_260_1.time_ and arg_260_1.time_ < 0 + var_263_9 and not isNil(var_263_8) then
				if arg_260_1.var_.characterEffect1070ui_story and not isNil(var_263_8) then
					arg_260_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_260_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_260_1.time_ - 0) / var_263_9)
				end
			end

			if arg_260_1.time_ >= 0 + var_263_9 and arg_260_1.time_ < 0 + var_263_9 + arg_263_0 and not isNil(var_263_8) and arg_260_1.var_.characterEffect1070ui_story then
				arg_260_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_260_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action8_2")
			end

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= 0 + arg_263_0 then
				arg_260_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_263_10 = 0
			local var_263_11 = 0.2

			if 0 < arg_260_1.time_ and arg_260_1.time_ <= var_263_10 + arg_263_0 then
				arg_260_1.talkMaxDuration = 0
				arg_260_1.dialogCg_.alpha = 1

				arg_260_1.dialog_:SetActive(true)
				SetActive(arg_260_1.leftNameGo_, true)

				arg_260_1.leftNameTxt_.text = arg_260_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_260_1.leftNameTxt_.transform)

				arg_260_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_260_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_260_1:RecordName(arg_260_1.leftNameTxt_.text)
				SetActive(arg_260_1.iconTrs_.gameObject, false)
				arg_260_1.callingController_:SetSelectedState("normal")

				local var_263_12 = arg_260_1:GetWordFromCfg(324072062)
				local var_263_13 = arg_260_1:FormatText(var_263_12.content)

				arg_260_1.text_.text = var_263_13

				LuaForUtil.ClearLinePrefixSymbol(arg_260_1.text_)

				local var_263_15 = 8 <= 0 and var_263_11 or var_263_11 * (utf8.len(var_263_13) / 8)

				if (8 <= 0 and var_263_11 or var_263_11 * (utf8.len(var_263_13) / 8)) > 0 and var_263_11 < var_263_15 then
					arg_260_1.talkMaxDuration = var_263_15

					if var_263_15 + var_263_10 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_15 + var_263_10
					end
				end

				arg_260_1.text_.text = var_263_13
				arg_260_1.typewritter.percent = 0

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072062", "story_v_out_324072.awb") ~= 0 then
					local var_263_16 = manager.audio:GetVoiceLength("story_v_out_324072", "324072062", "story_v_out_324072.awb") / 1000

					if var_263_16 + var_263_10 > arg_260_1.duration_ then
						arg_260_1.duration_ = var_263_16 + var_263_10
					end

					if var_263_12.prefab_name ~= "" and arg_260_1.actors_[var_263_12.prefab_name] ~= nil then
						local var_263_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_260_1.actors_[var_263_12.prefab_name].transform, "story_v_out_324072", "324072062", "story_v_out_324072.awb")

						arg_260_1:RecordAudio("324072062", var_263_17)
						arg_260_1:RecordAudio("324072062", var_263_17)
					else
						arg_260_1:AudioAction("play", "voice", "story_v_out_324072", "324072062", "story_v_out_324072.awb")
					end

					arg_260_1:RecordHistoryTalkVoice("story_v_out_324072", "324072062", "story_v_out_324072.awb")
				end

				arg_260_1:RecordContent(arg_260_1.text_.text)
			end

			local var_263_18 = math.max(var_263_11, arg_260_1.talkMaxDuration)

			if var_263_10 <= arg_260_1.time_ and arg_260_1.time_ < var_263_10 + var_263_18 then
				arg_260_1.typewritter.percent = (arg_260_1.time_ - var_263_10) / var_263_18

				arg_260_1.typewritter:SetDirty()
			end

			if arg_260_1.time_ >= var_263_10 + var_263_18 and arg_260_1.time_ < var_263_10 + var_263_18 + arg_263_0 then
				arg_260_1.typewritter.percent = 1

				arg_260_1.typewritter:SetDirty()
				arg_260_1:ShowNextGo(true)
			end
		end

		arg_260_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_260_1:InitPlayNodeList()
	end,
	Play324072063 = function(arg_264_0, arg_264_1)
		arg_264_1.time_ = 0
		arg_264_1.frameCnt_ = 0
		arg_264_1.state_ = "playing"
		arg_264_1.curTalkId_ = 324072063
		arg_264_1.duration_ = 8.63

		local var_264_0 = {
			zh = 7.6,
			ja = 8.633
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
				arg_264_0:Play324072064(arg_264_1)
			end
		end

		function arg_264_1.onSingleLineUpdate_(arg_267_0)
			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(arg_264_1.actors_["1070ui_story"]) and arg_264_1.var_.characterEffect1070ui_story == nil then
				arg_264_1.var_.characterEffect1070ui_story = arg_264_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_0 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_0 and not isNil(arg_264_1.actors_["1070ui_story"]) then
				if arg_264_1.var_.characterEffect1070ui_story and not isNil(arg_264_1.actors_["1070ui_story"]) then
					arg_264_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_264_1.time_ >= 0 + var_267_0 and arg_264_1.time_ < 0 + var_267_0 + arg_267_0 and not isNil(arg_264_1.actors_["1070ui_story"]) and arg_264_1.var_.characterEffect1070ui_story then
				arg_264_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_267_2 = arg_264_1.actors_["6148ui_story"]

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= 0 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.characterEffect6148ui_story == nil then
				arg_264_1.var_.characterEffect6148ui_story = var_267_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_267_3 = 0.200000002980232

			if 0 <= arg_264_1.time_ and arg_264_1.time_ < 0 + var_267_3 and not isNil(var_267_2) then
				if arg_264_1.var_.characterEffect6148ui_story and not isNil(var_267_2) then
					arg_264_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_264_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_264_1.time_ - 0) / var_267_3)
				end
			end

			if arg_264_1.time_ >= 0 + var_267_3 and arg_264_1.time_ < 0 + var_267_3 + arg_267_0 and not isNil(var_267_2) and arg_264_1.var_.characterEffect6148ui_story then
				arg_264_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_264_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_267_4 = 0
			local var_267_5 = 0.95

			if 0 < arg_264_1.time_ and arg_264_1.time_ <= var_267_4 + arg_267_0 then
				arg_264_1.talkMaxDuration = 0
				arg_264_1.dialogCg_.alpha = 1

				arg_264_1.dialog_:SetActive(true)
				SetActive(arg_264_1.leftNameGo_, true)

				arg_264_1.leftNameTxt_.text = arg_264_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_264_1.leftNameTxt_.transform)

				arg_264_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_264_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_264_1:RecordName(arg_264_1.leftNameTxt_.text)
				SetActive(arg_264_1.iconTrs_.gameObject, false)
				arg_264_1.callingController_:SetSelectedState("normal")

				local var_267_6 = arg_264_1:GetWordFromCfg(324072063)
				local var_267_7 = arg_264_1:FormatText(var_267_6.content)

				arg_264_1.text_.text = var_267_7

				LuaForUtil.ClearLinePrefixSymbol(arg_264_1.text_)

				local var_267_9 = 38 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 38)

				if (38 <= 0 and var_267_5 or var_267_5 * (utf8.len(var_267_7) / 38)) > 0 and var_267_5 < var_267_9 then
					arg_264_1.talkMaxDuration = var_267_9

					if var_267_9 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_9 + var_267_4
					end
				end

				arg_264_1.text_.text = var_267_7
				arg_264_1.typewritter.percent = 0

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072063", "story_v_out_324072.awb") ~= 0 then
					local var_267_10 = manager.audio:GetVoiceLength("story_v_out_324072", "324072063", "story_v_out_324072.awb") / 1000

					if var_267_10 + var_267_4 > arg_264_1.duration_ then
						arg_264_1.duration_ = var_267_10 + var_267_4
					end

					if var_267_6.prefab_name ~= "" and arg_264_1.actors_[var_267_6.prefab_name] ~= nil then
						local var_267_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_264_1.actors_[var_267_6.prefab_name].transform, "story_v_out_324072", "324072063", "story_v_out_324072.awb")

						arg_264_1:RecordAudio("324072063", var_267_11)
						arg_264_1:RecordAudio("324072063", var_267_11)
					else
						arg_264_1:AudioAction("play", "voice", "story_v_out_324072", "324072063", "story_v_out_324072.awb")
					end

					arg_264_1:RecordHistoryTalkVoice("story_v_out_324072", "324072063", "story_v_out_324072.awb")
				end

				arg_264_1:RecordContent(arg_264_1.text_.text)
			end

			local var_267_12 = math.max(var_267_5, arg_264_1.talkMaxDuration)

			if var_267_4 <= arg_264_1.time_ and arg_264_1.time_ < var_267_4 + var_267_12 then
				arg_264_1.typewritter.percent = (arg_264_1.time_ - var_267_4) / var_267_12

				arg_264_1.typewritter:SetDirty()
			end

			if arg_264_1.time_ >= var_267_4 + var_267_12 and arg_264_1.time_ < var_267_4 + var_267_12 + arg_267_0 then
				arg_264_1.typewritter.percent = 1

				arg_264_1.typewritter:SetDirty()
				arg_264_1:ShowNextGo(true)
			end
		end

		arg_264_1.nodeConfigList_ = {}

		arg_264_1:InitPlayNodeList()
	end,
	Play324072064 = function(arg_268_0, arg_268_1)
		arg_268_1.time_ = 0
		arg_268_1.frameCnt_ = 0
		arg_268_1.state_ = "playing"
		arg_268_1.curTalkId_ = 324072064
		arg_268_1.duration_ = 5

		SetActive(arg_268_1.tipsGo_, false)

		function arg_268_1.onSingleLineFinish_()
			arg_268_1.onSingleLineUpdate_ = nil
			arg_268_1.onSingleLineFinish_ = nil
			arg_268_1.state_ = "waiting"
		end

		function arg_268_1.playNext_(arg_270_0)
			if arg_270_0 == 1 then
				arg_268_0:Play324072065(arg_268_1)
			end
		end

		function arg_268_1.onSingleLineUpdate_(arg_271_0)
			if 0 < arg_268_1.time_ and arg_268_1.time_ <= 0 + arg_271_0 and not isNil(arg_268_1.actors_["1070ui_story"]) and arg_268_1.var_.characterEffect1070ui_story == nil then
				arg_268_1.var_.characterEffect1070ui_story = arg_268_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_271_0 = 0.200000002980232

			if 0 <= arg_268_1.time_ and arg_268_1.time_ < 0 + var_271_0 and not isNil(arg_268_1.actors_["1070ui_story"]) then
				if arg_268_1.var_.characterEffect1070ui_story and not isNil(arg_268_1.actors_["1070ui_story"]) then
					arg_268_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_268_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_268_1.time_ - 0) / var_271_0)
				end
			end

			if arg_268_1.time_ >= 0 + var_271_0 and arg_268_1.time_ < 0 + var_271_0 + arg_271_0 and not isNil(arg_268_1.actors_["1070ui_story"]) and arg_268_1.var_.characterEffect1070ui_story then
				arg_268_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_268_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_271_1 = 0
			local var_271_2 = 0.525

			if 0 < arg_268_1.time_ and arg_268_1.time_ <= var_271_1 + arg_271_0 then
				arg_268_1.talkMaxDuration = 0
				arg_268_1.dialogCg_.alpha = 1

				arg_268_1.dialog_:SetActive(true)
				SetActive(arg_268_1.leftNameGo_, true)

				arg_268_1.leftNameTxt_.text = arg_268_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_268_1.leftNameTxt_.transform)

				arg_268_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_268_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_268_1:RecordName(arg_268_1.leftNameTxt_.text)
				SetActive(arg_268_1.iconTrs_.gameObject, true)
				arg_268_1.iconController_:SetSelectedState("hero")

				arg_268_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_268_1.callingController_:SetSelectedState("normal")

				arg_268_1.keyicon_.color = Color.New(1, 1, 1)
				arg_268_1.icon_.color = Color.New(1, 1, 1)

				local var_271_3 = arg_268_1:FormatText(arg_268_1:GetWordFromCfg(324072064).content)

				arg_268_1.text_.text = var_271_3

				LuaForUtil.ClearLinePrefixSymbol(arg_268_1.text_)

				local var_271_5 = 21 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 21)

				if (21 <= 0 and var_271_2 or var_271_2 * (utf8.len(var_271_3) / 21)) > 0 and var_271_2 < var_271_5 then
					arg_268_1.talkMaxDuration = var_271_5

					if var_271_5 + var_271_1 > arg_268_1.duration_ then
						arg_268_1.duration_ = var_271_5 + var_271_1
					end
				end

				arg_268_1.text_.text = var_271_3
				arg_268_1.typewritter.percent = 0

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(false)
				arg_268_1:RecordContent(arg_268_1.text_.text)
			end

			local var_271_6 = math.max(var_271_2, arg_268_1.talkMaxDuration)

			if var_271_1 <= arg_268_1.time_ and arg_268_1.time_ < var_271_1 + var_271_6 then
				arg_268_1.typewritter.percent = (arg_268_1.time_ - var_271_1) / var_271_6

				arg_268_1.typewritter:SetDirty()
			end

			if arg_268_1.time_ >= var_271_1 + var_271_6 and arg_268_1.time_ < var_271_1 + var_271_6 + arg_271_0 then
				arg_268_1.typewritter.percent = 1

				arg_268_1.typewritter:SetDirty()
				arg_268_1:ShowNextGo(true)
			end
		end

		arg_268_1.nodeConfigList_ = {}

		arg_268_1:InitPlayNodeList()
	end,
	Play324072065 = function(arg_272_0, arg_272_1)
		arg_272_1.time_ = 0
		arg_272_1.frameCnt_ = 0
		arg_272_1.state_ = "playing"
		arg_272_1.curTalkId_ = 324072065
		arg_272_1.duration_ = 6.93

		local var_272_0 = {
			zh = 5.466,
			ja = 6.933
		}
		local var_272_1 = manager.audio:GetLocalizationFlag()

		if var_272_0[var_272_1] ~= nil then
			arg_272_1.duration_ = var_272_0[var_272_1]
		end

		SetActive(arg_272_1.tipsGo_, false)

		function arg_272_1.onSingleLineFinish_()
			arg_272_1.onSingleLineUpdate_ = nil
			arg_272_1.onSingleLineFinish_ = nil
			arg_272_1.state_ = "waiting"
		end

		function arg_272_1.playNext_(arg_274_0)
			if arg_274_0 == 1 then
				arg_272_0:Play324072066(arg_272_1)
			end
		end

		function arg_272_1.onSingleLineUpdate_(arg_275_0)
			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 and not isNil(arg_272_1.actors_["1070ui_story"]) and arg_272_1.var_.characterEffect1070ui_story == nil then
				arg_272_1.var_.characterEffect1070ui_story = arg_272_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_275_0 = 0.200000002980232

			if 0 <= arg_272_1.time_ and arg_272_1.time_ < 0 + var_275_0 and not isNil(arg_272_1.actors_["1070ui_story"]) then
				if arg_272_1.var_.characterEffect1070ui_story and not isNil(arg_272_1.actors_["1070ui_story"]) then
					arg_272_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_272_1.time_ >= 0 + var_275_0 and arg_272_1.time_ < 0 + var_275_0 + arg_275_0 and not isNil(arg_272_1.actors_["1070ui_story"]) and arg_272_1.var_.characterEffect1070ui_story then
				arg_272_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= 0 + arg_275_0 then
				arg_272_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_275_2 = 0
			local var_275_3 = 0.575

			if 0 < arg_272_1.time_ and arg_272_1.time_ <= var_275_2 + arg_275_0 then
				arg_272_1.talkMaxDuration = 0
				arg_272_1.dialogCg_.alpha = 1

				arg_272_1.dialog_:SetActive(true)
				SetActive(arg_272_1.leftNameGo_, true)

				arg_272_1.leftNameTxt_.text = arg_272_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_272_1.leftNameTxt_.transform)

				arg_272_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_272_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_272_1:RecordName(arg_272_1.leftNameTxt_.text)
				SetActive(arg_272_1.iconTrs_.gameObject, false)
				arg_272_1.callingController_:SetSelectedState("normal")

				local var_275_4 = arg_272_1:GetWordFromCfg(324072065)
				local var_275_5 = arg_272_1:FormatText(var_275_4.content)

				arg_272_1.text_.text = var_275_5

				LuaForUtil.ClearLinePrefixSymbol(arg_272_1.text_)

				local var_275_7 = 23 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 23)

				if (23 <= 0 and var_275_3 or var_275_3 * (utf8.len(var_275_5) / 23)) > 0 and var_275_3 < var_275_7 then
					arg_272_1.talkMaxDuration = var_275_7

					if var_275_7 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_7 + var_275_2
					end
				end

				arg_272_1.text_.text = var_275_5
				arg_272_1.typewritter.percent = 0

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324072", "324072065", "story_v_out_324072.awb") ~= 0 then
					local var_275_8 = manager.audio:GetVoiceLength("story_v_out_324072", "324072065", "story_v_out_324072.awb") / 1000

					if var_275_8 + var_275_2 > arg_272_1.duration_ then
						arg_272_1.duration_ = var_275_8 + var_275_2
					end

					if var_275_4.prefab_name ~= "" and arg_272_1.actors_[var_275_4.prefab_name] ~= nil then
						local var_275_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_272_1.actors_[var_275_4.prefab_name].transform, "story_v_out_324072", "324072065", "story_v_out_324072.awb")

						arg_272_1:RecordAudio("324072065", var_275_9)
						arg_272_1:RecordAudio("324072065", var_275_9)
					else
						arg_272_1:AudioAction("play", "voice", "story_v_out_324072", "324072065", "story_v_out_324072.awb")
					end

					arg_272_1:RecordHistoryTalkVoice("story_v_out_324072", "324072065", "story_v_out_324072.awb")
				end

				arg_272_1:RecordContent(arg_272_1.text_.text)
			end

			local var_275_10 = math.max(var_275_3, arg_272_1.talkMaxDuration)

			if var_275_2 <= arg_272_1.time_ and arg_272_1.time_ < var_275_2 + var_275_10 then
				arg_272_1.typewritter.percent = (arg_272_1.time_ - var_275_2) / var_275_10

				arg_272_1.typewritter:SetDirty()
			end

			if arg_272_1.time_ >= var_275_2 + var_275_10 and arg_272_1.time_ < var_275_2 + var_275_10 + arg_275_0 then
				arg_272_1.typewritter.percent = 1

				arg_272_1.typewritter:SetDirty()
				arg_272_1:ShowNextGo(true)
			end
		end

		arg_272_1.nodeConfigList_ = {}

		arg_272_1:InitPlayNodeList()
	end,
	Play324072066 = function(arg_276_0, arg_276_1)
		arg_276_1.time_ = 0
		arg_276_1.frameCnt_ = 0
		arg_276_1.state_ = "playing"
		arg_276_1.curTalkId_ = 324072066
		arg_276_1.duration_ = 5

		SetActive(arg_276_1.tipsGo_, false)

		function arg_276_1.onSingleLineFinish_()
			arg_276_1.onSingleLineUpdate_ = nil
			arg_276_1.onSingleLineFinish_ = nil
			arg_276_1.state_ = "waiting"
			arg_276_1.auto_ = false
		end

		function arg_276_1.playNext_(arg_278_0)
			arg_276_1.onStoryFinished_()
		end

		function arg_276_1.onSingleLineUpdate_(arg_279_0)
			if 0 < arg_276_1.time_ and arg_276_1.time_ <= 0 + arg_279_0 and not isNil(arg_276_1.actors_["1070ui_story"]) and arg_276_1.var_.characterEffect1070ui_story == nil then
				arg_276_1.var_.characterEffect1070ui_story = arg_276_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_279_0 = 0.200000002980232

			if 0 <= arg_276_1.time_ and arg_276_1.time_ < 0 + var_279_0 and not isNil(arg_276_1.actors_["1070ui_story"]) then
				if arg_276_1.var_.characterEffect1070ui_story and not isNil(arg_276_1.actors_["1070ui_story"]) then
					arg_276_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_276_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_276_1.time_ - 0) / var_279_0)
				end
			end

			if arg_276_1.time_ >= 0 + var_279_0 and arg_276_1.time_ < 0 + var_279_0 + arg_279_0 and not isNil(arg_276_1.actors_["1070ui_story"]) and arg_276_1.var_.characterEffect1070ui_story then
				arg_276_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_276_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_279_1 = 0
			local var_279_2 = 0.375

			if 0 < arg_276_1.time_ and arg_276_1.time_ <= var_279_1 + arg_279_0 then
				arg_276_1.talkMaxDuration = 0
				arg_276_1.dialogCg_.alpha = 1

				arg_276_1.dialog_:SetActive(true)
				SetActive(arg_276_1.leftNameGo_, true)

				arg_276_1.leftNameTxt_.text = arg_276_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_276_1.leftNameTxt_.transform)

				arg_276_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_276_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_276_1:RecordName(arg_276_1.leftNameTxt_.text)
				SetActive(arg_276_1.iconTrs_.gameObject, true)
				arg_276_1.iconController_:SetSelectedState("hero")

				arg_276_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_276_1.callingController_:SetSelectedState("normal")

				arg_276_1.keyicon_.color = Color.New(1, 1, 1)
				arg_276_1.icon_.color = Color.New(1, 1, 1)

				local var_279_3 = arg_276_1:FormatText(arg_276_1:GetWordFromCfg(324072066).content)

				arg_276_1.text_.text = var_279_3

				LuaForUtil.ClearLinePrefixSymbol(arg_276_1.text_)

				local var_279_5 = 15 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 15)

				if (15 <= 0 and var_279_2 or var_279_2 * (utf8.len(var_279_3) / 15)) > 0 and var_279_2 < var_279_5 then
					arg_276_1.talkMaxDuration = var_279_5

					if var_279_5 + var_279_1 > arg_276_1.duration_ then
						arg_276_1.duration_ = var_279_5 + var_279_1
					end
				end

				arg_276_1.text_.text = var_279_3
				arg_276_1.typewritter.percent = 0

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(false)
				arg_276_1:RecordContent(arg_276_1.text_.text)
			end

			local var_279_6 = math.max(var_279_2, arg_276_1.talkMaxDuration)

			if var_279_1 <= arg_276_1.time_ and arg_276_1.time_ < var_279_1 + var_279_6 then
				arg_276_1.typewritter.percent = (arg_276_1.time_ - var_279_1) / var_279_6

				arg_276_1.typewritter:SetDirty()
			end

			if arg_276_1.time_ >= var_279_1 + var_279_6 and arg_276_1.time_ < var_279_1 + var_279_6 + arg_279_0 then
				arg_276_1.typewritter.percent = 1

				arg_276_1.typewritter:SetDirty()
				arg_276_1:ShowNextGo(true)
			end
		end

		arg_276_1.nodeConfigList_ = {}

		arg_276_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2403",
		"TextureConfig/Background/ST2008",
		"TextureConfig/Background/ST2007"
	},
	voices = {
		"story_v_out_324072.awb"
	}
}
