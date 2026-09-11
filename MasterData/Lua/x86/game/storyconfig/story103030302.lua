return {
	Play303032001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 303032001
		arg_1_1.duration_ = 8.07

		local var_1_0 = {
			zh = 6,
			ja = 8.066
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
				arg_1_0:Play303032002(arg_1_1)
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

			local var_4_9 = "10140ui_story"

			if arg_1_1.actors_["10140ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10140ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10140ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10140ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10140ui_story = var_4_13.localPosition

				local var_4_14 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_14 then
					var_4_14:EnableDynamicBone(false)
				end
			end

			local var_4_15 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10140ui_story, Vector3.New(-0.7, -0.96, -6.29), (arg_1_1.time_ - 2) / var_4_15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(-0.7, -0.96, -6.29)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles

				local var_4_16 = GameObjectTools.GetOrAddComponent(var_4_13.gameObject, typeof(DynamicBoneHelper))

				if var_4_16 then
					var_4_16:EnableDynamicBone(true)
				end
			end

			local var_4_17 = arg_1_1.actors_["10140ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10140ui_story == nil then
				arg_1_1.var_.characterEffect10140ui_story = var_4_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_18 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_18 and not isNil(var_4_17) then
				if arg_1_1.var_.characterEffect10140ui_story and not isNil(var_4_17) then
					arg_1_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_18 and arg_1_1.time_ < 2 + var_4_18 + arg_4_0 and not isNil(var_4_17) and arg_1_1.var_.characterEffect10140ui_story then
				arg_1_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			if 0.2 < arg_1_1.time_ and arg_1_1.time_ <= 0.2 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if 1 < arg_1_1.time_ and arg_1_1.time_ <= 1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_5_2_story_nervous", "bgm_activity_5_2_story_nervous")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "ui_battle", "ui_battle_stopbgm", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_25 = 2
			local var_4_26 = 0.3

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_25 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_28 = arg_1_1:GetWordFromCfg(303032001)
				local var_4_29 = arg_1_1:FormatText(var_4_28.content)

				arg_1_1.text_.text = var_4_29

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_31 = 12 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 12)

				if (12 <= 0 and var_4_26 or var_4_26 * (utf8.len(var_4_29) / 12)) > 0 and var_4_26 < var_4_31 then
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

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032001", "story_v_out_303032.awb") ~= 0 then
					local var_4_32 = manager.audio:GetVoiceLength("story_v_out_303032", "303032001", "story_v_out_303032.awb") / 1000

					if var_4_32 + var_4_25 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_32 + var_4_25
					end

					if var_4_28.prefab_name ~= "" and arg_1_1.actors_[var_4_28.prefab_name] ~= nil then
						local var_4_33 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_28.prefab_name].transform, "story_v_out_303032", "303032001", "story_v_out_303032.awb")

						arg_1_1:RecordAudio("303032001", var_4_33)
						arg_1_1:RecordAudio("303032001", var_4_33)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_303032", "303032001", "story_v_out_303032.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_303032", "303032001", "story_v_out_303032.awb")
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
				actorName = "10140ui_story",
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
	Play303032002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 303032002
		arg_8_1.duration_ = 2.53

		local var_8_0 = {
			zh = 2.533,
			ja = 2.466
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
				arg_8_0:Play303032003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1084ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1084ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1084ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_3.localPosition
			end

			local var_11_4 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 then
				var_11_3.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_8_1.time_ - 0) / var_11_4)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 then
				var_11_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_11_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_3.position).x, (manager.ui.mainCamera.transform.position - var_11_3.position).y, (manager.ui.mainCamera.transform.position - var_11_3.position).z)
				var_11_3.localEulerAngles.z = 0
				var_11_3.localEulerAngles.x = 0
				var_11_3.localEulerAngles = var_11_3.localEulerAngles
			end

			local var_11_5 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_6 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_6 and not isNil(var_11_5) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_5) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_6 and arg_8_1.time_ < 0 + var_11_6 + arg_11_0 and not isNil(var_11_5) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_8 = arg_8_1.actors_["10140ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_8) and arg_8_1.var_.characterEffect10140ui_story == nil then
				arg_8_1.var_.characterEffect10140ui_story = var_11_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_9 = 0.200000002980232

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 and not isNil(var_11_8) then
				if arg_8_1.var_.characterEffect10140ui_story and not isNil(var_11_8) then
					arg_8_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_8_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_9)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 and not isNil(var_11_8) and arg_8_1.var_.characterEffect10140ui_story then
				arg_8_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_8_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_11_10 = 0
			local var_11_11 = 0.3

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(303032002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 12 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 12)

				if (12 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 12)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032002", "story_v_out_303032.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_303032", "303032002", "story_v_out_303032.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_303032", "303032002", "story_v_out_303032.awb")

						arg_8_1:RecordAudio("303032002", var_11_17)
						arg_8_1:RecordAudio("303032002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_303032", "303032002", "story_v_out_303032.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_303032", "303032002", "story_v_out_303032.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_18 = math.max(var_11_11, arg_8_1.talkMaxDuration)

			if var_11_10 <= arg_8_1.time_ and arg_8_1.time_ < var_11_10 + var_11_18 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_10) / var_11_18

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_10 + var_11_18 and arg_8_1.time_ < var_11_10 + var_11_18 + arg_11_0 then
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
	Play303032003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 303032003
		arg_12_1.duration_ = 5.53

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play303032004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			local var_15_9000

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = arg_12_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_15_0 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 then
				arg_12_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_0)
				arg_12_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).z)
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles = arg_12_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 then
				arg_12_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_12_1.actors_["1084ui_story"].transform.position).z)
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_12_1.actors_["1084ui_story"].transform.localEulerAngles = arg_12_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_15_1 = arg_12_1.actors_["10140ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos10140ui_story = var_15_1.localPosition

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_1.gameObject, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end
			end

			local var_15_3 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 then
				var_15_1.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_3)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 then
				var_15_1.localPosition = Vector3.New(0, 100, 0)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles

				local var_15_4 = GameObjectTools.GetOrAddComponent(var_15_1.gameObject, typeof(DynamicBoneHelper))

				if var_15_4 then
					var_15_4:EnableDynamicBone(true)
				end
			end

			local var_15_5 = arg_12_1.actors_["1084ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = var_15_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_6 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_6 and not isNil(var_15_5) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(var_15_5) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_6)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_6 and arg_12_1.time_ < 0 + var_15_6 + arg_15_0 and not isNil(var_15_5) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_15_7 = manager.ui.mainCamera.transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.shakeOldPos = var_15_7.localPosition
			end

			local var_15_8 = 1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_8 then
				local var_15_9, var_15_10 = math.modf((arg_12_1.time_ - 0) / 0.066)

				var_15_7.localPosition = Vector3.New(var_15_10 * 0.13, var_15_10 * 0.13, var_15_10 * 0.13) + arg_12_1.var_.shakeOldPos
			end

			if arg_12_1.time_ >= 0 + var_15_8 and arg_12_1.time_ < 0 + var_15_8 + arg_15_0 then
				var_15_7.localPosition = arg_12_1.var_.shakeOldPos
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				local var_15_11 = arg_12_1.var_.effecthongsejinggao

				if not arg_12_1.var_.effecthongsejinggao then
					var_15_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_redlight_keep"), manager.ui.mainCamera.transform)
					var_15_11.name = "hongsejinggao"
					arg_12_1.var_.effecthongsejinggao = var_15_11
				else
					var_15_11.transform:SetParent(var_15_9000)
				end

				var_15_11.transform.localPosition = Vector3.New(0, 0, 0)
				var_15_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_15_11.transform.localScale = Vector3.New(var_15_11.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_15_11.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_15_11.transform.localScale.z)
			end

			local var_15_13 = 0
			local var_15_14 = 1.525

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_13 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, false)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_15 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(303032003).content)

				arg_12_1.text_.text = var_15_15

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_17 = 61 <= 0 and var_15_14 or var_15_14 * (utf8.len(var_15_15) / 61)

				if (61 <= 0 and var_15_14 or var_15_14 * (utf8.len(var_15_15) / 61)) > 0 and var_15_14 < var_15_17 then
					arg_12_1.talkMaxDuration = var_15_17

					if var_15_17 + var_15_13 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_17 + var_15_13
					end
				end

				arg_12_1.text_.text = var_15_15
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_14, arg_12_1.talkMaxDuration)

			if var_15_13 <= arg_12_1.time_ and arg_12_1.time_ < var_15_13 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_13) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_13 + var_15_18 and arg_12_1.time_ < var_15_13 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play303032004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 303032004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play303032005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				if arg_16_1.var_.effecthongsejinggao then
					Object.Destroy(arg_16_1.var_.effecthongsejinggao)

					arg_16_1.var_.effecthongsejinggao = nil
				end
			end

			local var_19_1 = 0
			local var_19_2 = 2

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_1 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, false)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_3 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(303032004).content)

				arg_16_1.text_.text = var_19_3

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_5 = 80 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 80)

				if (80 <= 0 and var_19_2 or var_19_2 * (utf8.len(var_19_3) / 80)) > 0 and var_19_2 < var_19_5 then
					arg_16_1.talkMaxDuration = var_19_5

					if var_19_5 + var_19_1 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_5 + var_19_1
					end
				end

				arg_16_1.text_.text = var_19_3
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_6 = math.max(var_19_2, arg_16_1.talkMaxDuration)

			if var_19_1 <= arg_16_1.time_ and arg_16_1.time_ < var_19_1 + var_19_6 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_1) / var_19_6

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_1 + var_19_6 and arg_16_1.time_ < var_19_1 + var_19_6 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play303032005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 303032005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play303032006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			local var_23_0 = 0.425

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

				local var_23_1 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(303032005).content)

				arg_20_1.text_.text = var_23_1

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_3 = 17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 17)

				if (17 <= 0 and var_23_0 or var_23_0 * (utf8.len(var_23_1) / 17)) > 0 and var_23_0 < var_23_3 then
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
	Play303032006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 303032006
		arg_24_1.duration_ = 5.57

		local var_24_0 = {
			zh = 3.866,
			ja = 5.566
		}
		local var_24_1 = manager.audio:GetLocalizationFlag()

		if var_24_0[var_24_1] ~= nil then
			arg_24_1.duration_ = var_24_0[var_24_1]
		end

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play303032007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos10140ui_story = arg_24_1.actors_["10140ui_story"].transform.localPosition

				local var_27_0 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_0 then
					var_27_0:EnableDynamicBone(false)
				end
			end

			local var_27_1 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_1 then
				arg_24_1.actors_["10140ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos10140ui_story, Vector3.New(0, -0.96, -6.29), (arg_24_1.time_ - 0) / var_27_1)
				arg_24_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10140ui_story"].transform.position).z)
				arg_24_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10140ui_story"].transform.localEulerAngles = arg_24_1.actors_["10140ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_1 and arg_24_1.time_ < 0 + var_27_1 + arg_27_0 then
				arg_24_1.actors_["10140ui_story"].transform.localPosition = Vector3.New(0, -0.96, -6.29)
				arg_24_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["10140ui_story"].transform.position).z)
				arg_24_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["10140ui_story"].transform.localEulerAngles = arg_24_1.actors_["10140ui_story"].transform.localEulerAngles

				local var_27_2 = GameObjectTools.GetOrAddComponent(arg_24_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(true)
				end
			end

			local var_27_3 = arg_24_1.actors_["10140ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect10140ui_story == nil then
				arg_24_1.var_.characterEffect10140ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect10140ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect10140ui_story then
				arg_24_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_2")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_27_6 = 0
			local var_27_7 = 0.475

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_6 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_8 = arg_24_1:GetWordFromCfg(303032006)
				local var_27_9 = arg_24_1:FormatText(var_27_8.content)

				arg_24_1.text_.text = var_27_9

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_11 = 19 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 19)

				if (19 <= 0 and var_27_7 or var_27_7 * (utf8.len(var_27_9) / 19)) > 0 and var_27_7 < var_27_11 then
					arg_24_1.talkMaxDuration = var_27_11

					if var_27_11 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_11 + var_27_6
					end
				end

				arg_24_1.text_.text = var_27_9
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032006", "story_v_out_303032.awb") ~= 0 then
					local var_27_12 = manager.audio:GetVoiceLength("story_v_out_303032", "303032006", "story_v_out_303032.awb") / 1000

					if var_27_12 + var_27_6 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_12 + var_27_6
					end

					if var_27_8.prefab_name ~= "" and arg_24_1.actors_[var_27_8.prefab_name] ~= nil then
						local var_27_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_8.prefab_name].transform, "story_v_out_303032", "303032006", "story_v_out_303032.awb")

						arg_24_1:RecordAudio("303032006", var_27_13)
						arg_24_1:RecordAudio("303032006", var_27_13)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_303032", "303032006", "story_v_out_303032.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_303032", "303032006", "story_v_out_303032.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_14 = math.max(var_27_7, arg_24_1.talkMaxDuration)

			if var_27_6 <= arg_24_1.time_ and arg_24_1.time_ < var_27_6 + var_27_14 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_6) / var_27_14

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_6 + var_27_14 and arg_24_1.time_ < var_27_6 + var_27_14 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
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

		arg_24_1:InitPlayNodeList()
	end,
	Play303032007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 303032007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play303032008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["10140ui_story"]) and arg_28_1.var_.characterEffect10140ui_story == nil then
				arg_28_1.var_.characterEffect10140ui_story = arg_28_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.200000002980232

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["10140ui_story"]) then
				if arg_28_1.var_.characterEffect10140ui_story and not isNil(arg_28_1.actors_["10140ui_story"]) then
					arg_28_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_28_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["10140ui_story"]) and arg_28_1.var_.characterEffect10140ui_story then
				arg_28_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_28_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_31_1 = 0
			local var_31_2 = 0.125

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, true)
				arg_28_1.iconController_:SetSelectedState("hero")

				arg_28_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_28_1.callingController_:SetSelectedState("normal")

				arg_28_1.keyicon_.color = Color.New(1, 1, 1)
				arg_28_1.icon_.color = Color.New(1, 1, 1)

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(303032007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 5 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 5)

				if (5 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 5)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play303032008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 303032008
		arg_32_1.duration_ = 9

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play303032009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.bgs_.B15f == nil then
				local var_35_0 = Object.Instantiate(arg_32_1.paintGo_)

				var_35_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B15f")
				var_35_0.name = "B15f"
				var_35_0.transform.parent = arg_32_1.stage_.transform
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.bgs_.B15f = var_35_0
			end

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= 2 + arg_35_0 then
				local var_35_1 = arg_32_1.bgs_.B15f

				arg_32_1.bgs_.B15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_35_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_35_2 = var_35_1:GetComponent("SpriteRenderer")

				if var_35_2 and var_35_2.sprite then
					local var_35_3 = 2 * (var_35_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_35_1.transform.localScale = Vector3.New(var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, var_35_3 / var_35_2.sprite.bounds.size.y < var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x and var_35_3 * manager.ui.mainCameraCom_.aspect / var_35_2.sprite.bounds.size.x or var_35_3 / var_35_2.sprite.bounds.size.y, 0)
				end

				for iter_35_0, iter_35_1 in pairs(arg_32_1.bgs_) do
					if iter_35_0 ~= "B15f" then
						iter_35_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_35_4 = 4

			if 4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.allBtn_.enabled = false
			end

			if arg_32_1.time_ >= var_35_4 + 0.3 and arg_32_1.time_ < var_35_4 + 0.3 + arg_35_0 then
				arg_32_1.allBtn_.enabled = true
			end

			local var_35_5 = 0

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_5 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_6 = 2

			if var_35_5 <= arg_32_1.time_ and arg_32_1.time_ < var_35_5 + var_35_6 then
				local var_35_7 = Color.New(0, 0, 0)

				var_35_7.a = Mathf.Lerp(0, 1, (arg_32_1.time_ - var_35_5) / var_35_6)
				arg_32_1.mask_.color = var_35_7
			end

			if arg_32_1.time_ >= var_35_5 + var_35_6 and arg_32_1.time_ < var_35_5 + var_35_6 + arg_35_0 then
				local var_35_8 = Color.New(0, 0, 0)

				var_35_8.a = 1
				arg_32_1.mask_.color = var_35_8
			end

			local var_35_9 = 2

			if 2 < arg_32_1.time_ and arg_32_1.time_ <= var_35_9 + arg_35_0 then
				arg_32_1.mask_.enabled = true
				arg_32_1.mask_.raycastTarget = true

				arg_32_1:SetGaussion(false)
			end

			local var_35_10 = 2

			if var_35_9 <= arg_32_1.time_ and arg_32_1.time_ < var_35_9 + var_35_10 then
				local var_35_11 = Color.New(0, 0, 0)

				var_35_11.a = Mathf.Lerp(1, 0, (arg_32_1.time_ - var_35_9) / var_35_10)
				arg_32_1.mask_.color = var_35_11
			end

			if arg_32_1.time_ >= var_35_9 + var_35_10 and arg_32_1.time_ < var_35_9 + var_35_10 + arg_35_0 then
				local var_35_12 = Color.New(0, 0, 0)

				arg_32_1.mask_.enabled = false
				var_35_12.a = 0
				arg_32_1.mask_.color = var_35_12
			end

			local var_35_13 = arg_32_1.actors_["10140ui_story"].transform

			if 1.96599999815226 < arg_32_1.time_ and arg_32_1.time_ <= 1.96599999815226 + arg_35_0 then
				arg_32_1.var_.moveOldPos10140ui_story = var_35_13.localPosition

				local var_35_14 = GameObjectTools.GetOrAddComponent(var_35_13.gameObject, typeof(DynamicBoneHelper))

				if var_35_14 then
					var_35_14:EnableDynamicBone(false)
				end
			end

			local var_35_15 = 0.001

			if 1.96599999815226 <= arg_32_1.time_ and arg_32_1.time_ < 1.96599999815226 + var_35_15 then
				var_35_13.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 1.96599999815226) / var_35_15)
				var_35_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_13.position).x, (manager.ui.mainCamera.transform.position - var_35_13.position).y, (manager.ui.mainCamera.transform.position - var_35_13.position).z)
				var_35_13.localEulerAngles.z = 0
				var_35_13.localEulerAngles.x = 0
				var_35_13.localEulerAngles = var_35_13.localEulerAngles
			end

			if arg_32_1.time_ >= 1.96599999815226 + var_35_15 and arg_32_1.time_ < 1.96599999815226 + var_35_15 + arg_35_0 then
				var_35_13.localPosition = Vector3.New(0, 100, 0)
				var_35_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_13.position).x, (manager.ui.mainCamera.transform.position - var_35_13.position).y, (manager.ui.mainCamera.transform.position - var_35_13.position).z)
				var_35_13.localEulerAngles.z = 0
				var_35_13.localEulerAngles.x = 0
				var_35_13.localEulerAngles = var_35_13.localEulerAngles

				local var_35_16 = GameObjectTools.GetOrAddComponent(var_35_13.gameObject, typeof(DynamicBoneHelper))

				if var_35_16 then
					var_35_16:EnableDynamicBone(true)
				end
			end

			if 0.2 < arg_32_1.time_ and arg_32_1.time_ <= 0.2 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 0.2 < arg_32_1.time_ and arg_32_1.time_ <= 0.2 + arg_35_0 then
				arg_32_1:AudioAction("stop", "effect", "se_story_141", "se_story_141_amb_street_night02", "")
			end

			if arg_32_1.frameCnt_ <= 1 then
				arg_32_1.dialog_:SetActive(false)
			end

			local var_35_19 = 4
			local var_35_20 = 1.55

			if 4 < arg_32_1.time_ and arg_32_1.time_ <= var_35_19 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0

				arg_32_1.dialog_:SetActive(true)

				arg_32_1.dialogCg_.alpha = 0

				local var_35_21 = LeanTween.value(arg_32_1.dialog_, 0, 1, 0.3)

				var_35_21:setOnUpdate(LuaHelper.FloatAction(function(arg_36_0)
					arg_32_1.dialogCg_.alpha = arg_36_0
				end))
				var_35_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_32_1.dialog_)
					var_35_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_32_1.duration_ = arg_32_1.duration_ + 0.3

				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_22 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(303032008).content)

				arg_32_1.text_.text = var_35_22

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_24 = 62 <= 0 and var_35_20 or var_35_20 * (utf8.len(var_35_22) / 62)

				if (62 <= 0 and var_35_20 or var_35_20 * (utf8.len(var_35_22) / 62)) > 0 and var_35_20 < var_35_24 then
					arg_32_1.talkMaxDuration = var_35_24
					var_35_19 = var_35_19 + 0.3

					if var_35_24 + var_35_19 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_24 + var_35_19
					end
				end

				arg_32_1.text_.text = var_35_22
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_25 = var_35_19 + 0.3
			local var_35_26 = math.max(var_35_20, arg_32_1.talkMaxDuration)

			if var_35_19 + 0.3 <= arg_32_1.time_ and arg_32_1.time_ < var_35_25 + var_35_26 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_25) / var_35_26

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_25 + var_35_26 and arg_32_1.time_ < var_35_25 + var_35_26 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10140ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play303032009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 303032009
		arg_38_1.duration_ = 7.47

		local var_38_0 = {
			zh = 5.733,
			ja = 7.466
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
				arg_38_0:Play303032010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1.var_.moveOldPos10140ui_story = arg_38_1.actors_["10140ui_story"].transform.localPosition

				local var_41_0 = GameObjectTools.GetOrAddComponent(arg_38_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_41_0 then
					var_41_0:EnableDynamicBone(false)
				end
			end

			local var_41_1 = 0.001

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_1 then
				arg_38_1.actors_["10140ui_story"].transform.localPosition = Vector3.Lerp(arg_38_1.var_.moveOldPos10140ui_story, Vector3.New(-0.7, -0.96, -6.29), (arg_38_1.time_ - 0) / var_41_1)
				arg_38_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10140ui_story"].transform.position).z)
				arg_38_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["10140ui_story"].transform.localEulerAngles = arg_38_1.actors_["10140ui_story"].transform.localEulerAngles
			end

			if arg_38_1.time_ >= 0 + var_41_1 and arg_38_1.time_ < 0 + var_41_1 + arg_41_0 then
				arg_38_1.actors_["10140ui_story"].transform.localPosition = Vector3.New(-0.7, -0.96, -6.29)
				arg_38_1.actors_["10140ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_38_1.actors_["10140ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10140ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_38_1.actors_["10140ui_story"].transform.position).z)
				arg_38_1.actors_["10140ui_story"].transform.localEulerAngles.z = 0
				arg_38_1.actors_["10140ui_story"].transform.localEulerAngles.x = 0
				arg_38_1.actors_["10140ui_story"].transform.localEulerAngles = arg_38_1.actors_["10140ui_story"].transform.localEulerAngles

				local var_41_2 = GameObjectTools.GetOrAddComponent(arg_38_1.actors_["10140ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_41_2 then
					var_41_2:EnableDynamicBone(true)
				end
			end

			local var_41_3 = arg_38_1.actors_["10140ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect10140ui_story == nil then
				arg_38_1.var_.characterEffect10140ui_story = var_41_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_4 = 0.200000002980232

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 and not isNil(var_41_3) then
				if arg_38_1.var_.characterEffect10140ui_story and not isNil(var_41_3) then
					arg_38_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect10140ui_story then
				arg_38_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action1_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_41_6 = 0
			local var_41_7 = 0.525

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_6 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_8 = arg_38_1:GetWordFromCfg(303032009)
				local var_41_9 = arg_38_1:FormatText(var_41_8.content)

				arg_38_1.text_.text = var_41_9

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_11 = 21 <= 0 and var_41_7 or var_41_7 * (utf8.len(var_41_9) / 21)

				if (21 <= 0 and var_41_7 or var_41_7 * (utf8.len(var_41_9) / 21)) > 0 and var_41_7 < var_41_11 then
					arg_38_1.talkMaxDuration = var_41_11

					if var_41_11 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_6
					end
				end

				arg_38_1.text_.text = var_41_9
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032009", "story_v_out_303032.awb") ~= 0 then
					local var_41_12 = manager.audio:GetVoiceLength("story_v_out_303032", "303032009", "story_v_out_303032.awb") / 1000

					if var_41_12 + var_41_6 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_12 + var_41_6
					end

					if var_41_8.prefab_name ~= "" and arg_38_1.actors_[var_41_8.prefab_name] ~= nil then
						local var_41_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_8.prefab_name].transform, "story_v_out_303032", "303032009", "story_v_out_303032.awb")

						arg_38_1:RecordAudio("303032009", var_41_13)
						arg_38_1:RecordAudio("303032009", var_41_13)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_303032", "303032009", "story_v_out_303032.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_303032", "303032009", "story_v_out_303032.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_14 = math.max(var_41_7, arg_38_1.talkMaxDuration)

			if var_41_6 <= arg_38_1.time_ and arg_38_1.time_ < var_41_6 + var_41_14 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_6) / var_41_14

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_6 + var_41_14 and arg_38_1.time_ < var_41_6 + var_41_14 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {
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

		arg_38_1:InitPlayNodeList()
	end,
	Play303032010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 303032010
		arg_42_1.duration_ = 5.67

		local var_42_0 = {
			zh = 5.166,
			ja = 5.666
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
				arg_42_0:Play303032011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1.var_.moveOldPos1084ui_story = arg_42_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_45_0 = 0.001

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_0 then
				arg_42_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_42_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_42_1.time_ - 0) / var_45_0)
				arg_42_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1084ui_story"].transform.position).z)
				arg_42_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1084ui_story"].transform.localEulerAngles = arg_42_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_42_1.time_ >= 0 + var_45_0 and arg_42_1.time_ < 0 + var_45_0 + arg_45_0 then
				arg_42_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_42_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_42_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_42_1.actors_["1084ui_story"].transform.position).z)
				arg_42_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_42_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_42_1.actors_["1084ui_story"].transform.localEulerAngles = arg_42_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_45_1 = arg_42_1.actors_["1084ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1084ui_story == nil then
				arg_42_1.var_.characterEffect1084ui_story = var_45_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_2 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_2 and not isNil(var_45_1) then
				if arg_42_1.var_.characterEffect1084ui_story and not isNil(var_45_1) then
					arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_2 and arg_42_1.time_ < 0 + var_45_2 + arg_45_0 and not isNil(var_45_1) and arg_42_1.var_.characterEffect1084ui_story then
				arg_42_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_45_4 = arg_42_1.actors_["10140ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect10140ui_story == nil then
				arg_42_1.var_.characterEffect10140ui_story = var_45_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_5 = 0.200000002980232

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_5 and not isNil(var_45_4) then
				if arg_42_1.var_.characterEffect10140ui_story and not isNil(var_45_4) then
					arg_42_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_42_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_5)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_5 and arg_42_1.time_ < 0 + var_45_5 + arg_45_0 and not isNil(var_45_4) and arg_42_1.var_.characterEffect10140ui_story then
				arg_42_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_42_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_45_6 = 0
			local var_45_7 = 0.625

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_6 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_8 = arg_42_1:GetWordFromCfg(303032010)
				local var_45_9 = arg_42_1:FormatText(var_45_8.content)

				arg_42_1.text_.text = var_45_9

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_11 = 25 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 25)

				if (25 <= 0 and var_45_7 or var_45_7 * (utf8.len(var_45_9) / 25)) > 0 and var_45_7 < var_45_11 then
					arg_42_1.talkMaxDuration = var_45_11

					if var_45_11 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_6
					end
				end

				arg_42_1.text_.text = var_45_9
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032010", "story_v_out_303032.awb") ~= 0 then
					local var_45_12 = manager.audio:GetVoiceLength("story_v_out_303032", "303032010", "story_v_out_303032.awb") / 1000

					if var_45_12 + var_45_6 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_12 + var_45_6
					end

					if var_45_8.prefab_name ~= "" and arg_42_1.actors_[var_45_8.prefab_name] ~= nil then
						local var_45_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_8.prefab_name].transform, "story_v_out_303032", "303032010", "story_v_out_303032.awb")

						arg_42_1:RecordAudio("303032010", var_45_13)
						arg_42_1:RecordAudio("303032010", var_45_13)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_303032", "303032010", "story_v_out_303032.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_303032", "303032010", "story_v_out_303032.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_14 = math.max(var_45_7, arg_42_1.talkMaxDuration)

			if var_45_6 <= arg_42_1.time_ and arg_42_1.time_ < var_45_6 + var_45_14 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_6) / var_45_14

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_6 + var_45_14 and arg_42_1.time_ < var_45_6 + var_45_14 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {
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

		arg_42_1:InitPlayNodeList()
	end,
	Play303032011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 303032011
		arg_46_1.duration_ = 5.6

		local var_46_0 = {
			zh = 5.1,
			ja = 5.6
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
				arg_46_0:Play303032012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_49_0 = 0
			local var_49_1 = 0.725

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_0 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_2 = arg_46_1:GetWordFromCfg(303032011)
				local var_49_3 = arg_46_1:FormatText(var_49_2.content)

				arg_46_1.text_.text = var_49_3

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_5 = 29 <= 0 and var_49_1 or var_49_1 * (utf8.len(var_49_3) / 29)

				if (29 <= 0 and var_49_1 or var_49_1 * (utf8.len(var_49_3) / 29)) > 0 and var_49_1 < var_49_5 then
					arg_46_1.talkMaxDuration = var_49_5

					if var_49_5 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_5 + var_49_0
					end
				end

				arg_46_1.text_.text = var_49_3
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032011", "story_v_out_303032.awb") ~= 0 then
					local var_49_6 = manager.audio:GetVoiceLength("story_v_out_303032", "303032011", "story_v_out_303032.awb") / 1000

					if var_49_6 + var_49_0 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_6 + var_49_0
					end

					if var_49_2.prefab_name ~= "" and arg_46_1.actors_[var_49_2.prefab_name] ~= nil then
						local var_49_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_2.prefab_name].transform, "story_v_out_303032", "303032011", "story_v_out_303032.awb")

						arg_46_1:RecordAudio("303032011", var_49_7)
						arg_46_1:RecordAudio("303032011", var_49_7)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_303032", "303032011", "story_v_out_303032.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_303032", "303032011", "story_v_out_303032.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_8 = math.max(var_49_1, arg_46_1.talkMaxDuration)

			if var_49_0 <= arg_46_1.time_ and arg_46_1.time_ < var_49_0 + var_49_8 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_0) / var_49_8

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_0 + var_49_8 and arg_46_1.time_ < var_49_0 + var_49_8 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {}

		arg_46_1:InitPlayNodeList()
	end,
	Play303032012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 303032012
		arg_50_1.duration_ = 5

		SetActive(arg_50_1.tipsGo_, false)

		function arg_50_1.onSingleLineFinish_()
			arg_50_1.onSingleLineUpdate_ = nil
			arg_50_1.onSingleLineFinish_ = nil
			arg_50_1.state_ = "waiting"
		end

		function arg_50_1.playNext_(arg_52_0)
			if arg_52_0 == 1 then
				arg_50_0:Play303032013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1084ui_story"]) and arg_50_1.var_.characterEffect1084ui_story == nil then
				arg_50_1.var_.characterEffect1084ui_story = arg_50_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.200000002980232

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1084ui_story"]) then
				if arg_50_1.var_.characterEffect1084ui_story and not isNil(arg_50_1.actors_["1084ui_story"]) then
					arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_0)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1084ui_story"]) and arg_50_1.var_.characterEffect1084ui_story then
				arg_50_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_53_1 = arg_50_1.actors_["10140ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos10140ui_story = var_53_1.localPosition

				local var_53_2 = GameObjectTools.GetOrAddComponent(var_53_1.gameObject, typeof(DynamicBoneHelper))

				if var_53_2 then
					var_53_2:EnableDynamicBone(false)
				end
			end

			local var_53_3 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 then
				var_53_1.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_3)
				var_53_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_1.position).x, (manager.ui.mainCamera.transform.position - var_53_1.position).y, (manager.ui.mainCamera.transform.position - var_53_1.position).z)
				var_53_1.localEulerAngles.z = 0
				var_53_1.localEulerAngles.x = 0
				var_53_1.localEulerAngles = var_53_1.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 then
				var_53_1.localPosition = Vector3.New(0, 100, 0)
				var_53_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_1.position).x, (manager.ui.mainCamera.transform.position - var_53_1.position).y, (manager.ui.mainCamera.transform.position - var_53_1.position).z)
				var_53_1.localEulerAngles.z = 0
				var_53_1.localEulerAngles.x = 0
				var_53_1.localEulerAngles = var_53_1.localEulerAngles

				local var_53_4 = GameObjectTools.GetOrAddComponent(var_53_1.gameObject, typeof(DynamicBoneHelper))

				if var_53_4 then
					var_53_4:EnableDynamicBone(true)
				end
			end

			local var_53_5 = arg_50_1.actors_["1084ui_story"].transform

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1.var_.moveOldPos1084ui_story = var_53_5.localPosition
			end

			local var_53_6 = 0.001

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_6 then
				var_53_5.localPosition = Vector3.Lerp(arg_50_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_50_1.time_ - 0) / var_53_6)
				var_53_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_5.position).x, (manager.ui.mainCamera.transform.position - var_53_5.position).y, (manager.ui.mainCamera.transform.position - var_53_5.position).z)
				var_53_5.localEulerAngles.z = 0
				var_53_5.localEulerAngles.x = 0
				var_53_5.localEulerAngles = var_53_5.localEulerAngles
			end

			if arg_50_1.time_ >= 0 + var_53_6 and arg_50_1.time_ < 0 + var_53_6 + arg_53_0 then
				var_53_5.localPosition = Vector3.New(0, 100, 0)
				var_53_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_53_5.position).x, (manager.ui.mainCamera.transform.position - var_53_5.position).y, (manager.ui.mainCamera.transform.position - var_53_5.position).z)
				var_53_5.localEulerAngles.z = 0
				var_53_5.localEulerAngles.x = 0
				var_53_5.localEulerAngles = var_53_5.localEulerAngles
			end

			local var_53_7 = 0
			local var_53_8 = 1.55

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_7 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, false)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_9 = arg_50_1:FormatText(arg_50_1:GetWordFromCfg(303032012).content)

				arg_50_1.text_.text = var_53_9

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_11 = 62 <= 0 and var_53_8 or var_53_8 * (utf8.len(var_53_9) / 62)

				if (62 <= 0 and var_53_8 or var_53_8 * (utf8.len(var_53_9) / 62)) > 0 and var_53_8 < var_53_11 then
					arg_50_1.talkMaxDuration = var_53_11

					if var_53_11 + var_53_7 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_11 + var_53_7
					end
				end

				arg_50_1.text_.text = var_53_9
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)
				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_12 = math.max(var_53_8, arg_50_1.talkMaxDuration)

			if var_53_7 <= arg_50_1.time_ and arg_50_1.time_ < var_53_7 + var_53_12 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_7) / var_53_12

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_7 + var_53_12 and arg_50_1.time_ < var_53_7 + var_53_12 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {
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

		arg_50_1:InitPlayNodeList()
	end,
	Play303032013 = function(arg_54_0, arg_54_1)
		arg_54_1.time_ = 0
		arg_54_1.frameCnt_ = 0
		arg_54_1.state_ = "playing"
		arg_54_1.curTalkId_ = 303032013
		arg_54_1.duration_ = 5

		SetActive(arg_54_1.tipsGo_, false)

		function arg_54_1.onSingleLineFinish_()
			arg_54_1.onSingleLineUpdate_ = nil
			arg_54_1.onSingleLineFinish_ = nil
			arg_54_1.state_ = "waiting"
		end

		function arg_54_1.playNext_(arg_56_0)
			if arg_56_0 == 1 then
				arg_54_0:Play303032014(arg_54_1)
			end
		end

		function arg_54_1.onSingleLineUpdate_(arg_57_0)
			local var_57_0 = 0.325

			if 0 < arg_54_1.time_ and arg_54_1.time_ <= 0 + arg_57_0 then
				arg_54_1.talkMaxDuration = 0
				arg_54_1.dialogCg_.alpha = 1

				arg_54_1.dialog_:SetActive(true)
				SetActive(arg_54_1.leftNameGo_, true)

				arg_54_1.leftNameTxt_.text = arg_54_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_54_1.leftNameTxt_.transform)

				arg_54_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_54_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_54_1:RecordName(arg_54_1.leftNameTxt_.text)
				SetActive(arg_54_1.iconTrs_.gameObject, true)
				arg_54_1.iconController_:SetSelectedState("hero")

				arg_54_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_54_1.callingController_:SetSelectedState("normal")

				arg_54_1.keyicon_.color = Color.New(1, 1, 1)
				arg_54_1.icon_.color = Color.New(1, 1, 1)

				local var_57_1 = arg_54_1:FormatText(arg_54_1:GetWordFromCfg(303032013).content)

				arg_54_1.text_.text = var_57_1

				LuaForUtil.ClearLinePrefixSymbol(arg_54_1.text_)

				local var_57_3 = 13 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 13)

				if (13 <= 0 and var_57_0 or var_57_0 * (utf8.len(var_57_1) / 13)) > 0 and var_57_0 < var_57_3 then
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
	Play303032014 = function(arg_58_0, arg_58_1)
		arg_58_1.time_ = 0
		arg_58_1.frameCnt_ = 0
		arg_58_1.state_ = "playing"
		arg_58_1.curTalkId_ = 303032014
		arg_58_1.duration_ = 5.33

		local var_58_0 = {
			zh = 5.033,
			ja = 5.333
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
				arg_58_0:Play303032015(arg_58_1)
			end
		end

		function arg_58_1.onSingleLineUpdate_(arg_61_0)
			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1.var_.moveOldPos1084ui_story = arg_58_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_61_0 = 0.001

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_0 then
				arg_58_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_58_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_58_1.time_ - 0) / var_61_0)
				arg_58_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1084ui_story"].transform.position).z)
				arg_58_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1084ui_story"].transform.localEulerAngles = arg_58_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_58_1.time_ >= 0 + var_61_0 and arg_58_1.time_ < 0 + var_61_0 + arg_61_0 then
				arg_58_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_58_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_58_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_58_1.actors_["1084ui_story"].transform.position).z)
				arg_58_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_58_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_58_1.actors_["1084ui_story"].transform.localEulerAngles = arg_58_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_61_1 = arg_58_1.actors_["1084ui_story"]

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1084ui_story == nil then
				arg_58_1.var_.characterEffect1084ui_story = var_61_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_61_2 = 0.200000002980232

			if 0 <= arg_58_1.time_ and arg_58_1.time_ < 0 + var_61_2 and not isNil(var_61_1) then
				if arg_58_1.var_.characterEffect1084ui_story and not isNil(var_61_1) then
					arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_58_1.time_ >= 0 + var_61_2 and arg_58_1.time_ < 0 + var_61_2 + arg_61_0 and not isNil(var_61_1) and arg_58_1.var_.characterEffect1084ui_story then
				arg_58_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= 0 + arg_61_0 then
				arg_58_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_61_4 = 0
			local var_61_5 = 0.425

			if 0 < arg_58_1.time_ and arg_58_1.time_ <= var_61_4 + arg_61_0 then
				arg_58_1.talkMaxDuration = 0
				arg_58_1.dialogCg_.alpha = 1

				arg_58_1.dialog_:SetActive(true)
				SetActive(arg_58_1.leftNameGo_, true)

				arg_58_1.leftNameTxt_.text = arg_58_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_58_1.leftNameTxt_.transform)

				arg_58_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_58_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_58_1:RecordName(arg_58_1.leftNameTxt_.text)
				SetActive(arg_58_1.iconTrs_.gameObject, false)
				arg_58_1.callingController_:SetSelectedState("normal")

				local var_61_6 = arg_58_1:GetWordFromCfg(303032014)
				local var_61_7 = arg_58_1:FormatText(var_61_6.content)

				arg_58_1.text_.text = var_61_7

				LuaForUtil.ClearLinePrefixSymbol(arg_58_1.text_)

				local var_61_9 = 17 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 17)

				if (17 <= 0 and var_61_5 or var_61_5 * (utf8.len(var_61_7) / 17)) > 0 and var_61_5 < var_61_9 then
					arg_58_1.talkMaxDuration = var_61_9

					if var_61_9 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_9 + var_61_4
					end
				end

				arg_58_1.text_.text = var_61_7
				arg_58_1.typewritter.percent = 0

				arg_58_1.typewritter:SetDirty()
				arg_58_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032014", "story_v_out_303032.awb") ~= 0 then
					local var_61_10 = manager.audio:GetVoiceLength("story_v_out_303032", "303032014", "story_v_out_303032.awb") / 1000

					if var_61_10 + var_61_4 > arg_58_1.duration_ then
						arg_58_1.duration_ = var_61_10 + var_61_4
					end

					if var_61_6.prefab_name ~= "" and arg_58_1.actors_[var_61_6.prefab_name] ~= nil then
						local var_61_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_58_1.actors_[var_61_6.prefab_name].transform, "story_v_out_303032", "303032014", "story_v_out_303032.awb")

						arg_58_1:RecordAudio("303032014", var_61_11)
						arg_58_1:RecordAudio("303032014", var_61_11)
					else
						arg_58_1:AudioAction("play", "voice", "story_v_out_303032", "303032014", "story_v_out_303032.awb")
					end

					arg_58_1:RecordHistoryTalkVoice("story_v_out_303032", "303032014", "story_v_out_303032.awb")
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

		arg_58_1.nodeConfigList_ = {
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

		arg_58_1:InitPlayNodeList()
	end,
	Play303032015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 303032015
		arg_62_1.duration_ = 7.93

		local var_62_0 = {
			zh = 5.333,
			ja = 7.933
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
				arg_62_0:Play303032016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			local var_65_0 = 0.7

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_1 = arg_62_1:GetWordFromCfg(303032015)
				local var_65_2 = arg_62_1:FormatText(var_65_1.content)

				arg_62_1.text_.text = var_65_2

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_4 = 28 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 28)

				if (28 <= 0 and var_65_0 or var_65_0 * (utf8.len(var_65_2) / 28)) > 0 and var_65_0 < var_65_4 then
					arg_62_1.talkMaxDuration = var_65_4

					if var_65_4 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_4 + 0
					end
				end

				arg_62_1.text_.text = var_65_2
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032015", "story_v_out_303032.awb") ~= 0 then
					local var_65_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032015", "story_v_out_303032.awb") / 1000

					if var_65_5 + 0 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_5 + 0
					end

					if var_65_1.prefab_name ~= "" and arg_62_1.actors_[var_65_1.prefab_name] ~= nil then
						local var_65_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_1.prefab_name].transform, "story_v_out_303032", "303032015", "story_v_out_303032.awb")

						arg_62_1:RecordAudio("303032015", var_65_6)
						arg_62_1:RecordAudio("303032015", var_65_6)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_303032", "303032015", "story_v_out_303032.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_303032", "303032015", "story_v_out_303032.awb")
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
	Play303032016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 303032016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play303032017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1084ui_story"]) and arg_66_1.var_.characterEffect1084ui_story == nil then
				arg_66_1.var_.characterEffect1084ui_story = arg_66_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.200000002980232

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1084ui_story"]) then
				if arg_66_1.var_.characterEffect1084ui_story and not isNil(arg_66_1.actors_["1084ui_story"]) then
					arg_66_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1084ui_story"]) and arg_66_1.var_.characterEffect1084ui_story then
				arg_66_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.325

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

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(303032016).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 13 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 13)

				if (13 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 13)) > 0 and var_69_2 < var_69_5 then
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
	Play303032017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 303032017
		arg_70_1.duration_ = 4.83

		local var_70_0 = {
			zh = 3.1,
			ja = 4.833
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
				arg_70_0:Play303032018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = arg_70_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.200000002980232

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) then
				if arg_70_1.var_.characterEffect1084ui_story and not isNil(arg_70_1.actors_["1084ui_story"]) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_73_2 = 0
			local var_73_3 = 0.4

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_2 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_4 = arg_70_1:GetWordFromCfg(303032017)
				local var_73_5 = arg_70_1:FormatText(var_73_4.content)

				arg_70_1.text_.text = var_73_5

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_7 = 16 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 16)

				if (16 <= 0 and var_73_3 or var_73_3 * (utf8.len(var_73_5) / 16)) > 0 and var_73_3 < var_73_7 then
					arg_70_1.talkMaxDuration = var_73_7

					if var_73_7 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_7 + var_73_2
					end
				end

				arg_70_1.text_.text = var_73_5
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032017", "story_v_out_303032.awb") ~= 0 then
					local var_73_8 = manager.audio:GetVoiceLength("story_v_out_303032", "303032017", "story_v_out_303032.awb") / 1000

					if var_73_8 + var_73_2 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_8 + var_73_2
					end

					if var_73_4.prefab_name ~= "" and arg_70_1.actors_[var_73_4.prefab_name] ~= nil then
						local var_73_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_4.prefab_name].transform, "story_v_out_303032", "303032017", "story_v_out_303032.awb")

						arg_70_1:RecordAudio("303032017", var_73_9)
						arg_70_1:RecordAudio("303032017", var_73_9)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_303032", "303032017", "story_v_out_303032.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_303032", "303032017", "story_v_out_303032.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_10 = math.max(var_73_3, arg_70_1.talkMaxDuration)

			if var_73_2 <= arg_70_1.time_ and arg_70_1.time_ < var_73_2 + var_73_10 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_2) / var_73_10

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_2 + var_73_10 and arg_70_1.time_ < var_73_2 + var_73_10 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play303032018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 303032018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play303032019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["1084ui_story"]) and arg_74_1.var_.characterEffect1084ui_story == nil then
				arg_74_1.var_.characterEffect1084ui_story = arg_74_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.200000002980232

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["1084ui_story"]) then
				if arg_74_1.var_.characterEffect1084ui_story and not isNil(arg_74_1.actors_["1084ui_story"]) then
					arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_74_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["1084ui_story"]) and arg_74_1.var_.characterEffect1084ui_story then
				arg_74_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_74_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_77_1 = 0
			local var_77_2 = 0.3

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_1 + arg_77_0 then
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

				local var_77_3 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(303032018).content)

				arg_74_1.text_.text = var_77_3

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_5 = 12 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_3) / 12)

				if (12 <= 0 and var_77_2 or var_77_2 * (utf8.len(var_77_3) / 12)) > 0 and var_77_2 < var_77_5 then
					arg_74_1.talkMaxDuration = var_77_5

					if var_77_5 + var_77_1 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_5 + var_77_1
					end
				end

				arg_74_1.text_.text = var_77_3
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_6 = math.max(var_77_2, arg_74_1.talkMaxDuration)

			if var_77_1 <= arg_74_1.time_ and arg_74_1.time_ < var_77_1 + var_77_6 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_1) / var_77_6

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_1 + var_77_6 and arg_74_1.time_ < var_77_1 + var_77_6 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play303032019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 303032019
		arg_78_1.duration_ = 8.17

		local var_78_0 = {
			zh = 8.166,
			ja = 7.633
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play303032020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["1084ui_story"]) and arg_78_1.var_.characterEffect1084ui_story == nil then
				arg_78_1.var_.characterEffect1084ui_story = arg_78_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.200000002980232

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["1084ui_story"]) then
				if arg_78_1.var_.characterEffect1084ui_story and not isNil(arg_78_1.actors_["1084ui_story"]) then
					arg_78_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["1084ui_story"]) and arg_78_1.var_.characterEffect1084ui_story then
				arg_78_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_81_2 = 0
			local var_81_3 = 1.075

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(303032019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 43 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 43)

				if (43 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 43)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032019", "story_v_out_303032.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_303032", "303032019", "story_v_out_303032.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_303032", "303032019", "story_v_out_303032.awb")

						arg_78_1:RecordAudio("303032019", var_81_9)
						arg_78_1:RecordAudio("303032019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_303032", "303032019", "story_v_out_303032.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_303032", "303032019", "story_v_out_303032.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play303032020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 303032020
		arg_82_1.duration_ = 10.13

		local var_82_0 = {
			zh = 7.4,
			ja = 10.133
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
				arg_82_0:Play303032021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			local var_85_0 = 0.825

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_1 = arg_82_1:GetWordFromCfg(303032020)
				local var_85_2 = arg_82_1:FormatText(var_85_1.content)

				arg_82_1.text_.text = var_85_2

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_4 = 33 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 33)

				if (33 <= 0 and var_85_0 or var_85_0 * (utf8.len(var_85_2) / 33)) > 0 and var_85_0 < var_85_4 then
					arg_82_1.talkMaxDuration = var_85_4

					if var_85_4 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_4 + 0
					end
				end

				arg_82_1.text_.text = var_85_2
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032020", "story_v_out_303032.awb") ~= 0 then
					local var_85_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032020", "story_v_out_303032.awb") / 1000

					if var_85_5 + 0 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + 0
					end

					if var_85_1.prefab_name ~= "" and arg_82_1.actors_[var_85_1.prefab_name] ~= nil then
						local var_85_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_1.prefab_name].transform, "story_v_out_303032", "303032020", "story_v_out_303032.awb")

						arg_82_1:RecordAudio("303032020", var_85_6)
						arg_82_1:RecordAudio("303032020", var_85_6)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_303032", "303032020", "story_v_out_303032.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_303032", "303032020", "story_v_out_303032.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_7 = math.max(var_85_0, arg_82_1.talkMaxDuration)

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - 0) / var_85_7

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {}

		arg_82_1:InitPlayNodeList()
	end,
	Play303032021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 303032021
		arg_86_1.duration_ = 5

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play303032022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = arg_86_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.200000002980232

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) then
				if arg_86_1.var_.characterEffect1084ui_story and not isNil(arg_86_1.actors_["1084ui_story"]) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_86_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_0)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_86_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_89_1 = 0
			local var_89_2 = 0.175

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_1 + arg_89_0 then
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

				local var_89_3 = arg_86_1:FormatText(arg_86_1:GetWordFromCfg(303032021).content)

				arg_86_1.text_.text = var_89_3

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_5 = 7 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 7)

				if (7 <= 0 and var_89_2 or var_89_2 * (utf8.len(var_89_3) / 7)) > 0 and var_89_2 < var_89_5 then
					arg_86_1.talkMaxDuration = var_89_5

					if var_89_5 + var_89_1 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_5 + var_89_1
					end
				end

				arg_86_1.text_.text = var_89_3
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)
				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_6 = math.max(var_89_2, arg_86_1.talkMaxDuration)

			if var_89_1 <= arg_86_1.time_ and arg_86_1.time_ < var_89_1 + var_89_6 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_1) / var_89_6

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_1 + var_89_6 and arg_86_1.time_ < var_89_1 + var_89_6 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {}

		arg_86_1:InitPlayNodeList()
	end,
	Play303032022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 303032022
		arg_90_1.duration_ = 5

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play303032023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = arg_90_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_93_0 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 then
				arg_90_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_90_1.time_ - 0) / var_93_0)
				arg_90_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).z)
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles = arg_90_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 then
				arg_90_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_90_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_90_1.actors_["1084ui_story"].transform.position).z)
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_90_1.actors_["1084ui_story"].transform.localEulerAngles = arg_90_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_93_1 = 0
			local var_93_2 = 1.35

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_1 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, false)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_3 = arg_90_1:FormatText(arg_90_1:GetWordFromCfg(303032022).content)

				arg_90_1.text_.text = var_93_3

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_5 = 54 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 54)

				if (54 <= 0 and var_93_2 or var_93_2 * (utf8.len(var_93_3) / 54)) > 0 and var_93_2 < var_93_5 then
					arg_90_1.talkMaxDuration = var_93_5

					if var_93_5 + var_93_1 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_5 + var_93_1
					end
				end

				arg_90_1.text_.text = var_93_3
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)
				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_6 = math.max(var_93_2, arg_90_1.talkMaxDuration)

			if var_93_1 <= arg_90_1.time_ and arg_90_1.time_ < var_93_1 + var_93_6 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_1) / var_93_6

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_1 + var_93_6 and arg_90_1.time_ < var_93_1 + var_93_6 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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

		arg_90_1:InitPlayNodeList()
	end,
	Play303032023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 303032023
		arg_94_1.duration_ = 5

		SetActive(arg_94_1.tipsGo_, false)

		function arg_94_1.onSingleLineFinish_()
			arg_94_1.onSingleLineUpdate_ = nil
			arg_94_1.onSingleLineFinish_ = nil
			arg_94_1.state_ = "waiting"
		end

		function arg_94_1.playNext_(arg_96_0)
			if arg_96_0 == 1 then
				arg_94_0:Play303032024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			local var_97_0 = 0.35

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, true)
				arg_94_1.iconController_:SetSelectedState("hero")

				arg_94_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_94_1.callingController_:SetSelectedState("normal")

				arg_94_1.keyicon_.color = Color.New(1, 1, 1)
				arg_94_1.icon_.color = Color.New(1, 1, 1)

				local var_97_1 = arg_94_1:FormatText(arg_94_1:GetWordFromCfg(303032023).content)

				arg_94_1.text_.text = var_97_1

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_3 = 14 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 14)

				if (14 <= 0 and var_97_0 or var_97_0 * (utf8.len(var_97_1) / 14)) > 0 and var_97_0 < var_97_3 then
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
	Play303032024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 303032024
		arg_98_1.duration_ = 2.2

		local var_98_0 = {
			zh = 2.2,
			ja = 1.4
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
				arg_98_0:Play303032025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			local var_101_0 = 0.175

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, true)
				arg_98_1.iconController_:SetSelectedState("hero")

				arg_98_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_98_1.callingController_:SetSelectedState("calling")

				arg_98_1.keyicon_.color = Color.New(1, 1, 1)
				arg_98_1.icon_.color = Color.New(1, 1, 1)

				local var_101_1 = arg_98_1:GetWordFromCfg(303032024)
				local var_101_2 = arg_98_1:FormatText(var_101_1.content)

				arg_98_1.text_.text = var_101_2

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_4 = 7 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 7)

				if (7 <= 0 and var_101_0 or var_101_0 * (utf8.len(var_101_2) / 7)) > 0 and var_101_0 < var_101_4 then
					arg_98_1.talkMaxDuration = var_101_4

					if var_101_4 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_4 + 0
					end
				end

				arg_98_1.text_.text = var_101_2
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032024", "story_v_out_303032.awb") ~= 0 then
					local var_101_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032024", "story_v_out_303032.awb") / 1000

					if var_101_5 + 0 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + 0
					end

					if var_101_1.prefab_name ~= "" and arg_98_1.actors_[var_101_1.prefab_name] ~= nil then
						local var_101_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_1.prefab_name].transform, "story_v_out_303032", "303032024", "story_v_out_303032.awb")

						arg_98_1:RecordAudio("303032024", var_101_6)
						arg_98_1:RecordAudio("303032024", var_101_6)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_303032", "303032024", "story_v_out_303032.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_303032", "303032024", "story_v_out_303032.awb")
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
	Play303032025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 303032025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play303032026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if arg_102_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_105_0 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_102_1.stage_.transform)

				var_105_0.name = "1080ui_story"
				var_105_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_102_1.actors_["1080ui_story"] = var_105_0

				local var_105_1 = var_105_0:GetComponentInChildren(typeof(CharacterEffect))

				var_105_1.enabled = true

				local var_105_2 = GameObjectTools.GetOrAddComponent(var_105_0, typeof(DynamicBoneHelper))

				if var_105_2 then
					var_105_2:EnableDynamicBone(false)
				end

				arg_102_1:ShowWeapon(var_105_1.transform, false)

				arg_102_1.var_["1080ui_story" .. "Animator"] = var_105_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_102_1.var_["1080ui_story" .. "Animator"].applyRootMotion = true
				arg_102_1.var_["1080ui_story" .. "LipSync"] = var_105_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_105_3 = arg_102_1.actors_["1080ui_story"]

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(var_105_3) and arg_102_1.var_.characterEffect1080ui_story == nil then
				arg_102_1.var_.characterEffect1080ui_story = var_105_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_4 = 0.200000002980232

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 and not isNil(var_105_3) then
				if arg_102_1.var_.characterEffect1080ui_story and not isNil(var_105_3) then
					arg_102_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_102_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_4)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 and not isNil(var_105_3) and arg_102_1.var_.characterEffect1080ui_story then
				arg_102_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_102_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_105_5 = 0
			local var_105_6 = 0.475

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, true)
				arg_102_1.iconController_:SetSelectedState("hero")

				arg_102_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_102_1.callingController_:SetSelectedState("normal")

				arg_102_1.keyicon_.color = Color.New(1, 1, 1)
				arg_102_1.icon_.color = Color.New(1, 1, 1)

				local var_105_7 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(303032025).content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 19 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 19)

				if (19 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 19)) > 0 and var_105_6 < var_105_9 then
					arg_102_1.talkMaxDuration = var_105_9

					if var_105_9 + var_105_5 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_9 + var_105_5
					end
				end

				arg_102_1.text_.text = var_105_7
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)
				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_6, arg_102_1.talkMaxDuration)

			if var_105_5 <= arg_102_1.time_ and arg_102_1.time_ < var_105_5 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_5) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_5 + var_105_10 and arg_102_1.time_ < var_105_5 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play303032026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 303032026
		arg_106_1.duration_ = 4.57

		local var_106_0 = {
			zh = 3.533,
			ja = 4.566
		}
		local var_106_1 = manager.audio:GetLocalizationFlag()

		if var_106_0[var_106_1] ~= nil then
			arg_106_1.duration_ = var_106_0[var_106_1]
		end

		SetActive(arg_106_1.tipsGo_, false)

		function arg_106_1.onSingleLineFinish_()
			arg_106_1.onSingleLineUpdate_ = nil
			arg_106_1.onSingleLineFinish_ = nil
			arg_106_1.state_ = "waiting"
		end

		function arg_106_1.playNext_(arg_108_0)
			if arg_108_0 == 1 then
				arg_106_0:Play303032027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			local var_109_0 = 0.375

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, true)
				arg_106_1.iconController_:SetSelectedState("hero")

				arg_106_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_106_1.callingController_:SetSelectedState("calling")

				arg_106_1.keyicon_.color = Color.New(1, 1, 1)
				arg_106_1.icon_.color = Color.New(1, 1, 1)

				local var_109_1 = arg_106_1:GetWordFromCfg(303032026)
				local var_109_2 = arg_106_1:FormatText(var_109_1.content)

				arg_106_1.text_.text = var_109_2

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_4 = 15 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 15)

				if (15 <= 0 and var_109_0 or var_109_0 * (utf8.len(var_109_2) / 15)) > 0 and var_109_0 < var_109_4 then
					arg_106_1.talkMaxDuration = var_109_4

					if var_109_4 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_4 + 0
					end
				end

				arg_106_1.text_.text = var_109_2
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032026", "story_v_out_303032.awb") ~= 0 then
					local var_109_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032026", "story_v_out_303032.awb") / 1000

					if var_109_5 + 0 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_5 + 0
					end

					if var_109_1.prefab_name ~= "" and arg_106_1.actors_[var_109_1.prefab_name] ~= nil then
						local var_109_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_1.prefab_name].transform, "story_v_out_303032", "303032026", "story_v_out_303032.awb")

						arg_106_1:RecordAudio("303032026", var_109_6)
						arg_106_1:RecordAudio("303032026", var_109_6)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_303032", "303032026", "story_v_out_303032.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_303032", "303032026", "story_v_out_303032.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_7 = math.max(var_109_0, arg_106_1.talkMaxDuration)

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_7 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - 0) / var_109_7

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= 0 + var_109_7 and arg_106_1.time_ < 0 + var_109_7 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play303032027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 303032027
		arg_110_1.duration_ = 4.93

		local var_110_0 = {
			zh = 4.066,
			ja = 4.933
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
				arg_110_0:Play303032028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			local var_113_0 = 0.4

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_110_1.callingController_:SetSelectedState("calling")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_1 = arg_110_1:GetWordFromCfg(303032027)
				local var_113_2 = arg_110_1:FormatText(var_113_1.content)

				arg_110_1.text_.text = var_113_2

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_4 = 16 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 16)

				if (16 <= 0 and var_113_0 or var_113_0 * (utf8.len(var_113_2) / 16)) > 0 and var_113_0 < var_113_4 then
					arg_110_1.talkMaxDuration = var_113_4

					if var_113_4 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_4 + 0
					end
				end

				arg_110_1.text_.text = var_113_2
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032027", "story_v_out_303032.awb") ~= 0 then
					local var_113_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032027", "story_v_out_303032.awb") / 1000

					if var_113_5 + 0 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_5 + 0
					end

					if var_113_1.prefab_name ~= "" and arg_110_1.actors_[var_113_1.prefab_name] ~= nil then
						local var_113_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_1.prefab_name].transform, "story_v_out_303032", "303032027", "story_v_out_303032.awb")

						arg_110_1:RecordAudio("303032027", var_113_6)
						arg_110_1:RecordAudio("303032027", var_113_6)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_303032", "303032027", "story_v_out_303032.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_303032", "303032027", "story_v_out_303032.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_7 = math.max(var_113_0, arg_110_1.talkMaxDuration)

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - 0) / var_113_7

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {}

		arg_110_1:InitPlayNodeList()
	end,
	Play303032028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 303032028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play303032029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["1080ui_story"]) and arg_114_1.var_.characterEffect1080ui_story == nil then
				arg_114_1.var_.characterEffect1080ui_story = arg_114_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.200000002980232

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["1080ui_story"]) then
				if arg_114_1.var_.characterEffect1080ui_story and not isNil(arg_114_1.actors_["1080ui_story"]) then
					arg_114_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_114_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["1080ui_story"]) and arg_114_1.var_.characterEffect1080ui_story then
				arg_114_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_114_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_117_1 = 0
			local var_117_2 = 0.125

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

				local var_117_3 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(303032028).content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 5 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 5)

				if (5 <= 0 and var_117_2 or var_117_2 * (utf8.len(var_117_3) / 5)) > 0 and var_117_2 < var_117_5 then
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
	Play303032029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 303032029
		arg_118_1.duration_ = 10.6

		local var_118_0 = {
			zh = 9.73300000298023,
			ja = 10.6000000029802
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
				arg_118_0:Play303032030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.bgs_.I28f == nil then
				local var_121_0 = Object.Instantiate(arg_118_1.paintGo_)

				var_121_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I28f")
				var_121_0.name = "I28f"
				var_121_0.transform.parent = arg_118_1.stage_.transform
				var_121_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.bgs_.I28f = var_121_0
			end

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= 2 + arg_121_0 then
				local var_121_1 = arg_118_1.bgs_.I28f

				arg_118_1.bgs_.I28f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_121_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_121_2 = var_121_1:GetComponent("SpriteRenderer")

				if var_121_2 and var_121_2.sprite then
					local var_121_3 = 2 * (var_121_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_121_1.transform.localScale = Vector3.New(var_121_3 / var_121_2.sprite.bounds.size.y < var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x and var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x or var_121_3 / var_121_2.sprite.bounds.size.y, var_121_3 / var_121_2.sprite.bounds.size.y < var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x and var_121_3 * manager.ui.mainCameraCom_.aspect / var_121_2.sprite.bounds.size.x or var_121_3 / var_121_2.sprite.bounds.size.y, 0)
				end

				for iter_121_0, iter_121_1 in pairs(arg_118_1.bgs_) do
					if iter_121_0 ~= "I28f" then
						iter_121_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_121_4 = 4.00000000298023

			if 4.00000000298023 < arg_118_1.time_ and arg_118_1.time_ <= var_121_4 + arg_121_0 then
				arg_118_1.allBtn_.enabled = false
			end

			if arg_118_1.time_ >= var_121_4 + 0.3 and arg_118_1.time_ < var_121_4 + 0.3 + arg_121_0 then
				arg_118_1.allBtn_.enabled = true
			end

			local var_121_5 = 0

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_5 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_6 = 2

			if var_121_5 <= arg_118_1.time_ and arg_118_1.time_ < var_121_5 + var_121_6 then
				local var_121_7 = Color.New(0, 0, 0)

				var_121_7.a = Mathf.Lerp(0, 1, (arg_118_1.time_ - var_121_5) / var_121_6)
				arg_118_1.mask_.color = var_121_7
			end

			if arg_118_1.time_ >= var_121_5 + var_121_6 and arg_118_1.time_ < var_121_5 + var_121_6 + arg_121_0 then
				local var_121_8 = Color.New(0, 0, 0)

				var_121_8.a = 1
				arg_118_1.mask_.color = var_121_8
			end

			local var_121_9 = 2

			if 2 < arg_118_1.time_ and arg_118_1.time_ <= var_121_9 + arg_121_0 then
				arg_118_1.mask_.enabled = true
				arg_118_1.mask_.raycastTarget = true

				arg_118_1:SetGaussion(false)
			end

			local var_121_10 = 2

			if var_121_9 <= arg_118_1.time_ and arg_118_1.time_ < var_121_9 + var_121_10 then
				local var_121_11 = Color.New(0, 0, 0)

				var_121_11.a = Mathf.Lerp(1, 0, (arg_118_1.time_ - var_121_9) / var_121_10)
				arg_118_1.mask_.color = var_121_11
			end

			if arg_118_1.time_ >= var_121_9 + var_121_10 and arg_118_1.time_ < var_121_9 + var_121_10 + arg_121_0 then
				local var_121_12 = Color.New(0, 0, 0)

				arg_118_1.mask_.enabled = false
				var_121_12.a = 0
				arg_118_1.mask_.color = var_121_12
			end

			local var_121_13 = arg_118_1.actors_["1080ui_story"].transform

			if 3.8 < arg_118_1.time_ and arg_118_1.time_ <= 3.8 + arg_121_0 then
				arg_118_1.var_.moveOldPos1080ui_story = var_121_13.localPosition
			end

			local var_121_14 = 0.001

			if 3.8 <= arg_118_1.time_ and arg_118_1.time_ < 3.8 + var_121_14 then
				var_121_13.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 3.8) / var_121_14)
				var_121_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_13.position).x, (manager.ui.mainCamera.transform.position - var_121_13.position).y, (manager.ui.mainCamera.transform.position - var_121_13.position).z)
				var_121_13.localEulerAngles.z = 0
				var_121_13.localEulerAngles.x = 0
				var_121_13.localEulerAngles = var_121_13.localEulerAngles
			end

			if arg_118_1.time_ >= 3.8 + var_121_14 and arg_118_1.time_ < 3.8 + var_121_14 + arg_121_0 then
				var_121_13.localPosition = Vector3.New(0, 100, 0)
				var_121_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_13.position).x, (manager.ui.mainCamera.transform.position - var_121_13.position).y, (manager.ui.mainCamera.transform.position - var_121_13.position).z)
				var_121_13.localEulerAngles.z = 0
				var_121_13.localEulerAngles.x = 0
				var_121_13.localEulerAngles = var_121_13.localEulerAngles
			end

			local var_121_15 = "1027ui_story"

			if arg_118_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_121_16 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_118_1.stage_.transform)

				var_121_16.name = var_121_15
				var_121_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_[var_121_15] = var_121_16

				local var_121_17 = var_121_16:GetComponentInChildren(typeof(CharacterEffect))

				var_121_17.enabled = true

				local var_121_18 = GameObjectTools.GetOrAddComponent(var_121_16, typeof(DynamicBoneHelper))

				if var_121_18 then
					var_121_18:EnableDynamicBone(false)
				end

				arg_118_1:ShowWeapon(var_121_17.transform, false)

				arg_118_1.var_[var_121_15 .. "Animator"] = var_121_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_118_1.var_[var_121_15 .. "Animator"].applyRootMotion = true
				arg_118_1.var_[var_121_15 .. "LipSync"] = var_121_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_121_19 = arg_118_1.actors_["1027ui_story"].transform

			if 3.8 < arg_118_1.time_ and arg_118_1.time_ <= 3.8 + arg_121_0 then
				arg_118_1.var_.moveOldPos1027ui_story = var_121_19.localPosition
			end

			local var_121_20 = 0.001

			if 3.8 <= arg_118_1.time_ and arg_118_1.time_ < 3.8 + var_121_20 then
				var_121_19.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_118_1.time_ - 3.8) / var_121_20)
				var_121_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_19.position).x, (manager.ui.mainCamera.transform.position - var_121_19.position).y, (manager.ui.mainCamera.transform.position - var_121_19.position).z)
				var_121_19.localEulerAngles.z = 0
				var_121_19.localEulerAngles.x = 0
				var_121_19.localEulerAngles = var_121_19.localEulerAngles
			end

			if arg_118_1.time_ >= 3.8 + var_121_20 and arg_118_1.time_ < 3.8 + var_121_20 + arg_121_0 then
				var_121_19.localPosition = Vector3.New(0, -0.81, -5.8)
				var_121_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_19.position).x, (manager.ui.mainCamera.transform.position - var_121_19.position).y, (manager.ui.mainCamera.transform.position - var_121_19.position).z)
				var_121_19.localEulerAngles.z = 0
				var_121_19.localEulerAngles.x = 0
				var_121_19.localEulerAngles = var_121_19.localEulerAngles
			end

			local var_121_21 = arg_118_1.actors_["1027ui_story"]

			if 3.8 < arg_118_1.time_ and arg_118_1.time_ <= 3.8 + arg_121_0 and not isNil(var_121_21) and arg_118_1.var_.characterEffect1027ui_story == nil then
				arg_118_1.var_.characterEffect1027ui_story = var_121_21:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_22 = 0.200000002980232

			if 3.8 <= arg_118_1.time_ and arg_118_1.time_ < 3.8 + var_121_22 and not isNil(var_121_21) then
				if arg_118_1.var_.characterEffect1027ui_story and not isNil(var_121_21) then
					arg_118_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 3.8 + var_121_22 and arg_118_1.time_ < 3.8 + var_121_22 + arg_121_0 and not isNil(var_121_21) and arg_118_1.var_.characterEffect1027ui_story then
				arg_118_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 3.8 < arg_118_1.time_ and arg_118_1.time_ <= 3.8 + arg_121_0 then
				arg_118_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 3.8 < arg_118_1.time_ and arg_118_1.time_ <= 3.8 + arg_121_0 then
				arg_118_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 1.2 < arg_118_1.time_ and arg_118_1.time_ <= 1.2 + arg_121_0 then
				arg_118_1:AudioAction("play", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if 0.2 < arg_118_1.time_ and arg_118_1.time_ <= 0.2 + arg_121_0 then
				arg_118_1:AudioAction("stop", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if arg_118_1.frameCnt_ <= 1 then
				arg_118_1.dialog_:SetActive(false)
			end

			local var_121_26 = 4.00000000298023
			local var_121_27 = 0.625

			if 4.00000000298023 < arg_118_1.time_ and arg_118_1.time_ <= var_121_26 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0

				arg_118_1.dialog_:SetActive(true)

				arg_118_1.dialogCg_.alpha = 0

				local var_121_28 = LeanTween.value(arg_118_1.dialog_, 0, 1, 0.3)

				var_121_28:setOnUpdate(LuaHelper.FloatAction(function(arg_122_0)
					arg_118_1.dialogCg_.alpha = arg_122_0
				end))
				var_121_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_118_1.dialog_)
					var_121_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_118_1.duration_ = arg_118_1.duration_ + 0.3

				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_29 = arg_118_1:GetWordFromCfg(303032029)
				local var_121_30 = arg_118_1:FormatText(var_121_29.content)

				arg_118_1.text_.text = var_121_30

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_32 = 25 <= 0 and var_121_27 or var_121_27 * (utf8.len(var_121_30) / 25)

				if (25 <= 0 and var_121_27 or var_121_27 * (utf8.len(var_121_30) / 25)) > 0 and var_121_27 < var_121_32 then
					arg_118_1.talkMaxDuration = var_121_32
					var_121_26 = var_121_26 + 0.3

					if var_121_32 + var_121_26 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_32 + var_121_26
					end
				end

				arg_118_1.text_.text = var_121_30
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032029", "story_v_out_303032.awb") ~= 0 then
					local var_121_33 = manager.audio:GetVoiceLength("story_v_out_303032", "303032029", "story_v_out_303032.awb") / 1000

					if var_121_33 + var_121_26 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_33 + var_121_26
					end

					if var_121_29.prefab_name ~= "" and arg_118_1.actors_[var_121_29.prefab_name] ~= nil then
						local var_121_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_29.prefab_name].transform, "story_v_out_303032", "303032029", "story_v_out_303032.awb")

						arg_118_1:RecordAudio("303032029", var_121_34)
						arg_118_1:RecordAudio("303032029", var_121_34)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_303032", "303032029", "story_v_out_303032.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_303032", "303032029", "story_v_out_303032.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_35 = var_121_26 + 0.3
			local var_121_36 = math.max(var_121_27, arg_118_1.talkMaxDuration)

			if var_121_26 + 0.3 <= arg_118_1.time_ and arg_118_1.time_ < var_121_35 + var_121_36 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_35) / var_121_36

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_35 + var_121_36 and arg_118_1.time_ < var_121_35 + var_121_36 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play303032030 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 303032030
		arg_124_1.duration_ = 6.43

		local var_124_0 = {
			zh = 6.433,
			ja = 4
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
				arg_124_0:Play303032031(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_127_0 = 0
			local var_127_1 = 0.625

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_2 = arg_124_1:GetWordFromCfg(303032030)
				local var_127_3 = arg_124_1:FormatText(var_127_2.content)

				arg_124_1.text_.text = var_127_3

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_5 = 25 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 25)

				if (25 <= 0 and var_127_1 or var_127_1 * (utf8.len(var_127_3) / 25)) > 0 and var_127_1 < var_127_5 then
					arg_124_1.talkMaxDuration = var_127_5

					if var_127_5 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_5 + var_127_0
					end
				end

				arg_124_1.text_.text = var_127_3
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032030", "story_v_out_303032.awb") ~= 0 then
					local var_127_6 = manager.audio:GetVoiceLength("story_v_out_303032", "303032030", "story_v_out_303032.awb") / 1000

					if var_127_6 + var_127_0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_6 + var_127_0
					end

					if var_127_2.prefab_name ~= "" and arg_124_1.actors_[var_127_2.prefab_name] ~= nil then
						local var_127_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_2.prefab_name].transform, "story_v_out_303032", "303032030", "story_v_out_303032.awb")

						arg_124_1:RecordAudio("303032030", var_127_7)
						arg_124_1:RecordAudio("303032030", var_127_7)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_303032", "303032030", "story_v_out_303032.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_303032", "303032030", "story_v_out_303032.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_1, arg_124_1.talkMaxDuration)

			if var_127_0 <= arg_124_1.time_ and arg_124_1.time_ < var_127_0 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_0) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_0 + var_127_8 and arg_124_1.time_ < var_127_0 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play303032031 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 303032031
		arg_128_1.duration_ = 5

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play303032032(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1027ui_story = arg_128_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_131_0 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 then
				arg_128_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_128_1.time_ - 0) / var_131_0)
				arg_128_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1027ui_story"].transform.position).z)
				arg_128_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1027ui_story"].transform.localEulerAngles = arg_128_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 then
				arg_128_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_128_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_128_1.actors_["1027ui_story"].transform.position).z)
				arg_128_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_128_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_128_1.actors_["1027ui_story"].transform.localEulerAngles = arg_128_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_131_1 = arg_128_1.actors_["1027ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1027ui_story == nil then
				arg_128_1.var_.characterEffect1027ui_story = var_131_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_2 = 0.200000002980232

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_2 and not isNil(var_131_1) then
				if arg_128_1.var_.characterEffect1027ui_story and not isNil(var_131_1) then
					arg_128_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_128_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_128_1.time_ - 0) / var_131_2)
				end
			end

			if arg_128_1.time_ >= 0 + var_131_2 and arg_128_1.time_ < 0 + var_131_2 + arg_131_0 and not isNil(var_131_1) and arg_128_1.var_.characterEffect1027ui_story then
				arg_128_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_128_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_131_3 = 0
			local var_131_4 = 1.55

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_3 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, false)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_5 = arg_128_1:FormatText(arg_128_1:GetWordFromCfg(303032031).content)

				arg_128_1.text_.text = var_131_5

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_7 = 62 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 62)

				if (62 <= 0 and var_131_4 or var_131_4 * (utf8.len(var_131_5) / 62)) > 0 and var_131_4 < var_131_7 then
					arg_128_1.talkMaxDuration = var_131_7

					if var_131_7 + var_131_3 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_7 + var_131_3
					end
				end

				arg_128_1.text_.text = var_131_5
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)
				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_8 = math.max(var_131_4, arg_128_1.talkMaxDuration)

			if var_131_3 <= arg_128_1.time_ and arg_128_1.time_ < var_131_3 + var_131_8 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_3) / var_131_8

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_3 + var_131_8 and arg_128_1.time_ < var_131_3 + var_131_8 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play303032032 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 303032032
		arg_132_1.duration_ = 5

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play303032033(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			local var_135_0 = 0.825

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

				local var_135_1 = arg_132_1:FormatText(arg_132_1:GetWordFromCfg(303032032).content)

				arg_132_1.text_.text = var_135_1

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_3 = 33 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 33)

				if (33 <= 0 and var_135_0 or var_135_0 * (utf8.len(var_135_1) / 33)) > 0 and var_135_0 < var_135_3 then
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
	Play303032033 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 303032033
		arg_136_1.duration_ = 5

		local var_136_0 = {
			zh = 4.1,
			ja = 5
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
				arg_136_0:Play303032034(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1.var_.moveOldPos1080ui_story = arg_136_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_139_0 = 0.001

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 then
				arg_136_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_136_1.var_.moveOldPos1080ui_story, Vector3.New(0, -1.01, -6.05), (arg_136_1.time_ - 0) / var_139_0)
				arg_136_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1080ui_story"].transform.position).z)
				arg_136_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1080ui_story"].transform.localEulerAngles = arg_136_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 then
				arg_136_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, -1.01, -6.05)
				arg_136_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_136_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_136_1.actors_["1080ui_story"].transform.position).z)
				arg_136_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_136_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_136_1.actors_["1080ui_story"].transform.localEulerAngles = arg_136_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_139_1 = arg_136_1.actors_["1080ui_story"]

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1080ui_story == nil then
				arg_136_1.var_.characterEffect1080ui_story = var_139_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_2 = 0.200000002980232

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_2 and not isNil(var_139_1) then
				if arg_136_1.var_.characterEffect1080ui_story and not isNil(var_139_1) then
					arg_136_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_2 and arg_136_1.time_ < 0 + var_139_2 + arg_139_0 and not isNil(var_139_1) and arg_136_1.var_.characterEffect1080ui_story then
				arg_136_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action6_1")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_139_4 = 0
			local var_139_5 = 0.375

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_4 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_6 = arg_136_1:GetWordFromCfg(303032033)
				local var_139_7 = arg_136_1:FormatText(var_139_6.content)

				arg_136_1.text_.text = var_139_7

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_9 = 15 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 15)

				if (15 <= 0 and var_139_5 or var_139_5 * (utf8.len(var_139_7) / 15)) > 0 and var_139_5 < var_139_9 then
					arg_136_1.talkMaxDuration = var_139_9

					if var_139_9 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_9 + var_139_4
					end
				end

				arg_136_1.text_.text = var_139_7
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032033", "story_v_out_303032.awb") ~= 0 then
					local var_139_10 = manager.audio:GetVoiceLength("story_v_out_303032", "303032033", "story_v_out_303032.awb") / 1000

					if var_139_10 + var_139_4 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_10 + var_139_4
					end

					if var_139_6.prefab_name ~= "" and arg_136_1.actors_[var_139_6.prefab_name] ~= nil then
						local var_139_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_6.prefab_name].transform, "story_v_out_303032", "303032033", "story_v_out_303032.awb")

						arg_136_1:RecordAudio("303032033", var_139_11)
						arg_136_1:RecordAudio("303032033", var_139_11)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_303032", "303032033", "story_v_out_303032.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_303032", "303032033", "story_v_out_303032.awb")
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

		arg_136_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_136_1:InitPlayNodeList()
	end,
	Play303032034 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 303032034
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play303032035(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1080ui_story = arg_140_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1080ui_story"].transform.position).z)
				arg_140_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1080ui_story"].transform.localEulerAngles = arg_140_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_140_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1080ui_story"].transform.position).z)
				arg_140_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1080ui_story"].transform.localEulerAngles = arg_140_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_143_1 = arg_140_1.actors_["1080ui_story"]

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1080ui_story == nil then
				arg_140_1.var_.characterEffect1080ui_story = var_143_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_2 = 0.200000002980232

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 and not isNil(var_143_1) then
				if arg_140_1.var_.characterEffect1080ui_story and not isNil(var_143_1) then
					arg_140_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_2)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 and not isNil(var_143_1) and arg_140_1.var_.characterEffect1080ui_story then
				arg_140_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_143_3 = 0
			local var_143_4 = 1.3

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_3 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, false)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_5 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(303032034).content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 52 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_5) / 52)

				if (52 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_5) / 52)) > 0 and var_143_4 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_3 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_3
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_4, arg_140_1.talkMaxDuration)

			if var_143_3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_3 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_3) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_3 + var_143_8 and arg_140_1.time_ < var_143_3 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play303032035 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 303032035
		arg_144_1.duration_ = 4.1

		local var_144_0 = {
			zh = 3.7,
			ja = 4.1
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
				arg_144_0:Play303032036(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.var_.moveOldPos1027ui_story = arg_144_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_147_0 = 0.001

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 then
				arg_144_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_144_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_144_1.time_ - 0) / var_147_0)
				arg_144_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1027ui_story"].transform.position).z)
				arg_144_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1027ui_story"].transform.localEulerAngles = arg_144_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 then
				arg_144_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_144_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_144_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_144_1.actors_["1027ui_story"].transform.position).z)
				arg_144_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_144_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_144_1.actors_["1027ui_story"].transform.localEulerAngles = arg_144_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_147_1 = arg_144_1.actors_["1027ui_story"]

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1027ui_story == nil then
				arg_144_1.var_.characterEffect1027ui_story = var_147_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_2 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_2 and not isNil(var_147_1) then
				if arg_144_1.var_.characterEffect1027ui_story and not isNil(var_147_1) then
					arg_144_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_144_1.time_ >= 0 + var_147_2 and arg_144_1.time_ < 0 + var_147_2 + arg_147_0 and not isNil(var_147_1) and arg_144_1.var_.characterEffect1027ui_story then
				arg_144_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_1")
			end

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_147_4 = 0
			local var_147_5 = 0.4

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_4 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, false)
				arg_144_1.callingController_:SetSelectedState("normal")

				local var_147_6 = arg_144_1:GetWordFromCfg(303032035)
				local var_147_7 = arg_144_1:FormatText(var_147_6.content)

				arg_144_1.text_.text = var_147_7

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_9 = 16 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 16)

				if (16 <= 0 and var_147_5 or var_147_5 * (utf8.len(var_147_7) / 16)) > 0 and var_147_5 < var_147_9 then
					arg_144_1.talkMaxDuration = var_147_9

					if var_147_9 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_9 + var_147_4
					end
				end

				arg_144_1.text_.text = var_147_7
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032035", "story_v_out_303032.awb") ~= 0 then
					local var_147_10 = manager.audio:GetVoiceLength("story_v_out_303032", "303032035", "story_v_out_303032.awb") / 1000

					if var_147_10 + var_147_4 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_10 + var_147_4
					end

					if var_147_6.prefab_name ~= "" and arg_144_1.actors_[var_147_6.prefab_name] ~= nil then
						local var_147_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_144_1.actors_[var_147_6.prefab_name].transform, "story_v_out_303032", "303032035", "story_v_out_303032.awb")

						arg_144_1:RecordAudio("303032035", var_147_11)
						arg_144_1:RecordAudio("303032035", var_147_11)
					else
						arg_144_1:AudioAction("play", "voice", "story_v_out_303032", "303032035", "story_v_out_303032.awb")
					end

					arg_144_1:RecordHistoryTalkVoice("story_v_out_303032", "303032035", "story_v_out_303032.awb")
				end

				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_12 = math.max(var_147_5, arg_144_1.talkMaxDuration)

			if var_147_4 <= arg_144_1.time_ and arg_144_1.time_ < var_147_4 + var_147_12 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_4) / var_147_12

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_4 + var_147_12 and arg_144_1.time_ < var_147_4 + var_147_12 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_144_1:InitPlayNodeList()
	end,
	Play303032036 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 303032036
		arg_148_1.duration_ = 5.07

		local var_148_0 = {
			zh = 4.8,
			ja = 5.066
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
				arg_148_0:Play303032037(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action2_2")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_0 = 0
			local var_151_1 = 0.575

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_0 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_2 = arg_148_1:GetWordFromCfg(303032036)
				local var_151_3 = arg_148_1:FormatText(var_151_2.content)

				arg_148_1.text_.text = var_151_3

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_5 = 23 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 23)

				if (23 <= 0 and var_151_1 or var_151_1 * (utf8.len(var_151_3) / 23)) > 0 and var_151_1 < var_151_5 then
					arg_148_1.talkMaxDuration = var_151_5

					if var_151_5 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_5 + var_151_0
					end
				end

				arg_148_1.text_.text = var_151_3
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032036", "story_v_out_303032.awb") ~= 0 then
					local var_151_6 = manager.audio:GetVoiceLength("story_v_out_303032", "303032036", "story_v_out_303032.awb") / 1000

					if var_151_6 + var_151_0 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_6 + var_151_0
					end

					if var_151_2.prefab_name ~= "" and arg_148_1.actors_[var_151_2.prefab_name] ~= nil then
						local var_151_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_148_1.actors_[var_151_2.prefab_name].transform, "story_v_out_303032", "303032036", "story_v_out_303032.awb")

						arg_148_1:RecordAudio("303032036", var_151_7)
						arg_148_1:RecordAudio("303032036", var_151_7)
					else
						arg_148_1:AudioAction("play", "voice", "story_v_out_303032", "303032036", "story_v_out_303032.awb")
					end

					arg_148_1:RecordHistoryTalkVoice("story_v_out_303032", "303032036", "story_v_out_303032.awb")
				end

				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_8 = math.max(var_151_1, arg_148_1.talkMaxDuration)

			if var_151_0 <= arg_148_1.time_ and arg_148_1.time_ < var_151_0 + var_151_8 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_0) / var_151_8

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_0 + var_151_8 and arg_148_1.time_ < var_151_0 + var_151_8 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {}

		arg_148_1:InitPlayNodeList()
	end,
	Play303032037 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 303032037
		arg_152_1.duration_ = 2.93

		local var_152_0 = {
			zh = 2.133,
			ja = 2.933
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
				arg_152_0:Play303032038(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1080ui_story = arg_152_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_155_0 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 then
				arg_152_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_152_1.time_ - 0) / var_155_0)
				arg_152_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1080ui_story"].transform.position).z)
				arg_152_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1080ui_story"].transform.localEulerAngles = arg_152_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 then
				arg_152_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0.7, -1.01, -6.05)
				arg_152_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_152_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_152_1.actors_["1080ui_story"].transform.position).z)
				arg_152_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_152_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_152_1.actors_["1080ui_story"].transform.localEulerAngles = arg_152_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_155_1 = arg_152_1.actors_["1027ui_story"].transform

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1.var_.moveOldPos1027ui_story = var_155_1.localPosition
			end

			local var_155_2 = 0.001

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_2 then
				var_155_1.localPosition = Vector3.Lerp(arg_152_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_152_1.time_ - 0) / var_155_2)
				var_155_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_1.position).x, (manager.ui.mainCamera.transform.position - var_155_1.position).y, (manager.ui.mainCamera.transform.position - var_155_1.position).z)
				var_155_1.localEulerAngles.z = 0
				var_155_1.localEulerAngles.x = 0
				var_155_1.localEulerAngles = var_155_1.localEulerAngles
			end

			if arg_152_1.time_ >= 0 + var_155_2 and arg_152_1.time_ < 0 + var_155_2 + arg_155_0 then
				var_155_1.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_155_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_155_1.position).x, (manager.ui.mainCamera.transform.position - var_155_1.position).y, (manager.ui.mainCamera.transform.position - var_155_1.position).z)
				var_155_1.localEulerAngles.z = 0
				var_155_1.localEulerAngles.x = 0
				var_155_1.localEulerAngles = var_155_1.localEulerAngles
			end

			local var_155_3 = arg_152_1.actors_["1080ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect1080ui_story == nil then
				arg_152_1.var_.characterEffect1080ui_story = var_155_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_4 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_4 and not isNil(var_155_3) then
				if arg_152_1.var_.characterEffect1080ui_story and not isNil(var_155_3) then
					arg_152_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_152_1.time_ >= 0 + var_155_4 and arg_152_1.time_ < 0 + var_155_4 + arg_155_0 and not isNil(var_155_3) and arg_152_1.var_.characterEffect1080ui_story then
				arg_152_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_155_6 = arg_152_1.actors_["1027ui_story"]

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect1027ui_story == nil then
				arg_152_1.var_.characterEffect1027ui_story = var_155_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_7 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_7 and not isNil(var_155_6) then
				if arg_152_1.var_.characterEffect1027ui_story and not isNil(var_155_6) then
					arg_152_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_7)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_7 and arg_152_1.time_ < 0 + var_155_7 + arg_155_0 and not isNil(var_155_6) and arg_152_1.var_.characterEffect1027ui_story then
				arg_152_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_1")
			end

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 then
				arg_152_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_155_8 = 0
			local var_155_9 = 0.1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_8 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, false)
				arg_152_1.callingController_:SetSelectedState("normal")

				local var_155_10 = arg_152_1:GetWordFromCfg(303032037)
				local var_155_11 = arg_152_1:FormatText(var_155_10.content)

				arg_152_1.text_.text = var_155_11

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_13 = 4 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 4)

				if (4 <= 0 and var_155_9 or var_155_9 * (utf8.len(var_155_11) / 4)) > 0 and var_155_9 < var_155_13 then
					arg_152_1.talkMaxDuration = var_155_13

					if var_155_13 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_13 + var_155_8
					end
				end

				arg_152_1.text_.text = var_155_11
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032037", "story_v_out_303032.awb") ~= 0 then
					local var_155_14 = manager.audio:GetVoiceLength("story_v_out_303032", "303032037", "story_v_out_303032.awb") / 1000

					if var_155_14 + var_155_8 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_14 + var_155_8
					end

					if var_155_10.prefab_name ~= "" and arg_152_1.actors_[var_155_10.prefab_name] ~= nil then
						local var_155_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_152_1.actors_[var_155_10.prefab_name].transform, "story_v_out_303032", "303032037", "story_v_out_303032.awb")

						arg_152_1:RecordAudio("303032037", var_155_15)
						arg_152_1:RecordAudio("303032037", var_155_15)
					else
						arg_152_1:AudioAction("play", "voice", "story_v_out_303032", "303032037", "story_v_out_303032.awb")
					end

					arg_152_1:RecordHistoryTalkVoice("story_v_out_303032", "303032037", "story_v_out_303032.awb")
				end

				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_16 = math.max(var_155_9, arg_152_1.talkMaxDuration)

			if var_155_8 <= arg_152_1.time_ and arg_152_1.time_ < var_155_8 + var_155_16 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_8) / var_155_16

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_8 + var_155_16 and arg_152_1.time_ < var_155_8 + var_155_16 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_152_1:InitPlayNodeList()
	end,
	Play303032038 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 303032038
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play303032039(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(arg_156_1.actors_["1080ui_story"]) and arg_156_1.var_.characterEffect1080ui_story == nil then
				arg_156_1.var_.characterEffect1080ui_story = arg_156_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_0 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 and not isNil(arg_156_1.actors_["1080ui_story"]) then
				if arg_156_1.var_.characterEffect1080ui_story and not isNil(arg_156_1.actors_["1080ui_story"]) then
					arg_156_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_156_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_156_1.time_ - 0) / var_159_0)
				end
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 and not isNil(arg_156_1.actors_["1080ui_story"]) and arg_156_1.var_.characterEffect1080ui_story then
				arg_156_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_156_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action2_2")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva", "EmotionTimelineAnimator")
			end

			local var_159_1 = 0
			local var_159_2 = 0.95

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_1 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, false)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_3 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(303032038).content)

				arg_156_1.text_.text = var_159_3

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_5 = 38 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 38)

				if (38 <= 0 and var_159_2 or var_159_2 * (utf8.len(var_159_3) / 38)) > 0 and var_159_2 < var_159_5 then
					arg_156_1.talkMaxDuration = var_159_5

					if var_159_5 + var_159_1 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_5 + var_159_1
					end
				end

				arg_156_1.text_.text = var_159_3
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_6 = math.max(var_159_2, arg_156_1.talkMaxDuration)

			if var_159_1 <= arg_156_1.time_ and arg_156_1.time_ < var_159_1 + var_159_6 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_1) / var_159_6

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_1 + var_159_6 and arg_156_1.time_ < var_159_1 + var_159_6 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {}

		arg_156_1:InitPlayNodeList()
	end,
	Play303032039 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 303032039
		arg_160_1.duration_ = 5

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play303032040(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1080ui_story = arg_160_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_163_0 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_0 then
				arg_160_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_0)
				arg_160_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1080ui_story"].transform.position).z)
				arg_160_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1080ui_story"].transform.localEulerAngles = arg_160_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_0 and arg_160_1.time_ < 0 + var_163_0 + arg_163_0 then
				arg_160_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_160_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_160_1.actors_["1080ui_story"].transform.position).z)
				arg_160_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_160_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_160_1.actors_["1080ui_story"].transform.localEulerAngles = arg_160_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_163_1 = arg_160_1.actors_["1027ui_story"].transform

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= 0 + arg_163_0 then
				arg_160_1.var_.moveOldPos1027ui_story = var_163_1.localPosition
			end

			local var_163_2 = 0.001

			if 0 <= arg_160_1.time_ and arg_160_1.time_ < 0 + var_163_2 then
				var_163_1.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 0) / var_163_2)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			if arg_160_1.time_ >= 0 + var_163_2 and arg_160_1.time_ < 0 + var_163_2 + arg_163_0 then
				var_163_1.localPosition = Vector3.New(0, 100, 0)
				var_163_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_1.position).x, (manager.ui.mainCamera.transform.position - var_163_1.position).y, (manager.ui.mainCamera.transform.position - var_163_1.position).z)
				var_163_1.localEulerAngles.z = 0
				var_163_1.localEulerAngles.x = 0
				var_163_1.localEulerAngles = var_163_1.localEulerAngles
			end

			local var_163_3 = 0
			local var_163_4 = 1.425

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_3 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0
				arg_160_1.dialogCg_.alpha = 1

				arg_160_1.dialog_:SetActive(true)
				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_5 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(303032039).content)

				arg_160_1.text_.text = var_163_5

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_7 = 57 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_5) / 57)

				if (57 <= 0 and var_163_4 or var_163_4 * (utf8.len(var_163_5) / 57)) > 0 and var_163_4 < var_163_7 then
					arg_160_1.talkMaxDuration = var_163_7

					if var_163_7 + var_163_3 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_7 + var_163_3
					end
				end

				arg_160_1.text_.text = var_163_5
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_8 = math.max(var_163_4, arg_160_1.talkMaxDuration)

			if var_163_3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_3 + var_163_8 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_3) / var_163_8

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_3 + var_163_8 and arg_160_1.time_ < var_163_3 + var_163_8 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play303032040 = function(arg_164_0, arg_164_1)
		arg_164_1.time_ = 0
		arg_164_1.frameCnt_ = 0
		arg_164_1.state_ = "playing"
		arg_164_1.curTalkId_ = 303032040
		arg_164_1.duration_ = 12.2

		local var_164_0 = {
			zh = 7.1,
			ja = 12.2
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
				arg_164_0:Play303032041(arg_164_1)
			end
		end

		function arg_164_1.onSingleLineUpdate_(arg_167_0)
			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1.var_.moveOldPos1027ui_story = arg_164_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_167_0 = 0.001

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_0 then
				arg_164_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_164_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_164_1.time_ - 0) / var_167_0)
				arg_164_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1027ui_story"].transform.position).z)
				arg_164_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1027ui_story"].transform.localEulerAngles = arg_164_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_164_1.time_ >= 0 + var_167_0 and arg_164_1.time_ < 0 + var_167_0 + arg_167_0 then
				arg_164_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_164_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_164_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_164_1.actors_["1027ui_story"].transform.position).z)
				arg_164_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_164_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_164_1.actors_["1027ui_story"].transform.localEulerAngles = arg_164_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_167_1 = arg_164_1.actors_["1027ui_story"]

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect1027ui_story == nil then
				arg_164_1.var_.characterEffect1027ui_story = var_167_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_167_2 = 0.200000002980232

			if 0 <= arg_164_1.time_ and arg_164_1.time_ < 0 + var_167_2 and not isNil(var_167_1) then
				if arg_164_1.var_.characterEffect1027ui_story and not isNil(var_167_1) then
					arg_164_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_164_1.time_ >= 0 + var_167_2 and arg_164_1.time_ < 0 + var_167_2 + arg_167_0 and not isNil(var_167_1) and arg_164_1.var_.characterEffect1027ui_story then
				arg_164_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= 0 + arg_167_0 then
				arg_164_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_167_4 = 0
			local var_167_5 = 0.825

			if 0 < arg_164_1.time_ and arg_164_1.time_ <= var_167_4 + arg_167_0 then
				arg_164_1.talkMaxDuration = 0
				arg_164_1.dialogCg_.alpha = 1

				arg_164_1.dialog_:SetActive(true)
				SetActive(arg_164_1.leftNameGo_, true)

				arg_164_1.leftNameTxt_.text = arg_164_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_164_1.leftNameTxt_.transform)

				arg_164_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_164_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_164_1:RecordName(arg_164_1.leftNameTxt_.text)
				SetActive(arg_164_1.iconTrs_.gameObject, false)
				arg_164_1.callingController_:SetSelectedState("normal")

				local var_167_6 = arg_164_1:GetWordFromCfg(303032040)
				local var_167_7 = arg_164_1:FormatText(var_167_6.content)

				arg_164_1.text_.text = var_167_7

				LuaForUtil.ClearLinePrefixSymbol(arg_164_1.text_)

				local var_167_9 = 33 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 33)

				if (33 <= 0 and var_167_5 or var_167_5 * (utf8.len(var_167_7) / 33)) > 0 and var_167_5 < var_167_9 then
					arg_164_1.talkMaxDuration = var_167_9

					if var_167_9 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_9 + var_167_4
					end
				end

				arg_164_1.text_.text = var_167_7
				arg_164_1.typewritter.percent = 0

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032040", "story_v_out_303032.awb") ~= 0 then
					local var_167_10 = manager.audio:GetVoiceLength("story_v_out_303032", "303032040", "story_v_out_303032.awb") / 1000

					if var_167_10 + var_167_4 > arg_164_1.duration_ then
						arg_164_1.duration_ = var_167_10 + var_167_4
					end

					if var_167_6.prefab_name ~= "" and arg_164_1.actors_[var_167_6.prefab_name] ~= nil then
						local var_167_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_164_1.actors_[var_167_6.prefab_name].transform, "story_v_out_303032", "303032040", "story_v_out_303032.awb")

						arg_164_1:RecordAudio("303032040", var_167_11)
						arg_164_1:RecordAudio("303032040", var_167_11)
					else
						arg_164_1:AudioAction("play", "voice", "story_v_out_303032", "303032040", "story_v_out_303032.awb")
					end

					arg_164_1:RecordHistoryTalkVoice("story_v_out_303032", "303032040", "story_v_out_303032.awb")
				end

				arg_164_1:RecordContent(arg_164_1.text_.text)
			end

			local var_167_12 = math.max(var_167_5, arg_164_1.talkMaxDuration)

			if var_167_4 <= arg_164_1.time_ and arg_164_1.time_ < var_167_4 + var_167_12 then
				arg_164_1.typewritter.percent = (arg_164_1.time_ - var_167_4) / var_167_12

				arg_164_1.typewritter:SetDirty()
			end

			if arg_164_1.time_ >= var_167_4 + var_167_12 and arg_164_1.time_ < var_167_4 + var_167_12 + arg_167_0 then
				arg_164_1.typewritter.percent = 1

				arg_164_1.typewritter:SetDirty()
				arg_164_1:ShowNextGo(true)
			end
		end

		arg_164_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_164_1:InitPlayNodeList()
	end,
	Play303032041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 303032041
		arg_168_1.duration_ = 8

		local var_168_0 = {
			zh = 6.033,
			ja = 8
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
				arg_168_0:Play303032042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			local var_171_0 = 0.75

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0
				arg_168_1.dialogCg_.alpha = 1

				arg_168_1.dialog_:SetActive(true)
				SetActive(arg_168_1.leftNameGo_, true)

				arg_168_1.leftNameTxt_.text = arg_168_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_168_1.leftNameTxt_.transform)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1.leftNameTxt_.text)
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_1 = arg_168_1:GetWordFromCfg(303032041)
				local var_171_2 = arg_168_1:FormatText(var_171_1.content)

				arg_168_1.text_.text = var_171_2

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_4 = 30 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 30)

				if (30 <= 0 and var_171_0 or var_171_0 * (utf8.len(var_171_2) / 30)) > 0 and var_171_0 < var_171_4 then
					arg_168_1.talkMaxDuration = var_171_4

					if var_171_4 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_4 + 0
					end
				end

				arg_168_1.text_.text = var_171_2
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032041", "story_v_out_303032.awb") ~= 0 then
					local var_171_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032041", "story_v_out_303032.awb") / 1000

					if var_171_5 + 0 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_5 + 0
					end

					if var_171_1.prefab_name ~= "" and arg_168_1.actors_[var_171_1.prefab_name] ~= nil then
						local var_171_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_168_1.actors_[var_171_1.prefab_name].transform, "story_v_out_303032", "303032041", "story_v_out_303032.awb")

						arg_168_1:RecordAudio("303032041", var_171_6)
						arg_168_1:RecordAudio("303032041", var_171_6)
					else
						arg_168_1:AudioAction("play", "voice", "story_v_out_303032", "303032041", "story_v_out_303032.awb")
					end

					arg_168_1:RecordHistoryTalkVoice("story_v_out_303032", "303032041", "story_v_out_303032.awb")
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
	Play303032042 = function(arg_172_0, arg_172_1)
		arg_172_1.time_ = 0
		arg_172_1.frameCnt_ = 0
		arg_172_1.state_ = "playing"
		arg_172_1.curTalkId_ = 303032042
		arg_172_1.duration_ = 5

		SetActive(arg_172_1.tipsGo_, false)

		function arg_172_1.onSingleLineFinish_()
			arg_172_1.onSingleLineUpdate_ = nil
			arg_172_1.onSingleLineFinish_ = nil
			arg_172_1.state_ = "waiting"
		end

		function arg_172_1.playNext_(arg_174_0)
			if arg_174_0 == 1 then
				arg_172_0:Play303032043(arg_172_1)
			end
		end

		function arg_172_1.onSingleLineUpdate_(arg_175_0)
			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 then
				arg_172_1.var_.moveOldPos1027ui_story = arg_172_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_175_0 = 0.001

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_0 then
				arg_172_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_172_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_172_1.time_ - 0) / var_175_0)
				arg_172_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1027ui_story"].transform.position).z)
				arg_172_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1027ui_story"].transform.localEulerAngles = arg_172_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_172_1.time_ >= 0 + var_175_0 and arg_172_1.time_ < 0 + var_175_0 + arg_175_0 then
				arg_172_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_172_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_172_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_172_1.actors_["1027ui_story"].transform.position).z)
				arg_172_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_172_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_172_1.actors_["1027ui_story"].transform.localEulerAngles = arg_172_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_175_1 = arg_172_1.actors_["1027ui_story"]

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= 0 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1027ui_story == nil then
				arg_172_1.var_.characterEffect1027ui_story = var_175_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_175_2 = 0.200000002980232

			if 0 <= arg_172_1.time_ and arg_172_1.time_ < 0 + var_175_2 and not isNil(var_175_1) then
				if arg_172_1.var_.characterEffect1027ui_story and not isNil(var_175_1) then
					arg_172_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_172_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_172_1.time_ - 0) / var_175_2)
				end
			end

			if arg_172_1.time_ >= 0 + var_175_2 and arg_172_1.time_ < 0 + var_175_2 + arg_175_0 and not isNil(var_175_1) and arg_172_1.var_.characterEffect1027ui_story then
				arg_172_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_172_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_175_3 = 0
			local var_175_4 = 1.275

			if 0 < arg_172_1.time_ and arg_172_1.time_ <= var_175_3 + arg_175_0 then
				arg_172_1.talkMaxDuration = 0
				arg_172_1.dialogCg_.alpha = 1

				arg_172_1.dialog_:SetActive(true)
				SetActive(arg_172_1.leftNameGo_, false)

				arg_172_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_172_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_172_1:RecordName(arg_172_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_172_1.iconTrs_.gameObject, false)
				arg_172_1.callingController_:SetSelectedState("normal")

				local var_175_5 = arg_172_1:FormatText(arg_172_1:GetWordFromCfg(303032042).content)

				arg_172_1.text_.text = var_175_5

				LuaForUtil.ClearLinePrefixSymbol(arg_172_1.text_)

				local var_175_7 = 51 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_5) / 51)

				if (51 <= 0 and var_175_4 or var_175_4 * (utf8.len(var_175_5) / 51)) > 0 and var_175_4 < var_175_7 then
					arg_172_1.talkMaxDuration = var_175_7

					if var_175_7 + var_175_3 > arg_172_1.duration_ then
						arg_172_1.duration_ = var_175_7 + var_175_3
					end
				end

				arg_172_1.text_.text = var_175_5
				arg_172_1.typewritter.percent = 0

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(false)
				arg_172_1:RecordContent(arg_172_1.text_.text)
			end

			local var_175_8 = math.max(var_175_4, arg_172_1.talkMaxDuration)

			if var_175_3 <= arg_172_1.time_ and arg_172_1.time_ < var_175_3 + var_175_8 then
				arg_172_1.typewritter.percent = (arg_172_1.time_ - var_175_3) / var_175_8

				arg_172_1.typewritter:SetDirty()
			end

			if arg_172_1.time_ >= var_175_3 + var_175_8 and arg_172_1.time_ < var_175_3 + var_175_8 + arg_175_0 then
				arg_172_1.typewritter.percent = 1

				arg_172_1.typewritter:SetDirty()
				arg_172_1:ShowNextGo(true)
			end
		end

		arg_172_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_172_1:InitPlayNodeList()
	end,
	Play303032043 = function(arg_176_0, arg_176_1)
		arg_176_1.time_ = 0
		arg_176_1.frameCnt_ = 0
		arg_176_1.state_ = "playing"
		arg_176_1.curTalkId_ = 303032043
		arg_176_1.duration_ = 2.03

		local var_176_0 = {
			zh = 2.033,
			ja = 1.999999999999
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
				arg_176_0:Play303032044(arg_176_1)
			end
		end

		function arg_176_1.onSingleLineUpdate_(arg_179_0)
			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1.var_.moveOldPos1027ui_story = arg_176_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_179_0 = 0.001

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_0 then
				arg_176_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_176_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_176_1.time_ - 0) / var_179_0)
				arg_176_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1027ui_story"].transform.position).z)
				arg_176_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1027ui_story"].transform.localEulerAngles = arg_176_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_176_1.time_ >= 0 + var_179_0 and arg_176_1.time_ < 0 + var_179_0 + arg_179_0 then
				arg_176_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, -0.81, -5.8)
				arg_176_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_176_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_176_1.actors_["1027ui_story"].transform.position).z)
				arg_176_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_176_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_176_1.actors_["1027ui_story"].transform.localEulerAngles = arg_176_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_179_1 = arg_176_1.actors_["1027ui_story"]

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1027ui_story == nil then
				arg_176_1.var_.characterEffect1027ui_story = var_179_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_179_2 = 0.200000002980232

			if 0 <= arg_176_1.time_ and arg_176_1.time_ < 0 + var_179_2 and not isNil(var_179_1) then
				if arg_176_1.var_.characterEffect1027ui_story and not isNil(var_179_1) then
					arg_176_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_176_1.time_ >= 0 + var_179_2 and arg_176_1.time_ < 0 + var_179_2 + arg_179_0 and not isNil(var_179_1) and arg_176_1.var_.characterEffect1027ui_story then
				arg_176_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_2")
			end

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= 0 + arg_179_0 then
				arg_176_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_179_4 = 0
			local var_179_5 = 0.075

			if 0 < arg_176_1.time_ and arg_176_1.time_ <= var_179_4 + arg_179_0 then
				arg_176_1.talkMaxDuration = 0
				arg_176_1.dialogCg_.alpha = 1

				arg_176_1.dialog_:SetActive(true)
				SetActive(arg_176_1.leftNameGo_, true)

				arg_176_1.leftNameTxt_.text = arg_176_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_176_1.leftNameTxt_.transform)

				arg_176_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_176_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_176_1:RecordName(arg_176_1.leftNameTxt_.text)
				SetActive(arg_176_1.iconTrs_.gameObject, false)
				arg_176_1.callingController_:SetSelectedState("normal")

				local var_179_6 = arg_176_1:GetWordFromCfg(303032043)
				local var_179_7 = arg_176_1:FormatText(var_179_6.content)

				arg_176_1.text_.text = var_179_7

				LuaForUtil.ClearLinePrefixSymbol(arg_176_1.text_)

				local var_179_9 = 3 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 3)

				if (3 <= 0 and var_179_5 or var_179_5 * (utf8.len(var_179_7) / 3)) > 0 and var_179_5 < var_179_9 then
					arg_176_1.talkMaxDuration = var_179_9

					if var_179_9 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_9 + var_179_4
					end
				end

				arg_176_1.text_.text = var_179_7
				arg_176_1.typewritter.percent = 0

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032043", "story_v_out_303032.awb") ~= 0 then
					local var_179_10 = manager.audio:GetVoiceLength("story_v_out_303032", "303032043", "story_v_out_303032.awb") / 1000

					if var_179_10 + var_179_4 > arg_176_1.duration_ then
						arg_176_1.duration_ = var_179_10 + var_179_4
					end

					if var_179_6.prefab_name ~= "" and arg_176_1.actors_[var_179_6.prefab_name] ~= nil then
						local var_179_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_176_1.actors_[var_179_6.prefab_name].transform, "story_v_out_303032", "303032043", "story_v_out_303032.awb")

						arg_176_1:RecordAudio("303032043", var_179_11)
						arg_176_1:RecordAudio("303032043", var_179_11)
					else
						arg_176_1:AudioAction("play", "voice", "story_v_out_303032", "303032043", "story_v_out_303032.awb")
					end

					arg_176_1:RecordHistoryTalkVoice("story_v_out_303032", "303032043", "story_v_out_303032.awb")
				end

				arg_176_1:RecordContent(arg_176_1.text_.text)
			end

			local var_179_12 = math.max(var_179_5, arg_176_1.talkMaxDuration)

			if var_179_4 <= arg_176_1.time_ and arg_176_1.time_ < var_179_4 + var_179_12 then
				arg_176_1.typewritter.percent = (arg_176_1.time_ - var_179_4) / var_179_12

				arg_176_1.typewritter:SetDirty()
			end

			if arg_176_1.time_ >= var_179_4 + var_179_12 and arg_176_1.time_ < var_179_4 + var_179_12 + arg_179_0 then
				arg_176_1.typewritter.percent = 1

				arg_176_1.typewritter:SetDirty()
				arg_176_1:ShowNextGo(true)
			end
		end

		arg_176_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_176_1:InitPlayNodeList()
	end,
	Play303032044 = function(arg_180_0, arg_180_1)
		arg_180_1.time_ = 0
		arg_180_1.frameCnt_ = 0
		arg_180_1.state_ = "playing"
		arg_180_1.curTalkId_ = 303032044
		arg_180_1.duration_ = 9

		SetActive(arg_180_1.tipsGo_, false)

		function arg_180_1.onSingleLineFinish_()
			arg_180_1.onSingleLineUpdate_ = nil
			arg_180_1.onSingleLineFinish_ = nil
			arg_180_1.state_ = "waiting"
		end

		function arg_180_1.playNext_(arg_182_0)
			if arg_182_0 == 1 then
				arg_180_0:Play303032045(arg_180_1)
			end
		end

		function arg_180_1.onSingleLineUpdate_(arg_183_0)
			if 2 < arg_180_1.time_ and arg_180_1.time_ <= 2 + arg_183_0 then
				local var_183_0 = arg_180_1.bgs_.B15f

				arg_180_1.bgs_.B15f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_183_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_183_1 = var_183_0:GetComponent("SpriteRenderer")

				if var_183_1 and var_183_1.sprite then
					local var_183_2 = 2 * (var_183_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_183_0.transform.localScale = Vector3.New(var_183_2 / var_183_1.sprite.bounds.size.y < var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x and var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x or var_183_2 / var_183_1.sprite.bounds.size.y, var_183_2 / var_183_1.sprite.bounds.size.y < var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x and var_183_2 * manager.ui.mainCameraCom_.aspect / var_183_1.sprite.bounds.size.x or var_183_2 / var_183_1.sprite.bounds.size.y, 0)
				end

				for iter_183_0, iter_183_1 in pairs(arg_180_1.bgs_) do
					if iter_183_0 ~= "B15f" then
						iter_183_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_183_3 = 3.999999999999

			if 3.999999999999 < arg_180_1.time_ and arg_180_1.time_ <= var_183_3 + arg_183_0 then
				arg_180_1.allBtn_.enabled = false
			end

			if arg_180_1.time_ >= var_183_3 + 0.3 and arg_180_1.time_ < var_183_3 + 0.3 + arg_183_0 then
				arg_180_1.allBtn_.enabled = true
			end

			local var_183_4 = 0

			if 0 < arg_180_1.time_ and arg_180_1.time_ <= var_183_4 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_5 = 2

			if var_183_4 <= arg_180_1.time_ and arg_180_1.time_ < var_183_4 + var_183_5 then
				local var_183_6 = Color.New(0, 0, 0)

				var_183_6.a = Mathf.Lerp(0, 1, (arg_180_1.time_ - var_183_4) / var_183_5)
				arg_180_1.mask_.color = var_183_6
			end

			if arg_180_1.time_ >= var_183_4 + var_183_5 and arg_180_1.time_ < var_183_4 + var_183_5 + arg_183_0 then
				local var_183_7 = Color.New(0, 0, 0)

				var_183_7.a = 1
				arg_180_1.mask_.color = var_183_7
			end

			local var_183_8 = 2

			if 2 < arg_180_1.time_ and arg_180_1.time_ <= var_183_8 + arg_183_0 then
				arg_180_1.mask_.enabled = true
				arg_180_1.mask_.raycastTarget = true

				arg_180_1:SetGaussion(false)
			end

			local var_183_9 = 2

			if var_183_8 <= arg_180_1.time_ and arg_180_1.time_ < var_183_8 + var_183_9 then
				local var_183_10 = Color.New(0, 0, 0)

				var_183_10.a = Mathf.Lerp(1, 0, (arg_180_1.time_ - var_183_8) / var_183_9)
				arg_180_1.mask_.color = var_183_10
			end

			if arg_180_1.time_ >= var_183_8 + var_183_9 and arg_180_1.time_ < var_183_8 + var_183_9 + arg_183_0 then
				local var_183_11 = Color.New(0, 0, 0)

				arg_180_1.mask_.enabled = false
				var_183_11.a = 0
				arg_180_1.mask_.color = var_183_11
			end

			local var_183_12 = arg_180_1.actors_["1027ui_story"].transform

			if 1.96599999815226 < arg_180_1.time_ and arg_180_1.time_ <= 1.96599999815226 + arg_183_0 then
				arg_180_1.var_.moveOldPos1027ui_story = var_183_12.localPosition
			end

			local var_183_13 = 0.001

			if 1.96599999815226 <= arg_180_1.time_ and arg_180_1.time_ < 1.96599999815226 + var_183_13 then
				var_183_12.localPosition = Vector3.Lerp(arg_180_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_180_1.time_ - 1.96599999815226) / var_183_13)
				var_183_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_12.position).x, (manager.ui.mainCamera.transform.position - var_183_12.position).y, (manager.ui.mainCamera.transform.position - var_183_12.position).z)
				var_183_12.localEulerAngles.z = 0
				var_183_12.localEulerAngles.x = 0
				var_183_12.localEulerAngles = var_183_12.localEulerAngles
			end

			if arg_180_1.time_ >= 1.96599999815226 + var_183_13 and arg_180_1.time_ < 1.96599999815226 + var_183_13 + arg_183_0 then
				var_183_12.localPosition = Vector3.New(0, 100, 0)
				var_183_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_183_12.position).x, (manager.ui.mainCamera.transform.position - var_183_12.position).y, (manager.ui.mainCamera.transform.position - var_183_12.position).z)
				var_183_12.localEulerAngles.z = 0
				var_183_12.localEulerAngles.x = 0
				var_183_12.localEulerAngles = var_183_12.localEulerAngles
			end

			local var_183_14 = arg_180_1.actors_["1027ui_story"]

			if 1.96599999815226 < arg_180_1.time_ and arg_180_1.time_ <= 1.96599999815226 + arg_183_0 and not isNil(var_183_14) and arg_180_1.var_.characterEffect1027ui_story == nil then
				arg_180_1.var_.characterEffect1027ui_story = var_183_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_183_15 = 0.034000001847744

			if 1.96599999815226 <= arg_180_1.time_ and arg_180_1.time_ < 1.96599999815226 + var_183_15 and not isNil(var_183_14) then
				if arg_180_1.var_.characterEffect1027ui_story and not isNil(var_183_14) then
					arg_180_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_180_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_180_1.time_ - 1.96599999815226) / var_183_15)
				end
			end

			if arg_180_1.time_ >= 1.96599999815226 + var_183_15 and arg_180_1.time_ < 1.96599999815226 + var_183_15 + arg_183_0 and not isNil(var_183_14) and arg_180_1.var_.characterEffect1027ui_story then
				arg_180_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_180_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 1.2 < arg_180_1.time_ and arg_180_1.time_ <= 1.2 + arg_183_0 then
				arg_180_1:AudioAction("play", "effect", "se_story_148", "se_story_148_amb_drone02", "")
			end

			if 0.2 < arg_180_1.time_ and arg_180_1.time_ <= 0.2 + arg_183_0 then
				arg_180_1:AudioAction("stop", "effect", "se_story_side_1049", "se_story_side_1049_amb_room", "")
			end

			if arg_180_1.frameCnt_ <= 1 then
				arg_180_1.dialog_:SetActive(false)
			end

			local var_183_18 = 4
			local var_183_19 = 0.4

			if 4 < arg_180_1.time_ and arg_180_1.time_ <= var_183_18 + arg_183_0 then
				arg_180_1.talkMaxDuration = 0

				arg_180_1.dialog_:SetActive(true)

				arg_180_1.dialogCg_.alpha = 0

				local var_183_20 = LeanTween.value(arg_180_1.dialog_, 0, 1, 0.3)

				var_183_20:setOnUpdate(LuaHelper.FloatAction(function(arg_184_0)
					arg_180_1.dialogCg_.alpha = arg_184_0
				end))
				var_183_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_180_1.dialog_)
					var_183_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_180_1.duration_ = arg_180_1.duration_ + 0.3

				SetActive(arg_180_1.leftNameGo_, true)

				arg_180_1.leftNameTxt_.text = arg_180_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_180_1.leftNameTxt_.transform)

				arg_180_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_180_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_180_1:RecordName(arg_180_1.leftNameTxt_.text)
				SetActive(arg_180_1.iconTrs_.gameObject, true)
				arg_180_1.iconController_:SetSelectedState("hero")

				arg_180_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_180_1.callingController_:SetSelectedState("normal")

				arg_180_1.keyicon_.color = Color.New(1, 1, 1)
				arg_180_1.icon_.color = Color.New(1, 1, 1)

				local var_183_21 = arg_180_1:FormatText(arg_180_1:GetWordFromCfg(303032044).content)

				arg_180_1.text_.text = var_183_21

				LuaForUtil.ClearLinePrefixSymbol(arg_180_1.text_)

				local var_183_23 = 16 <= 0 and var_183_19 or var_183_19 * (utf8.len(var_183_21) / 16)

				if (16 <= 0 and var_183_19 or var_183_19 * (utf8.len(var_183_21) / 16)) > 0 and var_183_19 < var_183_23 then
					arg_180_1.talkMaxDuration = var_183_23
					var_183_18 = var_183_18 + 0.3

					if var_183_23 + var_183_18 > arg_180_1.duration_ then
						arg_180_1.duration_ = var_183_23 + var_183_18
					end
				end

				arg_180_1.text_.text = var_183_21
				arg_180_1.typewritter.percent = 0

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(false)
				arg_180_1:RecordContent(arg_180_1.text_.text)
			end

			local var_183_24 = var_183_18 + 0.3
			local var_183_25 = math.max(var_183_19, arg_180_1.talkMaxDuration)

			if var_183_18 + 0.3 <= arg_180_1.time_ and arg_180_1.time_ < var_183_24 + var_183_25 then
				arg_180_1.typewritter.percent = (arg_180_1.time_ - var_183_24) / var_183_25

				arg_180_1.typewritter:SetDirty()
			end

			if arg_180_1.time_ >= var_183_24 + var_183_25 and arg_180_1.time_ < var_183_24 + var_183_25 + arg_183_0 then
				arg_180_1.typewritter.percent = 1

				arg_180_1.typewritter:SetDirty()
				arg_180_1:ShowNextGo(true)
			end
		end

		arg_180_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_180_1:InitPlayNodeList()
	end,
	Play303032045 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 303032045
		arg_186_1.duration_ = 7.6

		local var_186_0 = {
			zh = 7.6,
			ja = 5.633
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
				arg_186_0:Play303032046(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			local var_189_0 = 0.775

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, true)
				arg_186_1.iconController_:SetSelectedState("hero")

				arg_186_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_186_1.callingController_:SetSelectedState("calling")

				arg_186_1.keyicon_.color = Color.New(1, 1, 1)
				arg_186_1.icon_.color = Color.New(1, 1, 1)

				local var_189_1 = arg_186_1:GetWordFromCfg(303032045)
				local var_189_2 = arg_186_1:FormatText(var_189_1.content)

				arg_186_1.text_.text = var_189_2

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_4 = 31 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 31)

				if (31 <= 0 and var_189_0 or var_189_0 * (utf8.len(var_189_2) / 31)) > 0 and var_189_0 < var_189_4 then
					arg_186_1.talkMaxDuration = var_189_4

					if var_189_4 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_4 + 0
					end
				end

				arg_186_1.text_.text = var_189_2
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032045", "story_v_out_303032.awb") ~= 0 then
					local var_189_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032045", "story_v_out_303032.awb") / 1000

					if var_189_5 + 0 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_5 + 0
					end

					if var_189_1.prefab_name ~= "" and arg_186_1.actors_[var_189_1.prefab_name] ~= nil then
						local var_189_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_1.prefab_name].transform, "story_v_out_303032", "303032045", "story_v_out_303032.awb")

						arg_186_1:RecordAudio("303032045", var_189_6)
						arg_186_1:RecordAudio("303032045", var_189_6)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_303032", "303032045", "story_v_out_303032.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_303032", "303032045", "story_v_out_303032.awb")
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
	Play303032046 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 303032046
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play303032047(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["1080ui_story"]) and arg_190_1.var_.characterEffect1080ui_story == nil then
				arg_190_1.var_.characterEffect1080ui_story = arg_190_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["1080ui_story"]) then
				if arg_190_1.var_.characterEffect1080ui_story and not isNil(arg_190_1.actors_["1080ui_story"]) then
					arg_190_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_0)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["1080ui_story"]) and arg_190_1.var_.characterEffect1080ui_story then
				arg_190_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_193_1 = 0
			local var_193_2 = 0.325

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_1 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, true)
				arg_190_1.iconController_:SetSelectedState("hero")

				arg_190_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_190_1.callingController_:SetSelectedState("normal")

				arg_190_1.keyicon_.color = Color.New(1, 1, 1)
				arg_190_1.icon_.color = Color.New(1, 1, 1)

				local var_193_3 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(303032046).content)

				arg_190_1.text_.text = var_193_3

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_5 = 13 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 13)

				if (13 <= 0 and var_193_2 or var_193_2 * (utf8.len(var_193_3) / 13)) > 0 and var_193_2 < var_193_5 then
					arg_190_1.talkMaxDuration = var_193_5

					if var_193_5 + var_193_1 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_5 + var_193_1
					end
				end

				arg_190_1.text_.text = var_193_3
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_6 = math.max(var_193_2, arg_190_1.talkMaxDuration)

			if var_193_1 <= arg_190_1.time_ and arg_190_1.time_ < var_193_1 + var_193_6 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_1) / var_193_6

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_1 + var_193_6 and arg_190_1.time_ < var_193_1 + var_193_6 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {}

		arg_190_1:InitPlayNodeList()
	end,
	Play303032047 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 303032047
		arg_194_1.duration_ = 4.8

		local var_194_0 = {
			zh = 4.8,
			ja = 3.9
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
				arg_194_0:Play303032048(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			local var_197_0 = 0.475

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, true)
				arg_194_1.iconController_:SetSelectedState("hero")

				arg_194_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_194_1.callingController_:SetSelectedState("calling")

				arg_194_1.keyicon_.color = Color.New(1, 1, 1)
				arg_194_1.icon_.color = Color.New(1, 1, 1)

				local var_197_1 = arg_194_1:GetWordFromCfg(303032047)
				local var_197_2 = arg_194_1:FormatText(var_197_1.content)

				arg_194_1.text_.text = var_197_2

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_4 = 19 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 19)

				if (19 <= 0 and var_197_0 or var_197_0 * (utf8.len(var_197_2) / 19)) > 0 and var_197_0 < var_197_4 then
					arg_194_1.talkMaxDuration = var_197_4

					if var_197_4 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_4 + 0
					end
				end

				arg_194_1.text_.text = var_197_2
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032047", "story_v_out_303032.awb") ~= 0 then
					local var_197_5 = manager.audio:GetVoiceLength("story_v_out_303032", "303032047", "story_v_out_303032.awb") / 1000

					if var_197_5 + 0 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_5 + 0
					end

					if var_197_1.prefab_name ~= "" and arg_194_1.actors_[var_197_1.prefab_name] ~= nil then
						local var_197_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_1.prefab_name].transform, "story_v_out_303032", "303032047", "story_v_out_303032.awb")

						arg_194_1:RecordAudio("303032047", var_197_6)
						arg_194_1:RecordAudio("303032047", var_197_6)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_303032", "303032047", "story_v_out_303032.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_303032", "303032047", "story_v_out_303032.awb")
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
	Play303032048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 303032048
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play303032049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["1080ui_story"]) and arg_198_1.var_.characterEffect1080ui_story == nil then
				arg_198_1.var_.characterEffect1080ui_story = arg_198_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["1080ui_story"]) then
				if arg_198_1.var_.characterEffect1080ui_story and not isNil(arg_198_1.actors_["1080ui_story"]) then
					arg_198_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_0)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["1080ui_story"]) and arg_198_1.var_.characterEffect1080ui_story then
				arg_198_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_201_1 = 0
			local var_201_2 = 0.175

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_1 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, true)
				arg_198_1.iconController_:SetSelectedState("hero")

				arg_198_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_198_1.callingController_:SetSelectedState("normal")

				arg_198_1.keyicon_.color = Color.New(1, 1, 1)
				arg_198_1.icon_.color = Color.New(1, 1, 1)

				local var_201_3 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(303032048).content)

				arg_198_1.text_.text = var_201_3

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_5 = 7 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 7)

				if (7 <= 0 and var_201_2 or var_201_2 * (utf8.len(var_201_3) / 7)) > 0 and var_201_2 < var_201_5 then
					arg_198_1.talkMaxDuration = var_201_5

					if var_201_5 + var_201_1 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + var_201_1
					end
				end

				arg_198_1.text_.text = var_201_3
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_6 = math.max(var_201_2, arg_198_1.talkMaxDuration)

			if var_201_1 <= arg_198_1.time_ and arg_198_1.time_ < var_201_1 + var_201_6 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_1) / var_201_6

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_1 + var_201_6 and arg_198_1.time_ < var_201_1 + var_201_6 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play303032049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 303032049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play303032050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			local var_205_0 = 0.225

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, true)
				arg_202_1.iconController_:SetSelectedState("hero")

				arg_202_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_202_1.callingController_:SetSelectedState("normal")

				arg_202_1.keyicon_.color = Color.New(1, 1, 1)
				arg_202_1.icon_.color = Color.New(1, 1, 1)

				local var_205_1 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(303032049).content)

				arg_202_1.text_.text = var_205_1

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_3 = 9 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 9)

				if (9 <= 0 and var_205_0 or var_205_0 * (utf8.len(var_205_1) / 9)) > 0 and var_205_0 < var_205_3 then
					arg_202_1.talkMaxDuration = var_205_3

					if var_205_3 + 0 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_3 + 0
					end
				end

				arg_202_1.text_.text = var_205_1
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_4 = math.max(var_205_0, arg_202_1.talkMaxDuration)

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - 0) / var_205_4

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	Play303032050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 303032050
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play303032051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1080ui_story = arg_206_1.actors_["1080ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1080ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1080ui_story"].transform.position).z)
				arg_206_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1080ui_story"].transform.localEulerAngles = arg_206_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1080ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.actors_["1080ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1080ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1080ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1080ui_story"].transform.position).z)
				arg_206_1.actors_["1080ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1080ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1080ui_story"].transform.localEulerAngles = arg_206_1.actors_["1080ui_story"].transform.localEulerAngles
			end

			local var_209_1 = 0
			local var_209_2 = 0.475

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_1 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_3 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(303032050).content)

				arg_206_1.text_.text = var_209_3

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_5 = 19 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 19)

				if (19 <= 0 and var_209_2 or var_209_2 * (utf8.len(var_209_3) / 19)) > 0 and var_209_2 < var_209_5 then
					arg_206_1.talkMaxDuration = var_209_5

					if var_209_5 + var_209_1 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_5 + var_209_1
					end
				end

				arg_206_1.text_.text = var_209_3
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_6 = math.max(var_209_2, arg_206_1.talkMaxDuration)

			if var_209_1 <= arg_206_1.time_ and arg_206_1.time_ < var_209_1 + var_209_6 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_1) / var_209_6

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_1 + var_209_6 and arg_206_1.time_ < var_209_1 + var_209_6 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play303032051 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 303032051
		arg_210_1.duration_ = 11.7

		local var_210_0 = {
			zh = 7.6,
			ja = 11.7
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
				arg_210_0:Play303032052(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos1084ui_story = arg_210_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_213_0 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_0 then
				arg_210_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_210_1.time_ - 0) / var_213_0)
				arg_210_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).z)
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles = arg_210_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_0 and arg_210_1.time_ < 0 + var_213_0 + arg_213_0 then
				arg_210_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_210_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["1084ui_story"].transform.position).z)
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["1084ui_story"].transform.localEulerAngles = arg_210_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_213_1 = arg_210_1.actors_["1084ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1084ui_story == nil then
				arg_210_1.var_.characterEffect1084ui_story = var_213_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_2 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_2 and not isNil(var_213_1) then
				if arg_210_1.var_.characterEffect1084ui_story and not isNil(var_213_1) then
					arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_2 and arg_210_1.time_ < 0 + var_213_2 + arg_213_0 and not isNil(var_213_1) and arg_210_1.var_.characterEffect1084ui_story then
				arg_210_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva", "EmotionTimelineAnimator")
			end

			local var_213_4 = 0
			local var_213_5 = 0.65

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

				local var_213_6 = arg_210_1:GetWordFromCfg(303032051)
				local var_213_7 = arg_210_1:FormatText(var_213_6.content)

				arg_210_1.text_.text = var_213_7

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_9 = 26 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 26)

				if (26 <= 0 and var_213_5 or var_213_5 * (utf8.len(var_213_7) / 26)) > 0 and var_213_5 < var_213_9 then
					arg_210_1.talkMaxDuration = var_213_9

					if var_213_9 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_9 + var_213_4
					end
				end

				arg_210_1.text_.text = var_213_7
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032051", "story_v_out_303032.awb") ~= 0 then
					local var_213_10 = manager.audio:GetVoiceLength("story_v_out_303032", "303032051", "story_v_out_303032.awb") / 1000

					if var_213_10 + var_213_4 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_10 + var_213_4
					end

					if var_213_6.prefab_name ~= "" and arg_210_1.actors_[var_213_6.prefab_name] ~= nil then
						local var_213_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_210_1.actors_[var_213_6.prefab_name].transform, "story_v_out_303032", "303032051", "story_v_out_303032.awb")

						arg_210_1:RecordAudio("303032051", var_213_11)
						arg_210_1:RecordAudio("303032051", var_213_11)
					else
						arg_210_1:AudioAction("play", "voice", "story_v_out_303032", "303032051", "story_v_out_303032.awb")
					end

					arg_210_1:RecordHistoryTalkVoice("story_v_out_303032", "303032051", "story_v_out_303032.awb")
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

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play303032052 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 303032052
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play303032053(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(arg_214_1.actors_["1084ui_story"]) and arg_214_1.var_.characterEffect1084ui_story == nil then
				arg_214_1.var_.characterEffect1084ui_story = arg_214_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_0 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_0 and not isNil(arg_214_1.actors_["1084ui_story"]) then
				if arg_214_1.var_.characterEffect1084ui_story and not isNil(arg_214_1.actors_["1084ui_story"]) then
					arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_214_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_0)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_0 and arg_214_1.time_ < 0 + var_217_0 + arg_217_0 and not isNil(arg_214_1.actors_["1084ui_story"]) and arg_214_1.var_.characterEffect1084ui_story then
				arg_214_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_214_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_217_1 = 0
			local var_217_2 = 0.45

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_1 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, true)
				arg_214_1.iconController_:SetSelectedState("hero")

				arg_214_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_214_1.callingController_:SetSelectedState("normal")

				arg_214_1.keyicon_.color = Color.New(1, 1, 1)
				arg_214_1.icon_.color = Color.New(1, 1, 1)

				local var_217_3 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(303032052).content)

				arg_214_1.text_.text = var_217_3

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_5 = 18 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 18)

				if (18 <= 0 and var_217_2 or var_217_2 * (utf8.len(var_217_3) / 18)) > 0 and var_217_2 < var_217_5 then
					arg_214_1.talkMaxDuration = var_217_5

					if var_217_5 + var_217_1 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_5 + var_217_1
					end
				end

				arg_214_1.text_.text = var_217_3
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_6 = math.max(var_217_2, arg_214_1.talkMaxDuration)

			if var_217_1 <= arg_214_1.time_ and arg_214_1.time_ < var_217_1 + var_217_6 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_1) / var_217_6

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_1 + var_217_6 and arg_214_1.time_ < var_217_1 + var_217_6 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {}

		arg_214_1:InitPlayNodeList()
	end,
	Play303032053 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 303032053
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play303032054(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			local var_221_0 = 1.475

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, true)

				arg_218_1.leftNameTxt_.text = arg_218_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_218_1.leftNameTxt_.transform)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1.leftNameTxt_.text)
				SetActive(arg_218_1.iconTrs_.gameObject, true)
				arg_218_1.iconController_:SetSelectedState("hero")

				arg_218_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_218_1.callingController_:SetSelectedState("normal")

				arg_218_1.keyicon_.color = Color.New(1, 1, 1)
				arg_218_1.icon_.color = Color.New(1, 1, 1)

				local var_221_1 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(303032053).content)

				arg_218_1.text_.text = var_221_1

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_3 = 59 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 59)

				if (59 <= 0 and var_221_0 or var_221_0 * (utf8.len(var_221_1) / 59)) > 0 and var_221_0 < var_221_3 then
					arg_218_1.talkMaxDuration = var_221_3

					if var_221_3 + 0 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_3 + 0
					end
				end

				arg_218_1.text_.text = var_221_1
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_4 = math.max(var_221_0, arg_218_1.talkMaxDuration)

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_4 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - 0) / var_221_4

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= 0 + var_221_4 and arg_218_1.time_ < 0 + var_221_4 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {}

		arg_218_1:InitPlayNodeList()
	end,
	Play303032054 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 303032054
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play303032055(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			local var_225_0 = 1.075

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, true)
				arg_222_1.iconController_:SetSelectedState("hero")

				arg_222_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_222_1.callingController_:SetSelectedState("normal")

				arg_222_1.keyicon_.color = Color.New(1, 1, 1)
				arg_222_1.icon_.color = Color.New(1, 1, 1)

				local var_225_1 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(303032054).content)

				arg_222_1.text_.text = var_225_1

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_3 = 43 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 43)

				if (43 <= 0 and var_225_0 or var_225_0 * (utf8.len(var_225_1) / 43)) > 0 and var_225_0 < var_225_3 then
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
	Play303032055 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 303032055
		arg_226_1.duration_ = 8.3

		local var_226_0 = {
			zh = 7.6,
			ja = 8.3
		}
		local var_226_1 = manager.audio:GetLocalizationFlag()

		if var_226_0[var_226_1] ~= nil then
			arg_226_1.duration_ = var_226_0[var_226_1]
		end

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play303032056(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos1084ui_story = arg_226_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_229_0 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_226_1.time_ - 0) / var_229_0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 then
				arg_226_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_226_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_226_1.actors_["1084ui_story"].transform.position).z)
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_226_1.actors_["1084ui_story"].transform.localEulerAngles = arg_226_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_229_1 = arg_226_1.actors_["10140ui_story"].transform

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1.var_.moveOldPos10140ui_story = var_229_1.localPosition

				local var_229_2 = GameObjectTools.GetOrAddComponent(var_229_1.gameObject, typeof(DynamicBoneHelper))

				if var_229_2 then
					var_229_2:EnableDynamicBone(false)
				end
			end

			local var_229_3 = 0.001

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_3 then
				var_229_1.localPosition = Vector3.Lerp(arg_226_1.var_.moveOldPos10140ui_story, Vector3.New(0, -0.96, -6.29), (arg_226_1.time_ - 0) / var_229_3)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles
			end

			if arg_226_1.time_ >= 0 + var_229_3 and arg_226_1.time_ < 0 + var_229_3 + arg_229_0 then
				var_229_1.localPosition = Vector3.New(0, -0.96, -6.29)
				var_229_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_229_1.position).x, (manager.ui.mainCamera.transform.position - var_229_1.position).y, (manager.ui.mainCamera.transform.position - var_229_1.position).z)
				var_229_1.localEulerAngles.z = 0
				var_229_1.localEulerAngles.x = 0
				var_229_1.localEulerAngles = var_229_1.localEulerAngles

				local var_229_4 = GameObjectTools.GetOrAddComponent(var_229_1.gameObject, typeof(DynamicBoneHelper))

				if var_229_4 then
					var_229_4:EnableDynamicBone(true)
				end
			end

			local var_229_5 = arg_226_1.actors_["10140ui_story"]

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect10140ui_story == nil then
				arg_226_1.var_.characterEffect10140ui_story = var_229_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_6 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_6 and not isNil(var_229_5) then
				if arg_226_1.var_.characterEffect10140ui_story and not isNil(var_229_5) then
					arg_226_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_226_1.time_ >= 0 + var_229_6 and arg_226_1.time_ < 0 + var_229_6 + arg_229_0 and not isNil(var_229_5) and arg_226_1.var_.characterEffect10140ui_story then
				arg_226_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_1")
			end

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 then
				arg_226_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/public_expression/expr_wuganA", "EmotionTimelineAnimator")
			end

			local var_229_8 = 0
			local var_229_9 = 0.4

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_8 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[606].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, false)
				arg_226_1.callingController_:SetSelectedState("normal")

				local var_229_10 = arg_226_1:GetWordFromCfg(303032055)
				local var_229_11 = arg_226_1:FormatText(var_229_10.content)

				arg_226_1.text_.text = var_229_11

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_13 = 16 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_11) / 16)

				if (16 <= 0 and var_229_9 or var_229_9 * (utf8.len(var_229_11) / 16)) > 0 and var_229_9 < var_229_13 then
					arg_226_1.talkMaxDuration = var_229_13

					if var_229_13 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_13 + var_229_8
					end
				end

				arg_226_1.text_.text = var_229_11
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032055", "story_v_out_303032.awb") ~= 0 then
					local var_229_14 = manager.audio:GetVoiceLength("story_v_out_303032", "303032055", "story_v_out_303032.awb") / 1000

					if var_229_14 + var_229_8 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_14 + var_229_8
					end

					if var_229_10.prefab_name ~= "" and arg_226_1.actors_[var_229_10.prefab_name] ~= nil then
						local var_229_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_226_1.actors_[var_229_10.prefab_name].transform, "story_v_out_303032", "303032055", "story_v_out_303032.awb")

						arg_226_1:RecordAudio("303032055", var_229_15)
						arg_226_1:RecordAudio("303032055", var_229_15)
					else
						arg_226_1:AudioAction("play", "voice", "story_v_out_303032", "303032055", "story_v_out_303032.awb")
					end

					arg_226_1:RecordHistoryTalkVoice("story_v_out_303032", "303032055", "story_v_out_303032.awb")
				end

				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_16 = math.max(var_229_9, arg_226_1.talkMaxDuration)

			if var_229_8 <= arg_226_1.time_ and arg_226_1.time_ < var_229_8 + var_229_16 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_8) / var_229_16

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_8 + var_229_16 and arg_226_1.time_ < var_229_8 + var_229_16 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {
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

		arg_226_1:InitPlayNodeList()
	end,
	Play303032056 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 303032056
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play303032057(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 and not isNil(arg_230_1.actors_["10140ui_story"]) and arg_230_1.var_.characterEffect10140ui_story == nil then
				arg_230_1.var_.characterEffect10140ui_story = arg_230_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_233_0 = 0.200000002980232

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_0 and not isNil(arg_230_1.actors_["10140ui_story"]) then
				if arg_230_1.var_.characterEffect10140ui_story and not isNil(arg_230_1.actors_["10140ui_story"]) then
					arg_230_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_230_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_230_1.time_ - 0) / var_233_0)
				end
			end

			if arg_230_1.time_ >= 0 + var_233_0 and arg_230_1.time_ < 0 + var_233_0 + arg_233_0 and not isNil(arg_230_1.actors_["10140ui_story"]) and arg_230_1.var_.characterEffect10140ui_story then
				arg_230_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_230_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			local var_233_1 = 0
			local var_233_2 = 0.225

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= var_233_1 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, true)
				arg_230_1.iconController_:SetSelectedState("hero")

				arg_230_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_230_1.callingController_:SetSelectedState("normal")

				arg_230_1.keyicon_.color = Color.New(1, 1, 1)
				arg_230_1.icon_.color = Color.New(1, 1, 1)

				local var_233_3 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(303032056).content)

				arg_230_1.text_.text = var_233_3

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_5 = 9 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 9)

				if (9 <= 0 and var_233_2 or var_233_2 * (utf8.len(var_233_3) / 9)) > 0 and var_233_2 < var_233_5 then
					arg_230_1.talkMaxDuration = var_233_5

					if var_233_5 + var_233_1 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + var_233_1
					end
				end

				arg_230_1.text_.text = var_233_3
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_6 = math.max(var_233_2, arg_230_1.talkMaxDuration)

			if var_233_1 <= arg_230_1.time_ and arg_230_1.time_ < var_233_1 + var_233_6 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - var_233_1) / var_233_6

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= var_233_1 + var_233_6 and arg_230_1.time_ < var_233_1 + var_233_6 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play303032057 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 303032057
		arg_234_1.duration_ = 6.27

		local var_234_0 = {
			zh = 4.7,
			ja = 6.266
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
				arg_234_0:Play303032058(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10140ui_story"]) and arg_234_1.var_.characterEffect10140ui_story == nil then
				arg_234_1.var_.characterEffect10140ui_story = arg_234_1.actors_["10140ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10140ui_story"]) then
				if arg_234_1.var_.characterEffect10140ui_story and not isNil(arg_234_1.actors_["10140ui_story"]) then
					arg_234_1.var_.characterEffect10140ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10140ui_story"]) and arg_234_1.var_.characterEffect10140ui_story then
				arg_234_1.var_.characterEffect10140ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("10140ui_story", "StoryTimeline/CharAction/story10140/story10140action/10140action8_2")
			end

			local var_237_2 = 0
			local var_237_3 = 0.175

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_2 + arg_237_0 then
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

				local var_237_4 = arg_234_1:GetWordFromCfg(303032057)
				local var_237_5 = arg_234_1:FormatText(var_237_4.content)

				arg_234_1.text_.text = var_237_5

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_7 = 7 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 7)

				if (7 <= 0 and var_237_3 or var_237_3 * (utf8.len(var_237_5) / 7)) > 0 and var_237_3 < var_237_7 then
					arg_234_1.talkMaxDuration = var_237_7

					if var_237_7 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_7 + var_237_2
					end
				end

				arg_234_1.text_.text = var_237_5
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032057", "story_v_out_303032.awb") ~= 0 then
					local var_237_8 = manager.audio:GetVoiceLength("story_v_out_303032", "303032057", "story_v_out_303032.awb") / 1000

					if var_237_8 + var_237_2 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_8 + var_237_2
					end

					if var_237_4.prefab_name ~= "" and arg_234_1.actors_[var_237_4.prefab_name] ~= nil then
						local var_237_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_234_1.actors_[var_237_4.prefab_name].transform, "story_v_out_303032", "303032057", "story_v_out_303032.awb")

						arg_234_1:RecordAudio("303032057", var_237_9)
						arg_234_1:RecordAudio("303032057", var_237_9)
					else
						arg_234_1:AudioAction("play", "voice", "story_v_out_303032", "303032057", "story_v_out_303032.awb")
					end

					arg_234_1:RecordHistoryTalkVoice("story_v_out_303032", "303032057", "story_v_out_303032.awb")
				end

				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_10 = math.max(var_237_3, arg_234_1.talkMaxDuration)

			if var_237_2 <= arg_234_1.time_ and arg_234_1.time_ < var_237_2 + var_237_10 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_2) / var_237_10

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_2 + var_237_10 and arg_234_1.time_ < var_237_2 + var_237_10 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play303032058 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 303032058
		arg_238_1.duration_ = 3.7

		local var_238_0 = {
			zh = 3.7,
			ja = 2.933
		}
		local var_238_1 = manager.audio:GetLocalizationFlag()

		if var_238_0[var_238_1] ~= nil then
			arg_238_1.duration_ = var_238_0[var_238_1]
		end

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play303032059(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = arg_238_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).z)
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles = arg_238_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_238_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).z)
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles = arg_238_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["10140ui_story"].transform

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos10140ui_story = var_241_1.localPosition

				local var_241_2 = GameObjectTools.GetOrAddComponent(var_241_1.gameObject, typeof(DynamicBoneHelper))

				if var_241_2 then
					var_241_2:EnableDynamicBone(false)
				end
			end

			local var_241_3 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_3 then
				var_241_1.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos10140ui_story, Vector3.New(0, 100, 0), (arg_238_1.time_ - 0) / var_241_3)
				var_241_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_1.position).x, (manager.ui.mainCamera.transform.position - var_241_1.position).y, (manager.ui.mainCamera.transform.position - var_241_1.position).z)
				var_241_1.localEulerAngles.z = 0
				var_241_1.localEulerAngles.x = 0
				var_241_1.localEulerAngles = var_241_1.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_3 and arg_238_1.time_ < 0 + var_241_3 + arg_241_0 then
				var_241_1.localPosition = Vector3.New(0, 100, 0)
				var_241_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_241_1.position).x, (manager.ui.mainCamera.transform.position - var_241_1.position).y, (manager.ui.mainCamera.transform.position - var_241_1.position).z)
				var_241_1.localEulerAngles.z = 0
				var_241_1.localEulerAngles.x = 0
				var_241_1.localEulerAngles = var_241_1.localEulerAngles

				local var_241_4 = GameObjectTools.GetOrAddComponent(var_241_1.gameObject, typeof(DynamicBoneHelper))

				if var_241_4 then
					var_241_4:EnableDynamicBone(true)
				end
			end

			local var_241_5 = arg_238_1.actors_["1084ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_6 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_6 and not isNil(var_241_5) then
				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_5) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_6 and arg_238_1.time_ < 0 + var_241_6 + arg_241_0 and not isNil(var_241_5) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_241_8 = arg_238_1.actors_["10140ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.characterEffect10140ui_story == nil then
				arg_238_1.var_.characterEffect10140ui_story = var_241_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_9 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_9 and not isNil(var_241_8) then
				if arg_238_1.var_.characterEffect10140ui_story and not isNil(var_241_8) then
					arg_238_1.var_.characterEffect10140ui_story.fillFlat = true
					arg_238_1.var_.characterEffect10140ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_9)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_9 and arg_238_1.time_ < 0 + var_241_9 + arg_241_0 and not isNil(var_241_8) and arg_238_1.var_.characterEffect10140ui_story then
				arg_238_1.var_.characterEffect10140ui_story.fillFlat = true
				arg_238_1.var_.characterEffect10140ui_story.fillRatio = 0.5
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_241_10 = 0
			local var_241_11 = 0.275

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_10 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, false)
				arg_238_1.callingController_:SetSelectedState("normal")

				local var_241_12 = arg_238_1:GetWordFromCfg(303032058)
				local var_241_13 = arg_238_1:FormatText(var_241_12.content)

				arg_238_1.text_.text = var_241_13

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_15 = 11 <= 0 and var_241_11 or var_241_11 * (utf8.len(var_241_13) / 11)

				if (11 <= 0 and var_241_11 or var_241_11 * (utf8.len(var_241_13) / 11)) > 0 and var_241_11 < var_241_15 then
					arg_238_1.talkMaxDuration = var_241_15

					if var_241_15 + var_241_10 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_15 + var_241_10
					end
				end

				arg_238_1.text_.text = var_241_13
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_303032", "303032058", "story_v_out_303032.awb") ~= 0 then
					local var_241_16 = manager.audio:GetVoiceLength("story_v_out_303032", "303032058", "story_v_out_303032.awb") / 1000

					if var_241_16 + var_241_10 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_16 + var_241_10
					end

					if var_241_12.prefab_name ~= "" and arg_238_1.actors_[var_241_12.prefab_name] ~= nil then
						local var_241_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_12.prefab_name].transform, "story_v_out_303032", "303032058", "story_v_out_303032.awb")

						arg_238_1:RecordAudio("303032058", var_241_17)
						arg_238_1:RecordAudio("303032058", var_241_17)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_303032", "303032058", "story_v_out_303032.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_303032", "303032058", "story_v_out_303032.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_18 = math.max(var_241_11, arg_238_1.talkMaxDuration)

			if var_241_10 <= arg_238_1.time_ and arg_238_1.time_ < var_241_10 + var_241_18 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_10) / var_241_18

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_10 + var_241_18 and arg_238_1.time_ < var_241_10 + var_241_18 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {
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

		arg_238_1:InitPlayNodeList()
	end,
	Play303032059 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 303032059
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play303032060(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1084ui_story = arg_242_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_245_0 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_0 then
				arg_242_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_242_1.time_ - 0) / var_245_0)
				arg_242_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).z)
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles = arg_242_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_0 and arg_242_1.time_ < 0 + var_245_0 + arg_245_0 then
				arg_242_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_242_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1084ui_story"].transform.position).z)
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1084ui_story"].transform.localEulerAngles = arg_242_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_245_1 = arg_242_1.actors_["1084ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1084ui_story == nil then
				arg_242_1.var_.characterEffect1084ui_story = var_245_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_2 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_2 and not isNil(var_245_1) then
				if arg_242_1.var_.characterEffect1084ui_story and not isNil(var_245_1) then
					arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_242_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_242_1.time_ - 0) / var_245_2)
				end
			end

			if arg_242_1.time_ >= 0 + var_245_2 and arg_242_1.time_ < 0 + var_245_2 + arg_245_0 and not isNil(var_245_1) and arg_242_1.var_.characterEffect1084ui_story then
				arg_242_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_242_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0.8 < arg_242_1.time_ and arg_242_1.time_ <= 0.8 + arg_245_0 then
				arg_242_1:AudioAction("play", "effect", "se_story_152", "se_story_152_monster01", "")
			end

			local var_245_4 = 0
			local var_245_5 = 1.325

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_4 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, false)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_6 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(303032059).content)

				arg_242_1.text_.text = var_245_6

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_8 = 53 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_6) / 53)

				if (53 <= 0 and var_245_5 or var_245_5 * (utf8.len(var_245_6) / 53)) > 0 and var_245_5 < var_245_8 then
					arg_242_1.talkMaxDuration = var_245_8

					if var_245_8 + var_245_4 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_8 + var_245_4
					end
				end

				arg_242_1.text_.text = var_245_6
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_9 = math.max(var_245_5, arg_242_1.talkMaxDuration)

			if var_245_4 <= arg_242_1.time_ and arg_242_1.time_ < var_245_4 + var_245_9 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_4) / var_245_9

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_4 + var_245_9 and arg_242_1.time_ < var_245_4 + var_245_9 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play303032060 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 303032060
		arg_246_1.duration_ = 6

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play303032061(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			local var_249_9000

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				arg_246_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_249_0 = 0.6

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 then
				local var_249_1, var_249_2 = math.modf((arg_246_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_249_2 * 0.13, var_249_2 * 0.13, var_249_2 * 0.13) + arg_246_1.var_.shakeOldPos
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 then
				manager.ui.mainCamera.transform.localPosition = arg_246_1.var_.shakeOldPos
			end

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 then
				local var_249_3 = arg_246_1.var_.effectcidao1

				if not arg_246_1.var_.effectcidao1 then
					var_249_3 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_249_3.name = "cidao1"
					arg_246_1.var_.effectcidao1 = var_249_3
				else
					var_249_3.transform:SetParent(var_249_9000)
				end

				var_249_3.transform.localPosition = Vector3.New(0, 0, 0)
				var_249_3.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0.8 < arg_246_1.time_ and arg_246_1.time_ <= 0.8 + arg_249_0 then
				arg_246_1:AudioAction("play", "effect", "se_story_152", "se_story_152_monster02", "")
			end

			if arg_246_1.frameCnt_ <= 1 then
				arg_246_1.dialog_:SetActive(false)
			end

			local var_249_6 = 1
			local var_249_7 = 1.4

			if 1 < arg_246_1.time_ and arg_246_1.time_ <= var_249_6 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0

				arg_246_1.dialog_:SetActive(true)

				arg_246_1.dialogCg_.alpha = 0

				local var_249_8 = LeanTween.value(arg_246_1.dialog_, 0, 1, 0.3)

				var_249_8:setOnUpdate(LuaHelper.FloatAction(function(arg_250_0)
					arg_246_1.dialogCg_.alpha = arg_250_0
				end))
				var_249_8:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_246_1.dialog_)
					var_249_8:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_246_1.duration_ = arg_246_1.duration_ + 0.3

				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_9 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(303032060).content)

				arg_246_1.text_.text = var_249_9

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_11 = 56 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 56)

				if (56 <= 0 and var_249_7 or var_249_7 * (utf8.len(var_249_9) / 56)) > 0 and var_249_7 < var_249_11 then
					arg_246_1.talkMaxDuration = var_249_11
					var_249_6 = var_249_6 + 0.3

					if var_249_11 + var_249_6 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_11 + var_249_6
					end
				end

				arg_246_1.text_.text = var_249_9
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_12 = var_249_6 + 0.3
			local var_249_13 = math.max(var_249_7, arg_246_1.talkMaxDuration)

			if var_249_6 + 0.3 <= arg_246_1.time_ and arg_246_1.time_ < var_249_12 + var_249_13 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_12) / var_249_13

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_12 + var_249_13 and arg_246_1.time_ < var_249_12 + var_249_13 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play303032061 = function(arg_252_0, arg_252_1)
		arg_252_1.time_ = 0
		arg_252_1.frameCnt_ = 0
		arg_252_1.state_ = "playing"
		arg_252_1.curTalkId_ = 303032061
		arg_252_1.duration_ = 6.3

		SetActive(arg_252_1.tipsGo_, false)

		function arg_252_1.onSingleLineFinish_()
			arg_252_1.onSingleLineUpdate_ = nil
			arg_252_1.onSingleLineFinish_ = nil
			arg_252_1.state_ = "waiting"
		end

		function arg_252_1.playNext_(arg_254_0)
			if arg_254_0 == 1 then
				arg_252_0:Play303032062(arg_252_1)
			end
		end

		function arg_252_1.onSingleLineUpdate_(arg_255_0)
			local var_255_9000

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				local var_255_0 = arg_252_1.var_.effectlixue1

				if not arg_252_1.var_.effectlixue1 then
					var_255_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in"), manager.ui.mainCamera.transform)
					var_255_0.name = "lixue1"
					arg_252_1.var_.effectlixue1 = var_255_0
				else
					var_255_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_255_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_255_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_255_0.transform.localScale = Vector3.New(var_255_0.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_255_0.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_255_0.transform.localScale.z)
			end

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= 0 + arg_255_0 then
				local var_255_2 = arg_252_1.var_.effectlixue2

				if not arg_252_1.var_.effectlixue2 then
					var_255_2 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_blood_in_ui"), manager.ui.mainCamera.transform)
					var_255_2.name = "lixue2"
					arg_252_1.var_.effectlixue2 = var_255_2
				else
					var_255_2.transform:SetParent(var_255_9000)
				end

				var_255_2.transform.localPosition = Vector3.New(0, 0, 0)
				var_255_2.transform.localRotation = Quaternion.Euler(0, 0, 0)
				var_255_2.transform.localScale = Vector3.New(var_255_2.transform.localScale.x * (Screen.width / Screen.height / 1.7777777777777777), var_255_2.transform.localScale.y * Mathf.Max(1.7777777777777777 / (Screen.width / Screen.height), 1), var_255_2.transform.localScale.z)
			end

			local var_255_4 = 0

			if 0 < arg_252_1.time_ and arg_252_1.time_ <= var_255_4 + arg_255_0 then
				arg_252_1.allBtn_.enabled = false
			end

			if arg_252_1.time_ >= var_255_4 + 2.299999999999 and arg_252_1.time_ < var_255_4 + 2.299999999999 + arg_255_0 then
				arg_252_1.allBtn_.enabled = true
			end

			if arg_252_1.frameCnt_ <= 1 then
				arg_252_1.dialog_:SetActive(false)
			end

			local var_255_5 = 1.299999999999
			local var_255_6 = 1

			if 1.299999999999 < arg_252_1.time_ and arg_252_1.time_ <= var_255_5 + arg_255_0 then
				arg_252_1.talkMaxDuration = 0

				arg_252_1.dialog_:SetActive(true)

				arg_252_1.dialogCg_.alpha = 0

				local var_255_7 = LeanTween.value(arg_252_1.dialog_, 0, 1, 0.3)

				var_255_7:setOnUpdate(LuaHelper.FloatAction(function(arg_256_0)
					arg_252_1.dialogCg_.alpha = arg_256_0
				end))
				var_255_7:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_252_1.dialog_)
					var_255_7:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_252_1.duration_ = arg_252_1.duration_ + 0.3

				SetActive(arg_252_1.leftNameGo_, false)

				arg_252_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_252_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_252_1:RecordName(arg_252_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_252_1.iconTrs_.gameObject, false)
				arg_252_1.callingController_:SetSelectedState("normal")

				local var_255_8 = arg_252_1:FormatText(arg_252_1:GetWordFromCfg(303032061).content)

				arg_252_1.text_.text = var_255_8

				LuaForUtil.ClearLinePrefixSymbol(arg_252_1.text_)

				local var_255_10 = 40 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 40)

				if (40 <= 0 and var_255_6 or var_255_6 * (utf8.len(var_255_8) / 40)) > 0 and var_255_6 < var_255_10 then
					arg_252_1.talkMaxDuration = var_255_10
					var_255_5 = var_255_5 + 0.3

					if var_255_10 + var_255_5 > arg_252_1.duration_ then
						arg_252_1.duration_ = var_255_10 + var_255_5
					end
				end

				arg_252_1.text_.text = var_255_8
				arg_252_1.typewritter.percent = 0

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(false)
				arg_252_1:RecordContent(arg_252_1.text_.text)
			end

			local var_255_11 = var_255_5 + 0.3
			local var_255_12 = math.max(var_255_6, arg_252_1.talkMaxDuration)

			if var_255_5 + 0.3 <= arg_252_1.time_ and arg_252_1.time_ < var_255_11 + var_255_12 then
				arg_252_1.typewritter.percent = (arg_252_1.time_ - var_255_11) / var_255_12

				arg_252_1.typewritter:SetDirty()
			end

			if arg_252_1.time_ >= var_255_11 + var_255_12 and arg_252_1.time_ < var_255_11 + var_255_12 + arg_255_0 then
				arg_252_1.typewritter.percent = 1

				arg_252_1.typewritter:SetDirty()
				arg_252_1:ShowNextGo(true)
			end
		end

		arg_252_1.nodeConfigList_ = {}

		arg_252_1:InitPlayNodeList()
	end,
	Play303032062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 303032062
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
			arg_258_1.auto_ = false
		end

		function arg_258_1.playNext_(arg_260_0)
			arg_258_1.onStoryFinished_()
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			local var_261_0 = 1.45

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, false)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_1 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(303032062).content)

				arg_258_1.text_.text = var_261_1

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_3 = 58 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 58)

				if (58 <= 0 and var_261_0 or var_261_0 * (utf8.len(var_261_1) / 58)) > 0 and var_261_0 < var_261_3 then
					arg_258_1.talkMaxDuration = var_261_3

					if var_261_3 + 0 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_3 + 0
					end
				end

				arg_258_1.text_.text = var_261_1
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_4 = math.max(var_261_0, arg_258_1.talkMaxDuration)

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - 0) / var_261_4

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B10c",
		"TextureConfig/Background/B15f",
		"TextureConfig/Background/I28f"
	},
	voices = {
		"story_v_out_303032.awb"
	}
}
