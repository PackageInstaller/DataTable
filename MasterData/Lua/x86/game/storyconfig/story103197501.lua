return {
	Play319751001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319751001
		arg_1_1.duration_ = 4.33

		local var_1_0 = {
			zh = 3.899999999999,
			ja = 4.332999999999
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
				arg_1_0:Play319751002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST71 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71")
				var_4_0.name = "ST71"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST71 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST71

				arg_1_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST71" then
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

			local var_4_9 = "10050ui_story"

			if arg_1_1.actors_["10050ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10050ui_story"))) then
				local var_4_10 = Object.Instantiate(Asset.Load("Char/" .. "10050ui_story"), arg_1_1.stage_.transform)

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

			local var_4_13 = arg_1_1.actors_["10050ui_story"].transform

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1.var_.moveOldPos10050ui_story = var_4_13.localPosition
			end

			local var_4_14 = 0.001

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_14 then
				var_4_13.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10050ui_story, Vector3.New(0, -0.715, -6.15), (arg_1_1.time_ - 1.9) / var_4_14)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			if arg_1_1.time_ >= 1.9 + var_4_14 and arg_1_1.time_ < 1.9 + var_4_14 + arg_4_0 then
				var_4_13.localPosition = Vector3.New(0, -0.715, -6.15)
				var_4_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_13.position).x, (manager.ui.mainCamera.transform.position - var_4_13.position).y, (manager.ui.mainCamera.transform.position - var_4_13.position).z)
				var_4_13.localEulerAngles.z = 0
				var_4_13.localEulerAngles.x = 0
				var_4_13.localEulerAngles = var_4_13.localEulerAngles
			end

			local var_4_15 = arg_1_1.actors_["10050ui_story"]

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10050ui_story == nil then
				arg_1_1.var_.characterEffect10050ui_story = var_4_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_16 = 0.200000002980232

			if 1.9 <= arg_1_1.time_ and arg_1_1.time_ < 1.9 + var_4_16 and not isNil(var_4_15) then
				if arg_1_1.var_.characterEffect10050ui_story and not isNil(var_4_15) then
					arg_1_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.9 + var_4_16 and arg_1_1.time_ < 1.9 + var_4_16 + arg_4_0 and not isNil(var_4_15) and arg_1_1.var_.characterEffect10050ui_story then
				arg_1_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action1_1")
			end

			if 1.9 < arg_1_1.time_ and arg_1_1.time_ <= 1.9 + arg_4_0 then
				arg_1_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_20 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_20 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_20

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_20
						arg_1_1.bgmTxt2_.text = var_4_20
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

			if 0.233333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.233333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room.awb")

				local var_4_23 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital_room", "bgm_activity_3_0_story_hospital_room")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 1.999999999999
			local var_4_25 = 0.175

			if 1.999999999999 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_26 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_26:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(319751001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 7 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 7)

				if (7 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 7)) > 0 and var_4_25 < var_4_30 then
					arg_1_1.talkMaxDuration = var_4_30
					var_4_24 = var_4_24 + 0.3

					if var_4_30 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_24
					end
				end

				arg_1_1.text_.text = var_4_28
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751001", "story_v_out_319751.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_319751", "319751001", "story_v_out_319751.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_319751", "319751001", "story_v_out_319751.awb")

						arg_1_1:RecordAudio("319751001", var_4_32)
						arg_1_1:RecordAudio("319751001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319751", "319751001", "story_v_out_319751.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319751", "319751001", "story_v_out_319751.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_33 = var_4_24 + 0.3
			local var_4_34 = math.max(var_4_25, arg_1_1.talkMaxDuration)

			if var_4_24 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_33 + var_4_34 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_33) / var_4_34

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_33 + var_4_34 and arg_1_1.time_ < var_4_33 + var_4_34 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.9,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319751002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319751002
		arg_9_1.duration_ = 4.4

		local var_9_0 = {
			zh = 2.266,
			ja = 4.4
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
				arg_9_0:Play319751003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1084ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1084ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1084ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1084ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1084ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.97, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_12_8 = arg_9_1.actors_["10050ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10050ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10050ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10050ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10050ui_story == nil then
				arg_9_1.var_.characterEffect10050ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10050ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10050ui_story then
				arg_9_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.225

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(319751002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 9 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 9)

				if (9 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 9)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751002", "story_v_out_319751.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_319751", "319751002", "story_v_out_319751.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_319751", "319751002", "story_v_out_319751.awb")

						arg_9_1:RecordAudio("319751002", var_12_19)
						arg_9_1:RecordAudio("319751002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319751", "319751002", "story_v_out_319751.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319751", "319751002", "story_v_out_319751.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_20 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 <= arg_9_1.time_ and arg_9_1.time_ < var_12_12 + var_12_20 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_12) / var_12_20

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_12 + var_12_20 and arg_9_1.time_ < var_12_12 + var_12_20 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play319751003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319751003
		arg_13_1.duration_ = 9.17

		local var_13_0 = {
			zh = 7.5,
			ja = 9.166
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
				arg_13_0:Play319751004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = arg_13_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) then
				if arg_13_1.var_.characterEffect1084ui_story and not isNil(arg_13_1.actors_["1084ui_story"]) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_16_1 = arg_13_1.actors_["10050ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10050ui_story == nil then
				arg_13_1.var_.characterEffect10050ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10050ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10050ui_story then
				arg_13_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_1")
			end

			local var_16_4 = 0
			local var_16_5 = 0.8

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_6 = arg_13_1:GetWordFromCfg(319751003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 32 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 32)

				if (32 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 32)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751003", "story_v_out_319751.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751003", "story_v_out_319751.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_319751", "319751003", "story_v_out_319751.awb")

						arg_13_1:RecordAudio("319751003", var_16_11)
						arg_13_1:RecordAudio("319751003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319751", "319751003", "story_v_out_319751.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319751", "319751003", "story_v_out_319751.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_12 = math.max(var_16_5, arg_13_1.talkMaxDuration)

			if var_16_4 <= arg_13_1.time_ and arg_13_1.time_ < var_16_4 + var_16_12 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_4) / var_16_12

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_4 + var_16_12 and arg_13_1.time_ < var_16_4 + var_16_12 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319751004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319751004
		arg_17_1.duration_ = 4.6

		local var_17_0 = {
			zh = 3.466,
			ja = 4.6
		}
		local var_17_1 = manager.audio:GetLocalizationFlag()

		if var_17_0[var_17_1] ~= nil then
			arg_17_1.duration_ = var_17_0[var_17_1]
		end

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319751005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = arg_17_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(arg_17_1.actors_["1084ui_story"]) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			local var_20_2 = arg_17_1.actors_["10050ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect10050ui_story == nil then
				arg_17_1.var_.characterEffect10050ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect10050ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect10050ui_story then
				arg_17_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.475

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(319751004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 19 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 19)

				if (19 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 19)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751004", "story_v_out_319751.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751004", "story_v_out_319751.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_319751", "319751004", "story_v_out_319751.awb")

						arg_17_1:RecordAudio("319751004", var_20_11)
						arg_17_1:RecordAudio("319751004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319751", "319751004", "story_v_out_319751.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319751", "319751004", "story_v_out_319751.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_12 = math.max(var_20_5, arg_17_1.talkMaxDuration)

			if var_20_4 <= arg_17_1.time_ and arg_17_1.time_ < var_20_4 + var_20_12 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_4) / var_20_12

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_4 + var_20_12 and arg_17_1.time_ < var_20_4 + var_20_12 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319751005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319751005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play319751006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1084ui_story = arg_21_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).z)
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles = arg_21_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1084ui_story"].transform.position).z)
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1084ui_story"].transform.localEulerAngles = arg_21_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["10050ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10050ui_story = var_24_1.localPosition
			end

			local var_24_2 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 then
				var_24_1.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10050ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_2)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 then
				var_24_1.localPosition = Vector3.New(0, 100, 0)
				var_24_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_1.position).x, (manager.ui.mainCamera.transform.position - var_24_1.position).y, (manager.ui.mainCamera.transform.position - var_24_1.position).z)
				var_24_1.localEulerAngles.z = 0
				var_24_1.localEulerAngles.x = 0
				var_24_1.localEulerAngles = var_24_1.localEulerAngles
			end

			local var_24_3 = 0
			local var_24_4 = 1.25

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_3 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_5 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(319751005).content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 50 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 50)

				if (50 <= 0 and var_24_4 or var_24_4 * (utf8.len(var_24_5) / 50)) > 0 and var_24_4 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_3 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_3
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_8 = math.max(var_24_4, arg_21_1.talkMaxDuration)

			if var_24_3 <= arg_21_1.time_ and arg_21_1.time_ < var_24_3 + var_24_8 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_3) / var_24_8

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_3 + var_24_8 and arg_21_1.time_ < var_24_3 + var_24_8 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play319751006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319751006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319751007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 1.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_1 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(319751006).content)

				arg_25_1.text_.text = var_28_1

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_3 = 48 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 48)

				if (48 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_1) / 48)) > 0 and var_28_0 < var_28_3 then
					arg_25_1.talkMaxDuration = var_28_3

					if var_28_3 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_3 + 0
					end
				end

				arg_25_1.text_.text = var_28_1
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_4 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_4

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319751007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319751007
		arg_29_1.duration_ = 8.83

		local var_29_0 = {
			zh = 8.8333333392938,
			ja = 8.1333333392938
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
				arg_29_0:Play319751008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 2.73333333631357 < arg_29_1.time_ and arg_29_1.time_ <= 2.73333333631357 + arg_32_0 then
				arg_29_1.var_.moveOldPos10050ui_story = arg_29_1.actors_["10050ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 2.73333333631357 <= arg_29_1.time_ and arg_29_1.time_ < 2.73333333631357 + var_32_0 then
				arg_29_1.actors_["10050ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10050ui_story, Vector3.New(0, -0.715, -6.15), (arg_29_1.time_ - 2.73333333631357) / var_32_0)
				arg_29_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10050ui_story"].transform.position).z)
				arg_29_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10050ui_story"].transform.localEulerAngles = arg_29_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 2.73333333631357 + var_32_0 and arg_29_1.time_ < 2.73333333631357 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10050ui_story"].transform.localPosition = Vector3.New(0, -0.715, -6.15)
				arg_29_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10050ui_story"].transform.position).z)
				arg_29_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10050ui_story"].transform.localEulerAngles = arg_29_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10050ui_story"]

			if 2.73333333631357 < arg_29_1.time_ and arg_29_1.time_ <= 2.73333333631357 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10050ui_story == nil then
				arg_29_1.var_.characterEffect10050ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 2.73333333631357 <= arg_29_1.time_ and arg_29_1.time_ < 2.73333333631357 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10050ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 2.73333333631357 + var_32_2 and arg_29_1.time_ < 2.73333333631357 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10050ui_story then
				arg_29_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 1 < arg_29_1.time_ and arg_29_1.time_ <= 1 + arg_32_0 then
				local var_32_4 = arg_29_1.bgs_.ST71

				arg_29_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_32_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_32_5 = var_32_4:GetComponent("SpriteRenderer")

				if var_32_5 and var_32_5.sprite then
					local var_32_6 = 2 * (var_32_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_32_4.transform.localScale = Vector3.New(var_32_6 / var_32_5.sprite.bounds.size.y < var_32_6 * manager.ui.mainCameraCom_.aspect / var_32_5.sprite.bounds.size.x and var_32_6 * manager.ui.mainCameraCom_.aspect / var_32_5.sprite.bounds.size.x or var_32_6 / var_32_5.sprite.bounds.size.y, var_32_6 / var_32_5.sprite.bounds.size.y < var_32_6 * manager.ui.mainCameraCom_.aspect / var_32_5.sprite.bounds.size.x and var_32_6 * manager.ui.mainCameraCom_.aspect / var_32_5.sprite.bounds.size.x or var_32_6 / var_32_5.sprite.bounds.size.y, 0)
				end

				for iter_32_0, iter_32_1 in pairs(arg_29_1.bgs_) do
					if iter_32_0 ~= "ST71" then
						iter_32_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_32_7 = 0

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_7 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_8 = 1

			if var_32_7 <= arg_29_1.time_ and arg_29_1.time_ < var_32_7 + var_32_8 then
				local var_32_9 = Color.New(0, 0, 0)

				var_32_9.a = Mathf.Lerp(0, 1, (arg_29_1.time_ - var_32_7) / var_32_8)
				arg_29_1.mask_.color = var_32_9
			end

			if arg_29_1.time_ >= var_32_7 + var_32_8 and arg_29_1.time_ < var_32_7 + var_32_8 + arg_32_0 then
				local var_32_10 = Color.New(0, 0, 0)

				var_32_10.a = 1
				arg_29_1.mask_.color = var_32_10
			end

			local var_32_11 = 1

			if 1 < arg_29_1.time_ and arg_29_1.time_ <= var_32_11 + arg_32_0 then
				arg_29_1.mask_.enabled = true
				arg_29_1.mask_.raycastTarget = true

				arg_29_1:SetGaussion(false)
			end

			local var_32_12 = 2

			if var_32_11 <= arg_29_1.time_ and arg_29_1.time_ < var_32_11 + var_32_12 then
				local var_32_13 = Color.New(0, 0, 0)

				var_32_13.a = Mathf.Lerp(1, 0, (arg_29_1.time_ - var_32_11) / var_32_12)
				arg_29_1.mask_.color = var_32_13
			end

			if arg_29_1.time_ >= var_32_11 + var_32_12 and arg_29_1.time_ < var_32_11 + var_32_12 + arg_32_0 then
				local var_32_14 = Color.New(0, 0, 0)

				arg_29_1.mask_.enabled = false
				var_32_14.a = 0
				arg_29_1.mask_.color = var_32_14
			end

			if arg_29_1.frameCnt_ <= 1 then
				arg_29_1.dialog_:SetActive(false)
			end

			local var_32_15 = 2.9333333392938
			local var_32_16 = 0.6

			if 2.9333333392938 < arg_29_1.time_ and arg_29_1.time_ <= var_32_15 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0

				arg_29_1.dialog_:SetActive(true)

				arg_29_1.dialogCg_.alpha = 0

				local var_32_17 = LeanTween.value(arg_29_1.dialog_, 0, 1, 0.3)

				var_32_17:setOnUpdate(LuaHelper.FloatAction(function(arg_33_0)
					arg_29_1.dialogCg_.alpha = arg_33_0
				end))
				var_32_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_29_1.dialog_)
					var_32_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_29_1.duration_ = arg_29_1.duration_ + 0.3

				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_18 = arg_29_1:GetWordFromCfg(319751007)
				local var_32_19 = arg_29_1:FormatText(var_32_18.content)

				arg_29_1.text_.text = var_32_19

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_21 = 24 <= 0 and var_32_16 or var_32_16 * (utf8.len(var_32_19) / 24)

				if (24 <= 0 and var_32_16 or var_32_16 * (utf8.len(var_32_19) / 24)) > 0 and var_32_16 < var_32_21 then
					arg_29_1.talkMaxDuration = var_32_21
					var_32_15 = var_32_15 + 0.3

					if var_32_21 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_21 + var_32_15
					end
				end

				arg_29_1.text_.text = var_32_19
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751007", "story_v_out_319751.awb") ~= 0 then
					local var_32_22 = manager.audio:GetVoiceLength("story_v_out_319751", "319751007", "story_v_out_319751.awb") / 1000

					if var_32_22 + var_32_15 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_22 + var_32_15
					end

					if var_32_18.prefab_name ~= "" and arg_29_1.actors_[var_32_18.prefab_name] ~= nil then
						local var_32_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_18.prefab_name].transform, "story_v_out_319751", "319751007", "story_v_out_319751.awb")

						arg_29_1:RecordAudio("319751007", var_32_23)
						arg_29_1:RecordAudio("319751007", var_32_23)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319751", "319751007", "story_v_out_319751.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319751", "319751007", "story_v_out_319751.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_24 = var_32_15 + 0.3
			local var_32_25 = math.max(var_32_16, arg_29_1.talkMaxDuration)

			if var_32_15 + 0.3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_24 + var_32_25 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_24) / var_32_25

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_24 + var_32_25 and arg_29_1.time_ < var_32_24 + var_32_25 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2.73333333631357,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play319751008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 319751008
		arg_35_1.duration_ = 2.33

		local var_35_0 = {
			zh = 1.9,
			ja = 2.333
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
				arg_35_0:Play319751009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(arg_35_1.actors_["10050ui_story"]) and arg_35_1.var_.characterEffect10050ui_story == nil then
				arg_35_1.var_.characterEffect10050ui_story = arg_35_1.actors_["10050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_0 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 and not isNil(arg_35_1.actors_["10050ui_story"]) then
				if arg_35_1.var_.characterEffect10050ui_story and not isNil(arg_35_1.actors_["10050ui_story"]) then
					arg_35_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_35_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_0)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 and not isNil(arg_35_1.actors_["10050ui_story"]) and arg_35_1.var_.characterEffect10050ui_story then
				arg_35_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_35_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_38_1 = 0
			local var_38_2 = 0.125

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[192].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_3 = arg_35_1:GetWordFromCfg(319751008)
				local var_38_4 = arg_35_1:FormatText(var_38_3.content)

				arg_35_1.text_.text = var_38_4

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_6 = 5 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_4) / 5)

				if (5 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_4) / 5)) > 0 and var_38_2 < var_38_6 then
					arg_35_1.talkMaxDuration = var_38_6

					if var_38_6 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_6 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_4
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751008", "story_v_out_319751.awb") ~= 0 then
					local var_38_7 = manager.audio:GetVoiceLength("story_v_out_319751", "319751008", "story_v_out_319751.awb") / 1000

					if var_38_7 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_1
					end

					if var_38_3.prefab_name ~= "" and arg_35_1.actors_[var_38_3.prefab_name] ~= nil then
						local var_38_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_35_1.actors_[var_38_3.prefab_name].transform, "story_v_out_319751", "319751008", "story_v_out_319751.awb")

						arg_35_1:RecordAudio("319751008", var_38_8)
						arg_35_1:RecordAudio("319751008", var_38_8)
					else
						arg_35_1:AudioAction("play", "voice", "story_v_out_319751", "319751008", "story_v_out_319751.awb")
					end

					arg_35_1:RecordHistoryTalkVoice("story_v_out_319751", "319751008", "story_v_out_319751.awb")
				end

				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_9 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_9 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_9

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_9 and arg_35_1.time_ < var_38_1 + var_38_9 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play319751009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 319751009
		arg_39_1.duration_ = 7.2

		local var_39_0 = {
			zh = 7.2,
			ja = 2.466
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
				arg_39_0:Play319751010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.5

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[192].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:GetWordFromCfg(319751009)
				local var_42_2 = arg_39_1:FormatText(var_42_1.content)

				arg_39_1.text_.text = var_42_2

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_4 = 20 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 20)

				if (20 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_2) / 20)) > 0 and var_42_0 < var_42_4 then
					arg_39_1.talkMaxDuration = var_42_4

					if var_42_4 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_4 + 0
					end
				end

				arg_39_1.text_.text = var_42_2
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751009", "story_v_out_319751.awb") ~= 0 then
					local var_42_5 = manager.audio:GetVoiceLength("story_v_out_319751", "319751009", "story_v_out_319751.awb") / 1000

					if var_42_5 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_5 + 0
					end

					if var_42_1.prefab_name ~= "" and arg_39_1.actors_[var_42_1.prefab_name] ~= nil then
						local var_42_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_1.prefab_name].transform, "story_v_out_319751", "319751009", "story_v_out_319751.awb")

						arg_39_1:RecordAudio("319751009", var_42_6)
						arg_39_1:RecordAudio("319751009", var_42_6)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_319751", "319751009", "story_v_out_319751.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_319751", "319751009", "story_v_out_319751.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_7 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_7 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_7

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_7 and arg_39_1.time_ < 0 + var_42_7 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play319751010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 319751010
		arg_43_1.duration_ = 2.97

		local var_43_0 = {
			zh = 1.999999999999,
			ja = 2.966
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
				arg_43_0:Play319751011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action4_2")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_46_0 = arg_43_1.actors_["10050ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect10050ui_story == nil then
				arg_43_1.var_.characterEffect10050ui_story = var_46_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_1 = 0.133333339293798

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_1 and not isNil(var_46_0) then
				if arg_43_1.var_.characterEffect10050ui_story and not isNil(var_46_0) then
					arg_43_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_1 and arg_43_1.time_ < 0 + var_46_1 + arg_46_0 and not isNil(var_46_0) and arg_43_1.var_.characterEffect10050ui_story then
				arg_43_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_46_3 = 0
			local var_46_4 = 0.175

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_3 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_5 = arg_43_1:GetWordFromCfg(319751010)
				local var_46_6 = arg_43_1:FormatText(var_46_5.content)

				arg_43_1.text_.text = var_46_6

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_8 = 7 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_6) / 7)

				if (7 <= 0 and var_46_4 or var_46_4 * (utf8.len(var_46_6) / 7)) > 0 and var_46_4 < var_46_8 then
					arg_43_1.talkMaxDuration = var_46_8

					if var_46_8 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_3
					end
				end

				arg_43_1.text_.text = var_46_6
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751010", "story_v_out_319751.awb") ~= 0 then
					local var_46_9 = manager.audio:GetVoiceLength("story_v_out_319751", "319751010", "story_v_out_319751.awb") / 1000

					if var_46_9 + var_46_3 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_9 + var_46_3
					end

					if var_46_5.prefab_name ~= "" and arg_43_1.actors_[var_46_5.prefab_name] ~= nil then
						local var_46_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_5.prefab_name].transform, "story_v_out_319751", "319751010", "story_v_out_319751.awb")

						arg_43_1:RecordAudio("319751010", var_46_10)
						arg_43_1:RecordAudio("319751010", var_46_10)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_319751", "319751010", "story_v_out_319751.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_319751", "319751010", "story_v_out_319751.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_11 = math.max(var_46_4, arg_43_1.talkMaxDuration)

			if var_46_3 <= arg_43_1.time_ and arg_43_1.time_ < var_46_3 + var_46_11 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_3) / var_46_11

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_3 + var_46_11 and arg_43_1.time_ < var_46_3 + var_46_11 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play319751011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 319751011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play319751012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["10050ui_story"]) and arg_47_1.var_.characterEffect10050ui_story == nil then
				arg_47_1.var_.characterEffect10050ui_story = arg_47_1.actors_["10050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["10050ui_story"]) then
				if arg_47_1.var_.characterEffect10050ui_story and not isNil(arg_47_1.actors_["10050ui_story"]) then
					arg_47_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_47_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["10050ui_story"]) and arg_47_1.var_.characterEffect10050ui_story then
				arg_47_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_47_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.85

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

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(319751011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 34 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 34)

				if (34 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 34)) > 0 and var_50_2 < var_50_5 then
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
	Play319751012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 319751012
		arg_51_1.duration_ = 3.27

		local var_51_0 = {
			zh = 3.266,
			ja = 3.166
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
				arg_51_0:Play319751013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(arg_51_1.actors_["10050ui_story"]) and arg_51_1.var_.characterEffect10050ui_story == nil then
				arg_51_1.var_.characterEffect10050ui_story = arg_51_1.actors_["10050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_0 = 0.200000002980232

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_0 and not isNil(arg_51_1.actors_["10050ui_story"]) then
				if arg_51_1.var_.characterEffect10050ui_story and not isNil(arg_51_1.actors_["10050ui_story"]) then
					arg_51_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_0 and arg_51_1.time_ < 0 + var_54_0 + arg_54_0 and not isNil(arg_51_1.actors_["10050ui_story"]) and arg_51_1.var_.characterEffect10050ui_story then
				arg_51_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_54_2 = 0
			local var_54_3 = 0.375

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_2 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_4 = arg_51_1:GetWordFromCfg(319751012)
				local var_54_5 = arg_51_1:FormatText(var_54_4.content)

				arg_51_1.text_.text = var_54_5

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_7 = 15 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 15)

				if (15 <= 0 and var_54_3 or var_54_3 * (utf8.len(var_54_5) / 15)) > 0 and var_54_3 < var_54_7 then
					arg_51_1.talkMaxDuration = var_54_7

					if var_54_7 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_7 + var_54_2
					end
				end

				arg_51_1.text_.text = var_54_5
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751012", "story_v_out_319751.awb") ~= 0 then
					local var_54_8 = manager.audio:GetVoiceLength("story_v_out_319751", "319751012", "story_v_out_319751.awb") / 1000

					if var_54_8 + var_54_2 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_8 + var_54_2
					end

					if var_54_4.prefab_name ~= "" and arg_51_1.actors_[var_54_4.prefab_name] ~= nil then
						local var_54_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_4.prefab_name].transform, "story_v_out_319751", "319751012", "story_v_out_319751.awb")

						arg_51_1:RecordAudio("319751012", var_54_9)
						arg_51_1:RecordAudio("319751012", var_54_9)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_319751", "319751012", "story_v_out_319751.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_319751", "319751012", "story_v_out_319751.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_10 = math.max(var_54_3, arg_51_1.talkMaxDuration)

			if var_54_2 <= arg_51_1.time_ and arg_51_1.time_ < var_54_2 + var_54_10 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_2) / var_54_10

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_2 + var_54_10 and arg_51_1.time_ < var_54_2 + var_54_10 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play319751013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 319751013
		arg_55_1.duration_ = 8.9

		local var_55_0 = {
			zh = 6.633,
			ja = 8.9
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
				arg_55_0:Play319751014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos1084ui_story = arg_55_1.actors_["1084ui_story"].transform.localPosition

				arg_55_1:ShowWeapon(arg_55_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_58_0 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 then
				arg_55_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_55_1.time_ - 0) / var_58_0)
				arg_55_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).z)
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles = arg_55_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 then
				arg_55_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_55_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["1084ui_story"].transform.position).z)
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["1084ui_story"].transform.localEulerAngles = arg_55_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_58_1 = arg_55_1.actors_["1084ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1084ui_story == nil then
				arg_55_1.var_.characterEffect1084ui_story = var_58_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_2 and not isNil(var_58_1) then
				if arg_55_1.var_.characterEffect1084ui_story and not isNil(var_58_1) then
					arg_55_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_2 and arg_55_1.time_ < 0 + var_58_2 + arg_58_0 and not isNil(var_58_1) and arg_55_1.var_.characterEffect1084ui_story then
				arg_55_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_58_4 = arg_55_1.actors_["10050ui_story"].transform

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos10050ui_story = var_58_4.localPosition
			end

			local var_58_5 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_5 then
				var_58_4.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos10050ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_55_1.time_ - 0) / var_58_5)
				var_58_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_4.position).x, (manager.ui.mainCamera.transform.position - var_58_4.position).y, (manager.ui.mainCamera.transform.position - var_58_4.position).z)
				var_58_4.localEulerAngles.z = 0
				var_58_4.localEulerAngles.x = 0
				var_58_4.localEulerAngles = var_58_4.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_5 and arg_55_1.time_ < 0 + var_58_5 + arg_58_0 then
				var_58_4.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				var_58_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_58_4.position).x, (manager.ui.mainCamera.transform.position - var_58_4.position).y, (manager.ui.mainCamera.transform.position - var_58_4.position).z)
				var_58_4.localEulerAngles.z = 0
				var_58_4.localEulerAngles.x = 0
				var_58_4.localEulerAngles = var_58_4.localEulerAngles
			end

			local var_58_6 = arg_55_1.actors_["10050ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect10050ui_story == nil then
				arg_55_1.var_.characterEffect10050ui_story = var_58_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_7 = 0.200000002980232

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_7 and not isNil(var_58_6) then
				if arg_55_1.var_.characterEffect10050ui_story and not isNil(var_58_6) then
					arg_55_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_7)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_7 and arg_55_1.time_ < 0 + var_58_7 + arg_58_0 and not isNil(var_58_6) and arg_55_1.var_.characterEffect10050ui_story then
				arg_55_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			local var_58_8 = 0
			local var_58_9 = 0.9

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_8 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_10 = arg_55_1:GetWordFromCfg(319751013)
				local var_58_11 = arg_55_1:FormatText(var_58_10.content)

				arg_55_1.text_.text = var_58_11

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_13 = 36 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 36)

				if (36 <= 0 and var_58_9 or var_58_9 * (utf8.len(var_58_11) / 36)) > 0 and var_58_9 < var_58_13 then
					arg_55_1.talkMaxDuration = var_58_13

					if var_58_13 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_13 + var_58_8
					end
				end

				arg_55_1.text_.text = var_58_11
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751013", "story_v_out_319751.awb") ~= 0 then
					local var_58_14 = manager.audio:GetVoiceLength("story_v_out_319751", "319751013", "story_v_out_319751.awb") / 1000

					if var_58_14 + var_58_8 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_14 + var_58_8
					end

					if var_58_10.prefab_name ~= "" and arg_55_1.actors_[var_58_10.prefab_name] ~= nil then
						local var_58_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_10.prefab_name].transform, "story_v_out_319751", "319751013", "story_v_out_319751.awb")

						arg_55_1:RecordAudio("319751013", var_58_15)
						arg_55_1:RecordAudio("319751013", var_58_15)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_319751", "319751013", "story_v_out_319751.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_319751", "319751013", "story_v_out_319751.awb")
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
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_55_1:InitPlayNodeList()
	end,
	Play319751014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 319751014
		arg_59_1.duration_ = 5.27

		local var_59_0 = {
			zh = 4.133,
			ja = 5.266
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
				arg_59_0:Play319751015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(arg_59_1.actors_["1084ui_story"]) and arg_59_1.var_.characterEffect1084ui_story == nil then
				arg_59_1.var_.characterEffect1084ui_story = arg_59_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_0 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 and not isNil(arg_59_1.actors_["1084ui_story"]) then
				if arg_59_1.var_.characterEffect1084ui_story and not isNil(arg_59_1.actors_["1084ui_story"]) then
					arg_59_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_59_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_0)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 and not isNil(arg_59_1.actors_["1084ui_story"]) and arg_59_1.var_.characterEffect1084ui_story then
				arg_59_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_59_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_62_1 = arg_59_1.actors_["10050ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10050ui_story == nil then
				arg_59_1.var_.characterEffect10050ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.133333339293798

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect10050ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect10050ui_story then
				arg_59_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_62_4 = 0
			local var_62_5 = 0.45

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_4 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_6 = arg_59_1:GetWordFromCfg(319751014)
				local var_62_7 = arg_59_1:FormatText(var_62_6.content)

				arg_59_1.text_.text = var_62_7

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_9 = 18 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 18)

				if (18 <= 0 and var_62_5 or var_62_5 * (utf8.len(var_62_7) / 18)) > 0 and var_62_5 < var_62_9 then
					arg_59_1.talkMaxDuration = var_62_9

					if var_62_9 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_4
					end
				end

				arg_59_1.text_.text = var_62_7
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751014", "story_v_out_319751.awb") ~= 0 then
					local var_62_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751014", "story_v_out_319751.awb") / 1000

					if var_62_10 + var_62_4 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_10 + var_62_4
					end

					if var_62_6.prefab_name ~= "" and arg_59_1.actors_[var_62_6.prefab_name] ~= nil then
						local var_62_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_6.prefab_name].transform, "story_v_out_319751", "319751014", "story_v_out_319751.awb")

						arg_59_1:RecordAudio("319751014", var_62_11)
						arg_59_1:RecordAudio("319751014", var_62_11)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_319751", "319751014", "story_v_out_319751.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_319751", "319751014", "story_v_out_319751.awb")
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
	Play319751015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 319751015
		arg_63_1.duration_ = 9.73

		local var_63_0 = {
			zh = 5.166,
			ja = 9.733
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
				arg_63_0:Play319751016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1084ui_story"]) and arg_63_1.var_.characterEffect1084ui_story == nil then
				arg_63_1.var_.characterEffect1084ui_story = arg_63_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1084ui_story"]) then
				if arg_63_1.var_.characterEffect1084ui_story and not isNil(arg_63_1.actors_["1084ui_story"]) then
					arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1084ui_story"]) and arg_63_1.var_.characterEffect1084ui_story then
				arg_63_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_66_2 = arg_63_1.actors_["10050ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect10050ui_story == nil then
				arg_63_1.var_.characterEffect10050ui_story = var_66_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_3 = 0.133333339293798

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_3 and not isNil(var_66_2) then
				if arg_63_1.var_.characterEffect10050ui_story and not isNil(var_66_2) then
					arg_63_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_63_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_3)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_3 and arg_63_1.time_ < 0 + var_66_3 + arg_66_0 and not isNil(var_66_2) and arg_63_1.var_.characterEffect10050ui_story then
				arg_63_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_63_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_66_4 = 0
			local var_66_5 = 0.65

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(319751015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 26 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 26)

				if (26 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 26)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751015", "story_v_out_319751.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751015", "story_v_out_319751.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_319751", "319751015", "story_v_out_319751.awb")

						arg_63_1:RecordAudio("319751015", var_66_11)
						arg_63_1:RecordAudio("319751015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_319751", "319751015", "story_v_out_319751.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_319751", "319751015", "story_v_out_319751.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_12 = math.max(var_66_5, arg_63_1.talkMaxDuration)

			if var_66_4 <= arg_63_1.time_ and arg_63_1.time_ < var_66_4 + var_66_12 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_4) / var_66_12

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_4 + var_66_12 and arg_63_1.time_ < var_66_4 + var_66_12 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play319751016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 319751016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play319751017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(arg_67_1.actors_["1084ui_story"]) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = arg_67_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_0 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 and not isNil(arg_67_1.actors_["1084ui_story"]) then
				if arg_67_1.var_.characterEffect1084ui_story and not isNil(arg_67_1.actors_["1084ui_story"]) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_0)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 and not isNil(arg_67_1.actors_["1084ui_story"]) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_70_1 = 0
			local var_70_2 = 1.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_1 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, false)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_3 = arg_67_1:FormatText(arg_67_1:GetWordFromCfg(319751016).content)

				arg_67_1.text_.text = var_70_3

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 52 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 52)

				if (52 <= 0 and var_70_2 or var_70_2 * (utf8.len(var_70_3) / 52)) > 0 and var_70_2 < var_70_5 then
					arg_67_1.talkMaxDuration = var_70_5

					if var_70_5 + var_70_1 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_5 + var_70_1
					end
				end

				arg_67_1.text_.text = var_70_3
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)
				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_6 = math.max(var_70_2, arg_67_1.talkMaxDuration)

			if var_70_1 <= arg_67_1.time_ and arg_67_1.time_ < var_70_1 + var_70_6 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_1) / var_70_6

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_1 + var_70_6 and arg_67_1.time_ < var_70_1 + var_70_6 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {}

		arg_67_1:InitPlayNodeList()
	end,
	Play319751017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 319751017
		arg_71_1.duration_ = 5.3

		local var_71_0 = {
			zh = 4,
			ja = 5.3
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
				arg_71_0:Play319751018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10050ui_story = arg_71_1.actors_["10050ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10050ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10050ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10050ui_story"].transform.position).z)
				arg_71_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10050ui_story"].transform.localEulerAngles = arg_71_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10050ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_71_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10050ui_story"].transform.position).z)
				arg_71_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10050ui_story"].transform.localEulerAngles = arg_71_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10050ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10050ui_story == nil then
				arg_71_1.var_.characterEffect10050ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10050ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10050ui_story then
				arg_71_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_1")
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_74_4 = 0
			local var_74_5 = 0.475

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_4 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_6 = arg_71_1:GetWordFromCfg(319751017)
				local var_74_7 = arg_71_1:FormatText(var_74_6.content)

				arg_71_1.text_.text = var_74_7

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_9 = 19 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 19)

				if (19 <= 0 and var_74_5 or var_74_5 * (utf8.len(var_74_7) / 19)) > 0 and var_74_5 < var_74_9 then
					arg_71_1.talkMaxDuration = var_74_9

					if var_74_9 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_9 + var_74_4
					end
				end

				arg_71_1.text_.text = var_74_7
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751017", "story_v_out_319751.awb") ~= 0 then
					local var_74_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751017", "story_v_out_319751.awb") / 1000

					if var_74_10 + var_74_4 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_10 + var_74_4
					end

					if var_74_6.prefab_name ~= "" and arg_71_1.actors_[var_74_6.prefab_name] ~= nil then
						local var_74_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_6.prefab_name].transform, "story_v_out_319751", "319751017", "story_v_out_319751.awb")

						arg_71_1:RecordAudio("319751017", var_74_11)
						arg_71_1:RecordAudio("319751017", var_74_11)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_319751", "319751017", "story_v_out_319751.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_319751", "319751017", "story_v_out_319751.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_12 = math.max(var_74_5, arg_71_1.talkMaxDuration)

			if var_74_4 <= arg_71_1.time_ and arg_71_1.time_ < var_74_4 + var_74_12 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_4) / var_74_12

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_4 + var_74_12 and arg_71_1.time_ < var_74_4 + var_74_12 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play319751018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319751018
		arg_75_1.duration_ = 10.53

		local var_75_0 = {
			zh = 10.533,
			ja = 6.7
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319751019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1084ui_story = arg_75_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).z)
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles = arg_75_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_75_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["1084ui_story"].transform.position).z)
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["1084ui_story"].transform.localEulerAngles = arg_75_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1084ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_2 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 and not isNil(var_78_1) then
				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_1) then
					arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 and not isNil(var_78_1) and arg_75_1.var_.characterEffect1084ui_story then
				arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_78_4 = arg_75_1.actors_["10050ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10050ui_story == nil then
				arg_75_1.var_.characterEffect10050ui_story = var_78_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_5 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_5 and not isNil(var_78_4) then
				if arg_75_1.var_.characterEffect10050ui_story and not isNil(var_78_4) then
					arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_75_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_5)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_5 and arg_75_1.time_ < 0 + var_78_5 + arg_78_0 and not isNil(var_78_4) and arg_75_1.var_.characterEffect10050ui_story then
				arg_75_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_75_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_78_6 = 0
			local var_78_7 = 1.1

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_6 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_8 = arg_75_1:GetWordFromCfg(319751018)
				local var_78_9 = arg_75_1:FormatText(var_78_8.content)

				arg_75_1.text_.text = var_78_9

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_11 = 44 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 44)

				if (44 <= 0 and var_78_7 or var_78_7 * (utf8.len(var_78_9) / 44)) > 0 and var_78_7 < var_78_11 then
					arg_75_1.talkMaxDuration = var_78_11

					if var_78_11 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_11 + var_78_6
					end
				end

				arg_75_1.text_.text = var_78_9
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751018", "story_v_out_319751.awb") ~= 0 then
					local var_78_12 = manager.audio:GetVoiceLength("story_v_out_319751", "319751018", "story_v_out_319751.awb") / 1000

					if var_78_12 + var_78_6 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_12 + var_78_6
					end

					if var_78_8.prefab_name ~= "" and arg_75_1.actors_[var_78_8.prefab_name] ~= nil then
						local var_78_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_8.prefab_name].transform, "story_v_out_319751", "319751018", "story_v_out_319751.awb")

						arg_75_1:RecordAudio("319751018", var_78_13)
						arg_75_1:RecordAudio("319751018", var_78_13)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_319751", "319751018", "story_v_out_319751.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_319751", "319751018", "story_v_out_319751.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_14 = math.max(var_78_7, arg_75_1.talkMaxDuration)

			if var_78_6 <= arg_75_1.time_ and arg_75_1.time_ < var_78_6 + var_78_14 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_6) / var_78_14

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_6 + var_78_14 and arg_75_1.time_ < var_78_6 + var_78_14 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
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

		arg_75_1:InitPlayNodeList()
	end,
	Play319751019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319751019
		arg_79_1.duration_ = 9.03

		local var_79_0 = {
			zh = 4.833,
			ja = 9.033
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
				arg_79_0:Play319751020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action467")
			end

			local var_82_0 = 0
			local var_82_1 = 0.525

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_2 = arg_79_1:GetWordFromCfg(319751019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 21 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 21)

				if (21 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 21)) > 0 and var_82_1 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751019", "story_v_out_319751.awb") ~= 0 then
					local var_82_6 = manager.audio:GetVoiceLength("story_v_out_319751", "319751019", "story_v_out_319751.awb") / 1000

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end

					if var_82_2.prefab_name ~= "" and arg_79_1.actors_[var_82_2.prefab_name] ~= nil then
						local var_82_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_2.prefab_name].transform, "story_v_out_319751", "319751019", "story_v_out_319751.awb")

						arg_79_1:RecordAudio("319751019", var_82_7)
						arg_79_1:RecordAudio("319751019", var_82_7)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319751", "319751019", "story_v_out_319751.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319751", "319751019", "story_v_out_319751.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play319751020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319751020
		arg_83_1.duration_ = 6

		local var_83_0 = {
			zh = 4.133,
			ja = 6
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
				arg_83_0:Play319751021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action2_2")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_86_0 = arg_83_1.actors_["1084ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_1 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 and not isNil(var_86_0) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_1)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_86_2 = arg_83_1.actors_["10050ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect10050ui_story == nil then
				arg_83_1.var_.characterEffect10050ui_story = var_86_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_3 = 0.133333339293798

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_3 and not isNil(var_86_2) then
				if arg_83_1.var_.characterEffect10050ui_story and not isNil(var_86_2) then
					arg_83_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_3 and arg_83_1.time_ < 0 + var_86_3 + arg_86_0 and not isNil(var_86_2) and arg_83_1.var_.characterEffect10050ui_story then
				arg_83_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			local var_86_5 = 0
			local var_86_6 = 0.35

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(319751020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 14 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 14)

				if (14 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 14)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751020", "story_v_out_319751.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_319751", "319751020", "story_v_out_319751.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_319751", "319751020", "story_v_out_319751.awb")

						arg_83_1:RecordAudio("319751020", var_86_12)
						arg_83_1:RecordAudio("319751020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_319751", "319751020", "story_v_out_319751.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_319751", "319751020", "story_v_out_319751.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_13 = math.max(var_86_6, arg_83_1.talkMaxDuration)

			if var_86_5 <= arg_83_1.time_ and arg_83_1.time_ < var_86_5 + var_86_13 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_5) / var_86_13

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_5 + var_86_13 and arg_83_1.time_ < var_86_5 + var_86_13 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319751021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319751021
		arg_87_1.duration_ = 10.63

		local var_87_0 = {
			zh = 6.866,
			ja = 10.633
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
				arg_87_0:Play319751022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1084ui_story"]) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = arg_87_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1084ui_story"]) then
				if arg_87_1.var_.characterEffect1084ui_story and not isNil(arg_87_1.actors_["1084ui_story"]) then
					arg_87_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1084ui_story"]) and arg_87_1.var_.characterEffect1084ui_story then
				arg_87_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_90_2 = arg_87_1.actors_["10050ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect10050ui_story == nil then
				arg_87_1.var_.characterEffect10050ui_story = var_90_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_3 = 0.133333339293798

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_3 and not isNil(var_90_2) then
				if arg_87_1.var_.characterEffect10050ui_story and not isNil(var_90_2) then
					arg_87_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_87_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_3)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_3 and arg_87_1.time_ < 0 + var_90_3 + arg_90_0 and not isNil(var_90_2) and arg_87_1.var_.characterEffect10050ui_story then
				arg_87_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_87_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_90_4 = 0
			local var_90_5 = 0.725

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
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

				local var_90_6 = arg_87_1:GetWordFromCfg(319751021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 29 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 29)

				if (29 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 29)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751021", "story_v_out_319751.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751021", "story_v_out_319751.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_319751", "319751021", "story_v_out_319751.awb")

						arg_87_1:RecordAudio("319751021", var_90_11)
						arg_87_1:RecordAudio("319751021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319751", "319751021", "story_v_out_319751.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319751", "319751021", "story_v_out_319751.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_12 = math.max(var_90_5, arg_87_1.talkMaxDuration)

			if var_90_4 <= arg_87_1.time_ and arg_87_1.time_ < var_90_4 + var_90_12 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_4) / var_90_12

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_4 + var_90_12 and arg_87_1.time_ < var_90_4 + var_90_12 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play319751022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319751022
		arg_91_1.duration_ = 10.1

		local var_91_0 = {
			zh = 8.766,
			ja = 10.1
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play319751023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action478")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_94_0 = 0
			local var_94_1 = 0.925

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_0 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_2 = arg_91_1:GetWordFromCfg(319751022)
				local var_94_3 = arg_91_1:FormatText(var_94_2.content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 38 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_3) / 38)

				if (38 <= 0 and var_94_1 or var_94_1 * (utf8.len(var_94_3) / 38)) > 0 and var_94_1 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_0
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751022", "story_v_out_319751.awb") ~= 0 then
					local var_94_6 = manager.audio:GetVoiceLength("story_v_out_319751", "319751022", "story_v_out_319751.awb") / 1000

					if var_94_6 + var_94_0 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_6 + var_94_0
					end

					if var_94_2.prefab_name ~= "" and arg_91_1.actors_[var_94_2.prefab_name] ~= nil then
						local var_94_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_2.prefab_name].transform, "story_v_out_319751", "319751022", "story_v_out_319751.awb")

						arg_91_1:RecordAudio("319751022", var_94_7)
						arg_91_1:RecordAudio("319751022", var_94_7)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_319751", "319751022", "story_v_out_319751.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_319751", "319751022", "story_v_out_319751.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_8 = math.max(var_94_1, arg_91_1.talkMaxDuration)

			if var_94_0 <= arg_91_1.time_ and arg_91_1.time_ < var_94_0 + var_94_8 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_0) / var_94_8

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_0 + var_94_8 and arg_91_1.time_ < var_94_0 + var_94_8 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play319751023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319751023
		arg_95_1.duration_ = 11.3

		local var_95_0 = {
			zh = 4.4,
			ja = 11.3
		}
		local var_95_1 = manager.audio:GetLocalizationFlag()

		if var_95_0[var_95_1] ~= nil then
			arg_95_1.duration_ = var_95_0[var_95_1]
		end

		SetActive(arg_95_1.tipsGo_, false)

		function arg_95_1.onSingleLineFinish_()
			arg_95_1.onSingleLineUpdate_ = nil
			arg_95_1.onSingleLineFinish_ = nil
			arg_95_1.state_ = "waiting"
		end

		function arg_95_1.playNext_(arg_97_0)
			if arg_97_0 == 1 then
				arg_95_0:Play319751024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			local var_98_0 = 0.575

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_1 = arg_95_1:GetWordFromCfg(319751023)
				local var_98_2 = arg_95_1:FormatText(var_98_1.content)

				arg_95_1.text_.text = var_98_2

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_4 = 23 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 23)

				if (23 <= 0 and var_98_0 or var_98_0 * (utf8.len(var_98_2) / 23)) > 0 and var_98_0 < var_98_4 then
					arg_95_1.talkMaxDuration = var_98_4

					if var_98_4 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_4 + 0
					end
				end

				arg_95_1.text_.text = var_98_2
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751023", "story_v_out_319751.awb") ~= 0 then
					local var_98_5 = manager.audio:GetVoiceLength("story_v_out_319751", "319751023", "story_v_out_319751.awb") / 1000

					if var_98_5 + 0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + 0
					end

					if var_98_1.prefab_name ~= "" and arg_95_1.actors_[var_98_1.prefab_name] ~= nil then
						local var_98_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_1.prefab_name].transform, "story_v_out_319751", "319751023", "story_v_out_319751.awb")

						arg_95_1:RecordAudio("319751023", var_98_6)
						arg_95_1:RecordAudio("319751023", var_98_6)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_319751", "319751023", "story_v_out_319751.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_319751", "319751023", "story_v_out_319751.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_7 = math.max(var_98_0, arg_95_1.talkMaxDuration)

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_7 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - 0) / var_98_7

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= 0 + var_98_7 and arg_95_1.time_ < 0 + var_98_7 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play319751024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319751024
		arg_99_1.duration_ = 7

		local var_99_0 = {
			zh = 3.5,
			ja = 7
		}
		local var_99_1 = manager.audio:GetLocalizationFlag()

		if var_99_0[var_99_1] ~= nil then
			arg_99_1.duration_ = var_99_0[var_99_1]
		end

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play319751025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10050ui_story = arg_99_1.actors_["10050ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["10050ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10050ui_story, Vector3.New(-0.7, -0.715, -6.15), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10050ui_story"].transform.position).z)
				arg_99_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10050ui_story"].transform.localEulerAngles = arg_99_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["10050ui_story"].transform.localPosition = Vector3.New(-0.7, -0.715, -6.15)
				arg_99_1.actors_["10050ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["10050ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10050ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["10050ui_story"].transform.position).z)
				arg_99_1.actors_["10050ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["10050ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["10050ui_story"].transform.localEulerAngles = arg_99_1.actors_["10050ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["10050ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10050ui_story == nil then
				arg_99_1.var_.characterEffect10050ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect10050ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect10050ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect10050ui_story then
				arg_99_1.var_.characterEffect10050ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/story10050/story10050action/10050action13_1")
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("10050ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_102_4 = arg_99_1.actors_["1084ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1084ui_story == nil then
				arg_99_1.var_.characterEffect1084ui_story = var_102_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_5 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 and not isNil(var_102_4) then
				if arg_99_1.var_.characterEffect1084ui_story and not isNil(var_102_4) then
					arg_99_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_99_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_99_1.time_ - 0) / var_102_5)
				end
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 and not isNil(var_102_4) and arg_99_1.var_.characterEffect1084ui_story then
				arg_99_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_99_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_102_6 = 0
			local var_102_7 = 0.325

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[692].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(319751024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 13 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 13)

				if (13 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 13)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751024", "story_v_out_319751.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_319751", "319751024", "story_v_out_319751.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_319751", "319751024", "story_v_out_319751.awb")

						arg_99_1:RecordAudio("319751024", var_102_13)
						arg_99_1:RecordAudio("319751024", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319751", "319751024", "story_v_out_319751.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319751", "319751024", "story_v_out_319751.awb")
				end

				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_14 = math.max(var_102_7, arg_99_1.talkMaxDuration)

			if var_102_6 <= arg_99_1.time_ and arg_99_1.time_ < var_102_6 + var_102_14 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_6) / var_102_14

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_6 + var_102_14 and arg_99_1.time_ < var_102_6 + var_102_14 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play319751025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319751025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319751026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["10050ui_story"]) and arg_103_1.var_.characterEffect10050ui_story == nil then
				arg_103_1.var_.characterEffect10050ui_story = arg_103_1.actors_["10050ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.200000002980232

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["10050ui_story"]) then
				if arg_103_1.var_.characterEffect10050ui_story and not isNil(arg_103_1.actors_["10050ui_story"]) then
					arg_103_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_103_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["10050ui_story"]) and arg_103_1.var_.characterEffect10050ui_story then
				arg_103_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_103_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:AudioAction("play", "effect", "se_story_side_1080", "se_story_1080_knock", "")
			end

			local var_106_2 = arg_103_1.actors_["1084ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1084ui_story = var_106_2.localPosition

				arg_103_1:ShowWeapon(arg_103_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_106_3 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_3 then
				var_106_2.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_3)
				var_106_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_2.position).x, (manager.ui.mainCamera.transform.position - var_106_2.position).y, (manager.ui.mainCamera.transform.position - var_106_2.position).z)
				var_106_2.localEulerAngles.z = 0
				var_106_2.localEulerAngles.x = 0
				var_106_2.localEulerAngles = var_106_2.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_3 and arg_103_1.time_ < 0 + var_106_3 + arg_106_0 then
				var_106_2.localPosition = Vector3.New(0, 100, 0)
				var_106_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_2.position).x, (manager.ui.mainCamera.transform.position - var_106_2.position).y, (manager.ui.mainCamera.transform.position - var_106_2.position).z)
				var_106_2.localEulerAngles.z = 0
				var_106_2.localEulerAngles.x = 0
				var_106_2.localEulerAngles = var_106_2.localEulerAngles
			end

			local var_106_4 = arg_103_1.actors_["10050ui_story"].transform

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos10050ui_story = var_106_4.localPosition
			end

			local var_106_5 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_5 then
				var_106_4.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos10050ui_story, Vector3.New(0, 100, 0), (arg_103_1.time_ - 0) / var_106_5)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_5 and arg_103_1.time_ < 0 + var_106_5 + arg_106_0 then
				var_106_4.localPosition = Vector3.New(0, 100, 0)
				var_106_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_106_4.position).x, (manager.ui.mainCamera.transform.position - var_106_4.position).y, (manager.ui.mainCamera.transform.position - var_106_4.position).z)
				var_106_4.localEulerAngles.z = 0
				var_106_4.localEulerAngles.x = 0
				var_106_4.localEulerAngles = var_106_4.localEulerAngles
			end

			local var_106_6 = 0
			local var_106_7 = 0.925

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_6 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_8 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(319751025).content)

				arg_103_1.text_.text = var_106_8

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_10 = 37 <= 0 and var_106_7 or var_106_7 * (utf8.len(var_106_8) / 37)

				if (37 <= 0 and var_106_7 or var_106_7 * (utf8.len(var_106_8) / 37)) > 0 and var_106_7 < var_106_10 then
					arg_103_1.talkMaxDuration = var_106_10

					if var_106_10 + var_106_6 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_6
					end
				end

				arg_103_1.text_.text = var_106_8
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_11 = math.max(var_106_7, arg_103_1.talkMaxDuration)

			if var_106_6 <= arg_103_1.time_ and arg_103_1.time_ < var_106_6 + var_106_11 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_6) / var_106_11

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_6 + var_106_11 and arg_103_1.time_ < var_106_6 + var_106_11 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
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
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play319751026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319751026
		arg_107_1.duration_ = 5

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319751027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			local var_110_0 = 0.75

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, false)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_1 = arg_107_1:FormatText(arg_107_1:GetWordFromCfg(319751026).content)

				arg_107_1.text_.text = var_110_1

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_3 = 30 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 30)

				if (30 <= 0 and var_110_0 or var_110_0 * (utf8.len(var_110_1) / 30)) > 0 and var_110_0 < var_110_3 then
					arg_107_1.talkMaxDuration = var_110_3

					if var_110_3 + 0 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_3 + 0
					end
				end

				arg_107_1.text_.text = var_110_1
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)
				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_4 = math.max(var_110_0, arg_107_1.talkMaxDuration)

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - 0) / var_110_4

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {}

		arg_107_1:InitPlayNodeList()
	end,
	Play319751027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319751027
		arg_111_1.duration_ = 4.3

		local var_111_0 = {
			zh = 2.833,
			ja = 4.3
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
				arg_111_0:Play319751028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if arg_111_1.actors_["10069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10069ui_story"))) then
				local var_114_0 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_111_1.stage_.transform)

				var_114_0.name = "10069ui_story"
				var_114_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_["10069ui_story"] = var_114_0

				local var_114_1 = var_114_0:GetComponentInChildren(typeof(CharacterEffect))

				var_114_1.enabled = true

				local var_114_2 = GameObjectTools.GetOrAddComponent(var_114_0, typeof(DynamicBoneHelper))

				if var_114_2 then
					var_114_2:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_1.transform, false)

				arg_111_1.var_["10069ui_story" .. "Animator"] = var_114_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_["10069ui_story" .. "Animator"].applyRootMotion = true
				arg_111_1.var_["10069ui_story" .. "LipSync"] = var_114_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_3 = arg_111_1.actors_["10069ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10069ui_story = var_114_3.localPosition
			end

			local var_114_4 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_4 then
				var_114_3.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_111_1.time_ - 0) / var_114_4)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_4 and arg_111_1.time_ < 0 + var_114_4 + arg_114_0 then
				var_114_3.localPosition = Vector3.New(0, -1.08, -6.33)
				var_114_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_3.position).x, (manager.ui.mainCamera.transform.position - var_114_3.position).y, (manager.ui.mainCamera.transform.position - var_114_3.position).z)
				var_114_3.localEulerAngles.z = 0
				var_114_3.localEulerAngles.x = 0
				var_114_3.localEulerAngles = var_114_3.localEulerAngles
			end

			local var_114_5 = arg_111_1.actors_["10069ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect10069ui_story == nil then
				arg_111_1.var_.characterEffect10069ui_story = var_114_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_6 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_6 and not isNil(var_114_5) then
				if arg_111_1.var_.characterEffect10069ui_story and not isNil(var_114_5) then
					arg_111_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_6 and arg_111_1.time_ < 0 + var_114_6 + arg_114_0 and not isNil(var_114_5) and arg_111_1.var_.characterEffect10069ui_story then
				arg_111_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_8 = arg_111_1.actors_["1084ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos1084ui_story = var_114_8.localPosition
			end

			local var_114_9 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_9 then
				var_114_8.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_9)
				var_114_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_8.position).x, (manager.ui.mainCamera.transform.position - var_114_8.position).y, (manager.ui.mainCamera.transform.position - var_114_8.position).z)
				var_114_8.localEulerAngles.z = 0
				var_114_8.localEulerAngles.x = 0
				var_114_8.localEulerAngles = var_114_8.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_9 and arg_111_1.time_ < 0 + var_114_9 + arg_114_0 then
				var_114_8.localPosition = Vector3.New(0, 100, 0)
				var_114_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_8.position).x, (manager.ui.mainCamera.transform.position - var_114_8.position).y, (manager.ui.mainCamera.transform.position - var_114_8.position).z)
				var_114_8.localEulerAngles.z = 0
				var_114_8.localEulerAngles.x = 0
				var_114_8.localEulerAngles = var_114_8.localEulerAngles
			end

			local var_114_10 = arg_111_1.actors_["10050ui_story"].transform

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1.var_.moveOldPos10050ui_story = var_114_10.localPosition
			end

			local var_114_11 = 0.001

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_11 then
				var_114_10.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10050ui_story, Vector3.New(0, 100, 0), (arg_111_1.time_ - 0) / var_114_11)
				var_114_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_10.position).x, (manager.ui.mainCamera.transform.position - var_114_10.position).y, (manager.ui.mainCamera.transform.position - var_114_10.position).z)
				var_114_10.localEulerAngles.z = 0
				var_114_10.localEulerAngles.x = 0
				var_114_10.localEulerAngles = var_114_10.localEulerAngles
			end

			if arg_111_1.time_ >= 0 + var_114_11 and arg_111_1.time_ < 0 + var_114_11 + arg_114_0 then
				var_114_10.localPosition = Vector3.New(0, 100, 0)
				var_114_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_114_10.position).x, (manager.ui.mainCamera.transform.position - var_114_10.position).y, (manager.ui.mainCamera.transform.position - var_114_10.position).z)
				var_114_10.localEulerAngles.z = 0
				var_114_10.localEulerAngles.x = 0
				var_114_10.localEulerAngles = var_114_10.localEulerAngles
			end

			local var_114_12 = arg_111_1.actors_["10050ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_12) and arg_111_1.var_.characterEffect10050ui_story == nil then
				arg_111_1.var_.characterEffect10050ui_story = var_114_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_13 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_13 and not isNil(var_114_12) then
				if arg_111_1.var_.characterEffect10050ui_story and not isNil(var_114_12) then
					arg_111_1.var_.characterEffect10050ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10050ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_13)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_13 and arg_111_1.time_ < 0 + var_114_13 + arg_114_0 and not isNil(var_114_12) and arg_111_1.var_.characterEffect10050ui_story then
				arg_111_1.var_.characterEffect10050ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10050ui_story.fillRatio = 0.5
			end

			local var_114_14 = 0
			local var_114_15 = 0.3

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_16 = arg_111_1:GetWordFromCfg(319751027)
				local var_114_17 = arg_111_1:FormatText(var_114_16.content)

				arg_111_1.text_.text = var_114_17

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_19 = 12 <= 0 and var_114_15 or var_114_15 * (utf8.len(var_114_17) / 12)

				if (12 <= 0 and var_114_15 or var_114_15 * (utf8.len(var_114_17) / 12)) > 0 and var_114_15 < var_114_19 then
					arg_111_1.talkMaxDuration = var_114_19

					if var_114_19 + var_114_14 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_19 + var_114_14
					end
				end

				arg_111_1.text_.text = var_114_17
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751027", "story_v_out_319751.awb") ~= 0 then
					local var_114_20 = manager.audio:GetVoiceLength("story_v_out_319751", "319751027", "story_v_out_319751.awb") / 1000

					if var_114_20 + var_114_14 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_20 + var_114_14
					end

					if var_114_16.prefab_name ~= "" and arg_111_1.actors_[var_114_16.prefab_name] ~= nil then
						local var_114_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_16.prefab_name].transform, "story_v_out_319751", "319751027", "story_v_out_319751.awb")

						arg_111_1:RecordAudio("319751027", var_114_21)
						arg_111_1:RecordAudio("319751027", var_114_21)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_319751", "319751027", "story_v_out_319751.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_319751", "319751027", "story_v_out_319751.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_22 = math.max(var_114_15, arg_111_1.talkMaxDuration)

			if var_114_14 <= arg_111_1.time_ and arg_111_1.time_ < var_114_14 + var_114_22 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_14) / var_114_22

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_14 + var_114_22 and arg_111_1.time_ < var_114_14 + var_114_22 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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
			},
			{
				assetPath = "",
				actorName = "10050ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_111_1:InitPlayNodeList()
	end,
	Play319751028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319751028
		arg_115_1.duration_ = 9.1

		local var_115_0 = {
			zh = 7.666,
			ja = 9.1
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
				arg_115_0:Play319751029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if arg_115_1.bgs_.ST72 == nil then
				local var_118_0 = Object.Instantiate(arg_115_1.paintGo_)

				var_118_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST72")
				var_118_0.name = "ST72"
				var_118_0.transform.parent = arg_115_1.stage_.transform
				var_118_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_115_1.bgs_.ST72 = var_118_0
			end

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				local var_118_1 = arg_115_1.bgs_.ST72

				arg_115_1.bgs_.ST72.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_118_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_118_2 = var_118_1:GetComponent("SpriteRenderer")

				if var_118_2 and var_118_2.sprite then
					local var_118_3 = 2 * (var_118_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_118_1.transform.localScale = Vector3.New(var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, var_118_3 / var_118_2.sprite.bounds.size.y < var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x and var_118_3 * manager.ui.mainCameraCom_.aspect / var_118_2.sprite.bounds.size.x or var_118_3 / var_118_2.sprite.bounds.size.y, 0)
				end

				for iter_118_0, iter_118_1 in pairs(arg_115_1.bgs_) do
					if iter_118_0 ~= "ST72" then
						iter_118_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_118_4 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_4 + arg_118_0 then
				arg_115_1.allBtn_.enabled = false
			end

			if arg_115_1.time_ >= var_118_4 + 0.3 and arg_115_1.time_ < var_118_4 + 0.3 + arg_118_0 then
				arg_115_1.allBtn_.enabled = true
			end

			local var_118_5 = 0

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_5 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_6 = 2

			if var_118_5 <= arg_115_1.time_ and arg_115_1.time_ < var_118_5 + var_118_6 then
				local var_118_7 = Color.New(0, 0, 0)

				var_118_7.a = Mathf.Lerp(0, 1, (arg_115_1.time_ - var_118_5) / var_118_6)
				arg_115_1.mask_.color = var_118_7
			end

			if arg_115_1.time_ >= var_118_5 + var_118_6 and arg_115_1.time_ < var_118_5 + var_118_6 + arg_118_0 then
				local var_118_8 = Color.New(0, 0, 0)

				var_118_8.a = 1
				arg_115_1.mask_.color = var_118_8
			end

			local var_118_9 = 2

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= var_118_9 + arg_118_0 then
				arg_115_1.mask_.enabled = true
				arg_115_1.mask_.raycastTarget = true

				arg_115_1:SetGaussion(false)
			end

			local var_118_10 = 2

			if var_118_9 <= arg_115_1.time_ and arg_115_1.time_ < var_118_9 + var_118_10 then
				local var_118_11 = Color.New(0, 0, 0)

				var_118_11.a = Mathf.Lerp(1, 0, (arg_115_1.time_ - var_118_9) / var_118_10)
				arg_115_1.mask_.color = var_118_11
			end

			if arg_115_1.time_ >= var_118_9 + var_118_10 and arg_115_1.time_ < var_118_9 + var_118_10 + arg_118_0 then
				local var_118_12 = Color.New(0, 0, 0)

				arg_115_1.mask_.enabled = false
				var_118_12.a = 0
				arg_115_1.mask_.color = var_118_12
			end

			local var_118_13 = arg_115_1.actors_["1084ui_story"].transform

			if 3.83333333333333 < arg_115_1.time_ and arg_115_1.time_ <= 3.83333333333333 + arg_118_0 then
				arg_115_1.var_.moveOldPos1084ui_story = var_118_13.localPosition
			end

			local var_118_14 = 0.001

			if 3.83333333333333 <= arg_115_1.time_ and arg_115_1.time_ < 3.83333333333333 + var_118_14 then
				var_118_13.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_115_1.time_ - 3.83333333333333) / var_118_14)
				var_118_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_13.position).x, (manager.ui.mainCamera.transform.position - var_118_13.position).y, (manager.ui.mainCamera.transform.position - var_118_13.position).z)
				var_118_13.localEulerAngles.z = 0
				var_118_13.localEulerAngles.x = 0
				var_118_13.localEulerAngles = var_118_13.localEulerAngles
			end

			if arg_115_1.time_ >= 3.83333333333333 + var_118_14 and arg_115_1.time_ < 3.83333333333333 + var_118_14 + arg_118_0 then
				var_118_13.localPosition = Vector3.New(0, -0.97, -6)
				var_118_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_13.position).x, (manager.ui.mainCamera.transform.position - var_118_13.position).y, (manager.ui.mainCamera.transform.position - var_118_13.position).z)
				var_118_13.localEulerAngles.z = 0
				var_118_13.localEulerAngles.x = 0
				var_118_13.localEulerAngles = var_118_13.localEulerAngles
			end

			local var_118_15 = arg_115_1.actors_["1084ui_story"]

			if 3.83333333333333 < arg_115_1.time_ and arg_115_1.time_ <= 3.83333333333333 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.characterEffect1084ui_story == nil then
				arg_115_1.var_.characterEffect1084ui_story = var_118_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_16 = 0.200000002980232

			if 3.83333333333333 <= arg_115_1.time_ and arg_115_1.time_ < 3.83333333333333 + var_118_16 and not isNil(var_118_15) then
				if arg_115_1.var_.characterEffect1084ui_story and not isNil(var_118_15) then
					arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 3.83333333333333 + var_118_16 and arg_115_1.time_ < 3.83333333333333 + var_118_16 + arg_118_0 and not isNil(var_118_15) and arg_115_1.var_.characterEffect1084ui_story then
				arg_115_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_115_1.time_ and arg_115_1.time_ <= 3.83333333333333 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 3.83333333333333 < arg_115_1.time_ and arg_115_1.time_ <= 3.83333333333333 + arg_118_0 then
				arg_115_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_18 = arg_115_1.actors_["10069ui_story"].transform

			if 2 < arg_115_1.time_ and arg_115_1.time_ <= 2 + arg_118_0 then
				arg_115_1.var_.moveOldPos10069ui_story = var_118_18.localPosition
			end

			local var_118_19 = 0.001

			if 2 <= arg_115_1.time_ and arg_115_1.time_ < 2 + var_118_19 then
				var_118_18.localPosition = Vector3.Lerp(arg_115_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_115_1.time_ - 2) / var_118_19)
				var_118_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_18.position).x, (manager.ui.mainCamera.transform.position - var_118_18.position).y, (manager.ui.mainCamera.transform.position - var_118_18.position).z)
				var_118_18.localEulerAngles.z = 0
				var_118_18.localEulerAngles.x = 0
				var_118_18.localEulerAngles = var_118_18.localEulerAngles
			end

			if arg_115_1.time_ >= 2 + var_118_19 and arg_115_1.time_ < 2 + var_118_19 + arg_118_0 then
				var_118_18.localPosition = Vector3.New(0, 100, 0)
				var_118_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_118_18.position).x, (manager.ui.mainCamera.transform.position - var_118_18.position).y, (manager.ui.mainCamera.transform.position - var_118_18.position).z)
				var_118_18.localEulerAngles.z = 0
				var_118_18.localEulerAngles.x = 0
				var_118_18.localEulerAngles = var_118_18.localEulerAngles
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_118_22 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_115_1.bgmTxt_.text ~= var_118_22 and arg_115_1.bgmTxt_.text ~= "" then
						if arg_115_1.bgmTxt2_.text ~= "" then
							arg_115_1.bgmTxt_.text = arg_115_1.bgmTxt2_.text
						end

						arg_115_1.bgmTxt2_.text = var_118_22

						arg_115_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_115_1.bgmTxt_.text = var_118_22
						arg_115_1.bgmTxt2_.text = var_118_22
					end

					if arg_115_1.bgmTimer then
						arg_115_1.bgmTimer:Stop()

						arg_115_1.bgmTimer = nil
					end

					if arg_115_1.settingData.show_music_name == 1 then
						arg_115_1.musicController:SetSelectedState("show")
						arg_115_1.musicAnimator_:Play("open", 0, 0)

						if arg_115_1.settingData.music_time ~= 0 then
							arg_115_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_115_1.settingData.music_time), function()
								if arg_115_1 == nil or isNil(arg_115_1.bgmTxt_) then
									return
								end

								arg_115_1.musicController:SetSelectedState("hide")
								arg_115_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.233333333333333 < arg_115_1.time_ and arg_115_1.time_ <= 0.233333333333333 + arg_118_0 then
				arg_115_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_118_25 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

				if "" ~= "" then
					if arg_115_1.bgmTxt_.text ~= var_118_25 and arg_115_1.bgmTxt_.text ~= "" then
						if arg_115_1.bgmTxt2_.text ~= "" then
							arg_115_1.bgmTxt_.text = arg_115_1.bgmTxt2_.text
						end

						arg_115_1.bgmTxt2_.text = var_118_25

						arg_115_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_115_1.bgmTxt_.text = var_118_25
						arg_115_1.bgmTxt2_.text = var_118_25
					end

					if arg_115_1.bgmTimer then
						arg_115_1.bgmTimer:Stop()

						arg_115_1.bgmTimer = nil
					end

					if arg_115_1.settingData.show_music_name == 1 then
						arg_115_1.musicController:SetSelectedState("show")
						arg_115_1.musicAnimator_:Play("open", 0, 0)

						if arg_115_1.settingData.music_time ~= 0 then
							arg_115_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_115_1.settingData.music_time), function()
								if arg_115_1 == nil or isNil(arg_115_1.bgmTxt_) then
									return
								end

								arg_115_1.musicController:SetSelectedState("hide")
								arg_115_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_115_1.frameCnt_ <= 1 then
				arg_115_1.dialog_:SetActive(false)
			end

			local var_118_26 = 4
			local var_118_27 = 0.5

			if 4 < arg_115_1.time_ and arg_115_1.time_ <= var_118_26 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0

				arg_115_1.dialog_:SetActive(true)

				arg_115_1.dialogCg_.alpha = 0

				local var_118_28 = LeanTween.value(arg_115_1.dialog_, 0, 1, 0.3)

				var_118_28:setOnUpdate(LuaHelper.FloatAction(function(arg_121_0)
					arg_115_1.dialogCg_.alpha = arg_121_0
				end))
				var_118_28:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_115_1.dialog_)
					var_118_28:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_115_1.duration_ = arg_115_1.duration_ + 0.3

				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_29 = arg_115_1:GetWordFromCfg(319751028)
				local var_118_30 = arg_115_1:FormatText(var_118_29.content)

				arg_115_1.text_.text = var_118_30

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_32 = 20 <= 0 and var_118_27 or var_118_27 * (utf8.len(var_118_30) / 20)

				if (20 <= 0 and var_118_27 or var_118_27 * (utf8.len(var_118_30) / 20)) > 0 and var_118_27 < var_118_32 then
					arg_115_1.talkMaxDuration = var_118_32
					var_118_26 = var_118_26 + 0.3

					if var_118_32 + var_118_26 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_32 + var_118_26
					end
				end

				arg_115_1.text_.text = var_118_30
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751028", "story_v_out_319751.awb") ~= 0 then
					local var_118_33 = manager.audio:GetVoiceLength("story_v_out_319751", "319751028", "story_v_out_319751.awb") / 1000

					if var_118_33 + var_118_26 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_33 + var_118_26
					end

					if var_118_29.prefab_name ~= "" and arg_115_1.actors_[var_118_29.prefab_name] ~= nil then
						local var_118_34 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_29.prefab_name].transform, "story_v_out_319751", "319751028", "story_v_out_319751.awb")

						arg_115_1:RecordAudio("319751028", var_118_34)
						arg_115_1:RecordAudio("319751028", var_118_34)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319751", "319751028", "story_v_out_319751.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319751", "319751028", "story_v_out_319751.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_35 = var_118_26 + 0.3
			local var_118_36 = math.max(var_118_27, arg_115_1.talkMaxDuration)

			if var_118_26 + 0.3 <= arg_115_1.time_ and arg_115_1.time_ < var_118_35 + var_118_36 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_35) / var_118_36

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_35 + var_118_36 and arg_115_1.time_ < var_118_35 + var_118_36 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_115_1:InitPlayNodeList()
	end,
	Play319751029 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319751029
		arg_123_1.duration_ = 4.83

		local var_123_0 = {
			zh = 3.3,
			ja = 4.833
		}
		local var_123_1 = manager.audio:GetLocalizationFlag()

		if var_123_0[var_123_1] ~= nil then
			arg_123_1.duration_ = var_123_0[var_123_1]
		end

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play319751030(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10069ui_story = arg_123_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10069ui_story"].transform.position).z)
				arg_123_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10069ui_story"].transform.localEulerAngles = arg_123_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6.33)
				arg_123_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["10069ui_story"].transform.position).z)
				arg_123_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["10069ui_story"].transform.localEulerAngles = arg_123_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["10069ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10069ui_story == nil then
				arg_123_1.var_.characterEffect10069ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect10069ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect10069ui_story then
				arg_123_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_126_4 = arg_123_1.actors_["1084ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1084ui_story = var_126_4.localPosition
			end

			local var_126_5 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_5 then
				var_126_4.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_123_1.time_ - 0) / var_126_5)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_5 and arg_123_1.time_ < 0 + var_126_5 + arg_126_0 then
				var_126_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_126_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_4.position).x, (manager.ui.mainCamera.transform.position - var_126_4.position).y, (manager.ui.mainCamera.transform.position - var_126_4.position).z)
				var_126_4.localEulerAngles.z = 0
				var_126_4.localEulerAngles.x = 0
				var_126_4.localEulerAngles = var_126_4.localEulerAngles
			end

			local var_126_6 = arg_123_1.actors_["1084ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_7 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_7 and not isNil(var_126_6) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_6) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_7)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_7 and arg_123_1.time_ < 0 + var_126_7 + arg_126_0 and not isNil(var_126_6) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_126_8 = 0
			local var_126_9 = 0.5

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_8 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_10 = arg_123_1:GetWordFromCfg(319751029)
				local var_126_11 = arg_123_1:FormatText(var_126_10.content)

				arg_123_1.text_.text = var_126_11

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_13 = 20 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 20)

				if (20 <= 0 and var_126_9 or var_126_9 * (utf8.len(var_126_11) / 20)) > 0 and var_126_9 < var_126_13 then
					arg_123_1.talkMaxDuration = var_126_13

					if var_126_13 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_13 + var_126_8
					end
				end

				arg_123_1.text_.text = var_126_11
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751029", "story_v_out_319751.awb") ~= 0 then
					local var_126_14 = manager.audio:GetVoiceLength("story_v_out_319751", "319751029", "story_v_out_319751.awb") / 1000

					if var_126_14 + var_126_8 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_14 + var_126_8
					end

					if var_126_10.prefab_name ~= "" and arg_123_1.actors_[var_126_10.prefab_name] ~= nil then
						local var_126_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_10.prefab_name].transform, "story_v_out_319751", "319751029", "story_v_out_319751.awb")

						arg_123_1:RecordAudio("319751029", var_126_15)
						arg_123_1:RecordAudio("319751029", var_126_15)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319751", "319751029", "story_v_out_319751.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319751", "319751029", "story_v_out_319751.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_16 = math.max(var_126_9, arg_123_1.talkMaxDuration)

			if var_126_8 <= arg_123_1.time_ and arg_123_1.time_ < var_126_8 + var_126_16 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_8) / var_126_16

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_8 + var_126_16 and arg_123_1.time_ < var_126_8 + var_126_16 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
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

		arg_123_1:InitPlayNodeList()
	end,
	Play319751030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319751030
		arg_127_1.duration_ = 3.3

		local var_127_0 = {
			zh = 3.3,
			ja = 2.533
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
				arg_127_0:Play319751031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10069ui_story"]) and arg_127_1.var_.characterEffect10069ui_story == nil then
				arg_127_1.var_.characterEffect10069ui_story = arg_127_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10069ui_story"]) then
				if arg_127_1.var_.characterEffect10069ui_story and not isNil(arg_127_1.actors_["10069ui_story"]) then
					arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10069ui_story"]) and arg_127_1.var_.characterEffect10069ui_story then
				arg_127_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["1084ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_130_4 = 0
			local var_130_5 = 0.45

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(319751030)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 18 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 18)

				if (18 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 18)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751030", "story_v_out_319751.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751030", "story_v_out_319751.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319751", "319751030", "story_v_out_319751.awb")

						arg_127_1:RecordAudio("319751030", var_130_11)
						arg_127_1:RecordAudio("319751030", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319751", "319751030", "story_v_out_319751.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319751", "319751030", "story_v_out_319751.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_12 = math.max(var_130_5, arg_127_1.talkMaxDuration)

			if var_130_4 <= arg_127_1.time_ and arg_127_1.time_ < var_130_4 + var_130_12 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_4) / var_130_12

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_4 + var_130_12 and arg_127_1.time_ < var_130_4 + var_130_12 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319751031 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319751031
		arg_131_1.duration_ = 11

		local var_131_0 = {
			zh = 8.433,
			ja = 11
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
				arg_131_0:Play319751032(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if arg_131_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_134_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_131_1.stage_.transform)

				var_134_0.name = "10066ui_story"
				var_134_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_131_1.actors_["10066ui_story"] = var_134_0

				local var_134_1 = var_134_0:GetComponentInChildren(typeof(CharacterEffect))

				var_134_1.enabled = true

				local var_134_2 = GameObjectTools.GetOrAddComponent(var_134_0, typeof(DynamicBoneHelper))

				if var_134_2 then
					var_134_2:EnableDynamicBone(false)
				end

				arg_131_1:ShowWeapon(var_134_1.transform, false)

				arg_131_1.var_["10066ui_story" .. "Animator"] = var_134_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_131_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_131_1.var_["10066ui_story" .. "LipSync"] = var_134_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_134_3 = arg_131_1.actors_["10066ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10066ui_story = var_134_3.localPosition
			end

			local var_134_4 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				var_134_3.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_131_1.time_ - 0) / var_134_4)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				var_134_3.localPosition = Vector3.New(0, -0.99, -5.83)
				var_134_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_3.position).x, (manager.ui.mainCamera.transform.position - var_134_3.position).y, (manager.ui.mainCamera.transform.position - var_134_3.position).z)
				var_134_3.localEulerAngles.z = 0
				var_134_3.localEulerAngles.x = 0
				var_134_3.localEulerAngles = var_134_3.localEulerAngles
			end

			local var_134_5 = arg_131_1.actors_["10066ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect10066ui_story == nil then
				arg_131_1.var_.characterEffect10066ui_story = var_134_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_6 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_6 and not isNil(var_134_5) then
				if arg_131_1.var_.characterEffect10066ui_story and not isNil(var_134_5) then
					arg_131_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_6 and arg_131_1.time_ < 0 + var_134_6 + arg_134_0 and not isNil(var_134_5) and arg_131_1.var_.characterEffect10066ui_story then
				arg_131_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_8 = arg_131_1.actors_["10069ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos10069ui_story = var_134_8.localPosition
			end

			local var_134_9 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_9 then
				var_134_8.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_9)
				var_134_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_8.position).x, (manager.ui.mainCamera.transform.position - var_134_8.position).y, (manager.ui.mainCamera.transform.position - var_134_8.position).z)
				var_134_8.localEulerAngles.z = 0
				var_134_8.localEulerAngles.x = 0
				var_134_8.localEulerAngles = var_134_8.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_9 and arg_131_1.time_ < 0 + var_134_9 + arg_134_0 then
				var_134_8.localPosition = Vector3.New(0, 100, 0)
				var_134_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_8.position).x, (manager.ui.mainCamera.transform.position - var_134_8.position).y, (manager.ui.mainCamera.transform.position - var_134_8.position).z)
				var_134_8.localEulerAngles.z = 0
				var_134_8.localEulerAngles.x = 0
				var_134_8.localEulerAngles = var_134_8.localEulerAngles
			end

			local var_134_10 = arg_131_1.actors_["10069ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect10069ui_story == nil then
				arg_131_1.var_.characterEffect10069ui_story = var_134_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_11 and not isNil(var_134_10) then
				if arg_131_1.var_.characterEffect10069ui_story and not isNil(var_134_10) then
					arg_131_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_11)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_11 and arg_131_1.time_ < 0 + var_134_11 + arg_134_0 and not isNil(var_134_10) and arg_131_1.var_.characterEffect10069ui_story then
				arg_131_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_134_12 = arg_131_1.actors_["1084ui_story"].transform

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.var_.moveOldPos1084ui_story = var_134_12.localPosition
			end

			local var_134_13 = 0.001

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_13 then
				var_134_12.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_131_1.time_ - 0) / var_134_13)
				var_134_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_12.position).x, (manager.ui.mainCamera.transform.position - var_134_12.position).y, (manager.ui.mainCamera.transform.position - var_134_12.position).z)
				var_134_12.localEulerAngles.z = 0
				var_134_12.localEulerAngles.x = 0
				var_134_12.localEulerAngles = var_134_12.localEulerAngles
			end

			if arg_131_1.time_ >= 0 + var_134_13 and arg_131_1.time_ < 0 + var_134_13 + arg_134_0 then
				var_134_12.localPosition = Vector3.New(0, 100, 0)
				var_134_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_134_12.position).x, (manager.ui.mainCamera.transform.position - var_134_12.position).y, (manager.ui.mainCamera.transform.position - var_134_12.position).z)
				var_134_12.localEulerAngles.z = 0
				var_134_12.localEulerAngles.x = 0
				var_134_12.localEulerAngles = var_134_12.localEulerAngles
			end

			local var_134_14 = arg_131_1.actors_["1084ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_14) and arg_131_1.var_.characterEffect1084ui_story == nil then
				arg_131_1.var_.characterEffect1084ui_story = var_134_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_15 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_15 and not isNil(var_134_14) then
				if arg_131_1.var_.characterEffect1084ui_story and not isNil(var_134_14) then
					arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_15)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_15 and arg_131_1.time_ < 0 + var_134_15 + arg_134_0 and not isNil(var_134_14) and arg_131_1.var_.characterEffect1084ui_story then
				arg_131_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_134_16 = 0
			local var_134_17 = 0.9

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_16 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_18 = arg_131_1:GetWordFromCfg(319751031)
				local var_134_19 = arg_131_1:FormatText(var_134_18.content)

				arg_131_1.text_.text = var_134_19

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_21 = 36 <= 0 and var_134_17 or var_134_17 * (utf8.len(var_134_19) / 36)

				if (36 <= 0 and var_134_17 or var_134_17 * (utf8.len(var_134_19) / 36)) > 0 and var_134_17 < var_134_21 then
					arg_131_1.talkMaxDuration = var_134_21

					if var_134_21 + var_134_16 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_21 + var_134_16
					end
				end

				arg_131_1.text_.text = var_134_19
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751031", "story_v_out_319751.awb") ~= 0 then
					local var_134_22 = manager.audio:GetVoiceLength("story_v_out_319751", "319751031", "story_v_out_319751.awb") / 1000

					if var_134_22 + var_134_16 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_22 + var_134_16
					end

					if var_134_18.prefab_name ~= "" and arg_131_1.actors_[var_134_18.prefab_name] ~= nil then
						local var_134_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_18.prefab_name].transform, "story_v_out_319751", "319751031", "story_v_out_319751.awb")

						arg_131_1:RecordAudio("319751031", var_134_23)
						arg_131_1:RecordAudio("319751031", var_134_23)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319751", "319751031", "story_v_out_319751.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319751", "319751031", "story_v_out_319751.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_24 = math.max(var_134_17, arg_131_1.talkMaxDuration)

			if var_134_16 <= arg_131_1.time_ and arg_131_1.time_ < var_134_16 + var_134_24 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_16) / var_134_24

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_16 + var_134_24 and arg_131_1.time_ < var_134_16 + var_134_24 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
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

		arg_131_1:InitPlayNodeList()
	end,
	Play319751032 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319751032
		arg_135_1.duration_ = 13.03

		local var_135_0 = {
			zh = 9.366,
			ja = 13.033
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play319751033(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10069ui_story = arg_135_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_138_0 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_0 then
				arg_135_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_135_1.time_ - 0) / var_138_0)
				arg_135_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10069ui_story"].transform.position).z)
				arg_135_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10069ui_story"].transform.localEulerAngles = arg_135_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_0 and arg_135_1.time_ < 0 + var_138_0 + arg_138_0 then
				arg_135_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6.33)
				arg_135_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_135_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_135_1.actors_["10069ui_story"].transform.position).z)
				arg_135_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_135_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_135_1.actors_["10069ui_story"].transform.localEulerAngles = arg_135_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_138_1 = arg_135_1.actors_["10069ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10069ui_story == nil then
				arg_135_1.var_.characterEffect10069ui_story = var_138_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_2 and not isNil(var_138_1) then
				if arg_135_1.var_.characterEffect10069ui_story and not isNil(var_138_1) then
					arg_135_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_2 and arg_135_1.time_ < 0 + var_138_2 + arg_138_0 and not isNil(var_138_1) and arg_135_1.var_.characterEffect10069ui_story then
				arg_135_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_138_4 = arg_135_1.actors_["10066ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos10066ui_story = var_138_4.localPosition
			end

			local var_138_5 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_5 then
				var_138_4.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_135_1.time_ - 0) / var_138_5)
				var_138_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_4.position).x, (manager.ui.mainCamera.transform.position - var_138_4.position).y, (manager.ui.mainCamera.transform.position - var_138_4.position).z)
				var_138_4.localEulerAngles.z = 0
				var_138_4.localEulerAngles.x = 0
				var_138_4.localEulerAngles = var_138_4.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_5 and arg_135_1.time_ < 0 + var_138_5 + arg_138_0 then
				var_138_4.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_138_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_4.position).x, (manager.ui.mainCamera.transform.position - var_138_4.position).y, (manager.ui.mainCamera.transform.position - var_138_4.position).z)
				var_138_4.localEulerAngles.z = 0
				var_138_4.localEulerAngles.x = 0
				var_138_4.localEulerAngles = var_138_4.localEulerAngles
			end

			local var_138_6 = arg_135_1.actors_["10066ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect10066ui_story == nil then
				arg_135_1.var_.characterEffect10066ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_7 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 and not isNil(var_138_6) then
				if arg_135_1.var_.characterEffect10066ui_story and not isNil(var_138_6) then
					arg_135_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_7)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 and not isNil(var_138_6) and arg_135_1.var_.characterEffect10066ui_story then
				arg_135_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_138_8 = 0
			local var_138_9 = 1.15

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_8 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_10 = arg_135_1:GetWordFromCfg(319751032)
				local var_138_11 = arg_135_1:FormatText(var_138_10.content)

				arg_135_1.text_.text = var_138_11

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_13 = 46 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 46)

				if (46 <= 0 and var_138_9 or var_138_9 * (utf8.len(var_138_11) / 46)) > 0 and var_138_9 < var_138_13 then
					arg_135_1.talkMaxDuration = var_138_13

					if var_138_13 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_13 + var_138_8
					end
				end

				arg_135_1.text_.text = var_138_11
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751032", "story_v_out_319751.awb") ~= 0 then
					local var_138_14 = manager.audio:GetVoiceLength("story_v_out_319751", "319751032", "story_v_out_319751.awb") / 1000

					if var_138_14 + var_138_8 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_14 + var_138_8
					end

					if var_138_10.prefab_name ~= "" and arg_135_1.actors_[var_138_10.prefab_name] ~= nil then
						local var_138_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_10.prefab_name].transform, "story_v_out_319751", "319751032", "story_v_out_319751.awb")

						arg_135_1:RecordAudio("319751032", var_138_15)
						arg_135_1:RecordAudio("319751032", var_138_15)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319751", "319751032", "story_v_out_319751.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319751", "319751032", "story_v_out_319751.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_16 = math.max(var_138_9, arg_135_1.talkMaxDuration)

			if var_138_8 <= arg_135_1.time_ and arg_135_1.time_ < var_138_8 + var_138_16 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_8) / var_138_16

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_8 + var_138_16 and arg_135_1.time_ < var_138_8 + var_138_16 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_135_1:InitPlayNodeList()
	end,
	Play319751033 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319751033
		arg_139_1.duration_ = 15.2

		local var_139_0 = {
			zh = 8.6,
			ja = 15.2
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
				arg_139_0:Play319751034(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10069ui_story"]) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = arg_139_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10069ui_story"]) then
				if arg_139_1.var_.characterEffect10069ui_story and not isNil(arg_139_1.actors_["10069ui_story"]) then
					arg_139_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_0)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10069ui_story"]) and arg_139_1.var_.characterEffect10069ui_story then
				arg_139_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_142_1 = arg_139_1.actors_["10066ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10066ui_story == nil then
				arg_139_1.var_.characterEffect10066ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10066ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10066ui_story then
				arg_139_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action434")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_142_4 = 0
			local var_142_5 = 0.85

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(319751033)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 34 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 34)

				if (34 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 34)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751033", "story_v_out_319751.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751033", "story_v_out_319751.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_319751", "319751033", "story_v_out_319751.awb")

						arg_139_1:RecordAudio("319751033", var_142_11)
						arg_139_1:RecordAudio("319751033", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319751", "319751033", "story_v_out_319751.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319751", "319751033", "story_v_out_319751.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_12 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_12 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_12

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_12 and arg_139_1.time_ < var_142_4 + var_142_12 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {}

		arg_139_1:InitPlayNodeList()
	end,
	Play319751034 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319751034
		arg_143_1.duration_ = 8.33

		local var_143_0 = {
			zh = 2.6,
			ja = 8.333
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
				arg_143_0:Play319751035(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10069ui_story"]) and arg_143_1.var_.characterEffect10069ui_story == nil then
				arg_143_1.var_.characterEffect10069ui_story = arg_143_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10069ui_story"]) then
				if arg_143_1.var_.characterEffect10069ui_story and not isNil(arg_143_1.actors_["10069ui_story"]) then
					arg_143_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10069ui_story"]) and arg_143_1.var_.characterEffect10069ui_story then
				arg_143_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_146_2 = arg_143_1.actors_["10066ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect10066ui_story == nil then
				arg_143_1.var_.characterEffect10066ui_story = var_146_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_3 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.characterEffect10066ui_story and not isNil(var_146_2) then
					arg_143_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_3)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect10066ui_story then
				arg_143_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_146_4 = 0
			local var_146_5 = 0.325

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(319751034)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 13 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 13)

				if (13 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 13)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751034", "story_v_out_319751.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751034", "story_v_out_319751.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_319751", "319751034", "story_v_out_319751.awb")

						arg_143_1:RecordAudio("319751034", var_146_11)
						arg_143_1:RecordAudio("319751034", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319751", "319751034", "story_v_out_319751.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319751", "319751034", "story_v_out_319751.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319751035 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319751035
		arg_147_1.duration_ = 8.97

		local var_147_0 = {
			zh = 4.1,
			ja = 8.966
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
				arg_147_0:Play319751036(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10069ui_story = arg_147_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10069ui_story"].transform.position).z)
				arg_147_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10069ui_story"].transform.localEulerAngles = arg_147_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6.33)
				arg_147_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["10069ui_story"].transform.position).z)
				arg_147_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["10069ui_story"].transform.localEulerAngles = arg_147_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["10069ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10069ui_story == nil then
				arg_147_1.var_.characterEffect10069ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect10069ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect10069ui_story then
				arg_147_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_150_4 = 0
			local var_150_5 = 0.5

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(319751035)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 20 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 20)

				if (20 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 20)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751035", "story_v_out_319751.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751035", "story_v_out_319751.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_319751", "319751035", "story_v_out_319751.awb")

						arg_147_1:RecordAudio("319751035", var_150_11)
						arg_147_1:RecordAudio("319751035", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319751", "319751035", "story_v_out_319751.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319751", "319751035", "story_v_out_319751.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_12 = math.max(var_150_5, arg_147_1.talkMaxDuration)

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_12 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_4) / var_150_12

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_4 + var_150_12 and arg_147_1.time_ < var_150_4 + var_150_12 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_147_1:InitPlayNodeList()
	end,
	Play319751036 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319751036
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319751037(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10069ui_story"]) and arg_151_1.var_.characterEffect10069ui_story == nil then
				arg_151_1.var_.characterEffect10069ui_story = arg_151_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10069ui_story"]) then
				if arg_151_1.var_.characterEffect10069ui_story and not isNil(arg_151_1.actors_["10069ui_story"]) then
					arg_151_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10069ui_story"]) and arg_151_1.var_.characterEffect10069ui_story then
				arg_151_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_154_1 = arg_151_1.actors_["10069ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10069ui_story = var_154_1.localPosition
			end

			local var_154_2 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 then
				var_154_1.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_2)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 then
				var_154_1.localPosition = Vector3.New(0, 100, 0)
				var_154_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_1.position).x, (manager.ui.mainCamera.transform.position - var_154_1.position).y, (manager.ui.mainCamera.transform.position - var_154_1.position).z)
				var_154_1.localEulerAngles.z = 0
				var_154_1.localEulerAngles.x = 0
				var_154_1.localEulerAngles = var_154_1.localEulerAngles
			end

			local var_154_3 = arg_151_1.actors_["10066ui_story"].transform

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10066ui_story = var_154_3.localPosition
			end

			local var_154_4 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_4 then
				var_154_3.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_151_1.time_ - 0) / var_154_4)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_4 and arg_151_1.time_ < 0 + var_154_4 + arg_154_0 then
				var_154_3.localPosition = Vector3.New(0, 100, 0)
				var_154_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_154_3.position).x, (manager.ui.mainCamera.transform.position - var_154_3.position).y, (manager.ui.mainCamera.transform.position - var_154_3.position).z)
				var_154_3.localEulerAngles.z = 0
				var_154_3.localEulerAngles.x = 0
				var_154_3.localEulerAngles = var_154_3.localEulerAngles
			end

			local var_154_5 = 0
			local var_154_6 = 0.975

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(319751036).content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 39 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_7) / 39)

				if (39 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_7) / 39)) > 0 and var_154_6 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_10 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_10 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_10

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_10 and arg_151_1.time_ < var_154_5 + var_154_10 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_151_1:InitPlayNodeList()
	end,
	Play319751037 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319751037
		arg_155_1.duration_ = 4.6

		local var_155_0 = {
			zh = 4.6,
			ja = 3.6
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319751038(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos10066ui_story = arg_155_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10066ui_story"].transform.position).z)
				arg_155_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10066ui_story"].transform.localEulerAngles = arg_155_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				arg_155_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["10066ui_story"].transform.position).z)
				arg_155_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["10066ui_story"].transform.localEulerAngles = arg_155_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["10066ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10066ui_story == nil then
				arg_155_1.var_.characterEffect10066ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect10066ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect10066ui_story then
				arg_155_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_2")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_158_4 = 0
			local var_158_5 = 0.425

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_4 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_6 = arg_155_1:GetWordFromCfg(319751037)
				local var_158_7 = arg_155_1:FormatText(var_158_6.content)

				arg_155_1.text_.text = var_158_7

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_9 = 17 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 17)

				if (17 <= 0 and var_158_5 or var_158_5 * (utf8.len(var_158_7) / 17)) > 0 and var_158_5 < var_158_9 then
					arg_155_1.talkMaxDuration = var_158_9

					if var_158_9 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_9 + var_158_4
					end
				end

				arg_155_1.text_.text = var_158_7
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751037", "story_v_out_319751.awb") ~= 0 then
					local var_158_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751037", "story_v_out_319751.awb") / 1000

					if var_158_10 + var_158_4 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_10 + var_158_4
					end

					if var_158_6.prefab_name ~= "" and arg_155_1.actors_[var_158_6.prefab_name] ~= nil then
						local var_158_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_6.prefab_name].transform, "story_v_out_319751", "319751037", "story_v_out_319751.awb")

						arg_155_1:RecordAudio("319751037", var_158_11)
						arg_155_1:RecordAudio("319751037", var_158_11)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319751", "319751037", "story_v_out_319751.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319751", "319751037", "story_v_out_319751.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_12 = math.max(var_158_5, arg_155_1.talkMaxDuration)

			if var_158_4 <= arg_155_1.time_ and arg_155_1.time_ < var_158_4 + var_158_12 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_4) / var_158_12

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_4 + var_158_12 and arg_155_1.time_ < var_158_4 + var_158_12 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play319751038 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319751038
		arg_159_1.duration_ = 10.9

		local var_159_0 = {
			zh = 6.166,
			ja = 10.9
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
				arg_159_0:Play319751039(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos1084ui_story = arg_159_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).z)
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles = arg_159_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_159_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["1084ui_story"].transform.position).z)
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["1084ui_story"].transform.localEulerAngles = arg_159_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["1084ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1084ui_story == nil then
				arg_159_1.var_.characterEffect1084ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect1084ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect1084ui_story then
				arg_159_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_4 = arg_159_1.actors_["10069ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10069ui_story = var_162_4.localPosition
			end

			local var_162_5 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				var_162_4.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_5)
				var_162_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_4.position).x, (manager.ui.mainCamera.transform.position - var_162_4.position).y, (manager.ui.mainCamera.transform.position - var_162_4.position).z)
				var_162_4.localEulerAngles.z = 0
				var_162_4.localEulerAngles.x = 0
				var_162_4.localEulerAngles = var_162_4.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_5 and arg_159_1.time_ < 0 + var_162_5 + arg_162_0 then
				var_162_4.localPosition = Vector3.New(0, 100, 0)
				var_162_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_4.position).x, (manager.ui.mainCamera.transform.position - var_162_4.position).y, (manager.ui.mainCamera.transform.position - var_162_4.position).z)
				var_162_4.localEulerAngles.z = 0
				var_162_4.localEulerAngles.x = 0
				var_162_4.localEulerAngles = var_162_4.localEulerAngles
			end

			local var_162_6 = arg_159_1.actors_["10069ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10069ui_story == nil then
				arg_159_1.var_.characterEffect10069ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_7 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 and not isNil(var_162_6) then
				if arg_159_1.var_.characterEffect10069ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_7)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect10069ui_story then
				arg_159_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_162_8 = arg_159_1.actors_["10066ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos10066ui_story = var_162_8.localPosition
			end

			local var_162_9 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_9 then
				var_162_8.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos10066ui_story, Vector3.New(-0.7, -0.99, -5.83), (arg_159_1.time_ - 0) / var_162_9)
				var_162_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_8.position).x, (manager.ui.mainCamera.transform.position - var_162_8.position).y, (manager.ui.mainCamera.transform.position - var_162_8.position).z)
				var_162_8.localEulerAngles.z = 0
				var_162_8.localEulerAngles.x = 0
				var_162_8.localEulerAngles = var_162_8.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_9 and arg_159_1.time_ < 0 + var_162_9 + arg_162_0 then
				var_162_8.localPosition = Vector3.New(-0.7, -0.99, -5.83)
				var_162_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_162_8.position).x, (manager.ui.mainCamera.transform.position - var_162_8.position).y, (manager.ui.mainCamera.transform.position - var_162_8.position).z)
				var_162_8.localEulerAngles.z = 0
				var_162_8.localEulerAngles.x = 0
				var_162_8.localEulerAngles = var_162_8.localEulerAngles
			end

			local var_162_10 = arg_159_1.actors_["10066ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_10) and arg_159_1.var_.characterEffect10066ui_story == nil then
				arg_159_1.var_.characterEffect10066ui_story = var_162_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_11 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_11 and not isNil(var_162_10) then
				if arg_159_1.var_.characterEffect10066ui_story and not isNil(var_162_10) then
					arg_159_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_11)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_11 and arg_159_1.time_ < 0 + var_162_11 + arg_162_0 and not isNil(var_162_10) and arg_159_1.var_.characterEffect10066ui_story then
				arg_159_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_162_12 = 0
			local var_162_13 = 0.775

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_12 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_14 = arg_159_1:GetWordFromCfg(319751038)
				local var_162_15 = arg_159_1:FormatText(var_162_14.content)

				arg_159_1.text_.text = var_162_15

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_17 = 31 <= 0 and var_162_13 or var_162_13 * (utf8.len(var_162_15) / 31)

				if (31 <= 0 and var_162_13 or var_162_13 * (utf8.len(var_162_15) / 31)) > 0 and var_162_13 < var_162_17 then
					arg_159_1.talkMaxDuration = var_162_17

					if var_162_17 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_17 + var_162_12
					end
				end

				arg_159_1.text_.text = var_162_15
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751038", "story_v_out_319751.awb") ~= 0 then
					local var_162_18 = manager.audio:GetVoiceLength("story_v_out_319751", "319751038", "story_v_out_319751.awb") / 1000

					if var_162_18 + var_162_12 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_18 + var_162_12
					end

					if var_162_14.prefab_name ~= "" and arg_159_1.actors_[var_162_14.prefab_name] ~= nil then
						local var_162_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_14.prefab_name].transform, "story_v_out_319751", "319751038", "story_v_out_319751.awb")

						arg_159_1:RecordAudio("319751038", var_162_19)
						arg_159_1:RecordAudio("319751038", var_162_19)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319751", "319751038", "story_v_out_319751.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319751", "319751038", "story_v_out_319751.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_20 = math.max(var_162_13, arg_159_1.talkMaxDuration)

			if var_162_12 <= arg_159_1.time_ and arg_159_1.time_ < var_162_12 + var_162_20 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_12) / var_162_20

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_12 + var_162_20 and arg_159_1.time_ < var_162_12 + var_162_20 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_159_1:InitPlayNodeList()
	end,
	Play319751039 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319751039
		arg_163_1.duration_ = 7.77

		local var_163_0 = {
			zh = 6.2,
			ja = 7.766
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
				arg_163_0:Play319751040(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10066ui_story"]) and arg_163_1.var_.characterEffect10066ui_story == nil then
				arg_163_1.var_.characterEffect10066ui_story = arg_163_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10066ui_story"]) then
				if arg_163_1.var_.characterEffect10066ui_story and not isNil(arg_163_1.actors_["10066ui_story"]) then
					arg_163_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10066ui_story"]) and arg_163_1.var_.characterEffect10066ui_story then
				arg_163_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action6_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_2 = arg_163_1.actors_["1084ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1084ui_story == nil then
				arg_163_1.var_.characterEffect1084ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect1084ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1084ui_story then
				arg_163_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_166_4 = 0
			local var_166_5 = 0.675

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:GetWordFromCfg(319751039)
				local var_166_7 = arg_163_1:FormatText(var_166_6.content)

				arg_163_1.text_.text = var_166_7

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_9 = 27 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 27)

				if (27 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_7) / 27)) > 0 and var_166_5 < var_166_9 then
					arg_163_1.talkMaxDuration = var_166_9

					if var_166_9 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_9 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_7
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751039", "story_v_out_319751.awb") ~= 0 then
					local var_166_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751039", "story_v_out_319751.awb") / 1000

					if var_166_10 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_10 + var_166_4
					end

					if var_166_6.prefab_name ~= "" and arg_163_1.actors_[var_166_6.prefab_name] ~= nil then
						local var_166_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_6.prefab_name].transform, "story_v_out_319751", "319751039", "story_v_out_319751.awb")

						arg_163_1:RecordAudio("319751039", var_166_11)
						arg_163_1:RecordAudio("319751039", var_166_11)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_319751", "319751039", "story_v_out_319751.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_319751", "319751039", "story_v_out_319751.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_12 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_12 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_12

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_12 and arg_163_1.time_ < var_166_4 + var_166_12 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play319751040 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319751040
		arg_167_1.duration_ = 3.43

		local var_167_0 = {
			zh = 2.9,
			ja = 3.433
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
				arg_167_0:Play319751041(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10069ui_story = arg_167_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_170_0 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 then
				arg_167_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_167_1.time_ - 0) / var_170_0)
				arg_167_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10069ui_story"].transform.position).z)
				arg_167_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10069ui_story"].transform.localEulerAngles = arg_167_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 then
				arg_167_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6.33)
				arg_167_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_167_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_167_1.actors_["10069ui_story"].transform.position).z)
				arg_167_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_167_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_167_1.actors_["10069ui_story"].transform.localEulerAngles = arg_167_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_170_1 = arg_167_1.actors_["10069ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10069ui_story == nil then
				arg_167_1.var_.characterEffect10069ui_story = var_170_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_2 and not isNil(var_170_1) then
				if arg_167_1.var_.characterEffect10069ui_story and not isNil(var_170_1) then
					arg_167_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_2 and arg_167_1.time_ < 0 + var_170_2 + arg_170_0 and not isNil(var_170_1) and arg_167_1.var_.characterEffect10069ui_story then
				arg_167_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_170_4 = arg_167_1.actors_["10066ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos10066ui_story = var_170_4.localPosition
			end

			local var_170_5 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_5 then
				var_170_4.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_5)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_5 and arg_167_1.time_ < 0 + var_170_5 + arg_170_0 then
				var_170_4.localPosition = Vector3.New(0, 100, 0)
				var_170_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_4.position).x, (manager.ui.mainCamera.transform.position - var_170_4.position).y, (manager.ui.mainCamera.transform.position - var_170_4.position).z)
				var_170_4.localEulerAngles.z = 0
				var_170_4.localEulerAngles.x = 0
				var_170_4.localEulerAngles = var_170_4.localEulerAngles
			end

			local var_170_6 = arg_167_1.actors_["10066ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect10066ui_story == nil then
				arg_167_1.var_.characterEffect10066ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_7 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_7 and not isNil(var_170_6) then
				if arg_167_1.var_.characterEffect10066ui_story and not isNil(var_170_6) then
					arg_167_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_7)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_7 and arg_167_1.time_ < 0 + var_170_7 + arg_170_0 and not isNil(var_170_6) and arg_167_1.var_.characterEffect10066ui_story then
				arg_167_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_170_8 = arg_167_1.actors_["1084ui_story"].transform

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.var_.moveOldPos1084ui_story = var_170_8.localPosition
			end

			local var_170_9 = 0.001

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_9 then
				var_170_8.localPosition = Vector3.Lerp(arg_167_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_167_1.time_ - 0) / var_170_9)
				var_170_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_8.position).x, (manager.ui.mainCamera.transform.position - var_170_8.position).y, (manager.ui.mainCamera.transform.position - var_170_8.position).z)
				var_170_8.localEulerAngles.z = 0
				var_170_8.localEulerAngles.x = 0
				var_170_8.localEulerAngles = var_170_8.localEulerAngles
			end

			if arg_167_1.time_ >= 0 + var_170_9 and arg_167_1.time_ < 0 + var_170_9 + arg_170_0 then
				var_170_8.localPosition = Vector3.New(0, 100, 0)
				var_170_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_170_8.position).x, (manager.ui.mainCamera.transform.position - var_170_8.position).y, (manager.ui.mainCamera.transform.position - var_170_8.position).z)
				var_170_8.localEulerAngles.z = 0
				var_170_8.localEulerAngles.x = 0
				var_170_8.localEulerAngles = var_170_8.localEulerAngles
			end

			local var_170_10 = 0
			local var_170_11 = 0.35

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_12 = arg_167_1:GetWordFromCfg(319751040)
				local var_170_13 = arg_167_1:FormatText(var_170_12.content)

				arg_167_1.text_.text = var_170_13

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_15 = 14 <= 0 and var_170_11 or var_170_11 * (utf8.len(var_170_13) / 14)

				if (14 <= 0 and var_170_11 or var_170_11 * (utf8.len(var_170_13) / 14)) > 0 and var_170_11 < var_170_15 then
					arg_167_1.talkMaxDuration = var_170_15

					if var_170_15 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_15 + var_170_10
					end
				end

				arg_167_1.text_.text = var_170_13
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751040", "story_v_out_319751.awb") ~= 0 then
					local var_170_16 = manager.audio:GetVoiceLength("story_v_out_319751", "319751040", "story_v_out_319751.awb") / 1000

					if var_170_16 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_16 + var_170_10
					end

					if var_170_12.prefab_name ~= "" and arg_167_1.actors_[var_170_12.prefab_name] ~= nil then
						local var_170_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_12.prefab_name].transform, "story_v_out_319751", "319751040", "story_v_out_319751.awb")

						arg_167_1:RecordAudio("319751040", var_170_17)
						arg_167_1:RecordAudio("319751040", var_170_17)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_319751", "319751040", "story_v_out_319751.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_319751", "319751040", "story_v_out_319751.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_18 = math.max(var_170_11, arg_167_1.talkMaxDuration)

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_18 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_10) / var_170_18

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_10 + var_170_18 and arg_167_1.time_ < var_170_10 + var_170_18 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
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

		arg_167_1:InitPlayNodeList()
	end,
	Play319751041 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319751041
		arg_171_1.duration_ = 7.27

		local var_171_0 = {
			zh = 7.266,
			ja = 5.1
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
				arg_171_0:Play319751042(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10069ui_story"]) and arg_171_1.var_.characterEffect10069ui_story == nil then
				arg_171_1.var_.characterEffect10069ui_story = arg_171_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10069ui_story"]) then
				if arg_171_1.var_.characterEffect10069ui_story and not isNil(arg_171_1.actors_["10069ui_story"]) then
					arg_171_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_171_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_0)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10069ui_story"]) and arg_171_1.var_.characterEffect10069ui_story then
				arg_171_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_171_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_174_1 = arg_171_1.actors_["10066ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10066ui_story = var_174_1.localPosition
			end

			local var_174_2 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 then
				var_174_1.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_171_1.time_ - 0) / var_174_2)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 then
				var_174_1.localPosition = Vector3.New(0, -0.99, -5.83)
				var_174_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_1.position).x, (manager.ui.mainCamera.transform.position - var_174_1.position).y, (manager.ui.mainCamera.transform.position - var_174_1.position).z)
				var_174_1.localEulerAngles.z = 0
				var_174_1.localEulerAngles.x = 0
				var_174_1.localEulerAngles = var_174_1.localEulerAngles
			end

			local var_174_3 = arg_171_1.actors_["10069ui_story"].transform

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10069ui_story = var_174_3.localPosition
			end

			local var_174_4 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_4 then
				var_174_3.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_171_1.time_ - 0) / var_174_4)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_4 and arg_171_1.time_ < 0 + var_174_4 + arg_174_0 then
				var_174_3.localPosition = Vector3.New(0, 100, 0)
				var_174_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_174_3.position).x, (manager.ui.mainCamera.transform.position - var_174_3.position).y, (manager.ui.mainCamera.transform.position - var_174_3.position).z)
				var_174_3.localEulerAngles.z = 0
				var_174_3.localEulerAngles.x = 0
				var_174_3.localEulerAngles = var_174_3.localEulerAngles
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_174_5 = arg_171_1.actors_["10066ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10066ui_story == nil then
				arg_171_1.var_.characterEffect10066ui_story = var_174_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_6 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_6 and not isNil(var_174_5) then
				if arg_171_1.var_.characterEffect10066ui_story and not isNil(var_174_5) then
					arg_171_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_6 and arg_171_1.time_ < 0 + var_174_6 + arg_174_0 and not isNil(var_174_5) and arg_171_1.var_.characterEffect10066ui_story then
				arg_171_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_174_8 = 0
			local var_174_9 = 0.825

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_8 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_10 = arg_171_1:GetWordFromCfg(319751041)
				local var_174_11 = arg_171_1:FormatText(var_174_10.content)

				arg_171_1.text_.text = var_174_11

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_13 = 33 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 33)

				if (33 <= 0 and var_174_9 or var_174_9 * (utf8.len(var_174_11) / 33)) > 0 and var_174_9 < var_174_13 then
					arg_171_1.talkMaxDuration = var_174_13

					if var_174_13 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_13 + var_174_8
					end
				end

				arg_171_1.text_.text = var_174_11
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751041", "story_v_out_319751.awb") ~= 0 then
					local var_174_14 = manager.audio:GetVoiceLength("story_v_out_319751", "319751041", "story_v_out_319751.awb") / 1000

					if var_174_14 + var_174_8 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_14 + var_174_8
					end

					if var_174_10.prefab_name ~= "" and arg_171_1.actors_[var_174_10.prefab_name] ~= nil then
						local var_174_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_10.prefab_name].transform, "story_v_out_319751", "319751041", "story_v_out_319751.awb")

						arg_171_1:RecordAudio("319751041", var_174_15)
						arg_171_1:RecordAudio("319751041", var_174_15)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319751", "319751041", "story_v_out_319751.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319751", "319751041", "story_v_out_319751.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_16 = math.max(var_174_9, arg_171_1.talkMaxDuration)

			if var_174_8 <= arg_171_1.time_ and arg_171_1.time_ < var_174_8 + var_174_16 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_8) / var_174_16

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_8 + var_174_16 and arg_171_1.time_ < var_174_8 + var_174_16 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_171_1:InitPlayNodeList()
	end,
	Play319751042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319751042
		arg_175_1.duration_ = 3.33

		local var_175_0 = {
			zh = 2.7,
			ja = 3.333
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
				arg_175_0:Play319751043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10069ui_story = arg_175_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10069ui_story"].transform.position).z)
				arg_175_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10069ui_story"].transform.localEulerAngles = arg_175_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6.33)
				arg_175_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["10069ui_story"].transform.position).z)
				arg_175_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["10069ui_story"].transform.localEulerAngles = arg_175_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_178_1 = arg_175_1.actors_["10069ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10069ui_story == nil then
				arg_175_1.var_.characterEffect10069ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect10069ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect10069ui_story then
				arg_175_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_178_4 = arg_175_1.actors_["10066ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10066ui_story = var_178_4.localPosition
			end

			local var_178_5 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_5 then
				var_178_4.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_5)
				var_178_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_4.position).x, (manager.ui.mainCamera.transform.position - var_178_4.position).y, (manager.ui.mainCamera.transform.position - var_178_4.position).z)
				var_178_4.localEulerAngles.z = 0
				var_178_4.localEulerAngles.x = 0
				var_178_4.localEulerAngles = var_178_4.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_5 and arg_175_1.time_ < 0 + var_178_5 + arg_178_0 then
				var_178_4.localPosition = Vector3.New(0, 100, 0)
				var_178_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_4.position).x, (manager.ui.mainCamera.transform.position - var_178_4.position).y, (manager.ui.mainCamera.transform.position - var_178_4.position).z)
				var_178_4.localEulerAngles.z = 0
				var_178_4.localEulerAngles.x = 0
				var_178_4.localEulerAngles = var_178_4.localEulerAngles
			end

			local var_178_6 = 0
			local var_178_7 = 0.25

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_6 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_8 = arg_175_1:GetWordFromCfg(319751042)
				local var_178_9 = arg_175_1:FormatText(var_178_8.content)

				arg_175_1.text_.text = var_178_9

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_11 = 10 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 10)

				if (10 <= 0 and var_178_7 or var_178_7 * (utf8.len(var_178_9) / 10)) > 0 and var_178_7 < var_178_11 then
					arg_175_1.talkMaxDuration = var_178_11

					if var_178_11 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_11 + var_178_6
					end
				end

				arg_175_1.text_.text = var_178_9
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751042", "story_v_out_319751.awb") ~= 0 then
					local var_178_12 = manager.audio:GetVoiceLength("story_v_out_319751", "319751042", "story_v_out_319751.awb") / 1000

					if var_178_12 + var_178_6 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_12 + var_178_6
					end

					if var_178_8.prefab_name ~= "" and arg_175_1.actors_[var_178_8.prefab_name] ~= nil then
						local var_178_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_8.prefab_name].transform, "story_v_out_319751", "319751042", "story_v_out_319751.awb")

						arg_175_1:RecordAudio("319751042", var_178_13)
						arg_175_1:RecordAudio("319751042", var_178_13)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_319751", "319751042", "story_v_out_319751.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_319751", "319751042", "story_v_out_319751.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_14 = math.max(var_178_7, arg_175_1.talkMaxDuration)

			if var_178_6 <= arg_175_1.time_ and arg_175_1.time_ < var_178_6 + var_178_14 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_6) / var_178_14

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_6 + var_178_14 and arg_175_1.time_ < var_178_6 + var_178_14 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_175_1:InitPlayNodeList()
	end,
	Play319751043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319751043
		arg_179_1.duration_ = 2.47

		local var_179_0 = {
			zh = 2.466,
			ja = 2.433
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319751044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1084ui_story = arg_179_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).z)
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles = arg_179_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_179_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).z)
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles = arg_179_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_182_1 = arg_179_1.actors_["1084ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1084ui_story == nil then
				arg_179_1.var_.characterEffect1084ui_story = var_182_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_2 and not isNil(var_182_1) then
				if arg_179_1.var_.characterEffect1084ui_story and not isNil(var_182_1) then
					arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_2 and arg_179_1.time_ < 0 + var_182_2 + arg_182_0 and not isNil(var_182_1) and arg_179_1.var_.characterEffect1084ui_story then
				arg_179_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_182_4 = arg_179_1.actors_["10069ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10069ui_story = var_182_4.localPosition
			end

			local var_182_5 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 then
				var_182_4.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_5)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 then
				var_182_4.localPosition = Vector3.New(0, 100, 0)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			local var_182_6 = arg_179_1.actors_["10069ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect10069ui_story == nil then
				arg_179_1.var_.characterEffect10069ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_7 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_7 and not isNil(var_182_6) then
				if arg_179_1.var_.characterEffect10069ui_story and not isNil(var_182_6) then
					arg_179_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_7)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_7 and arg_179_1.time_ < 0 + var_182_7 + arg_182_0 and not isNil(var_182_6) and arg_179_1.var_.characterEffect10069ui_story then
				arg_179_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_182_8 = arg_179_1.actors_["10066ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10066ui_story = var_182_8.localPosition
			end

			local var_182_9 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_9 then
				var_182_8.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_9)
				var_182_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_8.position).x, (manager.ui.mainCamera.transform.position - var_182_8.position).y, (manager.ui.mainCamera.transform.position - var_182_8.position).z)
				var_182_8.localEulerAngles.z = 0
				var_182_8.localEulerAngles.x = 0
				var_182_8.localEulerAngles = var_182_8.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_9 and arg_179_1.time_ < 0 + var_182_9 + arg_182_0 then
				var_182_8.localPosition = Vector3.New(0, 100, 0)
				var_182_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_8.position).x, (manager.ui.mainCamera.transform.position - var_182_8.position).y, (manager.ui.mainCamera.transform.position - var_182_8.position).z)
				var_182_8.localEulerAngles.z = 0
				var_182_8.localEulerAngles.x = 0
				var_182_8.localEulerAngles = var_182_8.localEulerAngles
			end

			local var_182_10 = arg_179_1.actors_["10066ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_10) and arg_179_1.var_.characterEffect10066ui_story == nil then
				arg_179_1.var_.characterEffect10066ui_story = var_182_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_11 = 0.200000002980232

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_11 and not isNil(var_182_10) then
				if arg_179_1.var_.characterEffect10066ui_story and not isNil(var_182_10) then
					arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_11)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_11 and arg_179_1.time_ < 0 + var_182_11 + arg_182_0 and not isNil(var_182_10) and arg_179_1.var_.characterEffect10066ui_story then
				arg_179_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_182_12 = 0
			local var_182_13 = 0.275

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_12 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_14 = arg_179_1:GetWordFromCfg(319751043)
				local var_182_15 = arg_179_1:FormatText(var_182_14.content)

				arg_179_1.text_.text = var_182_15

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_17 = 11 <= 0 and var_182_13 or var_182_13 * (utf8.len(var_182_15) / 11)

				if (11 <= 0 and var_182_13 or var_182_13 * (utf8.len(var_182_15) / 11)) > 0 and var_182_13 < var_182_17 then
					arg_179_1.talkMaxDuration = var_182_17

					if var_182_17 + var_182_12 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_12
					end
				end

				arg_179_1.text_.text = var_182_15
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751043", "story_v_out_319751.awb") ~= 0 then
					local var_182_18 = manager.audio:GetVoiceLength("story_v_out_319751", "319751043", "story_v_out_319751.awb") / 1000

					if var_182_18 + var_182_12 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_12
					end

					if var_182_14.prefab_name ~= "" and arg_179_1.actors_[var_182_14.prefab_name] ~= nil then
						local var_182_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_14.prefab_name].transform, "story_v_out_319751", "319751043", "story_v_out_319751.awb")

						arg_179_1:RecordAudio("319751043", var_182_19)
						arg_179_1:RecordAudio("319751043", var_182_19)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_319751", "319751043", "story_v_out_319751.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_319751", "319751043", "story_v_out_319751.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_20 = math.max(var_182_13, arg_179_1.talkMaxDuration)

			if var_182_12 <= arg_179_1.time_ and arg_179_1.time_ < var_182_12 + var_182_20 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_12) / var_182_20

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_12 + var_182_20 and arg_179_1.time_ < var_182_12 + var_182_20 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play319751044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319751044
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play319751045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) and arg_183_1.var_.characterEffect1084ui_story == nil then
				arg_183_1.var_.characterEffect1084ui_story = arg_183_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) then
				if arg_183_1.var_.characterEffect1084ui_story and not isNil(arg_183_1.actors_["1084ui_story"]) then
					arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1084ui_story"]) and arg_183_1.var_.characterEffect1084ui_story then
				arg_183_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_186_1 = arg_183_1.actors_["1084ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos1084ui_story = var_186_1.localPosition
			end

			local var_186_2 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_2 then
				var_186_1.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_183_1.time_ - 0) / var_186_2)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_2 and arg_183_1.time_ < 0 + var_186_2 + arg_186_0 then
				var_186_1.localPosition = Vector3.New(0, 100, 0)
				var_186_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_1.position).x, (manager.ui.mainCamera.transform.position - var_186_1.position).y, (manager.ui.mainCamera.transform.position - var_186_1.position).z)
				var_186_1.localEulerAngles.z = 0
				var_186_1.localEulerAngles.x = 0
				var_186_1.localEulerAngles = var_186_1.localEulerAngles
			end

			local var_186_3 = 0
			local var_186_4 = 1.225

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_5 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(319751044).content)

				arg_183_1.text_.text = var_186_5

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_7 = 49 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 49)

				if (49 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_5) / 49)) > 0 and var_186_4 < var_186_7 then
					arg_183_1.talkMaxDuration = var_186_7

					if var_186_7 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_7 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_5
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_8 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_8 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_8

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_8 and arg_183_1.time_ < var_186_3 + var_186_8 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play319751045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319751045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play319751046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.375

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(319751045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 15 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 15)

				if (15 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 15)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play319751046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319751046
		arg_191_1.duration_ = 2.87

		local var_191_0 = {
			zh = 2.866,
			ja = 2.033
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
				arg_191_0:Play319751047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1084ui_story = arg_191_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).z)
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles = arg_191_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_191_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).z)
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles = arg_191_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_194_1 = arg_191_1.actors_["1084ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1084ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1084ui_story then
				arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.325

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= var_194_4 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				arg_191_1.leftNameTxt_.text = arg_191_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_6 = arg_191_1:GetWordFromCfg(319751046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 13 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 13)

				if (13 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 13)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751046", "story_v_out_319751.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751046", "story_v_out_319751.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_319751", "319751046", "story_v_out_319751.awb")

						arg_191_1:RecordAudio("319751046", var_194_11)
						arg_191_1:RecordAudio("319751046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319751", "319751046", "story_v_out_319751.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319751", "319751046", "story_v_out_319751.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_12 = math.max(var_194_5, arg_191_1.talkMaxDuration)

			if var_194_4 <= arg_191_1.time_ and arg_191_1.time_ < var_194_4 + var_194_12 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_4) / var_194_12

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_4 + var_194_12 and arg_191_1.time_ < var_194_4 + var_194_12 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play319751047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319751047
		arg_195_1.duration_ = 5

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play319751048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = arg_195_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) then
				if arg_195_1.var_.characterEffect1084ui_story and not isNil(arg_195_1.actors_["1084ui_story"]) then
					arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) and arg_195_1.var_.characterEffect1084ui_story then
				arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_198_1 = 0
			local var_198_2 = 0.625

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, true)
				arg_195_1.iconController_:SetSelectedState("hero")

				arg_195_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_195_1.callingController_:SetSelectedState("normal")

				arg_195_1.keyicon_.color = Color.New(1, 1, 1)
				arg_195_1.icon_.color = Color.New(1, 1, 1)

				local var_198_3 = arg_195_1:FormatText(arg_195_1:GetWordFromCfg(319751047).content)

				arg_195_1.text_.text = var_198_3

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_5 = 25 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 25)

				if (25 <= 0 and var_198_2 or var_198_2 * (utf8.len(var_198_3) / 25)) > 0 and var_198_2 < var_198_5 then
					arg_195_1.talkMaxDuration = var_198_5

					if var_198_5 + var_198_1 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_5 + var_198_1
					end
				end

				arg_195_1.text_.text = var_198_3
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)
				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_6 = math.max(var_198_2, arg_195_1.talkMaxDuration)

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_6 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_1) / var_198_6

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_1 + var_198_6 and arg_195_1.time_ < var_198_1 + var_198_6 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319751048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319751048
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319751049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = 1.075

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, true)
				arg_199_1.iconController_:SetSelectedState("hero")

				arg_199_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_199_1.callingController_:SetSelectedState("normal")

				arg_199_1.keyicon_.color = Color.New(1, 1, 1)
				arg_199_1.icon_.color = Color.New(1, 1, 1)

				local var_202_1 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(319751048).content)

				arg_199_1.text_.text = var_202_1

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_3 = 43 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 43)

				if (43 <= 0 and var_202_0 or var_202_0 * (utf8.len(var_202_1) / 43)) > 0 and var_202_0 < var_202_3 then
					arg_199_1.talkMaxDuration = var_202_3

					if var_202_3 + 0 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_3 + 0
					end
				end

				arg_199_1.text_.text = var_202_1
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_4 = math.max(var_202_0, arg_199_1.talkMaxDuration)

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - 0) / var_202_4

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play319751049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319751049
		arg_203_1.duration_ = 5

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play319751050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0.775

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, true)
				arg_203_1.iconController_:SetSelectedState("hero")

				arg_203_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_203_1.callingController_:SetSelectedState("normal")

				arg_203_1.keyicon_.color = Color.New(1, 1, 1)
				arg_203_1.icon_.color = Color.New(1, 1, 1)

				local var_206_1 = arg_203_1:FormatText(arg_203_1:GetWordFromCfg(319751049).content)

				arg_203_1.text_.text = var_206_1

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_3 = 31 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 31)

				if (31 <= 0 and var_206_0 or var_206_0 * (utf8.len(var_206_1) / 31)) > 0 and var_206_0 < var_206_3 then
					arg_203_1.talkMaxDuration = var_206_3

					if var_206_3 + 0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_3 + 0
					end
				end

				arg_203_1.text_.text = var_206_1
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)
				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_4 = math.max(var_206_0, arg_203_1.talkMaxDuration)

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_4 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - 0) / var_206_4

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= 0 + var_206_4 and arg_203_1.time_ < 0 + var_206_4 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play319751050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319751050
		arg_207_1.duration_ = 9

		local var_207_0 = {
			zh = 5.7,
			ja = 9
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
				arg_207_0:Play319751051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1084ui_story = arg_207_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).z)
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles = arg_207_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_207_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["1084ui_story"].transform.position).z)
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["1084ui_story"].transform.localEulerAngles = arg_207_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["1084ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1084ui_story == nil then
				arg_207_1.var_.characterEffect1084ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect1084ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect1084ui_story then
				arg_207_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_210_4 = 0
			local var_210_5 = 0.65

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_4 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_6 = arg_207_1:GetWordFromCfg(319751050)
				local var_210_7 = arg_207_1:FormatText(var_210_6.content)

				arg_207_1.text_.text = var_210_7

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_9 = 26 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 26)

				if (26 <= 0 and var_210_5 or var_210_5 * (utf8.len(var_210_7) / 26)) > 0 and var_210_5 < var_210_9 then
					arg_207_1.talkMaxDuration = var_210_9

					if var_210_9 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_9 + var_210_4
					end
				end

				arg_207_1.text_.text = var_210_7
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751050", "story_v_out_319751.awb") ~= 0 then
					local var_210_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751050", "story_v_out_319751.awb") / 1000

					if var_210_10 + var_210_4 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_10 + var_210_4
					end

					if var_210_6.prefab_name ~= "" and arg_207_1.actors_[var_210_6.prefab_name] ~= nil then
						local var_210_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_6.prefab_name].transform, "story_v_out_319751", "319751050", "story_v_out_319751.awb")

						arg_207_1:RecordAudio("319751050", var_210_11)
						arg_207_1:RecordAudio("319751050", var_210_11)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319751", "319751050", "story_v_out_319751.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319751", "319751050", "story_v_out_319751.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_12 = math.max(var_210_5, arg_207_1.talkMaxDuration)

			if var_210_4 <= arg_207_1.time_ and arg_207_1.time_ < var_210_4 + var_210_12 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_4) / var_210_12

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_4 + var_210_12 and arg_207_1.time_ < var_210_4 + var_210_12 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play319751051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319751051
		arg_211_1.duration_ = 5

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319751052(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(arg_211_1.actors_["1084ui_story"]) and arg_211_1.var_.characterEffect1084ui_story == nil then
				arg_211_1.var_.characterEffect1084ui_story = arg_211_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_0 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 and not isNil(arg_211_1.actors_["1084ui_story"]) then
				if arg_211_1.var_.characterEffect1084ui_story and not isNil(arg_211_1.actors_["1084ui_story"]) then
					arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_211_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_0)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 and not isNil(arg_211_1.actors_["1084ui_story"]) and arg_211_1.var_.characterEffect1084ui_story then
				arg_211_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_211_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_214_1 = 0
			local var_214_2 = 0.425

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, true)
				arg_211_1.iconController_:SetSelectedState("hero")

				arg_211_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_211_1.callingController_:SetSelectedState("normal")

				arg_211_1.keyicon_.color = Color.New(1, 1, 1)
				arg_211_1.icon_.color = Color.New(1, 1, 1)

				local var_214_3 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(319751051).content)

				arg_211_1.text_.text = var_214_3

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_5 = 17 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 17)

				if (17 <= 0 and var_214_2 or var_214_2 * (utf8.len(var_214_3) / 17)) > 0 and var_214_2 < var_214_5 then
					arg_211_1.talkMaxDuration = var_214_5

					if var_214_5 + var_214_1 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_5 + var_214_1
					end
				end

				arg_211_1.text_.text = var_214_3
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_6 = math.max(var_214_2, arg_211_1.talkMaxDuration)

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_6 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_1) / var_214_6

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_1 + var_214_6 and arg_211_1.time_ < var_214_1 + var_214_6 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {}

		arg_211_1:InitPlayNodeList()
	end,
	Play319751052 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319751052
		arg_215_1.duration_ = 7.37

		local var_215_0 = {
			zh = 5.633,
			ja = 7.366
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
				arg_215_0:Play319751053(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["1084ui_story"]) and arg_215_1.var_.characterEffect1084ui_story == nil then
				arg_215_1.var_.characterEffect1084ui_story = arg_215_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["1084ui_story"]) then
				if arg_215_1.var_.characterEffect1084ui_story and not isNil(arg_215_1.actors_["1084ui_story"]) then
					arg_215_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["1084ui_story"]) and arg_215_1.var_.characterEffect1084ui_story then
				arg_215_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 then
				arg_215_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_218_2 = 0
			local var_218_3 = 0.725

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_2 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, true)

				arg_215_1.leftNameTxt_.text = arg_215_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_215_1.leftNameTxt_.transform)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1.leftNameTxt_.text)
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_4 = arg_215_1:GetWordFromCfg(319751052)
				local var_218_5 = arg_215_1:FormatText(var_218_4.content)

				arg_215_1.text_.text = var_218_5

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_7 = 29 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 29)

				if (29 <= 0 and var_218_3 or var_218_3 * (utf8.len(var_218_5) / 29)) > 0 and var_218_3 < var_218_7 then
					arg_215_1.talkMaxDuration = var_218_7

					if var_218_7 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_7 + var_218_2
					end
				end

				arg_215_1.text_.text = var_218_5
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751052", "story_v_out_319751.awb") ~= 0 then
					local var_218_8 = manager.audio:GetVoiceLength("story_v_out_319751", "319751052", "story_v_out_319751.awb") / 1000

					if var_218_8 + var_218_2 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_8 + var_218_2
					end

					if var_218_4.prefab_name ~= "" and arg_215_1.actors_[var_218_4.prefab_name] ~= nil then
						local var_218_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_215_1.actors_[var_218_4.prefab_name].transform, "story_v_out_319751", "319751052", "story_v_out_319751.awb")

						arg_215_1:RecordAudio("319751052", var_218_9)
						arg_215_1:RecordAudio("319751052", var_218_9)
					else
						arg_215_1:AudioAction("play", "voice", "story_v_out_319751", "319751052", "story_v_out_319751.awb")
					end

					arg_215_1:RecordHistoryTalkVoice("story_v_out_319751", "319751052", "story_v_out_319751.awb")
				end

				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_10 = math.max(var_218_3, arg_215_1.talkMaxDuration)

			if var_218_2 <= arg_215_1.time_ and arg_215_1.time_ < var_218_2 + var_218_10 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_2) / var_218_10

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_2 + var_218_10 and arg_215_1.time_ < var_218_2 + var_218_10 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319751053 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319751053
		arg_219_1.duration_ = 5

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play319751054(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story == nil then
				arg_219_1.var_.characterEffect1084ui_story = arg_219_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) then
				if arg_219_1.var_.characterEffect1084ui_story and not isNil(arg_219_1.actors_["1084ui_story"]) then
					arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_219_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_219_1.time_ - 0) / var_222_0)
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["1084ui_story"]) and arg_219_1.var_.characterEffect1084ui_story then
				arg_219_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_219_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_222_1 = 0
			local var_222_2 = 0.075

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, true)
				arg_219_1.iconController_:SetSelectedState("hero")

				arg_219_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_219_1.callingController_:SetSelectedState("normal")

				arg_219_1.keyicon_.color = Color.New(1, 1, 1)
				arg_219_1.icon_.color = Color.New(1, 1, 1)

				local var_222_3 = arg_219_1:FormatText(arg_219_1:GetWordFromCfg(319751053).content)

				arg_219_1.text_.text = var_222_3

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_5 = 3 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 3)

				if (3 <= 0 and var_222_2 or var_222_2 * (utf8.len(var_222_3) / 3)) > 0 and var_222_2 < var_222_5 then
					arg_219_1.talkMaxDuration = var_222_5

					if var_222_5 + var_222_1 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_5 + var_222_1
					end
				end

				arg_219_1.text_.text = var_222_3
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)
				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_6 = math.max(var_222_2, arg_219_1.talkMaxDuration)

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_6 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_1) / var_222_6

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_1 + var_222_6 and arg_219_1.time_ < var_222_1 + var_222_6 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319751054 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319751054
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play319751055(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = 0.75

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_1 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319751054).content)

				arg_223_1.text_.text = var_226_1

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_3 = 30 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 30)

				if (30 <= 0 and var_226_0 or var_226_0 * (utf8.len(var_226_1) / 30)) > 0 and var_226_0 < var_226_3 then
					arg_223_1.talkMaxDuration = var_226_3

					if var_226_3 + 0 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_3 + 0
					end
				end

				arg_223_1.text_.text = var_226_1
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_4 = math.max(var_226_0, arg_223_1.talkMaxDuration)

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_4 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - 0) / var_226_4

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= 0 + var_226_4 and arg_223_1.time_ < 0 + var_226_4 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play319751055 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319751055
		arg_227_1.duration_ = 5

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play319751056(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0.65

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, true)
				arg_227_1.iconController_:SetSelectedState("hero")

				arg_227_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_227_1.callingController_:SetSelectedState("normal")

				arg_227_1.keyicon_.color = Color.New(1, 1, 1)
				arg_227_1.icon_.color = Color.New(1, 1, 1)

				local var_230_1 = arg_227_1:FormatText(arg_227_1:GetWordFromCfg(319751055).content)

				arg_227_1.text_.text = var_230_1

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_3 = 26 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 26)

				if (26 <= 0 and var_230_0 or var_230_0 * (utf8.len(var_230_1) / 26)) > 0 and var_230_0 < var_230_3 then
					arg_227_1.talkMaxDuration = var_230_3

					if var_230_3 + 0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_3 + 0
					end
				end

				arg_227_1.text_.text = var_230_1
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)
				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_4 = math.max(var_230_0, arg_227_1.talkMaxDuration)

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_4 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - 0) / var_230_4

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= 0 + var_230_4 and arg_227_1.time_ < 0 + var_230_4 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {}

		arg_227_1:InitPlayNodeList()
	end,
	Play319751056 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319751056
		arg_231_1.duration_ = 7.8

		local var_231_0 = {
			zh = 7.8,
			ja = 5.733
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
				arg_231_0:Play319751057(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story == nil then
				arg_231_1.var_.characterEffect1084ui_story = arg_231_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) then
				if arg_231_1.var_.characterEffect1084ui_story and not isNil(arg_231_1.actors_["1084ui_story"]) then
					arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["1084ui_story"]) and arg_231_1.var_.characterEffect1084ui_story then
				arg_231_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 then
				arg_231_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			local var_234_2 = 0
			local var_234_3 = 0.9

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_2 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				arg_231_1.leftNameTxt_.text = arg_231_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_4 = arg_231_1:GetWordFromCfg(319751056)
				local var_234_5 = arg_231_1:FormatText(var_234_4.content)

				arg_231_1.text_.text = var_234_5

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_7 = 36 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 36)

				if (36 <= 0 and var_234_3 or var_234_3 * (utf8.len(var_234_5) / 36)) > 0 and var_234_3 < var_234_7 then
					arg_231_1.talkMaxDuration = var_234_7

					if var_234_7 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_7 + var_234_2
					end
				end

				arg_231_1.text_.text = var_234_5
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751056", "story_v_out_319751.awb") ~= 0 then
					local var_234_8 = manager.audio:GetVoiceLength("story_v_out_319751", "319751056", "story_v_out_319751.awb") / 1000

					if var_234_8 + var_234_2 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_8 + var_234_2
					end

					if var_234_4.prefab_name ~= "" and arg_231_1.actors_[var_234_4.prefab_name] ~= nil then
						local var_234_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_4.prefab_name].transform, "story_v_out_319751", "319751056", "story_v_out_319751.awb")

						arg_231_1:RecordAudio("319751056", var_234_9)
						arg_231_1:RecordAudio("319751056", var_234_9)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_319751", "319751056", "story_v_out_319751.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_319751", "319751056", "story_v_out_319751.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_10 = math.max(var_234_3, arg_231_1.talkMaxDuration)

			if var_234_2 <= arg_231_1.time_ and arg_231_1.time_ < var_234_2 + var_234_10 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_2) / var_234_10

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_2 + var_234_10 and arg_231_1.time_ < var_234_2 + var_234_10 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play319751057 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319751057
		arg_235_1.duration_ = 5

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319751058(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) and arg_235_1.var_.characterEffect1084ui_story == nil then
				arg_235_1.var_.characterEffect1084ui_story = arg_235_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_0 = 0.200000002980232

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) then
				if arg_235_1.var_.characterEffect1084ui_story and not isNil(arg_235_1.actors_["1084ui_story"]) then
					arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_235_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_235_1.time_ - 0) / var_238_0)
				end
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 and not isNil(arg_235_1.actors_["1084ui_story"]) and arg_235_1.var_.characterEffect1084ui_story then
				arg_235_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_235_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_238_1 = 0
			local var_238_2 = 0.25

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				arg_235_1.leftNameTxt_.text = arg_235_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, true)
				arg_235_1.iconController_:SetSelectedState("hero")

				arg_235_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_235_1.callingController_:SetSelectedState("normal")

				arg_235_1.keyicon_.color = Color.New(1, 1, 1)
				arg_235_1.icon_.color = Color.New(1, 1, 1)

				local var_238_3 = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(319751057).content)

				arg_235_1.text_.text = var_238_3

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_5 = 10 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 10)

				if (10 <= 0 and var_238_2 or var_238_2 * (utf8.len(var_238_3) / 10)) > 0 and var_238_2 < var_238_5 then
					arg_235_1.talkMaxDuration = var_238_5

					if var_238_5 + var_238_1 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_5 + var_238_1
					end
				end

				arg_235_1.text_.text = var_238_3
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)
				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_6 = math.max(var_238_2, arg_235_1.talkMaxDuration)

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_6 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_1) / var_238_6

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_1 + var_238_6 and arg_235_1.time_ < var_238_1 + var_238_6 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end

		arg_235_1.nodeConfigList_ = {}

		arg_235_1:InitPlayNodeList()
	end,
	Play319751058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319751058
		arg_239_1.duration_ = 9.1

		local var_239_0 = {
			zh = 7.866,
			ja = 9.1
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319751059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.var_.moveOldPos1084ui_story = arg_239_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_242_0 = 0.001

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_0 then
				arg_239_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_239_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_239_1.time_ - 0) / var_242_0)
				arg_239_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).z)
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles = arg_239_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_239_1.time_ >= 0 + var_242_0 and arg_239_1.time_ < 0 + var_242_0 + arg_242_0 then
				arg_239_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_239_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_239_1.actors_["1084ui_story"].transform.position).z)
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_239_1.actors_["1084ui_story"].transform.localEulerAngles = arg_239_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_242_1 = arg_239_1.actors_["1084ui_story"]

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1084ui_story == nil then
				arg_239_1.var_.characterEffect1084ui_story = var_242_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_242_2 = 0.200000002980232

			if 0 <= arg_239_1.time_ and arg_239_1.time_ < 0 + var_242_2 and not isNil(var_242_1) then
				if arg_239_1.var_.characterEffect1084ui_story and not isNil(var_242_1) then
					arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_239_1.time_ >= 0 + var_242_2 and arg_239_1.time_ < 0 + var_242_2 + arg_242_0 and not isNil(var_242_1) and arg_239_1.var_.characterEffect1084ui_story then
				arg_239_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			local var_242_4 = 0
			local var_242_5 = 1.025

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				arg_239_1.leftNameTxt_.text = arg_239_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:GetWordFromCfg(319751058)
				local var_242_7 = arg_239_1:FormatText(var_242_6.content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 41 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 41)

				if (41 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 41)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751058", "story_v_out_319751.awb") ~= 0 then
					local var_242_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751058", "story_v_out_319751.awb") / 1000

					if var_242_10 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_10 + var_242_4
					end

					if var_242_6.prefab_name ~= "" and arg_239_1.actors_[var_242_6.prefab_name] ~= nil then
						local var_242_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_6.prefab_name].transform, "story_v_out_319751", "319751058", "story_v_out_319751.awb")

						arg_239_1:RecordAudio("319751058", var_242_11)
						arg_239_1:RecordAudio("319751058", var_242_11)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_319751", "319751058", "story_v_out_319751.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_319751", "319751058", "story_v_out_319751.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_12 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 <= arg_239_1.time_ and arg_239_1.time_ < var_242_4 + var_242_12 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_4) / var_242_12

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_4 + var_242_12 and arg_239_1.time_ < var_242_4 + var_242_12 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {
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

		arg_239_1:InitPlayNodeList()
	end,
	Play319751059 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 319751059
		arg_243_1.duration_ = 5

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play319751060(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			if 0 < arg_243_1.time_ and arg_243_1.time_ <= 0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story == nil then
				arg_243_1.var_.characterEffect1084ui_story = arg_243_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_246_0 = 0.200000002980232

			if 0 <= arg_243_1.time_ and arg_243_1.time_ < 0 + var_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) then
				if arg_243_1.var_.characterEffect1084ui_story and not isNil(arg_243_1.actors_["1084ui_story"]) then
					arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_243_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_243_1.time_ - 0) / var_246_0)
				end
			end

			if arg_243_1.time_ >= 0 + var_246_0 and arg_243_1.time_ < 0 + var_246_0 + arg_246_0 and not isNil(arg_243_1.actors_["1084ui_story"]) and arg_243_1.var_.characterEffect1084ui_story then
				arg_243_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_243_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_246_1 = 0
			local var_246_2 = 1.05

			if 0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_1 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				arg_243_1.leftNameTxt_.text = arg_243_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, true)
				arg_243_1.iconController_:SetSelectedState("hero")

				arg_243_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_243_1.callingController_:SetSelectedState("normal")

				arg_243_1.keyicon_.color = Color.New(1, 1, 1)
				arg_243_1.icon_.color = Color.New(1, 1, 1)

				local var_246_3 = arg_243_1:FormatText(arg_243_1:GetWordFromCfg(319751059).content)

				arg_243_1.text_.text = var_246_3

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 42 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 42)

				if (42 <= 0 and var_246_2 or var_246_2 * (utf8.len(var_246_3) / 42)) > 0 and var_246_2 < var_246_5 then
					arg_243_1.talkMaxDuration = var_246_5

					if var_246_5 + var_246_1 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_5 + var_246_1
					end
				end

				arg_243_1.text_.text = var_246_3
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)
				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_6 = math.max(var_246_2, arg_243_1.talkMaxDuration)

			if var_246_1 <= arg_243_1.time_ and arg_243_1.time_ < var_246_1 + var_246_6 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_1) / var_246_6

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_1 + var_246_6 and arg_243_1.time_ < var_246_1 + var_246_6 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end

		arg_243_1.nodeConfigList_ = {}

		arg_243_1:InitPlayNodeList()
	end,
	Play319751060 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 319751060
		arg_247_1.duration_ = 5

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play319751061(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			if 0 < arg_247_1.time_ and arg_247_1.time_ <= 0 + arg_250_0 then
				arg_247_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2202cva")
			end

			local var_250_0 = 0
			local var_250_1 = 0.75

			if 0 < arg_247_1.time_ and arg_247_1.time_ <= var_250_0 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, false)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_2 = arg_247_1:FormatText(arg_247_1:GetWordFromCfg(319751060).content)

				arg_247_1.text_.text = var_250_2

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_4 = 30 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_2) / 30)

				if (30 <= 0 and var_250_1 or var_250_1 * (utf8.len(var_250_2) / 30)) > 0 and var_250_1 < var_250_4 then
					arg_247_1.talkMaxDuration = var_250_4

					if var_250_4 + var_250_0 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_4 + var_250_0
					end
				end

				arg_247_1.text_.text = var_250_2
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)
				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_5 = math.max(var_250_1, arg_247_1.talkMaxDuration)

			if var_250_0 <= arg_247_1.time_ and arg_247_1.time_ < var_250_0 + var_250_5 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_0) / var_250_5

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_0 + var_250_5 and arg_247_1.time_ < var_250_0 + var_250_5 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end

		arg_247_1.nodeConfigList_ = {}

		arg_247_1:InitPlayNodeList()
	end,
	Play319751061 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 319751061
		arg_251_1.duration_ = 3.13

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play319751062(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_0 = arg_251_1.fswbg_.transform:Find("textbox/adapt/content") or arg_251_1.fswbg_.transform:Find("textbox/content")
				local var_254_1 = arg_251_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_254_2 = var_254_0:GetComponent("RectTransform")

				var_254_0:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_254_2.offsetMin = Vector2.New(0, 0)
				var_254_2.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.fswbg_:SetActive(true)
				arg_251_1.dialog_:SetActive(false)

				arg_251_1.fswtw_.percent = 0
				arg_251_1.fswt_.text = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(319751061).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.fswt_)

				arg_251_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_251_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_251_1.fswtw_:SetDirty()

				arg_251_1.typewritterCharCountI18N = 0

				SetActive(arg_251_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_251_1:ShowNextGo(false)
			end

			local var_254_3 = 0.433333333333333

			if 0.433333333333333 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.var_.oldValueTypewriter = arg_251_1.fswtw_.percent

				SetActive(arg_251_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_251_1:ShowNextGo(false)
			end

			local var_254_4 = 7
			local var_254_5 = 0.466666666666667
			local var_254_6, var_254_7 = arg_251_1:GetPercentByPara(arg_251_1:FormatText(arg_251_1:GetWordFromCfg(319751061).content), 1)

			if var_254_3 < arg_251_1.time_ and arg_251_1.time_ <= var_254_3 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0

				local var_254_8 = var_254_4 <= 0 and var_254_5 or var_254_5 * ((var_254_7 - arg_251_1.typewritterCharCountI18N) / var_254_4)

				if (var_254_4 <= 0 and var_254_5 or var_254_5 * ((var_254_7 - arg_251_1.typewritterCharCountI18N) / var_254_4)) > 0 and var_254_5 < var_254_8 then
					arg_251_1.talkMaxDuration = var_254_8

					if var_254_8 + var_254_3 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_8 + var_254_3
					end
				end
			end

			local var_254_9 = math.max(0.466666666666667, arg_251_1.talkMaxDuration)

			if var_254_3 <= arg_251_1.time_ and arg_251_1.time_ < var_254_3 + var_254_9 then
				arg_251_1.fswtw_.percent = Mathf.Lerp(arg_251_1.var_.oldValueTypewriter, var_254_6, (arg_251_1.time_ - var_254_3) / var_254_9)
				arg_251_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_251_1.fswtw_:SetDirty()
			end

			if arg_251_1.time_ >= var_254_3 + var_254_9 and arg_251_1.time_ < var_254_3 + var_254_9 + arg_254_0 then
				arg_251_1.fswtw_.percent = var_254_6

				arg_251_1.fswtw_:SetDirty()
				arg_251_1:ShowNextGo(true)

				arg_251_1.typewritterCharCountI18N = var_254_7
			end

			local var_254_10 = arg_251_1.actors_["1084ui_story"].transform

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.var_.moveOldPos1084ui_story = var_254_10.localPosition
			end

			local var_254_11 = 0.001

			if 0 <= arg_251_1.time_ and arg_251_1.time_ < 0 + var_254_11 then
				var_254_10.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_251_1.time_ - 0) / var_254_11)
				var_254_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_10.position).x, (manager.ui.mainCamera.transform.position - var_254_10.position).y, (manager.ui.mainCamera.transform.position - var_254_10.position).z)
				var_254_10.localEulerAngles.z = 0
				var_254_10.localEulerAngles.x = 0
				var_254_10.localEulerAngles = var_254_10.localEulerAngles
			end

			if arg_251_1.time_ >= 0 + var_254_11 and arg_251_1.time_ < 0 + var_254_11 + arg_254_0 then
				var_254_10.localPosition = Vector3.New(0, 100, 0)
				var_254_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_254_10.position).x, (manager.ui.mainCamera.transform.position - var_254_10.position).y, (manager.ui.mainCamera.transform.position - var_254_10.position).z)
				var_254_10.localEulerAngles.z = 0
				var_254_10.localEulerAngles.x = 0
				var_254_10.localEulerAngles = var_254_10.localEulerAngles
			end

			local var_254_12 = "STblack"

			if arg_251_1.bgs_.STblack == nil then
				local var_254_13 = Object.Instantiate(arg_251_1.paintGo_)

				var_254_13:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_254_12)
				var_254_13.name = var_254_12
				var_254_13.transform.parent = arg_251_1.stage_.transform
				var_254_13.transform.localPosition = Vector3.New(0, 100, 0)
				arg_251_1.bgs_[var_254_12] = var_254_13
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				local var_254_14 = arg_251_1.bgs_.STblack

				arg_251_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_254_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_254_15 = var_254_14:GetComponent("SpriteRenderer")

				if var_254_15 and var_254_15.sprite then
					local var_254_16 = 2 * (var_254_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_254_14.transform.localScale = Vector3.New(var_254_16 / var_254_15.sprite.bounds.size.y < var_254_16 * manager.ui.mainCameraCom_.aspect / var_254_15.sprite.bounds.size.x and var_254_16 * manager.ui.mainCameraCom_.aspect / var_254_15.sprite.bounds.size.x or var_254_16 / var_254_15.sprite.bounds.size.y, var_254_16 / var_254_15.sprite.bounds.size.y < var_254_16 * manager.ui.mainCameraCom_.aspect / var_254_15.sprite.bounds.size.x and var_254_16 * manager.ui.mainCameraCom_.aspect / var_254_15.sprite.bounds.size.x or var_254_16 / var_254_15.sprite.bounds.size.y, 0)
				end

				for iter_254_0, iter_254_1 in pairs(arg_251_1.bgs_) do
					if iter_254_0 ~= "STblack" then
						iter_254_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_254_17 = 0.433333333333333
			local var_254_18 = manager.audio:GetVoiceLength("story_v_out_319751", "319751061", "story_v_out_319751.awb") / 1000

			if var_254_18 > 0 and 2.7 < var_254_18 and var_254_18 + var_254_17 > arg_251_1.duration_ then
				arg_251_1.duration_ = var_254_18 + var_254_17
			end

			if var_254_17 < arg_251_1.time_ and arg_251_1.time_ <= var_254_17 + arg_254_0 then
				arg_251_1:AudioAction("play", "voice", "story_v_out_319751", "319751061", "story_v_out_319751.awb")
			end

			if 0 < arg_251_1.time_ and arg_251_1.time_ <= 0 + arg_254_0 then
				arg_251_1.cswbg_:SetActive(true)

				local var_254_20 = arg_251_1.cswt_:GetComponent("RectTransform")

				arg_251_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_254_20.offsetMin = Vector2.New(410, 330)
				var_254_20.offsetMax = Vector2.New(-400, -175)
				arg_251_1.cswt_.text = arg_251_1:FormatText(arg_251_1:GetWordFromCfg(419051).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.cswt_)

				arg_251_1.cswt_.fontSize = 180
				arg_251_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_251_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_251_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end
		end

		arg_251_1.nodeConfigList_ = {
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

		arg_251_1:InitPlayNodeList()
	end,
	Play319751062 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 319751062
		arg_255_1.duration_ = 9.53

		local var_255_0 = {
			zh = 4.9333333303531,
			ja = 9.5333333303531
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play319751063(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			if 1 < arg_255_1.time_ and arg_255_1.time_ <= 1 + arg_258_0 then
				local var_258_0 = arg_255_1.bgs_.ST72

				arg_255_1.bgs_.ST72.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_258_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_258_1 = var_258_0:GetComponent("SpriteRenderer")

				if var_258_1 and var_258_1.sprite then
					local var_258_2 = 2 * (var_258_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_258_0.transform.localScale = Vector3.New(var_258_2 / var_258_1.sprite.bounds.size.y < var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x and var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x or var_258_2 / var_258_1.sprite.bounds.size.y, var_258_2 / var_258_1.sprite.bounds.size.y < var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x and var_258_2 * manager.ui.mainCameraCom_.aspect / var_258_1.sprite.bounds.size.x or var_258_2 / var_258_1.sprite.bounds.size.y, 0)
				end

				for iter_258_0, iter_258_1 in pairs(arg_255_1.bgs_) do
					if iter_258_0 ~= "ST72" then
						iter_258_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_258_3 = 0

			if 0 < arg_255_1.time_ and arg_255_1.time_ <= var_258_3 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_4 = 1

			if var_258_3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_3 + var_258_4 then
				local var_258_5 = Color.New(0, 0, 0)

				var_258_5.a = Mathf.Lerp(0, 1, (arg_255_1.time_ - var_258_3) / var_258_4)
				arg_255_1.mask_.color = var_258_5
			end

			if arg_255_1.time_ >= var_258_3 + var_258_4 and arg_255_1.time_ < var_258_3 + var_258_4 + arg_258_0 then
				local var_258_6 = Color.New(0, 0, 0)

				var_258_6.a = 1
				arg_255_1.mask_.color = var_258_6
			end

			local var_258_7 = 1

			if 1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 then
				arg_255_1.mask_.enabled = true
				arg_255_1.mask_.raycastTarget = true

				arg_255_1:SetGaussion(false)
			end

			local var_258_8 = 1.93333333333333

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 then
				local var_258_9 = Color.New(0, 0, 0)

				var_258_9.a = Mathf.Lerp(1, 0, (arg_255_1.time_ - var_258_7) / var_258_8)
				arg_255_1.mask_.color = var_258_9
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 then
				local var_258_10 = Color.New(0, 0, 0)

				arg_255_1.mask_.enabled = false
				var_258_10.a = 0
				arg_255_1.mask_.color = var_258_10
			end

			local var_258_11 = arg_255_1.actors_["1084ui_story"]

			if 2.7673333303531 < arg_255_1.time_ and arg_255_1.time_ <= 2.7673333303531 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.characterEffect1084ui_story == nil then
				arg_255_1.var_.characterEffect1084ui_story = var_258_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_12 = 0.2

			if 2.7673333303531 <= arg_255_1.time_ and arg_255_1.time_ < 2.7673333303531 + var_258_12 and not isNil(var_258_11) then
				if arg_255_1.var_.characterEffect1084ui_story and not isNil(var_258_11) then
					arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= 2.7673333303531 + var_258_12 and arg_255_1.time_ < 2.7673333303531 + var_258_12 + arg_258_0 and not isNil(var_258_11) and arg_255_1.var_.characterEffect1084ui_story then
				arg_255_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_258_14 = arg_255_1.actors_["1084ui_story"].transform

			if 1 < arg_255_1.time_ and arg_255_1.time_ <= 1 + arg_258_0 then
				arg_255_1.var_.moveOldPos1084ui_story = var_258_14.localPosition
			end

			local var_258_15 = 0.001

			if 1 <= arg_255_1.time_ and arg_255_1.time_ < 1 + var_258_15 then
				var_258_14.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_255_1.time_ - 1) / var_258_15)
				var_258_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_14.position).x, (manager.ui.mainCamera.transform.position - var_258_14.position).y, (manager.ui.mainCamera.transform.position - var_258_14.position).z)
				var_258_14.localEulerAngles.z = 0
				var_258_14.localEulerAngles.x = 0
				var_258_14.localEulerAngles = var_258_14.localEulerAngles
			end

			if arg_255_1.time_ >= 1 + var_258_15 and arg_255_1.time_ < 1 + var_258_15 + arg_258_0 then
				var_258_14.localPosition = Vector3.New(0, 100, 0)
				var_258_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_14.position).x, (manager.ui.mainCamera.transform.position - var_258_14.position).y, (manager.ui.mainCamera.transform.position - var_258_14.position).z)
				var_258_14.localEulerAngles.z = 0
				var_258_14.localEulerAngles.x = 0
				var_258_14.localEulerAngles = var_258_14.localEulerAngles
			end

			local var_258_16 = arg_255_1.actors_["1084ui_story"].transform

			if 2.7673333303531 < arg_255_1.time_ and arg_255_1.time_ <= 2.7673333303531 + arg_258_0 then
				arg_255_1.var_.moveOldPos1084ui_story = var_258_16.localPosition
			end

			local var_258_17 = 0.001

			if 2.7673333303531 <= arg_255_1.time_ and arg_255_1.time_ < 2.7673333303531 + var_258_17 then
				var_258_16.localPosition = Vector3.Lerp(arg_255_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_255_1.time_ - 2.7673333303531) / var_258_17)
				var_258_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_16.position).x, (manager.ui.mainCamera.transform.position - var_258_16.position).y, (manager.ui.mainCamera.transform.position - var_258_16.position).z)
				var_258_16.localEulerAngles.z = 0
				var_258_16.localEulerAngles.x = 0
				var_258_16.localEulerAngles = var_258_16.localEulerAngles
			end

			if arg_255_1.time_ >= 2.7673333303531 + var_258_17 and arg_255_1.time_ < 2.7673333303531 + var_258_17 + arg_258_0 then
				var_258_16.localPosition = Vector3.New(0, -0.97, -6)
				var_258_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_258_16.position).x, (manager.ui.mainCamera.transform.position - var_258_16.position).y, (manager.ui.mainCamera.transform.position - var_258_16.position).z)
				var_258_16.localEulerAngles.z = 0
				var_258_16.localEulerAngles.x = 0
				var_258_16.localEulerAngles = var_258_16.localEulerAngles
			end

			if 1 < arg_255_1.time_ and arg_255_1.time_ <= 1 + arg_258_0 then
				arg_255_1.fswbg_:SetActive(false)
				arg_255_1.dialog_:SetActive(false)
				SetActive(arg_255_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_255_1:ShowNextGo(false)
			end

			if 1.03400000184774 < arg_255_1.time_ and arg_255_1.time_ <= 1.03400000184774 + arg_258_0 then
				arg_255_1.fswbg_:SetActive(false)
				arg_255_1.dialog_:SetActive(false)
				SetActive(arg_255_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_255_1:ShowNextGo(false)
			end

			if 1 < arg_255_1.time_ and arg_255_1.time_ <= 1 + arg_258_0 then
				arg_255_1.cswbg_:SetActive(false)
			end

			if 2.7673333303531 < arg_255_1.time_ and arg_255_1.time_ <= 2.7673333303531 + arg_258_0 then
				arg_255_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action487")
			end

			if arg_255_1.frameCnt_ <= 1 then
				arg_255_1.dialog_:SetActive(false)
			end

			local var_258_18 = 2.9333333303531
			local var_258_19 = 0.2

			if 2.9333333303531 < arg_255_1.time_ and arg_255_1.time_ <= var_258_18 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0

				arg_255_1.dialog_:SetActive(true)

				arg_255_1.dialogCg_.alpha = 0

				local var_258_20 = LeanTween.value(arg_255_1.dialog_, 0, 1, 0.3)

				var_258_20:setOnUpdate(LuaHelper.FloatAction(function(arg_259_0)
					arg_255_1.dialogCg_.alpha = arg_259_0
				end))
				var_258_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_255_1.dialog_)
					var_258_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_255_1.duration_ = arg_255_1.duration_ + 0.3

				SetActive(arg_255_1.leftNameGo_, true)

				arg_255_1.leftNameTxt_.text = arg_255_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_21 = arg_255_1:GetWordFromCfg(319751062)
				local var_258_22 = arg_255_1:FormatText(var_258_21.content)

				arg_255_1.text_.text = var_258_22

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_24 = 8 <= 0 and var_258_19 or var_258_19 * (utf8.len(var_258_22) / 8)

				if (8 <= 0 and var_258_19 or var_258_19 * (utf8.len(var_258_22) / 8)) > 0 and var_258_19 < var_258_24 then
					arg_255_1.talkMaxDuration = var_258_24
					var_258_18 = var_258_18 + 0.3

					if var_258_24 + var_258_18 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_24 + var_258_18
					end
				end

				arg_255_1.text_.text = var_258_22
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751062", "story_v_out_319751.awb") ~= 0 then
					local var_258_25 = manager.audio:GetVoiceLength("story_v_out_319751", "319751062", "story_v_out_319751.awb") / 1000

					if var_258_25 + var_258_18 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_25 + var_258_18
					end

					if var_258_21.prefab_name ~= "" and arg_255_1.actors_[var_258_21.prefab_name] ~= nil then
						local var_258_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_21.prefab_name].transform, "story_v_out_319751", "319751062", "story_v_out_319751.awb")

						arg_255_1:RecordAudio("319751062", var_258_26)
						arg_255_1:RecordAudio("319751062", var_258_26)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_319751", "319751062", "story_v_out_319751.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_319751", "319751062", "story_v_out_319751.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_27 = var_258_18 + 0.3
			local var_258_28 = math.max(var_258_19, arg_255_1.talkMaxDuration)

			if var_258_18 + 0.3 <= arg_255_1.time_ and arg_255_1.time_ < var_258_27 + var_258_28 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_27) / var_258_28

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_27 + var_258_28 and arg_255_1.time_ < var_258_27 + var_258_28 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end

		arg_255_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2.7673333303531,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_255_1:InitPlayNodeList()
	end,
	Play319751063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 319751063
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play319751064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["1084ui_story"]) and arg_261_1.var_.characterEffect1084ui_story == nil then
				arg_261_1.var_.characterEffect1084ui_story = arg_261_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.2

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["1084ui_story"]) then
				if arg_261_1.var_.characterEffect1084ui_story and not isNil(arg_261_1.actors_["1084ui_story"]) then
					arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_261_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["1084ui_story"]) and arg_261_1.var_.characterEffect1084ui_story then
				arg_261_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_261_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.525

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, true)
				arg_261_1.iconController_:SetSelectedState("hero")

				arg_261_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_261_1.callingController_:SetSelectedState("normal")

				arg_261_1.keyicon_.color = Color.New(1, 1, 1)
				arg_261_1.icon_.color = Color.New(1, 1, 1)

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(319751063).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 21 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 21)

				if (21 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 21)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play319751064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319751064
		arg_265_1.duration_ = 7.33

		local var_265_0 = {
			zh = 4.266,
			ja = 7.333
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319751065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.var_.moveOldPos1084ui_story = arg_265_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_268_0 = 0.001

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 then
				arg_265_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_265_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_265_1.time_ - 0) / var_268_0)
				arg_265_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).z)
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles = arg_265_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 then
				arg_265_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_265_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_265_1.actors_["1084ui_story"].transform.position).z)
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_265_1.actors_["1084ui_story"].transform.localEulerAngles = arg_265_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_268_1 = arg_265_1.actors_["1084ui_story"]

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1084ui_story == nil then
				arg_265_1.var_.characterEffect1084ui_story = var_268_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_2 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_2 and not isNil(var_268_1) then
				if arg_265_1.var_.characterEffect1084ui_story and not isNil(var_268_1) then
					arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_2 and arg_265_1.time_ < 0 + var_268_2 + arg_268_0 and not isNil(var_268_1) and arg_265_1.var_.characterEffect1084ui_story then
				arg_265_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_268_4 = 0
			local var_268_5 = 0.525

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_4 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_6 = arg_265_1:GetWordFromCfg(319751064)
				local var_268_7 = arg_265_1:FormatText(var_268_6.content)

				arg_265_1.text_.text = var_268_7

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_9 = 21 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 21)

				if (21 <= 0 and var_268_5 or var_268_5 * (utf8.len(var_268_7) / 21)) > 0 and var_268_5 < var_268_9 then
					arg_265_1.talkMaxDuration = var_268_9

					if var_268_9 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_9 + var_268_4
					end
				end

				arg_265_1.text_.text = var_268_7
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319751", "319751064", "story_v_out_319751.awb") ~= 0 then
					local var_268_10 = manager.audio:GetVoiceLength("story_v_out_319751", "319751064", "story_v_out_319751.awb") / 1000

					if var_268_10 + var_268_4 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_10 + var_268_4
					end

					if var_268_6.prefab_name ~= "" and arg_265_1.actors_[var_268_6.prefab_name] ~= nil then
						local var_268_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_6.prefab_name].transform, "story_v_out_319751", "319751064", "story_v_out_319751.awb")

						arg_265_1:RecordAudio("319751064", var_268_11)
						arg_265_1:RecordAudio("319751064", var_268_11)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_319751", "319751064", "story_v_out_319751.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_319751", "319751064", "story_v_out_319751.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_12 = math.max(var_268_5, arg_265_1.talkMaxDuration)

			if var_268_4 <= arg_265_1.time_ and arg_265_1.time_ < var_268_4 + var_268_12 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_4) / var_268_12

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_4 + var_268_12 and arg_265_1.time_ < var_268_4 + var_268_12 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {
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

		arg_265_1:InitPlayNodeList()
	end,
	Play319751065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 319751065
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play319751066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 and not isNil(arg_269_1.actors_["1084ui_story"]) and arg_269_1.var_.characterEffect1084ui_story == nil then
				arg_269_1.var_.characterEffect1084ui_story = arg_269_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_272_0 = 0.200000002980232

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_0 and not isNil(arg_269_1.actors_["1084ui_story"]) then
				if arg_269_1.var_.characterEffect1084ui_story and not isNil(arg_269_1.actors_["1084ui_story"]) then
					arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_269_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_269_1.time_ - 0) / var_272_0)
				end
			end

			if arg_269_1.time_ >= 0 + var_272_0 and arg_269_1.time_ < 0 + var_272_0 + arg_272_0 and not isNil(arg_269_1.actors_["1084ui_story"]) and arg_269_1.var_.characterEffect1084ui_story then
				arg_269_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_269_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_272_1 = 0
			local var_272_2 = 0.4

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_1 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, true)
				arg_269_1.iconController_:SetSelectedState("hero")

				arg_269_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_269_1.callingController_:SetSelectedState("normal")

				arg_269_1.keyicon_.color = Color.New(1, 1, 1)
				arg_269_1.icon_.color = Color.New(1, 1, 1)

				local var_272_3 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(319751065).content)

				arg_269_1.text_.text = var_272_3

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_5 = 16 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 16)

				if (16 <= 0 and var_272_2 or var_272_2 * (utf8.len(var_272_3) / 16)) > 0 and var_272_2 < var_272_5 then
					arg_269_1.talkMaxDuration = var_272_5

					if var_272_5 + var_272_1 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + var_272_1
					end
				end

				arg_269_1.text_.text = var_272_3
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_6 = math.max(var_272_2, arg_269_1.talkMaxDuration)

			if var_272_1 <= arg_269_1.time_ and arg_269_1.time_ < var_272_1 + var_272_6 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_1) / var_272_6

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_1 + var_272_6 and arg_269_1.time_ < var_272_1 + var_272_6 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play319751066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 319751066
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play319751067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.var_.moveOldPos1084ui_story = arg_273_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_276_0 = 0.001

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 then
				arg_273_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_273_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_273_1.time_ - 0) / var_276_0)
				arg_273_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1084ui_story"].transform.position).z)
				arg_273_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1084ui_story"].transform.localEulerAngles = arg_273_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 then
				arg_273_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_273_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_273_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_273_1.actors_["1084ui_story"].transform.position).z)
				arg_273_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_273_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_273_1.actors_["1084ui_story"].transform.localEulerAngles = arg_273_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_276_1 = 0
			local var_276_2 = 1.425

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_1 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, false)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_3 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(319751066).content)

				arg_273_1.text_.text = var_276_3

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_5 = 57 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 57)

				if (57 <= 0 and var_276_2 or var_276_2 * (utf8.len(var_276_3) / 57)) > 0 and var_276_2 < var_276_5 then
					arg_273_1.talkMaxDuration = var_276_5

					if var_276_5 + var_276_1 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + var_276_1
					end
				end

				arg_273_1.text_.text = var_276_3
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_6 = math.max(var_276_2, arg_273_1.talkMaxDuration)

			if var_276_1 <= arg_273_1.time_ and arg_273_1.time_ < var_276_1 + var_276_6 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_1) / var_276_6

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_1 + var_276_6 and arg_273_1.time_ < var_276_1 + var_276_6 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {
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

		arg_273_1:InitPlayNodeList()
	end,
	Play319751067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 319751067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play319751068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 1.125

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, true)
				arg_277_1.iconController_:SetSelectedState("hero")

				arg_277_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_277_1.callingController_:SetSelectedState("normal")

				arg_277_1.keyicon_.color = Color.New(1, 1, 1)
				arg_277_1.icon_.color = Color.New(1, 1, 1)

				local var_280_1 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(319751067).content)

				arg_277_1.text_.text = var_280_1

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_3 = 45 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 45)

				if (45 <= 0 and var_280_0 or var_280_0 * (utf8.len(var_280_1) / 45)) > 0 and var_280_0 < var_280_3 then
					arg_277_1.talkMaxDuration = var_280_3

					if var_280_3 + 0 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_3 + 0
					end
				end

				arg_277_1.text_.text = var_280_1
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_4 = math.max(var_280_0, arg_277_1.talkMaxDuration)

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_4 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - 0) / var_280_4

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= 0 + var_280_4 and arg_277_1.time_ < 0 + var_280_4 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play319751068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 319751068
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play319751069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.5

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(319751068).content)

				arg_281_1.text_.text = var_284_1

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_3 = 20 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 20)

				if (20 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_1) / 20)) > 0 and var_284_0 < var_284_3 then
					arg_281_1.talkMaxDuration = var_284_3

					if var_284_3 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_3 + 0
					end
				end

				arg_281_1.text_.text = var_284_1
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_4 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_4 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_4

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_4 and arg_281_1.time_ < 0 + var_284_4 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play319751069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 319751069
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play319751070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 1.1

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(319751069).content)

				arg_285_1.text_.text = var_288_1

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_3 = 44 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 44)

				if (44 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_1) / 44)) > 0 and var_288_0 < var_288_3 then
					arg_285_1.talkMaxDuration = var_288_3

					if var_288_3 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_3 + 0
					end
				end

				arg_285_1.text_.text = var_288_1
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_4 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_4 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_4

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_4 and arg_285_1.time_ < 0 + var_288_4 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play319751070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 319751070
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play319751071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.825

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_289_1.callingController_:SetSelectedState("normal")

				arg_289_1.keyicon_.color = Color.New(1, 1, 1)
				arg_289_1.icon_.color = Color.New(1, 1, 1)

				local var_292_1 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(319751070).content)

				arg_289_1.text_.text = var_292_1

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_3 = 33 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 33)

				if (33 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_1) / 33)) > 0 and var_292_0 < var_292_3 then
					arg_289_1.talkMaxDuration = var_292_3

					if var_292_3 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_3 + 0
					end
				end

				arg_289_1.text_.text = var_292_1
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_4 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_4 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_4

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_4 and arg_289_1.time_ < 0 + var_292_4 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play319751071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 319751071
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play319751072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.625

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_1 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(319751071).content)

				arg_293_1.text_.text = var_296_1

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_3 = 25 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 25)

				if (25 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_1) / 25)) > 0 and var_296_0 < var_296_3 then
					arg_293_1.talkMaxDuration = var_296_3

					if var_296_3 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_3 + 0
					end
				end

				arg_293_1.text_.text = var_296_1
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_4 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_4 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_4

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_4 and arg_293_1.time_ < 0 + var_296_4 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play319751072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 319751072
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
			arg_297_1.auto_ = false
		end

		function arg_297_1.playNext_(arg_299_0)
			arg_297_1.onStoryFinished_()
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_0 = 0.125

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[698].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, true)
				arg_297_1.iconController_:SetSelectedState("hero")

				arg_297_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10073")

				arg_297_1.callingController_:SetSelectedState("normal")

				arg_297_1.keyicon_.color = Color.New(1, 1, 1)
				arg_297_1.icon_.color = Color.New(1, 1, 1)

				local var_300_1 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(319751072).content)

				arg_297_1.text_.text = var_300_1

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_3 = 5 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 5)

				if (5 <= 0 and var_300_0 or var_300_0 * (utf8.len(var_300_1) / 5)) > 0 and var_300_0 < var_300_3 then
					arg_297_1.talkMaxDuration = var_300_3

					if var_300_3 + 0 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_3 + 0
					end
				end

				arg_297_1.text_.text = var_300_1
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_4 = math.max(var_300_0, arg_297_1.talkMaxDuration)

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_4 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - 0) / var_300_4

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= 0 + var_300_4 and arg_297_1.time_ < 0 + var_300_4 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST71",
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319751.awb"
	}
}
