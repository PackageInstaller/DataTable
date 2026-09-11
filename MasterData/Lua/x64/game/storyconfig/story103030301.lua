return {
	Play303031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 303031001
		arg_1_1.duration_ = 7.8

		local var_1_0 = {
			zh = 7.46700000184774,
			ja = 7.80000000184774
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
				arg_1_0:Play303031002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.B10c == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B10c")
				var_4_0.name = "B10c"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.B10c = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.B10c

				arg_1_1.bgs_.B10c.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B10c" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2.03400000184774

			if 2.03400000184774 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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

			local var_4_9 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_10.name = var_4_9
				var_4_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_9] = var_4_10

				local var_4_11 = var_4_10:GetComponentInChildren(typeof(CharacterEffect))

				var_4_11.enabled = true

				local var_4_12 = GameObjectTools.GetOrAddComponent(var_4_10, typeof(DynamicBoneHelper))

				if var_4_12 then
					var_4_12:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_11.transform, false)

				arg_1_1.var_[var_4_9 .. "Animator"] = var_4_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_9 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_9 .. "LipSync"] = var_4_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_13 = arg_1_1.actors_["1084ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 2) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_14 and arg_1_1.time_ < 2 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.97, -6)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["1084ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_16 and arg_1_1.time_ < 2 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_21 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 2.03400000184774
			local var_4_24 = 0.575

			if 2.03400000184774 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(303031001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 23 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 23)

				if (23 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 23)) > 0 and var_4_24 < var_4_29 then
					arg_1_1.talkMaxDuration = var_4_29
					var_4_23 = var_4_23 + 0.3

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_27
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031001", "story_v_out_303031.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_303031", "303031001", "story_v_out_303031.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_303031", "303031001", "story_v_out_303031.awb")

						arg_1_1:RecordAudio("303031001", var_4_31)
						arg_1_1:RecordAudio("303031001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_303031", "303031001", "story_v_out_303031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_303031", "303031001", "story_v_out_303031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_32 = var_4_23 + 0.3
			local var_4_33 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_32 + var_4_33 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_32) / var_4_33

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_32 + var_4_33 and arg_1_1.time_ < var_4_32 + var_4_33 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play303031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 303031002
		arg_8_1.duration_ = 5

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play303031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = arg_8_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_11_0 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_0 then
				arg_8_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_0)
				arg_8_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).z)
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles = arg_8_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_0 and arg_8_1.time_ < 0 + var_11_0 + arg_11_0 then
				arg_8_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_8_1.actors_["1084ui_story"].transform.position).z)
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_8_1.actors_["1084ui_story"].transform.localEulerAngles = arg_8_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_11_1 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_1) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_2 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_2 and not isNil(var_11_1) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_1) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_2)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_2 and arg_8_1.time_ < 0 + var_11_2 + arg_11_0 and not isNil(var_11_1) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_11_3 = 0
			local var_11_4 = 1.35

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_3 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, false)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_5 = arg_8_1:FormatText(arg_8_1:GetWordFromCfg(303031002).content)

				arg_8_1.text_.text = var_11_5

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_7 = 54 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 54)

				if (54 <= 0 and var_11_4 or var_11_4 * (utf8.len(var_11_5) / 54)) > 0 and var_11_4 < var_11_7 then
					arg_8_1.talkMaxDuration = var_11_7

					if var_11_7 + var_11_3 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_7 + var_11_3
					end
				end

				arg_8_1.text_.text = var_11_5
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)
				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_8 = math.max(var_11_4, arg_8_1.talkMaxDuration)

			if var_11_3 <= arg_8_1.time_ and arg_8_1.time_ < var_11_3 + var_11_8 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_3) / var_11_8

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_3 + var_11_8 and arg_8_1.time_ < var_11_3 + var_11_8 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play303031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 303031003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play303031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_0 = 0.575

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
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

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_1 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(303031003).content)

				arg_12_1.text_.text = var_15_1

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_3 = 23 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 23)

				if (23 <= 0 and var_15_0 or var_15_0 * (utf8.len(var_15_1) / 23)) > 0 and var_15_0 < var_15_3 then
					arg_12_1.talkMaxDuration = var_15_3

					if var_15_3 + 0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_3 + 0
					end
				end

				arg_12_1.text_.text = var_15_1
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_4 = math.max(var_15_0, arg_12_1.talkMaxDuration)

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - 0) / var_15_4

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play303031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 303031004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play303031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			local var_19_0 = 0.75

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
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

				arg_16_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_16_1.callingController_:SetSelectedState("normal")

				arg_16_1.keyicon_.color = Color.New(1, 1, 1)
				arg_16_1.icon_.color = Color.New(1, 1, 1)

				local var_19_1 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(303031004).content)

				arg_16_1.text_.text = var_19_1

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_3 = 30 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 30)

				if (30 <= 0 and var_19_0 or var_19_0 * (utf8.len(var_19_1) / 30)) > 0 and var_19_0 < var_19_3 then
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
	Play303031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 303031005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play303031006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.825

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
				SetActive(arg_20_1.iconTrs_.gameObject, true)
				arg_20_1.iconController_:SetSelectedState("hero")

				arg_20_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_20_1.callingController_:SetSelectedState("normal")

				arg_20_1.keyicon_.color = Color.New(1, 1, 1)
				arg_20_1.icon_.color = Color.New(1, 1, 1)

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(303031005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 33 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 33)

				if (33 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 33)) > 0 and var_23_0 < var_23_3 then
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
	Play303031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 303031006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play303031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = arg_24_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1084ui_story"].transform.position).z)
				arg_24_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1084ui_story"].transform.localEulerAngles = arg_24_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_24_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1084ui_story"].transform.position).z)
				arg_24_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1084ui_story"].transform.localEulerAngles = arg_24_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_27_1 = arg_24_1.actors_["1084ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 and not isNil(var_27_1) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_1) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_4 = 0
			local var_27_5 = 0.075

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:GetWordFromCfg(303031006)
				local var_27_7 = arg_24_1:FormatText(var_27_6.content)

				arg_24_1.text_.text = var_27_7

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_9 = 3 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 3)

				if (3 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_7) / 3)) > 0 and var_27_5 < var_27_9 then
					arg_24_1.talkMaxDuration = var_27_9

					if var_27_9 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_9 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_7
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031006", "story_v_out_303031.awb") ~= 0 then
					local var_27_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031006", "story_v_out_303031.awb") / 1000

					if var_27_10 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_10 + var_27_4
					end

					if var_27_6.prefab_name ~= "" and arg_24_1.actors_[var_27_6.prefab_name] ~= nil then
						local var_27_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_6.prefab_name].transform, "story_v_out_303031", "303031006", "story_v_out_303031.awb")

						arg_24_1:RecordAudio("303031006", var_27_11)
						arg_24_1:RecordAudio("303031006", var_27_11)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_303031", "303031006", "story_v_out_303031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_303031", "303031006", "story_v_out_303031.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_12 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_12 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_12

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_12 and arg_24_1.time_ < var_27_4 + var_27_12 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play303031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 303031007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play303031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1084ui_story = arg_28_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1084ui_story"].transform.position).z)
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1084ui_story"].transform.localEulerAngles = arg_28_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_31_1 = arg_28_1.actors_["1084ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1084ui_story == nil then
				arg_28_1.var_.characterEffect1084ui_story = var_31_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_2 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 and not isNil(var_31_1) then
				if arg_28_1.var_.characterEffect1084ui_story and not isNil(var_31_1) then
					arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_2)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 and not isNil(var_31_1) and arg_28_1.var_.characterEffect1084ui_story then
				arg_28_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_31_3 = 0
			local var_31_4 = 0.875

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(303031007).content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 35 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 35)

				if (35 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 35)) > 0 and var_31_4 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_8 and arg_28_1.time_ < var_31_3 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play303031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 303031008
		arg_32_1.duration_ = 5.47

		local var_32_0 = {
			zh = 3.933,
			ja = 5.466
		}
		local var_32_1 = manager.audio:GetLocalizationFlag()

		if var_32_0[var_32_1] ~= nil then
			arg_32_1.duration_ = var_32_0[var_32_1]
		end

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play303031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1084ui_story = arg_32_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).z)
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles = arg_32_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_32_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["1084ui_story"].transform.position).z)
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["1084ui_story"].transform.localEulerAngles = arg_32_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_35_1 = arg_32_1.actors_["1084ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1084ui_story == nil then
				arg_32_1.var_.characterEffect1084ui_story = var_35_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_2 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_2 and not isNil(var_35_1) then
				if arg_32_1.var_.characterEffect1084ui_story and not isNil(var_35_1) then
					arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_2 and arg_32_1.time_ < 0 + var_35_2 + arg_35_0 and not isNil(var_35_1) and arg_32_1.var_.characterEffect1084ui_story then
				arg_32_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_4 = 0
			local var_35_5 = 0.7

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(303031008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 28 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 28)

				if (28 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 28)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031008", "story_v_out_303031.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031008", "story_v_out_303031.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_303031", "303031008", "story_v_out_303031.awb")

						arg_32_1:RecordAudio("303031008", var_35_11)
						arg_32_1:RecordAudio("303031008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_303031", "303031008", "story_v_out_303031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_303031", "303031008", "story_v_out_303031.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play303031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 303031009
		arg_36_1.duration_ = 1.33

		local var_36_0 = {
			zh = 1,
			ja = 1.333
		}
		local var_36_1 = manager.audio:GetLocalizationFlag()

		if var_36_0[var_36_1] ~= nil then
			arg_36_1.duration_ = var_36_0[var_36_1]
		end

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play303031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["1166ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1166ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "1166ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "1166ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["1166ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["1166ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["1166ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["1166ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["1166ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1166ui_story = var_39_3.localPosition

				local var_39_4 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_4 then
					var_39_4:EnableDynamicBone(false)
				end
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_3.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1166ui_story, Vector3.New(0.7, -0.75, -6.25), (arg_36_1.time_ - 0) / var_39_5)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_3.localPosition = Vector3.New(0.7, -0.75, -6.25)
				var_39_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_3.position).x, (manager.ui.mainCamera.transform.position - var_39_3.position).y, (manager.ui.mainCamera.transform.position - var_39_3.position).z)
				var_39_3.localEulerAngles.z = 0
				var_39_3.localEulerAngles.x = 0
				var_39_3.localEulerAngles = var_39_3.localEulerAngles

				local var_39_6 = GameObjectTools.GetOrAddComponent(var_39_3.gameObject, typeof(DynamicBoneHelper))

				if var_39_6 then
					var_39_6:EnableDynamicBone(true)
				end
			end

			local var_39_7 = arg_36_1.actors_["1166ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1166ui_story == nil then
				arg_36_1.var_.characterEffect1166ui_story = var_39_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_8 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_8 and not isNil(var_39_7) then
				if arg_36_1.var_.characterEffect1166ui_story and not isNil(var_39_7) then
					arg_36_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_8 and arg_36_1.time_ < 0 + var_39_8 + arg_39_0 and not isNil(var_39_7) and arg_36_1.var_.characterEffect1166ui_story then
				arg_36_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_39_10 = arg_36_1.actors_["1084ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_10) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = var_39_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_11 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_11 and not isNil(var_39_10) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(var_39_10) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_11)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_11 and arg_36_1.time_ < 0 + var_39_11 + arg_39_0 and not isNil(var_39_10) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_39_12 = 0
			local var_39_13 = 0.05

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(303031009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 2 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 2)

				if (2 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 2)) > 0 and var_39_13 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031009", "story_v_out_303031.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_303031", "303031009", "story_v_out_303031.awb") / 1000

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_303031", "303031009", "story_v_out_303031.awb")

						arg_36_1:RecordAudio("303031009", var_39_19)
						arg_36_1:RecordAudio("303031009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_303031", "303031009", "story_v_out_303031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_303031", "303031009", "story_v_out_303031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_20 and arg_36_1.time_ < var_39_12 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play303031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 303031010
		arg_40_1.duration_ = 10.17

		local var_40_0 = {
			zh = 7.733,
			ja = 10.166
		}
		local var_40_1 = manager.audio:GetLocalizationFlag()

		if var_40_0[var_40_1] ~= nil then
			arg_40_1.duration_ = var_40_0[var_40_1]
		end

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play303031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = arg_40_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(arg_40_1.actors_["1084ui_story"]) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1084ui_story"]) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1166ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1166ui_story == nil then
				arg_40_1.var_.characterEffect1166ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1166ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1166ui_story then
				arg_40_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 0.85

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:GetWordFromCfg(303031010)
				local var_43_7 = arg_40_1:FormatText(var_43_6.content)

				arg_40_1.text_.text = var_43_7

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_9 = 34 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 34)

				if (34 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_7) / 34)) > 0 and var_43_5 < var_43_9 then
					arg_40_1.talkMaxDuration = var_43_9

					if var_43_9 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_9 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_7
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031010", "story_v_out_303031.awb") ~= 0 then
					local var_43_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031010", "story_v_out_303031.awb") / 1000

					if var_43_10 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_10 + var_43_4
					end

					if var_43_6.prefab_name ~= "" and arg_40_1.actors_[var_43_6.prefab_name] ~= nil then
						local var_43_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_6.prefab_name].transform, "story_v_out_303031", "303031010", "story_v_out_303031.awb")

						arg_40_1:RecordAudio("303031010", var_43_11)
						arg_40_1:RecordAudio("303031010", var_43_11)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_303031", "303031010", "story_v_out_303031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_303031", "303031010", "story_v_out_303031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_12 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_12 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_12

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_12 and arg_40_1.time_ < var_43_4 + var_43_12 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play303031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 303031011
		arg_44_1.duration_ = 2

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play303031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1166ui_story"]) and arg_44_1.var_.characterEffect1166ui_story == nil then
				arg_44_1.var_.characterEffect1166ui_story = arg_44_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1166ui_story"]) then
				if arg_44_1.var_.characterEffect1166ui_story and not isNil(arg_44_1.actors_["1166ui_story"]) then
					arg_44_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1166ui_story"]) and arg_44_1.var_.characterEffect1166ui_story then
				arg_44_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1084ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story == nil then
				arg_44_1.var_.characterEffect1084ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1084ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1084ui_story then
				arg_44_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_47_4 = 0
			local var_47_5 = 0.1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_4 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_6 = arg_44_1:GetWordFromCfg(303031011)
				local var_47_7 = arg_44_1:FormatText(var_47_6.content)

				arg_44_1.text_.text = var_47_7

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_9 = 4 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 4)

				if (4 <= 0 and var_47_5 or var_47_5 * (utf8.len(var_47_7) / 4)) > 0 and var_47_5 < var_47_9 then
					arg_44_1.talkMaxDuration = var_47_9

					if var_47_9 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_9 + var_47_4
					end
				end

				arg_44_1.text_.text = var_47_7
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031011", "story_v_out_303031.awb") ~= 0 then
					local var_47_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031011", "story_v_out_303031.awb") / 1000

					if var_47_10 + var_47_4 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_10 + var_47_4
					end

					if var_47_6.prefab_name ~= "" and arg_44_1.actors_[var_47_6.prefab_name] ~= nil then
						local var_47_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_6.prefab_name].transform, "story_v_out_303031", "303031011", "story_v_out_303031.awb")

						arg_44_1:RecordAudio("303031011", var_47_11)
						arg_44_1:RecordAudio("303031011", var_47_11)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_303031", "303031011", "story_v_out_303031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_303031", "303031011", "story_v_out_303031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_12 = math.max(var_47_5, arg_44_1.talkMaxDuration)

			if var_47_4 <= arg_44_1.time_ and arg_44_1.time_ < var_47_4 + var_47_12 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_4) / var_47_12

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_4 + var_47_12 and arg_44_1.time_ < var_47_4 + var_47_12 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play303031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 303031012
		arg_48_1.duration_ = 4.97

		local var_48_0 = {
			zh = 4.033,
			ja = 4.966
		}
		local var_48_1 = manager.audio:GetLocalizationFlag()

		if var_48_0[var_48_1] ~= nil then
			arg_48_1.duration_ = var_48_0[var_48_1]
		end

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play303031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = arg_48_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(arg_48_1.actors_["1084ui_story"]) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1166ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1166ui_story == nil then
				arg_48_1.var_.characterEffect1166ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1166ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1166ui_story then
				arg_48_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action434")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_4 = 0
			local var_51_5 = 0.45

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(303031012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 18 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 18)

				if (18 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 18)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031012", "story_v_out_303031.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031012", "story_v_out_303031.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_303031", "303031012", "story_v_out_303031.awb")

						arg_48_1:RecordAudio("303031012", var_51_11)
						arg_48_1:RecordAudio("303031012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_303031", "303031012", "story_v_out_303031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_303031", "303031012", "story_v_out_303031.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_12 = math.max(var_51_5, arg_48_1.talkMaxDuration)

			if var_51_4 <= arg_48_1.time_ and arg_48_1.time_ < var_51_4 + var_51_12 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_4) / var_51_12

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_4 + var_51_12 and arg_48_1.time_ < var_51_4 + var_51_12 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play303031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 303031013
		arg_52_1.duration_ = 8.43

		local var_52_0 = {
			zh = 5.366,
			ja = 8.433
		}
		local var_52_1 = manager.audio:GetLocalizationFlag()

		if var_52_0[var_52_1] ~= nil then
			arg_52_1.duration_ = var_52_0[var_52_1]
		end

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play303031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_55_0 = 0
			local var_55_1 = 0.7

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_0 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_2 = arg_52_1:GetWordFromCfg(303031013)
				local var_55_3 = arg_52_1:FormatText(var_55_2.content)

				arg_52_1.text_.text = var_55_3

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_5 = 28 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 28)

				if (28 <= 0 and var_55_1 or var_55_1 * (utf8.len(var_55_3) / 28)) > 0 and var_55_1 < var_55_5 then
					arg_52_1.talkMaxDuration = var_55_5

					if var_55_5 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_5 + var_55_0
					end
				end

				arg_52_1.text_.text = var_55_3
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031013", "story_v_out_303031.awb") ~= 0 then
					local var_55_6 = manager.audio:GetVoiceLength("story_v_out_303031", "303031013", "story_v_out_303031.awb") / 1000

					if var_55_6 + var_55_0 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_0
					end

					if var_55_2.prefab_name ~= "" and arg_52_1.actors_[var_55_2.prefab_name] ~= nil then
						local var_55_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_2.prefab_name].transform, "story_v_out_303031", "303031013", "story_v_out_303031.awb")

						arg_52_1:RecordAudio("303031013", var_55_7)
						arg_52_1:RecordAudio("303031013", var_55_7)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_303031", "303031013", "story_v_out_303031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_303031", "303031013", "story_v_out_303031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_8 = math.max(var_55_1, arg_52_1.talkMaxDuration)

			if var_55_0 <= arg_52_1.time_ and arg_52_1.time_ < var_55_0 + var_55_8 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_0) / var_55_8

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_0 + var_55_8 and arg_52_1.time_ < var_55_0 + var_55_8 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play303031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 303031014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play303031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) and arg_56_1.var_.characterEffect1084ui_story == nil then
				arg_56_1.var_.characterEffect1084ui_story = arg_56_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.200000002980232

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) then
				if arg_56_1.var_.characterEffect1084ui_story and not isNil(arg_56_1.actors_["1084ui_story"]) then
					arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_0)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1084ui_story"]) and arg_56_1.var_.characterEffect1084ui_story then
				arg_56_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action2_2")
			end

			local var_59_1 = 0
			local var_59_2 = 0.35

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_1 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_3 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(303031014).content)

				arg_56_1.text_.text = var_59_3

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_5 = 14 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 14)

				if (14 <= 0 and var_59_2 or var_59_2 * (utf8.len(var_59_3) / 14)) > 0 and var_59_2 < var_59_5 then
					arg_56_1.talkMaxDuration = var_59_5

					if var_59_5 + var_59_1 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_5 + var_59_1
					end
				end

				arg_56_1.text_.text = var_59_3
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_6 = math.max(var_59_2, arg_56_1.talkMaxDuration)

			if var_59_1 <= arg_56_1.time_ and arg_56_1.time_ < var_59_1 + var_59_6 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_1) / var_59_6

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_1 + var_59_6 and arg_56_1.time_ < var_59_1 + var_59_6 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play303031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 303031015
		arg_60_1.duration_ = 4.2

		local var_60_0 = {
			zh = 2.6,
			ja = 4.2
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play303031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story == nil then
				arg_60_1.var_.characterEffect1084ui_story = arg_60_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) then
				if arg_60_1.var_.characterEffect1084ui_story and not isNil(arg_60_1.actors_["1084ui_story"]) then
					arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1084ui_story"]) and arg_60_1.var_.characterEffect1084ui_story then
				arg_60_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_63_2 = 0
			local var_63_3 = 0.275

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_2 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_4 = arg_60_1:GetWordFromCfg(303031015)
				local var_63_5 = arg_60_1:FormatText(var_63_4.content)

				arg_60_1.text_.text = var_63_5

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_7 = 11 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 11)

				if (11 <= 0 and var_63_3 or var_63_3 * (utf8.len(var_63_5) / 11)) > 0 and var_63_3 < var_63_7 then
					arg_60_1.talkMaxDuration = var_63_7

					if var_63_7 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_7 + var_63_2
					end
				end

				arg_60_1.text_.text = var_63_5
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031015", "story_v_out_303031.awb") ~= 0 then
					local var_63_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031015", "story_v_out_303031.awb") / 1000

					if var_63_8 + var_63_2 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_8 + var_63_2
					end

					if var_63_4.prefab_name ~= "" and arg_60_1.actors_[var_63_4.prefab_name] ~= nil then
						local var_63_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_4.prefab_name].transform, "story_v_out_303031", "303031015", "story_v_out_303031.awb")

						arg_60_1:RecordAudio("303031015", var_63_9)
						arg_60_1:RecordAudio("303031015", var_63_9)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_303031", "303031015", "story_v_out_303031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_303031", "303031015", "story_v_out_303031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_10 = math.max(var_63_3, arg_60_1.talkMaxDuration)

			if var_63_2 <= arg_60_1.time_ and arg_60_1.time_ < var_63_2 + var_63_10 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_2) / var_63_10

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_2 + var_63_10 and arg_60_1.time_ < var_63_2 + var_63_10 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play303031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 303031016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play303031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = arg_64_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(arg_64_1.actors_["1084ui_story"]) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.3

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(303031016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 12 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 12)

				if (12 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 12)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play303031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 303031017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play303031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 0.575

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(303031017).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 23 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 23)

				if (23 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 23)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play303031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 303031018
		arg_72_1.duration_ = 7.83

		local var_72_0 = {
			zh = 7.066,
			ja = 7.833
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play303031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = arg_72_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(arg_72_1.actors_["1084ui_story"]) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_75_2 = 0
			local var_75_3 = 0.75

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_2 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_4 = arg_72_1:GetWordFromCfg(303031018)
				local var_75_5 = arg_72_1:FormatText(var_75_4.content)

				arg_72_1.text_.text = var_75_5

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_7 = 30 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 30)

				if (30 <= 0 and var_75_3 or var_75_3 * (utf8.len(var_75_5) / 30)) > 0 and var_75_3 < var_75_7 then
					arg_72_1.talkMaxDuration = var_75_7

					if var_75_7 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_2
					end
				end

				arg_72_1.text_.text = var_75_5
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031018", "story_v_out_303031.awb") ~= 0 then
					local var_75_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031018", "story_v_out_303031.awb") / 1000

					if var_75_8 + var_75_2 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_8 + var_75_2
					end

					if var_75_4.prefab_name ~= "" and arg_72_1.actors_[var_75_4.prefab_name] ~= nil then
						local var_75_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_4.prefab_name].transform, "story_v_out_303031", "303031018", "story_v_out_303031.awb")

						arg_72_1:RecordAudio("303031018", var_75_9)
						arg_72_1:RecordAudio("303031018", var_75_9)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_303031", "303031018", "story_v_out_303031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_303031", "303031018", "story_v_out_303031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_10 = math.max(var_75_3, arg_72_1.talkMaxDuration)

			if var_75_2 <= arg_72_1.time_ and arg_72_1.time_ < var_75_2 + var_75_10 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_2) / var_75_10

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_2 + var_75_10 and arg_72_1.time_ < var_75_2 + var_75_10 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play303031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 303031019
		arg_76_1.duration_ = 6.07

		local var_76_0 = {
			zh = 3.733,
			ja = 6.066
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
				arg_76_0:Play303031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_79_0 = 0
			local var_79_1 = 0.425

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(303031019)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 17 <= 0 and var_79_1 or var_79_1 * (utf8.len(var_79_3) / 17)

				if (17 <= 0 and var_79_1 or var_79_1 * (utf8.len(var_79_3) / 17)) > 0 and var_79_1 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031019", "story_v_out_303031.awb") ~= 0 then
					local var_79_6 = manager.audio:GetVoiceLength("story_v_out_303031", "303031019", "story_v_out_303031.awb") / 1000

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end

					if var_79_2.prefab_name ~= "" and arg_76_1.actors_[var_79_2.prefab_name] ~= nil then
						local var_79_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_2.prefab_name].transform, "story_v_out_303031", "303031019", "story_v_out_303031.awb")

						arg_76_1:RecordAudio("303031019", var_79_7)
						arg_76_1:RecordAudio("303031019", var_79_7)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_303031", "303031019", "story_v_out_303031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_303031", "303031019", "story_v_out_303031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play303031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 303031020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play303031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = arg_80_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(arg_80_1.actors_["1084ui_story"]) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_83_1 = arg_80_1.actors_["1084ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_1.localPosition
			end

			local var_83_2 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_2)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			local var_83_3 = 0
			local var_83_4 = 0.825

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_3 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, false)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_5 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(303031020).content)

				arg_80_1.text_.text = var_83_5

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_7 = 33 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 33)

				if (33 <= 0 and var_83_4 or var_83_4 * (utf8.len(var_83_5) / 33)) > 0 and var_83_4 < var_83_7 then
					arg_80_1.talkMaxDuration = var_83_7

					if var_83_7 + var_83_3 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_3
					end
				end

				arg_80_1.text_.text = var_83_5
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_8 = math.max(var_83_4, arg_80_1.talkMaxDuration)

			if var_83_3 <= arg_80_1.time_ and arg_80_1.time_ < var_83_3 + var_83_8 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_3) / var_83_8

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_3 + var_83_8 and arg_80_1.time_ < var_83_3 + var_83_8 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play303031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 303031021
		arg_84_1.duration_ = 8.23

		local var_84_0 = {
			zh = 6.8,
			ja = 8.233
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play303031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if arg_84_1.bgs_.B01a == nil then
				local var_87_0 = Object.Instantiate(arg_84_1.paintGo_)

				var_87_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B01a")
				var_87_0.name = "B01a"
				var_87_0.transform.parent = arg_84_1.stage_.transform
				var_87_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.bgs_.B01a = var_87_0
			end

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= 2 + arg_87_0 then
				local var_87_1 = arg_84_1.bgs_.B01a

				arg_84_1.bgs_.B01a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_87_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_87_2 = var_87_1:GetComponent("SpriteRenderer")

				if var_87_2 and var_87_2.sprite then
					local var_87_3 = 2 * (var_87_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_87_1.transform.localScale = Vector3.New(var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, var_87_3 / var_87_2.sprite.bounds.size.y < var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x and var_87_3 * manager.ui.mainCameraCom_.aspect / var_87_2.sprite.bounds.size.x or var_87_3 / var_87_2.sprite.bounds.size.y, 0)
				end

				for iter_87_0, iter_87_1 in pairs(arg_84_1.bgs_) do
					if iter_87_0 ~= "B01a" then
						iter_87_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_87_4 = 4.03333333631357

			if 4.03333333631357 < arg_84_1.time_ and arg_84_1.time_ <= var_87_4 + arg_87_0 then
				arg_84_1.allBtn_.enabled = false
			end

			if arg_84_1.time_ >= var_87_4 + 0.3 and arg_84_1.time_ < var_87_4 + 0.3 + arg_87_0 then
				arg_84_1.allBtn_.enabled = true
			end

			local var_87_5 = 0

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_5 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_6 = 2

			if var_87_5 <= arg_84_1.time_ and arg_84_1.time_ < var_87_5 + var_87_6 then
				local var_87_7 = Color.New(0, 0, 0)

				var_87_7.a = Mathf.Lerp(0, 1, (arg_84_1.time_ - var_87_5) / var_87_6)
				arg_84_1.mask_.color = var_87_7
			end

			if arg_84_1.time_ >= var_87_5 + var_87_6 and arg_84_1.time_ < var_87_5 + var_87_6 + arg_87_0 then
				local var_87_8 = Color.New(0, 0, 0)

				var_87_8.a = 1
				arg_84_1.mask_.color = var_87_8
			end

			local var_87_9 = 2

			if 2 < arg_84_1.time_ and arg_84_1.time_ <= var_87_9 + arg_87_0 then
				arg_84_1.mask_.enabled = true
				arg_84_1.mask_.raycastTarget = true

				arg_84_1:SetGaussion(false)
			end

			local var_87_10 = 2

			if var_87_9 <= arg_84_1.time_ and arg_84_1.time_ < var_87_9 + var_87_10 then
				local var_87_11 = Color.New(0, 0, 0)

				var_87_11.a = Mathf.Lerp(1, 0, (arg_84_1.time_ - var_87_9) / var_87_10)
				arg_84_1.mask_.color = var_87_11
			end

			if arg_84_1.time_ >= var_87_9 + var_87_10 and arg_84_1.time_ < var_87_9 + var_87_10 + arg_87_0 then
				local var_87_12 = Color.New(0, 0, 0)

				arg_84_1.mask_.enabled = false
				var_87_12.a = 0
				arg_84_1.mask_.color = var_87_12
			end

			local var_87_13 = arg_84_1.actors_["1166ui_story"].transform

			if 1.96599999815226 < arg_84_1.time_ and arg_84_1.time_ <= 1.96599999815226 + arg_87_0 then
				arg_84_1.var_.moveOldPos1166ui_story = var_87_13.localPosition

				local var_87_14 = GameObjectTools.GetOrAddComponent(var_87_13.gameObject, typeof(DynamicBoneHelper))

				if var_87_14 then
					var_87_14:EnableDynamicBone(false)
				end
			end

			local var_87_15 = 0.001

			if 1.96599999815226 <= arg_84_1.time_ and arg_84_1.time_ < 1.96599999815226 + var_87_15 then
				var_87_13.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 1.96599999815226) / var_87_15)
				var_87_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_13.position).x, (manager.ui.mainCamera.transform.position - var_87_13.position).y, (manager.ui.mainCamera.transform.position - var_87_13.position).z)
				var_87_13.localEulerAngles.z = 0
				var_87_13.localEulerAngles.x = 0
				var_87_13.localEulerAngles = var_87_13.localEulerAngles
			end

			if arg_84_1.time_ >= 1.96599999815226 + var_87_15 and arg_84_1.time_ < 1.96599999815226 + var_87_15 + arg_87_0 then
				var_87_13.localPosition = Vector3.New(0, 100, 0)
				var_87_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_13.position).x, (manager.ui.mainCamera.transform.position - var_87_13.position).y, (manager.ui.mainCamera.transform.position - var_87_13.position).z)
				var_87_13.localEulerAngles.z = 0
				var_87_13.localEulerAngles.x = 0
				var_87_13.localEulerAngles = var_87_13.localEulerAngles

				local var_87_16 = GameObjectTools.GetOrAddComponent(var_87_13.gameObject, typeof(DynamicBoneHelper))

				if var_87_16 then
					var_87_16:EnableDynamicBone(true)
				end
			end

			local var_87_17 = arg_84_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_84_1.time_ and arg_84_1.time_ <= 1.96599999815226 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_17.localPosition
			end

			local var_87_18 = 0.001

			if 1.96599999815226 <= arg_84_1.time_ and arg_84_1.time_ < 1.96599999815226 + var_87_18 then
				var_87_17.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 1.96599999815226) / var_87_18)
				var_87_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_17.position).x, (manager.ui.mainCamera.transform.position - var_87_17.position).y, (manager.ui.mainCamera.transform.position - var_87_17.position).z)
				var_87_17.localEulerAngles.z = 0
				var_87_17.localEulerAngles.x = 0
				var_87_17.localEulerAngles = var_87_17.localEulerAngles
			end

			if arg_84_1.time_ >= 1.96599999815226 + var_87_18 and arg_84_1.time_ < 1.96599999815226 + var_87_18 + arg_87_0 then
				var_87_17.localPosition = Vector3.New(0, 100, 0)
				var_87_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_17.position).x, (manager.ui.mainCamera.transform.position - var_87_17.position).y, (manager.ui.mainCamera.transform.position - var_87_17.position).z)
				var_87_17.localEulerAngles.z = 0
				var_87_17.localEulerAngles.x = 0
				var_87_17.localEulerAngles = var_87_17.localEulerAngles
			end

			local var_87_19 = "10140ui_story"

			if arg_84_1.actors_["10140ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10140ui_story"))) then
				local var_87_20 = Object.Instantiate(Asset.Load("Char/" .. "10140ui_story"), arg_84_1.stage_.transform)

				var_87_20.name = var_87_19
				var_87_20.transform.localPosition = Vector3.New(0, 100, 0)
				arg_84_1.actors_[var_87_19] = var_87_20

				local var_87_21 = var_87_20:GetComponentInChildren(typeof(CharacterEffect))

				var_87_21.enabled = true

				local var_87_22 = GameObjectTools.GetOrAddComponent(var_87_20, typeof(DynamicBoneHelper))

				if var_87_22 then
					var_87_22:EnableDynamicBone(false)
				end

				arg_84_1:ShowWeapon(var_87_21.transform, false)

				arg_84_1.var_[var_87_19 .. "Animator"] = var_87_21.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_84_1.var_[var_87_19 .. "Animator"].applyRootMotion = true
				arg_84_1.var_[var_87_19 .. "LipSync"] = var_87_21.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_87_23 = arg_84_1.actors_["10140ui_story"].transform

			if 3.83333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 3.83333333333333 + arg_87_0 then
				arg_84_1.var_.moveOldPos10140ui_story = var_87_23.localPosition

				local var_87_24 = GameObjectTools.GetOrAddComponent(var_87_23.gameObject, typeof(DynamicBoneHelper))

				if var_87_24 then
					var_87_24:EnableDynamicBone(false)
				end
			end

			local var_87_25 = 0.001

			if 3.83333333333333 <= arg_84_1.time_ and arg_84_1.time_ < 3.83333333333333 + var_87_25 then
				var_87_23.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos10140ui_story, Vector3.New(0, -0.96, -6.29), (arg_84_1.time_ - 3.83333333333333) / var_87_25)
				var_87_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_23.position).x, (manager.ui.mainCamera.transform.position - var_87_23.position).y, (manager.ui.mainCamera.transform.position - var_87_23.position).z)
				var_87_23.localEulerAngles.z = 0
				var_87_23.localEulerAngles.x = 0
				var_87_23.localEulerAngles = var_87_23.localEulerAngles
			end

			if arg_84_1.time_ >= 3.83333333333333 + var_87_25 and arg_84_1.time_ < 3.83333333333333 + var_87_25 + arg_87_0 then
				var_87_23.localPosition = Vector3.New(0, -0.96, -6.29)
				var_87_23.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_23.position).x, (manager.ui.mainCamera.transform.position - var_87_23.position).y, (manager.ui.mainCamera.transform.position - var_87_23.position).z)
				var_87_23.localEulerAngles.z = 0
				var_87_23.localEulerAngles.x = 0
				var_87_23.localEulerAngles = var_87_23.localEulerAngles

				local var_87_26 = GameObjectTools.GetOrAddComponent(var_87_23.gameObject, typeof(DynamicBoneHelper))

				if var_87_26 then
					var_87_26:EnableDynamicBone(true)
				end
			end

			local var_87_27 = arg_84_1.actors_["10140ui_story"]

			if 3.83333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 3.83333333333333 + arg_87_0 and not isNil(var_87_27) and arg_84_1.var_.characterEffect10140ui_story == nil then
				arg_84_1.var_.characterEffect10140ui_story = var_87_27:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_28 = 0.200000002980232

			if 3.83333333333333 <= arg_84_1.time_ and arg_84_1.time_ < 3.83333333333333 + var_87_28 and not isNil(var_87_27) then
				if arg_84_1.var_.characterEffect10140ui_story and not isNil(var_87_27) then
					arg_84_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 3.83333333333333 + var_87_28 and arg_84_1.time_ < 3.83333333333333 + var_87_28 + arg_87_0 and not isNil(var_87_27) and arg_84_1.var_.characterEffect10140ui_story then
				arg_84_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 3.83333333333333 + arg_87_0 then
				arg_84_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_1")
			end

			if 3.83333333333333 < arg_84_1.time_ and arg_84_1.time_ <= 3.83333333333333 + arg_87_0 then
				arg_84_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_84_1.time_ and arg_84_1.time_ <= 1.2 + arg_87_0 then
				arg_84_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_room", "")
			end

			if 0.2 < arg_84_1.time_ and arg_84_1.time_ <= 0.2 + arg_87_0 then
				arg_84_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_84_1.frameCnt_ <= 1 then
				arg_84_1.dialog_:SetActive(false)
			end

			local var_87_32 = 4
			local var_87_33 = 0.25

			if 4 < arg_84_1.time_ and arg_84_1.time_ <= var_87_32 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0

				arg_84_1.dialog_:SetActive(true)

				arg_84_1.dialogCg_.alpha = 0

				local var_87_34 = LeanTween.value(arg_84_1.dialog_, 0, 1, 0.3)

				var_87_34:setOnUpdate(LuaHelper.FloatAction(function(arg_88_0)
					arg_84_1.dialogCg_.alpha = arg_88_0
				end))
				var_87_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_84_1.dialog_)
					var_87_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_84_1.duration_ = arg_84_1.duration_ + 0.3

				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_35 = arg_84_1:GetWordFromCfg(303031021)
				local var_87_36 = arg_84_1:FormatText(var_87_35.content)

				arg_84_1.text_.text = var_87_36

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_38 = 10 <= 0 and var_87_33 or var_87_33 * (utf8.len(var_87_36) / 10)

				if (10 <= 0 and var_87_33 or var_87_33 * (utf8.len(var_87_36) / 10)) > 0 and var_87_33 < var_87_38 then
					arg_84_1.talkMaxDuration = var_87_38
					var_87_32 = var_87_32 + 0.3

					if var_87_38 + var_87_32 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_38 + var_87_32
					end
				end

				arg_84_1.text_.text = var_87_36
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031021", "story_v_out_303031.awb") ~= 0 then
					local var_87_39 = manager.audio:GetVoiceLength("story_v_out_303031", "303031021", "story_v_out_303031.awb") / 1000

					if var_87_39 + var_87_32 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_39 + var_87_32
					end

					if var_87_35.prefab_name ~= "" and arg_84_1.actors_[var_87_35.prefab_name] ~= nil then
						local var_87_40 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_35.prefab_name].transform, "story_v_out_303031", "303031021", "story_v_out_303031.awb")

						arg_84_1:RecordAudio("303031021", var_87_40)
						arg_84_1:RecordAudio("303031021", var_87_40)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_303031", "303031021", "story_v_out_303031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_303031", "303031021", "story_v_out_303031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_41 = var_87_32 + 0.3
			local var_87_42 = math.max(var_87_33, arg_84_1.talkMaxDuration)

			if var_87_32 + 0.3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_41 + var_87_42 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_41) / var_87_42

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_41 + var_87_42 and arg_84_1.time_ < var_87_41 + var_87_42 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play303031022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 303031022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play303031023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos10140ui_story = arg_90_1.actors_["10140ui_story"].transform.localPosition

				local var_93_0 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_0 then
					var_93_0:EnableDynamicBone(false)
				end
			end

			local var_93_1 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_1 then
				arg_90_1.actors_["10140ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_90_1.time_ - 0) / var_93_1)
				arg_90_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10140ui_story"].transform.position).z)
				arg_90_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10140ui_story"].transform.localEulerAngles = arg_90_1.actors_["10140ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_1 and arg_90_1.time_ < 0 + var_93_1 + arg_93_0 then
				arg_90_1.actors_["10140ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["10140ui_story"].transform.position).z)
				arg_90_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["10140ui_story"].transform.localEulerAngles = arg_90_1.actors_["10140ui_story"].transform.localEulerAngles

				local var_93_2 = GameObjectTools.GetOrAddComponent(arg_90_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_93_2 then
					var_93_2:EnableDynamicBone(true)
				end
			end

			local var_93_3 = arg_90_1.actors_["10140ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect10140ui_story == nil then
				arg_90_1.var_.characterEffect10140ui_story = var_93_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_4 = 0.200000002980232

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_4 and not isNil(var_93_3) then
				if arg_90_1.var_.characterEffect10140ui_story and not isNil(var_93_3) then
					arg_90_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_90_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_4)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_4 and arg_90_1.time_ < 0 + var_93_4 + arg_93_0 and not isNil(var_93_3) and arg_90_1.var_.characterEffect10140ui_story then
				arg_90_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_90_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_93_5 = 0
			local var_93_6 = 1.35

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_5 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_7 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(303031022).content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 54 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 54)

				if (54 <= 0 and var_93_6 or var_93_6 * (utf8.len(var_93_7) / 54)) > 0 and var_93_6 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_5 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_5
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_10 = math.max(var_93_6, arg_90_1.talkMaxDuration)

			if var_93_5 <= arg_90_1.time_ and arg_90_1.time_ < var_93_5 + var_93_10 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_5) / var_93_10

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_5 + var_93_10 and arg_90_1.time_ < var_93_5 + var_93_10 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play303031023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 303031023
		arg_94_1.duration_ = 10.27

		local var_94_0 = {
			zh = 4.866,
			ja = 10.266
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
				arg_94_0:Play303031024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1084ui_story = arg_94_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_97_0 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 then
				arg_94_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_94_1.time_ - 0) / var_97_0)
				arg_94_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).z)
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles = arg_94_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 then
				arg_94_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_94_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_94_1.actors_["1084ui_story"].transform.position).z)
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_94_1.actors_["1084ui_story"].transform.localEulerAngles = arg_94_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_97_1 = arg_94_1.actors_["1084ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1084ui_story == nil then
				arg_94_1.var_.characterEffect1084ui_story = var_97_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_2 = 0.200000002980232

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_2 and not isNil(var_97_1) then
				if arg_94_1.var_.characterEffect1084ui_story and not isNil(var_97_1) then
					arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_2 and arg_94_1.time_ < 0 + var_97_2 + arg_97_0 and not isNil(var_97_1) and arg_94_1.var_.characterEffect1084ui_story then
				arg_94_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_97_4 = 0
			local var_97_5 = 0.7

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(303031023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 28 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 28)

				if (28 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 28)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031023", "story_v_out_303031.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031023", "story_v_out_303031.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_303031", "303031023", "story_v_out_303031.awb")

						arg_94_1:RecordAudio("303031023", var_97_11)
						arg_94_1:RecordAudio("303031023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_303031", "303031023", "story_v_out_303031.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_303031", "303031023", "story_v_out_303031.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_12 = math.max(var_97_5, arg_94_1.talkMaxDuration)

			if var_97_4 <= arg_94_1.time_ and arg_94_1.time_ < var_97_4 + var_97_12 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_4) / var_97_12

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_4 + var_97_12 and arg_94_1.time_ < var_97_4 + var_97_12 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_94_1:InitPlayNodeList()
	end,
	Play303031024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 303031024
		arg_98_1.duration_ = 14.3

		local var_98_0 = {
			zh = 6.6,
			ja = 14.3
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
				arg_98_0:Play303031025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.var_.moveOldPos10140ui_story = arg_98_1.actors_["10140ui_story"].transform.localPosition

				local var_101_0 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_0 then
					var_101_0:EnableDynamicBone(false)
				end
			end

			local var_101_1 = 0.001

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_1 then
				arg_98_1.actors_["10140ui_story"].transform.localPosition = Vector3.Lerp(arg_98_1.var_.moveOldPos10140ui_story, Vector3.New(0.7, -0.96, -6.29), (arg_98_1.time_ - 0) / var_101_1)
				arg_98_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10140ui_story"].transform.position).z)
				arg_98_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10140ui_story"].transform.localEulerAngles = arg_98_1.actors_["10140ui_story"].transform.localEulerAngles
			end

			if arg_98_1.time_ >= 0 + var_101_1 and arg_98_1.time_ < 0 + var_101_1 + arg_101_0 then
				arg_98_1.actors_["10140ui_story"].transform.localPosition = Vector3.New(0.7, -0.96, -6.29)
				arg_98_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_98_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_98_1.actors_["10140ui_story"].transform.position).z)
				arg_98_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_98_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_98_1.actors_["10140ui_story"].transform.localEulerAngles = arg_98_1.actors_["10140ui_story"].transform.localEulerAngles

				local var_101_2 = GameObjectTools.GetOrAddComponent(arg_98_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_101_2 then
					var_101_2:EnableDynamicBone(true)
				end
			end

			local var_101_3 = arg_98_1.actors_["10140ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect10140ui_story == nil then
				arg_98_1.var_.characterEffect10140ui_story = var_101_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_4 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_4 and not isNil(var_101_3) then
				if arg_98_1.var_.characterEffect10140ui_story and not isNil(var_101_3) then
					arg_98_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_4 and arg_98_1.time_ < 0 + var_101_4 + arg_101_0 and not isNil(var_101_3) and arg_98_1.var_.characterEffect10140ui_story then
				arg_98_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			local var_101_6 = arg_98_1.actors_["1084ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_6) and arg_98_1.var_.characterEffect1084ui_story == nil then
				arg_98_1.var_.characterEffect1084ui_story = var_101_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_7 = 0.200000002980232

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_7 and not isNil(var_101_6) then
				if arg_98_1.var_.characterEffect1084ui_story and not isNil(var_101_6) then
					arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_7)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_7 and arg_98_1.time_ < 0 + var_101_7 + arg_101_0 and not isNil(var_101_6) and arg_98_1.var_.characterEffect1084ui_story then
				arg_98_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_2")
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiC_fahuo", "EmotionTimelineAnimator")
			end

			local var_101_8 = 0
			local var_101_9 = 0.675

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_8 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_10 = arg_98_1:GetWordFromCfg(303031024)
				local var_101_11 = arg_98_1:FormatText(var_101_10.content)

				arg_98_1.text_.text = var_101_11

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_13 = 27 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 27)

				if (27 <= 0 and var_101_9 or var_101_9 * (utf8.len(var_101_11) / 27)) > 0 and var_101_9 < var_101_13 then
					arg_98_1.talkMaxDuration = var_101_13

					if var_101_13 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_13 + var_101_8
					end
				end

				arg_98_1.text_.text = var_101_11
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031024", "story_v_out_303031.awb") ~= 0 then
					local var_101_14 = manager.audio:GetVoiceLength("story_v_out_303031", "303031024", "story_v_out_303031.awb") / 1000

					if var_101_14 + var_101_8 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_14 + var_101_8
					end

					if var_101_10.prefab_name ~= "" and arg_98_1.actors_[var_101_10.prefab_name] ~= nil then
						local var_101_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_10.prefab_name].transform, "story_v_out_303031", "303031024", "story_v_out_303031.awb")

						arg_98_1:RecordAudio("303031024", var_101_15)
						arg_98_1:RecordAudio("303031024", var_101_15)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_303031", "303031024", "story_v_out_303031.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_303031", "303031024", "story_v_out_303031.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_16 = math.max(var_101_9, arg_98_1.talkMaxDuration)

			if var_101_8 <= arg_98_1.time_ and arg_98_1.time_ < var_101_8 + var_101_16 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_8) / var_101_16

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_8 + var_101_16 and arg_98_1.time_ < var_101_8 + var_101_16 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_98_1:InitPlayNodeList()
	end,
	Play303031025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 303031025
		arg_102_1.duration_ = 2

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play303031026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) and arg_102_1.var_.characterEffect1084ui_story == nil then
				arg_102_1.var_.characterEffect1084ui_story = arg_102_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) then
				if arg_102_1.var_.characterEffect1084ui_story and not isNil(arg_102_1.actors_["1084ui_story"]) then
					arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["1084ui_story"]) and arg_102_1.var_.characterEffect1084ui_story then
				arg_102_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_105_2 = arg_102_1.actors_["10140ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect10140ui_story == nil then
				arg_102_1.var_.characterEffect10140ui_story = var_105_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_3 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_3 and not isNil(var_105_2) then
				if arg_102_1.var_.characterEffect10140ui_story and not isNil(var_105_2) then
					arg_102_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_102_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_3)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_3 and arg_102_1.time_ < 0 + var_105_3 + arg_105_0 and not isNil(var_105_2) and arg_102_1.var_.characterEffect10140ui_story then
				arg_102_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_102_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_105_4 = 0
			local var_105_5 = 0.1

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_4 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_6 = arg_102_1:GetWordFromCfg(303031025)
				local var_105_7 = arg_102_1:FormatText(var_105_6.content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 4 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 4)

				if (4 <= 0 and var_105_5 or var_105_5 * (utf8.len(var_105_7) / 4)) > 0 and var_105_5 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_4
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031025", "story_v_out_303031.awb") ~= 0 then
					local var_105_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031025", "story_v_out_303031.awb") / 1000

					if var_105_10 + var_105_4 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_10 + var_105_4
					end

					if var_105_6.prefab_name ~= "" and arg_102_1.actors_[var_105_6.prefab_name] ~= nil then
						local var_105_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_6.prefab_name].transform, "story_v_out_303031", "303031025", "story_v_out_303031.awb")

						arg_102_1:RecordAudio("303031025", var_105_11)
						arg_102_1:RecordAudio("303031025", var_105_11)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_303031", "303031025", "story_v_out_303031.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_303031", "303031025", "story_v_out_303031.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_12 = math.max(var_105_5, arg_102_1.talkMaxDuration)

			if var_105_4 <= arg_102_1.time_ and arg_102_1.time_ < var_105_4 + var_105_12 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_4) / var_105_12

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_4 + var_105_12 and arg_102_1.time_ < var_105_4 + var_105_12 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play303031026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 303031026
		arg_106_1.duration_ = 5

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play303031027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1084ui_story"]) and arg_106_1.var_.characterEffect1084ui_story == nil then
				arg_106_1.var_.characterEffect1084ui_story = arg_106_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.200000002980232

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1084ui_story"]) then
				if arg_106_1.var_.characterEffect1084ui_story and not isNil(arg_106_1.actors_["1084ui_story"]) then
					arg_106_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_106_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_0)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1084ui_story"]) and arg_106_1.var_.characterEffect1084ui_story then
				arg_106_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_106_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_109_1 = 0
			local var_109_2 = 0.35

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_1 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_106_1.callingController_:SetSelectedState("normal")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_3 = arg_106_1:FormatText(arg_106_1:GetWordFromCfg(303031026).content)

				arg_106_1.text_.text = var_109_3

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_5 = 14 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 14)

				if (14 <= 0 and var_109_2 or var_109_2 * (utf8.len(var_109_3) / 14)) > 0 and var_109_2 < var_109_5 then
					arg_106_1.talkMaxDuration = var_109_5

					if var_109_5 + var_109_1 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + var_109_1
					end
				end

				arg_106_1.text_.text = var_109_3
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)
				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_6 = math.max(var_109_2, arg_106_1.talkMaxDuration)

			if var_109_1 <= arg_106_1.time_ and arg_106_1.time_ < var_109_1 + var_109_6 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_1) / var_109_6

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_1 + var_109_6 and arg_106_1.time_ < var_109_1 + var_109_6 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play303031027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 303031027
		arg_110_1.duration_ = 3.83

		local var_110_0 = {
			zh = 2.766,
			ja = 3.833
		}
		local var_110_1 = manager.audio:GetLocalizationFlag()

		if var_110_0[var_110_1] ~= nil then
			arg_110_1.duration_ = var_110_0[var_110_1]
		end

		SetActive(arg_110_1.tipsGo_, false)

		function arg_110_1.onSingleLineFinish_()
			arg_110_1.onSingleLineUpdate_ = nil
			arg_110_1.onSingleLineFinish_ = nil
			arg_110_1.state_ = "waiting"
		end

		function arg_110_1.playNext_(arg_112_0)
			if arg_112_0 == 1 then
				arg_110_0:Play303031028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(arg_110_1.actors_["10140ui_story"]) and arg_110_1.var_.characterEffect10140ui_story == nil then
				arg_110_1.var_.characterEffect10140ui_story = arg_110_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_0 = 0.200000002980232

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_0 and not isNil(arg_110_1.actors_["10140ui_story"]) then
				if arg_110_1.var_.characterEffect10140ui_story and not isNil(arg_110_1.actors_["10140ui_story"]) then
					arg_110_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_0 and arg_110_1.time_ < 0 + var_113_0 + arg_113_0 and not isNil(arg_110_1.actors_["10140ui_story"]) and arg_110_1.var_.characterEffect10140ui_story then
				arg_110_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action1_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_113_2 = 0
			local var_113_3 = 0.225

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_2 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_4 = arg_110_1:GetWordFromCfg(303031027)
				local var_113_5 = arg_110_1:FormatText(var_113_4.content)

				arg_110_1.text_.text = var_113_5

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_7 = 9 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 9)

				if (9 <= 0 and var_113_3 or var_113_3 * (utf8.len(var_113_5) / 9)) > 0 and var_113_3 < var_113_7 then
					arg_110_1.talkMaxDuration = var_113_7

					if var_113_7 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_7 + var_113_2
					end
				end

				arg_110_1.text_.text = var_113_5
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031027", "story_v_out_303031.awb") ~= 0 then
					local var_113_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031027", "story_v_out_303031.awb") / 1000

					if var_113_8 + var_113_2 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_8 + var_113_2
					end

					if var_113_4.prefab_name ~= "" and arg_110_1.actors_[var_113_4.prefab_name] ~= nil then
						local var_113_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_4.prefab_name].transform, "story_v_out_303031", "303031027", "story_v_out_303031.awb")

						arg_110_1:RecordAudio("303031027", var_113_9)
						arg_110_1:RecordAudio("303031027", var_113_9)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_303031", "303031027", "story_v_out_303031.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_303031", "303031027", "story_v_out_303031.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_10 = math.max(var_113_3, arg_110_1.talkMaxDuration)

			if var_113_2 <= arg_110_1.time_ and arg_110_1.time_ < var_113_2 + var_113_10 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_2) / var_113_10

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_2 + var_113_10 and arg_110_1.time_ < var_113_2 + var_113_10 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play303031028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 303031028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play303031029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["10140ui_story"]) and arg_114_1.var_.characterEffect10140ui_story == nil then
				arg_114_1.var_.characterEffect10140ui_story = arg_114_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["10140ui_story"]) then
				if arg_114_1.var_.characterEffect10140ui_story and not isNil(arg_114_1.actors_["10140ui_story"]) then
					arg_114_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_114_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["10140ui_story"]) and arg_114_1.var_.characterEffect10140ui_story then
				arg_114_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_114_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_117_1 = 0
			local var_117_2 = 1.225

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_1 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, true)
				arg_114_1.iconController_:SetSelectedState("hero")

				arg_114_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_114_1.callingController_:SetSelectedState("normal")

				arg_114_1.keyicon_.color = Color.New(1, 1, 1)
				arg_114_1.icon_.color = Color.New(1, 1, 1)

				local var_117_3 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(303031028).content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 49 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 49)

				if (49 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 49)) > 0 and var_117_2 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_1 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_1
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_6 = math.max(var_117_2, arg_114_1.talkMaxDuration)

			if var_117_1 <= arg_114_1.time_ and arg_114_1.time_ < var_117_1 + var_117_6 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_1) / var_117_6

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_1 + var_117_6 and arg_114_1.time_ < var_117_1 + var_117_6 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play303031029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 303031029
		arg_118_1.duration_ = 9.1

		local var_118_0 = {
			zh = 4.5,
			ja = 9.1
		}
		local var_118_1 = manager.audio:GetLocalizationFlag()

		if var_118_0[var_118_1] ~= nil then
			arg_118_1.duration_ = var_118_0[var_118_1]
		end

		SetActive(arg_118_1.tipsGo_, false)

		function arg_118_1.onSingleLineFinish_()
			arg_118_1.onSingleLineUpdate_ = nil
			arg_118_1.onSingleLineFinish_ = nil
			arg_118_1.state_ = "waiting"
		end

		function arg_118_1.playNext_(arg_120_0)
			if arg_120_0 == 1 then
				arg_118_0:Play303031030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["10140ui_story"]) and arg_118_1.var_.characterEffect10140ui_story == nil then
				arg_118_1.var_.characterEffect10140ui_story = arg_118_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.200000002980232

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["10140ui_story"]) then
				if arg_118_1.var_.characterEffect10140ui_story and not isNil(arg_118_1.actors_["10140ui_story"]) then
					arg_118_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["10140ui_story"]) and arg_118_1.var_.characterEffect10140ui_story then
				arg_118_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action4_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_121_2 = 0
			local var_121_3 = 0.45

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_2 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_4 = arg_118_1:GetWordFromCfg(303031029)
				local var_121_5 = arg_118_1:FormatText(var_121_4.content)

				arg_118_1.text_.text = var_121_5

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_7 = 18 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 18)

				if (18 <= 0 and var_121_3 or var_121_3 * (utf8.len(var_121_5) / 18)) > 0 and var_121_3 < var_121_7 then
					arg_118_1.talkMaxDuration = var_121_7

					if var_121_7 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_7 + var_121_2
					end
				end

				arg_118_1.text_.text = var_121_5
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031029", "story_v_out_303031.awb") ~= 0 then
					local var_121_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031029", "story_v_out_303031.awb") / 1000

					if var_121_8 + var_121_2 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_8 + var_121_2
					end

					if var_121_4.prefab_name ~= "" and arg_118_1.actors_[var_121_4.prefab_name] ~= nil then
						local var_121_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_4.prefab_name].transform, "story_v_out_303031", "303031029", "story_v_out_303031.awb")

						arg_118_1:RecordAudio("303031029", var_121_9)
						arg_118_1:RecordAudio("303031029", var_121_9)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_303031", "303031029", "story_v_out_303031.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_303031", "303031029", "story_v_out_303031.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_10 = math.max(var_121_3, arg_118_1.talkMaxDuration)

			if var_121_2 <= arg_118_1.time_ and arg_118_1.time_ < var_121_2 + var_121_10 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_2) / var_121_10

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_2 + var_121_10 and arg_118_1.time_ < var_121_2 + var_121_10 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {}

		arg_118_1:InitPlayNodeList()
	end,
	Play303031030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 303031030
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play303031031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["10140ui_story"]) and arg_122_1.var_.characterEffect10140ui_story == nil then
				arg_122_1.var_.characterEffect10140ui_story = arg_122_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.200000002980232

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["10140ui_story"]) then
				if arg_122_1.var_.characterEffect10140ui_story and not isNil(arg_122_1.actors_["10140ui_story"]) then
					arg_122_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_122_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_0)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["10140ui_story"]) and arg_122_1.var_.characterEffect10140ui_story then
				arg_122_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_122_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_125_1 = 0
			local var_125_2 = 0.95

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_1 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_3 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(303031030).content)

				arg_122_1.text_.text = var_125_3

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_5 = 38 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 38)

				if (38 <= 0 and var_125_2 or var_125_2 * (utf8.len(var_125_3) / 38)) > 0 and var_125_2 < var_125_5 then
					arg_122_1.talkMaxDuration = var_125_5

					if var_125_5 + var_125_1 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_5 + var_125_1
					end
				end

				arg_122_1.text_.text = var_125_3
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_6 = math.max(var_125_2, arg_122_1.talkMaxDuration)

			if var_125_1 <= arg_122_1.time_ and arg_122_1.time_ < var_125_1 + var_125_6 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_1) / var_125_6

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_1 + var_125_6 and arg_122_1.time_ < var_125_1 + var_125_6 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play303031031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 303031031
		arg_126_1.duration_ = 5.97

		local var_126_0 = {
			zh = 4,
			ja = 5.966
		}
		local var_126_1 = manager.audio:GetLocalizationFlag()

		if var_126_0[var_126_1] ~= nil then
			arg_126_1.duration_ = var_126_0[var_126_1]
		end

		SetActive(arg_126_1.tipsGo_, false)

		function arg_126_1.onSingleLineFinish_()
			arg_126_1.onSingleLineUpdate_ = nil
			arg_126_1.onSingleLineFinish_ = nil
			arg_126_1.state_ = "waiting"
		end

		function arg_126_1.playNext_(arg_128_0)
			if arg_128_0 == 1 then
				arg_126_0:Play303031032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["10140ui_story"]) and arg_126_1.var_.characterEffect10140ui_story == nil then
				arg_126_1.var_.characterEffect10140ui_story = arg_126_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.200000002980232

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["10140ui_story"]) then
				if arg_126_1.var_.characterEffect10140ui_story and not isNil(arg_126_1.actors_["10140ui_story"]) then
					arg_126_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["10140ui_story"]) and arg_126_1.var_.characterEffect10140ui_story then
				arg_126_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action4_2")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_129_2 = 0
			local var_129_3 = 0.375

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_2 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_4 = arg_126_1:GetWordFromCfg(303031031)
				local var_129_5 = arg_126_1:FormatText(var_129_4.content)

				arg_126_1.text_.text = var_129_5

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_7 = 15 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_5) / 15)

				if (15 <= 0 and var_129_3 or var_129_3 * (utf8.len(var_129_5) / 15)) > 0 and var_129_3 < var_129_7 then
					arg_126_1.talkMaxDuration = var_129_7

					if var_129_7 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_7 + var_129_2
					end
				end

				arg_126_1.text_.text = var_129_5
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031031", "story_v_out_303031.awb") ~= 0 then
					local var_129_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031031", "story_v_out_303031.awb") / 1000

					if var_129_8 + var_129_2 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_8 + var_129_2
					end

					if var_129_4.prefab_name ~= "" and arg_126_1.actors_[var_129_4.prefab_name] ~= nil then
						local var_129_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_4.prefab_name].transform, "story_v_out_303031", "303031031", "story_v_out_303031.awb")

						arg_126_1:RecordAudio("303031031", var_129_9)
						arg_126_1:RecordAudio("303031031", var_129_9)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_303031", "303031031", "story_v_out_303031.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_303031", "303031031", "story_v_out_303031.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_10 = math.max(var_129_3, arg_126_1.talkMaxDuration)

			if var_129_2 <= arg_126_1.time_ and arg_126_1.time_ < var_129_2 + var_129_10 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_2) / var_129_10

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_2 + var_129_10 and arg_126_1.time_ < var_129_2 + var_129_10 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {}

		arg_126_1:InitPlayNodeList()
	end,
	Play303031032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 303031032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play303031033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["10140ui_story"]) and arg_130_1.var_.characterEffect10140ui_story == nil then
				arg_130_1.var_.characterEffect10140ui_story = arg_130_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.200000002980232

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["10140ui_story"]) then
				if arg_130_1.var_.characterEffect10140ui_story and not isNil(arg_130_1.actors_["10140ui_story"]) then
					arg_130_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_130_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["10140ui_story"]) and arg_130_1.var_.characterEffect10140ui_story then
				arg_130_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_130_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_133_1 = 0
			local var_133_2 = 0.425

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, true)
				arg_130_1.iconController_:SetSelectedState("hero")

				arg_130_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_130_1.callingController_:SetSelectedState("normal")

				arg_130_1.keyicon_.color = Color.New(1, 1, 1)
				arg_130_1.icon_.color = Color.New(1, 1, 1)

				local var_133_3 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(303031032).content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 17 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 17)

				if (17 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 17)) > 0 and var_133_2 < var_133_5 then
					arg_130_1.talkMaxDuration = var_133_5

					if var_133_5 + var_133_1 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_5 + var_133_1
					end
				end

				arg_130_1.text_.text = var_133_3
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)
				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_6 = math.max(var_133_2, arg_130_1.talkMaxDuration)

			if var_133_1 <= arg_130_1.time_ and arg_130_1.time_ < var_133_1 + var_133_6 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_1) / var_133_6

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_1 + var_133_6 and arg_130_1.time_ < var_133_1 + var_133_6 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {}

		arg_130_1:InitPlayNodeList()
	end,
	Play303031033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 303031033
		arg_134_1.duration_ = 8.37

		local var_134_0 = {
			zh = 5.7,
			ja = 8.366
		}
		local var_134_1 = manager.audio:GetLocalizationFlag()

		if var_134_0[var_134_1] ~= nil then
			arg_134_1.duration_ = var_134_0[var_134_1]
		end

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play303031034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["10140ui_story"]) and arg_134_1.var_.characterEffect10140ui_story == nil then
				arg_134_1.var_.characterEffect10140ui_story = arg_134_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.200000002980232

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["10140ui_story"]) then
				if arg_134_1.var_.characterEffect10140ui_story and not isNil(arg_134_1.actors_["10140ui_story"]) then
					arg_134_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["10140ui_story"]) and arg_134_1.var_.characterEffect10140ui_story then
				arg_134_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action1_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_137_2 = 0
			local var_137_3 = 0.475

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(303031033)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 19 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 19)

				if (19 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 19)) > 0 and var_137_3 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031033", "story_v_out_303031.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031033", "story_v_out_303031.awb") / 1000

					if var_137_8 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_2
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_303031", "303031033", "story_v_out_303031.awb")

						arg_134_1:RecordAudio("303031033", var_137_9)
						arg_134_1:RecordAudio("303031033", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_303031", "303031033", "story_v_out_303031.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_303031", "303031033", "story_v_out_303031.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_10 = math.max(var_137_3, arg_134_1.talkMaxDuration)

			if var_137_2 <= arg_134_1.time_ and arg_134_1.time_ < var_137_2 + var_137_10 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_2) / var_137_10

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_2 + var_137_10 and arg_134_1.time_ < var_137_2 + var_137_10 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {}

		arg_134_1:InitPlayNodeList()
	end,
	Play303031034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 303031034
		arg_138_1.duration_ = 5

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play303031035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["10140ui_story"]) and arg_138_1.var_.characterEffect10140ui_story == nil then
				arg_138_1.var_.characterEffect10140ui_story = arg_138_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.200000002980232

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["10140ui_story"]) then
				if arg_138_1.var_.characterEffect10140ui_story and not isNil(arg_138_1.actors_["10140ui_story"]) then
					arg_138_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_138_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_0)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["10140ui_story"]) and arg_138_1.var_.characterEffect10140ui_story then
				arg_138_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_138_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_141_1 = 0
			local var_141_2 = 0.9

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_1 + arg_141_0 then
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

				local var_141_3 = arg_138_1:FormatText(arg_138_1:GetWordFromCfg(303031034).content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 36 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 36)

				if (36 <= 0 and var_141_2 or var_141_2 * (utf8.len(var_141_3) / 36)) > 0 and var_141_2 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_1 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_1
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)
				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_6 = math.max(var_141_2, arg_138_1.talkMaxDuration)

			if var_141_1 <= arg_138_1.time_ and arg_138_1.time_ < var_141_1 + var_141_6 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_1) / var_141_6

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_1 + var_141_6 and arg_138_1.time_ < var_141_1 + var_141_6 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play303031035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 303031035
		arg_142_1.duration_ = 5.47

		local var_142_0 = {
			zh = 3.7,
			ja = 5.466
		}
		local var_142_1 = manager.audio:GetLocalizationFlag()

		if var_142_0[var_142_1] ~= nil then
			arg_142_1.duration_ = var_142_0[var_142_1]
		end

		SetActive(arg_142_1.tipsGo_, false)

		function arg_142_1.onSingleLineFinish_()
			arg_142_1.onSingleLineUpdate_ = nil
			arg_142_1.onSingleLineFinish_ = nil
			arg_142_1.state_ = "waiting"
		end

		function arg_142_1.playNext_(arg_144_0)
			if arg_144_0 == 1 then
				arg_142_0:Play303031036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 and not isNil(arg_142_1.actors_["10140ui_story"]) and arg_142_1.var_.characterEffect10140ui_story == nil then
				arg_142_1.var_.characterEffect10140ui_story = arg_142_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_145_0 = 0.200000002980232

			if 0 <= arg_142_1.time_ and arg_142_1.time_ < 0 + var_145_0 and not isNil(arg_142_1.actors_["10140ui_story"]) then
				if arg_142_1.var_.characterEffect10140ui_story and not isNil(arg_142_1.actors_["10140ui_story"]) then
					arg_142_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_142_1.time_ >= 0 + var_145_0 and arg_142_1.time_ < 0 + var_145_0 + arg_145_0 and not isNil(arg_142_1.actors_["10140ui_story"]) and arg_142_1.var_.characterEffect10140ui_story then
				arg_142_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_1")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoB", "EmotionTimelineAnimator")
			end

			local var_145_2 = 0
			local var_145_3 = 0.3

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_2 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_4 = arg_142_1:GetWordFromCfg(303031035)
				local var_145_5 = arg_142_1:FormatText(var_145_4.content)

				arg_142_1.text_.text = var_145_5

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_7 = 12 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 12)

				if (12 <= 0 and var_145_3 or var_145_3 * (utf8.len(var_145_5) / 12)) > 0 and var_145_3 < var_145_7 then
					arg_142_1.talkMaxDuration = var_145_7

					if var_145_7 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_7 + var_145_2
					end
				end

				arg_142_1.text_.text = var_145_5
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031035", "story_v_out_303031.awb") ~= 0 then
					local var_145_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031035", "story_v_out_303031.awb") / 1000

					if var_145_8 + var_145_2 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_8 + var_145_2
					end

					if var_145_4.prefab_name ~= "" and arg_142_1.actors_[var_145_4.prefab_name] ~= nil then
						local var_145_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_4.prefab_name].transform, "story_v_out_303031", "303031035", "story_v_out_303031.awb")

						arg_142_1:RecordAudio("303031035", var_145_9)
						arg_142_1:RecordAudio("303031035", var_145_9)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_303031", "303031035", "story_v_out_303031.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_303031", "303031035", "story_v_out_303031.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_10 = math.max(var_145_3, arg_142_1.talkMaxDuration)

			if var_145_2 <= arg_142_1.time_ and arg_142_1.time_ < var_145_2 + var_145_10 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_2) / var_145_10

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_2 + var_145_10 and arg_142_1.time_ < var_145_2 + var_145_10 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play303031036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 303031036
		arg_146_1.duration_ = 5

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play303031037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["10140ui_story"]) and arg_146_1.var_.characterEffect10140ui_story == nil then
				arg_146_1.var_.characterEffect10140ui_story = arg_146_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.200000002980232

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["10140ui_story"]) then
				if arg_146_1.var_.characterEffect10140ui_story and not isNil(arg_146_1.actors_["10140ui_story"]) then
					arg_146_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_146_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_0)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["10140ui_story"]) and arg_146_1.var_.characterEffect10140ui_story then
				arg_146_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_146_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_149_1 = 0
			local var_149_2 = 0.4

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_1 + arg_149_0 then
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

				local var_149_3 = arg_146_1:FormatText(arg_146_1:GetWordFromCfg(303031036).content)

				arg_146_1.text_.text = var_149_3

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_5 = 16 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 16)

				if (16 <= 0 and var_149_2 or var_149_2 * (utf8.len(var_149_3) / 16)) > 0 and var_149_2 < var_149_5 then
					arg_146_1.talkMaxDuration = var_149_5

					if var_149_5 + var_149_1 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_5 + var_149_1
					end
				end

				arg_146_1.text_.text = var_149_3
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)
				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_6 = math.max(var_149_2, arg_146_1.talkMaxDuration)

			if var_149_1 <= arg_146_1.time_ and arg_146_1.time_ < var_149_1 + var_149_6 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_1) / var_149_6

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_1 + var_149_6 and arg_146_1.time_ < var_149_1 + var_149_6 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {}

		arg_146_1:InitPlayNodeList()
	end,
	Play303031037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 303031037
		arg_150_1.duration_ = 5

		local var_150_0 = {
			zh = 4.633,
			ja = 5
		}
		local var_150_1 = manager.audio:GetLocalizationFlag()

		if var_150_0[var_150_1] ~= nil then
			arg_150_1.duration_ = var_150_0[var_150_1]
		end

		SetActive(arg_150_1.tipsGo_, false)

		function arg_150_1.onSingleLineFinish_()
			arg_150_1.onSingleLineUpdate_ = nil
			arg_150_1.onSingleLineFinish_ = nil
			arg_150_1.state_ = "waiting"
		end

		function arg_150_1.playNext_(arg_152_0)
			if arg_152_0 == 1 then
				arg_150_0:Play303031038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["10140ui_story"]) and arg_150_1.var_.characterEffect10140ui_story == nil then
				arg_150_1.var_.characterEffect10140ui_story = arg_150_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.200000002980232

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["10140ui_story"]) then
				if arg_150_1.var_.characterEffect10140ui_story and not isNil(arg_150_1.actors_["10140ui_story"]) then
					arg_150_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["10140ui_story"]) and arg_150_1.var_.characterEffect10140ui_story then
				arg_150_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140actionlink/10140action484")
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_kunraoA_sikao", "EmotionTimelineAnimator")
			end

			local var_153_2 = 0
			local var_153_3 = 0.525

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_2 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_4 = arg_150_1:GetWordFromCfg(303031037)
				local var_153_5 = arg_150_1:FormatText(var_153_4.content)

				arg_150_1.text_.text = var_153_5

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_7 = 21 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_5) / 21)

				if (21 <= 0 and var_153_3 or var_153_3 * (utf8.len(var_153_5) / 21)) > 0 and var_153_3 < var_153_7 then
					arg_150_1.talkMaxDuration = var_153_7

					if var_153_7 + var_153_2 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_7 + var_153_2
					end
				end

				arg_150_1.text_.text = var_153_5
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031037", "story_v_out_303031.awb") ~= 0 then
					local var_153_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031037", "story_v_out_303031.awb") / 1000

					if var_153_8 + var_153_2 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_8 + var_153_2
					end

					if var_153_4.prefab_name ~= "" and arg_150_1.actors_[var_153_4.prefab_name] ~= nil then
						local var_153_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_4.prefab_name].transform, "story_v_out_303031", "303031037", "story_v_out_303031.awb")

						arg_150_1:RecordAudio("303031037", var_153_9)
						arg_150_1:RecordAudio("303031037", var_153_9)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_303031", "303031037", "story_v_out_303031.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_303031", "303031037", "story_v_out_303031.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_10 = math.max(var_153_3, arg_150_1.talkMaxDuration)

			if var_153_2 <= arg_150_1.time_ and arg_150_1.time_ < var_153_2 + var_153_10 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_2) / var_153_10

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_2 + var_153_10 and arg_150_1.time_ < var_153_2 + var_153_10 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {}

		arg_150_1:InitPlayNodeList()
	end,
	Play303031038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 303031038
		arg_154_1.duration_ = 5

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play303031039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["10140ui_story"]) and arg_154_1.var_.characterEffect10140ui_story == nil then
				arg_154_1.var_.characterEffect10140ui_story = arg_154_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.200000002980232

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["10140ui_story"]) then
				if arg_154_1.var_.characterEffect10140ui_story and not isNil(arg_154_1.actors_["10140ui_story"]) then
					arg_154_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_154_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_0)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["10140ui_story"]) and arg_154_1.var_.characterEffect10140ui_story then
				arg_154_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_154_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_157_1 = 0
			local var_157_2 = 0.4

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_1 + arg_157_0 then
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

				local var_157_3 = arg_154_1:FormatText(arg_154_1:GetWordFromCfg(303031038).content)

				arg_154_1.text_.text = var_157_3

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_5 = 16 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 16)

				if (16 <= 0 and var_157_2 or var_157_2 * (utf8.len(var_157_3) / 16)) > 0 and var_157_2 < var_157_5 then
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
	Play303031039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 303031039
		arg_158_1.duration_ = 5

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play303031040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			local var_161_0 = 1.025

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

				local var_161_1 = arg_158_1:FormatText(arg_158_1:GetWordFromCfg(303031039).content)

				arg_158_1.text_.text = var_161_1

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_3 = 41 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 41)

				if (41 <= 0 and var_161_0 or var_161_0 * (utf8.len(var_161_1) / 41)) > 0 and var_161_0 < var_161_3 then
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
	Play303031040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 303031040
		arg_162_1.duration_ = 10.3

		local var_162_0 = {
			zh = 7.9,
			ja = 10.3
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
				arg_162_0:Play303031041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["10140ui_story"]) and arg_162_1.var_.characterEffect10140ui_story == nil then
				arg_162_1.var_.characterEffect10140ui_story = arg_162_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.200000002980232

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["10140ui_story"]) then
				if arg_162_1.var_.characterEffect10140ui_story and not isNil(arg_162_1.actors_["10140ui_story"]) then
					arg_162_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["10140ui_story"]) and arg_162_1.var_.characterEffect10140ui_story then
				arg_162_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action4_2")
			end

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 then
				arg_162_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_165_2 = 0
			local var_165_3 = 0.9

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_2 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, true)

				arg_162_1.leftNameTxt_.text = arg_162_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_162_1.leftNameTxt_.transform)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1.leftNameTxt_.text)
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_4 = arg_162_1:GetWordFromCfg(303031040)
				local var_165_5 = arg_162_1:FormatText(var_165_4.content)

				arg_162_1.text_.text = var_165_5

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_7 = 36 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 36)

				if (36 <= 0 and var_165_3 or var_165_3 * (utf8.len(var_165_5) / 36)) > 0 and var_165_3 < var_165_7 then
					arg_162_1.talkMaxDuration = var_165_7

					if var_165_7 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_7 + var_165_2
					end
				end

				arg_162_1.text_.text = var_165_5
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031040", "story_v_out_303031.awb") ~= 0 then
					local var_165_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031040", "story_v_out_303031.awb") / 1000

					if var_165_8 + var_165_2 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_8 + var_165_2
					end

					if var_165_4.prefab_name ~= "" and arg_162_1.actors_[var_165_4.prefab_name] ~= nil then
						local var_165_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_162_1.actors_[var_165_4.prefab_name].transform, "story_v_out_303031", "303031040", "story_v_out_303031.awb")

						arg_162_1:RecordAudio("303031040", var_165_9)
						arg_162_1:RecordAudio("303031040", var_165_9)
					else
						arg_162_1:AudioAction("play", "voice", "story_v_out_303031", "303031040", "story_v_out_303031.awb")
					end

					arg_162_1:RecordHistoryTalkVoice("story_v_out_303031", "303031040", "story_v_out_303031.awb")
				end

				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_10 = math.max(var_165_3, arg_162_1.talkMaxDuration)

			if var_165_2 <= arg_162_1.time_ and arg_162_1.time_ < var_165_2 + var_165_10 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_2) / var_165_10

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_2 + var_165_10 and arg_162_1.time_ < var_165_2 + var_165_10 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play303031041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 303031041
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play303031042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["10140ui_story"]) and arg_166_1.var_.characterEffect10140ui_story == nil then
				arg_166_1.var_.characterEffect10140ui_story = arg_166_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["10140ui_story"]) then
				if arg_166_1.var_.characterEffect10140ui_story and not isNil(arg_166_1.actors_["10140ui_story"]) then
					arg_166_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_166_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_166_1.time_ - 0) / var_169_0)
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["10140ui_story"]) and arg_166_1.var_.characterEffect10140ui_story then
				arg_166_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_166_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_169_1 = 0
			local var_169_2 = 0.325

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_1 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, true)
				arg_166_1.iconController_:SetSelectedState("hero")

				arg_166_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_166_1.callingController_:SetSelectedState("normal")

				arg_166_1.keyicon_.color = Color.New(1, 1, 1)
				arg_166_1.icon_.color = Color.New(1, 1, 1)

				local var_169_3 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(303031041).content)

				arg_166_1.text_.text = var_169_3

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_5 = 13 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 13)

				if (13 <= 0 and var_169_2 or var_169_2 * (utf8.len(var_169_3) / 13)) > 0 and var_169_2 < var_169_5 then
					arg_166_1.talkMaxDuration = var_169_5

					if var_169_5 + var_169_1 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_5 + var_169_1
					end
				end

				arg_166_1.text_.text = var_169_3
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_6 = math.max(var_169_2, arg_166_1.talkMaxDuration)

			if var_169_1 <= arg_166_1.time_ and arg_166_1.time_ < var_169_1 + var_169_6 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_1) / var_169_6

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_1 + var_169_6 and arg_166_1.time_ < var_169_1 + var_169_6 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play303031042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 303031042
		arg_170_1.duration_ = 4.7

		local var_170_0 = {
			zh = 4.6,
			ja = 4.7
		}
		local var_170_1 = manager.audio:GetLocalizationFlag()

		if var_170_0[var_170_1] ~= nil then
			arg_170_1.duration_ = var_170_0[var_170_1]
		end

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play303031043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(arg_170_1.actors_["10140ui_story"]) and arg_170_1.var_.characterEffect10140ui_story == nil then
				arg_170_1.var_.characterEffect10140ui_story = arg_170_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_0 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 and not isNil(arg_170_1.actors_["10140ui_story"]) then
				if arg_170_1.var_.characterEffect10140ui_story and not isNil(arg_170_1.actors_["10140ui_story"]) then
					arg_170_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 and not isNil(arg_170_1.actors_["10140ui_story"]) and arg_170_1.var_.characterEffect10140ui_story then
				arg_170_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action1_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_173_2 = 0
			local var_173_3 = 0.45

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_2 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_4 = arg_170_1:GetWordFromCfg(303031042)
				local var_173_5 = arg_170_1:FormatText(var_173_4.content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 18 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 18)

				if (18 <= 0 and var_173_3 or var_173_3 * (utf8.len(var_173_5) / 18)) > 0 and var_173_3 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_2
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031042", "story_v_out_303031.awb") ~= 0 then
					local var_173_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031042", "story_v_out_303031.awb") / 1000

					if var_173_8 + var_173_2 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_8 + var_173_2
					end

					if var_173_4.prefab_name ~= "" and arg_170_1.actors_[var_173_4.prefab_name] ~= nil then
						local var_173_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_4.prefab_name].transform, "story_v_out_303031", "303031042", "story_v_out_303031.awb")

						arg_170_1:RecordAudio("303031042", var_173_9)
						arg_170_1:RecordAudio("303031042", var_173_9)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_303031", "303031042", "story_v_out_303031.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_303031", "303031042", "story_v_out_303031.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_10 = math.max(var_173_3, arg_170_1.talkMaxDuration)

			if var_173_2 <= arg_170_1.time_ and arg_170_1.time_ < var_173_2 + var_173_10 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_2) / var_173_10

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_2 + var_173_10 and arg_170_1.time_ < var_173_2 + var_173_10 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play303031043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 303031043
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play303031044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["10140ui_story"]) and arg_174_1.var_.characterEffect10140ui_story == nil then
				arg_174_1.var_.characterEffect10140ui_story = arg_174_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.200000002980232

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["10140ui_story"]) then
				if arg_174_1.var_.characterEffect10140ui_story and not isNil(arg_174_1.actors_["10140ui_story"]) then
					arg_174_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_174_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["10140ui_story"]) and arg_174_1.var_.characterEffect10140ui_story then
				arg_174_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_174_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_177_1 = 0
			local var_177_2 = 0.35

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_1 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_3 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(303031043).content)

				arg_174_1.text_.text = var_177_3

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_5 = 14 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 14)

				if (14 <= 0 and var_177_2 or var_177_2 * (utf8.len(var_177_3) / 14)) > 0 and var_177_2 < var_177_5 then
					arg_174_1.talkMaxDuration = var_177_5

					if var_177_5 + var_177_1 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_5 + var_177_1
					end
				end

				arg_174_1.text_.text = var_177_3
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_6 = math.max(var_177_2, arg_174_1.talkMaxDuration)

			if var_177_1 <= arg_174_1.time_ and arg_174_1.time_ < var_177_1 + var_177_6 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_1) / var_177_6

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_1 + var_177_6 and arg_174_1.time_ < var_177_1 + var_177_6 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play303031044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 303031044
		arg_178_1.duration_ = 8.83

		local var_178_0 = {
			zh = 5.666,
			ja = 8.833
		}
		local var_178_1 = manager.audio:GetLocalizationFlag()

		if var_178_0[var_178_1] ~= nil then
			arg_178_1.duration_ = var_178_0[var_178_1]
		end

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play303031045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(arg_178_1.actors_["10140ui_story"]) and arg_178_1.var_.characterEffect10140ui_story == nil then
				arg_178_1.var_.characterEffect10140ui_story = arg_178_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_0 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 and not isNil(arg_178_1.actors_["10140ui_story"]) then
				if arg_178_1.var_.characterEffect10140ui_story and not isNil(arg_178_1.actors_["10140ui_story"]) then
					arg_178_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 and not isNil(arg_178_1.actors_["10140ui_story"]) and arg_178_1.var_.characterEffect10140ui_story then
				arg_178_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action4_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_181_2 = 0
			local var_181_3 = 0.5

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_2 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_4 = arg_178_1:GetWordFromCfg(303031044)
				local var_181_5 = arg_178_1:FormatText(var_181_4.content)

				arg_178_1.text_.text = var_181_5

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_7 = 20 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_5) / 20)

				if (20 <= 0 and var_181_3 or var_181_3 * (utf8.len(var_181_5) / 20)) > 0 and var_181_3 < var_181_7 then
					arg_178_1.talkMaxDuration = var_181_7

					if var_181_7 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_7 + var_181_2
					end
				end

				arg_178_1.text_.text = var_181_5
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031044", "story_v_out_303031.awb") ~= 0 then
					local var_181_8 = manager.audio:GetVoiceLength("story_v_out_303031", "303031044", "story_v_out_303031.awb") / 1000

					if var_181_8 + var_181_2 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_2
					end

					if var_181_4.prefab_name ~= "" and arg_178_1.actors_[var_181_4.prefab_name] ~= nil then
						local var_181_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_4.prefab_name].transform, "story_v_out_303031", "303031044", "story_v_out_303031.awb")

						arg_178_1:RecordAudio("303031044", var_181_9)
						arg_178_1:RecordAudio("303031044", var_181_9)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_303031", "303031044", "story_v_out_303031.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_303031", "303031044", "story_v_out_303031.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_10 = math.max(var_181_3, arg_178_1.talkMaxDuration)

			if var_181_2 <= arg_178_1.time_ and arg_178_1.time_ < var_181_2 + var_181_10 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_2) / var_181_10

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_2 + var_181_10 and arg_178_1.time_ < var_181_2 + var_181_10 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play303031045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 303031045
		arg_182_1.duration_ = 10.3

		local var_182_0 = {
			zh = 6.433,
			ja = 10.3
		}
		local var_182_1 = manager.audio:GetLocalizationFlag()

		if var_182_0[var_182_1] ~= nil then
			arg_182_1.duration_ = var_182_0[var_182_1]
		end

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play303031046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.75

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_1 = arg_182_1:GetWordFromCfg(303031045)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 30 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 30)

				if (30 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 30)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031045", "story_v_out_303031.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_303031", "303031045", "story_v_out_303031.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_303031", "303031045", "story_v_out_303031.awb")

						arg_182_1:RecordAudio("303031045", var_185_6)
						arg_182_1:RecordAudio("303031045", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_303031", "303031045", "story_v_out_303031.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_303031", "303031045", "story_v_out_303031.awb")
				end

				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_7 = math.max(var_185_0, arg_182_1.talkMaxDuration)

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_7 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - 0) / var_185_7

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= 0 + var_185_7 and arg_182_1.time_ < 0 + var_185_7 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {}

		arg_182_1:InitPlayNodeList()
	end,
	Play303031046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 303031046
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play303031047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_9000

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1084ui_story = arg_186_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_189_0 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_0 then
				arg_186_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_0)
				arg_186_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).z)
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles = arg_186_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_0 and arg_186_1.time_ < 0 + var_189_0 + arg_189_0 then
				arg_186_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_186_1.actors_["1084ui_story"].transform.position).z)
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_186_1.actors_["1084ui_story"].transform.localEulerAngles = arg_186_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_189_1 = arg_186_1.actors_["10140ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos10140ui_story = var_189_1.localPosition

				local var_189_2 = GameObjectTools.GetOrAddComponent(var_189_1.gameObject, typeof(DynamicBoneHelper))

				if var_189_2 then
					var_189_2:EnableDynamicBone(false)
				end
			end

			local var_189_3 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_3 then
				var_189_1.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_186_1.time_ - 0) / var_189_3)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_3 and arg_186_1.time_ < 0 + var_189_3 + arg_189_0 then
				var_189_1.localPosition = Vector3.New(0, 100, 0)
				var_189_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_1.position).x, (manager.ui.mainCamera.transform.position - var_189_1.position).y, (manager.ui.mainCamera.transform.position - var_189_1.position).z)
				var_189_1.localEulerAngles.z = 0
				var_189_1.localEulerAngles.x = 0
				var_189_1.localEulerAngles = var_189_1.localEulerAngles

				local var_189_4 = GameObjectTools.GetOrAddComponent(var_189_1.gameObject, typeof(DynamicBoneHelper))

				if var_189_4 then
					var_189_4:EnableDynamicBone(true)
				end
			end

			local var_189_5 = arg_186_1.actors_["10140ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect10140ui_story == nil then
				arg_186_1.var_.characterEffect10140ui_story = var_189_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_6 and not isNil(var_189_5) then
				if arg_186_1.var_.characterEffect10140ui_story and not isNil(var_189_5) then
					arg_186_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_186_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_186_1.time_ - 0) / var_189_6)
				end
			end

			if arg_186_1.time_ >= 0 + var_189_6 and arg_186_1.time_ < 0 + var_189_6 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect10140ui_story then
				arg_186_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_186_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				local var_189_7 = arg_186_1.var_.effectjiliejingbao1

				if not arg_186_1.var_.effectjiliejingbao1 then
					var_189_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_189_7.name = "jiliejingbao1"
					arg_186_1.var_.effectjiliejingbao1 = var_189_7
				else
					var_189_7.transform:SetParent(var_189_9000)
				end

				var_189_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_189_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_189_7.transform.localScale = Vector3.New(var_189_7.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_189_7.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_189_7.transform.localScale.z)
			end

			if 1 < arg_186_1.time_ and arg_186_1.time_ <= 1 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story_1311", "se_story_1311_beep", "")
			end

			local var_189_10 = 0
			local var_189_11 = 1.425

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_10 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0

				arg_186_1.dialog_:SetActive(true)

				arg_186_1.dialogCg_.alpha = 0

				local var_189_12 = LeanTween.value(arg_186_1.dialog_, 0, 1, 0.3)

				var_189_12:setOnUpdate(LuaHelper.FloatAction(function(arg_190_0)
					arg_186_1.dialogCg_.alpha = arg_190_0
				end))
				var_189_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_186_1.dialog_)
					var_189_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_186_1.duration_ = arg_186_1.duration_ + 0.3

				SetActive(arg_186_1.leftNameGo_, false)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_13 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(303031046).content)

				arg_186_1.text_.text = var_189_13

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_15 = 57 <= 0 and var_189_11 or var_189_11 * (utf8.len(var_189_13) / 57)

				if (57 <= 0 and var_189_11 or var_189_11 * (utf8.len(var_189_13) / 57)) > 0 and var_189_11 < var_189_15 then
					arg_186_1.talkMaxDuration = var_189_15
					var_189_10 = var_189_10 + 0.3

					if var_189_15 + var_189_10 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_15 + var_189_10
					end
				end

				arg_186_1.text_.text = var_189_13
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_16 = var_189_10 + 0.3
			local var_189_17 = math.max(var_189_11, arg_186_1.talkMaxDuration)

			if var_189_10 + 0.3 <= arg_186_1.time_ and arg_186_1.time_ < var_189_16 + var_189_17 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_16) / var_189_17

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_16 + var_189_17 and arg_186_1.time_ < var_189_16 + var_189_17 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play303031047 = function(arg_192_0, arg_192_1)
		arg_192_1.time_ = 0
		arg_192_1.frameCnt_ = 0
		arg_192_1.state_ = "playing"
		arg_192_1.curTalkId_ = 303031047
		arg_192_1.duration_ = 6.64

		SetActive(arg_192_1.tipsGo_, false)

		function arg_192_1.onSingleLineFinish_()
			arg_192_1.onSingleLineUpdate_ = nil
			arg_192_1.onSingleLineFinish_ = nil
			arg_192_1.state_ = "waiting"
		end

		function arg_192_1.playNext_(arg_194_0)
			if arg_194_0 == 1 then
				arg_192_0:Play303031048(arg_192_1)
			end
		end

		function arg_192_1.onSingleLineUpdate_(arg_195_0)
			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				local var_195_0 = arg_192_1.var_.effectjiliejingbao2

				if not arg_192_1.var_.effectjiliejingbao2 then
					var_195_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_dust"), manager.ui.mainCamera.transform)
					var_195_0.name = "jiliejingbao2"
					arg_192_1.var_.effectjiliejingbao2 = var_195_0
				else
					var_195_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_195_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_195_0.transform.localRotation = Quaternion.Euler(0, 0, 0)

				local var_195_2 = Mathf.Max(Screen.width / Screen.height / 1.7777777777777777, (Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1)))

				var_195_0.transform.localScale = Vector3.New(var_195_0.transform.localScale.x * var_195_2, var_195_0.transform.localScale.y * var_195_2, var_195_0.transform.localScale.z * var_195_2)
			end

			local var_195_3 = manager.ui.mainCamera.transform

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= 0 + arg_195_0 then
				arg_192_1.var_.shakeOldPos = var_195_3.localPosition
			end

			local var_195_4 = 1

			if 0 <= arg_192_1.time_ and arg_192_1.time_ < 0 + var_195_4 then
				local var_195_5, var_195_6 = math.modf((arg_192_1.time_ - 0) / 0.066)

				var_195_3.localPosition = Vector3.New(var_195_6 * 0.13, var_195_6 * 0.13, var_195_6 * 0.13) + arg_192_1.var_.shakeOldPos
			end

			if arg_192_1.time_ >= 0 + var_195_4 and arg_192_1.time_ < 0 + var_195_4 + arg_195_0 then
				var_195_3.localPosition = arg_192_1.var_.shakeOldPos
			end

			local var_195_7 = 0

			if 0 < arg_192_1.time_ and arg_192_1.time_ <= var_195_7 + arg_195_0 then
				arg_192_1.allBtn_.enabled = false
			end

			if arg_192_1.time_ >= var_195_7 + 1.64166666666667 and arg_192_1.time_ < var_195_7 + 1.64166666666667 + arg_195_0 then
				arg_192_1.allBtn_.enabled = true
			end

			if 0.1 < arg_192_1.time_ and arg_192_1.time_ <= 0.1 + arg_195_0 then
				arg_192_1:AudioAction("play", "effect", "se_story_148", "se_story_148_earthquake03", "")
			end

			if arg_192_1.frameCnt_ <= 1 then
				arg_192_1.dialog_:SetActive(false)
			end

			local var_195_9 = 1.64166666666667
			local var_195_10 = 0.925

			if 1.64166666666667 < arg_192_1.time_ and arg_192_1.time_ <= var_195_9 + arg_195_0 then
				arg_192_1.talkMaxDuration = 0

				arg_192_1.dialog_:SetActive(true)

				arg_192_1.dialogCg_.alpha = 0

				local var_195_11 = LeanTween.value(arg_192_1.dialog_, 0, 1, 0.3)

				var_195_11:setOnUpdate(LuaHelper.FloatAction(function(arg_196_0)
					arg_192_1.dialogCg_.alpha = arg_196_0
				end))
				var_195_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_192_1.dialog_)
					var_195_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_192_1.duration_ = arg_192_1.duration_ + 0.3

				SetActive(arg_192_1.leftNameGo_, false)

				arg_192_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_192_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_192_1:RecordName(arg_192_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_192_1.iconTrs_.gameObject, false)
				arg_192_1.callingController_:SetSelectedState("normal")

				local var_195_12 = arg_192_1:FormatText(arg_192_1:GetWordFromCfg(303031047).content)

				arg_192_1.text_.text = var_195_12

				LuaForUtil.ClearLinePrefixSymbol(arg_192_1.text_)

				local var_195_14 = 37 <= 0 and var_195_10 or var_195_10 * (utf8.len(var_195_12) / 37)

				if (37 <= 0 and var_195_10 or var_195_10 * (utf8.len(var_195_12) / 37)) > 0 and var_195_10 < var_195_14 then
					arg_192_1.talkMaxDuration = var_195_14
					var_195_9 = var_195_9 + 0.3

					if var_195_14 + var_195_9 > arg_192_1.duration_ then
						arg_192_1.duration_ = var_195_14 + var_195_9
					end
				end

				arg_192_1.text_.text = var_195_12
				arg_192_1.typewritter.percent = 0

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(false)
				arg_192_1:RecordContent(arg_192_1.text_.text)
			end

			local var_195_15 = var_195_9 + 0.3
			local var_195_16 = math.max(var_195_10, arg_192_1.talkMaxDuration)

			if var_195_9 + 0.3 <= arg_192_1.time_ and arg_192_1.time_ < var_195_15 + var_195_16 then
				arg_192_1.typewritter.percent = (arg_192_1.time_ - var_195_15) / var_195_16

				arg_192_1.typewritter:SetDirty()
			end

			if arg_192_1.time_ >= var_195_15 + var_195_16 and arg_192_1.time_ < var_195_15 + var_195_16 + arg_195_0 then
				arg_192_1.typewritter.percent = 1

				arg_192_1.typewritter:SetDirty()
				arg_192_1:ShowNextGo(true)
			end
		end

		arg_192_1.nodeConfigList_ = {}

		arg_192_1:InitPlayNodeList()
	end,
	Play303031048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 303031048
		arg_198_1.duration_ = 5.2

		local var_198_0 = {
			zh = 5.2,
			ja = 5
		}
		local var_198_1 = manager.audio:GetLocalizationFlag()

		if var_198_0[var_198_1] ~= nil then
			arg_198_1.duration_ = var_198_0[var_198_1]
		end

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play303031049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos1084ui_story = arg_198_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_201_0 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 then
				arg_198_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_198_1.time_ - 0) / var_201_0)
				arg_198_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).z)
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles = arg_198_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 then
				arg_198_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_198_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["1084ui_story"].transform.position).z)
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["1084ui_story"].transform.localEulerAngles = arg_198_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_201_1 = arg_198_1.actors_["1084ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1084ui_story == nil then
				arg_198_1.var_.characterEffect1084ui_story = var_201_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_2 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_2 and not isNil(var_201_1) then
				if arg_198_1.var_.characterEffect1084ui_story and not isNil(var_201_1) then
					arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_2 and arg_198_1.time_ < 0 + var_201_2 + arg_201_0 and not isNil(var_201_1) and arg_198_1.var_.characterEffect1084ui_story then
				arg_198_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				if arg_198_1.var_.effectjiliejingbao1 then
					Object.Destroy(arg_198_1.var_.effectjiliejingbao1)

					arg_198_1.var_.effectjiliejingbao1 = nil
				end
			end

			local var_201_5 = 0
			local var_201_6 = 0.425

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_5 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_7 = arg_198_1:GetWordFromCfg(303031048)
				local var_201_8 = arg_198_1:FormatText(var_201_7.content)

				arg_198_1.text_.text = var_201_8

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_10 = 17 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 17)

				if (17 <= 0 and var_201_6 or var_201_6 * (utf8.len(var_201_8) / 17)) > 0 and var_201_6 < var_201_10 then
					arg_198_1.talkMaxDuration = var_201_10

					if var_201_10 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_5
					end
				end

				arg_198_1.text_.text = var_201_8
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031048", "story_v_out_303031.awb") ~= 0 then
					local var_201_11 = manager.audio:GetVoiceLength("story_v_out_303031", "303031048", "story_v_out_303031.awb") / 1000

					if var_201_11 + var_201_5 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_11 + var_201_5
					end

					if var_201_7.prefab_name ~= "" and arg_198_1.actors_[var_201_7.prefab_name] ~= nil then
						local var_201_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_7.prefab_name].transform, "story_v_out_303031", "303031048", "story_v_out_303031.awb")

						arg_198_1:RecordAudio("303031048", var_201_12)
						arg_198_1:RecordAudio("303031048", var_201_12)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_303031", "303031048", "story_v_out_303031.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_303031", "303031048", "story_v_out_303031.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_6, arg_198_1.talkMaxDuration)

			if var_201_5 <= arg_198_1.time_ and arg_198_1.time_ < var_201_5 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_5) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_5 + var_201_13 and arg_198_1.time_ < var_201_5 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_198_1:InitPlayNodeList()
	end,
	Play303031049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 303031049
		arg_202_1.duration_ = 4.23

		local var_202_0 = {
			zh = 4.233,
			ja = 1.333
		}
		local var_202_1 = manager.audio:GetLocalizationFlag()

		if var_202_0[var_202_1] ~= nil then
			arg_202_1.duration_ = var_202_0[var_202_1]
		end

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play303031050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1166ui_story = arg_202_1.actors_["1166ui_story"].transform.localPosition

				local var_205_0 = GameObjectTools.GetOrAddComponent(arg_202_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_205_0 then
					var_205_0:EnableDynamicBone(false)
				end
			end

			local var_205_1 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 then
				arg_202_1.actors_["1166ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1166ui_story, Vector3.New(0.7, -0.75, -6.25), (arg_202_1.time_ - 0) / var_205_1)
				arg_202_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1166ui_story"].transform.position).z)
				arg_202_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1166ui_story"].transform.localEulerAngles = arg_202_1.actors_["1166ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 then
				arg_202_1.actors_["1166ui_story"].transform.localPosition = Vector3.New(0.7, -0.75, -6.25)
				arg_202_1.actors_["1166ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1166ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1166ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1166ui_story"].transform.position).z)
				arg_202_1.actors_["1166ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1166ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1166ui_story"].transform.localEulerAngles = arg_202_1.actors_["1166ui_story"].transform.localEulerAngles

				local var_205_2 = GameObjectTools.GetOrAddComponent(arg_202_1.actors_["1166ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_205_2 then
					var_205_2:EnableDynamicBone(true)
				end
			end

			local var_205_3 = arg_202_1.actors_["1166ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect1166ui_story == nil then
				arg_202_1.var_.characterEffect1166ui_story = var_205_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_4 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 and not isNil(var_205_3) then
				if arg_202_1.var_.characterEffect1166ui_story and not isNil(var_205_3) then
					arg_202_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 and not isNil(var_205_3) and arg_202_1.var_.characterEffect1166ui_story then
				arg_202_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_205_6 = arg_202_1.actors_["1084ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_7 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_7 and not isNil(var_205_6) then
				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_6) then
					arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_7)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_7 and arg_202_1.time_ < 0 + var_205_7 + arg_205_0 and not isNil(var_205_6) and arg_202_1.var_.characterEffect1084ui_story then
				arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action1_1")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_205_8 = 0
			local var_205_9 = 0.475

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_10 = arg_202_1:GetWordFromCfg(303031049)
				local var_205_11 = arg_202_1:FormatText(var_205_10.content)

				arg_202_1.text_.text = var_205_11

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_13 = 19 <= 0 and var_205_9 or var_205_9 * (utf8.len(var_205_11) / 19)

				if (19 <= 0 and var_205_9 or var_205_9 * (utf8.len(var_205_11) / 19)) > 0 and var_205_9 < var_205_13 then
					arg_202_1.talkMaxDuration = var_205_13

					if var_205_13 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_13 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_11
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031049", "story_v_out_303031.awb") ~= 0 then
					local var_205_14 = manager.audio:GetVoiceLength("story_v_out_303031", "303031049", "story_v_out_303031.awb") / 1000

					if var_205_14 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_14 + var_205_8
					end

					if var_205_10.prefab_name ~= "" and arg_202_1.actors_[var_205_10.prefab_name] ~= nil then
						local var_205_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_10.prefab_name].transform, "story_v_out_303031", "303031049", "story_v_out_303031.awb")

						arg_202_1:RecordAudio("303031049", var_205_15)
						arg_202_1:RecordAudio("303031049", var_205_15)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_303031", "303031049", "story_v_out_303031.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_303031", "303031049", "story_v_out_303031.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_16 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_16 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_16

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_16 and arg_202_1.time_ < var_205_8 + var_205_16 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play303031050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 303031050
		arg_206_1.duration_ = 3.13

		local var_206_0 = {
			zh = 3.133,
			ja = 1.999999999999
		}
		local var_206_1 = manager.audio:GetLocalizationFlag()

		if var_206_0[var_206_1] ~= nil then
			arg_206_1.duration_ = var_206_0[var_206_1]
		end

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play303031051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166action/1166action4_1")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_209_0 = 0
			local var_209_1 = 0.375

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_0 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_2 = arg_206_1:GetWordFromCfg(303031050)
				local var_209_3 = arg_206_1:FormatText(var_209_2.content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 15 <= 0 and var_209_1 or var_209_1 * (utf8.len(var_209_3) / 15)

				if (15 <= 0 and var_209_1 or var_209_1 * (utf8.len(var_209_3) / 15)) > 0 and var_209_1 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_0
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031050", "story_v_out_303031.awb") ~= 0 then
					local var_209_6 = manager.audio:GetVoiceLength("story_v_out_303031", "303031050", "story_v_out_303031.awb") / 1000

					if var_209_6 + var_209_0 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_6 + var_209_0
					end

					if var_209_2.prefab_name ~= "" and arg_206_1.actors_[var_209_2.prefab_name] ~= nil then
						local var_209_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_206_1.actors_[var_209_2.prefab_name].transform, "story_v_out_303031", "303031050", "story_v_out_303031.awb")

						arg_206_1:RecordAudio("303031050", var_209_7)
						arg_206_1:RecordAudio("303031050", var_209_7)
					else
						arg_206_1:AudioAction("play", "voice", "story_v_out_303031", "303031050", "story_v_out_303031.awb")
					end

					arg_206_1:RecordHistoryTalkVoice("story_v_out_303031", "303031050", "story_v_out_303031.awb")
				end

				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_8 = math.max(var_209_1, arg_206_1.talkMaxDuration)

			if var_209_0 <= arg_206_1.time_ and arg_206_1.time_ < var_209_0 + var_209_8 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_0) / var_209_8

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_0 + var_209_8 and arg_206_1.time_ < var_209_0 + var_209_8 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play303031051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 303031051
		arg_210_1.duration_ = 2.47

		local var_210_0 = {
			zh = 1.999999999999,
			ja = 2.466
		}
		local var_210_1 = manager.audio:GetLocalizationFlag()

		if var_210_0[var_210_1] ~= nil then
			arg_210_1.duration_ = var_210_0[var_210_1]
		end

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play303031052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = arg_210_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_0 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) then
				if arg_210_1.var_.characterEffect1084ui_story and not isNil(arg_210_1.actors_["1084ui_story"]) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 and not isNil(arg_210_1.actors_["1084ui_story"]) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_213_2 = arg_210_1.actors_["1166ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1166ui_story == nil then
				arg_210_1.var_.characterEffect1166ui_story = var_213_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_3 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_3 and not isNil(var_213_2) then
				if arg_210_1.var_.characterEffect1166ui_story and not isNil(var_213_2) then
					arg_210_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_3)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_3 and arg_210_1.time_ < 0 + var_213_3 + arg_213_0 and not isNil(var_213_2) and arg_210_1.var_.characterEffect1166ui_story then
				arg_210_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.2

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_4 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_6 = arg_210_1:GetWordFromCfg(303031051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 8 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 8)

				if (8 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 8)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031051", "story_v_out_303031.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031051", "story_v_out_303031.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_303031", "303031051", "story_v_out_303031.awb")

						arg_210_1:RecordAudio("303031051", var_213_11)
						arg_210_1:RecordAudio("303031051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_303031", "303031051", "story_v_out_303031.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_303031", "303031051", "story_v_out_303031.awb")
				end

				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_12 = math.max(var_213_5, arg_210_1.talkMaxDuration)

			if var_213_4 <= arg_210_1.time_ and arg_210_1.time_ < var_213_4 + var_213_12 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_4) / var_213_12

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_4 + var_213_12 and arg_210_1.time_ < var_213_4 + var_213_12 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {}

		arg_210_1:InitPlayNodeList()
	end,
	Play303031052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 303031052
		arg_214_1.duration_ = 2.83

		local var_214_0 = {
			zh = 2.833,
			ja = 1.999999999999
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
				arg_214_0:Play303031053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1166ui_story"]) and arg_214_1.var_.characterEffect1166ui_story == nil then
				arg_214_1.var_.characterEffect1166ui_story = arg_214_1.actors_["1166ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1166ui_story"]) then
				if arg_214_1.var_.characterEffect1166ui_story and not isNil(arg_214_1.actors_["1166ui_story"]) then
					arg_214_1.var_.characterEffect1166ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1166ui_story"]) and arg_214_1.var_.characterEffect1166ui_story then
				arg_214_1.var_.characterEffect1166ui_story.fillFlat = false
			end

			local var_217_2 = arg_214_1.actors_["1084ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = var_217_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_3 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_3 and not isNil(var_217_2) then
				if arg_214_1.var_.characterEffect1084ui_story and not isNil(var_217_2) then
					arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_3)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_3 and arg_214_1.time_ < 0 + var_217_3 + arg_217_0 and not isNil(var_217_2) and arg_214_1.var_.characterEffect1084ui_story then
				arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/story1166/story1166actionlink/1166action443")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1166ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_217_4 = 0
			local var_217_5 = 0.3

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_4 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_6 = arg_214_1:GetWordFromCfg(303031052)
				local var_217_7 = arg_214_1:FormatText(var_217_6.content)

				arg_214_1.text_.text = var_217_7

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_9 = 12 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 12)

				if (12 <= 0 and var_217_5 or var_217_5 * (utf8.len(var_217_7) / 12)) > 0 and var_217_5 < var_217_9 then
					arg_214_1.talkMaxDuration = var_217_9

					if var_217_9 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_9 + var_217_4
					end
				end

				arg_214_1.text_.text = var_217_7
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031052", "story_v_out_303031.awb") ~= 0 then
					local var_217_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031052", "story_v_out_303031.awb") / 1000

					if var_217_10 + var_217_4 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_10 + var_217_4
					end

					if var_217_6.prefab_name ~= "" and arg_214_1.actors_[var_217_6.prefab_name] ~= nil then
						local var_217_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_214_1.actors_[var_217_6.prefab_name].transform, "story_v_out_303031", "303031052", "story_v_out_303031.awb")

						arg_214_1:RecordAudio("303031052", var_217_11)
						arg_214_1:RecordAudio("303031052", var_217_11)
					else
						arg_214_1:AudioAction("play", "voice", "story_v_out_303031", "303031052", "story_v_out_303031.awb")
					end

					arg_214_1:RecordHistoryTalkVoice("story_v_out_303031", "303031052", "story_v_out_303031.awb")
				end

				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_12 = math.max(var_217_5, arg_214_1.talkMaxDuration)

			if var_217_4 <= arg_214_1.time_ and arg_214_1.time_ < var_217_4 + var_217_12 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_4) / var_217_12

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_4 + var_217_12 and arg_214_1.time_ < var_217_4 + var_217_12 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play303031053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 303031053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play303031054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_9000

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1084ui_story = arg_218_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).z)
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles = arg_218_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1084ui_story"].transform.position).z)
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1084ui_story"].transform.localEulerAngles = arg_218_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["1166ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1166ui_story = var_221_1.localPosition

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_1.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end
			end

			local var_221_3 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 then
				var_221_1.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1166ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_3)
				var_221_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_1.position).x, (manager.ui.mainCamera.transform.position - var_221_1.position).y, (manager.ui.mainCamera.transform.position - var_221_1.position).z)
				var_221_1.localEulerAngles.z = 0
				var_221_1.localEulerAngles.x = 0
				var_221_1.localEulerAngles = var_221_1.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 then
				var_221_1.localPosition = Vector3.New(0, 100, 0)
				var_221_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_1.position).x, (manager.ui.mainCamera.transform.position - var_221_1.position).y, (manager.ui.mainCamera.transform.position - var_221_1.position).z)
				var_221_1.localEulerAngles.z = 0
				var_221_1.localEulerAngles.x = 0
				var_221_1.localEulerAngles = var_221_1.localEulerAngles

				local var_221_4 = GameObjectTools.GetOrAddComponent(var_221_1.gameObject, typeof(DynamicBoneHelper))

				if var_221_4 then
					var_221_4:EnableDynamicBone(true)
				end
			end

			local var_221_5 = arg_218_1.actors_["1166ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1166ui_story == nil then
				arg_218_1.var_.characterEffect1166ui_story = var_221_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_6 and not isNil(var_221_5) then
				if arg_218_1.var_.characterEffect1166ui_story and not isNil(var_221_5) then
					arg_218_1.var_.characterEffect1166ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1166ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_6)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_6 and arg_218_1.time_ < 0 + var_221_6 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1166ui_story then
				arg_218_1.var_.characterEffect1166ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1166ui_story.fillRatio = 0.5
			end

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				local var_221_7 = arg_218_1.var_.effecthainengdaoguang1

				if not arg_218_1.var_.effecthainengdaoguang1 then
					var_221_7 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_red_in"), manager.ui.mainCamera.transform)
					var_221_7.name = "hainengdaoguang1"
					arg_218_1.var_.effecthainengdaoguang1 = var_221_7
				else
					var_221_7.transform:SetParent(var_221_9000)
				end

				var_221_7.transform.localPosition = Vector3.New(0, 0, 0)
				var_221_7.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_221_9 = 0
			local var_221_10 = 1.25

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_9 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_11 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(303031053).content)

				arg_218_1.text_.text = var_221_11

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_13 = 50 <= 0 and var_221_10 or var_221_10 * (utf8.len(var_221_11) / 50)

				if (50 <= 0 and var_221_10 or var_221_10 * (utf8.len(var_221_11) / 50)) > 0 and var_221_10 < var_221_13 then
					arg_218_1.talkMaxDuration = var_221_13

					if var_221_13 + var_221_9 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_13 + var_221_9
					end
				end

				arg_218_1.text_.text = var_221_11
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_14 = math.max(var_221_10, arg_218_1.talkMaxDuration)

			if var_221_9 <= arg_218_1.time_ and arg_218_1.time_ < var_221_9 + var_221_14 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_9) / var_221_14

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_9 + var_221_14 and arg_218_1.time_ < var_221_9 + var_221_14 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1166ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play303031054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 303031054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play303031055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.025

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, false)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(303031054).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 41 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 41)

				if (41 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 41)) > 0 and var_225_0 < var_225_3 then
					arg_222_1.talkMaxDuration = var_225_3

					if var_225_3 + 0 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_3 + 0
					end
				end

				arg_222_1.text_.text = var_225_1
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_4 = math.max(var_225_0, arg_222_1.talkMaxDuration)

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - 0) / var_225_4

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {}

		arg_222_1:InitPlayNodeList()
	end,
	Play303031055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 303031055
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play303031056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			local var_229_0 = 0.375

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_1 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(303031055).content)

				arg_226_1.text_.text = var_229_1

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_3 = 15 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 15)

				if (15 <= 0 and var_229_0 or var_229_0 * (utf8.len(var_229_1) / 15)) > 0 and var_229_0 < var_229_3 then
					arg_226_1.talkMaxDuration = var_229_3

					if var_229_3 + 0 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_3 + 0
					end
				end

				arg_226_1.text_.text = var_229_1
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_4 = math.max(var_229_0, arg_226_1.talkMaxDuration)

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_4 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - 0) / var_229_4

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= 0 + var_229_4 and arg_226_1.time_ < 0 + var_229_4 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play303031056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 303031056
		arg_230_1.duration_ = 7.1

		local var_230_0 = {
			zh = 4.033,
			ja = 7.1
		}
		local var_230_1 = manager.audio:GetLocalizationFlag()

		if var_230_0[var_230_1] ~= nil then
			arg_230_1.duration_ = var_230_0[var_230_1]
		end

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play303031057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.var_.moveOldPos1084ui_story = arg_230_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_233_0 = 0.001

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 then
				arg_230_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_230_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_230_1.time_ - 0) / var_233_0)
				arg_230_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).z)
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles = arg_230_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 then
				arg_230_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_230_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_230_1.actors_["1084ui_story"].transform.position).z)
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_230_1.actors_["1084ui_story"].transform.localEulerAngles = arg_230_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_233_1 = arg_230_1.actors_["1084ui_story"]

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1084ui_story == nil then
				arg_230_1.var_.characterEffect1084ui_story = var_233_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_2 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_2 and not isNil(var_233_1) then
				if arg_230_1.var_.characterEffect1084ui_story and not isNil(var_233_1) then
					arg_230_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_230_1.time_ >= 0 + var_233_2 and arg_230_1.time_ < 0 + var_233_2 + arg_233_0 and not isNil(var_233_1) and arg_230_1.var_.characterEffect1084ui_story then
				arg_230_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_233_4 = 0
			local var_233_5 = 0.525

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_4 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_6 = arg_230_1:GetWordFromCfg(303031056)
				local var_233_7 = arg_230_1:FormatText(var_233_6.content)

				arg_230_1.text_.text = var_233_7

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_9 = 21 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 21)

				if (21 <= 0 and var_233_5 or var_233_5 * (utf8.len(var_233_7) / 21)) > 0 and var_233_5 < var_233_9 then
					arg_230_1.talkMaxDuration = var_233_9

					if var_233_9 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_9 + var_233_4
					end
				end

				arg_230_1.text_.text = var_233_7
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031056", "story_v_out_303031.awb") ~= 0 then
					local var_233_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031056", "story_v_out_303031.awb") / 1000

					if var_233_10 + var_233_4 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_10 + var_233_4
					end

					if var_233_6.prefab_name ~= "" and arg_230_1.actors_[var_233_6.prefab_name] ~= nil then
						local var_233_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_6.prefab_name].transform, "story_v_out_303031", "303031056", "story_v_out_303031.awb")

						arg_230_1:RecordAudio("303031056", var_233_11)
						arg_230_1:RecordAudio("303031056", var_233_11)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_303031", "303031056", "story_v_out_303031.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_303031", "303031056", "story_v_out_303031.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_12 = math.max(var_233_5, arg_230_1.talkMaxDuration)

			if var_233_4 <= arg_230_1.time_ and arg_230_1.time_ < var_233_4 + var_233_12 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_4) / var_233_12

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_4 + var_233_12 and arg_230_1.time_ < var_233_4 + var_233_12 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_230_1:InitPlayNodeList()
	end,
	Play303031057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 303031057
		arg_234_1.duration_ = 5.4

		local var_234_0 = {
			zh = 3.033,
			ja = 5.4
		}
		local var_234_1 = manager.audio:GetLocalizationFlag()

		if var_234_0[var_234_1] ~= nil then
			arg_234_1.duration_ = var_234_0[var_234_1]
		end

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play303031058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos10140ui_story = arg_234_1.actors_["10140ui_story"].transform.localPosition

				local var_237_0 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_0 then
					var_237_0:EnableDynamicBone(false)
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["10140ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos10140ui_story, Vector3.New(0.7, -0.96, -6.29), (arg_234_1.time_ - 0) / var_237_1)
				arg_234_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10140ui_story"].transform.position).z)
				arg_234_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10140ui_story"].transform.localEulerAngles = arg_234_1.actors_["10140ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["10140ui_story"].transform.localPosition = Vector3.New(0.7, -0.96, -6.29)
				arg_234_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["10140ui_story"].transform.position).z)
				arg_234_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["10140ui_story"].transform.localEulerAngles = arg_234_1.actors_["10140ui_story"].transform.localEulerAngles

				local var_237_2 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(true)
				end
			end

			local var_237_3 = arg_234_1.actors_["10140ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect10140ui_story == nil then
				arg_234_1.var_.characterEffect10140ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect10140ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect10140ui_story then
				arg_234_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			local var_237_6 = arg_234_1.actors_["1084ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_6) and arg_234_1.var_.characterEffect1084ui_story == nil then
				arg_234_1.var_.characterEffect1084ui_story = var_237_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_7 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_7 and not isNil(var_237_6) then
				if arg_234_1.var_.characterEffect1084ui_story and not isNil(var_237_6) then
					arg_234_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_234_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_7)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_7 and arg_234_1.time_ < 0 + var_237_7 + arg_237_0 and not isNil(var_237_6) and arg_234_1.var_.characterEffect1084ui_story then
				arg_234_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_234_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_237_8 = 0
			local var_237_9 = 0.325

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_8 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_10 = arg_234_1:GetWordFromCfg(303031057)
				local var_237_11 = arg_234_1:FormatText(var_237_10.content)

				arg_234_1.text_.text = var_237_11

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_13 = 13 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 13)

				if (13 <= 0 and var_237_9 or var_237_9 * (utf8.len(var_237_11) / 13)) > 0 and var_237_9 < var_237_13 then
					arg_234_1.talkMaxDuration = var_237_13

					if var_237_13 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_13 + var_237_8
					end
				end

				arg_234_1.text_.text = var_237_11
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031057", "story_v_out_303031.awb") ~= 0 then
					local var_237_14 = manager.audio:GetVoiceLength("story_v_out_303031", "303031057", "story_v_out_303031.awb") / 1000

					if var_237_14 + var_237_8 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_14 + var_237_8
					end

					if var_237_10.prefab_name ~= "" and arg_234_1.actors_[var_237_10.prefab_name] ~= nil then
						local var_237_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_10.prefab_name].transform, "story_v_out_303031", "303031057", "story_v_out_303031.awb")

						arg_234_1:RecordAudio("303031057", var_237_15)
						arg_234_1:RecordAudio("303031057", var_237_15)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_303031", "303031057", "story_v_out_303031.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_303031", "303031057", "story_v_out_303031.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_16 = math.max(var_237_9, arg_234_1.talkMaxDuration)

			if var_237_8 <= arg_234_1.time_ and arg_234_1.time_ < var_237_8 + var_237_16 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_8) / var_237_16

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_8 + var_237_16 and arg_234_1.time_ < var_237_8 + var_237_16 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_234_1:InitPlayNodeList()
	end,
	Play303031058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 303031058
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play303031059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10140ui_story = arg_238_1.actors_["10140ui_story"].transform.localPosition

				local var_241_0 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_0 then
					var_241_0:EnableDynamicBone(false)
				end
			end

			local var_241_1 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_1 then
				arg_238_1.actors_["10140ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_1)
				arg_238_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10140ui_story"].transform.position).z)
				arg_238_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["10140ui_story"].transform.localEulerAngles = arg_238_1.actors_["10140ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_1 and arg_238_1.time_ < 0 + var_241_1 + arg_241_0 then
				arg_238_1.actors_["10140ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_238_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["10140ui_story"].transform.position).z)
				arg_238_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["10140ui_story"].transform.localEulerAngles = arg_238_1.actors_["10140ui_story"].transform.localEulerAngles

				local var_241_2 = GameObjectTools.GetOrAddComponent(arg_238_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(true)
				end
			end

			local var_241_3 = arg_238_1.actors_["1084ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = var_241_3.localPosition
			end

			local var_241_4 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_4 then
				var_241_3.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_4)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_4 and arg_238_1.time_ < 0 + var_241_4 + arg_241_0 then
				var_241_3.localPosition = Vector3.New(0, 100, 0)
				var_241_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_3.position).x, (manager.ui.mainCamera.transform.position - var_241_3.position).y, (manager.ui.mainCamera.transform.position - var_241_3.position).z)
				var_241_3.localEulerAngles.z = 0
				var_241_3.localEulerAngles.x = 0
				var_241_3.localEulerAngles = var_241_3.localEulerAngles
			end

			local var_241_5 = arg_238_1.actors_["10140ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect10140ui_story == nil then
				arg_238_1.var_.characterEffect10140ui_story = var_241_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_6 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_6 and not isNil(var_241_5) then
				if arg_238_1.var_.characterEffect10140ui_story and not isNil(var_241_5) then
					arg_238_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_6)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_6 and arg_238_1.time_ < 0 + var_241_6 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect10140ui_story then
				arg_238_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_241_7 = 0
			local var_241_8 = 0.35

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_7 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_9 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(303031058).content)

				arg_238_1.text_.text = var_241_9

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_11 = 14 <= 0 and var_241_8 or var_241_8 * (utf8.len(var_241_9) / 14)

				if (14 <= 0 and var_241_8 or var_241_8 * (utf8.len(var_241_9) / 14)) > 0 and var_241_8 < var_241_11 then
					arg_238_1.talkMaxDuration = var_241_11

					if var_241_11 + var_241_7 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_11 + var_241_7
					end
				end

				arg_238_1.text_.text = var_241_9
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_8, arg_238_1.talkMaxDuration)

			if var_241_7 <= arg_238_1.time_ and arg_238_1.time_ < var_241_7 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_7) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_7 + var_241_12 and arg_238_1.time_ < var_241_7 + var_241_12 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play303031059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 303031059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play303031060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.775

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(303031059).content)

				arg_242_1.text_.text = var_245_1

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_3 = 29 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 29)

				if (29 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_1) / 29)) > 0 and var_245_0 < var_245_3 then
					arg_242_1.talkMaxDuration = var_245_3

					if var_245_3 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_3 + 0
					end
				end

				arg_242_1.text_.text = var_245_1
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_4 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_4

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play303031060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 303031060
		arg_246_1.duration_ = 3.73

		local var_246_0 = {
			zh = 1.999999999999,
			ja = 3.733
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
			arg_246_1.auto_ = false
		end

		function arg_246_1.playNext_(arg_248_0)
			arg_246_1.onStoryFinished_()
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.moveOldPos1084ui_story = arg_246_1.actors_["1084ui_story"].transform.localPosition

				arg_246_1:ShowWeapon(arg_246_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_249_0 = 0.001

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				arg_246_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_246_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_246_1.time_ - 0) / var_249_0)
				arg_246_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).z)
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles = arg_246_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				arg_246_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_246_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_246_1.actors_["1084ui_story"].transform.position).z)
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_246_1.actors_["1084ui_story"].transform.localEulerAngles = arg_246_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_249_1 = arg_246_1.actors_["1084ui_story"]

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = var_249_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_2 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_2 and not isNil(var_249_1) then
				if arg_246_1.var_.characterEffect1084ui_story and not isNil(var_249_1) then
					arg_246_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_246_1.time_ >= 0 + var_249_2 and arg_246_1.time_ < 0 + var_249_2 + arg_249_0 and not isNil(var_249_1) and arg_246_1.var_.characterEffect1084ui_story then
				arg_246_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_249_4 = 0
			local var_249_5 = 0.225

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_4 + arg_249_0 then
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

				local var_249_6 = arg_246_1:GetWordFromCfg(303031060)
				local var_249_7 = arg_246_1:FormatText(var_249_6.content)

				arg_246_1.text_.text = var_249_7

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_9 = 9 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 9)

				if (9 <= 0 and var_249_5 or var_249_5 * (utf8.len(var_249_7) / 9)) > 0 and var_249_5 < var_249_9 then
					arg_246_1.talkMaxDuration = var_249_9

					if var_249_9 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_9 + var_249_4
					end
				end

				arg_246_1.text_.text = var_249_7
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303031", "303031060", "story_v_out_303031.awb") ~= 0 then
					local var_249_10 = manager.audio:GetVoiceLength("story_v_out_303031", "303031060", "story_v_out_303031.awb") / 1000

					if var_249_10 + var_249_4 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_10 + var_249_4
					end

					if var_249_6.prefab_name ~= "" and arg_246_1.actors_[var_249_6.prefab_name] ~= nil then
						local var_249_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_246_1.actors_[var_249_6.prefab_name].transform, "story_v_out_303031", "303031060", "story_v_out_303031.awb")

						arg_246_1:RecordAudio("303031060", var_249_11)
						arg_246_1:RecordAudio("303031060", var_249_11)
					else
						arg_246_1:AudioAction("play", "voice", "story_v_out_303031", "303031060", "story_v_out_303031.awb")
					end

					arg_246_1:RecordHistoryTalkVoice("story_v_out_303031", "303031060", "story_v_out_303031.awb")
				end

				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = math.max(var_249_5, arg_246_1.talkMaxDuration)

			if var_249_4 <= arg_246_1.time_ and arg_246_1.time_ < var_249_4 + var_249_12 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_4) / var_249_12

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_4 + var_249_12 and arg_246_1.time_ < var_249_4 + var_249_12 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_246_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10c",
		"TextureConfig/Background/B01a"
	},
	voices = {
		"story_v_out_303031.awb"
	}
}
