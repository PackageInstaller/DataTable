return {
	Play324541001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 324541001
		arg_1_1.duration_ = 7.67

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play324541002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.MS2406 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "MS2406")
				var_4_0.name = "MS2406"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.MS2406 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.MS2406

				arg_1_1.bgs_.MS2406.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "MS2406" then
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

			local var_4_9 = arg_1_1.bgs_.MS2406.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2406 = var_4_9.localPosition
			end

			local var_4_10 = 2

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_10 then
				var_4_9.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2406, Vector3.New(0, 0, 5.5), (arg_1_1.time_ - 0) / var_4_10)
			end

			if arg_1_1.time_ >= 0 + var_4_10 and arg_1_1.time_ < 0 + var_4_10 + arg_4_0 then
				var_4_9.localPosition = Vector3.New(0, 0, 5.5)
			end

			local var_4_11 = arg_1_1.bgs_.MS2406.transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPosMS2406 = var_4_11.localPosition
			end

			local var_4_12 = 1.1

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_12 then
				var_4_11.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosMS2406, Vector3.New(0, 1, 10), (arg_1_1.time_ - 1.8) / var_4_12)
			end

			if arg_1_1.time_ >= 1.8 + var_4_12 and arg_1_1.time_ < 1.8 + var_4_12 + arg_4_0 then
				var_4_11.localPosition = Vector3.New(0, 1, 10)
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_dark", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu.awb")

				local var_4_17 = manager.audio:GetAudioName("bgm_activity_4_8_story_taixu", "bgm_activity_4_8_story_taixu")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_17 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_17

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_17
						arg_1_1.bgmTxt2_.text = var_4_17
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

			local var_4_18 = 2.66666666666667
			local var_4_19 = 0.175

			if 2.66666666666667 < arg_1_1.time_ and arg_1_1.time_ <= var_4_18 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_20 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_20:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_21 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(324541001).content)

				arg_1_1.text_.text = var_4_21

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_23 = 7 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 7)

				if (7 <= 0 and var_4_19 or var_4_19 * (utf8.len(var_4_21) / 7)) > 0 and var_4_19 < var_4_23 then
					arg_1_1.talkMaxDuration = var_4_23
					var_4_18 = var_4_18 + 0.3

					if var_4_23 + var_4_18 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_23 + var_4_18
					end
				end

				arg_1_1.text_.text = var_4_21
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_24 = var_4_18 + 0.3
			local var_4_25 = math.max(var_4_19, arg_1_1.talkMaxDuration)

			if var_4_18 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_24 + var_4_25 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_24) / var_4_25

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_24 + var_4_25 and arg_1_1.time_ < var_4_24 + var_4_25 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406",
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
					startPos = Vector3.New(1, 0, 5),
					endPos = Vector3.New(0, 0, 5.5),
					easeType = LeanTweenType.easeInOutQuint
				}
			},
			{
				assetPath = "",
				needEase = true,
				actorName = "MS2406",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1.1,
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 0, 5.5),
					endPos = Vector3.New(0, 1, 10),
					easeType = LeanTweenType.easeInOutExpo
				}
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play324541002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 324541002
		arg_8_1.duration_ = 2.53

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play324541003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1012ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1012ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1012ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1012ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1012ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1012ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1012ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1012ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1012ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1012ui_story == nil then
				arg_8_1.var_.characterEffect1012ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1012ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1012ui_story then
				arg_8_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_11_6 = 0
			local var_11_7 = 0.225

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_6 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_8 = arg_8_1:GetWordFromCfg(324541002)
				local var_11_9 = arg_8_1:FormatText(var_11_8.content)

				arg_8_1.text_.text = var_11_9

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_11 = 9 <= 0 and var_11_7 or var_11_7 * (utf8.len(var_11_9) / 9)

				if (9 <= 0 and var_11_7 or var_11_7 * (utf8.len(var_11_9) / 9)) > 0 and var_11_7 < var_11_11 then
					arg_8_1.talkMaxDuration = var_11_11

					if var_11_11 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_11 + var_11_6
					end
				end

				arg_8_1.text_.text = var_11_9
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324541", "324541002", "story_v_out_324541.awb") ~= 0 then
					local var_11_12 = manager.audio:GetVoiceLength("story_v_out_324541", "324541002", "story_v_out_324541.awb") / 1000

					if var_11_12 + var_11_6 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_12 + var_11_6
					end

					if var_11_8.prefab_name ~= "" and arg_8_1.actors_[var_11_8.prefab_name] ~= nil then
						local var_11_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_8.prefab_name].transform, "story_v_out_324541", "324541002", "story_v_out_324541.awb")

						arg_8_1:RecordAudio("324541002", var_11_13)
						arg_8_1:RecordAudio("324541002", var_11_13)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_324541", "324541002", "story_v_out_324541.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_324541", "324541002", "story_v_out_324541.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_14 = math.max(var_11_7, arg_8_1.talkMaxDuration)

			if var_11_6 <= arg_8_1.time_ and arg_8_1.time_ < var_11_6 + var_11_14 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_6) / var_11_14

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_6 + var_11_14 and arg_8_1.time_ < var_11_6 + var_11_14 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {}

		arg_8_1:InitPlayNodeList()
	end,
	Play324541003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 324541003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play324541004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1012ui_story"]) and arg_12_1.var_.characterEffect1012ui_story == nil then
				arg_12_1.var_.characterEffect1012ui_story = arg_12_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1012ui_story"]) then
				if arg_12_1.var_.characterEffect1012ui_story and not isNil(arg_12_1.actors_["1012ui_story"]) then
					arg_12_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1012ui_story"]) and arg_12_1.var_.characterEffect1012ui_story then
				arg_12_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.25

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
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(324541003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 10 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 10)

				if (10 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 10)) > 0 and var_15_2 < var_15_5 then
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
	Play324541004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 324541004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play324541005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.7

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

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(324541004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 28 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 28)

				if (28 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 28)) > 0 and var_19_0 < var_19_3 then
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
	Play324541005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 324541005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play324541006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.75

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(324541005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 30 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 30)

				if (30 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 30)) > 0 and var_23_0 < var_23_3 then
					arg_20_1.talkMaxDuration = var_23_3

					if var_23_3 + 0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_3 + 0
					end
				end

				arg_20_1.text_.text = var_23_1
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_4 = math.max(var_23_0, arg_20_1.talkMaxDuration)

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - 0) / var_23_4

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play324541006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 324541006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play324541007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.4

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_1 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(324541006).content)

				arg_24_1.text_.text = var_27_1

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_3 = 16 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 16)

				if (16 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_1) / 16)) > 0 and var_27_0 < var_27_3 then
					arg_24_1.talkMaxDuration = var_27_3

					if var_27_3 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_3 + 0
					end
				end

				arg_24_1.text_.text = var_27_1
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_4 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_4

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play324541007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 324541007
		arg_28_1.duration_ = 4.27

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play324541008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1012ui_story"]) and arg_28_1.var_.characterEffect1012ui_story == nil then
				arg_28_1.var_.characterEffect1012ui_story = arg_28_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1012ui_story"]) then
				if arg_28_1.var_.characterEffect1012ui_story and not isNil(arg_28_1.actors_["1012ui_story"]) then
					arg_28_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1012ui_story"]) and arg_28_1.var_.characterEffect1012ui_story then
				arg_28_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_31_2 = 0
			local var_31_3 = 0.475

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_2 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_4 = arg_28_1:GetWordFromCfg(324541007)
				local var_31_5 = arg_28_1:FormatText(var_31_4.content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 19 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 19)

				if (19 <= 0 and var_31_3 or var_31_3 * (utf8.len(var_31_5) / 19)) > 0 and var_31_3 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_2
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324541", "324541007", "story_v_out_324541.awb") ~= 0 then
					local var_31_8 = manager.audio:GetVoiceLength("story_v_out_324541", "324541007", "story_v_out_324541.awb") / 1000

					if var_31_8 + var_31_2 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_8 + var_31_2
					end

					if var_31_4.prefab_name ~= "" and arg_28_1.actors_[var_31_4.prefab_name] ~= nil then
						local var_31_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_4.prefab_name].transform, "story_v_out_324541", "324541007", "story_v_out_324541.awb")

						arg_28_1:RecordAudio("324541007", var_31_9)
						arg_28_1:RecordAudio("324541007", var_31_9)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_324541", "324541007", "story_v_out_324541.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_324541", "324541007", "story_v_out_324541.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_10 = math.max(var_31_3, arg_28_1.talkMaxDuration)

			if var_31_2 <= arg_28_1.time_ and arg_28_1.time_ < var_31_2 + var_31_10 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_2) / var_31_10

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_2 + var_31_10 and arg_28_1.time_ < var_31_2 + var_31_10 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play324541008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 324541008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play324541009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1012ui_story"]) and arg_32_1.var_.characterEffect1012ui_story == nil then
				arg_32_1.var_.characterEffect1012ui_story = arg_32_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1012ui_story"]) then
				if arg_32_1.var_.characterEffect1012ui_story and not isNil(arg_32_1.actors_["1012ui_story"]) then
					arg_32_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1012ui_story"]) and arg_32_1.var_.characterEffect1012ui_story then
				arg_32_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.7

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(324541008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 28 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 28)

				if (28 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 28)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play324541009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 324541009
		arg_36_1.duration_ = 1.53

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play324541010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1012ui_story"]) and arg_36_1.var_.characterEffect1012ui_story == nil then
				arg_36_1.var_.characterEffect1012ui_story = arg_36_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1012ui_story"]) then
				if arg_36_1.var_.characterEffect1012ui_story and not isNil(arg_36_1.actors_["1012ui_story"]) then
					arg_36_1.var_.characterEffect1012ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1012ui_story"]) and arg_36_1.var_.characterEffect1012ui_story then
				arg_36_1.var_.characterEffect1012ui_story.fillFlat = false
			end

			local var_39_2 = 0
			local var_39_3 = 0.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[1450].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(324541009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 6 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 6)

				if (6 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 6)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_324541", "324541009", "story_v_out_324541.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_324541", "324541009", "story_v_out_324541.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_324541", "324541009", "story_v_out_324541.awb")

						arg_36_1:RecordAudio("324541009", var_39_9)
						arg_36_1:RecordAudio("324541009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_324541", "324541009", "story_v_out_324541.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_324541", "324541009", "story_v_out_324541.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play324541010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 324541010
		arg_40_1.duration_ = 1

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"

			SetActive(arg_40_1.choicesGo_, true)

			for iter_41_0, iter_41_1 in ipairs(arg_40_1.choices_) do
				SetActive(iter_41_1.go, iter_41_0 <= 3)
			end

			arg_40_1.choices_[1].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1618].name)
			arg_40_1.choices_[2].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1619].name)
			arg_40_1.choices_[3].txt.text = arg_40_1:FormatText(StoryChoiceCfg[1620].name)
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play324541011(arg_40_1)
			end

			if arg_42_0 == 2 then
				arg_40_0:Play324541011(arg_40_1)
			end

			if arg_42_0 == 3 then
				arg_40_0:Play324541011(arg_40_1)
			end

			arg_40_1:RecordChoiceLog(324541010, 1618, 1619, 1620)
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1012ui_story"]) and arg_40_1.var_.characterEffect1012ui_story == nil then
				arg_40_1.var_.characterEffect1012ui_story = arg_40_1.actors_["1012ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1012ui_story"]) then
				if arg_40_1.var_.characterEffect1012ui_story and not isNil(arg_40_1.actors_["1012ui_story"]) then
					arg_40_1.var_.characterEffect1012ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1012ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1012ui_story"]) and arg_40_1.var_.characterEffect1012ui_story then
				arg_40_1.var_.characterEffect1012ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1012ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.allBtn_.enabled = false
			end

			if arg_40_1.time_ >= var_43_1 + 0.6 and arg_40_1.time_ < var_43_1 + 0.6 + arg_43_0 then
				arg_40_1.allBtn_.enabled = true
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play324541011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 324541011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play324541012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 1.25

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(324541011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 50 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 50)

				if (50 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 50)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play324541012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 324541012
		arg_48_1.duration_ = 9

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play324541013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if arg_48_1.bgs_.J25f == nil then
				local var_51_0 = Object.Instantiate(arg_48_1.paintGo_)

				var_51_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "J25f")
				var_51_0.name = "J25f"
				var_51_0.transform.parent = arg_48_1.stage_.transform
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.bgs_.J25f = var_51_0
			end

			if 2 < arg_48_1.time_ and arg_48_1.time_ <= 2 + arg_51_0 then
				local var_51_1 = arg_48_1.bgs_.J25f

				arg_48_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_51_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_51_2 = var_51_1:GetComponent("SpriteRenderer")

				if var_51_2 and var_51_2.sprite then
					local var_51_3 = 2 * (var_51_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_51_1.transform.localScale = Vector3.New(var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, var_51_3 / var_51_2.sprite.bounds.size.y < var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x and var_51_3 * manager.ui.mainCameraCom_.aspect / var_51_2.sprite.bounds.size.x or var_51_3 / var_51_2.sprite.bounds.size.y, 0)
				end

				for iter_51_0, iter_51_1 in pairs(arg_48_1.bgs_) do
					if iter_51_0 ~= "J25f" then
						iter_51_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_51_4 = 4

			if 4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.allBtn_.enabled = false
			end

			if arg_48_1.time_ >= var_51_4 + 0.3 and arg_48_1.time_ < var_51_4 + 0.3 + arg_51_0 then
				arg_48_1.allBtn_.enabled = true
			end

			local var_51_5 = 0

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_5 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_6 = 2

			if var_51_5 <= arg_48_1.time_ and arg_48_1.time_ < var_51_5 + var_51_6 then
				local var_51_7 = Color.New(0, 0, 0)

				var_51_7.a = Mathf.Lerp(0, 1, (arg_48_1.time_ - var_51_5) / var_51_6)
				arg_48_1.mask_.color = var_51_7
			end

			if arg_48_1.time_ >= var_51_5 + var_51_6 and arg_48_1.time_ < var_51_5 + var_51_6 + arg_51_0 then
				local var_51_8 = Color.New(0, 0, 0)

				var_51_8.a = 1
				arg_48_1.mask_.color = var_51_8
			end

			local var_51_9 = 2

			if 2 < arg_48_1.time_ and arg_48_1.time_ <= var_51_9 + arg_51_0 then
				arg_48_1.mask_.enabled = true
				arg_48_1.mask_.raycastTarget = true

				arg_48_1:SetGaussion(false)
			end

			local var_51_10 = 2

			if var_51_9 <= arg_48_1.time_ and arg_48_1.time_ < var_51_9 + var_51_10 then
				local var_51_11 = Color.New(0, 0, 0)

				var_51_11.a = Mathf.Lerp(1, 0, (arg_48_1.time_ - var_51_9) / var_51_10)
				arg_48_1.mask_.color = var_51_11
			end

			if arg_48_1.time_ >= var_51_9 + var_51_10 and arg_48_1.time_ < var_51_9 + var_51_10 + arg_51_0 then
				local var_51_12 = Color.New(0, 0, 0)

				arg_48_1.mask_.enabled = false
				var_51_12.a = 0
				arg_48_1.mask_.color = var_51_12
			end

			if arg_48_1.frameCnt_ <= 1 then
				arg_48_1.dialog_:SetActive(false)
			end

			local var_51_13 = 4
			local var_51_14 = 1.325

			if 4 < arg_48_1.time_ and arg_48_1.time_ <= var_51_13 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0

				arg_48_1.dialog_:SetActive(true)

				arg_48_1.dialogCg_.alpha = 0

				local var_51_15 = LeanTween.value(arg_48_1.dialog_, 0, 1, 0.3)

				var_51_15:setOnUpdate(LuaHelper.FloatAction(function(arg_52_0)
					arg_48_1.dialogCg_.alpha = arg_52_0
				end))
				var_51_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_48_1.dialog_)
					var_51_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_48_1.duration_ = arg_48_1.duration_ + 0.3

				SetActive(arg_48_1.leftNameGo_, false)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_16 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(324541012).content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_18 = 53 <= 0 and var_51_14 or var_51_14 * (utf8.len(var_51_16) / 53)

				if (53 <= 0 and var_51_14 or var_51_14 * (utf8.len(var_51_16) / 53)) > 0 and var_51_14 < var_51_18 then
					arg_48_1.talkMaxDuration = var_51_18
					var_51_13 = var_51_13 + 0.3

					if var_51_18 + var_51_13 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_13
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_19 = var_51_13 + 0.3
			local var_51_20 = math.max(var_51_14, arg_48_1.talkMaxDuration)

			if var_51_13 + 0.3 <= arg_48_1.time_ and arg_48_1.time_ < var_51_19 + var_51_20 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_19) / var_51_20

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_19 + var_51_20 and arg_48_1.time_ < var_51_19 + var_51_20 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play324541013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 324541013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play324541014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 1.2

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, false)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_54_1.iconTrs_.gameObject, false)
				arg_54_1.callingController_:SetSelectedState("normal")

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(324541013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 48 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 48)

				if (48 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 48)) > 0 and var_57_0 < var_57_3 then
					arg_54_1.talkMaxDuration = var_57_3

					if var_57_3 + 0 > arg_54_1.duration_ then
						arg_54_1.duration_ = var_57_3 + 0
					end
				end

				arg_54_1.text_.text = var_57_1
				arg_54_1.typewritter.percent = 0

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(false)
				arg_54_1:RecordContent(arg_54_1.text_.text)
			end

			local var_57_4 = math.max(var_57_0, arg_54_1.talkMaxDuration)

			if 0 <= arg_54_1.time_ and arg_54_1.time_ < 0 + var_57_4 then
				arg_54_1.typewritter.percent = (arg_54_1.time_ - 0) / var_57_4

				arg_54_1.typewritter:SetDirty()
			end

			if arg_54_1.time_ >= 0 + var_57_4 and arg_54_1.time_ < 0 + var_57_4 + arg_57_0 then
				arg_54_1.typewritter.percent = 1

				arg_54_1.typewritter:SetDirty()
				arg_54_1:ShowNextGo(true)
			end
		end

		arg_54_1.nodeConfigList_ = {}

		arg_54_1:InitPlayNodeList()
	end,
	Play324541014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 324541014
		arg_58_1.duration_ = 5

		SetActive(arg_58_1.tipsGo_, false)

		function arg_58_1.onSingleLineFinish_()
			arg_58_1.onSingleLineUpdate_ = nil
			arg_58_1.onSingleLineFinish_ = nil
			arg_58_1.state_ = "waiting"
		end

		function arg_58_1.playNext_(arg_60_0)
			if arg_60_0 == 1 then
				arg_58_0:Play324541015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			local var_61_0 = 0.675

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, true)
				arg_58_1.iconController_:SetSelectedState("hero")

				arg_58_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_58_1.callingController_:SetSelectedState("normal")

				arg_58_1.keyicon_.color = Color.New(1, 1, 1)
				arg_58_1.icon_.color = Color.New(1, 1, 1)

				local var_61_1 = arg_58_1:FormatText(arg_58_1:GetWordFromCfg(324541014).content)

				arg_58_1.text_.text = var_61_1

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_3 = 27 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 27)

				if (27 <= 0 and var_61_0 or var_61_0 * (utf8.len(var_61_1) / 27)) > 0 and var_61_0 < var_61_3 then
					arg_58_1.talkMaxDuration = var_61_3

					if var_61_3 + 0 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_3 + 0
					end
				end

				arg_58_1.text_.text = var_61_1
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)
				arg_58_1:RecordContent(arg_58_1.text_.text)
			end

			local var_61_4 = math.max(var_61_0, arg_58_1.talkMaxDuration)

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_4 then
				arg_58_1.typewritter.percent = (arg_58_1.time_ - 0) / var_61_4

				arg_58_1.typewritter:SetDirty()
			end

			if arg_58_1.time_ >= 0 + var_61_4 and arg_58_1.time_ < 0 + var_61_4 + arg_61_0 then
				arg_58_1.typewritter.percent = 1

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(true)
			end
		end

		arg_58_1.nodeConfigList_ = {}

		arg_58_1:InitPlayNodeList()
	end,
	Play324541015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 324541015
		arg_62_1.duration_ = 5

		SetActive(arg_62_1.tipsGo_, false)

		function arg_62_1.onSingleLineFinish_()
			arg_62_1.onSingleLineUpdate_ = nil
			arg_62_1.onSingleLineFinish_ = nil
			arg_62_1.state_ = "waiting"
		end

		function arg_62_1.playNext_(arg_64_0)
			if arg_64_0 == 1 then
				arg_62_0:Play324541016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 1.275

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, false)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:FormatText(arg_62_1:GetWordFromCfg(324541015).content)

				arg_62_1.text_.text = var_65_1

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_3 = 51 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 51)

				if (51 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_1) / 51)) > 0 and var_65_0 < var_65_3 then
					arg_62_1.talkMaxDuration = var_65_3

					if var_65_3 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_3 + 0
					end
				end

				arg_62_1.text_.text = var_65_1
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)
				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_4 = math.max(var_65_0, arg_62_1.talkMaxDuration)

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - 0) / var_65_4

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {}

		arg_62_1:InitPlayNodeList()
	end,
	Play324541016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 324541016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play324541017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			local var_69_0 = 1.375

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, false)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_1 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(324541016).content)

				arg_66_1.text_.text = var_69_1

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_3 = 55 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 55)

				if (55 <= 0 and var_69_0 or var_69_0 * (utf8.len(var_69_1) / 55)) > 0 and var_69_0 < var_69_3 then
					arg_66_1.talkMaxDuration = var_69_3

					if var_69_3 + 0 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_3 + 0
					end
				end

				arg_66_1.text_.text = var_69_1
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_4 = math.max(var_69_0, arg_66_1.talkMaxDuration)

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_4 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - 0) / var_69_4

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= 0 + var_69_4 and arg_66_1.time_ < 0 + var_69_4 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play324541017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 324541017
		arg_70_1.duration_ = 5

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play324541018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			local var_73_0 = 1.325

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, false)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_1 = arg_70_1:FormatText(arg_70_1:GetWordFromCfg(324541017).content)

				arg_70_1.text_.text = var_73_1

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_3 = 53 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 53)

				if (53 <= 0 and var_73_0 or var_73_0 * (utf8.len(var_73_1) / 53)) > 0 and var_73_0 < var_73_3 then
					arg_70_1.talkMaxDuration = var_73_3

					if var_73_3 + 0 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_3 + 0
					end
				end

				arg_70_1.text_.text = var_73_1
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)
				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_4 = math.max(var_73_0, arg_70_1.talkMaxDuration)

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_4 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - 0) / var_73_4

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= 0 + var_73_4 and arg_70_1.time_ < 0 + var_73_4 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play324541018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 324541018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play324541019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			local var_77_0 = 0.125

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

				arg_74_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_74_1.callingController_:SetSelectedState("normal")

				arg_74_1.keyicon_.color = Color.New(1, 1, 1)
				arg_74_1.icon_.color = Color.New(1, 1, 1)

				local var_77_1 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(324541018).content)

				arg_74_1.text_.text = var_77_1

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_3 = 5 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 5)

				if (5 <= 0 and var_77_0 or var_77_0 * (utf8.len(var_77_1) / 5)) > 0 and var_77_0 < var_77_3 then
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
	Play324541019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 324541019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play324541020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			local var_81_0 = 0.6

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_1 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(324541019).content)

				arg_78_1.text_.text = var_81_1

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_3 = 24 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 24)

				if (24 <= 0 and var_81_0 or var_81_0 * (utf8.len(var_81_1) / 24)) > 0 and var_81_0 < var_81_3 then
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
	Play324541020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 324541020
		arg_82_1.duration_ = 5.7

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play324541021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPosJ25f = arg_82_1.bgs_.J25f.transform.localPosition
			end

			local var_85_0 = 1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.bgs_.J25f.transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPosJ25f, Vector3.New(0, 1, 9.5), (arg_82_1.time_ - 0) / var_85_0)
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_85_1 = 0

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.allBtn_.enabled = false
			end

			if arg_82_1.time_ >= var_85_1 + 1.36666666666667 and arg_82_1.time_ < var_85_1 + 1.36666666666667 + arg_85_0 then
				arg_82_1.allBtn_.enabled = true
			end

			local var_85_2 = 0.7
			local var_85_3 = 1.2

			if 0.7 < arg_82_1.time_ and arg_82_1.time_ <= var_85_2 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_4 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(324541020).content)

				arg_82_1.text_.text = var_85_4

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_6 = 48 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 48)

				if (48 <= 0 and var_85_3 or var_85_3 * (utf8.len(var_85_4) / 48)) > 0 and var_85_3 < var_85_6 then
					arg_82_1.talkMaxDuration = var_85_6

					if var_85_6 + var_85_2 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_6 + var_85_2
					end
				end

				arg_82_1.text_.text = var_85_4
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_3, arg_82_1.talkMaxDuration)

			if var_85_2 <= arg_82_1.time_ and arg_82_1.time_ < var_85_2 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_2) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_2 + var_85_7 and arg_82_1.time_ < var_85_2 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				needEase = true,
				actorName = "J25f",
				className = "StoryMoveNode",
				changeDisplayLayer = false,
				duration = 1,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				easeData = {
					needAlphaEase = false,
					startAlpha = 0,
					endAlpha = 1,
					moveType = StoryPlayerConst.EASE_MOVE_TYPE.MOVE_IN,
					startPos = Vector3.New(0, 1, 10),
					endPos = Vector3.New(0, 1, 9.5),
					easeType = LeanTweenType.notUsed
				}
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play324541021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 324541021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play324541022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			local var_89_0 = 0.15

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, true)
				arg_86_1.iconController_:SetSelectedState("hero")

				arg_86_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_86_1.callingController_:SetSelectedState("normal")

				arg_86_1.keyicon_.color = Color.New(1, 1, 1)
				arg_86_1.icon_.color = Color.New(1, 1, 1)

				local var_89_1 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(324541021).content)

				arg_86_1.text_.text = var_89_1

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_3 = 6 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 6)

				if (6 <= 0 and var_89_0 or var_89_0 * (utf8.len(var_89_1) / 6)) > 0 and var_89_0 < var_89_3 then
					arg_86_1.talkMaxDuration = var_89_3

					if var_89_3 + 0 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_3 + 0
					end
				end

				arg_86_1.text_.text = var_89_1
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_4 = math.max(var_89_0, arg_86_1.talkMaxDuration)

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - 0) / var_89_4

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play324541022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 324541022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play324541023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			local var_93_0 = 1.575

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_1 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(324541022).content)

				arg_90_1.text_.text = var_93_1

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_3 = 63 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 63)

				if (63 <= 0 and var_93_0 or var_93_0 * (utf8.len(var_93_1) / 63)) > 0 and var_93_0 < var_93_3 then
					arg_90_1.talkMaxDuration = var_93_3

					if var_93_3 + 0 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_3 + 0
					end
				end

				arg_90_1.text_.text = var_93_1
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_4 = math.max(var_93_0, arg_90_1.talkMaxDuration)

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - 0) / var_93_4

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play324541023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 324541023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play324541024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 1.45

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, false)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(324541023).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 58 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 58)

				if (58 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 58)) > 0 and var_97_0 < var_97_3 then
					arg_94_1.talkMaxDuration = var_97_3

					if var_97_3 + 0 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_3 + 0
					end
				end

				arg_94_1.text_.text = var_97_1
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)
				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_4 = math.max(var_97_0, arg_94_1.talkMaxDuration)

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - 0) / var_97_4

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play324541024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 324541024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play324541025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.15

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_98_1.callingController_:SetSelectedState("normal")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(324541024).content)

				arg_98_1.text_.text = var_101_1

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_3 = 6 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 6)

				if (6 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_1) / 6)) > 0 and var_101_0 < var_101_3 then
					arg_98_1.talkMaxDuration = var_101_3

					if var_101_3 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_3 + 0
					end
				end

				arg_98_1.text_.text = var_101_1
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_4 = math.max(var_101_0, arg_98_1.talkMaxDuration)

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - 0) / var_101_4

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play324541025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 324541025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play324541026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			local var_105_0 = 1.05

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_1 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(324541025).content)

				arg_102_1.text_.text = var_105_1

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_3 = 42 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 42)

				if (42 <= 0 and var_105_0 or var_105_0 * (utf8.len(var_105_1) / 42)) > 0 and var_105_0 < var_105_3 then
					arg_102_1.talkMaxDuration = var_105_3

					if var_105_3 + 0 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_3 + 0
					end
				end

				arg_102_1.text_.text = var_105_1
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_4 = math.max(var_105_0, arg_102_1.talkMaxDuration)

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - 0) / var_105_4

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play324541026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 324541026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play324541027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 1.225

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, false)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_1 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(324541026).content)

				arg_106_1.text_.text = var_109_1

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_3 = 49 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 49)

				if (49 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_1) / 49)) > 0 and var_109_0 < var_109_3 then
					arg_106_1.talkMaxDuration = var_109_3

					if var_109_3 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_3 + 0
					end
				end

				arg_106_1.text_.text = var_109_1
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_4 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_4 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_4

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_4 and arg_106_1.time_ < 0 + var_109_4 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play324541027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 324541027
		arg_110_1.duration_ = 5

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play324541028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.25

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:FormatText(arg_110_1:GetWordFromCfg(324541027).content)

				arg_110_1.text_.text = var_113_1

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_3 = 10 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 10)

				if (10 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_1) / 10)) > 0 and var_113_0 < var_113_3 then
					arg_110_1.talkMaxDuration = var_113_3

					if var_113_3 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_3 + 0
					end
				end

				arg_110_1.text_.text = var_113_1
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)
				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_4 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_4

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play324541028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 324541028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play324541029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			local var_117_0 = 1.45

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_1 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(324541028).content)

				arg_114_1.text_.text = var_117_1

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_3 = 58 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 58)

				if (58 <= 0 and var_117_0 or var_117_0 * (utf8.len(var_117_1) / 58)) > 0 and var_117_0 < var_117_3 then
					arg_114_1.talkMaxDuration = var_117_3

					if var_117_3 + 0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_3 + 0
					end
				end

				arg_114_1.text_.text = var_117_1
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_4 = math.max(var_117_0, arg_114_1.talkMaxDuration)

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_4 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - 0) / var_117_4

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= 0 + var_117_4 and arg_114_1.time_ < 0 + var_117_4 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play324541029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 324541029
		arg_118_1.duration_ = 5

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play324541030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			local var_121_0 = 1.1

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, false)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_1 = arg_118_1:FormatText(arg_118_1:GetWordFromCfg(324541029).content)

				arg_118_1.text_.text = var_121_1

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_3 = 44 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 44)

				if (44 <= 0 and var_121_0 or var_121_0 * (utf8.len(var_121_1) / 44)) > 0 and var_121_0 < var_121_3 then
					arg_118_1.talkMaxDuration = var_121_3

					if var_121_3 + 0 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_3 + 0
					end
				end

				arg_118_1.text_.text = var_121_1
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)
				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_4 = math.max(var_121_0, arg_118_1.talkMaxDuration)

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - 0) / var_121_4

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play324541030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 324541030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play324541031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			local var_125_0 = 1.375

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_1 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(324541030).content)

				arg_122_1.text_.text = var_125_1

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_3 = 55 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 55)

				if (55 <= 0 and var_125_0 or var_125_0 * (utf8.len(var_125_1) / 55)) > 0 and var_125_0 < var_125_3 then
					arg_122_1.talkMaxDuration = var_125_3

					if var_125_3 + 0 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_3 + 0
					end
				end

				arg_122_1.text_.text = var_125_1
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_4 = math.max(var_125_0, arg_122_1.talkMaxDuration)

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_4 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - 0) / var_125_4

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= 0 + var_125_4 and arg_122_1.time_ < 0 + var_125_4 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play324541031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 324541031
		arg_126_1.duration_ = 5

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play324541032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			local var_129_0 = 0.4

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, true)
				arg_126_1.iconController_:SetSelectedState("hero")

				arg_126_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_126_1.callingController_:SetSelectedState("normal")

				arg_126_1.keyicon_.color = Color.New(1, 1, 1)
				arg_126_1.icon_.color = Color.New(1, 1, 1)

				local var_129_1 = arg_126_1:FormatText(arg_126_1:GetWordFromCfg(324541031).content)

				arg_126_1.text_.text = var_129_1

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_3 = 16 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 16)

				if (16 <= 0 and var_129_0 or var_129_0 * (utf8.len(var_129_1) / 16)) > 0 and var_129_0 < var_129_3 then
					arg_126_1.talkMaxDuration = var_129_3

					if var_129_3 + 0 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_3 + 0
					end
				end

				arg_126_1.text_.text = var_129_1
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)
				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_4 = math.max(var_129_0, arg_126_1.talkMaxDuration)

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_4 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - 0) / var_129_4

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= 0 + var_129_4 and arg_126_1.time_ < 0 + var_129_4 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play324541032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 324541032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play324541033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			local var_133_0 = 1.2

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_1 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(324541032).content)

				arg_130_1.text_.text = var_133_1

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_3 = 48 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 48)

				if (48 <= 0 and var_133_0 or var_133_0 * (utf8.len(var_133_1) / 48)) > 0 and var_133_0 < var_133_3 then
					arg_130_1.talkMaxDuration = var_133_3

					if var_133_3 + 0 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_3 + 0
					end
				end

				arg_130_1.text_.text = var_133_1
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_4 = math.max(var_133_0, arg_130_1.talkMaxDuration)

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - 0) / var_133_4

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play324541033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 324541033
		arg_134_1.duration_ = 5

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play324541034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			local var_137_0 = 0.225

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, true)
				arg_134_1.iconController_:SetSelectedState("hero")

				arg_134_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_134_1.callingController_:SetSelectedState("normal")

				arg_134_1.keyicon_.color = Color.New(1, 1, 1)
				arg_134_1.icon_.color = Color.New(1, 1, 1)

				local var_137_1 = arg_134_1:FormatText(arg_134_1:GetWordFromCfg(324541033).content)

				arg_134_1.text_.text = var_137_1

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_3 = 9 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 9)

				if (9 <= 0 and var_137_0 or var_137_0 * (utf8.len(var_137_1) / 9)) > 0 and var_137_0 < var_137_3 then
					arg_134_1.talkMaxDuration = var_137_3

					if var_137_3 + 0 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_3 + 0
					end
				end

				arg_134_1.text_.text = var_137_1
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)
				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_4 = math.max(var_137_0, arg_134_1.talkMaxDuration)

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_4 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - 0) / var_137_4

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= 0 + var_137_4 and arg_134_1.time_ < 0 + var_137_4 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play324541034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 324541034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play324541035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			local var_141_0 = 0.45

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, true)
				arg_138_1.iconController_:SetSelectedState("hero")

				arg_138_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_138_1.callingController_:SetSelectedState("normal")

				arg_138_1.keyicon_.color = Color.New(1, 1, 1)
				arg_138_1.icon_.color = Color.New(1, 1, 1)

				local var_141_1 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(324541034).content)

				arg_138_1.text_.text = var_141_1

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_3 = 18 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 18)

				if (18 <= 0 and var_141_0 or var_141_0 * (utf8.len(var_141_1) / 18)) > 0 and var_141_0 < var_141_3 then
					arg_138_1.talkMaxDuration = var_141_3

					if var_141_3 + 0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_3 + 0
					end
				end

				arg_138_1.text_.text = var_141_1
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_4 = math.max(var_141_0, arg_138_1.talkMaxDuration)

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_4 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - 0) / var_141_4

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= 0 + var_141_4 and arg_138_1.time_ < 0 + var_141_4 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play324541035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 324541035
		arg_142_1.duration_ = 5

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play324541036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			local var_145_0 = 1.35

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, false)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_1 = arg_142_1:FormatText(arg_142_1:GetWordFromCfg(324541035).content)

				arg_142_1.text_.text = var_145_1

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_3 = 54 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 54)

				if (54 <= 0 and var_145_0 or var_145_0 * (utf8.len(var_145_1) / 54)) > 0 and var_145_0 < var_145_3 then
					arg_142_1.talkMaxDuration = var_145_3

					if var_145_3 + 0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_3 + 0
					end
				end

				arg_142_1.text_.text = var_145_1
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)
				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_4 = math.max(var_145_0, arg_142_1.talkMaxDuration)

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_4 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - 0) / var_145_4

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= 0 + var_145_4 and arg_142_1.time_ < 0 + var_145_4 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play324541036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 324541036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play324541037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			local var_149_0 = 1.675

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, false)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_1 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(324541036).content)

				arg_146_1.text_.text = var_149_1

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_3 = 67 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 67)

				if (67 <= 0 and var_149_0 or var_149_0 * (utf8.len(var_149_1) / 67)) > 0 and var_149_0 < var_149_3 then
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
	Play324541037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 324541037
		arg_150_1.duration_ = 5

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play324541038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			local var_153_0 = 1.3

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, false)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_1 = arg_150_1:FormatText(arg_150_1:GetWordFromCfg(324541037).content)

				arg_150_1.text_.text = var_153_1

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_3 = 52 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 52)

				if (52 <= 0 and var_153_0 or var_153_0 * (utf8.len(var_153_1) / 52)) > 0 and var_153_0 < var_153_3 then
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
	Play324541038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 324541038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play324541039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			local var_157_0 = 0.225

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, true)
				arg_154_1.iconController_:SetSelectedState("hero")

				arg_154_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_154_1.callingController_:SetSelectedState("normal")

				arg_154_1.keyicon_.color = Color.New(1, 1, 1)
				arg_154_1.icon_.color = Color.New(1, 1, 1)

				local var_157_1 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(324541038).content)

				arg_154_1.text_.text = var_157_1

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_3 = 9 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 9)

				if (9 <= 0 and var_157_0 or var_157_0 * (utf8.len(var_157_1) / 9)) > 0 and var_157_0 < var_157_3 then
					arg_154_1.talkMaxDuration = var_157_3

					if var_157_3 + 0 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_3 + 0
					end
				end

				arg_154_1.text_.text = var_157_1
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)
				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_4 = math.max(var_157_0, arg_154_1.talkMaxDuration)

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_4 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - 0) / var_157_4

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= 0 + var_157_4 and arg_154_1.time_ < 0 + var_157_4 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play324541039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 324541039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play324541040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 0.85

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, false)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(324541039).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 34 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 34)

				if (34 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 34)) > 0 and var_161_0 < var_161_3 then
					arg_158_1.talkMaxDuration = var_161_3

					if var_161_3 + 0 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_3 + 0
					end
				end

				arg_158_1.text_.text = var_161_1
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)
				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_4 = math.max(var_161_0, arg_158_1.talkMaxDuration)

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_4 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - 0) / var_161_4

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= 0 + var_161_4 and arg_158_1.time_ < 0 + var_161_4 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {}

		arg_158_1:InitPlayNodeList()
	end,
	Play324541040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 324541040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play324541041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			local var_165_0 = 1.05

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_1 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(324541040).content)

				arg_162_1.text_.text = var_165_1

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_3 = 42 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 42)

				if (42 <= 0 and var_165_0 or var_165_0 * (utf8.len(var_165_1) / 42)) > 0 and var_165_0 < var_165_3 then
					arg_162_1.talkMaxDuration = var_165_3

					if var_165_3 + 0 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_3 + 0
					end
				end

				arg_162_1.text_.text = var_165_1
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_4 = math.max(var_165_0, arg_162_1.talkMaxDuration)

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_4 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - 0) / var_165_4

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= 0 + var_165_4 and arg_162_1.time_ < 0 + var_165_4 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play324541041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 324541041
		arg_166_1.duration_ = 3.2

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play324541042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.bgs_.STblack == nil then
				local var_169_0 = Object.Instantiate(arg_166_1.paintGo_)

				var_169_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_169_0.name = "STblack"
				var_169_0.transform.parent = arg_166_1.stage_.transform
				var_169_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.bgs_.STblack = var_169_0
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				local var_169_1 = arg_166_1.bgs_.STblack

				arg_166_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_2 = var_169_1:GetComponent("SpriteRenderer")

				if var_169_2 and var_169_2.sprite then
					local var_169_3 = 2 * (var_169_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_1.transform.localScale = Vector3.New(var_169_3 / var_169_2.sprite.bounds.size.y < var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x and var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x or var_169_3 / var_169_2.sprite.bounds.size.y, var_169_3 / var_169_2.sprite.bounds.size.y < var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x and var_169_3 * manager.ui.mainCameraCom_.aspect / var_169_2.sprite.bounds.size.x or var_169_3 / var_169_2.sprite.bounds.size.y, 0)
				end

				for iter_169_0, iter_169_1 in pairs(arg_166_1.bgs_) do
					if iter_169_0 ~= "STblack" then
						iter_169_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.9 < arg_166_1.time_ and arg_166_1.time_ <= 0.9 + arg_169_0 then
				local var_169_4 = arg_166_1.bgs_.J25f

				arg_166_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_169_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_169_5 = var_169_4:GetComponent("SpriteRenderer")

				if var_169_5 and var_169_5.sprite then
					local var_169_6 = 2 * (var_169_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_169_4.transform.localScale = Vector3.New(var_169_6 / var_169_5.sprite.bounds.size.y < var_169_6 * manager.ui.mainCameraCom_.aspect / var_169_5.sprite.bounds.size.x and var_169_6 * manager.ui.mainCameraCom_.aspect / var_169_5.sprite.bounds.size.x or var_169_6 / var_169_5.sprite.bounds.size.y, var_169_6 / var_169_5.sprite.bounds.size.y < var_169_6 * manager.ui.mainCameraCom_.aspect / var_169_5.sprite.bounds.size.x and var_169_6 * manager.ui.mainCameraCom_.aspect / var_169_5.sprite.bounds.size.x or var_169_6 / var_169_5.sprite.bounds.size.y, 0)
				end

				for iter_169_2, iter_169_3 in pairs(arg_166_1.bgs_) do
					if iter_169_2 ~= "J25f" then
						iter_169_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_169_7 = 2

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= var_169_7 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_7 + 0.3 and arg_166_1.time_ < var_169_7 + 0.3 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end

			local var_169_8 = 0.8

			if 0.8 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.mask_.enabled = true
				arg_166_1.mask_.raycastTarget = true

				arg_166_1:SetGaussion(false)
			end

			local var_169_9 = 0.5

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_9 then
				local var_169_10 = Color.New(1, 1, 1)

				var_169_10.a = Mathf.Lerp(1, 0, (arg_166_1.time_ - var_169_8) / var_169_9)
				arg_166_1.mask_.color = var_169_10
			end

			if arg_166_1.time_ >= var_169_8 + var_169_9 and arg_166_1.time_ < var_169_8 + var_169_9 + arg_169_0 then
				local var_169_11 = Color.New(1, 1, 1)

				arg_166_1.mask_.enabled = false
				var_169_11.a = 0
				arg_166_1.mask_.color = var_169_11
			end

			local var_169_12 = "1037ui_story"

			if arg_166_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_169_13 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_166_1.stage_.transform)

				var_169_13.name = var_169_12
				var_169_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_[var_169_12] = var_169_13

				local var_169_14 = var_169_13:GetComponentInChildren(typeof(CharacterEffect))

				var_169_14.enabled = true

				local var_169_15 = GameObjectTools.GetOrAddComponent(var_169_13, typeof(DynamicBoneHelper))

				if var_169_15 then
					var_169_15:EnableDynamicBone(false)
				end

				arg_166_1:ShowWeapon(var_169_14.transform, false)

				arg_166_1.var_[var_169_12 .. "Animator"] = var_169_14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_166_1.var_[var_169_12 .. "Animator"].applyRootMotion = true
				arg_166_1.var_[var_169_12 .. "LipSync"] = var_169_14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_169_16 = arg_166_1.actors_["1037ui_story"]

			if 2 < arg_166_1.time_ and arg_166_1.time_ <= 2 + arg_169_0 and not isNil(var_169_16) and arg_166_1.var_.characterEffect1037ui_story == nil then
				arg_166_1.var_.characterEffect1037ui_story = var_169_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_17 = 0.200000002980232

			if 2 <= arg_166_1.time_ and arg_166_1.time_ < 2 + var_169_17 and not isNil(var_169_16) then
				if arg_166_1.var_.characterEffect1037ui_story and not isNil(var_169_16) then
					arg_166_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 2 + var_169_17 and arg_166_1.time_ < 2 + var_169_17 + arg_169_0 and not isNil(var_169_16) and arg_166_1.var_.characterEffect1037ui_story then
				arg_166_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0.0333333333333333 < arg_166_1.time_ and arg_166_1.time_ <= 0.0333333333333333 + arg_169_0 then
				arg_166_1.fswbg_:SetActive(true)
				arg_166_1.dialog_:SetActive(false)

				arg_166_1.fswtw_.percent = 0
				arg_166_1.fswt_.text = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(102).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.fswt_)

				arg_166_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_166_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_166_1.fswtw_:SetDirty()

				arg_166_1.typewritterCharCountI18N = 0

				SetActive(arg_166_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_166_1:ShowNextGo(false)
			end

			local var_169_19 = 0.266666666666667

			if 0.266666666666667 < arg_166_1.time_ and arg_166_1.time_ <= var_169_19 + arg_169_0 then
				arg_166_1.var_.oldValueTypewriter = arg_166_1.fswtw_.percent

				SetActive(arg_166_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_166_1:ShowNextGo(false)
			end

			local var_169_20 = 0
			local var_169_21 = 0.233333333333333
			local var_169_22, var_169_23 = arg_166_1:GetPercentByPara(arg_166_1:FormatText(arg_166_1:GetWordFromCfg(102).content), 1)

			if var_169_19 < arg_166_1.time_ and arg_166_1.time_ <= var_169_19 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0

				local var_169_24 = var_169_20 <= 0 and var_169_21 or var_169_21 * ((var_169_23 - arg_166_1.typewritterCharCountI18N) / var_169_20)

				if (var_169_20 <= 0 and var_169_21 or var_169_21 * ((var_169_23 - arg_166_1.typewritterCharCountI18N) / var_169_20)) > 0 and var_169_21 < var_169_24 then
					arg_166_1.talkMaxDuration = var_169_24

					if var_169_24 + var_169_19 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_24 + var_169_19
					end
				end
			end

			local var_169_25 = math.max(0.233333333333333, arg_166_1.talkMaxDuration)

			if var_169_19 <= arg_166_1.time_ and arg_166_1.time_ < var_169_19 + var_169_25 then
				arg_166_1.fswtw_.percent = Mathf.Lerp(arg_166_1.var_.oldValueTypewriter, var_169_22, (arg_166_1.time_ - var_169_19) / var_169_25)
				arg_166_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_166_1.fswtw_:SetDirty()
			end

			if arg_166_1.time_ >= var_169_19 + var_169_25 and arg_166_1.time_ < var_169_19 + var_169_25 + arg_169_0 then
				arg_166_1.fswtw_.percent = var_169_22

				arg_166_1.fswtw_:SetDirty()
				arg_166_1:ShowNextGo(true)

				arg_166_1.typewritterCharCountI18N = var_169_23
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.cswbg_:SetActive(true)

				local var_169_26 = arg_166_1.cswt_:GetComponent("RectTransform")

				arg_166_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_169_26.offsetMin = Vector2.New(400, 300)
				var_169_26.offsetMax = Vector2.New(-400, -200)
				arg_166_1.cswt_.text = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(419180).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.cswt_)

				arg_166_1.cswt_.fontSize = 108
				arg_166_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_166_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_166_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.9 < arg_166_1.time_ and arg_166_1.time_ <= 0.9 + arg_169_0 then
				arg_166_1.cswbg_:SetActive(false)
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:AudioAction("play", "music", "ui_skip", "ui_bgm_33", "ui_skip.awb")

				local var_169_29 = manager.audio:GetAudioName("ui_skip", "ui_bgm_33")

				if "" ~= "" then
					if arg_166_1.bgmTxt_.text ~= var_169_29 and arg_166_1.bgmTxt_.text ~= "" then
						if arg_166_1.bgmTxt2_.text ~= "" then
							arg_166_1.bgmTxt_.text = arg_166_1.bgmTxt2_.text
						end

						arg_166_1.bgmTxt2_.text = var_169_29

						arg_166_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_166_1.bgmTxt_.text = var_169_29
						arg_166_1.bgmTxt2_.text = var_169_29
					end

					if arg_166_1.bgmTimer then
						arg_166_1.bgmTimer:Stop()

						arg_166_1.bgmTimer = nil
					end

					if arg_166_1.settingData.show_music_name == 1 then
						arg_166_1.musicController:SetSelectedState("show")
						arg_166_1.musicAnimator_:Play("open", 0, 0)

						if arg_166_1.settingData.music_time ~= 0 then
							arg_166_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_166_1.settingData.music_time), function()
								if arg_166_1 == nil or isNil(arg_166_1.bgmTxt_) then
									return
								end

								arg_166_1.musicController:SetSelectedState("hide")
								arg_166_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_169_30 = 1.3
			local var_169_31 = manager.audio:GetVoiceLength("story_v_out_324541", "324541041", "0") / 1000

			if var_169_31 > 0 and 1.9 < var_169_31 and var_169_31 + var_169_30 > arg_166_1.duration_ then
				arg_166_1.duration_ = var_169_31 + var_169_30
			end

			if var_169_30 < arg_166_1.time_ and arg_166_1.time_ <= var_169_30 + arg_169_0 then
				arg_166_1:AudioAction("play", "voice", "story_v_out_324541", "324541041", "0")
			end

			local var_169_33 = 0

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_33 + arg_169_0 then
				arg_166_1.allBtn_.enabled = false
			end

			if arg_166_1.time_ >= var_169_33 + 2.83333333333333 and arg_166_1.time_ < var_169_33 + 2.83333333333333 + arg_169_0 then
				arg_166_1.allBtn_.enabled = true
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play324541042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 324541042
		arg_171_1.duration_ = 1

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"

			SetActive(arg_171_1.choicesGo_, true)

			for iter_172_0, iter_172_1 in ipairs(arg_171_1.choices_) do
				SetActive(iter_172_1.go, iter_172_0 <= 3)
			end

			arg_171_1.choices_[1].txt.text = arg_171_1:FormatText(StoryChoiceCfg[1621].name)
			arg_171_1.choices_[2].txt.text = arg_171_1:FormatText(StoryChoiceCfg[1622].name)
			arg_171_1.choices_[3].txt.text = arg_171_1:FormatText(StoryChoiceCfg[1623].name)
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play324541043(arg_171_1)
			end

			if arg_173_0 == 2 then
				arg_171_0:Play324541043(arg_171_1)
			end

			if arg_173_0 == 3 then
				arg_171_0:Play324541043(arg_171_1)
			end

			arg_171_1:RecordChoiceLog(324541042, 1621, 1622, 1623)
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["1037ui_story"]) and arg_171_1.var_.characterEffect1037ui_story == nil then
				arg_171_1.var_.characterEffect1037ui_story = arg_171_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["1037ui_story"]) then
				if arg_171_1.var_.characterEffect1037ui_story and not isNil(arg_171_1.actors_["1037ui_story"]) then
					arg_171_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["1037ui_story"]) and arg_171_1.var_.characterEffect1037ui_story then
				arg_171_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play324541043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 324541043
		arg_175_1.duration_ = 2.77

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play324541044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_9000

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["1037ui_story"]) and arg_175_1.var_.characterEffect1037ui_story == nil then
				arg_175_1.var_.characterEffect1037ui_story = arg_175_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["1037ui_story"]) then
				if arg_175_1.var_.characterEffect1037ui_story and not isNil(arg_175_1.actors_["1037ui_story"]) then
					arg_175_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["1037ui_story"]) and arg_175_1.var_.characterEffect1037ui_story then
				arg_175_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(true)

				local var_178_2 = arg_175_1.cswt_:GetComponent("RectTransform")

				arg_175_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_178_2.offsetMin = Vector2.New(400, 300)
				var_178_2.offsetMax = Vector2.New(-400, -200)
				arg_175_1.cswt_.text = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(419181).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.cswt_)

				arg_175_1.cswt_.fontSize = 108
				arg_175_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_175_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_175_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.833333330353101 < arg_175_1.time_ and arg_175_1.time_ <= 0.833333330353101 + arg_178_0 then
				arg_175_1.cswbg_:SetActive(false)
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_3 = arg_175_1.var_.effect32131

				if not arg_175_1.var_.effect32131 then
					var_178_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_178_3.name = "32131"
					arg_175_1.var_.effect32131 = var_178_3
				else
					var_178_3.transform:SetParent(var_178_9000)
				end

				var_178_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_178_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_178_3.transform.localScale = Vector3.New(var_178_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_178_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_178_3.transform.localScale.z)
			end

			if 1.16666666666667 < arg_175_1.time_ and arg_175_1.time_ <= 1.16666666666667 + arg_178_0 then
				if arg_175_1.var_.effect32131 then
					Object.Destroy(arg_175_1.var_.effect32131)

					arg_175_1.var_.effect32131 = nil
				end
			end

			local var_178_6 = 1.16666666666667
			local var_178_7 = manager.audio:GetVoiceLength("story_v_out_324541", "324541043", "0") / 1000

			if var_178_7 > 0 and 1.6 < var_178_7 and var_178_7 + var_178_6 > arg_175_1.duration_ then
				arg_175_1.duration_ = var_178_7 + var_178_6
			end

			if var_178_6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1:AudioAction("play", "voice", "story_v_out_324541", "324541043", "0")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_9 = arg_175_1.bgs_.STblack

				arg_175_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_10 = var_178_9:GetComponent("SpriteRenderer")

				if var_178_10 and var_178_10.sprite then
					local var_178_11 = 2 * (var_178_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_9.transform.localScale = Vector3.New(var_178_11 / var_178_10.sprite.bounds.size.y < var_178_11 * manager.ui.mainCameraCom_.aspect / var_178_10.sprite.bounds.size.x and var_178_11 * manager.ui.mainCameraCom_.aspect / var_178_10.sprite.bounds.size.x or var_178_11 / var_178_10.sprite.bounds.size.y, var_178_11 / var_178_10.sprite.bounds.size.y < var_178_11 * manager.ui.mainCameraCom_.aspect / var_178_10.sprite.bounds.size.x and var_178_11 * manager.ui.mainCameraCom_.aspect / var_178_10.sprite.bounds.size.x or var_178_11 / var_178_10.sprite.bounds.size.y, 0)
				end

				for iter_178_0, iter_178_1 in pairs(arg_175_1.bgs_) do
					if iter_178_0 ~= "STblack" then
						iter_178_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.699999997019768 < arg_175_1.time_ and arg_175_1.time_ <= 0.699999997019768 + arg_178_0 then
				local var_178_12 = arg_175_1.bgs_.J25f

				arg_175_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_178_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_178_13 = var_178_12:GetComponent("SpriteRenderer")

				if var_178_13 and var_178_13.sprite then
					local var_178_14 = 2 * (var_178_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_178_12.transform.localScale = Vector3.New(var_178_14 / var_178_13.sprite.bounds.size.y < var_178_14 * manager.ui.mainCameraCom_.aspect / var_178_13.sprite.bounds.size.x and var_178_14 * manager.ui.mainCameraCom_.aspect / var_178_13.sprite.bounds.size.x or var_178_14 / var_178_13.sprite.bounds.size.y, var_178_14 / var_178_13.sprite.bounds.size.y < var_178_14 * manager.ui.mainCameraCom_.aspect / var_178_13.sprite.bounds.size.x and var_178_14 * manager.ui.mainCameraCom_.aspect / var_178_13.sprite.bounds.size.x or var_178_14 / var_178_13.sprite.bounds.size.y, 0)
				end

				for iter_178_2, iter_178_3 in pairs(arg_175_1.bgs_) do
					if iter_178_2 ~= "J25f" then
						iter_178_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_178_15 = 0.6

			if 0.6 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_16 = 0.566666666666667

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_16 then
				local var_178_17 = Color.New(1, 1, 1)

				var_178_17.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_15) / var_178_16)
				arg_175_1.mask_.color = var_178_17
			end

			if arg_175_1.time_ >= var_178_15 + var_178_16 and arg_175_1.time_ < var_178_15 + var_178_16 + arg_178_0 then
				local var_178_18 = Color.New(1, 1, 1)

				arg_175_1.mask_.enabled = false
				var_178_18.a = 0
				arg_175_1.mask_.color = var_178_18
			end

			local var_178_19 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_19 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_19 + 2.13333333333333 and arg_175_1.time_ < var_178_19 + 2.13333333333333 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play324541044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 324541044
		arg_179_1.duration_ = 1

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"

			SetActive(arg_179_1.choicesGo_, true)

			for iter_180_0, iter_180_1 in ipairs(arg_179_1.choices_) do
				SetActive(iter_180_1.go, iter_180_0 <= 3)
			end

			arg_179_1.choices_[1].txt.text = arg_179_1:FormatText(StoryChoiceCfg[1624].name)
			arg_179_1.choices_[2].txt.text = arg_179_1:FormatText(StoryChoiceCfg[1625].name)
			arg_179_1.choices_[3].txt.text = arg_179_1:FormatText(StoryChoiceCfg[1626].name)
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play324541045(arg_179_1)
			end

			if arg_181_0 == 2 then
				arg_179_0:Play324541045(arg_179_1)
			end

			if arg_181_0 == 3 then
				arg_179_0:Play324541045(arg_179_1)
			end

			arg_179_1:RecordChoiceLog(324541044, 1624, 1625, 1626)
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			return
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play324541045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 324541045
		arg_183_1.duration_ = 2.67

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play324541046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_9000

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1037ui_story"]) and arg_183_1.var_.characterEffect1037ui_story == nil then
				arg_183_1.var_.characterEffect1037ui_story = arg_183_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1037ui_story"]) then
				if arg_183_1.var_.characterEffect1037ui_story and not isNil(arg_183_1.actors_["1037ui_story"]) then
					arg_183_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1037ui_story"]) and arg_183_1.var_.characterEffect1037ui_story then
				arg_183_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.cswbg_:SetActive(true)

				local var_186_2 = arg_183_1.cswt_:GetComponent("RectTransform")

				arg_183_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_186_2.offsetMin = Vector2.New(400, 300)
				var_186_2.offsetMax = Vector2.New(-400, -200)
				arg_183_1.cswt_.text = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(419182).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.cswt_)

				arg_183_1.cswt_.fontSize = 108
				arg_183_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_183_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_183_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.839815799146891 < arg_183_1.time_ and arg_183_1.time_ <= 0.839815799146891 + arg_186_0 then
				arg_183_1.cswbg_:SetActive(false)
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				local var_186_3 = arg_183_1.var_.effect223131

				if not arg_183_1.var_.effect223131 then
					var_186_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_186_3.name = "223131"
					arg_183_1.var_.effect223131 = var_186_3
				else
					var_186_3.transform:SetParent(var_186_9000)
				end

				var_186_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_186_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_186_3.transform.localScale = Vector3.New(var_186_3.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_186_3.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_186_3.transform.localScale.z)
			end

			if 1.16666666666667 < arg_183_1.time_ and arg_183_1.time_ <= 1.16666666666667 + arg_186_0 then
				if arg_183_1.var_.effect223131 then
					Object.Destroy(arg_183_1.var_.effect223131)

					arg_183_1.var_.effect223131 = nil
				end
			end

			local var_186_6 = 0.633333333333333
			local var_186_7 = manager.audio:GetVoiceLength("story_v_out_324541", "324541045", "0") / 1000

			if var_186_7 > 0 and 2.033 < var_186_7 and var_186_7 + var_186_6 > arg_183_1.duration_ then
				arg_183_1.duration_ = var_186_7 + var_186_6
			end

			if var_186_6 < arg_183_1.time_ and arg_183_1.time_ <= var_186_6 + arg_186_0 then
				arg_183_1:AudioAction("play", "voice", "story_v_out_324541", "324541045", "0")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				local var_186_9 = arg_183_1.bgs_.STblack

				arg_183_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_9.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_10 = var_186_9:GetComponent("SpriteRenderer")

				if var_186_10 and var_186_10.sprite then
					local var_186_11 = 2 * (var_186_9.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_9.transform.localScale = Vector3.New(var_186_11 / var_186_10.sprite.bounds.size.y < var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x and var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x or var_186_11 / var_186_10.sprite.bounds.size.y, var_186_11 / var_186_10.sprite.bounds.size.y < var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x and var_186_11 * manager.ui.mainCameraCom_.aspect / var_186_10.sprite.bounds.size.x or var_186_11 / var_186_10.sprite.bounds.size.y, 0)
				end

				for iter_186_0, iter_186_1 in pairs(arg_183_1.bgs_) do
					if iter_186_0 ~= "STblack" then
						iter_186_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0.839815799146891 < arg_183_1.time_ and arg_183_1.time_ <= 0.839815799146891 + arg_186_0 then
				local var_186_12 = arg_183_1.bgs_.J25f

				arg_183_1.bgs_.J25f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_186_12.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_186_13 = var_186_12:GetComponent("SpriteRenderer")

				if var_186_13 and var_186_13.sprite then
					local var_186_14 = 2 * (var_186_12.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_186_12.transform.localScale = Vector3.New(var_186_14 / var_186_13.sprite.bounds.size.y < var_186_14 * manager.ui.mainCameraCom_.aspect / var_186_13.sprite.bounds.size.x and var_186_14 * manager.ui.mainCameraCom_.aspect / var_186_13.sprite.bounds.size.x or var_186_14 / var_186_13.sprite.bounds.size.y, var_186_14 / var_186_13.sprite.bounds.size.y < var_186_14 * manager.ui.mainCameraCom_.aspect / var_186_13.sprite.bounds.size.x and var_186_14 * manager.ui.mainCameraCom_.aspect / var_186_13.sprite.bounds.size.x or var_186_14 / var_186_13.sprite.bounds.size.y, 0)
				end

				for iter_186_2, iter_186_3 in pairs(arg_183_1.bgs_) do
					if iter_186_2 ~= "J25f" then
						iter_186_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_186_15 = 0.633333333333333

			if 0.633333333333333 < arg_183_1.time_ and arg_183_1.time_ <= var_186_15 + arg_186_0 then
				arg_183_1.mask_.enabled = true
				arg_183_1.mask_.raycastTarget = true

				arg_183_1:SetGaussion(false)
			end

			local var_186_16 = 0.8

			if var_186_15 <= arg_183_1.time_ and arg_183_1.time_ < var_186_15 + var_186_16 then
				local var_186_17 = Color.New(1, 1, 1)

				var_186_17.a = Mathf.Lerp(1, 0, (arg_183_1.time_ - var_186_15) / var_186_16)
				arg_183_1.mask_.color = var_186_17
			end

			if arg_183_1.time_ >= var_186_15 + var_186_16 and arg_183_1.time_ < var_186_15 + var_186_16 + arg_186_0 then
				local var_186_18 = Color.New(1, 1, 1)

				arg_183_1.mask_.enabled = false
				var_186_18.a = 0
				arg_183_1.mask_.color = var_186_18
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play324541046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 324541046
		arg_187_1.duration_ = 3.83

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play324541047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_9002
			local var_190_9001
			local var_190_9000

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.cswbg_:SetActive(true)

				local var_190_0 = arg_187_1.cswt_:GetComponent("RectTransform")

				arg_187_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_190_0.offsetMin = Vector2.New(400, 300)
				var_190_0.offsetMax = Vector2.New(-400, -200)
				arg_187_1.cswt_.text = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(419183).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.cswt_)

				arg_187_1.cswt_.fontSize = 108
				arg_187_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_187_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_187_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				local var_190_1 = arg_187_1.var_.effect321313

				if not arg_187_1.var_.effect321313 then
					var_190_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_190_1.name = "321313"
					arg_187_1.var_.effect321313 = var_190_1
				else
					var_190_1.transform:SetParent(var_190_9002)
				end

				var_190_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_190_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_190_1.transform.localScale = Vector3.New(var_190_1.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_190_1.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_190_1.transform.localScale.z)
			end

			if 2.06666666666667 < arg_187_1.time_ and arg_187_1.time_ <= 2.06666666666667 + arg_190_0 then
				if arg_187_1.var_.effect321313 then
					Object.Destroy(arg_187_1.var_.effect321313)

					arg_187_1.var_.effect321313 = nil
				end
			end

			if 0.266666666666667 < arg_187_1.time_ and arg_187_1.time_ <= 0.266666666666667 + arg_190_0 then
				local var_190_4 = arg_187_1.var_.effect321314

				if not arg_187_1.var_.effect321314 then
					var_190_4 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_190_4.name = "321314"
					arg_187_1.var_.effect321314 = var_190_4
				else
					var_190_4.transform:SetParent(var_190_9001)
				end

				var_190_4.transform.localPosition = Vector3.New(0, 0, 18.4)
				var_190_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_190_4.transform.localScale = Vector3.New(var_190_4.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_190_4.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_190_4.transform.localScale.z)
			end

			if 2.33333333333333 < arg_187_1.time_ and arg_187_1.time_ <= 2.33333333333333 + arg_190_0 then
				if arg_187_1.var_.effect321314 then
					Object.Destroy(arg_187_1.var_.effect321314)

					arg_187_1.var_.effect321314 = nil
				end
			end

			if 0.599999999998666 < arg_187_1.time_ and arg_187_1.time_ <= 0.599999999998666 + arg_190_0 then
				local var_190_7 = arg_187_1.var_.effect321315

				if not arg_187_1.var_.effect321315 then
					var_190_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_190_7.name = "321315"
					arg_187_1.var_.effect321315 = var_190_7
				else
					var_190_7.transform:SetParent(var_190_9000)
				end

				var_190_7.transform.localPosition = Vector3.New(0, 0.23, 0.31)
				var_190_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_190_7.transform.localScale = Vector3.New(var_190_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_190_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_190_7.transform.localScale.z)
			end

			if 2.66666666666667 < arg_187_1.time_ and arg_187_1.time_ <= 2.66666666666667 + arg_190_0 then
				if arg_187_1.var_.effect321315 then
					Object.Destroy(arg_187_1.var_.effect321315)

					arg_187_1.var_.effect321315 = nil
				end
			end

			local var_190_10 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_10 + 0.599999999998666 and arg_187_1.time_ < var_190_10 + 0.599999999998666 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_11 = 0
			local var_190_12 = manager.audio:GetVoiceLength("story_v_out_324541", "324541046", "0") / 1000

			if var_190_12 > 0 and 1 < var_190_12 and var_190_12 + var_190_11 > arg_187_1.duration_ then
				arg_187_1.duration_ = var_190_12 + var_190_11
			end

			if var_190_11 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1:AudioAction("play", "voice", "story_v_out_324541", "324541046", "0")
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play324541047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 324541047
		arg_191_1.duration_ = 2.8

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play324541048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0.466666666666667 < arg_191_1.time_ and arg_191_1.time_ <= 0.466666666666667 + arg_194_0 then
				local var_194_0 = arg_191_1.var_.effect32131

				if not arg_191_1.var_.effect32131 then
					var_194_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_194_0.name = "32131"
					arg_191_1.var_.effect32131 = var_194_0
				else
					var_194_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_194_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_194_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_194_0.transform.localScale = Vector3.New(var_194_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_194_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_194_0.transform.localScale.z)
			end

			if 1.63333333333333 < arg_191_1.time_ and arg_191_1.time_ <= 1.63333333333333 + arg_194_0 then
				if arg_191_1.var_.effect32131 then
					Object.Destroy(arg_191_1.var_.effect32131)

					arg_191_1.var_.effect32131 = nil
				end
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.cswbg_:SetActive(true)

				local var_194_3 = arg_191_1.cswt_:GetComponent("RectTransform")

				arg_191_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_194_3.offsetMin = Vector2.New(400, 300)
				var_194_3.offsetMax = Vector2.New(-400, -200)
				arg_191_1.cswt_.text = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(419184).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.cswt_)

				arg_191_1.cswt_.fontSize = 108
				arg_191_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_191_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_191_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.0333333333333333 < arg_191_1.time_ and arg_191_1.time_ <= 0.0333333333333333 + arg_194_0 then
				arg_191_1.fswbg_:SetActive(true)
				arg_191_1.dialog_:SetActive(false)

				arg_191_1.fswtw_.percent = 0
				arg_191_1.fswt_.text = arg_191_1:FormatText(arg_191_1:GetWordFromCfg(324541047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.fswt_)

				arg_191_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_191_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_191_1.fswtw_:SetDirty()

				arg_191_1.typewritterCharCountI18N = 0

				SetActive(arg_191_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_191_1:ShowNextGo(false)
			end

			local var_194_4 = 0.266666666666667

			if 0.266666666666667 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.var_.oldValueTypewriter = arg_191_1.fswtw_.percent

				SetActive(arg_191_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_191_1:ShowNextGo(false)
			end

			local var_194_5 = 12
			local var_194_6 = 0.8
			local var_194_7, var_194_8 = arg_191_1:GetPercentByPara(arg_191_1:FormatText(arg_191_1:GetWordFromCfg(324541047).content), 1)

			if var_194_4 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0

				local var_194_9 = var_194_5 <= 0 and var_194_6 or var_194_6 * ((var_194_8 - arg_191_1.typewritterCharCountI18N) / var_194_5)

				if (var_194_5 <= 0 and var_194_6 or var_194_6 * ((var_194_8 - arg_191_1.typewritterCharCountI18N) / var_194_5)) > 0 and var_194_6 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end
			end

			local var_194_10 = math.max(0.8, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_10 then
				arg_191_1.fswtw_.percent = Mathf.Lerp(arg_191_1.var_.oldValueTypewriter, var_194_7, (arg_191_1.time_ - var_194_4) / var_194_10)
				arg_191_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_191_1.fswtw_:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_10 and arg_191_1.time_ < var_194_4 + var_194_10 + arg_194_0 then
				arg_191_1.fswtw_.percent = var_194_7

				arg_191_1.fswtw_:SetDirty()
				arg_191_1:ShowNextGo(true)

				arg_191_1.typewritterCharCountI18N = var_194_8
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				local var_194_11 = arg_191_1.fswbg_.transform:Find("textbox/adapt/content") or arg_191_1.fswbg_.transform:Find("textbox/content")
				local var_194_12 = arg_191_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_194_13 = var_194_11:GetComponent("RectTransform")

				var_194_11:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_194_13.offsetMin = Vector2.New(0, 0)
				var_194_13.offsetMax = Vector2.New(0, 0)
			end

			local var_194_14 = 0.466666666666667
			local var_194_15 = manager.audio:GetVoiceLength("story_v_out_324541", "324541047", "0") / 1000

			if var_194_15 > 0 and 1.8 < var_194_15 and var_194_15 + var_194_14 > arg_191_1.duration_ then
				arg_191_1.duration_ = var_194_15 + var_194_14
			end

			if var_194_14 < arg_191_1.time_ and arg_191_1.time_ <= var_194_14 + arg_194_0 then
				arg_191_1:AudioAction("play", "voice", "story_v_out_324541", "324541047", "0")
			end

			local var_194_17 = 0.266666666666667

			if 0.266666666666667 < arg_191_1.time_ and arg_191_1.time_ <= var_194_17 + arg_194_0 then
				arg_191_1.mask_.enabled = true
				arg_191_1.mask_.raycastTarget = true

				arg_191_1:SetGaussion(false)
			end

			local var_194_18 = 0.2

			if var_194_17 <= arg_191_1.time_ and arg_191_1.time_ < var_194_17 + var_194_18 then
				local var_194_19 = Color.New(1, 1, 1)

				var_194_19.a = Mathf.Lerp(1, 0, (arg_191_1.time_ - var_194_17) / var_194_18)
				arg_191_1.mask_.color = var_194_19
			end

			if arg_191_1.time_ >= var_194_17 + var_194_18 and arg_191_1.time_ < var_194_17 + var_194_18 + arg_194_0 then
				local var_194_20 = Color.New(1, 1, 1)

				arg_191_1.mask_.enabled = false
				var_194_20.a = 0
				arg_191_1.mask_.color = var_194_20
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				local var_194_21 = arg_191_1.bgs_.STblack

				arg_191_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_194_21.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_194_22 = var_194_21:GetComponent("SpriteRenderer")

				if var_194_22 and var_194_22.sprite then
					local var_194_23 = 2 * (var_194_21.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_194_21.transform.localScale = Vector3.New(var_194_23 / var_194_22.sprite.bounds.size.y < var_194_23 * manager.ui.mainCameraCom_.aspect / var_194_22.sprite.bounds.size.x and var_194_23 * manager.ui.mainCameraCom_.aspect / var_194_22.sprite.bounds.size.x or var_194_23 / var_194_22.sprite.bounds.size.y, var_194_23 / var_194_22.sprite.bounds.size.y < var_194_23 * manager.ui.mainCameraCom_.aspect / var_194_22.sprite.bounds.size.x and var_194_23 * manager.ui.mainCameraCom_.aspect / var_194_22.sprite.bounds.size.x or var_194_23 / var_194_22.sprite.bounds.size.y, 0)
				end

				for iter_194_0, iter_194_1 in pairs(arg_191_1.bgs_) do
					if iter_194_0 ~= "STblack" then
						iter_194_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_194_24 = 0
			local var_194_25 = manager.audio:GetVoiceLength("story_v_out_324541", "324541047", "0") / 1000

			if var_194_25 > 0 and 2.63333333333333 < var_194_25 and var_194_25 + var_194_24 > arg_191_1.duration_ then
				arg_191_1.duration_ = var_194_25 + var_194_24
			end

			if var_194_24 < arg_191_1.time_ and arg_191_1.time_ <= var_194_24 + arg_194_0 then
				arg_191_1:AudioAction("play", "voice", "story_v_out_324541", "324541047", "0")
			end
		end

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play324541048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 324541048
		arg_195_1.duration_ = 1

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"

			SetActive(arg_195_1.choicesGo_, true)

			for iter_196_0, iter_196_1 in ipairs(arg_195_1.choices_) do
				SetActive(iter_196_1.go, iter_196_0 <= 3)
			end

			arg_195_1.choices_[1].txt.text = arg_195_1:FormatText(StoryChoiceCfg[1627].name)
			arg_195_1.choices_[2].txt.text = arg_195_1:FormatText(StoryChoiceCfg[1628].name)
			arg_195_1.choices_[3].txt.text = arg_195_1:FormatText(StoryChoiceCfg[1629].name)
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play324541049(arg_195_1)
			end

			if arg_197_0 == 2 then
				arg_195_0:Play324541049(arg_195_1)
			end

			if arg_197_0 == 3 then
				arg_195_0:Play324541049(arg_195_1)
			end

			arg_195_1:RecordChoiceLog(324541048, 1627, 1628, 1629)
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1037ui_story"]) and arg_195_1.var_.characterEffect1037ui_story == nil then
				arg_195_1.var_.characterEffect1037ui_story = arg_195_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1037ui_story"]) then
				if arg_195_1.var_.characterEffect1037ui_story and not isNil(arg_195_1.actors_["1037ui_story"]) then
					arg_195_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1037ui_story"]) and arg_195_1.var_.characterEffect1037ui_story then
				arg_195_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play324541049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 324541049
		arg_199_1.duration_ = 1.07

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play324541050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0.0333333333333333 < arg_199_1.time_ and arg_199_1.time_ <= 0.0333333333333333 + arg_202_0 then
				arg_199_1.fswbg_:SetActive(true)
				arg_199_1.dialog_:SetActive(false)

				arg_199_1.fswtw_.percent = 0
				arg_199_1.fswt_.text = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(324541047).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.fswt_)

				arg_199_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_199_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_199_1.fswtw_:SetDirty()

				arg_199_1.typewritterCharCountI18N = 0

				SetActive(arg_199_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_199_1:ShowNextGo(false)
			end

			local var_202_0 = 0.266666666666667

			if 0.266666666666667 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.var_.oldValueTypewriter = arg_199_1.fswtw_.percent

				SetActive(arg_199_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_199_1:ShowNextGo(false)
			end

			local var_202_1 = 12
			local var_202_2 = 0.8
			local var_202_3, var_202_4 = arg_199_1:GetPercentByPara(arg_199_1:FormatText(arg_199_1:GetWordFromCfg(324541047).content), 1)

			if var_202_0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0

				local var_202_5 = var_202_1 <= 0 and var_202_2 or var_202_2 * ((var_202_4 - arg_199_1.typewritterCharCountI18N) / var_202_1)

				if (var_202_1 <= 0 and var_202_2 or var_202_2 * ((var_202_4 - arg_199_1.typewritterCharCountI18N) / var_202_1)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_0
					end
				end
			end

			local var_202_6 = math.max(0.8, arg_199_1.talkMaxDuration)

			if var_202_0 <= arg_199_1.time_ and arg_199_1.time_ < var_202_0 + var_202_6 then
				arg_199_1.fswtw_.percent = Mathf.Lerp(arg_199_1.var_.oldValueTypewriter, var_202_3, (arg_199_1.time_ - var_202_0) / var_202_6)
				arg_199_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_199_1.fswtw_:SetDirty()
			end

			if arg_199_1.time_ >= var_202_0 + var_202_6 and arg_199_1.time_ < var_202_0 + var_202_6 + arg_202_0 then
				arg_199_1.fswtw_.percent = var_202_3

				arg_199_1.fswtw_:SetDirty()
				arg_199_1:ShowNextGo(true)

				arg_199_1.typewritterCharCountI18N = var_202_4
			end

			local var_202_7 = 0

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_8 = 0.433333333333333

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 then
				local var_202_9 = Color.New(1, 1, 1)

				var_202_9.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_7) / var_202_8)
				arg_199_1.mask_.color = var_202_9
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 then
				local var_202_10 = Color.New(1, 1, 1)

				arg_199_1.mask_.enabled = false
				var_202_10.a = 0
				arg_199_1.mask_.color = var_202_10
			end

			local var_202_11 = 0.433333333333333

			if 0.433333333333333 < arg_199_1.time_ and arg_199_1.time_ <= var_202_11 + arg_202_0 then
				arg_199_1.mask_.enabled = true
				arg_199_1.mask_.raycastTarget = true

				arg_199_1:SetGaussion(false)
			end

			local var_202_12 = 0.433333333333333

			if var_202_11 <= arg_199_1.time_ and arg_199_1.time_ < var_202_11 + var_202_12 then
				local var_202_13 = Color.New(1, 1, 1)

				var_202_13.a = Mathf.Lerp(1, 0, (arg_199_1.time_ - var_202_11) / var_202_12)
				arg_199_1.mask_.color = var_202_13
			end

			if arg_199_1.time_ >= var_202_11 + var_202_12 and arg_199_1.time_ < var_202_11 + var_202_12 + arg_202_0 then
				local var_202_14 = Color.New(1, 1, 1)

				arg_199_1.mask_.enabled = false
				var_202_14.a = 0
				arg_199_1.mask_.color = var_202_14
			end

			local var_202_15 = 0
			local var_202_16 = manager.audio:GetVoiceLength("story_v_out_324541", "324541049", "0") / 1000

			if var_202_16 > 0 and 1 < var_202_16 and var_202_16 + var_202_15 > arg_199_1.duration_ then
				arg_199_1.duration_ = var_202_16 + var_202_15
			end

			if var_202_15 < arg_199_1.time_ and arg_199_1.time_ <= var_202_15 + arg_202_0 then
				arg_199_1:AudioAction("play", "voice", "story_v_out_324541", "324541049", "0")
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play324541050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 324541050
		arg_203_1.duration_ = 1.1

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play324541051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.fswbg_:SetActive(true)
				arg_203_1.dialog_:SetActive(false)

				arg_203_1.fswtw_.percent = 0
				arg_203_1.fswt_.text = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(324541050).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.fswt_)

				arg_203_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_203_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_203_1.fswtw_:SetDirty()

				arg_203_1.typewritterCharCountI18N = 0

				SetActive(arg_203_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_203_1:ShowNextGo(false)
			end

			local var_206_0 = 0.266666666666667

			if 0.266666666666667 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.var_.oldValueTypewriter = arg_203_1.fswtw_.percent

				SetActive(arg_203_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_203_1:ShowNextGo(false)
			end

			local var_206_1 = 0
			local var_206_2 = 0.233333333333333
			local var_206_3, var_206_4 = arg_203_1:GetPercentByPara(arg_203_1:FormatText(arg_203_1:GetWordFromCfg(324541050).content), 1)

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0

				local var_206_5 = var_206_1 <= 0 and var_206_2 or var_206_2 * ((var_206_4 - arg_203_1.typewritterCharCountI18N) / var_206_1)

				if (var_206_1 <= 0 and var_206_2 or var_206_2 * ((var_206_4 - arg_203_1.typewritterCharCountI18N) / var_206_1)) > 0 and var_206_2 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end
			end

			local var_206_6 = math.max(0.233333333333333, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_6 then
				arg_203_1.fswtw_.percent = Mathf.Lerp(arg_203_1.var_.oldValueTypewriter, var_206_3, (arg_203_1.time_ - var_206_0) / var_206_6)
				arg_203_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_203_1.fswtw_:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_6 and arg_203_1.time_ < var_206_0 + var_206_6 + arg_206_0 then
				arg_203_1.fswtw_.percent = var_206_3

				arg_203_1.fswtw_:SetDirty()
				arg_203_1:ShowNextGo(true)

				arg_203_1.typewritterCharCountI18N = var_206_4
			end

			local var_206_7 = 0

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_7 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_8 = 0.433333333333333

			if var_206_7 <= arg_203_1.time_ and arg_203_1.time_ < var_206_7 + var_206_8 then
				local var_206_9 = Color.New(1, 1, 1)

				var_206_9.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_7) / var_206_8)
				arg_203_1.mask_.color = var_206_9
			end

			if arg_203_1.time_ >= var_206_7 + var_206_8 and arg_203_1.time_ < var_206_7 + var_206_8 + arg_206_0 then
				local var_206_10 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_10.a = 0
				arg_203_1.mask_.color = var_206_10
			end

			local var_206_11 = 0.433333333333333

			if 0.433333333333333 < arg_203_1.time_ and arg_203_1.time_ <= var_206_11 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_12 = 0.433333333333333

			if var_206_11 <= arg_203_1.time_ and arg_203_1.time_ < var_206_11 + var_206_12 then
				local var_206_13 = Color.New(1, 1, 1)

				var_206_13.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_11) / var_206_12)
				arg_203_1.mask_.color = var_206_13
			end

			if arg_203_1.time_ >= var_206_11 + var_206_12 and arg_203_1.time_ < var_206_11 + var_206_12 + arg_206_0 then
				local var_206_14 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_14.a = 0
				arg_203_1.mask_.color = var_206_14
			end

			local var_206_15 = 0.666666666666667

			if 0.666666666666667 < arg_203_1.time_ and arg_203_1.time_ <= var_206_15 + arg_206_0 then
				arg_203_1.mask_.enabled = true
				arg_203_1.mask_.raycastTarget = true

				arg_203_1:SetGaussion(false)
			end

			local var_206_16 = 0.433333333333333

			if var_206_15 <= arg_203_1.time_ and arg_203_1.time_ < var_206_15 + var_206_16 then
				local var_206_17 = Color.New(1, 1, 1)

				var_206_17.a = Mathf.Lerp(1, 0, (arg_203_1.time_ - var_206_15) / var_206_16)
				arg_203_1.mask_.color = var_206_17
			end

			if arg_203_1.time_ >= var_206_15 + var_206_16 and arg_203_1.time_ < var_206_15 + var_206_16 + arg_206_0 then
				local var_206_18 = Color.New(1, 1, 1)

				arg_203_1.mask_.enabled = false
				var_206_18.a = 0
				arg_203_1.mask_.color = var_206_18
			end

			if 0.1 < arg_203_1.time_ and arg_203_1.time_ <= 0.1 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_side_1095", "se_story_side_1095_amb_beach_night", "")
			end

			if 0.1 < arg_203_1.time_ and arg_203_1.time_ <= 0.1 + arg_206_0 then
				arg_203_1:AudioAction("play", "effect", "se_story_150", "se_story_150_beach_down", "")
			end

			local var_206_21 = 0
			local var_206_22 = manager.audio:GetVoiceLength("story_v_out_324541", "324541050", "0") / 1000

			if var_206_22 > 0 and 1 < var_206_22 and var_206_22 + var_206_21 > arg_203_1.duration_ then
				arg_203_1.duration_ = var_206_22 + var_206_21
			end

			if var_206_21 < arg_203_1.time_ and arg_203_1.time_ <= var_206_21 + arg_206_0 then
				arg_203_1:AudioAction("play", "voice", "story_v_out_324541", "324541050", "0")
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play324541051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 324541051
		arg_207_1.duration_ = 7.2

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play324541052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_9000

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1037ui_story"]) and arg_207_1.var_.characterEffect1037ui_story == nil then
				arg_207_1.var_.characterEffect1037ui_story = arg_207_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1037ui_story"]) then
				if arg_207_1.var_.characterEffect1037ui_story and not isNil(arg_207_1.actors_["1037ui_story"]) then
					arg_207_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1037ui_story"]) and arg_207_1.var_.characterEffect1037ui_story then
				arg_207_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			if 0.0333333333333333 < arg_207_1.time_ and arg_207_1.time_ <= 0.0333333333333333 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(false)
				arg_207_1.dialog_:SetActive(false)
				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			if 0.266666666666667 < arg_207_1.time_ and arg_207_1.time_ <= 0.266666666666667 + arg_210_0 then
				arg_207_1.fswbg_:SetActive(false)
				arg_207_1.dialog_:SetActive(false)
				SetActive(arg_207_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_207_1:ShowNextGo(false)
			end

			local var_210_1 = 0

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.allBtn_.enabled = false
			end

			if arg_207_1.time_ >= var_210_1 + 2.2 and arg_207_1.time_ < var_210_1 + 2.2 + arg_210_0 then
				arg_207_1.allBtn_.enabled = true
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				local var_210_2 = arg_207_1.var_.effectfdsfsf

				if not arg_207_1.var_.effectfdsfsf then
					var_210_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_starheart"), manager.ui.mainCamera.transform)
					var_210_2.name = "fdsfsf"
					arg_207_1.var_.effectfdsfsf = var_210_2
				else
					var_210_2.transform:SetParent(var_210_9000)
				end

				var_210_2.transform.localPosition = Vector3.New(0, -0.2, 0)
				var_210_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.1 < arg_207_1.time_ and arg_207_1.time_ <= 0.1 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "se_story_150", "se_story_150_beach_up", "")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.cswbg_:SetActive(false)
			end

			if arg_207_1.frameCnt_ <= 1 then
				arg_207_1.dialog_:SetActive(false)
			end

			local var_210_6 = 2.2
			local var_210_7 = 0.175

			if 2.2 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0

				arg_207_1.dialog_:SetActive(true)

				arg_207_1.dialogCg_.alpha = 0

				local var_210_8 = LeanTween.value(arg_207_1.dialog_, 0, 1, 0.3)

				var_210_8:setOnUpdate(LuaHelper.FloatAction(function(arg_211_0)
					arg_207_1.dialogCg_.alpha = arg_211_0
				end))
				var_210_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_207_1.dialog_)
					var_210_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_207_1.duration_ = arg_207_1.duration_ + 0.3

				SetActive(arg_207_1.leftNameGo_, false)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_9 = arg_207_1:FormatText(arg_207_1:GetWordFromCfg(324541051).content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 7 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 7)

				if (7 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 7)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11
					var_210_6 = var_210_6 + 0.3

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)
				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = var_210_6 + 0.3
			local var_210_13 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 + 0.3 <= arg_207_1.time_ and arg_207_1.time_ < var_210_12 + var_210_13 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_12) / var_210_13

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_12 + var_210_13 and arg_207_1.time_ < var_210_12 + var_210_13 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {}

		arg_207_1:InitPlayNodeList()
	end,
	Play324541052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 324541052
		arg_213_1.duration_ = 5.18

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play324541053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			local var_216_9000

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_0 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_0.offsetMin = Vector2.New(400, 300)
				var_216_0.offsetMax = Vector2.New(-400, -200)
				arg_213_1.cswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(419185).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.cswt_)

				arg_213_1.cswt_.fontSize = 108
				arg_213_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_213_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.866666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 0.866666666666667 + arg_216_0 then
				arg_213_1.cswbg_:SetActive(true)

				local var_216_1 = arg_213_1.cswt_:GetComponent("RectTransform")

				arg_213_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_216_1.offsetMin = Vector2.New(400, 300)
				var_216_1.offsetMax = Vector2.New(-400, -200)
				arg_213_1.cswt_.text = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(419186).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.cswt_)

				arg_213_1.cswt_.fontSize = 108
				arg_213_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_213_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_213_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_216_2 = 0

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.allBtn_.enabled = false
			end

			if arg_213_1.time_ >= var_216_2 + 1.86666666666667 and arg_213_1.time_ < var_216_2 + 1.86666666666667 + arg_216_0 then
				arg_213_1.allBtn_.enabled = true
			end

			if 0.4 < arg_213_1.time_ and arg_213_1.time_ <= 0.4 + arg_216_0 then
				local var_216_3 = arg_213_1.var_.effectdsdsd

				if not arg_213_1.var_.effectdsdsd then
					var_216_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_small"), manager.ui.mainCamera.transform)
					var_216_3.name = "dsdsd"
					arg_213_1.var_.effectdsdsd = var_216_3
				else
					var_216_3.transform:SetParent(var_216_9000)
				end

				var_216_3.transform.localPosition = Vector3.New(0, 0.04, 1.15)
				var_216_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1.46666666666667 < arg_213_1.time_ and arg_213_1.time_ <= 1.46666666666667 + arg_216_0 then
				if arg_213_1.var_.effectdsdsd then
					Object.Destroy(arg_213_1.var_.effectdsdsd)

					arg_213_1.var_.effectdsdsd = nil
				end
			end

			if arg_213_1.frameCnt_ <= 1 then
				arg_213_1.dialog_:SetActive(false)
			end

			local var_216_6 = 0.175
			local var_216_7 = 0.825

			if 0.175 < arg_213_1.time_ and arg_213_1.time_ <= var_216_6 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0

				arg_213_1.dialog_:SetActive(true)

				arg_213_1.dialogCg_.alpha = 0

				local var_216_8 = LeanTween.value(arg_213_1.dialog_, 0, 1, 0.3)

				var_216_8:setOnUpdate(LuaHelper.FloatAction(function(arg_217_0)
					arg_213_1.dialogCg_.alpha = arg_217_0
				end))
				var_216_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_213_1.dialog_)
					var_216_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_213_1.duration_ = arg_213_1.duration_ + 0.3

				SetActive(arg_213_1.leftNameGo_, false)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_9 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(324541052).content)

				arg_213_1.text_.text = var_216_9

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_11 = 33 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 33)

				if (33 <= 0 and var_216_7 or var_216_7 * (utf8.len(var_216_9) / 33)) > 0 and var_216_7 < var_216_11 then
					arg_213_1.talkMaxDuration = var_216_11
					var_216_6 = var_216_6 + 0.3

					if var_216_11 + var_216_6 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_11 + var_216_6
					end
				end

				arg_213_1.text_.text = var_216_9
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = var_216_6 + 0.3
			local var_216_13 = math.max(var_216_7, arg_213_1.talkMaxDuration)

			if var_216_6 + 0.3 <= arg_213_1.time_ and arg_213_1.time_ < var_216_12 + var_216_13 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_12) / var_216_13

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_12 + var_216_13 and arg_213_1.time_ < var_216_12 + var_216_13 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play324541053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 324541053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play324541054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_9000

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_0 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_0.offsetMin = Vector2.New(400, 300)
				var_222_0.offsetMax = Vector2.New(-400, -200)
				arg_219_1.cswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(419187).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 108
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.666666666666667 < arg_219_1.time_ and arg_219_1.time_ <= 0.666666666666667 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_1 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_1.offsetMin = Vector2.New(400, 300)
				var_222_1.offsetMax = Vector2.New(-400, -200)
				arg_219_1.cswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(419188).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 108
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.43333333333333 < arg_219_1.time_ and arg_219_1.time_ <= 1.43333333333333 + arg_222_0 then
				arg_219_1.cswbg_:SetActive(true)

				local var_222_2 = arg_219_1.cswt_:GetComponent("RectTransform")

				arg_219_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_222_2.offsetMin = Vector2.New(400, 300)
				var_222_2.offsetMax = Vector2.New(-400, -200)
				arg_219_1.cswt_.text = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(419189).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.cswt_)

				arg_219_1.cswt_.fontSize = 108
				arg_219_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_219_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_219_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1 < arg_219_1.time_ and arg_219_1.time_ <= 1 + arg_222_0 then
				local var_222_3 = arg_219_1.var_.effectewqew

				if not arg_219_1.var_.effectewqew then
					var_222_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_erro2_big"), manager.ui.mainCamera.transform)
					var_222_3.name = "ewqew"
					arg_219_1.var_.effectewqew = var_222_3
				else
					var_222_3.transform:SetParent(var_222_9000)
				end

				var_222_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_222_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.26666666666667 < arg_219_1.time_ and arg_219_1.time_ <= 2.26666666666667 + arg_222_0 then
				if arg_219_1.var_.effectewqew then
					Object.Destroy(arg_219_1.var_.effectewqew)

					arg_219_1.var_.effectewqew = nil
				end
			end

			local var_222_6 = 0

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_6 + arg_222_0 then
				arg_219_1.allBtn_.enabled = false
			end

			if arg_219_1.time_ >= var_222_6 + 1.8 and arg_219_1.time_ < var_222_6 + 1.8 + arg_222_0 then
				arg_219_1.allBtn_.enabled = true
			end

			local var_222_7 = 0
			local var_222_8 = 0.575

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_7 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, false)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_9 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(324541053).content)

				arg_219_1.text_.text = var_222_9

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_11 = 23 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_9) / 23)

				if (23 <= 0 and var_222_8 or var_222_8 * (utf8.len(var_222_9) / 23)) > 0 and var_222_8 < var_222_11 then
					arg_219_1.talkMaxDuration = var_222_11

					if var_222_11 + var_222_7 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_11 + var_222_7
					end
				end

				arg_219_1.text_.text = var_222_9
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_12 = math.max(var_222_8, arg_219_1.talkMaxDuration)

			if var_222_7 <= arg_219_1.time_ and arg_219_1.time_ < var_222_7 + var_222_12 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_7) / var_222_12

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_7 + var_222_12 and arg_219_1.time_ < var_222_7 + var_222_12 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play324541054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 324541054
		arg_223_1.duration_ = 7.43

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
			arg_223_1.auto_ = false
		end

		function arg_223_1.playNext_(arg_225_0)
			arg_223_1.onStoryFinished_()
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_9000

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_0 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_0.offsetMin = Vector2.New(400, 300)
				var_226_0.offsetMax = Vector2.New(-400, -200)
				arg_223_1.cswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(419190).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.4 < arg_223_1.time_ and arg_223_1.time_ <= 0.4 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_1 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_1.offsetMin = Vector2.New(400, 300)
				var_226_1.offsetMax = Vector2.New(-400, -200)
				arg_223_1.cswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(419191).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.6 < arg_223_1.time_ and arg_223_1.time_ <= 0.6 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_2 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_2.offsetMin = Vector2.New(400, 300)
				var_226_2.offsetMax = Vector2.New(-400, -200)
				arg_223_1.cswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(419192).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.833333333333333 < arg_223_1.time_ and arg_223_1.time_ <= 0.833333333333333 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_3 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_3.offsetMin = Vector2.New(400, 300)
				var_226_3.offsetMax = Vector2.New(-400, -200)
				arg_223_1.cswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(419193).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 1.19999999999867 < arg_223_1.time_ and arg_223_1.time_ <= 1.19999999999867 + arg_226_0 then
				arg_223_1.cswbg_:SetActive(true)

				local var_226_4 = arg_223_1.cswt_:GetComponent("RectTransform")

				arg_223_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_226_4.offsetMin = Vector2.New(400, 300)
				var_226_4.offsetMax = Vector2.New(-400, -200)
				arg_223_1.cswt_.text = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(419194).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.cswt_)

				arg_223_1.cswt_.fontSize = 108
				arg_223_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_223_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_223_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			if 0.433333333333333 < arg_223_1.time_ and arg_223_1.time_ <= 0.433333333333333 + arg_226_0 then
				local var_226_5 = arg_223_1.var_.effect12314

				if not arg_223_1.var_.effect12314 then
					var_226_5 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_226_5.name = "12314"
					arg_223_1.var_.effect12314 = var_226_5
				else
					var_226_5.transform:SetParent(var_226_9000)
				end

				var_226_5.transform.localPosition = Vector3.New(0, 0, 0)
				var_226_5.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_226_5.transform.localScale = Vector3.New(var_226_5.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_226_5.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_226_5.transform.localScale.z)
			end

			local var_226_7 = 0

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 then
				arg_223_1.allBtn_.enabled = false
			end

			if arg_223_1.time_ >= var_226_7 + 2.6 and arg_223_1.time_ < var_226_7 + 2.6 + arg_226_0 then
				arg_223_1.allBtn_.enabled = true
			end

			if arg_223_1.frameCnt_ <= 1 then
				arg_223_1.dialog_:SetActive(false)
			end

			local var_226_8 = 2.43333333333333
			local var_226_9 = 0.3

			if 2.43333333333333 < arg_223_1.time_ and arg_223_1.time_ <= var_226_8 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0

				arg_223_1.dialog_:SetActive(true)

				arg_223_1.dialogCg_.alpha = 0

				local var_226_10 = LeanTween.value(arg_223_1.dialog_, 0, 1, 0.3)

				var_226_10:setOnUpdate(LuaHelper.FloatAction(function(arg_227_0)
					arg_223_1.dialogCg_.alpha = arg_227_0
				end))
				var_226_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_223_1.dialog_)
					var_226_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_223_1.duration_ = arg_223_1.duration_ + 0.3

				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_11 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(324541054).content)

				arg_223_1.text_.text = var_226_11

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_13 = 12 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 12)

				if (12 <= 0 and var_226_9 or var_226_9 * (utf8.len(var_226_11) / 12)) > 0 and var_226_9 < var_226_13 then
					arg_223_1.talkMaxDuration = var_226_13
					var_226_8 = var_226_8 + 0.3

					if var_226_13 + var_226_8 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_13 + var_226_8
					end
				end

				arg_223_1.text_.text = var_226_11
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_14 = var_226_8 + 0.3
			local var_226_15 = math.max(var_226_9, arg_223_1.talkMaxDuration)

			if var_226_8 + 0.3 <= arg_223_1.time_ and arg_223_1.time_ < var_226_14 + var_226_15 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_14) / var_226_15

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_14 + var_226_15 and arg_223_1.time_ < var_226_14 + var_226_15 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/MS2406",
		"TextureConfig/Background/J25f",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_324541.awb"
	}
}
