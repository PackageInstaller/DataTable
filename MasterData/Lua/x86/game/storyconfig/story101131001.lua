return {
	Play113101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113101001
		arg_1_1.duration_ = 6.67

		local var_1_0 = {
			ja = 5.499999999999,
			ko = 6.665999999999,
			zh = 6.299999999999,
			en = 6.099999999999
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
				arg_1_0:Play113101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F03")
				var_4_0.name = "F03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F03

				arg_1_1.bgs_.F03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F03" then
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

			local var_4_8 = "1041ui_story"

			if arg_1_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["1041ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos1041ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_4_14 = arg_1_1.actors_["1041ui_story"]

			if 1.799999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.799999999999 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story == nil then
				arg_1_1.var_.characterEffect1041ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.2

			if 1.799999999999 <= arg_1_1.time_ and arg_1_1.time_ < 1.799999999999 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1041ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.799999999999 + var_4_15 and arg_1_1.time_ < 1.799999999999 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1041ui_story then
				arg_1_1.var_.characterEffect1041ui_story.fillFlat = false
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

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= 1.999999999999 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

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

			local var_4_23 = 1.999999999999
			local var_4_24 = 0.55

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0
				arg_1_1.dialogCg_.alpha = 1

				arg_1_1.dialog_:SetActive(true)
				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(113101001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 22 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 22)

				if (22 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_26) / 22)) > 0 and var_4_24 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28

					if var_4_28 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_23
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101001", "story_v_out_113101.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_113101", "113101001", "story_v_out_113101.awb") / 1000

					if var_4_29 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_23
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_113101", "113101001", "story_v_out_113101.awb")

						arg_1_1:RecordAudio("113101001", var_4_30)
						arg_1_1:RecordAudio("113101001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113101", "113101001", "story_v_out_113101.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113101", "113101001", "story_v_out_113101.awb")
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
				actorName = "1041ui_story",
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
	Play113101002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 113101002
		arg_7_1.duration_ = 7.37

		local var_7_0 = {
			ja = 6.133,
			ko = 7.366,
			zh = 7.266,
			en = 7.066
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
				arg_7_0:Play113101003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			if arg_7_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_10_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_7_1.stage_.transform)

				var_10_0.name = "1084ui_story"
				var_10_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_7_1.actors_["1084ui_story"] = var_10_0

				local var_10_1 = var_10_0:GetComponentInChildren(typeof(CharacterEffect))

				var_10_1.enabled = true

				local var_10_2 = GameObjectTools.GetOrAddComponent(var_10_0, typeof(DynamicBoneHelper))

				if var_10_2 then
					var_10_2:EnableDynamicBone(false)
				end

				arg_7_1:ShowWeapon(var_10_1.transform, false)

				arg_7_1.var_["1084ui_story" .. "Animator"] = var_10_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_7_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_7_1.var_["1084ui_story" .. "LipSync"] = var_10_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_10_3 = arg_7_1.actors_["1084ui_story"].transform

			if 1.00008890058234e-12 < arg_7_1.time_ and arg_7_1.time_ <= 1.00008890058234e-12 + arg_10_0 then
				arg_7_1.var_.moveOldPos1084ui_story = var_10_3.localPosition
			end

			local var_10_4 = 0.001

			if 1.00008890058234e-12 <= arg_7_1.time_ and arg_7_1.time_ < 1.00008890058234e-12 + var_10_4 then
				var_10_3.localPosition = Vector3.Lerp(arg_7_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_7_1.time_ - 1.00008890058234e-12) / var_10_4)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if arg_7_1.time_ >= 1.00008890058234e-12 + var_10_4 and arg_7_1.time_ < 1.00008890058234e-12 + var_10_4 + arg_10_0 then
				var_10_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_10_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_10_3.position).x, (manager.ui.mainCamera.transform.position - var_10_3.position).y, (manager.ui.mainCamera.transform.position - var_10_3.position).z)
				var_10_3.localEulerAngles.z = 0
				var_10_3.localEulerAngles.x = 0
				var_10_3.localEulerAngles = var_10_3.localEulerAngles
			end

			if 1.00008890058234e-12 < arg_7_1.time_ and arg_7_1.time_ <= 1.00008890058234e-12 + arg_10_0 then
				arg_7_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 1.00008890058234e-12 < arg_7_1.time_ and arg_7_1.time_ <= 1.00008890058234e-12 + arg_10_0 then
				arg_7_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_10_5 = arg_7_1.actors_["1084ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1084ui_story == nil then
				arg_7_1.var_.characterEffect1084ui_story = var_10_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_6 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_6 and not isNil(var_10_5) then
				if arg_7_1.var_.characterEffect1084ui_story and not isNil(var_10_5) then
					arg_7_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_7_1.time_ >= 0 + var_10_6 and arg_7_1.time_ < 0 + var_10_6 + arg_10_0 and not isNil(var_10_5) and arg_7_1.var_.characterEffect1084ui_story then
				arg_7_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_10_8 = arg_7_1.actors_["1041ui_story"]

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= 0 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.characterEffect1041ui_story == nil then
				arg_7_1.var_.characterEffect1041ui_story = var_10_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_10_9 = 0.2

			if 0 <= arg_7_1.time_ and arg_7_1.time_ < 0 + var_10_9 and not isNil(var_10_8) then
				if arg_7_1.var_.characterEffect1041ui_story and not isNil(var_10_8) then
					arg_7_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_7_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_7_1.time_ - 0) / var_10_9)
				end
			end

			if arg_7_1.time_ >= 0 + var_10_9 and arg_7_1.time_ < 0 + var_10_9 + arg_10_0 and not isNil(var_10_8) and arg_7_1.var_.characterEffect1041ui_story then
				arg_7_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_7_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_10_10 = 0
			local var_10_11 = 0.725

			if 0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_10 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, true)

				arg_7_1.leftNameTxt_.text = arg_7_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_7_1.leftNameTxt_.transform)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1.leftNameTxt_.text)
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_12 = arg_7_1:GetWordFromCfg(113101002)
				local var_10_13 = arg_7_1:FormatText(var_10_12.content)

				arg_7_1.text_.text = var_10_13

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_15 = 29 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_13) / 29)

				if (29 <= 0 and var_10_11 or var_10_11 * (utf8.len(var_10_13) / 29)) > 0 and var_10_11 < var_10_15 then
					arg_7_1.talkMaxDuration = var_10_15

					if var_10_15 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_15 + var_10_10
					end
				end

				arg_7_1.text_.text = var_10_13
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101002", "story_v_out_113101.awb") ~= 0 then
					local var_10_16 = manager.audio:GetVoiceLength("story_v_out_113101", "113101002", "story_v_out_113101.awb") / 1000

					if var_10_16 + var_10_10 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_16 + var_10_10
					end

					if var_10_12.prefab_name ~= "" and arg_7_1.actors_[var_10_12.prefab_name] ~= nil then
						local var_10_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_7_1.actors_[var_10_12.prefab_name].transform, "story_v_out_113101", "113101002", "story_v_out_113101.awb")

						arg_7_1:RecordAudio("113101002", var_10_17)
						arg_7_1:RecordAudio("113101002", var_10_17)
					else
						arg_7_1:AudioAction("play", "voice", "story_v_out_113101", "113101002", "story_v_out_113101.awb")
					end

					arg_7_1:RecordHistoryTalkVoice("story_v_out_113101", "113101002", "story_v_out_113101.awb")
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
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_7_1:InitPlayNodeList()
	end,
	Play113101003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 113101003
		arg_11_1.duration_ = 2.77

		local var_11_0 = {
			ja = 2.766,
			ko = 2.333,
			zh = 2,
			en = 2.433
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
				arg_11_0:Play113101004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			if 1.00008890058234e-12 < arg_11_1.time_ and arg_11_1.time_ <= 1.00008890058234e-12 + arg_14_0 then
				arg_11_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_14_0 = arg_11_1.actors_["1041ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_0) and arg_11_1.var_.characterEffect1041ui_story == nil then
				arg_11_1.var_.characterEffect1041ui_story = var_14_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_1 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_1 and not isNil(var_14_0) then
				if arg_11_1.var_.characterEffect1041ui_story and not isNil(var_14_0) then
					arg_11_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_11_1.time_ >= 0 + var_14_1 and arg_11_1.time_ < 0 + var_14_1 + arg_14_0 and not isNil(var_14_0) and arg_11_1.var_.characterEffect1041ui_story then
				arg_11_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_14_3 = arg_11_1.actors_["1084ui_story"]

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= 0 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.characterEffect1084ui_story == nil then
				arg_11_1.var_.characterEffect1084ui_story = var_14_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_14_4 = 0.2

			if 0 <= arg_11_1.time_ and arg_11_1.time_ < 0 + var_14_4 and not isNil(var_14_3) then
				if arg_11_1.var_.characterEffect1084ui_story and not isNil(var_14_3) then
					arg_11_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_11_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_11_1.time_ - 0) / var_14_4)
				end
			end

			if arg_11_1.time_ >= 0 + var_14_4 and arg_11_1.time_ < 0 + var_14_4 + arg_14_0 and not isNil(var_14_3) and arg_11_1.var_.characterEffect1084ui_story then
				arg_11_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_11_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_14_5 = 0
			local var_14_6 = 0.2

			if 0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_5 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, true)

				arg_11_1.leftNameTxt_.text = arg_11_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_11_1.leftNameTxt_.transform)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1.leftNameTxt_.text)
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_7 = arg_11_1:GetWordFromCfg(113101003)
				local var_14_8 = arg_11_1:FormatText(var_14_7.content)

				arg_11_1.text_.text = var_14_8

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_10 = 8 <= 0 and var_14_6 or var_14_6 * (utf8.len(var_14_8) / 8)

				if (8 <= 0 and var_14_6 or var_14_6 * (utf8.len(var_14_8) / 8)) > 0 and var_14_6 < var_14_10 then
					arg_11_1.talkMaxDuration = var_14_10

					if var_14_10 + var_14_5 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_10 + var_14_5
					end
				end

				arg_11_1.text_.text = var_14_8
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101003", "story_v_out_113101.awb") ~= 0 then
					local var_14_11 = manager.audio:GetVoiceLength("story_v_out_113101", "113101003", "story_v_out_113101.awb") / 1000

					if var_14_11 + var_14_5 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_11 + var_14_5
					end

					if var_14_7.prefab_name ~= "" and arg_11_1.actors_[var_14_7.prefab_name] ~= nil then
						local var_14_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_11_1.actors_[var_14_7.prefab_name].transform, "story_v_out_113101", "113101003", "story_v_out_113101.awb")

						arg_11_1:RecordAudio("113101003", var_14_12)
						arg_11_1:RecordAudio("113101003", var_14_12)
					else
						arg_11_1:AudioAction("play", "voice", "story_v_out_113101", "113101003", "story_v_out_113101.awb")
					end

					arg_11_1:RecordHistoryTalkVoice("story_v_out_113101", "113101003", "story_v_out_113101.awb")
				end

				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_13 = math.max(var_14_6, arg_11_1.talkMaxDuration)

			if var_14_5 <= arg_11_1.time_ and arg_11_1.time_ < var_14_5 + var_14_13 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_5) / var_14_13

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_5 + var_14_13 and arg_11_1.time_ < var_14_5 + var_14_13 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end

		arg_11_1.nodeConfigList_ = {}

		arg_11_1:InitPlayNodeList()
	end,
	Play113101004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 113101004
		arg_15_1.duration_ = 8.83

		local var_15_0 = {
			ja = 8.833,
			ko = 4.666,
			zh = 4.666,
			en = 5.9
		}
		local var_15_1 = manager.audio:GetLocalizationFlag()

		if var_15_0[var_15_1] ~= nil then
			arg_15_1.duration_ = var_15_0[var_15_1]
		end

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play113101005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 1.00008890058234e-12 < arg_15_1.time_ and arg_15_1.time_ <= 1.00008890058234e-12 + arg_18_0 then
				arg_15_1.var_.moveOldPos1084ui_story = arg_15_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_18_0 = 0.001

			if 1.00008890058234e-12 <= arg_15_1.time_ and arg_15_1.time_ < 1.00008890058234e-12 + var_18_0 then
				arg_15_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_15_1.time_ - 1.00008890058234e-12) / var_18_0)
				arg_15_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1084ui_story"].transform.position).z)
				arg_15_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1084ui_story"].transform.localEulerAngles = arg_15_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_15_1.time_ >= 1.00008890058234e-12 + var_18_0 and arg_15_1.time_ < 1.00008890058234e-12 + var_18_0 + arg_18_0 then
				arg_15_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_15_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_15_1.actors_["1084ui_story"].transform.position).z)
				arg_15_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_15_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_15_1.actors_["1084ui_story"].transform.localEulerAngles = arg_15_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_18_1 = "1042ui_story"

			if arg_15_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_18_2 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_15_1.stage_.transform)

				var_18_2.name = var_18_1
				var_18_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_15_1.actors_[var_18_1] = var_18_2

				local var_18_3 = var_18_2:GetComponentInChildren(typeof(CharacterEffect))

				var_18_3.enabled = true

				local var_18_4 = GameObjectTools.GetOrAddComponent(var_18_2, typeof(DynamicBoneHelper))

				if var_18_4 then
					var_18_4:EnableDynamicBone(false)
				end

				arg_15_1:ShowWeapon(var_18_3.transform, false)

				arg_15_1.var_[var_18_1 .. "Animator"] = var_18_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_15_1.var_[var_18_1 .. "Animator"].applyRootMotion = true
				arg_15_1.var_[var_18_1 .. "LipSync"] = var_18_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_18_5 = arg_15_1.actors_["1042ui_story"].transform

			if 1.00008890058234e-12 < arg_15_1.time_ and arg_15_1.time_ <= 1.00008890058234e-12 + arg_18_0 then
				arg_15_1.var_.moveOldPos1042ui_story = var_18_5.localPosition
			end

			local var_18_6 = 0.001

			if 1.00008890058234e-12 <= arg_15_1.time_ and arg_15_1.time_ < 1.00008890058234e-12 + var_18_6 then
				var_18_5.localPosition = Vector3.Lerp(arg_15_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_15_1.time_ - 1.00008890058234e-12) / var_18_6)
				var_18_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_5.position).x, (manager.ui.mainCamera.transform.position - var_18_5.position).y, (manager.ui.mainCamera.transform.position - var_18_5.position).z)
				var_18_5.localEulerAngles.z = 0
				var_18_5.localEulerAngles.x = 0
				var_18_5.localEulerAngles = var_18_5.localEulerAngles
			end

			if arg_15_1.time_ >= 1.00008890058234e-12 + var_18_6 and arg_15_1.time_ < 1.00008890058234e-12 + var_18_6 + arg_18_0 then
				var_18_5.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_18_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_18_5.position).x, (manager.ui.mainCamera.transform.position - var_18_5.position).y, (manager.ui.mainCamera.transform.position - var_18_5.position).z)
				var_18_5.localEulerAngles.z = 0
				var_18_5.localEulerAngles.x = 0
				var_18_5.localEulerAngles = var_18_5.localEulerAngles
			end

			if 1.00008890058234e-12 < arg_15_1.time_ and arg_15_1.time_ <= 1.00008890058234e-12 + arg_18_0 then
				arg_15_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 1.00008890058234e-12 < arg_15_1.time_ and arg_15_1.time_ <= 1.00008890058234e-12 + arg_18_0 then
				arg_15_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_18_7 = arg_15_1.actors_["1042ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_7) and arg_15_1.var_.characterEffect1042ui_story == nil then
				arg_15_1.var_.characterEffect1042ui_story = var_18_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_8 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_8 and not isNil(var_18_7) then
				if arg_15_1.var_.characterEffect1042ui_story and not isNil(var_18_7) then
					arg_15_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_15_1.time_ >= 0 + var_18_8 and arg_15_1.time_ < 0 + var_18_8 + arg_18_0 and not isNil(var_18_7) and arg_15_1.var_.characterEffect1042ui_story then
				arg_15_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_18_10 = arg_15_1.actors_["1041ui_story"]

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(var_18_10) and arg_15_1.var_.characterEffect1041ui_story == nil then
				arg_15_1.var_.characterEffect1041ui_story = var_18_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_11 = 0.2

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_11 and not isNil(var_18_10) then
				if arg_15_1.var_.characterEffect1041ui_story and not isNil(var_18_10) then
					arg_15_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_11)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_11 and arg_15_1.time_ < 0 + var_18_11 + arg_18_0 and not isNil(var_18_10) and arg_15_1.var_.characterEffect1041ui_story then
				arg_15_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_18_12 = 0
			local var_18_13 = 0.6

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_12 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_14 = arg_15_1:GetWordFromCfg(113101004)
				local var_18_15 = arg_15_1:FormatText(var_18_14.content)

				arg_15_1.text_.text = var_18_15

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_17 = 24 <= 0 and var_18_13 or var_18_13 * (utf8.len(var_18_15) / 24)

				if (24 <= 0 and var_18_13 or var_18_13 * (utf8.len(var_18_15) / 24)) > 0 and var_18_13 < var_18_17 then
					arg_15_1.talkMaxDuration = var_18_17

					if var_18_17 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_17 + var_18_12
					end
				end

				arg_15_1.text_.text = var_18_15
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101004", "story_v_out_113101.awb") ~= 0 then
					local var_18_18 = manager.audio:GetVoiceLength("story_v_out_113101", "113101004", "story_v_out_113101.awb") / 1000

					if var_18_18 + var_18_12 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_18 + var_18_12
					end

					if var_18_14.prefab_name ~= "" and arg_15_1.actors_[var_18_14.prefab_name] ~= nil then
						local var_18_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_15_1.actors_[var_18_14.prefab_name].transform, "story_v_out_113101", "113101004", "story_v_out_113101.awb")

						arg_15_1:RecordAudio("113101004", var_18_19)
						arg_15_1:RecordAudio("113101004", var_18_19)
					else
						arg_15_1:AudioAction("play", "voice", "story_v_out_113101", "113101004", "story_v_out_113101.awb")
					end

					arg_15_1:RecordHistoryTalkVoice("story_v_out_113101", "113101004", "story_v_out_113101.awb")
				end

				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_20 = math.max(var_18_13, arg_15_1.talkMaxDuration)

			if var_18_12 <= arg_15_1.time_ and arg_15_1.time_ < var_18_12 + var_18_20 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_12) / var_18_20

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_12 + var_18_20 and arg_15_1.time_ < var_18_12 + var_18_20 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end

		arg_15_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_15_1:InitPlayNodeList()
	end,
	Play113101005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 113101005
		arg_19_1.duration_ = 5.87

		local var_19_0 = {
			ja = 4.666,
			ko = 5.366,
			zh = 4.366,
			en = 5.866
		}
		local var_19_1 = manager.audio:GetLocalizationFlag()

		if var_19_0[var_19_1] ~= nil then
			arg_19_1.duration_ = var_19_0[var_19_1]
		end

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play113101006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 1.00008890058234e-12 < arg_19_1.time_ and arg_19_1.time_ <= 1.00008890058234e-12 + arg_22_0 then
				arg_19_1.var_.moveOldPos1042ui_story = arg_19_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_22_0 = 0.001

			if 1.00008890058234e-12 <= arg_19_1.time_ and arg_19_1.time_ < 1.00008890058234e-12 + var_22_0 then
				arg_19_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_19_1.time_ - 1.00008890058234e-12) / var_22_0)
				arg_19_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1042ui_story"].transform.position).z)
				arg_19_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1042ui_story"].transform.localEulerAngles = arg_19_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_19_1.time_ >= 1.00008890058234e-12 + var_22_0 and arg_19_1.time_ < 1.00008890058234e-12 + var_22_0 + arg_22_0 then
				arg_19_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_19_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_19_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_19_1.actors_["1042ui_story"].transform.position).z)
				arg_19_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_19_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_19_1.actors_["1042ui_story"].transform.localEulerAngles = arg_19_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_22_1 = arg_19_1.actors_["1084ui_story"].transform

			if 1.00008890058234e-12 < arg_19_1.time_ and arg_19_1.time_ <= 1.00008890058234e-12 + arg_22_0 then
				arg_19_1.var_.moveOldPos1084ui_story = var_22_1.localPosition
			end

			local var_22_2 = 0.001

			if 1.00008890058234e-12 <= arg_19_1.time_ and arg_19_1.time_ < 1.00008890058234e-12 + var_22_2 then
				var_22_1.localPosition = Vector3.Lerp(arg_19_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_19_1.time_ - 1.00008890058234e-12) / var_22_2)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			if arg_19_1.time_ >= 1.00008890058234e-12 + var_22_2 and arg_19_1.time_ < 1.00008890058234e-12 + var_22_2 + arg_22_0 then
				var_22_1.localPosition = Vector3.New(0.7, -0.97, -6)
				var_22_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_22_1.position).x, (manager.ui.mainCamera.transform.position - var_22_1.position).y, (manager.ui.mainCamera.transform.position - var_22_1.position).z)
				var_22_1.localEulerAngles.z = 0
				var_22_1.localEulerAngles.x = 0
				var_22_1.localEulerAngles = var_22_1.localEulerAngles
			end

			if 1.00008890058234e-12 < arg_19_1.time_ and arg_19_1.time_ <= 1.00008890058234e-12 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_22_3 = arg_19_1.actors_["1084ui_story"]

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = var_22_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_4 = 0.2

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_4 and not isNil(var_22_3) then
				if arg_19_1.var_.characterEffect1084ui_story and not isNil(var_22_3) then
					arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_4 and arg_19_1.time_ < 0 + var_22_4 + arg_22_0 and not isNil(var_22_3) and arg_19_1.var_.characterEffect1084ui_story then
				arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_22_6 = 0
			local var_22_7 = 0.625

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_6 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_8 = arg_19_1:GetWordFromCfg(113101005)
				local var_22_9 = arg_19_1:FormatText(var_22_8.content)

				arg_19_1.text_.text = var_22_9

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_11 = 25 <= 0 and var_22_7 or var_22_7 * (utf8.len(var_22_9) / 25)

				if (25 <= 0 and var_22_7 or var_22_7 * (utf8.len(var_22_9) / 25)) > 0 and var_22_7 < var_22_11 then
					arg_19_1.talkMaxDuration = var_22_11

					if var_22_11 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_11 + var_22_6
					end
				end

				arg_19_1.text_.text = var_22_9
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101005", "story_v_out_113101.awb") ~= 0 then
					local var_22_12 = manager.audio:GetVoiceLength("story_v_out_113101", "113101005", "story_v_out_113101.awb") / 1000

					if var_22_12 + var_22_6 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_12 + var_22_6
					end

					if var_22_8.prefab_name ~= "" and arg_19_1.actors_[var_22_8.prefab_name] ~= nil then
						local var_22_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_8.prefab_name].transform, "story_v_out_113101", "113101005", "story_v_out_113101.awb")

						arg_19_1:RecordAudio("113101005", var_22_13)
						arg_19_1:RecordAudio("113101005", var_22_13)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_113101", "113101005", "story_v_out_113101.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_113101", "113101005", "story_v_out_113101.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_14 = math.max(var_22_7, arg_19_1.talkMaxDuration)

			if var_22_6 <= arg_19_1.time_ and arg_19_1.time_ < var_22_6 + var_22_14 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_6) / var_22_14

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_6 + var_22_14 and arg_19_1.time_ < var_22_6 + var_22_14 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_19_1:InitPlayNodeList()
	end,
	Play113101006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 113101006
		arg_23_1.duration_ = 2

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play113101007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1084ui_story"]) and arg_23_1.var_.characterEffect1084ui_story == nil then
				arg_23_1.var_.characterEffect1084ui_story = arg_23_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_0 and not isNil(arg_23_1.actors_["1084ui_story"]) then
				if arg_23_1.var_.characterEffect1084ui_story and not isNil(arg_23_1.actors_["1084ui_story"]) then
					arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_23_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_23_1.time_ - 0) / var_26_0)
				end
			end

			if arg_23_1.time_ >= 0 + var_26_0 and arg_23_1.time_ < 0 + var_26_0 + arg_26_0 and not isNil(arg_23_1.actors_["1084ui_story"]) and arg_23_1.var_.characterEffect1084ui_story then
				arg_23_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_23_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 1.00008890058234e-12 < arg_23_1.time_ and arg_23_1.time_ <= 1.00008890058234e-12 + arg_26_0 then
				arg_23_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_26_1 = arg_23_1.actors_["1041ui_story"]

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1041ui_story == nil then
				arg_23_1.var_.characterEffect1041ui_story = var_26_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_2 = 0.2

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 and not isNil(var_26_1) then
				if arg_23_1.var_.characterEffect1041ui_story and not isNil(var_26_1) then
					arg_23_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 and not isNil(var_26_1) and arg_23_1.var_.characterEffect1041ui_story then
				arg_23_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_26_4 = 0
			local var_26_5 = 0.05

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_4 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, true)

				arg_23_1.leftNameTxt_.text = arg_23_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_23_1.leftNameTxt_.transform)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1.leftNameTxt_.text)
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_6 = arg_23_1:GetWordFromCfg(113101006)
				local var_26_7 = arg_23_1:FormatText(var_26_6.content)

				arg_23_1.text_.text = var_26_7

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_9 = 2 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 2)

				if (2 <= 0 and var_26_5 or var_26_5 * (utf8.len(var_26_7) / 2)) > 0 and var_26_5 < var_26_9 then
					arg_23_1.talkMaxDuration = var_26_9

					if var_26_9 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_9 + var_26_4
					end
				end

				arg_23_1.text_.text = var_26_7
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101006", "story_v_out_113101.awb") ~= 0 then
					local var_26_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101006", "story_v_out_113101.awb") / 1000

					if var_26_10 + var_26_4 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_10 + var_26_4
					end

					if var_26_6.prefab_name ~= "" and arg_23_1.actors_[var_26_6.prefab_name] ~= nil then
						local var_26_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_23_1.actors_[var_26_6.prefab_name].transform, "story_v_out_113101", "113101006", "story_v_out_113101.awb")

						arg_23_1:RecordAudio("113101006", var_26_11)
						arg_23_1:RecordAudio("113101006", var_26_11)
					else
						arg_23_1:AudioAction("play", "voice", "story_v_out_113101", "113101006", "story_v_out_113101.awb")
					end

					arg_23_1:RecordHistoryTalkVoice("story_v_out_113101", "113101006", "story_v_out_113101.awb")
				end

				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_12 = math.max(var_26_5, arg_23_1.talkMaxDuration)

			if var_26_4 <= arg_23_1.time_ and arg_23_1.time_ < var_26_4 + var_26_12 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_4) / var_26_12

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_4 + var_26_12 and arg_23_1.time_ < var_26_4 + var_26_12 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {}

		arg_23_1:InitPlayNodeList()
	end,
	Play113101007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 113101007
		arg_27_1.duration_ = 5

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play113101008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1041ui_story = arg_27_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1041ui_story"].transform.position).z)
				arg_27_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1041ui_story"].transform.localEulerAngles = arg_27_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_27_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1041ui_story"].transform.position).z)
				arg_27_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1041ui_story"].transform.localEulerAngles = arg_27_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1084ui_story"].transform

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = var_30_1.localPosition
			end

			local var_30_2 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 then
				var_30_1.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_27_1.time_ - 0) / var_30_2)
				var_30_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_1.position).x, (manager.ui.mainCamera.transform.position - var_30_1.position).y, (manager.ui.mainCamera.transform.position - var_30_1.position).z)
				var_30_1.localEulerAngles.z = 0
				var_30_1.localEulerAngles.x = 0
				var_30_1.localEulerAngles = var_30_1.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 then
				var_30_1.localPosition = Vector3.New(0, 100, 0)
				var_30_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_30_1.position).x, (manager.ui.mainCamera.transform.position - var_30_1.position).y, (manager.ui.mainCamera.transform.position - var_30_1.position).z)
				var_30_1.localEulerAngles.z = 0
				var_30_1.localEulerAngles.x = 0
				var_30_1.localEulerAngles = var_30_1.localEulerAngles
			end

			local var_30_3 = 0
			local var_30_4 = 0.7

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_3 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, false)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_5 = arg_27_1:FormatText(arg_27_1:GetWordFromCfg(113101007).content)

				arg_27_1.text_.text = var_30_5

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_7 = 28 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 28)

				if (28 <= 0 and var_30_4 or var_30_4 * (utf8.len(var_30_5) / 28)) > 0 and var_30_4 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_3 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_3
					end
				end

				arg_27_1.text_.text = var_30_5
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)
				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_8 = math.max(var_30_4, arg_27_1.talkMaxDuration)

			if var_30_3 <= arg_27_1.time_ and arg_27_1.time_ < var_30_3 + var_30_8 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_3) / var_30_8

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_3 + var_30_8 and arg_27_1.time_ < var_30_3 + var_30_8 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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
			}
		}

		arg_27_1:InitPlayNodeList()
	end,
	Play113101008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 113101008
		arg_31_1.duration_ = 2.63

		local var_31_0 = {
			ja = 2.633,
			ko = 2.633,
			zh = 2.2,
			en = 2.566
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play113101009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 1.00008890058234e-12 < arg_31_1.time_ and arg_31_1.time_ <= 1.00008890058234e-12 + arg_34_0 then
				arg_31_1.var_.moveOldPos1041ui_story = arg_31_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 1.00008890058234e-12 <= arg_31_1.time_ and arg_31_1.time_ < 1.00008890058234e-12 + var_34_0 then
				arg_31_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_31_1.time_ - 1.00008890058234e-12) / var_34_0)
				arg_31_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1041ui_story"].transform.position).z)
				arg_31_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1041ui_story"].transform.localEulerAngles = arg_31_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 1.00008890058234e-12 + var_34_0 and arg_31_1.time_ < 1.00008890058234e-12 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				arg_31_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1041ui_story"].transform.position).z)
				arg_31_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1041ui_story"].transform.localEulerAngles = arg_31_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 1.00008890058234e-12 < arg_31_1.time_ and arg_31_1.time_ <= 1.00008890058234e-12 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 1.00008890058234e-12 < arg_31_1.time_ and arg_31_1.time_ <= 1.00008890058234e-12 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_34_1 = arg_31_1.actors_["1041ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1041ui_story == nil then
				arg_31_1.var_.characterEffect1041ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1041ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1041ui_story then
				arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_34_4 = 0
			local var_34_5 = 0.3

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:GetWordFromCfg(113101008)
				local var_34_7 = arg_31_1:FormatText(var_34_6.content)

				arg_31_1.text_.text = var_34_7

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_9 = 12 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 12)

				if (12 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_7) / 12)) > 0 and var_34_5 < var_34_9 then
					arg_31_1.talkMaxDuration = var_34_9

					if var_34_9 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_9 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_7
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101008", "story_v_out_113101.awb") ~= 0 then
					local var_34_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101008", "story_v_out_113101.awb") / 1000

					if var_34_10 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_10 + var_34_4
					end

					if var_34_6.prefab_name ~= "" and arg_31_1.actors_[var_34_6.prefab_name] ~= nil then
						local var_34_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_6.prefab_name].transform, "story_v_out_113101", "113101008", "story_v_out_113101.awb")

						arg_31_1:RecordAudio("113101008", var_34_11)
						arg_31_1:RecordAudio("113101008", var_34_11)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_113101", "113101008", "story_v_out_113101.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_113101", "113101008", "story_v_out_113101.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_12 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_12 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_12

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_12 and arg_31_1.time_ < var_34_4 + var_34_12 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play113101009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 113101009
		arg_35_1.duration_ = 5.5

		local var_35_0 = {
			ja = 4.066,
			ko = 5.5,
			zh = 3.5,
			en = 2
		}
		local var_35_1 = manager.audio:GetLocalizationFlag()

		if var_35_0[var_35_1] ~= nil then
			arg_35_1.duration_ = var_35_0[var_35_1]
		end

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play113101010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 1.00008890058234e-12 < arg_35_1.time_ and arg_35_1.time_ <= 1.00008890058234e-12 + arg_38_0 then
				arg_35_1.var_.moveOldPos1084ui_story = arg_35_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 1.00008890058234e-12 <= arg_35_1.time_ and arg_35_1.time_ < 1.00008890058234e-12 + var_38_0 then
				arg_35_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_35_1.time_ - 1.00008890058234e-12) / var_38_0)
				arg_35_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1084ui_story"].transform.position).z)
				arg_35_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1084ui_story"].transform.localEulerAngles = arg_35_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 1.00008890058234e-12 + var_38_0 and arg_35_1.time_ < 1.00008890058234e-12 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_35_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1084ui_story"].transform.position).z)
				arg_35_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1084ui_story"].transform.localEulerAngles = arg_35_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 1.00008890058234e-12 < arg_35_1.time_ and arg_35_1.time_ <= 1.00008890058234e-12 + arg_38_0 then
				arg_35_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_38_1 = arg_35_1.actors_["1084ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1084ui_story == nil then
				arg_35_1.var_.characterEffect1084ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1084ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1084ui_story then
				arg_35_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_38_4 = arg_35_1.actors_["1041ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1041ui_story == nil then
				arg_35_1.var_.characterEffect1041ui_story = var_38_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_5 = 0.2

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_5 and not isNil(var_38_4) then
				if arg_35_1.var_.characterEffect1041ui_story and not isNil(var_38_4) then
					arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_5)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_5 and arg_35_1.time_ < 0 + var_38_5 + arg_38_0 and not isNil(var_38_4) and arg_35_1.var_.characterEffect1041ui_story then
				arg_35_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_38_6 = 0
			local var_38_7 = 0.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_6 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_8 = arg_35_1:GetWordFromCfg(113101009)
				local var_38_9 = arg_35_1:FormatText(var_38_8.content)

				arg_35_1.text_.text = var_38_9

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_11 = 18 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_9) / 18)

				if (18 <= 0 and var_38_7 or var_38_7 * (utf8.len(var_38_9) / 18)) > 0 and var_38_7 < var_38_11 then
					arg_35_1.talkMaxDuration = var_38_11

					if var_38_11 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_11 + var_38_6
					end
				end

				arg_35_1.text_.text = var_38_9
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101009", "story_v_out_113101.awb") ~= 0 then
					local var_38_12 = manager.audio:GetVoiceLength("story_v_out_113101", "113101009", "story_v_out_113101.awb") / 1000

					if var_38_12 + var_38_6 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_12 + var_38_6
					end

					if var_38_8.prefab_name ~= "" and arg_35_1.actors_[var_38_8.prefab_name] ~= nil then
						local var_38_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_8.prefab_name].transform, "story_v_out_113101", "113101009", "story_v_out_113101.awb")

						arg_35_1:RecordAudio("113101009", var_38_13)
						arg_35_1:RecordAudio("113101009", var_38_13)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_113101", "113101009", "story_v_out_113101.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_113101", "113101009", "story_v_out_113101.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_14 = math.max(var_38_7, arg_35_1.talkMaxDuration)

			if var_38_6 <= arg_35_1.time_ and arg_35_1.time_ < var_38_6 + var_38_14 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_6) / var_38_14

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_6 + var_38_14 and arg_35_1.time_ < var_38_6 + var_38_14 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play113101010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 113101010
		arg_39_1.duration_ = 7.07

		local var_39_0 = {
			ja = 7.066,
			ko = 5.966,
			zh = 6.433,
			en = 6.533
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play113101011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(arg_39_1.actors_["1084ui_story"]) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = arg_39_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_0 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 and not isNil(arg_39_1.actors_["1084ui_story"]) then
				if arg_39_1.var_.characterEffect1084ui_story and not isNil(arg_39_1.actors_["1084ui_story"]) then
					arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_39_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_39_1.time_ - 0) / var_42_0)
				end
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 and not isNil(arg_39_1.actors_["1084ui_story"]) and arg_39_1.var_.characterEffect1084ui_story then
				arg_39_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_39_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_42_1 = arg_39_1.actors_["1041ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1041ui_story == nil then
				arg_39_1.var_.characterEffect1041ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1041ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1041ui_story then
				arg_39_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_1")
			end

			local var_42_4 = 0
			local var_42_5 = 0.825

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(113101010)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 33 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 33)

				if (33 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 33)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101010", "story_v_out_113101.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101010", "story_v_out_113101.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_113101", "113101010", "story_v_out_113101.awb")

						arg_39_1:RecordAudio("113101010", var_42_11)
						arg_39_1:RecordAudio("113101010", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_113101", "113101010", "story_v_out_113101.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_113101", "113101010", "story_v_out_113101.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play113101011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 113101011
		arg_43_1.duration_ = 5.33

		local var_43_0 = {
			ja = 4.1,
			ko = 4.2,
			zh = 3.133,
			en = 5.333
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
				arg_43_0:Play113101012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1041ui_story"]) and arg_43_1.var_.characterEffect1041ui_story == nil then
				arg_43_1.var_.characterEffect1041ui_story = arg_43_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1041ui_story"]) then
				if arg_43_1.var_.characterEffect1041ui_story and not isNil(arg_43_1.actors_["1041ui_story"]) then
					arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1041ui_story"]) and arg_43_1.var_.characterEffect1041ui_story then
				arg_43_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_46_1 = arg_43_1.actors_["1084ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1084ui_story == nil then
				arg_43_1.var_.characterEffect1084ui_story = var_46_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_2 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 and not isNil(var_46_1) then
				if arg_43_1.var_.characterEffect1084ui_story and not isNil(var_46_1) then
					arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 and not isNil(var_46_1) and arg_43_1.var_.characterEffect1084ui_story then
				arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1.00008890058234e-12 < arg_43_1.time_ and arg_43_1.time_ <= 1.00008890058234e-12 + arg_46_0 then
				arg_43_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_46_4 = 0
			local var_46_5 = 0.425

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_4 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_6 = arg_43_1:GetWordFromCfg(113101011)
				local var_46_7 = arg_43_1:FormatText(var_46_6.content)

				arg_43_1.text_.text = var_46_7

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_9 = 17 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 17)

				if (17 <= 0 and var_46_5 or var_46_5 * (utf8.len(var_46_7) / 17)) > 0 and var_46_5 < var_46_9 then
					arg_43_1.talkMaxDuration = var_46_9

					if var_46_9 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_4
					end
				end

				arg_43_1.text_.text = var_46_7
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101011", "story_v_out_113101.awb") ~= 0 then
					local var_46_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101011", "story_v_out_113101.awb") / 1000

					if var_46_10 + var_46_4 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_10 + var_46_4
					end

					if var_46_6.prefab_name ~= "" and arg_43_1.actors_[var_46_6.prefab_name] ~= nil then
						local var_46_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_6.prefab_name].transform, "story_v_out_113101", "113101011", "story_v_out_113101.awb")

						arg_43_1:RecordAudio("113101011", var_46_11)
						arg_43_1:RecordAudio("113101011", var_46_11)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_113101", "113101011", "story_v_out_113101.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_113101", "113101011", "story_v_out_113101.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_12 = math.max(var_46_5, arg_43_1.talkMaxDuration)

			if var_46_4 <= arg_43_1.time_ and arg_43_1.time_ < var_46_4 + var_46_12 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_4) / var_46_12

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_4 + var_46_12 and arg_43_1.time_ < var_46_4 + var_46_12 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play113101012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113101012
		arg_47_1.duration_ = 8.97

		local var_47_0 = {
			ja = 8.966,
			ko = 6.233,
			zh = 5.633,
			en = 4.966
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
				arg_47_0:Play113101013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1041ui_story"]) and arg_47_1.var_.characterEffect1041ui_story == nil then
				arg_47_1.var_.characterEffect1041ui_story = arg_47_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1041ui_story"]) then
				if arg_47_1.var_.characterEffect1041ui_story and not isNil(arg_47_1.actors_["1041ui_story"]) then
					arg_47_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1041ui_story"]) and arg_47_1.var_.characterEffect1041ui_story then
				arg_47_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_50_2 = arg_47_1.actors_["1084ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1084ui_story == nil then
				arg_47_1.var_.characterEffect1084ui_story = var_50_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_3 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_3 and not isNil(var_50_2) then
				if arg_47_1.var_.characterEffect1084ui_story and not isNil(var_50_2) then
					arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_3)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_3 and arg_47_1.time_ < 0 + var_50_3 + arg_50_0 and not isNil(var_50_2) and arg_47_1.var_.characterEffect1084ui_story then
				arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action3_2")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_50_4 = 0
			local var_50_5 = 0.775

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_4 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_6 = arg_47_1:GetWordFromCfg(113101012)
				local var_50_7 = arg_47_1:FormatText(var_50_6.content)

				arg_47_1.text_.text = var_50_7

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_9 = 31 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 31)

				if (31 <= 0 and var_50_5 or var_50_5 * (utf8.len(var_50_7) / 31)) > 0 and var_50_5 < var_50_9 then
					arg_47_1.talkMaxDuration = var_50_9

					if var_50_9 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_9 + var_50_4
					end
				end

				arg_47_1.text_.text = var_50_7
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101012", "story_v_out_113101.awb") ~= 0 then
					local var_50_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101012", "story_v_out_113101.awb") / 1000

					if var_50_10 + var_50_4 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_4
					end

					if var_50_6.prefab_name ~= "" and arg_47_1.actors_[var_50_6.prefab_name] ~= nil then
						local var_50_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_6.prefab_name].transform, "story_v_out_113101", "113101012", "story_v_out_113101.awb")

						arg_47_1:RecordAudio("113101012", var_50_11)
						arg_47_1:RecordAudio("113101012", var_50_11)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_113101", "113101012", "story_v_out_113101.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_113101", "113101012", "story_v_out_113101.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_12 = math.max(var_50_5, arg_47_1.talkMaxDuration)

			if var_50_4 <= arg_47_1.time_ and arg_47_1.time_ < var_50_4 + var_50_12 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_4) / var_50_12

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_4 + var_50_12 and arg_47_1.time_ < var_50_4 + var_50_12 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play113101013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 113101013
		arg_51_1.duration_ = 9.1

		local var_51_0 = {
			ja = 9.1,
			ko = 8.6,
			zh = 8.933,
			en = 6.733
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
				arg_51_0:Play113101014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_54_0 = 0
			local var_54_1 = 1.1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_2 = arg_51_1:GetWordFromCfg(113101013)
				local var_54_3 = arg_51_1:FormatText(var_54_2.content)

				arg_51_1.text_.text = var_54_3

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_5 = 44 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_3) / 44)

				if (44 <= 0 and var_54_1 or var_54_1 * (utf8.len(var_54_3) / 44)) > 0 and var_54_1 < var_54_5 then
					arg_51_1.talkMaxDuration = var_54_5

					if var_54_5 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_5 + var_54_0
					end
				end

				arg_51_1.text_.text = var_54_3
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101013", "story_v_out_113101.awb") ~= 0 then
					local var_54_6 = manager.audio:GetVoiceLength("story_v_out_113101", "113101013", "story_v_out_113101.awb") / 1000

					if var_54_6 + var_54_0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_6 + var_54_0
					end

					if var_54_2.prefab_name ~= "" and arg_51_1.actors_[var_54_2.prefab_name] ~= nil then
						local var_54_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_2.prefab_name].transform, "story_v_out_113101", "113101013", "story_v_out_113101.awb")

						arg_51_1:RecordAudio("113101013", var_54_7)
						arg_51_1:RecordAudio("113101013", var_54_7)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_113101", "113101013", "story_v_out_113101.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_113101", "113101013", "story_v_out_113101.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_8 = math.max(var_54_1, arg_51_1.talkMaxDuration)

			if var_54_0 <= arg_51_1.time_ and arg_51_1.time_ < var_54_0 + var_54_8 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_0) / var_54_8

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_0 + var_54_8 and arg_51_1.time_ < var_54_0 + var_54_8 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play113101014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113101014
		arg_55_1.duration_ = 4.03

		local var_55_0 = {
			ja = 4.033,
			ko = 3.1,
			zh = 3.566,
			en = 3.233
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
				arg_55_0:Play113101015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 1.00008890058234e-12 < arg_55_1.time_ and arg_55_1.time_ <= 1.00008890058234e-12 + arg_58_0 then
				arg_55_1.var_.moveOldPos1042ui_story = arg_55_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_58_0 = 0.001

			if 1.00008890058234e-12 <= arg_55_1.time_ and arg_55_1.time_ < 1.00008890058234e-12 + var_58_0 then
				arg_55_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_55_1.time_ - 1.00008890058234e-12) / var_58_0)
				arg_55_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1042ui_story"].transform.position).z)
				arg_55_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1042ui_story"].transform.localEulerAngles = arg_55_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 1.00008890058234e-12 + var_58_0 and arg_55_1.time_ < 1.00008890058234e-12 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_55_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1042ui_story"].transform.position).z)
				arg_55_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1042ui_story"].transform.localEulerAngles = arg_55_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 1.00008890058234e-12 < arg_55_1.time_ and arg_55_1.time_ <= 1.00008890058234e-12 + arg_58_0 then
				arg_55_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 1.00008890058234e-12 < arg_55_1.time_ and arg_55_1.time_ <= 1.00008890058234e-12 + arg_58_0 then
				arg_55_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_58_1 = arg_55_1.actors_["1042ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1042ui_story == nil then
				arg_55_1.var_.characterEffect1042ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1042ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1042ui_story then
				arg_55_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_58_4 = arg_55_1.actors_["1041ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1041ui_story == nil then
				arg_55_1.var_.characterEffect1041ui_story = var_58_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_5 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 and not isNil(var_58_4) then
				if arg_55_1.var_.characterEffect1041ui_story and not isNil(var_58_4) then
					arg_55_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_5)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 and not isNil(var_58_4) and arg_55_1.var_.characterEffect1041ui_story then
				arg_55_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_58_6 = arg_55_1.actors_["1084ui_story"].transform

			if 1.00008890058234e-12 < arg_55_1.time_ and arg_55_1.time_ <= 1.00008890058234e-12 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = var_58_6.localPosition
			end

			local var_58_7 = 0.001

			if 1.00008890058234e-12 <= arg_55_1.time_ and arg_55_1.time_ < 1.00008890058234e-12 + var_58_7 then
				var_58_6.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 1.00008890058234e-12) / var_58_7)
				var_58_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_6.position).x, (manager.ui.mainCamera.transform.position - var_58_6.position).y, (manager.ui.mainCamera.transform.position - var_58_6.position).z)
				var_58_6.localEulerAngles.z = 0
				var_58_6.localEulerAngles.x = 0
				var_58_6.localEulerAngles = var_58_6.localEulerAngles
			end

			if arg_55_1.time_ >= 1.00008890058234e-12 + var_58_7 and arg_55_1.time_ < 1.00008890058234e-12 + var_58_7 + arg_58_0 then
				var_58_6.localPosition = Vector3.New(0, 100, 0)
				var_58_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_6.position).x, (manager.ui.mainCamera.transform.position - var_58_6.position).y, (manager.ui.mainCamera.transform.position - var_58_6.position).z)
				var_58_6.localEulerAngles.z = 0
				var_58_6.localEulerAngles.x = 0
				var_58_6.localEulerAngles = var_58_6.localEulerAngles
			end

			local var_58_8 = 0
			local var_58_9 = 0.35

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(113101014)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 14 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 14)

				if (14 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 14)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101014", "story_v_out_113101.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_113101", "113101014", "story_v_out_113101.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_113101", "113101014", "story_v_out_113101.awb")

						arg_55_1:RecordAudio("113101014", var_58_15)
						arg_55_1:RecordAudio("113101014", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113101", "113101014", "story_v_out_113101.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113101", "113101014", "story_v_out_113101.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_16 = math.max(var_58_9, arg_55_1.talkMaxDuration)

			if var_58_8 <= arg_55_1.time_ and arg_55_1.time_ < var_58_8 + var_58_16 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_8) / var_58_16

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_8 + var_58_16 and arg_55_1.time_ < var_58_8 + var_58_16 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play113101015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113101015
		arg_59_1.duration_ = 2.83

		local var_59_0 = {
			ja = 1.999999999999,
			ko = 2.266,
			zh = 2.833,
			en = 2.566
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
				arg_59_0:Play113101016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1041ui_story"]) and arg_59_1.var_.characterEffect1041ui_story == nil then
				arg_59_1.var_.characterEffect1041ui_story = arg_59_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1041ui_story"]) then
				if arg_59_1.var_.characterEffect1041ui_story and not isNil(arg_59_1.actors_["1041ui_story"]) then
					arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1041ui_story"]) and arg_59_1.var_.characterEffect1041ui_story then
				arg_59_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_62_2 = arg_59_1.actors_["1042ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1042ui_story == nil then
				arg_59_1.var_.characterEffect1042ui_story = var_62_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_3 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_3 and not isNil(var_62_2) then
				if arg_59_1.var_.characterEffect1042ui_story and not isNil(var_62_2) then
					arg_59_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_3)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_3 and arg_59_1.time_ < 0 + var_62_3 + arg_62_0 and not isNil(var_62_2) and arg_59_1.var_.characterEffect1042ui_story then
				arg_59_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_62_4 = 0
			local var_62_5 = 0.325

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(113101015)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 13 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 13)

				if (13 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 13)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101015", "story_v_out_113101.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_113101", "113101015", "story_v_out_113101.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_113101", "113101015", "story_v_out_113101.awb")

						arg_59_1:RecordAudio("113101015", var_62_11)
						arg_59_1:RecordAudio("113101015", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113101", "113101015", "story_v_out_113101.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113101", "113101015", "story_v_out_113101.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_12 = math.max(var_62_5, arg_59_1.talkMaxDuration)

			if var_62_4 <= arg_59_1.time_ and arg_59_1.time_ < var_62_4 + var_62_12 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_4) / var_62_12

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_4 + var_62_12 and arg_59_1.time_ < var_62_4 + var_62_12 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113101016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113101016
		arg_63_1.duration_ = 7.17

		local var_63_0 = {
			ja = 7.166,
			ko = 4.066,
			zh = 3.8,
			en = 4.466
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
				arg_63_0:Play113101017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action7_1")
			end

			local var_66_0 = 0
			local var_66_1 = 0.475

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_2 = arg_63_1:GetWordFromCfg(113101016)
				local var_66_3 = arg_63_1:FormatText(var_66_2.content)

				arg_63_1.text_.text = var_66_3

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 19 <= 0 and var_66_1 or var_66_1 * (utf8.len(var_66_3) / 19)

				if (19 <= 0 and var_66_1 or var_66_1 * (utf8.len(var_66_3) / 19)) > 0 and var_66_1 < var_66_5 then
					arg_63_1.talkMaxDuration = var_66_5

					if var_66_5 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_5 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_3
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101016", "story_v_out_113101.awb") ~= 0 then
					local var_66_6 = manager.audio:GetVoiceLength("story_v_out_113101", "113101016", "story_v_out_113101.awb") / 1000

					if var_66_6 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_6 + var_66_0
					end

					if var_66_2.prefab_name ~= "" and arg_63_1.actors_[var_66_2.prefab_name] ~= nil then
						local var_66_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_2.prefab_name].transform, "story_v_out_113101", "113101016", "story_v_out_113101.awb")

						arg_63_1:RecordAudio("113101016", var_66_7)
						arg_63_1:RecordAudio("113101016", var_66_7)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113101", "113101016", "story_v_out_113101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113101", "113101016", "story_v_out_113101.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_8 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_8 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_8

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_8 and arg_63_1.time_ < var_66_0 + var_66_8 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113101017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113101017
		arg_67_1.duration_ = 4.23

		local var_67_0 = {
			ja = 4.233,
			ko = 2.7,
			zh = 2.3,
			en = 2.2
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
				arg_67_0:Play113101018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 1.00008890058234e-12 < arg_67_1.time_ and arg_67_1.time_ <= 1.00008890058234e-12 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_2")
			end

			if 1.00008890058234e-12 < arg_67_1.time_ and arg_67_1.time_ <= 1.00008890058234e-12 + arg_70_0 then
				arg_67_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_70_0 = arg_67_1.actors_["1042ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1042ui_story == nil then
				arg_67_1.var_.characterEffect1042ui_story = var_70_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_1 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_1 and not isNil(var_70_0) then
				if arg_67_1.var_.characterEffect1042ui_story and not isNil(var_70_0) then
					arg_67_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_1 and arg_67_1.time_ < 0 + var_70_1 + arg_70_0 and not isNil(var_70_0) and arg_67_1.var_.characterEffect1042ui_story then
				arg_67_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_70_3 = arg_67_1.actors_["1041ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect1041ui_story == nil then
				arg_67_1.var_.characterEffect1041ui_story = var_70_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_4 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 and not isNil(var_70_3) then
				if arg_67_1.var_.characterEffect1041ui_story and not isNil(var_70_3) then
					arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_4)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect1041ui_story then
				arg_67_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_70_5 = 0
			local var_70_6 = 0.25

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_5 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_7 = arg_67_1:GetWordFromCfg(113101017)
				local var_70_8 = arg_67_1:FormatText(var_70_7.content)

				arg_67_1.text_.text = var_70_8

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_10 = 10 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 10)

				if (10 <= 0 and var_70_6 or var_70_6 * (utf8.len(var_70_8) / 10)) > 0 and var_70_6 < var_70_10 then
					arg_67_1.talkMaxDuration = var_70_10

					if var_70_10 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_5
					end
				end

				arg_67_1.text_.text = var_70_8
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101017", "story_v_out_113101.awb") ~= 0 then
					local var_70_11 = manager.audio:GetVoiceLength("story_v_out_113101", "113101017", "story_v_out_113101.awb") / 1000

					if var_70_11 + var_70_5 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_5
					end

					if var_70_7.prefab_name ~= "" and arg_67_1.actors_[var_70_7.prefab_name] ~= nil then
						local var_70_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_7.prefab_name].transform, "story_v_out_113101", "113101017", "story_v_out_113101.awb")

						arg_67_1:RecordAudio("113101017", var_70_12)
						arg_67_1:RecordAudio("113101017", var_70_12)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113101", "113101017", "story_v_out_113101.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113101", "113101017", "story_v_out_113101.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_13 = math.max(var_70_6, arg_67_1.talkMaxDuration)

			if var_70_5 <= arg_67_1.time_ and arg_67_1.time_ < var_70_5 + var_70_13 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_5) / var_70_13

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_5 + var_70_13 and arg_67_1.time_ < var_70_5 + var_70_13 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play113101018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113101018
		arg_71_1.duration_ = 3.1

		local var_71_0 = {
			ja = 2.1,
			ko = 2,
			zh = 2,
			en = 3.1
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play113101019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1041ui_story = arg_71_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1041ui_story"].transform.position).z)
				arg_71_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1041ui_story"].transform.localEulerAngles = arg_71_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_71_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["1041ui_story"].transform.position).z)
				arg_71_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["1041ui_story"].transform.localEulerAngles = arg_71_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["1042ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1042ui_story = var_74_1.localPosition
			end

			local var_74_2 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 then
				var_74_1.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_71_1.time_ - 0) / var_74_2)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 then
				var_74_1.localPosition = Vector3.New(0, 100, 0)
				var_74_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_1.position).x, (manager.ui.mainCamera.transform.position - var_74_1.position).y, (manager.ui.mainCamera.transform.position - var_74_1.position).z)
				var_74_1.localEulerAngles.z = 0
				var_74_1.localEulerAngles.x = 0
				var_74_1.localEulerAngles = var_74_1.localEulerAngles
			end

			local var_74_3 = arg_71_1.actors_["1084ui_story"].transform

			if 1.00008890058234e-12 < arg_71_1.time_ and arg_71_1.time_ <= 1.00008890058234e-12 + arg_74_0 then
				arg_71_1.var_.moveOldPos1084ui_story = var_74_3.localPosition
			end

			local var_74_4 = 0.001

			if 1.00008890058234e-12 <= arg_71_1.time_ and arg_71_1.time_ < 1.00008890058234e-12 + var_74_4 then
				var_74_3.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_71_1.time_ - 1.00008890058234e-12) / var_74_4)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if arg_71_1.time_ >= 1.00008890058234e-12 + var_74_4 and arg_71_1.time_ < 1.00008890058234e-12 + var_74_4 + arg_74_0 then
				var_74_3.localPosition = Vector3.New(0, -0.97, -6)
				var_74_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_3.position).x, (manager.ui.mainCamera.transform.position - var_74_3.position).y, (manager.ui.mainCamera.transform.position - var_74_3.position).z)
				var_74_3.localEulerAngles.z = 0
				var_74_3.localEulerAngles.x = 0
				var_74_3.localEulerAngles = var_74_3.localEulerAngles
			end

			if 1.00008890058234e-12 < arg_71_1.time_ and arg_71_1.time_ <= 1.00008890058234e-12 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 1.00008890058234e-12 < arg_71_1.time_ and arg_71_1.time_ <= 1.00008890058234e-12 + arg_74_0 then
				arg_71_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_74_5 = arg_71_1.actors_["1084ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = var_74_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_6 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_6 and not isNil(var_74_5) then
				if arg_71_1.var_.characterEffect1084ui_story and not isNil(var_74_5) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_6 and arg_71_1.time_ < 0 + var_74_6 + arg_74_0 and not isNil(var_74_5) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_74_8 = 0
			local var_74_9 = 0.1

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_8 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_10 = arg_71_1:GetWordFromCfg(113101018)
				local var_74_11 = arg_71_1:FormatText(var_74_10.content)

				arg_71_1.text_.text = var_74_11

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_13 = 4 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 4)

				if (4 <= 0 and var_74_9 or var_74_9 * (utf8.len(var_74_11) / 4)) > 0 and var_74_9 < var_74_13 then
					arg_71_1.talkMaxDuration = var_74_13

					if var_74_13 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_13 + var_74_8
					end
				end

				arg_71_1.text_.text = var_74_11
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101018", "story_v_out_113101.awb") ~= 0 then
					local var_74_14 = manager.audio:GetVoiceLength("story_v_out_113101", "113101018", "story_v_out_113101.awb") / 1000

					if var_74_14 + var_74_8 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_14 + var_74_8
					end

					if var_74_10.prefab_name ~= "" and arg_71_1.actors_[var_74_10.prefab_name] ~= nil then
						local var_74_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_10.prefab_name].transform, "story_v_out_113101", "113101018", "story_v_out_113101.awb")

						arg_71_1:RecordAudio("113101018", var_74_15)
						arg_71_1:RecordAudio("113101018", var_74_15)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113101", "113101018", "story_v_out_113101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113101", "113101018", "story_v_out_113101.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_16 = math.max(var_74_9, arg_71_1.talkMaxDuration)

			if var_74_8 <= arg_71_1.time_ and arg_71_1.time_ < var_74_8 + var_74_16 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_8) / var_74_16

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_8 + var_74_16 and arg_71_1.time_ < var_74_8 + var_74_16 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
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
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play113101019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113101019
		arg_75_1.duration_ = 0.2

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"

			SetActive(arg_75_1.choicesGo_, true)

			for iter_76_0, iter_76_1 in ipairs(arg_75_1.choices_) do
				SetActive(iter_76_1.go, iter_76_0 <= 2)
			end

			arg_75_1.choices_[1].txt.text = arg_75_1:FormatText(StoryChoiceCfg[199].name)
			arg_75_1.choices_[2].txt.text = arg_75_1:FormatText(StoryChoiceCfg[200].name)
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play113101020(arg_75_1)
			end

			if arg_77_0 == 2 then
				arg_75_0:Play113101020(arg_75_1)
			end

			arg_75_1:RecordChoiceLog(113101019, 199, 200)
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1084ui_story"]) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = arg_75_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1084ui_story"]) then
				if arg_75_1.var_.characterEffect1084ui_story and not isNil(arg_75_1.actors_["1084ui_story"]) then
					arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1084ui_story"]) and arg_75_1.var_.characterEffect1084ui_story then
				arg_75_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113101020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113101020
		arg_79_1.duration_ = 8.67

		local var_79_0 = {
			ja = 8.666,
			ko = 4.666,
			zh = 4.6,
			en = 5.1
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
				arg_79_0:Play113101021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 1.00008890058234e-12 < arg_79_1.time_ and arg_79_1.time_ <= 1.00008890058234e-12 + arg_82_0 then
				arg_79_1.var_.moveOldPos1084ui_story = arg_79_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 1.00008890058234e-12 <= arg_79_1.time_ and arg_79_1.time_ < 1.00008890058234e-12 + var_82_0 then
				arg_79_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_79_1.time_ - 1.00008890058234e-12) / var_82_0)
				arg_79_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).z)
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles = arg_79_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 1.00008890058234e-12 + var_82_0 and arg_79_1.time_ < 1.00008890058234e-12 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["1084ui_story"].transform.position).z)
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["1084ui_story"].transform.localEulerAngles = arg_79_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["1041ui_story"].transform

			if 1.00008890058234e-12 < arg_79_1.time_ and arg_79_1.time_ <= 1.00008890058234e-12 + arg_82_0 then
				arg_79_1.var_.moveOldPos1041ui_story = var_82_1.localPosition
			end

			local var_82_2 = 0.001

			if 1.00008890058234e-12 <= arg_79_1.time_ and arg_79_1.time_ < 1.00008890058234e-12 + var_82_2 then
				var_82_1.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_79_1.time_ - 1.00008890058234e-12) / var_82_2)
				var_82_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_1.position).x, (manager.ui.mainCamera.transform.position - var_82_1.position).y, (manager.ui.mainCamera.transform.position - var_82_1.position).z)
				var_82_1.localEulerAngles.z = 0
				var_82_1.localEulerAngles.x = 0
				var_82_1.localEulerAngles = var_82_1.localEulerAngles
			end

			if arg_79_1.time_ >= 1.00008890058234e-12 + var_82_2 and arg_79_1.time_ < 1.00008890058234e-12 + var_82_2 + arg_82_0 then
				var_82_1.localPosition = Vector3.New(0, -1.11, -5.9)
				var_82_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_1.position).x, (manager.ui.mainCamera.transform.position - var_82_1.position).y, (manager.ui.mainCamera.transform.position - var_82_1.position).z)
				var_82_1.localEulerAngles.z = 0
				var_82_1.localEulerAngles.x = 0
				var_82_1.localEulerAngles = var_82_1.localEulerAngles
			end

			local var_82_3 = "1041ui_story"

			if arg_79_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_82_4 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_79_1.stage_.transform)

				var_82_4.name = var_82_3
				var_82_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_[var_82_3] = var_82_4

				local var_82_5 = var_82_4:GetComponentInChildren(typeof(CharacterEffect))

				var_82_5.enabled = true

				local var_82_6 = GameObjectTools.GetOrAddComponent(var_82_4, typeof(DynamicBoneHelper))

				if var_82_6 then
					var_82_6:EnableDynamicBone(false)
				end

				arg_79_1:ShowWeapon(var_82_5.transform, false)

				arg_79_1.var_[var_82_3 .. "Animator"] = var_82_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_79_1.var_[var_82_3 .. "Animator"].applyRootMotion = true
				arg_79_1.var_[var_82_3 .. "LipSync"] = var_82_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 1.00008890058234e-12 < arg_79_1.time_ and arg_79_1.time_ <= 1.00008890058234e-12 + arg_82_0 then
				arg_79_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			local var_82_7 = "1041ui_story"

			if arg_79_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_82_8 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_79_1.stage_.transform)

				var_82_8.name = var_82_7
				var_82_8.transform.localPosition = Vector3.New(0, 100, 0)
				arg_79_1.actors_[var_82_7] = var_82_8

				local var_82_9 = var_82_8:GetComponentInChildren(typeof(CharacterEffect))

				var_82_9.enabled = true

				local var_82_10 = GameObjectTools.GetOrAddComponent(var_82_8, typeof(DynamicBoneHelper))

				if var_82_10 then
					var_82_10:EnableDynamicBone(false)
				end

				arg_79_1:ShowWeapon(var_82_9.transform, false)

				arg_79_1.var_[var_82_7 .. "Animator"] = var_82_9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_79_1.var_[var_82_7 .. "Animator"].applyRootMotion = true
				arg_79_1.var_[var_82_7 .. "LipSync"] = var_82_9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 1.00008890058234e-12 < arg_79_1.time_ and arg_79_1.time_ <= 1.00008890058234e-12 + arg_82_0 then
				arg_79_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_82_11 = arg_79_1.actors_["1041ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_11) and arg_79_1.var_.characterEffect1041ui_story == nil then
				arg_79_1.var_.characterEffect1041ui_story = var_82_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_12 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_12 and not isNil(var_82_11) then
				if arg_79_1.var_.characterEffect1041ui_story and not isNil(var_82_11) then
					arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_12 and arg_79_1.time_ < 0 + var_82_12 + arg_82_0 and not isNil(var_82_11) and arg_79_1.var_.characterEffect1041ui_story then
				arg_79_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_82_14 = 0
			local var_82_15 = 0.525

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_14 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_16 = arg_79_1:GetWordFromCfg(113101020)
				local var_82_17 = arg_79_1:FormatText(var_82_16.content)

				arg_79_1.text_.text = var_82_17

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_19 = 21 <= 0 and var_82_15 or var_82_15 * (utf8.len(var_82_17) / 21)

				if (21 <= 0 and var_82_15 or var_82_15 * (utf8.len(var_82_17) / 21)) > 0 and var_82_15 < var_82_19 then
					arg_79_1.talkMaxDuration = var_82_19

					if var_82_19 + var_82_14 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_19 + var_82_14
					end
				end

				arg_79_1.text_.text = var_82_17
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113101", "113101020", "story_v_out_113101.awb") ~= 0 then
					local var_82_20 = manager.audio:GetVoiceLength("story_v_out_113101", "113101020", "story_v_out_113101.awb") / 1000

					if var_82_20 + var_82_14 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_20 + var_82_14
					end

					if var_82_16.prefab_name ~= "" and arg_79_1.actors_[var_82_16.prefab_name] ~= nil then
						local var_82_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_16.prefab_name].transform, "story_v_out_113101", "113101020", "story_v_out_113101.awb")

						arg_79_1:RecordAudio("113101020", var_82_21)
						arg_79_1:RecordAudio("113101020", var_82_21)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113101", "113101020", "story_v_out_113101.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113101", "113101020", "story_v_out_113101.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_22 = math.max(var_82_15, arg_79_1.talkMaxDuration)

			if var_82_14 <= arg_79_1.time_ and arg_79_1.time_ < var_82_14 + var_82_22 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_14) / var_82_22

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_14 + var_82_22 and arg_79_1.time_ < var_82_14 + var_82_22 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.00008890058234e-12,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play113101021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113101021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
			arg_83_1.auto_ = false
		end

		function arg_83_1.playNext_(arg_85_0)
			arg_83_1.onStoryFinished_()
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["1041ui_story"]) and arg_83_1.var_.characterEffect1041ui_story == nil then
				arg_83_1.var_.characterEffect1041ui_story = arg_83_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["1041ui_story"]) then
				if arg_83_1.var_.characterEffect1041ui_story and not isNil(arg_83_1.actors_["1041ui_story"]) then
					arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["1041ui_story"]) and arg_83_1.var_.characterEffect1041ui_story then
				arg_83_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_86_1 = 0
			local var_86_2 = 0.475

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_1 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_3 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(113101021).content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_5 = 19 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 19)

				if (19 <= 0 and var_86_2 or var_86_2 * (utf8.len(var_86_3) / 19)) > 0 and var_86_2 < var_86_5 then
					arg_83_1.talkMaxDuration = var_86_5

					if var_86_5 + var_86_1 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + var_86_1
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_6 = math.max(var_86_2, arg_83_1.talkMaxDuration)

			if var_86_1 <= arg_83_1.time_ and arg_83_1.time_ < var_86_1 + var_86_6 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_1) / var_86_6

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_1 + var_86_6 and arg_83_1.time_ < var_86_1 + var_86_6 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F03"
	},
	voices = {
		"story_v_out_113101.awb"
	}
}
