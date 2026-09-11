return {
	Play112171001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 112171001
		arg_1_1.duration_ = 4.8

		local var_1_0 = {
			ja = 3.799999999999,
			ko = 4.8,
			zh = 3.866,
			en = 4.133
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
				arg_1_0:Play112171002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.H04 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "H04")
				var_4_0.name = "H04"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.H04 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.H04

				arg_1_1.bgs_.H04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "H04" then
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

			local var_4_8 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1084ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_4_14 = arg_1_1.actors_["1084ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_19 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_2_1_summer2_story_general", "bgm_activity_1_2_1_summer2_story_general")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_22 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_22

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_22
						arg_1_1.bgmTxt2_.text = var_4_22
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

			local var_4_23 = 2
			local var_4_24 = 0.25

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(112171001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 10 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 10)

				if (10 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 10)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171001", "story_v_out_112171.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_112171", "112171001", "story_v_out_112171.awb") / 1000

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_112171", "112171001", "story_v_out_112171.awb")

						arg_1_1:RecordAudio("112171001", var_4_30)
						arg_1_1:RecordAudio("112171001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_112171", "112171001", "story_v_out_112171.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_112171", "112171001", "story_v_out_112171.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = math.max(var_4_24, arg_1_1.talkMaxDuration)

			if var_4_23 <= arg_1_1.time_ and arg_1_1.time_ < var_4_23 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_23) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_23 + var_4_31 and arg_1_1.time_ < var_4_23 + var_4_31 + arg_4_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play112171002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 112171002
		arg_7_1.duration_ = 7.2

		local var_7_0 = {
			ja = 7.2,
			ko = 4.933,
			zh = 3.533,
			en = 5.166
		}
		local var_7_1 = manager.audio:GetLocalizationFlag()

		if var_7_0[var_7_1] ~= nil then
			arg_7_1.duration_ = var_7_0[var_7_1]
		end

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play112171003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(arg_7_1.actors_["1084ui_story"]) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = arg_7_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_0 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_0 and not isNil(arg_7_1.actors_["1084ui_story"]) then
				if arg_7_1.var_.characterEffect1084ui_story and not isNil(arg_7_1.actors_["1084ui_story"]) then
					arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_0)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_0 and arg_7_1.time_ < 0 + var_10_0 + arg_10_0 and not isNil(arg_7_1.actors_["1084ui_story"]) and arg_7_1.var_.characterEffect1084ui_story then
				arg_7_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_10_1 = "1148ui_story"

			if arg_7_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_10_2 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_7_1.stage_.transform)

				var_10_2.name = var_10_1
				var_10_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_[var_10_1] = var_10_2

				local var_10_3 = var_10_2:GetComponentInChildren(typeof(CharacterEffect))

				var_10_3.enabled = true

				local var_10_4 = GameObjectTools.GetOrAddComponent(var_10_2, typeof(DynamicBoneHelper))

				if var_10_4 then
					var_10_4:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_3.transform, false)

				arg_7_1.var_[var_10_1 .. "Animator"] = var_10_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_[var_10_1 .. "Animator"].applyRootMotion = true
				arg_7_1.var_[var_10_1 .. "LipSync"] = var_10_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_5 = arg_7_1.actors_["1148ui_story"].transform

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1.var_.moveOldPos1148ui_story = var_10_5.localPosition
			end

			local var_10_6 = 0.001

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 then
				var_10_5.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1148ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_7_1.time_ - 0) / var_10_6)
				var_10_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_5.position).x, (manager.ui.mainCamera.transform.position - var_10_5.position).y, (manager.ui.mainCamera.transform.position - var_10_5.position).z)
				var_10_5.localEulerAngles.z = 0
				var_10_5.localEulerAngles.x = 0
				var_10_5.localEulerAngles = var_10_5.localEulerAngles
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 then
				var_10_5.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_10_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_5.position).x, (manager.ui.mainCamera.transform.position - var_10_5.position).y, (manager.ui.mainCamera.transform.position - var_10_5.position).z)
				var_10_5.localEulerAngles.z = 0
				var_10_5.localEulerAngles.x = 0
				var_10_5.localEulerAngles = var_10_5.localEulerAngles
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action9_1")
			end

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 then
				arg_7_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_10_7 = arg_7_1.actors_["1148ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_7) and arg_7_1.var_.characterEffect1148ui_story == nil then
				arg_7_1.var_.characterEffect1148ui_story = var_10_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_8 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_8 and not isNil(var_10_7) then
				if arg_7_1.var_.characterEffect1148ui_story and not isNil(var_10_7) then
					arg_7_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_8 and arg_7_1.time_ < 0 + var_10_8 + arg_10_0 and not isNil(var_10_7) and arg_7_1.var_.characterEffect1148ui_story then
				arg_7_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_10_10 = 0
			local var_10_11 = 0.525

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_10 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_12 = arg_7_1:GetWordFromCfg(112171002)
				local var_10_13 = arg_7_1:FormatText(var_10_12.content)

				arg_7_1.text_.text = var_10_13

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_15 = 21 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_13) / 21)

				if (21 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_13) / 21)) > 0 and var_10_11 < var_10_15 then
					arg_7_1.talkMaxDuration = var_10_15

					if var_10_15 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_15 + var_10_10
					end
				end

				arg_7_1.text_.text = var_10_13
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171002", "story_v_out_112171.awb") ~= 0 then
					local var_10_16 = manager.audio:GetVoiceLength("story_v_out_112171", "112171002", "story_v_out_112171.awb") / 1000

					if var_10_16 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_16 + var_10_10
					end

					if var_10_12.prefab_name ~= "" and arg_7_1.actors_[var_10_12.prefab_name] ~= nil then
						local var_10_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_12.prefab_name].transform, "story_v_out_112171", "112171002", "story_v_out_112171.awb")

						arg_7_1:RecordAudio("112171002", var_10_17)
						arg_7_1:RecordAudio("112171002", var_10_17)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_112171", "112171002", "story_v_out_112171.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_112171", "112171002", "story_v_out_112171.awb")
				end

				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_18 = math.max(var_10_11, arg_7_1.talkMaxDuration)

			if var_10_10 <= arg_7_1.time_ and arg_7_1.time_ < var_10_10 + var_10_18 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_10) / var_10_18

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_10 + var_10_18 and arg_7_1.time_ < var_10_10 + var_10_18 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end

		arg_7_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play112171003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 112171003
		arg_11_1.duration_ = 3.9

		local var_11_0 = {
			ja = 3.9,
			ko = 2.8,
			zh = 2.633,
			en = 3.7
		}
		local var_11_1 = manager.audio:GetLocalizationFlag()

		if var_11_0[var_11_1] ~= nil then
			arg_11_1.duration_ = var_11_0[var_11_1]
		end

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play112171004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1148ui_story = arg_11_1.actors_["1148ui_story"].transform.localPosition
			end

			local var_14_0 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_0 then
				arg_11_1.actors_["1148ui_story"].transform.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_0)
				arg_11_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).z)
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles = arg_11_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_0 and arg_11_1.time_ < 0 + var_14_0 + arg_14_0 then
				arg_11_1.actors_["1148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_["1148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_11_1.actors_["1148ui_story"].transform.position).z)
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.z = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles.x = 0
				arg_11_1.actors_["1148ui_story"].transform.localEulerAngles = arg_11_1.actors_["1148ui_story"].transform.localEulerAngles
			end

			local var_14_1 = arg_11_1.actors_["1084ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1084ui_story = var_14_1.localPosition
			end

			local var_14_2 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_2 then
				var_14_1.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_11_1.time_ - 0) / var_14_2)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_2 and arg_11_1.time_ < 0 + var_14_2 + arg_14_0 then
				var_14_1.localPosition = Vector3.New(0, 100, 0)
				var_14_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_1.position).x, (manager.ui.mainCamera.transform.position - var_14_1.position).y, (manager.ui.mainCamera.transform.position - var_14_1.position).z)
				var_14_1.localEulerAngles.z = 0
				var_14_1.localEulerAngles.x = 0
				var_14_1.localEulerAngles = var_14_1.localEulerAngles
			end

			local var_14_3 = "1081ui_story"

			if arg_11_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_14_4 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_11_1.stage_.transform)

				var_14_4.name = var_14_3
				var_14_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_11_1.actors_[var_14_3] = var_14_4

				local var_14_5 = var_14_4:GetComponentInChildren(typeof(CharacterEffect))

				var_14_5.enabled = true

				local var_14_6 = GameObjectTools.GetOrAddComponent(var_14_4, typeof(DynamicBoneHelper))

				if var_14_6 then
					var_14_6:EnableDynamicBone(false)
				end

				arg_11_1:ShowWeapon(var_14_5.transform, false)

				arg_11_1.var_[var_14_3 .. "Animator"] = var_14_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_11_1.var_[var_14_3 .. "Animator"].applyRootMotion = true
				arg_11_1.var_[var_14_3 .. "LipSync"] = var_14_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_14_7 = arg_11_1.actors_["1081ui_story"].transform

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1.var_.moveOldPos1081ui_story = var_14_7.localPosition
			end

			local var_14_8 = 0.001

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_8 then
				var_14_7.localPosition = Vector3.Lerp(arg_11_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_11_1.time_ - 0) / var_14_8)
				var_14_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_7.position).x, (manager.ui.mainCamera.transform.position - var_14_7.position).y, (manager.ui.mainCamera.transform.position - var_14_7.position).z)
				var_14_7.localEulerAngles.z = 0
				var_14_7.localEulerAngles.x = 0
				var_14_7.localEulerAngles = var_14_7.localEulerAngles
			end

			if arg_11_1.time_ >= 0 + var_14_8 and arg_11_1.time_ < 0 + var_14_8 + arg_14_0 then
				var_14_7.localPosition = Vector3.New(0, -0.92, -5.8)
				var_14_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_14_7.position).x, (manager.ui.mainCamera.transform.position - var_14_7.position).y, (manager.ui.mainCamera.transform.position - var_14_7.position).z)
				var_14_7.localEulerAngles.z = 0
				var_14_7.localEulerAngles.x = 0
				var_14_7.localEulerAngles = var_14_7.localEulerAngles
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action1_1")
			end

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 then
				arg_11_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_14_9 = arg_11_1.actors_["1081ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_9) and arg_11_1.var_.characterEffect1081ui_story == nil then
				arg_11_1.var_.characterEffect1081ui_story = var_14_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_10 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_10 and not isNil(var_14_9) then
				if arg_11_1.var_.characterEffect1081ui_story and not isNil(var_14_9) then
					arg_11_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_10 and arg_11_1.time_ < 0 + var_14_10 + arg_14_0 and not isNil(var_14_9) and arg_11_1.var_.characterEffect1081ui_story then
				arg_11_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_14_12 = 0
			local var_14_13 = 0.35

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_12 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_14 = arg_11_1:GetWordFromCfg(112171003)
				local var_14_15 = arg_11_1:FormatText(var_14_14.content)

				arg_11_1.text_.text = var_14_15

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_17 = 14 <= 0 and var_14_13 or var_14_13 * (utf8.len(var_14_15) / 14)

				if (14 <= 0 and var_14_13 or var_14_13 * (utf8.len(var_14_15) / 14)) > 0 and var_14_13 < var_14_17 then
					arg_11_1.talkMaxDuration = var_14_17

					if var_14_17 + var_14_12 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_17 + var_14_12
					end
				end

				arg_11_1.text_.text = var_14_15
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171003", "story_v_out_112171.awb") ~= 0 then
					local var_14_18 = manager.audio:GetVoiceLength("story_v_out_112171", "112171003", "story_v_out_112171.awb") / 1000

					if var_14_18 + var_14_12 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_18 + var_14_12
					end

					if var_14_14.prefab_name ~= "" and arg_11_1.actors_[var_14_14.prefab_name] ~= nil then
						local var_14_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_14.prefab_name].transform, "story_v_out_112171", "112171003", "story_v_out_112171.awb")

						arg_11_1:RecordAudio("112171003", var_14_19)
						arg_11_1:RecordAudio("112171003", var_14_19)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_112171", "112171003", "story_v_out_112171.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_112171", "112171003", "story_v_out_112171.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_20 = math.max(var_14_13, arg_11_1.talkMaxDuration)

			if var_14_12 <= arg_11_1.time_ and arg_11_1.time_ < var_14_12 + var_14_20 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_12) / var_14_20

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_12 + var_14_20 and arg_11_1.time_ < var_14_12 + var_14_20 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_11_1:InitPlayNodeList()
	end,
	Play112171004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 112171004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play112171005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 then
				arg_15_1.var_.moveOldPos1081ui_story = arg_15_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 then
				arg_15_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 0) / var_18_0)
				arg_15_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1081ui_story"].transform.position).z)
				arg_15_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1081ui_story"].transform.localEulerAngles = arg_15_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1081ui_story"].transform.position).z)
				arg_15_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1081ui_story"].transform.localEulerAngles = arg_15_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			local var_18_1 = 0
			local var_18_2 = 0.8

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(112171004).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 32 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 32)

				if (32 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 32)) > 0 and var_18_2 < var_18_5 then
					arg_15_1.talkMaxDuration = var_18_5

					if var_18_5 + var_18_1 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_5 + var_18_1
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_6 = math.max(var_18_2, arg_15_1.talkMaxDuration)

			if var_18_1 <= arg_15_1.time_ and arg_15_1.time_ < var_18_1 + var_18_6 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_1) / var_18_6

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_1 + var_18_6 and arg_15_1.time_ < var_18_1 + var_18_6 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play112171005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 112171005
		arg_19_1.duration_ = 5

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play112171006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0.65

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, false)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_1 = arg_19_1:FormatText(arg_19_1:GetWordFromCfg(112171005).content)

				arg_19_1.text_.text = var_22_1

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_3 = 26 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 26)

				if (26 <= 0 and var_22_0 or var_22_0 * (utf8.len(var_22_1) / 26)) > 0 and var_22_0 < var_22_3 then
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
	Play112171006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 112171006
		arg_23_1.duration_ = 2.6

		local var_23_0 = {
			ja = 2.6,
			ko = 2.266,
			zh = 2.3,
			en = 2.566
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
				arg_23_0:Play112171007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0.175

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, true)
				arg_23_1.iconController_:SetSelectedState("hero")

				arg_23_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1081")

				arg_23_1.callingController_:SetSelectedState("normal")

				arg_23_1.keyicon_.color = Color.New(1, 1, 1)
				arg_23_1.icon_.color = Color.New(1, 1, 1)

				local var_26_1 = arg_23_1:GetWordFromCfg(112171006)
				local var_26_2 = arg_23_1:FormatText(var_26_1.content)

				arg_23_1.text_.text = var_26_2

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_4 = 7 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 7)

				if (7 <= 0 and var_26_0 or var_26_0 * (utf8.len(var_26_2) / 7)) > 0 and var_26_0 < var_26_4 then
					arg_23_1.talkMaxDuration = var_26_4

					if var_26_4 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_4 + 0
					end
				end

				arg_23_1.text_.text = var_26_2
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171006", "story_v_out_112171.awb") ~= 0 then
					local var_26_5 = manager.audio:GetVoiceLength("story_v_out_112171", "112171006", "story_v_out_112171.awb") / 1000

					if var_26_5 + 0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_5 + 0
					end

					if var_26_1.prefab_name ~= "" and arg_23_1.actors_[var_26_1.prefab_name] ~= nil then
						local var_26_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_1.prefab_name].transform, "story_v_out_112171", "112171006", "story_v_out_112171.awb")

						arg_23_1:RecordAudio("112171006", var_26_6)
						arg_23_1:RecordAudio("112171006", var_26_6)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_112171", "112171006", "story_v_out_112171.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_112171", "112171006", "story_v_out_112171.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_7 = math.max(var_26_0, arg_23_1.talkMaxDuration)

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_7 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - 0) / var_26_7

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= 0 + var_26_7 and arg_23_1.time_ < 0 + var_26_7 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play112171007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 112171007
		arg_27_1.duration_ = 7.6

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play112171008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_30_0 = 1

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				local var_30_1, var_30_2 = math.modf((arg_27_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_30_2 * 0.13, var_30_2 * 0.13, var_30_2 * 0.13) + arg_27_1.var_.shakeOldPos
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				manager.ui.mainCamera.transform.localPosition = arg_27_1.var_.shakeOldPos
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				local var_30_3 = arg_27_1.bgs_.H04:GetComponent("SpriteRenderer")

				if var_30_3 then
					arg_27_1.var_.alphaOldValueH04 = var_30_3.color.a
					arg_27_1.var_.alphaMatValueH04 = var_30_3
				end

				arg_27_1.var_.alphaOldValueH04 = 1
			end

			local var_30_4 = 2

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_4 then
				if arg_27_1.var_.alphaMatValueH04 then
					arg_27_1.var_.alphaMatValueH04.color.a = Mathf.Lerp(arg_27_1.var_.alphaOldValueH04, 0, (arg_27_1.time_ - 0) / var_30_4)
					arg_27_1.var_.alphaMatValueH04.color = arg_27_1.var_.alphaMatValueH04.color
				end
			end

			if arg_27_1.time_ >= 0 + var_30_4 and arg_27_1.time_ < 0 + var_30_4 + arg_30_0 and arg_27_1.var_.alphaMatValueH04 then
				arg_27_1.var_.alphaMatValueH04.color.a = 0
				arg_27_1.var_.alphaMatValueH04.color = arg_27_1.var_.alphaMatValueH04.color
			end

			local var_30_5 = 0

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_5 + arg_30_0 then
				arg_27_1.allBtn_.enabled = false
			end

			if arg_27_1.time_ >= var_30_5 + 2.6 and arg_27_1.time_ < var_30_5 + 2.6 + arg_30_0 then
				arg_27_1.allBtn_.enabled = true
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:AudioAction("play", "effect", "se_story_activity_1_2_1", "se_story_activity_1_2_1_huge_waves02", "")
			end

			if arg_27_1.frameCnt_ <= 1 then
				arg_27_1.dialog_:SetActive(false)
			end

			local var_30_7 = 2.6
			local var_30_8 = 0.475

			if 2.6 < arg_27_1.time_ and arg_27_1.time_ <= var_30_7 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				arg_27_1.dialog_:SetActive(true)

				arg_27_1.dialogCg_.alpha = 0

				local var_30_9 = LeanTween.value(arg_27_1.dialog_, 0, 1, 0.3)

				var_30_9:setOnUpdate(LuaHelper.FloatAction(function(arg_31_0)
					arg_27_1.dialogCg_.alpha = arg_31_0
				end))
				var_30_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_27_1.dialog_)
					var_30_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_27_1.duration_ = arg_27_1.duration_ + 0.3

				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_10 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(112171007).content)

				arg_27_1.text_.text = var_30_10

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_12 = 19 <= 0 and var_30_8 or var_30_8 * (utf8.len(var_30_10) / 19)

				if (19 <= 0 and var_30_8 or var_30_8 * (utf8.len(var_30_10) / 19)) > 0 and var_30_8 < var_30_12 then
					arg_27_1.talkMaxDuration = var_30_12
					var_30_7 = var_30_7 + 0.3

					if var_30_12 + var_30_7 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_12 + var_30_7
					end
				end

				arg_27_1.text_.text = var_30_10
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_13 = var_30_7 + 0.3
			local var_30_14 = math.max(var_30_8, arg_27_1.talkMaxDuration)

			if var_30_7 + 0.3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_13 + var_30_14 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_13) / var_30_14

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_13 + var_30_14 and arg_27_1.time_ < var_30_13 + var_30_14 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {}

		arg_27_1:InitPlayNodeList()
	end,
	Play112171008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 112171008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play112171009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("play", "effect", "se_story_activity_1_2_1", "se_story_activity_1_2_1_whale", "")
			end

			local var_36_1 = 0
			local var_36_2 = 1.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_1 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_3 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(112171008).content)

				arg_33_1.text_.text = var_36_3

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_5 = 45 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 45)

				if (45 <= 0 and var_36_2 or var_36_2 * (utf8.len(var_36_3) / 45)) > 0 and var_36_2 < var_36_5 then
					arg_33_1.talkMaxDuration = var_36_5

					if var_36_5 + var_36_1 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_5 + var_36_1
					end
				end

				arg_33_1.text_.text = var_36_3
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_6 = math.max(var_36_2, arg_33_1.talkMaxDuration)

			if var_36_1 <= arg_33_1.time_ and arg_33_1.time_ < var_36_1 + var_36_6 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_1) / var_36_6

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_1 + var_36_6 and arg_33_1.time_ < var_36_1 + var_36_6 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play112171009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 112171009
		arg_37_1.duration_ = 7

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play112171010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if arg_37_1.bgs_.SA0108 == nil then
				local var_40_0 = Object.Instantiate(arg_37_1.paintGo_)

				var_40_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SA0108")
				var_40_0.name = "SA0108"
				var_40_0.transform.parent = arg_37_1.stage_.transform
				var_40_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_37_1.bgs_.SA0108 = var_40_0
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_1 = arg_37_1.bgs_.SA0108

				arg_37_1.bgs_.SA0108.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_2 = var_40_1:GetComponent("SpriteRenderer")

				if var_40_2 and var_40_2.sprite then
					local var_40_3 = 2 * (var_40_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_1.transform.localScale = Vector3.New(var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, var_40_3 / var_40_2.sprite.bounds.size.y < var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x and var_40_3 * manager.ui.mainCameraCom_.aspect / var_40_2.sprite.bounds.size.x or var_40_3 / var_40_2.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "SA0108" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_4 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_5 = 2

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_5 then
				local var_40_6 = Color.New(1, 1, 1)

				var_40_6.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_4) / var_40_5)
				arg_37_1.mask_.color = var_40_6
			end

			if arg_37_1.time_ >= var_40_4 + var_40_5 and arg_37_1.time_ < var_40_4 + var_40_5 + arg_40_0 then
				local var_40_7 = Color.New(1, 1, 1)

				arg_37_1.mask_.enabled = false
				var_40_7.a = 0
				arg_37_1.mask_.color = var_40_7
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				local var_40_8 = arg_37_1.bgs_.H04:GetComponent("SpriteRenderer")

				if var_40_8 then
					arg_37_1.var_.alphaOldValueH04 = var_40_8.color.a
					arg_37_1.var_.alphaMatValueH04 = var_40_8
				end

				arg_37_1.var_.alphaOldValueH04 = 0
			end

			local var_40_9 = 0.0166666666666667

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_9 then
				if arg_37_1.var_.alphaMatValueH04 then
					arg_37_1.var_.alphaMatValueH04.color.a = Mathf.Lerp(arg_37_1.var_.alphaOldValueH04, 1, (arg_37_1.time_ - 0) / var_40_9)
					arg_37_1.var_.alphaMatValueH04.color = arg_37_1.var_.alphaMatValueH04.color
				end
			end

			if arg_37_1.time_ >= 0 + var_40_9 and arg_37_1.time_ < 0 + var_40_9 + arg_40_0 and arg_37_1.var_.alphaMatValueH04 then
				arg_37_1.var_.alphaMatValueH04.color.a = 1
				arg_37_1.var_.alphaMatValueH04.color = arg_37_1.var_.alphaMatValueH04.color
			end

			if arg_37_1.frameCnt_ <= 1 then
				arg_37_1.dialog_:SetActive(false)
			end

			local var_40_10 = 2
			local var_40_11 = 0.625

			if 2 < arg_37_1.time_ and arg_37_1.time_ <= var_40_10 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0

				arg_37_1.dialog_:SetActive(true)

				arg_37_1.dialogCg_.alpha = 0

				local var_40_12 = LeanTween.value(arg_37_1.dialog_, 0, 1, 0.3)

				var_40_12:setOnUpdate(LuaHelper.FloatAction(function(arg_41_0)
					arg_37_1.dialogCg_.alpha = arg_41_0
				end))
				var_40_12:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_37_1.dialog_)
					var_40_12:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_37_1.duration_ = arg_37_1.duration_ + 0.3

				SetActive(arg_37_1.leftNameGo_, false)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_13 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(112171009).content)

				arg_37_1.text_.text = var_40_13

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_15 = 25 <= 0 and var_40_11 or var_40_11 * (utf8.len(var_40_13) / 25)

				if (25 <= 0 and var_40_11 or var_40_11 * (utf8.len(var_40_13) / 25)) > 0 and var_40_11 < var_40_15 then
					arg_37_1.talkMaxDuration = var_40_15
					var_40_10 = var_40_10 + 0.3

					if var_40_15 + var_40_10 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_15 + var_40_10
					end
				end

				arg_37_1.text_.text = var_40_13
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_16 = var_40_10 + 0.3
			local var_40_17 = math.max(var_40_11, arg_37_1.talkMaxDuration)

			if var_40_10 + 0.3 <= arg_37_1.time_ and arg_37_1.time_ < var_40_16 + var_40_17 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_16) / var_40_17

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_16 + var_40_17 and arg_37_1.time_ < var_40_16 + var_40_17 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play112171010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 112171010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play112171011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0.925

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, false)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_1 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(112171010).content)

				arg_43_1.text_.text = var_46_1

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_3 = 37 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 37)

				if (37 <= 0 and var_46_0 or var_46_0 * (utf8.len(var_46_1) / 37)) > 0 and var_46_0 < var_46_3 then
					arg_43_1.talkMaxDuration = var_46_3

					if var_46_3 + 0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_3 + 0
					end
				end

				arg_43_1.text_.text = var_46_1
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_4 = math.max(var_46_0, arg_43_1.talkMaxDuration)

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - 0) / var_46_4

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play112171011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 112171011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play112171012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:AudioAction("play", "effect", "se_story_activity_1_2_1", "se_story_activity_1_2_1_huge_waves03", "")
			end

			local var_50_1 = 0
			local var_50_2 = 0.825

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, false)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(112171011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 33 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 33)

				if (33 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 33)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play112171012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 112171012
		arg_51_1.duration_ = 3.57

		local var_51_0 = {
			ja = 3.566,
			ko = 3.366,
			zh = 1.933,
			en = 2.8
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
				arg_51_0:Play112171013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.175

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1127")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:GetWordFromCfg(112171012)
				local var_54_2 = arg_51_1:FormatText(var_54_1.content)

				arg_51_1.text_.text = var_54_2

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_4 = 7 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 7)

				if (7 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_2) / 7)) > 0 and var_54_0 < var_54_4 then
					arg_51_1.talkMaxDuration = var_54_4

					if var_54_4 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_4 + 0
					end
				end

				arg_51_1.text_.text = var_54_2
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171012", "story_v_out_112171.awb") ~= 0 then
					local var_54_5 = manager.audio:GetVoiceLength("story_v_out_112171", "112171012", "story_v_out_112171.awb") / 1000

					if var_54_5 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + 0
					end

					if var_54_1.prefab_name ~= "" and arg_51_1.actors_[var_54_1.prefab_name] ~= nil then
						local var_54_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_1.prefab_name].transform, "story_v_out_112171", "112171012", "story_v_out_112171.awb")

						arg_51_1:RecordAudio("112171012", var_54_6)
						arg_51_1:RecordAudio("112171012", var_54_6)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_112171", "112171012", "story_v_out_112171.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_112171", "112171012", "story_v_out_112171.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_7 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_7 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_7

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_7 and arg_51_1.time_ < 0 + var_54_7 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play112171013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 112171013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play112171014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = 0.175

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

				local var_58_1 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(112171013).content)

				arg_55_1.text_.text = var_58_1

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_3 = 7 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 7)

				if (7 <= 0 and var_58_0 or var_58_0 * (utf8.len(var_58_1) / 7)) > 0 and var_58_0 < var_58_3 then
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
	Play112171014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 112171014
		arg_59_1.duration_ = 3.6

		local var_59_0 = {
			ja = 3.033,
			ko = 2.5,
			zh = 2.9,
			en = 3.6
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
				arg_59_0:Play112171015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.25

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_59_1.callingController_:SetSelectedState("normal")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:GetWordFromCfg(112171014)
				local var_62_2 = arg_59_1:FormatText(var_62_1.content)

				arg_59_1.text_.text = var_62_2

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 10 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 10)

				if (10 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_2) / 10)) > 0 and var_62_0 < var_62_4 then
					arg_59_1.talkMaxDuration = var_62_4

					if var_62_4 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_4 + 0
					end
				end

				arg_59_1.text_.text = var_62_2
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171014", "story_v_out_112171.awb") ~= 0 then
					local var_62_5 = manager.audio:GetVoiceLength("story_v_out_112171", "112171014", "story_v_out_112171.awb") / 1000

					if var_62_5 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_5 + 0
					end

					if var_62_1.prefab_name ~= "" and arg_59_1.actors_[var_62_1.prefab_name] ~= nil then
						local var_62_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_1.prefab_name].transform, "story_v_out_112171", "112171014", "story_v_out_112171.awb")

						arg_59_1:RecordAudio("112171014", var_62_6)
						arg_59_1:RecordAudio("112171014", var_62_6)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_112171", "112171014", "story_v_out_112171.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_112171", "112171014", "story_v_out_112171.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play112171015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 112171015
		arg_63_1.duration_ = 7.17

		local var_63_0 = {
			ja = 5.4,
			ko = 5.866,
			zh = 5.366,
			en = 7.166
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play112171016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1148")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:GetWordFromCfg(112171015)
				local var_66_2 = arg_63_1:FormatText(var_66_1.content)

				arg_63_1.text_.text = var_66_2

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_4 = 19 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 19)

				if (19 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_2) / 19)) > 0 and var_66_0 < var_66_4 then
					arg_63_1.talkMaxDuration = var_66_4

					if var_66_4 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_4 + 0
					end
				end

				arg_63_1.text_.text = var_66_2
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171015", "story_v_out_112171.awb") ~= 0 then
					local var_66_5 = manager.audio:GetVoiceLength("story_v_out_112171", "112171015", "story_v_out_112171.awb") / 1000

					if var_66_5 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + 0
					end

					if var_66_1.prefab_name ~= "" and arg_63_1.actors_[var_66_1.prefab_name] ~= nil then
						local var_66_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_1.prefab_name].transform, "story_v_out_112171", "112171015", "story_v_out_112171.awb")

						arg_63_1:RecordAudio("112171015", var_66_6)
						arg_63_1:RecordAudio("112171015", var_66_6)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_112171", "112171015", "story_v_out_112171.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_112171", "112171015", "story_v_out_112171.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_7 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_7 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_7

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_7 and arg_63_1.time_ < 0 + var_66_7 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play112171016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 112171016
		arg_67_1.duration_ = 8.83

		local var_67_0 = {
			ja = 8.1,
			ko = 8.166,
			zh = 7.3,
			en = 8.833
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play112171017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 2 < arg_67_1.time_ and arg_67_1.time_ <= 2 + arg_70_0 then
				local var_70_0 = arg_67_1.bgs_.H04

				arg_67_1.bgs_.H04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_70_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_70_1 = var_70_0:GetComponent("SpriteRenderer")

				if var_70_1 and var_70_1.sprite then
					local var_70_2 = 2 * (var_70_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_70_0.transform.localScale = Vector3.New(var_70_2 / var_70_1.sprite.bounds.size.y < var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x and var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x or var_70_2 / var_70_1.sprite.bounds.size.y, var_70_2 / var_70_1.sprite.bounds.size.y < var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x and var_70_2 * manager.ui.mainCameraCom_.aspect / var_70_1.sprite.bounds.size.x or var_70_2 / var_70_1.sprite.bounds.size.y, 0)
				end

				for iter_70_0, iter_70_1 in pairs(arg_67_1.bgs_) do
					if iter_70_0 ~= "H04" then
						iter_70_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_70_3 = 0

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_3 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_4 = 2

			if var_70_3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_3 + var_70_4 then
				local var_70_5 = Color.New(0, 0, 0)

				var_70_5.a = Mathf.Lerp(0, 1, (arg_67_1.time_ - var_70_3) / var_70_4)
				arg_67_1.mask_.color = var_70_5
			end

			if arg_67_1.time_ >= var_70_3 + var_70_4 and arg_67_1.time_ < var_70_3 + var_70_4 + arg_70_0 then
				local var_70_6 = Color.New(0, 0, 0)

				var_70_6.a = 1
				arg_67_1.mask_.color = var_70_6
			end

			local var_70_7 = 2

			if 2 < arg_67_1.time_ and arg_67_1.time_ <= var_70_7 + arg_70_0 then
				arg_67_1.mask_.enabled = true
				arg_67_1.mask_.raycastTarget = true

				arg_67_1:SetGaussion(false)
			end

			local var_70_8 = 2

			if var_70_7 <= arg_67_1.time_ and arg_67_1.time_ < var_70_7 + var_70_8 then
				local var_70_9 = Color.New(0, 0, 0)

				var_70_9.a = Mathf.Lerp(1, 0, (arg_67_1.time_ - var_70_7) / var_70_8)
				arg_67_1.mask_.color = var_70_9
			end

			if arg_67_1.time_ >= var_70_7 + var_70_8 and arg_67_1.time_ < var_70_7 + var_70_8 + arg_70_0 then
				local var_70_10 = Color.New(0, 0, 0)

				arg_67_1.mask_.enabled = false
				var_70_10.a = 0
				arg_67_1.mask_.color = var_70_10
			end

			local var_70_11 = "1039ui_story"

			if arg_67_1.actors_["1039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1039ui_story"))) then
				local var_70_12 = Object.Instantiate(Asset.Load("Char/" .. "1039ui_story"), arg_67_1.stage_.transform)

				var_70_12.name = var_70_11
				var_70_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_[var_70_11] = var_70_12

				local var_70_13 = var_70_12:GetComponentInChildren(typeof(CharacterEffect))

				var_70_13.enabled = true

				local var_70_14 = GameObjectTools.GetOrAddComponent(var_70_12, typeof(DynamicBoneHelper))

				if var_70_14 then
					var_70_14:EnableDynamicBone(false)
				end

				arg_67_1:ShowWeapon(var_70_13.transform, false)

				arg_67_1.var_[var_70_11 .. "Animator"] = var_70_13.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_67_1.var_[var_70_11 .. "Animator"].applyRootMotion = true
				arg_67_1.var_[var_70_11 .. "LipSync"] = var_70_13.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_70_15 = arg_67_1.actors_["1039ui_story"].transform

			if 3.8 < arg_67_1.time_ and arg_67_1.time_ <= 3.8 + arg_70_0 then
				arg_67_1.var_.moveOldPos1039ui_story = var_70_15.localPosition
			end

			local var_70_16 = 0.001

			if 3.8 <= arg_67_1.time_ and arg_67_1.time_ < 3.8 + var_70_16 then
				var_70_15.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1039ui_story, Vector3.New(-0.7, -1.01, -5.9), (arg_67_1.time_ - 3.8) / var_70_16)
				var_70_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_15.position).x, (manager.ui.mainCamera.transform.position - var_70_15.position).y, (manager.ui.mainCamera.transform.position - var_70_15.position).z)
				var_70_15.localEulerAngles.z = 0
				var_70_15.localEulerAngles.x = 0
				var_70_15.localEulerAngles = var_70_15.localEulerAngles
			end

			if arg_67_1.time_ >= 3.8 + var_70_16 and arg_67_1.time_ < 3.8 + var_70_16 + arg_70_0 then
				var_70_15.localPosition = Vector3.New(-0.7, -1.01, -5.9)
				var_70_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_15.position).x, (manager.ui.mainCamera.transform.position - var_70_15.position).y, (manager.ui.mainCamera.transform.position - var_70_15.position).z)
				var_70_15.localEulerAngles.z = 0
				var_70_15.localEulerAngles.x = 0
				var_70_15.localEulerAngles = var_70_15.localEulerAngles
			end

			if 3.8 < arg_67_1.time_ and arg_67_1.time_ <= 3.8 + arg_70_0 then
				arg_67_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/story1039/story1039action/1039action5_1")
			end

			if 3.8 < arg_67_1.time_ and arg_67_1.time_ <= 3.8 + arg_70_0 then
				arg_67_1:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_70_17 = arg_67_1.actors_["1039ui_story"]

			if 3.8 < arg_67_1.time_ and arg_67_1.time_ <= 3.8 + arg_70_0 and not isNil(var_70_17) and arg_67_1.var_.characterEffect1039ui_story == nil then
				arg_67_1.var_.characterEffect1039ui_story = var_70_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_18 = 0.2

			if 3.8 <= arg_67_1.time_ and arg_67_1.time_ < 3.8 + var_70_18 and not isNil(var_70_17) then
				if arg_67_1.var_.characterEffect1039ui_story and not isNil(var_70_17) then
					arg_67_1.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 3.8 + var_70_18 and arg_67_1.time_ < 3.8 + var_70_18 + arg_70_0 and not isNil(var_70_17) and arg_67_1.var_.characterEffect1039ui_story then
				arg_67_1.var_.characterEffect1039ui_story.fillFlat = false
			end

			if arg_67_1.frameCnt_ <= 1 then
				arg_67_1.dialog_:SetActive(false)
			end

			local var_70_20 = 4
			local var_70_21 = 0.375

			if 4 < arg_67_1.time_ and arg_67_1.time_ <= var_70_20 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0

				arg_67_1.dialog_:SetActive(true)

				arg_67_1.dialogCg_.alpha = 0

				local var_70_22 = LeanTween.value(arg_67_1.dialog_, 0, 1, 0.3)

				var_70_22:setOnUpdate(LuaHelper.FloatAction(function(arg_71_0)
					arg_67_1.dialogCg_.alpha = arg_71_0
				end))
				var_70_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_67_1.dialog_)
					var_70_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_67_1.duration_ = arg_67_1.duration_ + 0.3

				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_23 = arg_67_1:GetWordFromCfg(112171016)
				local var_70_24 = arg_67_1:FormatText(var_70_23.content)

				arg_67_1.text_.text = var_70_24

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_26 = 15 <= 0 and var_70_21 or var_70_21 * (utf8.len(var_70_24) / 15)

				if (15 <= 0 and var_70_21 or var_70_21 * (utf8.len(var_70_24) / 15)) > 0 and var_70_21 < var_70_26 then
					arg_67_1.talkMaxDuration = var_70_26
					var_70_20 = var_70_20 + 0.3

					if var_70_26 + var_70_20 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_26 + var_70_20
					end
				end

				arg_67_1.text_.text = var_70_24
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171016", "story_v_out_112171.awb") ~= 0 then
					local var_70_27 = manager.audio:GetVoiceLength("story_v_out_112171", "112171016", "story_v_out_112171.awb") / 1000

					if var_70_27 + var_70_20 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_27 + var_70_20
					end

					if var_70_23.prefab_name ~= "" and arg_67_1.actors_[var_70_23.prefab_name] ~= nil then
						local var_70_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_23.prefab_name].transform, "story_v_out_112171", "112171016", "story_v_out_112171.awb")

						arg_67_1:RecordAudio("112171016", var_70_28)
						arg_67_1:RecordAudio("112171016", var_70_28)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_112171", "112171016", "story_v_out_112171.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_112171", "112171016", "story_v_out_112171.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_29 = var_70_20 + 0.3
			local var_70_30 = math.max(var_70_21, arg_67_1.talkMaxDuration)

			if var_70_20 + 0.3 <= arg_67_1.time_ and arg_67_1.time_ < var_70_29 + var_70_30 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_29) / var_70_30

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_29 + var_70_30 and arg_67_1.time_ < var_70_29 + var_70_30 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_67_1:InitPlayNodeList()
	end,
	Play112171017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 112171017
		arg_73_1.duration_ = 7.7

		local var_73_0 = {
			ja = 5.033,
			ko = 4.433,
			zh = 6.9,
			en = 7.7
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
				arg_73_0:Play112171018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1039ui_story"]) and arg_73_1.var_.characterEffect1039ui_story == nil then
				arg_73_1.var_.characterEffect1039ui_story = arg_73_1.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1039ui_story"]) then
				if arg_73_1.var_.characterEffect1039ui_story and not isNil(arg_73_1.actors_["1039ui_story"]) then
					arg_73_1.var_.characterEffect1039ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1039ui_story"]) and arg_73_1.var_.characterEffect1039ui_story then
				arg_73_1.var_.characterEffect1039ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			local var_76_1 = "1127ui_story"

			if arg_73_1.actors_["1127ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1127ui_story"))) then
				local var_76_2 = Object.Instantiate(Asset.Load("Char/" .. "1127ui_story"), arg_73_1.stage_.transform)

				var_76_2.name = var_76_1
				var_76_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_73_1.actors_[var_76_1] = var_76_2

				local var_76_3 = var_76_2:GetComponentInChildren(typeof(CharacterEffect))

				var_76_3.enabled = true

				local var_76_4 = GameObjectTools.GetOrAddComponent(var_76_2, typeof(DynamicBoneHelper))

				if var_76_4 then
					var_76_4:EnableDynamicBone(false)
				end

				arg_73_1:ShowWeapon(var_76_3.transform, false)

				arg_73_1.var_[var_76_1 .. "Animator"] = var_76_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_73_1.var_[var_76_1 .. "Animator"].applyRootMotion = true
				arg_73_1.var_[var_76_1 .. "LipSync"] = var_76_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_76_5 = arg_73_1.actors_["1127ui_story"].transform

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.var_.moveOldPos1127ui_story = var_76_5.localPosition
			end

			local var_76_6 = 0.001

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_6 then
				var_76_5.localPosition = Vector3.Lerp(arg_73_1.var_.moveOldPos1127ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_73_1.time_ - 0) / var_76_6)
				var_76_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_5.position).x, (manager.ui.mainCamera.transform.position - var_76_5.position).y, (manager.ui.mainCamera.transform.position - var_76_5.position).z)
				var_76_5.localEulerAngles.z = 0
				var_76_5.localEulerAngles.x = 0
				var_76_5.localEulerAngles = var_76_5.localEulerAngles
			end

			if arg_73_1.time_ >= 0 + var_76_6 and arg_73_1.time_ < 0 + var_76_6 + arg_76_0 then
				var_76_5.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_76_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_76_5.position).x, (manager.ui.mainCamera.transform.position - var_76_5.position).y, (manager.ui.mainCamera.transform.position - var_76_5.position).z)
				var_76_5.localEulerAngles.z = 0
				var_76_5.localEulerAngles.x = 0
				var_76_5.localEulerAngles = var_76_5.localEulerAngles
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1127ui_story", "StoryTimeline/CharAction/story1127/story1127action/1127action6_1")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1127ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_76_7 = arg_73_1.actors_["1127ui_story"]

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1127ui_story == nil then
				arg_73_1.var_.characterEffect1127ui_story = var_76_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_8 = 0.2

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_8 and not isNil(var_76_7) then
				if arg_73_1.var_.characterEffect1127ui_story and not isNil(var_76_7) then
					arg_73_1.var_.characterEffect1127ui_story.fillFlat = false
				end
			end

			if arg_73_1.time_ >= 0 + var_76_8 and arg_73_1.time_ < 0 + var_76_8 + arg_76_0 and not isNil(var_76_7) and arg_73_1.var_.characterEffect1127ui_story then
				arg_73_1.var_.characterEffect1127ui_story.fillFlat = false
			end

			local var_76_10 = 0
			local var_76_11 = 0.525

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_10 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_12 = arg_73_1:GetWordFromCfg(112171017)
				local var_76_13 = arg_73_1:FormatText(var_76_12.content)

				arg_73_1.text_.text = var_76_13

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_15 = 21 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_13) / 21)

				if (21 <= 0 and var_76_11 or var_76_11 * (utf8.len(var_76_13) / 21)) > 0 and var_76_11 < var_76_15 then
					arg_73_1.talkMaxDuration = var_76_15

					if var_76_15 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_15 + var_76_10
					end
				end

				arg_73_1.text_.text = var_76_13
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171017", "story_v_out_112171.awb") ~= 0 then
					local var_76_16 = manager.audio:GetVoiceLength("story_v_out_112171", "112171017", "story_v_out_112171.awb") / 1000

					if var_76_16 + var_76_10 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_16 + var_76_10
					end

					if var_76_12.prefab_name ~= "" and arg_73_1.actors_[var_76_12.prefab_name] ~= nil then
						local var_76_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_12.prefab_name].transform, "story_v_out_112171", "112171017", "story_v_out_112171.awb")

						arg_73_1:RecordAudio("112171017", var_76_17)
						arg_73_1:RecordAudio("112171017", var_76_17)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_112171", "112171017", "story_v_out_112171.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_112171", "112171017", "story_v_out_112171.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_18 = math.max(var_76_11, arg_73_1.talkMaxDuration)

			if var_76_10 <= arg_73_1.time_ and arg_73_1.time_ < var_76_10 + var_76_18 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_10) / var_76_18

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_10 + var_76_18 and arg_73_1.time_ < var_76_10 + var_76_18 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1127ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_73_1:InitPlayNodeList()
	end,
	Play112171018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 112171018
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play112171019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1039ui_story = arg_77_1.actors_["1039ui_story"].transform.localPosition
			end

			local var_80_0 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 then
				arg_77_1.actors_["1039ui_story"].transform.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_0)
				arg_77_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1039ui_story"].transform.position).z)
				arg_77_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1039ui_story"].transform.localEulerAngles = arg_77_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 then
				arg_77_1.actors_["1039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_77_1.actors_["1039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_77_1.actors_["1039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_77_1.actors_["1039ui_story"].transform.position).z)
				arg_77_1.actors_["1039ui_story"].transform.localEulerAngles.z = 0
				arg_77_1.actors_["1039ui_story"].transform.localEulerAngles.x = 0
				arg_77_1.actors_["1039ui_story"].transform.localEulerAngles = arg_77_1.actors_["1039ui_story"].transform.localEulerAngles
			end

			local var_80_1 = arg_77_1.actors_["1127ui_story"].transform

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.var_.moveOldPos1127ui_story = var_80_1.localPosition
			end

			local var_80_2 = 0.001

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_2 then
				var_80_1.localPosition = Vector3.Lerp(arg_77_1.var_.moveOldPos1127ui_story, Vector3.New(0, 100, 0), (arg_77_1.time_ - 0) / var_80_2)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			if arg_77_1.time_ >= 0 + var_80_2 and arg_77_1.time_ < 0 + var_80_2 + arg_80_0 then
				var_80_1.localPosition = Vector3.New(0, 100, 0)
				var_80_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_80_1.position).x, (manager.ui.mainCamera.transform.position - var_80_1.position).y, (manager.ui.mainCamera.transform.position - var_80_1.position).z)
				var_80_1.localEulerAngles.z = 0
				var_80_1.localEulerAngles.x = 0
				var_80_1.localEulerAngles = var_80_1.localEulerAngles
			end

			local var_80_3 = 0
			local var_80_4 = 0.375

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_3 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_5 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(112171018).content)

				arg_77_1.text_.text = var_80_5

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_7 = 15 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 15)

				if (15 <= 0 and var_80_4 or var_80_4 * (utf8.len(var_80_5) / 15)) > 0 and var_80_4 < var_80_7 then
					arg_77_1.talkMaxDuration = var_80_7

					if var_80_7 + var_80_3 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_7 + var_80_3
					end
				end

				arg_77_1.text_.text = var_80_5
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_8 = math.max(var_80_4, arg_77_1.talkMaxDuration)

			if var_80_3 <= arg_77_1.time_ and arg_77_1.time_ < var_80_3 + var_80_8 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_3) / var_80_8

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_3 + var_80_8 and arg_77_1.time_ < var_80_3 + var_80_8 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1127ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_77_1:InitPlayNodeList()
	end,
	Play112171019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 112171019
		arg_81_1.duration_ = 6.5

		local var_81_0 = {
			ja = 6.5,
			ko = 6.5,
			zh = 4.8,
			en = 6.1
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
				arg_81_0:Play112171020(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1081ui_story = arg_81_1.actors_["1081ui_story"].transform.localPosition
			end

			local var_84_0 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 then
				arg_81_1.actors_["1081ui_story"].transform.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1081ui_story, Vector3.New(-0.7, -0.92, -5.8), (arg_81_1.time_ - 0) / var_84_0)
				arg_81_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).z)
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles = arg_81_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 then
				arg_81_1.actors_["1081ui_story"].transform.localPosition = Vector3.New(-0.7, -0.92, -5.8)
				arg_81_1.actors_["1081ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_81_1.actors_["1081ui_story"].transform.position).z)
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.z = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles.x = 0
				arg_81_1.actors_["1081ui_story"].transform.localEulerAngles = arg_81_1.actors_["1081ui_story"].transform.localEulerAngles
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action7_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_84_1 = arg_81_1.actors_["1081ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1081ui_story == nil then
				arg_81_1.var_.characterEffect1081ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.2

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1081ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1081ui_story then
				arg_81_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_84_4 = 0
			local var_84_5 = 0.575

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_4 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_6 = arg_81_1:GetWordFromCfg(112171019)
				local var_84_7 = arg_81_1:FormatText(var_84_6.content)

				arg_81_1.text_.text = var_84_7

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_9 = 23 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 23)

				if (23 <= 0 and var_84_5 or var_84_5 * (utf8.len(var_84_7) / 23)) > 0 and var_84_5 < var_84_9 then
					arg_81_1.talkMaxDuration = var_84_9

					if var_84_9 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_9 + var_84_4
					end
				end

				arg_81_1.text_.text = var_84_7
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171019", "story_v_out_112171.awb") ~= 0 then
					local var_84_10 = manager.audio:GetVoiceLength("story_v_out_112171", "112171019", "story_v_out_112171.awb") / 1000

					if var_84_10 + var_84_4 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_10 + var_84_4
					end

					if var_84_6.prefab_name ~= "" and arg_81_1.actors_[var_84_6.prefab_name] ~= nil then
						local var_84_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_6.prefab_name].transform, "story_v_out_112171", "112171019", "story_v_out_112171.awb")

						arg_81_1:RecordAudio("112171019", var_84_11)
						arg_81_1:RecordAudio("112171019", var_84_11)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_112171", "112171019", "story_v_out_112171.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_112171", "112171019", "story_v_out_112171.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_12 = math.max(var_84_5, arg_81_1.talkMaxDuration)

			if var_84_4 <= arg_81_1.time_ and arg_81_1.time_ < var_84_4 + var_84_12 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_4) / var_84_12

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_4 + var_84_12 and arg_81_1.time_ < var_84_4 + var_84_12 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_81_1:InitPlayNodeList()
	end,
	Play112171020 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 112171020
		arg_85_1.duration_ = 3.93

		local var_85_0 = {
			ja = 3.933,
			ko = 2.1,
			zh = 2.9,
			en = 3.9
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
				arg_85_0:Play112171021(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1081ui_story"]) and arg_85_1.var_.characterEffect1081ui_story == nil then
				arg_85_1.var_.characterEffect1081ui_story = arg_85_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1081ui_story"]) then
				if arg_85_1.var_.characterEffect1081ui_story and not isNil(arg_85_1.actors_["1081ui_story"]) then
					arg_85_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1081ui_story"]) and arg_85_1.var_.characterEffect1081ui_story then
				arg_85_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["1127ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1127ui_story = var_88_1.localPosition
			end

			local var_88_2 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1127ui_story, Vector3.New(0.7, -0.81, -5.8), (arg_85_1.time_ - 0) / var_88_2)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0.7, -0.81, -5.8)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1127ui_story", "StoryTimeline/CharAction/story1127/story1127action/1127action2_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1127ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_88_3 = arg_85_1.actors_["1127ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1127ui_story == nil then
				arg_85_1.var_.characterEffect1127ui_story = var_88_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_4 = 0.2

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_4 and not isNil(var_88_3) then
				if arg_85_1.var_.characterEffect1127ui_story and not isNil(var_88_3) then
					arg_85_1.var_.characterEffect1127ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_4 and arg_85_1.time_ < 0 + var_88_4 + arg_88_0 and not isNil(var_88_3) and arg_85_1.var_.characterEffect1127ui_story then
				arg_85_1.var_.characterEffect1127ui_story.fillFlat = false
			end

			local var_88_6 = 0
			local var_88_7 = 0.2

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_6 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_8 = arg_85_1:GetWordFromCfg(112171020)
				local var_88_9 = arg_85_1:FormatText(var_88_8.content)

				arg_85_1.text_.text = var_88_9

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_11 = 8 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 8)

				if (8 <= 0 and var_88_7 or var_88_7 * (utf8.len(var_88_9) / 8)) > 0 and var_88_7 < var_88_11 then
					arg_85_1.talkMaxDuration = var_88_11

					if var_88_11 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_11 + var_88_6
					end
				end

				arg_85_1.text_.text = var_88_9
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112171", "112171020", "story_v_out_112171.awb") ~= 0 then
					local var_88_12 = manager.audio:GetVoiceLength("story_v_out_112171", "112171020", "story_v_out_112171.awb") / 1000

					if var_88_12 + var_88_6 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_12 + var_88_6
					end

					if var_88_8.prefab_name ~= "" and arg_85_1.actors_[var_88_8.prefab_name] ~= nil then
						local var_88_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_8.prefab_name].transform, "story_v_out_112171", "112171020", "story_v_out_112171.awb")

						arg_85_1:RecordAudio("112171020", var_88_13)
						arg_85_1:RecordAudio("112171020", var_88_13)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_112171", "112171020", "story_v_out_112171.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_112171", "112171020", "story_v_out_112171.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_14 = math.max(var_88_7, arg_85_1.talkMaxDuration)

			if var_88_6 <= arg_85_1.time_ and arg_85_1.time_ < var_88_6 + var_88_14 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_6) / var_88_14

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_6 + var_88_14 and arg_85_1.time_ < var_88_6 + var_88_14 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1127ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_85_1:InitPlayNodeList()
	end,
	Play112171021 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 112171021
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
			arg_89_1.auto_ = false
		end

		function arg_89_1.playNext_(arg_91_0)
			arg_89_1.onStoryFinished_()
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1127ui_story = arg_89_1.actors_["1127ui_story"].transform.localPosition
			end

			local var_92_0 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 then
				arg_89_1.actors_["1127ui_story"].transform.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1127ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_0)
				arg_89_1.actors_["1127ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1127ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1127ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1127ui_story"].transform.position).z)
				arg_89_1.actors_["1127ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1127ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1127ui_story"].transform.localEulerAngles = arg_89_1.actors_["1127ui_story"].transform.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 then
				arg_89_1.actors_["1127ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_89_1.actors_["1127ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_89_1.actors_["1127ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1127ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_89_1.actors_["1127ui_story"].transform.position).z)
				arg_89_1.actors_["1127ui_story"].transform.localEulerAngles.z = 0
				arg_89_1.actors_["1127ui_story"].transform.localEulerAngles.x = 0
				arg_89_1.actors_["1127ui_story"].transform.localEulerAngles = arg_89_1.actors_["1127ui_story"].transform.localEulerAngles
			end

			local var_92_1 = arg_89_1.actors_["1081ui_story"].transform

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.var_.moveOldPos1081ui_story = var_92_1.localPosition
			end

			local var_92_2 = 0.001

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_2 then
				var_92_1.localPosition = Vector3.Lerp(arg_89_1.var_.moveOldPos1081ui_story, Vector3.New(0, 100, 0), (arg_89_1.time_ - 0) / var_92_2)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			if arg_89_1.time_ >= 0 + var_92_2 and arg_89_1.time_ < 0 + var_92_2 + arg_92_0 then
				var_92_1.localPosition = Vector3.New(0, 100, 0)
				var_92_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_92_1.position).x, (manager.ui.mainCamera.transform.position - var_92_1.position).y, (manager.ui.mainCamera.transform.position - var_92_1.position).z)
				var_92_1.localEulerAngles.z = 0
				var_92_1.localEulerAngles.x = 0
				var_92_1.localEulerAngles = var_92_1.localEulerAngles
			end

			local var_92_3 = 0
			local var_92_4 = 1.475

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_3 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_5 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(112171021).content)

				arg_89_1.text_.text = var_92_5

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_7 = 59 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 59)

				if (59 <= 0 and var_92_4 or var_92_4 * (utf8.len(var_92_5) / 59)) > 0 and var_92_4 < var_92_7 then
					arg_89_1.talkMaxDuration = var_92_7

					if var_92_7 + var_92_3 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_7 + var_92_3
					end
				end

				arg_89_1.text_.text = var_92_5
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_8 = math.max(var_92_4, arg_89_1.talkMaxDuration)

			if var_92_3 <= arg_89_1.time_ and arg_89_1.time_ < var_92_3 + var_92_8 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_3) / var_92_8

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_3 + var_92_8 and arg_89_1.time_ < var_92_3 + var_92_8 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1127ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1081ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_89_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/H04",
		"TextureConfig/Background/SA0108"
	},
	voices = {
		"story_v_out_112171.awb"
	}
}
