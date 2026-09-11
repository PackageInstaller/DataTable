return {
	Play319501001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319501001
		arg_1_1.duration_ = 10.3

		local var_1_0 = {
			zh = 9.233,
			ja = 10.3
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
				arg_1_0:Play319501002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST72 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST72")
				var_4_0.name = "ST72"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST72 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST72

				arg_1_1.bgs_.ST72.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST72" then
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

			local var_4_8 = "10069ui_story"

			if arg_1_1.actors_["10069ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10069ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "10069ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["10069ui_story"].transform

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10069ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -1.08, -6.33)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["10069ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10069ui_story == nil then
				arg_1_1.var_.characterEffect10069ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10069ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10069ui_story then
				arg_1_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_hospital", "bgm_activity_3_0_story_hospital")

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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_23 = 1.8
			local var_4_24 = 1.05

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_25 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_25:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(319501001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 41 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 41)

				if (41 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 41)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501001", "story_v_out_319501.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_319501", "319501001", "story_v_out_319501.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_319501", "319501001", "story_v_out_319501.awb")

						arg_1_1:RecordAudio("319501001", var_4_31)
						arg_1_1:RecordAudio("319501001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319501", "319501001", "story_v_out_319501.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319501", "319501001", "story_v_out_319501.awb")
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319501002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319501002
		arg_9_1.duration_ = 5.5

		local var_9_0 = {
			zh = 4.266,
			ja = 5.5
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
				arg_9_0:Play319501003(arg_9_1)
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
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_12_8 = arg_9_1.actors_["10069ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10069ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10069ui_story, Vector3.New(-0.7, -1.08, -6.33), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(-0.7, -1.08, -6.33)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10069ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10069ui_story == nil then
				arg_9_1.var_.characterEffect10069ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10069ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10069ui_story then
				arg_9_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.45

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

				local var_12_14 = arg_9_1:GetWordFromCfg(319501002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 18 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 18)

				if (18 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 18)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501002", "story_v_out_319501.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501002", "story_v_out_319501.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_319501", "319501002", "story_v_out_319501.awb")

						arg_9_1:RecordAudio("319501002", var_12_19)
						arg_9_1:RecordAudio("319501002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319501", "319501002", "story_v_out_319501.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319501", "319501002", "story_v_out_319501.awb")
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
				actorName = "10069ui_story",
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
	Play319501003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319501003
		arg_13_1.duration_ = 3.7

		local var_13_0 = {
			zh = 1.466,
			ja = 3.7
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
				arg_13_0:Play319501004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(319501003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 5)

				if (5 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 5)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501003", "story_v_out_319501.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501003", "story_v_out_319501.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_319501", "319501003", "story_v_out_319501.awb")

						arg_13_1:RecordAudio("319501003", var_16_6)
						arg_13_1:RecordAudio("319501003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319501", "319501003", "story_v_out_319501.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319501", "319501003", "story_v_out_319501.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_7 = math.max(var_16_0, arg_13_1.talkMaxDuration)

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_7 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - 0) / var_16_7

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= 0 + var_16_7 and arg_13_1.time_ < 0 + var_16_7 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play319501004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319501004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319501005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story == nil then
				arg_17_1.var_.characterEffect1084ui_story = arg_17_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) then
				if arg_17_1.var_.characterEffect1084ui_story and not isNil(arg_17_1.actors_["1084ui_story"]) then
					arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1084ui_story"]) and arg_17_1.var_.characterEffect1084ui_story then
				arg_17_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 0.9

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_1 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(319501004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 36 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 36)

				if (36 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 36)) > 0 and var_20_2 < var_20_5 then
					arg_17_1.talkMaxDuration = var_20_5

					if var_20_5 + var_20_1 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_5 + var_20_1
					end
				end

				arg_17_1.text_.text = var_20_3
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_6 = math.max(var_20_2, arg_17_1.talkMaxDuration)

			if var_20_1 <= arg_17_1.time_ and arg_17_1.time_ < var_20_1 + var_20_6 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_1) / var_20_6

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_1 + var_20_6 and arg_17_1.time_ < var_20_1 + var_20_6 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {}

		arg_17_1:InitPlayNodeList()
	end,
	Play319501005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319501005
		arg_21_1.duration_ = 10.6

		local var_21_0 = {
			zh = 3.533,
			ja = 10.6
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
				arg_21_0:Play319501006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10069ui_story"]) and arg_21_1.var_.characterEffect10069ui_story == nil then
				arg_21_1.var_.characterEffect10069ui_story = arg_21_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10069ui_story"]) then
				if arg_21_1.var_.characterEffect10069ui_story and not isNil(arg_21_1.actors_["10069ui_story"]) then
					arg_21_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10069ui_story"]) and arg_21_1.var_.characterEffect10069ui_story then
				arg_21_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_24_2 = 0
			local var_24_3 = 0.425

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:GetWordFromCfg(319501005)
				local var_24_5 = arg_21_1:FormatText(var_24_4.content)

				arg_21_1.text_.text = var_24_5

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_7 = 17 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 17)

				if (17 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_5) / 17)) > 0 and var_24_3 < var_24_7 then
					arg_21_1.talkMaxDuration = var_24_7

					if var_24_7 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_7 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_5
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501005", "story_v_out_319501.awb") ~= 0 then
					local var_24_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501005", "story_v_out_319501.awb") / 1000

					if var_24_8 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_2
					end

					if var_24_4.prefab_name ~= "" and arg_21_1.actors_[var_24_4.prefab_name] ~= nil then
						local var_24_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_4.prefab_name].transform, "story_v_out_319501", "319501005", "story_v_out_319501.awb")

						arg_21_1:RecordAudio("319501005", var_24_9)
						arg_21_1:RecordAudio("319501005", var_24_9)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319501", "319501005", "story_v_out_319501.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319501", "319501005", "story_v_out_319501.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_10 and arg_21_1.time_ < var_24_2 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319501006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319501006
		arg_25_1.duration_ = 2.4

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 2.4
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play319501007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story == nil then
				arg_25_1.var_.characterEffect1084ui_story = arg_25_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) then
				if arg_25_1.var_.characterEffect1084ui_story and not isNil(arg_25_1.actors_["1084ui_story"]) then
					arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["1084ui_story"]) and arg_25_1.var_.characterEffect1084ui_story then
				arg_25_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_28_2 = arg_25_1.actors_["10069ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10069ui_story == nil then
				arg_25_1.var_.characterEffect10069ui_story = var_28_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_3 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_3 and not isNil(var_28_2) then
				if arg_25_1.var_.characterEffect10069ui_story and not isNil(var_28_2) then
					arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_3)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_3 and arg_25_1.time_ < 0 + var_28_3 + arg_28_0 and not isNil(var_28_2) and arg_25_1.var_.characterEffect10069ui_story then
				arg_25_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_28_4 = 0
			local var_28_5 = 0.1

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(319501006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 4 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 4)

				if (4 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 4)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501006", "story_v_out_319501.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501006", "story_v_out_319501.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_319501", "319501006", "story_v_out_319501.awb")

						arg_25_1:RecordAudio("319501006", var_28_11)
						arg_25_1:RecordAudio("319501006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319501", "319501006", "story_v_out_319501.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319501", "319501006", "story_v_out_319501.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_12 = math.max(var_28_5, arg_25_1.talkMaxDuration)

			if var_28_4 <= arg_25_1.time_ and arg_25_1.time_ < var_28_4 + var_28_12 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_4) / var_28_12

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_4 + var_28_12 and arg_25_1.time_ < var_28_4 + var_28_12 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319501007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319501007
		arg_29_1.duration_ = 2

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319501008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story == nil then
				arg_29_1.var_.characterEffect1084ui_story = arg_29_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) then
				if arg_29_1.var_.characterEffect1084ui_story and not isNil(arg_29_1.actors_["1084ui_story"]) then
					arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_29_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_0)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1084ui_story"]) and arg_29_1.var_.characterEffect1084ui_story then
				arg_29_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_29_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			local var_32_1 = arg_29_1.actors_["10069ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10069ui_story == nil then
				arg_29_1.var_.characterEffect10069ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect10069ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect10069ui_story then
				arg_29_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.175

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(319501007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 7 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 7)

				if (7 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 7)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501007", "story_v_out_319501.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501007", "story_v_out_319501.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_319501", "319501007", "story_v_out_319501.awb")

						arg_29_1:RecordAudio("319501007", var_32_11)
						arg_29_1:RecordAudio("319501007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319501", "319501007", "story_v_out_319501.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319501", "319501007", "story_v_out_319501.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_12 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_12 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_12

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_12 and arg_29_1.time_ < var_32_4 + var_32_12 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play319501008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319501008
		arg_33_1.duration_ = 4.4

		local var_33_0 = {
			zh = 3.3,
			ja = 4.4
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
				arg_33_0:Play319501009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["1084ui_story"]) and arg_33_1.var_.characterEffect1084ui_story == nil then
				arg_33_1.var_.characterEffect1084ui_story = arg_33_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["1084ui_story"]) then
				if arg_33_1.var_.characterEffect1084ui_story and not isNil(arg_33_1.actors_["1084ui_story"]) then
					arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["1084ui_story"]) and arg_33_1.var_.characterEffect1084ui_story then
				arg_33_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_36_2 = arg_33_1.actors_["10069ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect10069ui_story == nil then
				arg_33_1.var_.characterEffect10069ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect10069ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_33_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect10069ui_story then
				arg_33_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_33_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_36_4 = 0
			local var_36_5 = 0.35

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:GetWordFromCfg(319501008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 14 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 14)

				if (14 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 14)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501008", "story_v_out_319501.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501008", "story_v_out_319501.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_319501", "319501008", "story_v_out_319501.awb")

						arg_33_1:RecordAudio("319501008", var_36_11)
						arg_33_1:RecordAudio("319501008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319501", "319501008", "story_v_out_319501.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319501", "319501008", "story_v_out_319501.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_12 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_12 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_12

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_12 and arg_33_1.time_ < var_36_4 + var_36_12 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319501009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319501009
		arg_37_1.duration_ = 5.5

		local var_37_0 = {
			zh = 5.5,
			ja = 3.7
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
				arg_37_0:Play319501010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_40_0 = 0
			local var_40_1 = 0.575

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_0 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_2 = arg_37_1:GetWordFromCfg(319501009)
				local var_40_3 = arg_37_1:FormatText(var_40_2.content)

				arg_37_1.text_.text = var_40_3

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_5 = 23 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 23)

				if (23 <= 0 and var_40_1 or var_40_1 * (utf8.len(var_40_3) / 23)) > 0 and var_40_1 < var_40_5 then
					arg_37_1.talkMaxDuration = var_40_5

					if var_40_5 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_5 + var_40_0
					end
				end

				arg_37_1.text_.text = var_40_3
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501009", "story_v_out_319501.awb") ~= 0 then
					local var_40_6 = manager.audio:GetVoiceLength("story_v_out_319501", "319501009", "story_v_out_319501.awb") / 1000

					if var_40_6 + var_40_0 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_6 + var_40_0
					end

					if var_40_2.prefab_name ~= "" and arg_37_1.actors_[var_40_2.prefab_name] ~= nil then
						local var_40_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_2.prefab_name].transform, "story_v_out_319501", "319501009", "story_v_out_319501.awb")

						arg_37_1:RecordAudio("319501009", var_40_7)
						arg_37_1:RecordAudio("319501009", var_40_7)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319501", "319501009", "story_v_out_319501.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319501", "319501009", "story_v_out_319501.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_8 = math.max(var_40_1, arg_37_1.talkMaxDuration)

			if var_40_0 <= arg_37_1.time_ and arg_37_1.time_ < var_40_0 + var_40_8 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_0) / var_40_8

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_0 + var_40_8 and arg_37_1.time_ < var_40_0 + var_40_8 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play319501010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319501010
		arg_41_1.duration_ = 9.03

		local var_41_0 = {
			zh = 9.033,
			ja = 6.466
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
				arg_41_0:Play319501011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["10069ui_story"]) and arg_41_1.var_.characterEffect10069ui_story == nil then
				arg_41_1.var_.characterEffect10069ui_story = arg_41_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["10069ui_story"]) then
				if arg_41_1.var_.characterEffect10069ui_story and not isNil(arg_41_1.actors_["10069ui_story"]) then
					arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["10069ui_story"]) and arg_41_1.var_.characterEffect10069ui_story then
				arg_41_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_2 = arg_41_1.actors_["1084ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1084ui_story == nil then
				arg_41_1.var_.characterEffect1084ui_story = var_44_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_3 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_3 and not isNil(var_44_2) then
				if arg_41_1.var_.characterEffect1084ui_story and not isNil(var_44_2) then
					arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_3)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_3 and arg_41_1.time_ < 0 + var_44_3 + arg_44_0 and not isNil(var_44_2) and arg_41_1.var_.characterEffect1084ui_story then
				arg_41_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_44_4 = 0
			local var_44_5 = 1.025

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_4 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_6 = arg_41_1:GetWordFromCfg(319501010)
				local var_44_7 = arg_41_1:FormatText(var_44_6.content)

				arg_41_1.text_.text = var_44_7

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_9 = 41 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 41)

				if (41 <= 0 and var_44_5 or var_44_5 * (utf8.len(var_44_7) / 41)) > 0 and var_44_5 < var_44_9 then
					arg_41_1.talkMaxDuration = var_44_9

					if var_44_9 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_9 + var_44_4
					end
				end

				arg_41_1.text_.text = var_44_7
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501010", "story_v_out_319501.awb") ~= 0 then
					local var_44_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501010", "story_v_out_319501.awb") / 1000

					if var_44_10 + var_44_4 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_10 + var_44_4
					end

					if var_44_6.prefab_name ~= "" and arg_41_1.actors_[var_44_6.prefab_name] ~= nil then
						local var_44_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_6.prefab_name].transform, "story_v_out_319501", "319501010", "story_v_out_319501.awb")

						arg_41_1:RecordAudio("319501010", var_44_11)
						arg_41_1:RecordAudio("319501010", var_44_11)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319501", "319501010", "story_v_out_319501.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319501", "319501010", "story_v_out_319501.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_12 = math.max(var_44_5, arg_41_1.talkMaxDuration)

			if var_44_4 <= arg_41_1.time_ and arg_41_1.time_ < var_44_4 + var_44_12 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_4) / var_44_12

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_4 + var_44_12 and arg_41_1.time_ < var_44_4 + var_44_12 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319501011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319501011
		arg_45_1.duration_ = 8.73

		local var_45_0 = {
			zh = 8.733,
			ja = 8.166
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
				arg_45_0:Play319501012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story == nil then
				arg_45_1.var_.characterEffect1084ui_story = arg_45_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) then
				if arg_45_1.var_.characterEffect1084ui_story and not isNil(arg_45_1.actors_["1084ui_story"]) then
					arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1084ui_story"]) and arg_45_1.var_.characterEffect1084ui_story then
				arg_45_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_48_2 = arg_45_1.actors_["10069ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect10069ui_story == nil then
				arg_45_1.var_.characterEffect10069ui_story = var_48_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_3 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 and not isNil(var_48_2) then
				if arg_45_1.var_.characterEffect10069ui_story and not isNil(var_48_2) then
					arg_45_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_3)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 and not isNil(var_48_2) and arg_45_1.var_.characterEffect10069ui_story then
				arg_45_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_48_4 = 0
			local var_48_5 = 0.925

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:GetWordFromCfg(319501011)
				local var_48_7 = arg_45_1:FormatText(var_48_6.content)

				arg_45_1.text_.text = var_48_7

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_9 = 37 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 37)

				if (37 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_7) / 37)) > 0 and var_48_5 < var_48_9 then
					arg_45_1.talkMaxDuration = var_48_9

					if var_48_9 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_9 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_7
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501011", "story_v_out_319501.awb") ~= 0 then
					local var_48_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501011", "story_v_out_319501.awb") / 1000

					if var_48_10 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_10 + var_48_4
					end

					if var_48_6.prefab_name ~= "" and arg_45_1.actors_[var_48_6.prefab_name] ~= nil then
						local var_48_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_6.prefab_name].transform, "story_v_out_319501", "319501011", "story_v_out_319501.awb")

						arg_45_1:RecordAudio("319501011", var_48_11)
						arg_45_1:RecordAudio("319501011", var_48_11)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319501", "319501011", "story_v_out_319501.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319501", "319501011", "story_v_out_319501.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_12 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_12 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_12

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_12 and arg_45_1.time_ < var_48_4 + var_48_12 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319501012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319501012
		arg_49_1.duration_ = 7.37

		local var_49_0 = {
			zh = 2.033,
			ja = 7.366
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
				arg_49_0:Play319501013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) and arg_49_1.var_.characterEffect1084ui_story == nil then
				arg_49_1.var_.characterEffect1084ui_story = arg_49_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_0 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) then
				if arg_49_1.var_.characterEffect1084ui_story and not isNil(arg_49_1.actors_["1084ui_story"]) then
					arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_0)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 and not isNil(arg_49_1.actors_["1084ui_story"]) and arg_49_1.var_.characterEffect1084ui_story then
				arg_49_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_52_1 = arg_49_1.actors_["10069ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10069ui_story == nil then
				arg_49_1.var_.characterEffect10069ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10069ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10069ui_story then
				arg_49_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_52_4 = 0
			local var_52_5 = 0.225

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_4 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_6 = arg_49_1:GetWordFromCfg(319501012)
				local var_52_7 = arg_49_1:FormatText(var_52_6.content)

				arg_49_1.text_.text = var_52_7

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_9 = 9 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 9)

				if (9 <= 0 and var_52_5 or var_52_5 * (utf8.len(var_52_7) / 9)) > 0 and var_52_5 < var_52_9 then
					arg_49_1.talkMaxDuration = var_52_9

					if var_52_9 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_9 + var_52_4
					end
				end

				arg_49_1.text_.text = var_52_7
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501012", "story_v_out_319501.awb") ~= 0 then
					local var_52_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501012", "story_v_out_319501.awb") / 1000

					if var_52_10 + var_52_4 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_10 + var_52_4
					end

					if var_52_6.prefab_name ~= "" and arg_49_1.actors_[var_52_6.prefab_name] ~= nil then
						local var_52_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_6.prefab_name].transform, "story_v_out_319501", "319501012", "story_v_out_319501.awb")

						arg_49_1:RecordAudio("319501012", var_52_11)
						arg_49_1:RecordAudio("319501012", var_52_11)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319501", "319501012", "story_v_out_319501.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319501", "319501012", "story_v_out_319501.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_12 = math.max(var_52_5, arg_49_1.talkMaxDuration)

			if var_52_4 <= arg_49_1.time_ and arg_49_1.time_ < var_52_4 + var_52_12 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_4) / var_52_12

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_4 + var_52_12 and arg_49_1.time_ < var_52_4 + var_52_12 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319501013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319501013
		arg_53_1.duration_ = 7.4

		local var_53_0 = {
			zh = 4.366,
			ja = 7.4
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
				arg_53_0:Play319501014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story == nil then
				arg_53_1.var_.characterEffect1084ui_story = arg_53_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_0 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) then
				if arg_53_1.var_.characterEffect1084ui_story and not isNil(arg_53_1.actors_["1084ui_story"]) then
					arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 0 + var_56_0 and arg_53_1.time_ < 0 + var_56_0 + arg_56_0 and not isNil(arg_53_1.actors_["1084ui_story"]) and arg_53_1.var_.characterEffect1084ui_story then
				arg_53_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_56_2 = arg_53_1.actors_["10069ui_story"]

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10069ui_story == nil then
				arg_53_1.var_.characterEffect10069ui_story = var_56_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_3 = 0.200000002980232

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_3 and not isNil(var_56_2) then
				if arg_53_1.var_.characterEffect10069ui_story and not isNil(var_56_2) then
					arg_53_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_53_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_53_1.time_ - 0) / var_56_3)
				end
			end

			if arg_53_1.time_ >= 0 + var_56_3 and arg_53_1.time_ < 0 + var_56_3 + arg_56_0 and not isNil(var_56_2) and arg_53_1.var_.characterEffect10069ui_story then
				arg_53_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_53_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_56_4 = 0
			local var_56_5 = 0.5

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_6 = arg_53_1:GetWordFromCfg(319501013)
				local var_56_7 = arg_53_1:FormatText(var_56_6.content)

				arg_53_1.text_.text = var_56_7

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_9 = 20 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 20)

				if (20 <= 0 and var_56_5 or var_56_5 * (utf8.len(var_56_7) / 20)) > 0 and var_56_5 < var_56_9 then
					arg_53_1.talkMaxDuration = var_56_9

					if var_56_9 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_9 + var_56_4
					end
				end

				arg_53_1.text_.text = var_56_7
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501013", "story_v_out_319501.awb") ~= 0 then
					local var_56_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501013", "story_v_out_319501.awb") / 1000

					if var_56_10 + var_56_4 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_10 + var_56_4
					end

					if var_56_6.prefab_name ~= "" and arg_53_1.actors_[var_56_6.prefab_name] ~= nil then
						local var_56_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_6.prefab_name].transform, "story_v_out_319501", "319501013", "story_v_out_319501.awb")

						arg_53_1:RecordAudio("319501013", var_56_11)
						arg_53_1:RecordAudio("319501013", var_56_11)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319501", "319501013", "story_v_out_319501.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319501", "319501013", "story_v_out_319501.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_12 = math.max(var_56_5, arg_53_1.talkMaxDuration)

			if var_56_4 <= arg_53_1.time_ and arg_53_1.time_ < var_56_4 + var_56_12 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_4) / var_56_12

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_4 + var_56_12 and arg_53_1.time_ < var_56_4 + var_56_12 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319501014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319501014
		arg_57_1.duration_ = 5.7

		local var_57_0 = {
			zh = 5.7,
			ja = 4.633
		}
		local var_57_1 = manager.audio:GetLocalizationFlag()

		if var_57_0[var_57_1] ~= nil then
			arg_57_1.duration_ = var_57_0[var_57_1]
		end

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play319501015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.65

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(319501014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 26 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 26)

				if (26 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 26)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501014", "story_v_out_319501.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501014", "story_v_out_319501.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_319501", "319501014", "story_v_out_319501.awb")

						arg_57_1:RecordAudio("319501014", var_60_6)
						arg_57_1:RecordAudio("319501014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319501", "319501014", "story_v_out_319501.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319501", "319501014", "story_v_out_319501.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_7 = math.max(var_60_0, arg_57_1.talkMaxDuration)

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_7 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - 0) / var_60_7

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= 0 + var_60_7 and arg_57_1.time_ < 0 + var_60_7 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play319501015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319501015
		arg_61_1.duration_ = 2

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319501016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10069ui_story"]) and arg_61_1.var_.characterEffect10069ui_story == nil then
				arg_61_1.var_.characterEffect10069ui_story = arg_61_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10069ui_story"]) then
				if arg_61_1.var_.characterEffect10069ui_story and not isNil(arg_61_1.actors_["10069ui_story"]) then
					arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10069ui_story"]) and arg_61_1.var_.characterEffect10069ui_story then
				arg_61_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_2 = arg_61_1.actors_["1084ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1084ui_story == nil then
				arg_61_1.var_.characterEffect1084ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect1084ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect1084ui_story then
				arg_61_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_64_4 = 0
			local var_64_5 = 0.15

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:GetWordFromCfg(319501015)
				local var_64_7 = arg_61_1:FormatText(var_64_6.content)

				arg_61_1.text_.text = var_64_7

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_9 = 6 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 6)

				if (6 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_7) / 6)) > 0 and var_64_5 < var_64_9 then
					arg_61_1.talkMaxDuration = var_64_9

					if var_64_9 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_9 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_7
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501015", "story_v_out_319501.awb") ~= 0 then
					local var_64_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501015", "story_v_out_319501.awb") / 1000

					if var_64_10 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_10 + var_64_4
					end

					if var_64_6.prefab_name ~= "" and arg_61_1.actors_[var_64_6.prefab_name] ~= nil then
						local var_64_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_6.prefab_name].transform, "story_v_out_319501", "319501015", "story_v_out_319501.awb")

						arg_61_1:RecordAudio("319501015", var_64_11)
						arg_61_1:RecordAudio("319501015", var_64_11)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319501", "319501015", "story_v_out_319501.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319501", "319501015", "story_v_out_319501.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_12 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_12 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_12

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_12 and arg_61_1.time_ < var_64_4 + var_64_12 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319501016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319501016
		arg_65_1.duration_ = 5.57

		local var_65_0 = {
			zh = 2.533,
			ja = 5.566
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
				arg_65_0:Play319501017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = arg_65_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(arg_65_1.actors_["1084ui_story"]) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_68_2 = arg_65_1.actors_["10069ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect10069ui_story == nil then
				arg_65_1.var_.characterEffect10069ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect10069ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect10069ui_story then
				arg_65_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_68_4 = 0
			local var_68_5 = 0.3

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:GetWordFromCfg(319501016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 12 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 12)

				if (12 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 12)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501016", "story_v_out_319501.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501016", "story_v_out_319501.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_319501", "319501016", "story_v_out_319501.awb")

						arg_65_1:RecordAudio("319501016", var_68_11)
						arg_65_1:RecordAudio("319501016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319501", "319501016", "story_v_out_319501.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319501", "319501016", "story_v_out_319501.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_12 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_12 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_12

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_12 and arg_65_1.time_ < var_68_4 + var_68_12 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play319501017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319501017
		arg_69_1.duration_ = 8.7

		local var_69_0 = {
			zh = 7.533,
			ja = 8.7
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
				arg_69_0:Play319501018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story == nil then
				arg_69_1.var_.characterEffect1084ui_story = arg_69_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) then
				if arg_69_1.var_.characterEffect1084ui_story and not isNil(arg_69_1.actors_["1084ui_story"]) then
					arg_69_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1084ui_story"]) and arg_69_1.var_.characterEffect1084ui_story then
				arg_69_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_72_1 = arg_69_1.actors_["10069ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10069ui_story == nil then
				arg_69_1.var_.characterEffect10069ui_story = var_72_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_2 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_2 and not isNil(var_72_1) then
				if arg_69_1.var_.characterEffect10069ui_story and not isNil(var_72_1) then
					arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_2 and arg_69_1.time_ < 0 + var_72_2 + arg_72_0 and not isNil(var_72_1) and arg_69_1.var_.characterEffect10069ui_story then
				arg_69_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_72_4 = 0
			local var_72_5 = 0.875

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:GetWordFromCfg(319501017)
				local var_72_7 = arg_69_1:FormatText(var_72_6.content)

				arg_69_1.text_.text = var_72_7

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_9 = 35 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 35)

				if (35 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_7) / 35)) > 0 and var_72_5 < var_72_9 then
					arg_69_1.talkMaxDuration = var_72_9

					if var_72_9 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_9 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_7
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501017", "story_v_out_319501.awb") ~= 0 then
					local var_72_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501017", "story_v_out_319501.awb") / 1000

					if var_72_10 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_10 + var_72_4
					end

					if var_72_6.prefab_name ~= "" and arg_69_1.actors_[var_72_6.prefab_name] ~= nil then
						local var_72_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_6.prefab_name].transform, "story_v_out_319501", "319501017", "story_v_out_319501.awb")

						arg_69_1:RecordAudio("319501017", var_72_11)
						arg_69_1:RecordAudio("319501017", var_72_11)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319501", "319501017", "story_v_out_319501.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319501", "319501017", "story_v_out_319501.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_12 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_12 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_12

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_12 and arg_69_1.time_ < var_72_4 + var_72_12 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319501018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319501018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319501019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["10069ui_story"]) and arg_73_1.var_.characterEffect10069ui_story == nil then
				arg_73_1.var_.characterEffect10069ui_story = arg_73_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["10069ui_story"]) then
				if arg_73_1.var_.characterEffect10069ui_story and not isNil(arg_73_1.actors_["10069ui_story"]) then
					arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_73_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["10069ui_story"]) and arg_73_1.var_.characterEffect10069ui_story then
				arg_73_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_73_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_76_1 = 0
			local var_76_2 = 1.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(319501018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 63 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 63)

				if (63 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 63)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319501019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319501019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319501020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 1.025

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, false)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_1 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(319501019).content)

				arg_77_1.text_.text = var_80_1

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_3 = 41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 41)

				if (41 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_1) / 41)) > 0 and var_80_0 < var_80_3 then
					arg_77_1.talkMaxDuration = var_80_3

					if var_80_3 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_3 + 0
					end
				end

				arg_77_1.text_.text = var_80_1
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_4 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_4 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_4

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_4 and arg_77_1.time_ < 0 + var_80_4 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319501020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319501020
		arg_81_1.duration_ = 6.67

		local var_81_0 = {
			zh = 3.766,
			ja = 6.666
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
				arg_81_0:Play319501021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story == nil then
				arg_81_1.var_.characterEffect1084ui_story = arg_81_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) then
				if arg_81_1.var_.characterEffect1084ui_story and not isNil(arg_81_1.actors_["1084ui_story"]) then
					arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["1084ui_story"]) and arg_81_1.var_.characterEffect1084ui_story then
				arg_81_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_84_2 = 0
			local var_84_3 = 0.375

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_2 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_4 = arg_81_1:GetWordFromCfg(319501020)
				local var_84_5 = arg_81_1:FormatText(var_84_4.content)

				arg_81_1.text_.text = var_84_5

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_7 = 15 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 15)

				if (15 <= 0 and var_84_3 or var_84_3 * (utf8.len(var_84_5) / 15)) > 0 and var_84_3 < var_84_7 then
					arg_81_1.talkMaxDuration = var_84_7

					if var_84_7 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_7 + var_84_2
					end
				end

				arg_81_1.text_.text = var_84_5
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501020", "story_v_out_319501.awb") ~= 0 then
					local var_84_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501020", "story_v_out_319501.awb") / 1000

					if var_84_8 + var_84_2 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_8 + var_84_2
					end

					if var_84_4.prefab_name ~= "" and arg_81_1.actors_[var_84_4.prefab_name] ~= nil then
						local var_84_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_4.prefab_name].transform, "story_v_out_319501", "319501020", "story_v_out_319501.awb")

						arg_81_1:RecordAudio("319501020", var_84_9)
						arg_81_1:RecordAudio("319501020", var_84_9)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319501", "319501020", "story_v_out_319501.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319501", "319501020", "story_v_out_319501.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_10 = math.max(var_84_3, arg_81_1.talkMaxDuration)

			if var_84_2 <= arg_81_1.time_ and arg_81_1.time_ < var_84_2 + var_84_10 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_2) / var_84_10

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_2 + var_84_10 and arg_81_1.time_ < var_84_2 + var_84_10 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play319501021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319501021
		arg_85_1.duration_ = 5.5

		local var_85_0 = {
			zh = 4.266,
			ja = 5.5
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
				arg_85_0:Play319501022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story == nil then
				arg_85_1.var_.characterEffect1084ui_story = arg_85_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) then
				if arg_85_1.var_.characterEffect1084ui_story and not isNil(arg_85_1.actors_["1084ui_story"]) then
					arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1084ui_story"]) and arg_85_1.var_.characterEffect1084ui_story then
				arg_85_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["10069ui_story"]

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10069ui_story == nil then
				arg_85_1.var_.characterEffect10069ui_story = var_88_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_2 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 and not isNil(var_88_1) then
				if arg_85_1.var_.characterEffect10069ui_story and not isNil(var_88_1) then
					arg_85_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 and not isNil(var_88_1) and arg_85_1.var_.characterEffect10069ui_story then
				arg_85_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_88_4 = 0
			local var_88_5 = 0.55

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_4 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_6 = arg_85_1:GetWordFromCfg(319501021)
				local var_88_7 = arg_85_1:FormatText(var_88_6.content)

				arg_85_1.text_.text = var_88_7

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_9 = 22 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 22)

				if (22 <= 0 and var_88_5 or var_88_5 * (utf8.len(var_88_7) / 22)) > 0 and var_88_5 < var_88_9 then
					arg_85_1.talkMaxDuration = var_88_9

					if var_88_9 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_9 + var_88_4
					end
				end

				arg_85_1.text_.text = var_88_7
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501021", "story_v_out_319501.awb") ~= 0 then
					local var_88_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501021", "story_v_out_319501.awb") / 1000

					if var_88_10 + var_88_4 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_10 + var_88_4
					end

					if var_88_6.prefab_name ~= "" and arg_85_1.actors_[var_88_6.prefab_name] ~= nil then
						local var_88_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_85_1.actors_[var_88_6.prefab_name].transform, "story_v_out_319501", "319501021", "story_v_out_319501.awb")

						arg_85_1:RecordAudio("319501021", var_88_11)
						arg_85_1:RecordAudio("319501021", var_88_11)
					else
						arg_85_1:AudioAction("play", "voice", "story_v_out_319501", "319501021", "story_v_out_319501.awb")
					end

					arg_85_1:RecordHistoryTalkVoice("story_v_out_319501", "319501021", "story_v_out_319501.awb")
				end

				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_12 = math.max(var_88_5, arg_85_1.talkMaxDuration)

			if var_88_4 <= arg_85_1.time_ and arg_85_1.time_ < var_88_4 + var_88_12 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_4) / var_88_12

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_4 + var_88_12 and arg_85_1.time_ < var_88_4 + var_88_12 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play319501022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319501022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319501023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["10069ui_story"]) and arg_89_1.var_.characterEffect10069ui_story == nil then
				arg_89_1.var_.characterEffect10069ui_story = arg_89_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["10069ui_story"]) then
				if arg_89_1.var_.characterEffect10069ui_story and not isNil(arg_89_1.actors_["10069ui_story"]) then
					arg_89_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_89_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["10069ui_story"]) and arg_89_1.var_.characterEffect10069ui_story then
				arg_89_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_89_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 0.6

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(319501022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 24 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 24)

				if (24 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 24)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319501023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319501023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319501024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 0.875

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(319501023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 35 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 35)

				if (35 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 35)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play319501024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319501024
		arg_97_1.duration_ = 5.53

		local var_97_0 = {
			zh = 1.999999999999,
			ja = 5.533
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play319501025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) and arg_97_1.var_.characterEffect1084ui_story == nil then
				arg_97_1.var_.characterEffect1084ui_story = arg_97_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) then
				if arg_97_1.var_.characterEffect1084ui_story and not isNil(arg_97_1.actors_["1084ui_story"]) then
					arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1084ui_story"]) and arg_97_1.var_.characterEffect1084ui_story then
				arg_97_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_100_2 = 0
			local var_100_3 = 0.275

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:GetWordFromCfg(319501024)
				local var_100_5 = arg_97_1:FormatText(var_100_4.content)

				arg_97_1.text_.text = var_100_5

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_7 = 11 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 11)

				if (11 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_5) / 11)) > 0 and var_100_3 < var_100_7 then
					arg_97_1.talkMaxDuration = var_100_7

					if var_100_7 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_5
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501024", "story_v_out_319501.awb") ~= 0 then
					local var_100_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501024", "story_v_out_319501.awb") / 1000

					if var_100_8 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_8 + var_100_2
					end

					if var_100_4.prefab_name ~= "" and arg_97_1.actors_[var_100_4.prefab_name] ~= nil then
						local var_100_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_4.prefab_name].transform, "story_v_out_319501", "319501024", "story_v_out_319501.awb")

						arg_97_1:RecordAudio("319501024", var_100_9)
						arg_97_1:RecordAudio("319501024", var_100_9)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319501", "319501024", "story_v_out_319501.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319501", "319501024", "story_v_out_319501.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_10 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_10 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_10

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_10 and arg_97_1.time_ < var_100_2 + var_100_10 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319501025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319501025
		arg_101_1.duration_ = 13

		local var_101_0 = {
			zh = 6.166,
			ja = 13
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play319501026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["10069ui_story"]) and arg_101_1.var_.characterEffect10069ui_story == nil then
				arg_101_1.var_.characterEffect10069ui_story = arg_101_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["10069ui_story"]) then
				if arg_101_1.var_.characterEffect10069ui_story and not isNil(arg_101_1.actors_["10069ui_story"]) then
					arg_101_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["10069ui_story"]) and arg_101_1.var_.characterEffect10069ui_story then
				arg_101_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_104_2 = arg_101_1.actors_["1084ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1084ui_story == nil then
				arg_101_1.var_.characterEffect1084ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect1084ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_101_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect1084ui_story then
				arg_101_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_101_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_104_4 = 0
			local var_104_5 = 0.675

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:GetWordFromCfg(319501025)
				local var_104_7 = arg_101_1:FormatText(var_104_6.content)

				arg_101_1.text_.text = var_104_7

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_9 = 27 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 27)

				if (27 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_7) / 27)) > 0 and var_104_5 < var_104_9 then
					arg_101_1.talkMaxDuration = var_104_9

					if var_104_9 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_9 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_7
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501025", "story_v_out_319501.awb") ~= 0 then
					local var_104_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501025", "story_v_out_319501.awb") / 1000

					if var_104_10 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_10 + var_104_4
					end

					if var_104_6.prefab_name ~= "" and arg_101_1.actors_[var_104_6.prefab_name] ~= nil then
						local var_104_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_6.prefab_name].transform, "story_v_out_319501", "319501025", "story_v_out_319501.awb")

						arg_101_1:RecordAudio("319501025", var_104_11)
						arg_101_1:RecordAudio("319501025", var_104_11)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319501", "319501025", "story_v_out_319501.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319501", "319501025", "story_v_out_319501.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_12 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_12 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_12

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_12 and arg_101_1.time_ < var_104_4 + var_104_12 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319501026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319501026
		arg_105_1.duration_ = 9.97

		local var_105_0 = {
			zh = 6.066,
			ja = 9.966
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play319501027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.825

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(319501026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 33 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 33)

				if (33 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 33)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501026", "story_v_out_319501.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501026", "story_v_out_319501.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_319501", "319501026", "story_v_out_319501.awb")

						arg_105_1:RecordAudio("319501026", var_108_6)
						arg_105_1:RecordAudio("319501026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319501", "319501026", "story_v_out_319501.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319501", "319501026", "story_v_out_319501.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_7 = math.max(var_108_0, arg_105_1.talkMaxDuration)

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_7 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - 0) / var_108_7

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= 0 + var_108_7 and arg_105_1.time_ < 0 + var_108_7 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play319501027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319501027
		arg_109_1.duration_ = 3.33

		local var_109_0 = {
			zh = 2.2,
			ja = 3.333
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play319501028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story == nil then
				arg_109_1.var_.characterEffect1084ui_story = arg_109_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) then
				if arg_109_1.var_.characterEffect1084ui_story and not isNil(arg_109_1.actors_["1084ui_story"]) then
					arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["1084ui_story"]) and arg_109_1.var_.characterEffect1084ui_story then
				arg_109_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_2")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_112_2 = arg_109_1.actors_["10069ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect10069ui_story == nil then
				arg_109_1.var_.characterEffect10069ui_story = var_112_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_3 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_3 and not isNil(var_112_2) then
				if arg_109_1.var_.characterEffect10069ui_story and not isNil(var_112_2) then
					arg_109_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_3)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_3 and arg_109_1.time_ < 0 + var_112_3 + arg_112_0 and not isNil(var_112_2) and arg_109_1.var_.characterEffect10069ui_story then
				arg_109_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_112_4 = 0
			local var_112_5 = 0.25

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_4 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_6 = arg_109_1:GetWordFromCfg(319501027)
				local var_112_7 = arg_109_1:FormatText(var_112_6.content)

				arg_109_1.text_.text = var_112_7

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_9 = 10 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 10)

				if (10 <= 0 and var_112_5 or var_112_5 * (utf8.len(var_112_7) / 10)) > 0 and var_112_5 < var_112_9 then
					arg_109_1.talkMaxDuration = var_112_9

					if var_112_9 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_9 + var_112_4
					end
				end

				arg_109_1.text_.text = var_112_7
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501027", "story_v_out_319501.awb") ~= 0 then
					local var_112_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501027", "story_v_out_319501.awb") / 1000

					if var_112_10 + var_112_4 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_10 + var_112_4
					end

					if var_112_6.prefab_name ~= "" and arg_109_1.actors_[var_112_6.prefab_name] ~= nil then
						local var_112_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_6.prefab_name].transform, "story_v_out_319501", "319501027", "story_v_out_319501.awb")

						arg_109_1:RecordAudio("319501027", var_112_11)
						arg_109_1:RecordAudio("319501027", var_112_11)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_319501", "319501027", "story_v_out_319501.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_319501", "319501027", "story_v_out_319501.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_12 = math.max(var_112_5, arg_109_1.talkMaxDuration)

			if var_112_4 <= arg_109_1.time_ and arg_109_1.time_ < var_112_4 + var_112_12 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_4) / var_112_12

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_4 + var_112_12 and arg_109_1.time_ < var_112_4 + var_112_12 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319501028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319501028
		arg_113_1.duration_ = 6.5

		local var_113_0 = {
			zh = 2.833,
			ja = 6.5
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play319501029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) and arg_113_1.var_.characterEffect1084ui_story == nil then
				arg_113_1.var_.characterEffect1084ui_story = arg_113_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) then
				if arg_113_1.var_.characterEffect1084ui_story and not isNil(arg_113_1.actors_["1084ui_story"]) then
					arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_0)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1084ui_story"]) and arg_113_1.var_.characterEffect1084ui_story then
				arg_113_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_116_1 = arg_113_1.actors_["10069ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10069ui_story == nil then
				arg_113_1.var_.characterEffect10069ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10069ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10069ui_story then
				arg_113_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_116_4 = 0
			local var_116_5 = 0.3

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:GetWordFromCfg(319501028)
				local var_116_7 = arg_113_1:FormatText(var_116_6.content)

				arg_113_1.text_.text = var_116_7

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_9 = 12 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 12)

				if (12 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_7) / 12)) > 0 and var_116_5 < var_116_9 then
					arg_113_1.talkMaxDuration = var_116_9

					if var_116_9 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_9 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_7
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501028", "story_v_out_319501.awb") ~= 0 then
					local var_116_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501028", "story_v_out_319501.awb") / 1000

					if var_116_10 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_10 + var_116_4
					end

					if var_116_6.prefab_name ~= "" and arg_113_1.actors_[var_116_6.prefab_name] ~= nil then
						local var_116_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_6.prefab_name].transform, "story_v_out_319501", "319501028", "story_v_out_319501.awb")

						arg_113_1:RecordAudio("319501028", var_116_11)
						arg_113_1:RecordAudio("319501028", var_116_11)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319501", "319501028", "story_v_out_319501.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319501", "319501028", "story_v_out_319501.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_12 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_12 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_12

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_12 and arg_113_1.time_ < var_116_4 + var_116_12 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319501029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319501029
		arg_117_1.duration_ = 11.97

		local var_117_0 = {
			zh = 6.8,
			ja = 11.966
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play319501030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			local var_120_0 = 0.825

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_1 = arg_117_1:GetWordFromCfg(319501029)
				local var_120_2 = arg_117_1:FormatText(var_120_1.content)

				arg_117_1.text_.text = var_120_2

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_4 = 33 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 33)

				if (33 <= 0 and var_120_0 or var_120_0 * (utf8.len(var_120_2) / 33)) > 0 and var_120_0 < var_120_4 then
					arg_117_1.talkMaxDuration = var_120_4

					if var_120_4 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_4 + 0
					end
				end

				arg_117_1.text_.text = var_120_2
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501029", "story_v_out_319501.awb") ~= 0 then
					local var_120_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501029", "story_v_out_319501.awb") / 1000

					if var_120_5 + 0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + 0
					end

					if var_120_1.prefab_name ~= "" and arg_117_1.actors_[var_120_1.prefab_name] ~= nil then
						local var_120_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_1.prefab_name].transform, "story_v_out_319501", "319501029", "story_v_out_319501.awb")

						arg_117_1:RecordAudio("319501029", var_120_6)
						arg_117_1:RecordAudio("319501029", var_120_6)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319501", "319501029", "story_v_out_319501.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319501", "319501029", "story_v_out_319501.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_7 = math.max(var_120_0, arg_117_1.talkMaxDuration)

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_7 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - 0) / var_120_7

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= 0 + var_120_7 and arg_117_1.time_ < 0 + var_120_7 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319501030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319501030
		arg_121_1.duration_ = 7.47

		local var_121_0 = {
			zh = 1.999999999999,
			ja = 7.466
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play319501031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1084ui_story"]) and arg_121_1.var_.characterEffect1084ui_story == nil then
				arg_121_1.var_.characterEffect1084ui_story = arg_121_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1084ui_story"]) then
				if arg_121_1.var_.characterEffect1084ui_story and not isNil(arg_121_1.actors_["1084ui_story"]) then
					arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1084ui_story"]) and arg_121_1.var_.characterEffect1084ui_story then
				arg_121_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_124_2 = arg_121_1.actors_["10069ui_story"]

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect10069ui_story == nil then
				arg_121_1.var_.characterEffect10069ui_story = var_124_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_3 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_3 and not isNil(var_124_2) then
				if arg_121_1.var_.characterEffect10069ui_story and not isNil(var_124_2) then
					arg_121_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 0) / var_124_3)
				end
			end

			if arg_121_1.time_ >= 0 + var_124_3 and arg_121_1.time_ < 0 + var_124_3 + arg_124_0 and not isNil(var_124_2) and arg_121_1.var_.characterEffect10069ui_story then
				arg_121_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_124_4 = 0
			local var_124_5 = 0.125

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_6 = arg_121_1:GetWordFromCfg(319501030)
				local var_124_7 = arg_121_1:FormatText(var_124_6.content)

				arg_121_1.text_.text = var_124_7

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_9 = 5 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 5)

				if (5 <= 0 and var_124_5 or var_124_5 * (utf8.len(var_124_7) / 5)) > 0 and var_124_5 < var_124_9 then
					arg_121_1.talkMaxDuration = var_124_9

					if var_124_9 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_9 + var_124_4
					end
				end

				arg_121_1.text_.text = var_124_7
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501030", "story_v_out_319501.awb") ~= 0 then
					local var_124_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501030", "story_v_out_319501.awb") / 1000

					if var_124_10 + var_124_4 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_10 + var_124_4
					end

					if var_124_6.prefab_name ~= "" and arg_121_1.actors_[var_124_6.prefab_name] ~= nil then
						local var_124_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_6.prefab_name].transform, "story_v_out_319501", "319501030", "story_v_out_319501.awb")

						arg_121_1:RecordAudio("319501030", var_124_11)
						arg_121_1:RecordAudio("319501030", var_124_11)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319501", "319501030", "story_v_out_319501.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319501", "319501030", "story_v_out_319501.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_12 = math.max(var_124_5, arg_121_1.talkMaxDuration)

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_12 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_4) / var_124_12

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_4 + var_124_12 and arg_121_1.time_ < var_124_4 + var_124_12 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play319501031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 319501031
		arg_125_1.duration_ = 5

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play319501032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story == nil then
				arg_125_1.var_.characterEffect1084ui_story = arg_125_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_0 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) then
				if arg_125_1.var_.characterEffect1084ui_story and not isNil(arg_125_1.actors_["1084ui_story"]) then
					arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_0)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 and not isNil(arg_125_1.actors_["1084ui_story"]) and arg_125_1.var_.characterEffect1084ui_story then
				arg_125_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_128_1 = 0
			local var_128_2 = 0.925

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_1 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_3 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(319501031).content)

				arg_125_1.text_.text = var_128_3

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_5 = 37 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 37)

				if (37 <= 0 and var_128_2 or var_128_2 * (utf8.len(var_128_3) / 37)) > 0 and var_128_2 < var_128_5 then
					arg_125_1.talkMaxDuration = var_128_5

					if var_128_5 + var_128_1 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_5 + var_128_1
					end
				end

				arg_125_1.text_.text = var_128_3
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_6 = math.max(var_128_2, arg_125_1.talkMaxDuration)

			if var_128_1 <= arg_125_1.time_ and arg_125_1.time_ < var_128_1 + var_128_6 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_1) / var_128_6

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_1 + var_128_6 and arg_125_1.time_ < var_128_1 + var_128_6 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {}

		arg_125_1:InitPlayNodeList()
	end,
	Play319501032 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 319501032
		arg_129_1.duration_ = 4.72

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play319501033(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if arg_129_1.bgs_.STblack == nil then
				local var_132_0 = Object.Instantiate(arg_129_1.paintGo_)

				var_132_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_132_0.name = "STblack"
				var_132_0.transform.parent = arg_129_1.stage_.transform
				var_132_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_129_1.bgs_.STblack = var_132_0
			end

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= 2 + arg_132_0 then
				local var_132_1 = arg_129_1.bgs_.STblack

				arg_129_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_132_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_132_2 = var_132_1:GetComponent("SpriteRenderer")

				if var_132_2 and var_132_2.sprite then
					local var_132_3 = 2 * (var_132_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_132_1.transform.localScale = Vector3.New(var_132_3 / var_132_2.sprite.bounds.size.y < var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x and var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x or var_132_3 / var_132_2.sprite.bounds.size.y, var_132_3 / var_132_2.sprite.bounds.size.y < var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x and var_132_3 * manager.ui.mainCameraCom_.aspect / var_132_2.sprite.bounds.size.x or var_132_3 / var_132_2.sprite.bounds.size.y, 0)
				end

				for iter_132_0, iter_132_1 in pairs(arg_129_1.bgs_) do
					if iter_132_0 ~= "STblack" then
						iter_132_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_132_4 = 0

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_4 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_5 = 2

			if var_132_4 <= arg_129_1.time_ and arg_129_1.time_ < var_132_4 + var_132_5 then
				local var_132_6 = Color.New(0, 0, 0)

				var_132_6.a = Mathf.Lerp(0, 1, (arg_129_1.time_ - var_132_4) / var_132_5)
				arg_129_1.mask_.color = var_132_6
			end

			if arg_129_1.time_ >= var_132_4 + var_132_5 and arg_129_1.time_ < var_132_4 + var_132_5 + arg_132_0 then
				local var_132_7 = Color.New(0, 0, 0)

				var_132_7.a = 1
				arg_129_1.mask_.color = var_132_7
			end

			local var_132_8 = 2

			if 2 < arg_129_1.time_ and arg_129_1.time_ <= var_132_8 + arg_132_0 then
				arg_129_1.mask_.enabled = true
				arg_129_1.mask_.raycastTarget = true

				arg_129_1:SetGaussion(false)
			end

			local var_132_9 = 2

			if var_132_8 <= arg_129_1.time_ and arg_129_1.time_ < var_132_8 + var_132_9 then
				local var_132_10 = Color.New(0, 0, 0)

				var_132_10.a = Mathf.Lerp(1, 0, (arg_129_1.time_ - var_132_8) / var_132_9)
				arg_129_1.mask_.color = var_132_10
			end

			if arg_129_1.time_ >= var_132_8 + var_132_9 and arg_129_1.time_ < var_132_8 + var_132_9 + arg_132_0 then
				local var_132_11 = Color.New(0, 0, 0)

				arg_129_1.mask_.enabled = false
				var_132_11.a = 0
				arg_129_1.mask_.color = var_132_11
			end

			local var_132_12 = arg_129_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_129_1.time_ and arg_129_1.time_ <= 1.96599999815226 + arg_132_0 then
				arg_129_1.var_.moveOldPos1084ui_story = var_132_12.localPosition
			end

			local var_132_13 = 0.001

			if 1.96599999815226 <= arg_129_1.time_ and arg_129_1.time_ < 1.96599999815226 + var_132_13 then
				var_132_12.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 1.96599999815226) / var_132_13)
				var_132_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_12.position).x, (manager.ui.mainCamera.transform.position - var_132_12.position).y, (manager.ui.mainCamera.transform.position - var_132_12.position).z)
				var_132_12.localEulerAngles.z = 0
				var_132_12.localEulerAngles.x = 0
				var_132_12.localEulerAngles = var_132_12.localEulerAngles
			end

			if arg_129_1.time_ >= 1.96599999815226 + var_132_13 and arg_129_1.time_ < 1.96599999815226 + var_132_13 + arg_132_0 then
				var_132_12.localPosition = Vector3.New(0, 100, 0)
				var_132_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_12.position).x, (manager.ui.mainCamera.transform.position - var_132_12.position).y, (manager.ui.mainCamera.transform.position - var_132_12.position).z)
				var_132_12.localEulerAngles.z = 0
				var_132_12.localEulerAngles.x = 0
				var_132_12.localEulerAngles = var_132_12.localEulerAngles
			end

			local var_132_14 = arg_129_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_129_1.time_ and arg_129_1.time_ <= 1.96599999815226 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.characterEffect1084ui_story == nil then
				arg_129_1.var_.characterEffect1084ui_story = var_132_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_15 = 0.034000001847744

			if 1.96599999815226 <= arg_129_1.time_ and arg_129_1.time_ < 1.96599999815226 + var_132_15 and not isNil(var_132_14) then
				if arg_129_1.var_.characterEffect1084ui_story and not isNil(var_132_14) then
					arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_129_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 1.96599999815226) / var_132_15)
				end
			end

			if arg_129_1.time_ >= 1.96599999815226 + var_132_15 and arg_129_1.time_ < 1.96599999815226 + var_132_15 + arg_132_0 and not isNil(var_132_14) and arg_129_1.var_.characterEffect1084ui_story then
				arg_129_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_129_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_132_16 = arg_129_1.actors_["10069ui_story"].transform

			if 1.96599999815226 < arg_129_1.time_ and arg_129_1.time_ <= 1.96599999815226 + arg_132_0 then
				arg_129_1.var_.moveOldPos10069ui_story = var_132_16.localPosition
			end

			local var_132_17 = 0.001

			if 1.96599999815226 <= arg_129_1.time_ and arg_129_1.time_ < 1.96599999815226 + var_132_17 then
				var_132_16.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_129_1.time_ - 1.96599999815226) / var_132_17)
				var_132_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_16.position).x, (manager.ui.mainCamera.transform.position - var_132_16.position).y, (manager.ui.mainCamera.transform.position - var_132_16.position).z)
				var_132_16.localEulerAngles.z = 0
				var_132_16.localEulerAngles.x = 0
				var_132_16.localEulerAngles = var_132_16.localEulerAngles
			end

			if arg_129_1.time_ >= 1.96599999815226 + var_132_17 and arg_129_1.time_ < 1.96599999815226 + var_132_17 + arg_132_0 then
				var_132_16.localPosition = Vector3.New(0, 100, 0)
				var_132_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_132_16.position).x, (manager.ui.mainCamera.transform.position - var_132_16.position).y, (manager.ui.mainCamera.transform.position - var_132_16.position).z)
				var_132_16.localEulerAngles.z = 0
				var_132_16.localEulerAngles.x = 0
				var_132_16.localEulerAngles = var_132_16.localEulerAngles
			end

			local var_132_18 = arg_129_1.actors_["10069ui_story"]

			if 1.96599999815226 < arg_129_1.time_ and arg_129_1.time_ <= 1.96599999815226 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect10069ui_story == nil then
				arg_129_1.var_.characterEffect10069ui_story = var_132_18:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_19 = 0.034000001847744

			if 1.96599999815226 <= arg_129_1.time_ and arg_129_1.time_ < 1.96599999815226 + var_132_19 and not isNil(var_132_18) then
				if arg_129_1.var_.characterEffect10069ui_story and not isNil(var_132_18) then
					arg_129_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 1.96599999815226) / var_132_19)
				end
			end

			if arg_129_1.time_ >= 1.96599999815226 + var_132_19 and arg_129_1.time_ < 1.96599999815226 + var_132_19 + arg_132_0 and not isNil(var_132_18) and arg_129_1.var_.characterEffect10069ui_story then
				arg_129_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			if 1.96599999815226 < arg_129_1.time_ and arg_129_1.time_ <= 1.96599999815226 + arg_132_0 then
				arg_129_1.fswbg_:SetActive(true)
				arg_129_1.dialog_:SetActive(false)

				arg_129_1.fswtw_.percent = 0
				arg_129_1.fswt_.text = arg_129_1:FormatText(arg_129_1:GetWordFromCfg(319501032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.fswt_)

				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_129_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_129_1.fswtw_:SetDirty()

				arg_129_1.typewritterCharCountI18N = 0

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_20 = 1.98266666481892

			if 1.98266666481892 < arg_129_1.time_ and arg_129_1.time_ <= var_132_20 + arg_132_0 then
				arg_129_1.var_.oldValueTypewriter = arg_129_1.fswtw_.percent

				SetActive(arg_129_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_129_1:ShowNextGo(false)
			end

			local var_132_21 = 41
			local var_132_22 = 2.73333333333333
			local var_132_23, var_132_24 = arg_129_1:GetPercentByPara(arg_129_1:FormatText(arg_129_1:GetWordFromCfg(319501032).content), 1)

			if var_132_20 < arg_129_1.time_ and arg_129_1.time_ <= var_132_20 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0

				local var_132_25 = var_132_21 <= 0 and var_132_22 or var_132_22 * ((var_132_24 - arg_129_1.typewritterCharCountI18N) / var_132_21)

				if (var_132_21 <= 0 and var_132_22 or var_132_22 * ((var_132_24 - arg_129_1.typewritterCharCountI18N) / var_132_21)) > 0 and var_132_22 < var_132_25 then
					arg_129_1.talkMaxDuration = var_132_25

					if var_132_25 + var_132_20 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_25 + var_132_20
					end
				end
			end

			local var_132_26 = math.max(2.73333333333333, arg_129_1.talkMaxDuration)

			if var_132_20 <= arg_129_1.time_ and arg_129_1.time_ < var_132_20 + var_132_26 then
				arg_129_1.fswtw_.percent = Mathf.Lerp(arg_129_1.var_.oldValueTypewriter, var_132_23, (arg_129_1.time_ - var_132_20) / var_132_26)
				arg_129_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_129_1.fswtw_:SetDirty()
			end

			if arg_129_1.time_ >= var_132_20 + var_132_26 and arg_129_1.time_ < var_132_20 + var_132_26 + arg_132_0 then
				arg_129_1.fswtw_.percent = var_132_23

				arg_129_1.fswtw_:SetDirty()
				arg_129_1:ShowNextGo(true)

				arg_129_1.typewritterCharCountI18N = var_132_24
			end

			if 1.96599999815226 < arg_129_1.time_ and arg_129_1.time_ <= 1.96599999815226 + arg_132_0 then
				local var_132_27 = arg_129_1.fswbg_.transform:Find("textbox/adapt/content") or arg_129_1.fswbg_.transform:Find("textbox/content")
				local var_132_28 = arg_129_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_132_29 = var_132_27:GetComponent("RectTransform")

				var_132_27:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_132_29.offsetMin = Vector2.New(0, 0)
				var_132_29.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_129_1.nodeConfigList_ = {
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
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_129_1:InitPlayNodeList()
	end,
	Play319501033 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 319501033
		arg_133_1.duration_ = 8.23

		local var_133_0 = {
			zh = 6.6,
			ja = 8.233
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play319501034(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 2.00000000298023 < arg_133_1.time_ and arg_133_1.time_ <= 2.00000000298023 + arg_136_0 then
				local var_136_0 = arg_133_1.bgs_.ST72

				arg_133_1.bgs_.ST72.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_1 = var_136_0:GetComponent("SpriteRenderer")

				if var_136_1 and var_136_1.sprite then
					local var_136_2 = 2 * (var_136_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_0.transform.localScale = Vector3.New(var_136_2 / var_136_1.sprite.bounds.size.y < var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x and var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x or var_136_2 / var_136_1.sprite.bounds.size.y, var_136_2 / var_136_1.sprite.bounds.size.y < var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x and var_136_2 * manager.ui.mainCameraCom_.aspect / var_136_1.sprite.bounds.size.x or var_136_2 / var_136_1.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST72" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_3 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_3 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_4 = 2

			if var_136_3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_3 + var_136_4 then
				local var_136_5 = Color.New(0, 0, 0)

				var_136_5.a = Mathf.Lerp(0, 1, (arg_133_1.time_ - var_136_3) / var_136_4)
				arg_133_1.mask_.color = var_136_5
			end

			if arg_133_1.time_ >= var_136_3 + var_136_4 and arg_133_1.time_ < var_136_3 + var_136_4 + arg_136_0 then
				local var_136_6 = Color.New(0, 0, 0)

				var_136_6.a = 1
				arg_133_1.mask_.color = var_136_6
			end

			local var_136_7 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_7 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_8 = 2

			if var_136_7 <= arg_133_1.time_ and arg_133_1.time_ < var_136_7 + var_136_8 then
				local var_136_9 = Color.New(0, 0, 0)

				var_136_9.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_7) / var_136_8)
				arg_133_1.mask_.color = var_136_9
			end

			if arg_133_1.time_ >= var_136_7 + var_136_8 and arg_133_1.time_ < var_136_7 + var_136_8 + arg_136_0 then
				local var_136_10 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_10.a = 0
				arg_133_1.mask_.color = var_136_10
			end

			local var_136_11 = arg_133_1.actors_["1084ui_story"].transform

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1.var_.moveOldPos1084ui_story = var_136_11.localPosition
			end

			local var_136_12 = 0.001

			if 3.8 <= arg_133_1.time_ and arg_133_1.time_ < 3.8 + var_136_12 then
				var_136_11.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_133_1.time_ - 3.8) / var_136_12)
				var_136_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_11.position).x, (manager.ui.mainCamera.transform.position - var_136_11.position).y, (manager.ui.mainCamera.transform.position - var_136_11.position).z)
				var_136_11.localEulerAngles.z = 0
				var_136_11.localEulerAngles.x = 0
				var_136_11.localEulerAngles = var_136_11.localEulerAngles
			end

			if arg_133_1.time_ >= 3.8 + var_136_12 and arg_133_1.time_ < 3.8 + var_136_12 + arg_136_0 then
				var_136_11.localPosition = Vector3.New(0, -0.97, -6)
				var_136_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_11.position).x, (manager.ui.mainCamera.transform.position - var_136_11.position).y, (manager.ui.mainCamera.transform.position - var_136_11.position).z)
				var_136_11.localEulerAngles.z = 0
				var_136_11.localEulerAngles.x = 0
				var_136_11.localEulerAngles = var_136_11.localEulerAngles
			end

			local var_136_13 = arg_133_1.actors_["1084ui_story"]

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect1084ui_story == nil then
				arg_133_1.var_.characterEffect1084ui_story = var_136_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_14 = 0.200000002980232

			if 3.8 <= arg_133_1.time_ and arg_133_1.time_ < 3.8 + var_136_14 and not isNil(var_136_13) then
				if arg_133_1.var_.characterEffect1084ui_story and not isNil(var_136_13) then
					arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 3.8 + var_136_14 and arg_133_1.time_ < 3.8 + var_136_14 + arg_136_0 and not isNil(var_136_13) and arg_133_1.var_.characterEffect1084ui_story then
				arg_133_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 3.8 < arg_133_1.time_ and arg_133_1.time_ <= 3.8 + arg_136_0 then
				arg_133_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 2.00000000298023 < arg_133_1.time_ and arg_133_1.time_ <= 2.00000000298023 + arg_136_0 then
				arg_133_1.fswbg_:SetActive(false)
				arg_133_1.dialog_:SetActive(false)
				SetActive(arg_133_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_133_1:ShowNextGo(false)
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_16 = 4
			local var_136_17 = 0.25

			if 4 < arg_133_1.time_ and arg_133_1.time_ <= var_136_16 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_18 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_18:setOnUpdate(LuaHelper.FloatAction(function(arg_137_0)
					arg_133_1.dialogCg_.alpha = arg_137_0
				end))
				var_136_18:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_18:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_19 = arg_133_1:GetWordFromCfg(319501033)
				local var_136_20 = arg_133_1:FormatText(var_136_19.content)

				arg_133_1.text_.text = var_136_20

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_22 = 10 <= 0 and var_136_17 or var_136_17 * (utf8.len(var_136_20) / 10)

				if (10 <= 0 and var_136_17 or var_136_17 * (utf8.len(var_136_20) / 10)) > 0 and var_136_17 < var_136_22 then
					arg_133_1.talkMaxDuration = var_136_22
					var_136_16 = var_136_16 + 0.3

					if var_136_22 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_22 + var_136_16
					end
				end

				arg_133_1.text_.text = var_136_20
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501033", "story_v_out_319501.awb") ~= 0 then
					local var_136_23 = manager.audio:GetVoiceLength("story_v_out_319501", "319501033", "story_v_out_319501.awb") / 1000

					if var_136_23 + var_136_16 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_23 + var_136_16
					end

					if var_136_19.prefab_name ~= "" and arg_133_1.actors_[var_136_19.prefab_name] ~= nil then
						local var_136_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_19.prefab_name].transform, "story_v_out_319501", "319501033", "story_v_out_319501.awb")

						arg_133_1:RecordAudio("319501033", var_136_24)
						arg_133_1:RecordAudio("319501033", var_136_24)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_319501", "319501033", "story_v_out_319501.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_319501", "319501033", "story_v_out_319501.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_25 = var_136_16 + 0.3
			local var_136_26 = math.max(var_136_17, arg_133_1.talkMaxDuration)

			if var_136_16 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_25 + var_136_26 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_25) / var_136_26

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_25 + var_136_26 and arg_133_1.time_ < var_136_25 + var_136_26 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play319501034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319501034
		arg_139_1.duration_ = 11.8

		local var_139_0 = {
			zh = 3.7,
			ja = 11.8
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
				arg_139_0:Play319501035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10069ui_story = arg_139_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10069ui_story, Vector3.New(0.7, -1.08, -6.33), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).z)
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles = arg_139_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0.7, -1.08, -6.33)
				arg_139_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["10069ui_story"].transform.position).z)
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["10069ui_story"].transform.localEulerAngles = arg_139_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["10069ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10069ui_story == nil then
				arg_139_1.var_.characterEffect10069ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect10069ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect10069ui_story then
				arg_139_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10056/story10056action/10056action1_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = arg_139_1.actors_["1084ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_139_1.time_ - 0) / var_142_5)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			local var_142_6 = arg_139_1.actors_["1084ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1084ui_story == nil then
				arg_139_1.var_.characterEffect1084ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect1084ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_139_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect1084ui_story then
				arg_139_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_139_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_142_8 = 0
			local var_142_9 = 0.425

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(319501034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 17 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 17)

				if (17 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 17)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501034", "story_v_out_319501.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501034", "story_v_out_319501.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_319501", "319501034", "story_v_out_319501.awb")

						arg_139_1:RecordAudio("319501034", var_142_15)
						arg_139_1:RecordAudio("319501034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319501", "319501034", "story_v_out_319501.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319501", "319501034", "story_v_out_319501.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_16 = math.max(var_142_9, arg_139_1.talkMaxDuration)

			if var_142_8 <= arg_139_1.time_ and arg_139_1.time_ < var_142_8 + var_142_16 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_8) / var_142_16

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_8 + var_142_16 and arg_139_1.time_ < var_142_8 + var_142_16 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
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

		arg_139_1:InitPlayNodeList()
	end,
	Play319501035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319501035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play319501036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["10069ui_story"]) and arg_143_1.var_.characterEffect10069ui_story == nil then
				arg_143_1.var_.characterEffect10069ui_story = arg_143_1.actors_["10069ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["10069ui_story"]) then
				if arg_143_1.var_.characterEffect10069ui_story and not isNil(arg_143_1.actors_["10069ui_story"]) then
					arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_0)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["10069ui_story"]) and arg_143_1.var_.characterEffect10069ui_story then
				arg_143_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			local var_146_1 = 0
			local var_146_2 = 0.925

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, false)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_3 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(319501035).content)

				arg_143_1.text_.text = var_146_3

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_5 = 37 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 37)

				if (37 <= 0 and var_146_2 or var_146_2 * (utf8.len(var_146_3) / 37)) > 0 and var_146_2 < var_146_5 then
					arg_143_1.talkMaxDuration = var_146_5

					if var_146_5 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_5 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_3
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_6 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_6 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_6

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_6 and arg_143_1.time_ < var_146_1 + var_146_6 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {}

		arg_143_1:InitPlayNodeList()
	end,
	Play319501036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319501036
		arg_147_1.duration_ = 5.2

		local var_147_0 = {
			zh = 4.433,
			ja = 5.2
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
				arg_147_0:Play319501037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1084ui_story = arg_147_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).z)
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles = arg_147_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_147_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).z)
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles = arg_147_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["1084ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1084ui_story == nil then
				arg_147_1.var_.characterEffect1084ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1084ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1084ui_story then
				arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_4 = 0
			local var_150_5 = 0.55

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_6 = arg_147_1:GetWordFromCfg(319501036)
				local var_150_7 = arg_147_1:FormatText(var_150_6.content)

				arg_147_1.text_.text = var_150_7

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_9 = 22 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 22)

				if (22 <= 0 and var_150_5 or var_150_5 * (utf8.len(var_150_7) / 22)) > 0 and var_150_5 < var_150_9 then
					arg_147_1.talkMaxDuration = var_150_9

					if var_150_9 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_9 + var_150_4
					end
				end

				arg_147_1.text_.text = var_150_7
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501036", "story_v_out_319501.awb") ~= 0 then
					local var_150_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501036", "story_v_out_319501.awb") / 1000

					if var_150_10 + var_150_4 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_10 + var_150_4
					end

					if var_150_6.prefab_name ~= "" and arg_147_1.actors_[var_150_6.prefab_name] ~= nil then
						local var_150_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_6.prefab_name].transform, "story_v_out_319501", "319501036", "story_v_out_319501.awb")

						arg_147_1:RecordAudio("319501036", var_150_11)
						arg_147_1:RecordAudio("319501036", var_150_11)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319501", "319501036", "story_v_out_319501.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319501", "319501036", "story_v_out_319501.awb")
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
				actorName = "1084ui_story",
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
	Play319501037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319501037
		arg_151_1.duration_ = 3.8

		local var_151_0 = {
			zh = 2.266,
			ja = 3.8
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
				arg_151_0:Play319501038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = arg_151_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(arg_151_1.actors_["1084ui_story"]) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_154_1 = arg_151_1.actors_["10069ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10069ui_story == nil then
				arg_151_1.var_.characterEffect10069ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10069ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10069ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10069ui_story then
				arg_151_1.var_.characterEffect10069ui_story.fillFlat = false
			end

			local var_154_4 = 0
			local var_154_5 = 0.2

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_4 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_6 = arg_151_1:GetWordFromCfg(319501037)
				local var_154_7 = arg_151_1:FormatText(var_154_6.content)

				arg_151_1.text_.text = var_154_7

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_9 = 8 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 8)

				if (8 <= 0 and var_154_5 or var_154_5 * (utf8.len(var_154_7) / 8)) > 0 and var_154_5 < var_154_9 then
					arg_151_1.talkMaxDuration = var_154_9

					if var_154_9 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_9 + var_154_4
					end
				end

				arg_151_1.text_.text = var_154_7
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501037", "story_v_out_319501.awb") ~= 0 then
					local var_154_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501037", "story_v_out_319501.awb") / 1000

					if var_154_10 + var_154_4 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_4
					end

					if var_154_6.prefab_name ~= "" and arg_151_1.actors_[var_154_6.prefab_name] ~= nil then
						local var_154_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_6.prefab_name].transform, "story_v_out_319501", "319501037", "story_v_out_319501.awb")

						arg_151_1:RecordAudio("319501037", var_154_11)
						arg_151_1:RecordAudio("319501037", var_154_11)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319501", "319501037", "story_v_out_319501.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319501", "319501037", "story_v_out_319501.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_12 = math.max(var_154_5, arg_151_1.talkMaxDuration)

			if var_154_4 <= arg_151_1.time_ and arg_151_1.time_ < var_154_4 + var_154_12 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_4) / var_154_12

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_4 + var_154_12 and arg_151_1.time_ < var_154_4 + var_154_12 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319501038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319501038
		arg_155_1.duration_ = 9

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play319501039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 2 < arg_155_1.time_ and arg_155_1.time_ <= 2 + arg_158_0 then
				local var_158_0 = arg_155_1.bgs_.ST72

				arg_155_1.bgs_.ST72.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_158_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_158_1 = var_158_0:GetComponent("SpriteRenderer")

				if var_158_1 and var_158_1.sprite then
					local var_158_2 = 2 * (var_158_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_158_0.transform.localScale = Vector3.New(var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, var_158_2 / var_158_1.sprite.bounds.size.y < var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x and var_158_2 * manager.ui.mainCameraCom_.aspect / var_158_1.sprite.bounds.size.x or var_158_2 / var_158_1.sprite.bounds.size.y, 0)
				end

				for iter_158_0, iter_158_1 in pairs(arg_155_1.bgs_) do
					if iter_158_0 ~= "ST72" then
						iter_158_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_158_3 = 0

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_4 = 2

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_4 then
				local var_158_5 = Color.New(0, 0, 0)

				var_158_5.a = Mathf.Lerp(0, 1, (arg_155_1.time_ - var_158_3) / var_158_4)
				arg_155_1.mask_.color = var_158_5
			end

			if arg_155_1.time_ >= var_158_3 + var_158_4 and arg_155_1.time_ < var_158_3 + var_158_4 + arg_158_0 then
				local var_158_6 = Color.New(0, 0, 0)

				var_158_6.a = 1
				arg_155_1.mask_.color = var_158_6
			end

			local var_158_7 = 2

			if 2 < arg_155_1.time_ and arg_155_1.time_ <= var_158_7 + arg_158_0 then
				arg_155_1.mask_.enabled = true
				arg_155_1.mask_.raycastTarget = true

				arg_155_1:SetGaussion(false)
			end

			local var_158_8 = 2

			if var_158_7 <= arg_155_1.time_ and arg_155_1.time_ < var_158_7 + var_158_8 then
				local var_158_9 = Color.New(0, 0, 0)

				var_158_9.a = Mathf.Lerp(1, 0, (arg_155_1.time_ - var_158_7) / var_158_8)
				arg_155_1.mask_.color = var_158_9
			end

			if arg_155_1.time_ >= var_158_7 + var_158_8 and arg_155_1.time_ < var_158_7 + var_158_8 + arg_158_0 then
				local var_158_10 = Color.New(0, 0, 0)

				arg_155_1.mask_.enabled = false
				var_158_10.a = 0
				arg_155_1.mask_.color = var_158_10
			end

			local var_158_11 = arg_155_1.actors_["1084ui_story"].transform

			if 1.966 < arg_155_1.time_ and arg_155_1.time_ <= 1.966 + arg_158_0 then
				arg_155_1.var_.moveOldPos1084ui_story = var_158_11.localPosition
			end

			local var_158_12 = 0.001

			if 1.966 <= arg_155_1.time_ and arg_155_1.time_ < 1.966 + var_158_12 then
				var_158_11.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 1.966) / var_158_12)
				var_158_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_11.position).x, (manager.ui.mainCamera.transform.position - var_158_11.position).y, (manager.ui.mainCamera.transform.position - var_158_11.position).z)
				var_158_11.localEulerAngles.z = 0
				var_158_11.localEulerAngles.x = 0
				var_158_11.localEulerAngles = var_158_11.localEulerAngles
			end

			if arg_155_1.time_ >= 1.966 + var_158_12 and arg_155_1.time_ < 1.966 + var_158_12 + arg_158_0 then
				var_158_11.localPosition = Vector3.New(0, 100, 0)
				var_158_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_11.position).x, (manager.ui.mainCamera.transform.position - var_158_11.position).y, (manager.ui.mainCamera.transform.position - var_158_11.position).z)
				var_158_11.localEulerAngles.z = 0
				var_158_11.localEulerAngles.x = 0
				var_158_11.localEulerAngles = var_158_11.localEulerAngles
			end

			local var_158_13 = arg_155_1.actors_["10069ui_story"].transform

			if 1.966 < arg_155_1.time_ and arg_155_1.time_ <= 1.966 + arg_158_0 then
				arg_155_1.var_.moveOldPos10069ui_story = var_158_13.localPosition
			end

			local var_158_14 = 0.001

			if 1.966 <= arg_155_1.time_ and arg_155_1.time_ < 1.966 + var_158_14 then
				var_158_13.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 1.966) / var_158_14)
				var_158_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_13.position).x, (manager.ui.mainCamera.transform.position - var_158_13.position).y, (manager.ui.mainCamera.transform.position - var_158_13.position).z)
				var_158_13.localEulerAngles.z = 0
				var_158_13.localEulerAngles.x = 0
				var_158_13.localEulerAngles = var_158_13.localEulerAngles
			end

			if arg_155_1.time_ >= 1.966 + var_158_14 and arg_155_1.time_ < 1.966 + var_158_14 + arg_158_0 then
				var_158_13.localPosition = Vector3.New(0, 100, 0)
				var_158_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_13.position).x, (manager.ui.mainCamera.transform.position - var_158_13.position).y, (manager.ui.mainCamera.transform.position - var_158_13.position).z)
				var_158_13.localEulerAngles.z = 0
				var_158_13.localEulerAngles.x = 0
				var_158_13.localEulerAngles = var_158_13.localEulerAngles
			end

			if arg_155_1.frameCnt_ <= 1 then
				arg_155_1.dialog_:SetActive(false)
			end

			local var_158_15 = 4
			local var_158_16 = 1.05

			if 4 < arg_155_1.time_ and arg_155_1.time_ <= var_158_15 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0

				arg_155_1.dialog_:SetActive(true)

				arg_155_1.dialogCg_.alpha = 0

				local var_158_17 = LeanTween.value(arg_155_1.dialog_, 0, 1, 0.3)

				var_158_17:setOnUpdate(LuaHelper.FloatAction(function(arg_159_0)
					arg_155_1.dialogCg_.alpha = arg_159_0
				end))
				var_158_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_155_1.dialog_)
					var_158_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_155_1.duration_ = arg_155_1.duration_ + 0.3

				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_18 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(319501038).content)

				arg_155_1.text_.text = var_158_18

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_20 = 42 <= 0 and var_158_16 or var_158_16 * (utf8.len(var_158_18) / 42)

				if (42 <= 0 and var_158_16 or var_158_16 * (utf8.len(var_158_18) / 42)) > 0 and var_158_16 < var_158_20 then
					arg_155_1.talkMaxDuration = var_158_20
					var_158_15 = var_158_15 + 0.3

					if var_158_20 + var_158_15 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_20 + var_158_15
					end
				end

				arg_155_1.text_.text = var_158_18
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_21 = var_158_15 + 0.3
			local var_158_22 = math.max(var_158_16, arg_155_1.talkMaxDuration)

			if var_158_15 + 0.3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_21 + var_158_22 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_21) / var_158_22

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_21 + var_158_22 and arg_155_1.time_ < var_158_21 + var_158_22 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.966,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_155_1:InitPlayNodeList()
	end,
	Play319501039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 319501039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play319501040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			local var_164_0 = 1.775

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_1 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(319501039).content)

				arg_161_1.text_.text = var_164_1

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_3 = 71 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 71)

				if (71 <= 0 and var_164_0 or var_164_0 * (utf8.len(var_164_1) / 71)) > 0 and var_164_0 < var_164_3 then
					arg_161_1.talkMaxDuration = var_164_3

					if var_164_3 + 0 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_3 + 0
					end
				end

				arg_161_1.text_.text = var_164_1
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_4 = math.max(var_164_0, arg_161_1.talkMaxDuration)

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_4 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - 0) / var_164_4

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= 0 + var_164_4 and arg_161_1.time_ < 0 + var_164_4 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {}

		arg_161_1:InitPlayNodeList()
	end,
	Play319501040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 319501040
		arg_165_1.duration_ = 5

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play319501041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			local var_168_0 = 1.05

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, false)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_1 = arg_165_1:FormatText(arg_165_1:GetWordFromCfg(319501040).content)

				arg_165_1.text_.text = var_168_1

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_3 = 42 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 42)

				if (42 <= 0 and var_168_0 or var_168_0 * (utf8.len(var_168_1) / 42)) > 0 and var_168_0 < var_168_3 then
					arg_165_1.talkMaxDuration = var_168_3

					if var_168_3 + 0 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_3 + 0
					end
				end

				arg_165_1.text_.text = var_168_1
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)
				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_4 = math.max(var_168_0, arg_165_1.talkMaxDuration)

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_4 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - 0) / var_168_4

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= 0 + var_168_4 and arg_165_1.time_ < 0 + var_168_4 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {}

		arg_165_1:InitPlayNodeList()
	end,
	Play319501041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 319501041
		arg_169_1.duration_ = 3.4

		local var_169_0 = {
			zh = 2,
			ja = 3.4
		}
		local var_169_1 = manager.audio:GetLocalizationFlag()

		if var_169_0[var_169_1] ~= nil then
			arg_169_1.duration_ = var_169_0[var_169_1]
		end

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play319501042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10069ui_story = arg_169_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10069ui_story, Vector3.New(0, -1.08, -6.33), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10069ui_story"].transform.position).z)
				arg_169_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10069ui_story"].transform.localEulerAngles = arg_169_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, -1.08, -6.33)
				arg_169_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10069ui_story"].transform.position).z)
				arg_169_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10069ui_story"].transform.localEulerAngles = arg_169_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1:PlayTimeline("10069ui_story", "StoryTimeline/CharAction/story10069/story10069action/10069action1_1")
			end

			local var_172_1 = 0
			local var_172_2 = 0.2

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_1 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, true)

				arg_169_1.leftNameTxt_.text = arg_169_1:FormatText(StoryNameCfg[693].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_169_1.leftNameTxt_.transform)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1.leftNameTxt_.text)
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_3 = arg_169_1:GetWordFromCfg(319501041)
				local var_172_4 = arg_169_1:FormatText(var_172_3.content)

				arg_169_1.text_.text = var_172_4

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_6 = 8 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_4) / 8)

				if (8 <= 0 and var_172_2 or var_172_2 * (utf8.len(var_172_4) / 8)) > 0 and var_172_2 < var_172_6 then
					arg_169_1.talkMaxDuration = var_172_6

					if var_172_6 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_6 + var_172_1
					end
				end

				arg_169_1.text_.text = var_172_4
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501041", "story_v_out_319501.awb") ~= 0 then
					local var_172_7 = manager.audio:GetVoiceLength("story_v_out_319501", "319501041", "story_v_out_319501.awb") / 1000

					if var_172_7 + var_172_1 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_7 + var_172_1
					end

					if var_172_3.prefab_name ~= "" and arg_169_1.actors_[var_172_3.prefab_name] ~= nil then
						local var_172_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_169_1.actors_[var_172_3.prefab_name].transform, "story_v_out_319501", "319501041", "story_v_out_319501.awb")

						arg_169_1:RecordAudio("319501041", var_172_8)
						arg_169_1:RecordAudio("319501041", var_172_8)
					else
						arg_169_1:AudioAction("play", "voice", "story_v_out_319501", "319501041", "story_v_out_319501.awb")
					end

					arg_169_1:RecordHistoryTalkVoice("story_v_out_319501", "319501041", "story_v_out_319501.awb")
				end

				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_9 = math.max(var_172_2, arg_169_1.talkMaxDuration)

			if var_172_1 <= arg_169_1.time_ and arg_169_1.time_ < var_172_1 + var_172_9 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_1) / var_172_9

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_1 + var_172_9 and arg_169_1.time_ < var_172_1 + var_172_9 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play319501042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 319501042
		arg_173_1.duration_ = 5

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play319501043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos10069ui_story = arg_173_1.actors_["10069ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["10069ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10069ui_story"].transform.position).z)
				arg_173_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10069ui_story"].transform.localEulerAngles = arg_173_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["10069ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_173_1.actors_["10069ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["10069ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10069ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["10069ui_story"].transform.position).z)
				arg_173_1.actors_["10069ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["10069ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["10069ui_story"].transform.localEulerAngles = arg_173_1.actors_["10069ui_story"].transform.localEulerAngles
			end

			local var_176_1 = 0
			local var_176_2 = 1.425

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_1 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, false)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_3 = arg_173_1:FormatText(arg_173_1:GetWordFromCfg(319501042).content)

				arg_173_1.text_.text = var_176_3

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_5 = 57 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 57)

				if (57 <= 0 and var_176_2 or var_176_2 * (utf8.len(var_176_3) / 57)) > 0 and var_176_2 < var_176_5 then
					arg_173_1.talkMaxDuration = var_176_5

					if var_176_5 + var_176_1 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_5 + var_176_1
					end
				end

				arg_173_1.text_.text = var_176_3
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)
				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_6 = math.max(var_176_2, arg_173_1.talkMaxDuration)

			if var_176_1 <= arg_173_1.time_ and arg_173_1.time_ < var_176_1 + var_176_6 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_1) / var_176_6

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_1 + var_176_6 and arg_173_1.time_ < var_176_1 + var_176_6 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10069ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_173_1:InitPlayNodeList()
	end,
	Play319501043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 319501043
		arg_177_1.duration_ = 4.53

		local var_177_0 = {
			zh = 2.9,
			ja = 4.533
		}
		local var_177_1 = manager.audio:GetLocalizationFlag()

		if var_177_0[var_177_1] ~= nil then
			arg_177_1.duration_ = var_177_0[var_177_1]
		end

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play319501044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1084ui_story = arg_177_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).z)
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles = arg_177_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_177_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1084ui_story"].transform.position).z)
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1084ui_story"].transform.localEulerAngles = arg_177_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_180_1 = arg_177_1.actors_["1084ui_story"]

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1084ui_story == nil then
				arg_177_1.var_.characterEffect1084ui_story = var_180_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_180_2 = 0.200000002980232

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_2 and not isNil(var_180_1) then
				if arg_177_1.var_.characterEffect1084ui_story and not isNil(var_180_1) then
					arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_177_1.time_ >= 0 + var_180_2 and arg_177_1.time_ < 0 + var_180_2 + arg_180_0 and not isNil(var_180_1) and arg_177_1.var_.characterEffect1084ui_story then
				arg_177_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_180_4 = 0
			local var_180_5 = 0.25

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_4 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, true)

				arg_177_1.leftNameTxt_.text = arg_177_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_177_1.leftNameTxt_.transform)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1.leftNameTxt_.text)
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_6 = arg_177_1:GetWordFromCfg(319501043)
				local var_180_7 = arg_177_1:FormatText(var_180_6.content)

				arg_177_1.text_.text = var_180_7

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_9 = 10 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 10)

				if (10 <= 0 and var_180_5 or var_180_5 * (utf8.len(var_180_7) / 10)) > 0 and var_180_5 < var_180_9 then
					arg_177_1.talkMaxDuration = var_180_9

					if var_180_9 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_9 + var_180_4
					end
				end

				arg_177_1.text_.text = var_180_7
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501043", "story_v_out_319501.awb") ~= 0 then
					local var_180_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501043", "story_v_out_319501.awb") / 1000

					if var_180_10 + var_180_4 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_10 + var_180_4
					end

					if var_180_6.prefab_name ~= "" and arg_177_1.actors_[var_180_6.prefab_name] ~= nil then
						local var_180_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_177_1.actors_[var_180_6.prefab_name].transform, "story_v_out_319501", "319501043", "story_v_out_319501.awb")

						arg_177_1:RecordAudio("319501043", var_180_11)
						arg_177_1:RecordAudio("319501043", var_180_11)
					else
						arg_177_1:AudioAction("play", "voice", "story_v_out_319501", "319501043", "story_v_out_319501.awb")
					end

					arg_177_1:RecordHistoryTalkVoice("story_v_out_319501", "319501043", "story_v_out_319501.awb")
				end

				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_12 = math.max(var_180_5, arg_177_1.talkMaxDuration)

			if var_180_4 <= arg_177_1.time_ and arg_177_1.time_ < var_180_4 + var_180_12 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_4) / var_180_12

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_4 + var_180_12 and arg_177_1.time_ < var_180_4 + var_180_12 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play319501044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 319501044
		arg_181_1.duration_ = 5

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play319501045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) and arg_181_1.var_.characterEffect1084ui_story == nil then
				arg_181_1.var_.characterEffect1084ui_story = arg_181_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_184_0 = 0.200000002980232

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) then
				if arg_181_1.var_.characterEffect1084ui_story and not isNil(arg_181_1.actors_["1084ui_story"]) then
					arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_181_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_181_1.time_ - 0) / var_184_0)
				end
			end

			if arg_181_1.time_ >= 0 + var_184_0 and arg_181_1.time_ < 0 + var_184_0 + arg_184_0 and not isNil(arg_181_1.actors_["1084ui_story"]) and arg_181_1.var_.characterEffect1084ui_story then
				arg_181_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_181_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_184_1 = 0
			local var_184_2 = 0.775

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= var_184_1 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, false)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_181_1.iconTrs_.gameObject, false)
				arg_181_1.callingController_:SetSelectedState("normal")

				local var_184_3 = arg_181_1:FormatText(arg_181_1:GetWordFromCfg(319501044).content)

				arg_181_1.text_.text = var_184_3

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_5 = 31 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 31)

				if (31 <= 0 and var_184_2 or var_184_2 * (utf8.len(var_184_3) / 31)) > 0 and var_184_2 < var_184_5 then
					arg_181_1.talkMaxDuration = var_184_5

					if var_184_5 + var_184_1 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + var_184_1
					end
				end

				arg_181_1.text_.text = var_184_3
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)
				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_6 = math.max(var_184_2, arg_181_1.talkMaxDuration)

			if var_184_1 <= arg_181_1.time_ and arg_181_1.time_ < var_184_1 + var_184_6 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - var_184_1) / var_184_6

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= var_184_1 + var_184_6 and arg_181_1.time_ < var_184_1 + var_184_6 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play319501045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 319501045
		arg_185_1.duration_ = 2

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play319501046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_2")
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_188_0 = arg_185_1.actors_["1084ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1084ui_story == nil then
				arg_185_1.var_.characterEffect1084ui_story = var_188_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_1 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_1 and not isNil(var_188_0) then
				if arg_185_1.var_.characterEffect1084ui_story and not isNil(var_188_0) then
					arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_1 and arg_185_1.time_ < 0 + var_188_1 + arg_188_0 and not isNil(var_188_0) and arg_185_1.var_.characterEffect1084ui_story then
				arg_185_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_188_3 = 0
			local var_188_4 = 0.1

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_3 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_5 = arg_185_1:GetWordFromCfg(319501045)
				local var_188_6 = arg_185_1:FormatText(var_188_5.content)

				arg_185_1.text_.text = var_188_6

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_8 = 4 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_6) / 4)

				if (4 <= 0 and var_188_4 or var_188_4 * (utf8.len(var_188_6) / 4)) > 0 and var_188_4 < var_188_8 then
					arg_185_1.talkMaxDuration = var_188_8

					if var_188_8 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_8 + var_188_3
					end
				end

				arg_185_1.text_.text = var_188_6
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501045", "story_v_out_319501.awb") ~= 0 then
					local var_188_9 = manager.audio:GetVoiceLength("story_v_out_319501", "319501045", "story_v_out_319501.awb") / 1000

					if var_188_9 + var_188_3 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_3
					end

					if var_188_5.prefab_name ~= "" and arg_185_1.actors_[var_188_5.prefab_name] ~= nil then
						local var_188_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_5.prefab_name].transform, "story_v_out_319501", "319501045", "story_v_out_319501.awb")

						arg_185_1:RecordAudio("319501045", var_188_10)
						arg_185_1:RecordAudio("319501045", var_188_10)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_319501", "319501045", "story_v_out_319501.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_319501", "319501045", "story_v_out_319501.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_11 = math.max(var_188_4, arg_185_1.talkMaxDuration)

			if var_188_3 <= arg_185_1.time_ and arg_185_1.time_ < var_188_3 + var_188_11 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_3) / var_188_11

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_3 + var_188_11 and arg_185_1.time_ < var_188_3 + var_188_11 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {}

		arg_185_1:InitPlayNodeList()
	end,
	Play319501046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 319501046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play319501047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 and not isNil(arg_189_1.actors_["1084ui_story"]) and arg_189_1.var_.characterEffect1084ui_story == nil then
				arg_189_1.var_.characterEffect1084ui_story = arg_189_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_192_0 = 0.200000002980232

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 and not isNil(arg_189_1.actors_["1084ui_story"]) then
				if arg_189_1.var_.characterEffect1084ui_story and not isNil(arg_189_1.actors_["1084ui_story"]) then
					arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_189_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_189_1.time_ - 0) / var_192_0)
				end
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 and not isNil(arg_189_1.actors_["1084ui_story"]) and arg_189_1.var_.characterEffect1084ui_story then
				arg_189_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_189_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_192_1 = 0
			local var_192_2 = 0.825

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_1 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_3 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(319501046).content)

				arg_189_1.text_.text = var_192_3

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_5 = 33 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 33)

				if (33 <= 0 and var_192_2 or var_192_2 * (utf8.len(var_192_3) / 33)) > 0 and var_192_2 < var_192_5 then
					arg_189_1.talkMaxDuration = var_192_5

					if var_192_5 + var_192_1 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_5 + var_192_1
					end
				end

				arg_189_1.text_.text = var_192_3
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_6 = math.max(var_192_2, arg_189_1.talkMaxDuration)

			if var_192_1 <= arg_189_1.time_ and arg_189_1.time_ < var_192_1 + var_192_6 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_1) / var_192_6

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_1 + var_192_6 and arg_189_1.time_ < var_192_1 + var_192_6 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {}

		arg_189_1:InitPlayNodeList()
	end,
	Play319501047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 319501047
		arg_193_1.duration_ = 6.6

		local var_193_0 = {
			zh = 5.666,
			ja = 6.6
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play319501048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_196_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_193_1.bgmTxt_.text ~= var_196_2 and arg_193_1.bgmTxt_.text ~= "" then
						if arg_193_1.bgmTxt2_.text ~= "" then
							arg_193_1.bgmTxt_.text = arg_193_1.bgmTxt2_.text
						end

						arg_193_1.bgmTxt2_.text = var_196_2

						arg_193_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_193_1.bgmTxt_.text = var_196_2
						arg_193_1.bgmTxt2_.text = var_196_2
					end

					if arg_193_1.bgmTimer then
						arg_193_1.bgmTimer:Stop()

						arg_193_1.bgmTimer = nil
					end

					if arg_193_1.settingData.show_music_name == 1 then
						arg_193_1.musicController:SetSelectedState("show")
						arg_193_1.musicAnimator_:Play("open", 0, 0)

						if arg_193_1.settingData.music_time ~= 0 then
							arg_193_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_193_1.settingData.music_time), function()
								if arg_193_1 == nil or isNil(arg_193_1.bgmTxt_) then
									return
								end

								arg_193_1.musicController:SetSelectedState("hide")
								arg_193_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_196_3 = arg_193_1.actors_["1084ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_3) and arg_193_1.var_.characterEffect1084ui_story == nil then
				arg_193_1.var_.characterEffect1084ui_story = var_196_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_4 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_4 and not isNil(var_196_3) then
				if arg_193_1.var_.characterEffect1084ui_story and not isNil(var_196_3) then
					arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_4 and arg_193_1.time_ < 0 + var_196_4 + arg_196_0 and not isNil(var_196_3) and arg_193_1.var_.characterEffect1084ui_story then
				arg_193_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_196_6 = 0
			local var_196_7 = 0.625

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:GetWordFromCfg(319501047)
				local var_196_9 = arg_193_1:FormatText(var_196_8.content)

				arg_193_1.text_.text = var_196_9

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_11 = 25 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 25)

				if (25 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_9) / 25)) > 0 and var_196_7 < var_196_11 then
					arg_193_1.talkMaxDuration = var_196_11

					if var_196_11 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_11 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_9
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501047", "story_v_out_319501.awb") ~= 0 then
					local var_196_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501047", "story_v_out_319501.awb") / 1000

					if var_196_12 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_12 + var_196_6
					end

					if var_196_8.prefab_name ~= "" and arg_193_1.actors_[var_196_8.prefab_name] ~= nil then
						local var_196_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_8.prefab_name].transform, "story_v_out_319501", "319501047", "story_v_out_319501.awb")

						arg_193_1:RecordAudio("319501047", var_196_13)
						arg_193_1:RecordAudio("319501047", var_196_13)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_319501", "319501047", "story_v_out_319501.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_319501", "319501047", "story_v_out_319501.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_14 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_14 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_14

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_14 and arg_193_1.time_ < var_196_6 + var_196_14 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {}

		arg_193_1:InitPlayNodeList()
	end,
	Play319501048 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 319501048
		arg_198_1.duration_ = 7.13

		local var_198_0 = {
			zh = 3.033,
			ja = 7.133
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
				arg_198_0:Play319501049(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			local var_201_0 = 0.45

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
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

				local var_201_1 = arg_198_1:GetWordFromCfg(319501048)
				local var_201_2 = arg_198_1:FormatText(var_201_1.content)

				arg_198_1.text_.text = var_201_2

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_4 = 18 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 18)

				if (18 <= 0 and var_201_0 or var_201_0 * (utf8.len(var_201_2) / 18)) > 0 and var_201_0 < var_201_4 then
					arg_198_1.talkMaxDuration = var_201_4

					if var_201_4 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_4 + 0
					end
				end

				arg_198_1.text_.text = var_201_2
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501048", "story_v_out_319501.awb") ~= 0 then
					local var_201_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501048", "story_v_out_319501.awb") / 1000

					if var_201_5 + 0 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_5 + 0
					end

					if var_201_1.prefab_name ~= "" and arg_198_1.actors_[var_201_1.prefab_name] ~= nil then
						local var_201_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_1.prefab_name].transform, "story_v_out_319501", "319501048", "story_v_out_319501.awb")

						arg_198_1:RecordAudio("319501048", var_201_6)
						arg_198_1:RecordAudio("319501048", var_201_6)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_319501", "319501048", "story_v_out_319501.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_319501", "319501048", "story_v_out_319501.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_7 = math.max(var_201_0, arg_198_1.talkMaxDuration)

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - 0) / var_201_7

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play319501049 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 319501049
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play319501050(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1084ui_story = arg_202_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_205_0 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 then
				arg_202_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_0)
				arg_202_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1084ui_story"].transform.position).z)
				arg_202_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1084ui_story"].transform.localEulerAngles = arg_202_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 then
				arg_202_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["1084ui_story"].transform.position).z)
				arg_202_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["1084ui_story"].transform.localEulerAngles = arg_202_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_205_1 = arg_202_1.actors_["1084ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1084ui_story == nil then
				arg_202_1.var_.characterEffect1084ui_story = var_205_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_2 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_2 and not isNil(var_205_1) then
				if arg_202_1.var_.characterEffect1084ui_story and not isNil(var_205_1) then
					arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_202_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_2)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_2 and arg_202_1.time_ < 0 + var_205_2 + arg_205_0 and not isNil(var_205_1) and arg_202_1.var_.characterEffect1084ui_story then
				arg_202_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_202_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_205_3 = arg_202_1.actors_["10069ui_story"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos10069ui_story = var_205_3.localPosition
			end

			local var_205_4 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				var_205_3.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos10069ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_4)
				var_205_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_3.position).x, (manager.ui.mainCamera.transform.position - var_205_3.position).y, (manager.ui.mainCamera.transform.position - var_205_3.position).z)
				var_205_3.localEulerAngles.z = 0
				var_205_3.localEulerAngles.x = 0
				var_205_3.localEulerAngles = var_205_3.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				var_205_3.localPosition = Vector3.New(0, 100, 0)
				var_205_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_3.position).x, (manager.ui.mainCamera.transform.position - var_205_3.position).y, (manager.ui.mainCamera.transform.position - var_205_3.position).z)
				var_205_3.localEulerAngles.z = 0
				var_205_3.localEulerAngles.x = 0
				var_205_3.localEulerAngles = var_205_3.localEulerAngles
			end

			local var_205_5 = arg_202_1.actors_["10069ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.characterEffect10069ui_story == nil then
				arg_202_1.var_.characterEffect10069ui_story = var_205_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_6 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_6 and not isNil(var_205_5) then
				if arg_202_1.var_.characterEffect10069ui_story and not isNil(var_205_5) then
					arg_202_1.var_.characterEffect10069ui_story.fillFlat = true
					arg_202_1.var_.characterEffect10069ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_6)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_6 and arg_202_1.time_ < 0 + var_205_6 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.characterEffect10069ui_story then
				arg_202_1.var_.characterEffect10069ui_story.fillFlat = true
				arg_202_1.var_.characterEffect10069ui_story.fillRatio = 0.5
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:AudioAction("play", "effect", "se_story_130", "se_story_130__knock", "")
			end

			local var_205_8 = 0
			local var_205_9 = 1.075

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_8 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_10 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(319501049).content)

				arg_202_1.text_.text = var_205_10

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_12 = 43 <= 0 and var_205_9 or var_205_9 * (utf8.len(var_205_10) / 43)

				if (43 <= 0 and var_205_9 or var_205_9 * (utf8.len(var_205_10) / 43)) > 0 and var_205_9 < var_205_12 then
					arg_202_1.talkMaxDuration = var_205_12

					if var_205_12 + var_205_8 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_12 + var_205_8
					end
				end

				arg_202_1.text_.text = var_205_10
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_13 = math.max(var_205_9, arg_202_1.talkMaxDuration)

			if var_205_8 <= arg_202_1.time_ and arg_202_1.time_ < var_205_8 + var_205_13 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_8) / var_205_13

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_8 + var_205_13 and arg_202_1.time_ < var_205_8 + var_205_13 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play319501050 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 319501050
		arg_206_1.duration_ = 7

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play319501051(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if arg_206_1.bgs_.ST71 == nil then
				local var_209_0 = Object.Instantiate(arg_206_1.paintGo_)

				var_209_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST71")
				var_209_0.name = "ST71"
				var_209_0.transform.parent = arg_206_1.stage_.transform
				var_209_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_206_1.bgs_.ST71 = var_209_0
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				local var_209_1 = arg_206_1.bgs_.ST71

				arg_206_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_209_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_209_2 = var_209_1:GetComponent("SpriteRenderer")

				if var_209_2 and var_209_2.sprite then
					local var_209_3 = 2 * (var_209_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_209_1.transform.localScale = Vector3.New(var_209_3 / var_209_2.sprite.bounds.size.y < var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x and var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x or var_209_3 / var_209_2.sprite.bounds.size.y, var_209_3 / var_209_2.sprite.bounds.size.y < var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x and var_209_3 * manager.ui.mainCameraCom_.aspect / var_209_2.sprite.bounds.size.x or var_209_3 / var_209_2.sprite.bounds.size.y, 0)
				end

				for iter_209_0, iter_209_1 in pairs(arg_206_1.bgs_) do
					if iter_209_0 ~= "ST71" then
						iter_209_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_209_4 = 2

			if 2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.allBtn_.enabled = false
			end

			if arg_206_1.time_ >= var_209_4 + 0.3 and arg_206_1.time_ < var_209_4 + 0.3 + arg_209_0 then
				arg_206_1.allBtn_.enabled = true
			end

			local var_209_5 = 0

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_5 + arg_209_0 then
				arg_206_1.mask_.enabled = true
				arg_206_1.mask_.raycastTarget = true

				arg_206_1:SetGaussion(false)
			end

			local var_209_6 = 2

			if var_209_5 <= arg_206_1.time_ and arg_206_1.time_ < var_209_5 + var_209_6 then
				local var_209_7 = Color.New(1, 1, 1)

				var_209_7.a = Mathf.Lerp(1, 0, (arg_206_1.time_ - var_209_5) / var_209_6)
				arg_206_1.mask_.color = var_209_7
			end

			if arg_206_1.time_ >= var_209_5 + var_209_6 and arg_206_1.time_ < var_209_5 + var_209_6 + arg_209_0 then
				local var_209_8 = Color.New(1, 1, 1)

				arg_206_1.mask_.enabled = false
				var_209_8.a = 0
				arg_206_1.mask_.color = var_209_8
			end

			if arg_206_1.frameCnt_ <= 1 then
				arg_206_1.dialog_:SetActive(false)
			end

			local var_209_9 = 2
			local var_209_10 = 1.825

			if 2 < arg_206_1.time_ and arg_206_1.time_ <= var_209_9 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0

				arg_206_1.dialog_:SetActive(true)

				arg_206_1.dialogCg_.alpha = 0

				local var_209_11 = LeanTween.value(arg_206_1.dialog_, 0, 1, 0.3)

				var_209_11:setOnUpdate(LuaHelper.FloatAction(function(arg_210_0)
					arg_206_1.dialogCg_.alpha = arg_210_0
				end))
				var_209_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_206_1.dialog_)
					var_209_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_206_1.duration_ = arg_206_1.duration_ + 0.3

				SetActive(arg_206_1.leftNameGo_, false)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_12 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(319501050).content)

				arg_206_1.text_.text = var_209_12

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_14 = 73 <= 0 and var_209_10 or var_209_10 * (utf8.len(var_209_12) / 73)

				if (73 <= 0 and var_209_10 or var_209_10 * (utf8.len(var_209_12) / 73)) > 0 and var_209_10 < var_209_14 then
					arg_206_1.talkMaxDuration = var_209_14
					var_209_9 = var_209_9 + 0.3

					if var_209_14 + var_209_9 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_14 + var_209_9
					end
				end

				arg_206_1.text_.text = var_209_12
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_15 = var_209_9 + 0.3
			local var_209_16 = math.max(var_209_10, arg_206_1.talkMaxDuration)

			if var_209_9 + 0.3 <= arg_206_1.time_ and arg_206_1.time_ < var_209_15 + var_209_16 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_15) / var_209_16

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_15 + var_209_16 and arg_206_1.time_ < var_209_15 + var_209_16 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {}

		arg_206_1:InitPlayNodeList()
	end,
	Play319501051 = function(arg_212_0, arg_212_1)
		arg_212_1.time_ = 0
		arg_212_1.frameCnt_ = 0
		arg_212_1.state_ = "playing"
		arg_212_1.curTalkId_ = 319501051
		arg_212_1.duration_ = 5

		SetActive(arg_212_1.tipsGo_, false)

		function arg_212_1.onSingleLineFinish_()
			arg_212_1.onSingleLineUpdate_ = nil
			arg_212_1.onSingleLineFinish_ = nil
			arg_212_1.state_ = "waiting"
		end

		function arg_212_1.playNext_(arg_214_0)
			if arg_214_0 == 1 then
				arg_212_0:Play319501052(arg_212_1)
			end
		end

		function arg_212_1.onSingleLineUpdate_(arg_215_0)
			local var_215_0 = 1.175

			if 0 < arg_212_1.time_ and arg_212_1.time_ <= 0 + arg_215_0 then
				arg_212_1.talkMaxDuration = 0
				arg_212_1.dialogCg_.alpha = 1

				arg_212_1.dialog_:SetActive(true)
				SetActive(arg_212_1.leftNameGo_, false)

				arg_212_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_212_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_212_1:RecordName(arg_212_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_212_1.iconTrs_.gameObject, false)
				arg_212_1.callingController_:SetSelectedState("normal")

				local var_215_1 = arg_212_1:FormatText(arg_212_1:GetWordFromCfg(319501051).content)

				arg_212_1.text_.text = var_215_1

				LuaForUtil.ClearLinePrefixSymbol(arg_212_1.text_)

				local var_215_3 = 47 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 47)

				if (47 <= 0 and var_215_0 or var_215_0 * (utf8.len(var_215_1) / 47)) > 0 and var_215_0 < var_215_3 then
					arg_212_1.talkMaxDuration = var_215_3

					if var_215_3 + 0 > arg_212_1.duration_ then
						arg_212_1.duration_ = var_215_3 + 0
					end
				end

				arg_212_1.text_.text = var_215_1
				arg_212_1.typewritter.percent = 0

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(false)
				arg_212_1:RecordContent(arg_212_1.text_.text)
			end

			local var_215_4 = math.max(var_215_0, arg_212_1.talkMaxDuration)

			if 0 <= arg_212_1.time_ and arg_212_1.time_ < 0 + var_215_4 then
				arg_212_1.typewritter.percent = (arg_212_1.time_ - 0) / var_215_4

				arg_212_1.typewritter:SetDirty()
			end

			if arg_212_1.time_ >= 0 + var_215_4 and arg_212_1.time_ < 0 + var_215_4 + arg_215_0 then
				arg_212_1.typewritter.percent = 1

				arg_212_1.typewritter:SetDirty()
				arg_212_1:ShowNextGo(true)
			end
		end

		arg_212_1.nodeConfigList_ = {}

		arg_212_1:InitPlayNodeList()
	end,
	Play319501052 = function(arg_216_0, arg_216_1)
		arg_216_1.time_ = 0
		arg_216_1.frameCnt_ = 0
		arg_216_1.state_ = "playing"
		arg_216_1.curTalkId_ = 319501052
		arg_216_1.duration_ = 5

		SetActive(arg_216_1.tipsGo_, false)

		function arg_216_1.onSingleLineFinish_()
			arg_216_1.onSingleLineUpdate_ = nil
			arg_216_1.onSingleLineFinish_ = nil
			arg_216_1.state_ = "waiting"
		end

		function arg_216_1.playNext_(arg_218_0)
			if arg_218_0 == 1 then
				arg_216_0:Play319501053(arg_216_1)
			end
		end

		function arg_216_1.onSingleLineUpdate_(arg_219_0)
			local var_219_0 = 1.425

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

				local var_219_1 = arg_216_1:FormatText(arg_216_1:GetWordFromCfg(319501052).content)

				arg_216_1.text_.text = var_219_1

				LuaForUtil.ClearLinePrefixSymbol(arg_216_1.text_)

				local var_219_3 = 57 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 57)

				if (57 <= 0 and var_219_0 or var_219_0 * (utf8.len(var_219_1) / 57)) > 0 and var_219_0 < var_219_3 then
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
	Play319501053 = function(arg_220_0, arg_220_1)
		arg_220_1.time_ = 0
		arg_220_1.frameCnt_ = 0
		arg_220_1.state_ = "playing"
		arg_220_1.curTalkId_ = 319501053
		arg_220_1.duration_ = 2.6

		local var_220_0 = {
			zh = 1.233,
			ja = 2.6
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
				arg_220_0:Play319501054(arg_220_1)
			end
		end

		function arg_220_1.onSingleLineUpdate_(arg_223_0)
			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1.var_.moveOldPos1084ui_story = arg_220_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_223_0 = 0.001

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_0 then
				arg_220_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_220_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_220_1.time_ - 0) / var_223_0)
				arg_220_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1084ui_story"].transform.position).z)
				arg_220_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1084ui_story"].transform.localEulerAngles = arg_220_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_220_1.time_ >= 0 + var_223_0 and arg_220_1.time_ < 0 + var_223_0 + arg_223_0 then
				arg_220_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_220_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_220_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_220_1.actors_["1084ui_story"].transform.position).z)
				arg_220_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_220_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_220_1.actors_["1084ui_story"].transform.localEulerAngles = arg_220_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_223_1 = arg_220_1.actors_["1084ui_story"]

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1084ui_story == nil then
				arg_220_1.var_.characterEffect1084ui_story = var_223_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_223_2 = 0.200000002980232

			if 0 <= arg_220_1.time_ and arg_220_1.time_ < 0 + var_223_2 and not isNil(var_223_1) then
				if arg_220_1.var_.characterEffect1084ui_story and not isNil(var_223_1) then
					arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_220_1.time_ >= 0 + var_223_2 and arg_220_1.time_ < 0 + var_223_2 + arg_223_0 and not isNil(var_223_1) and arg_220_1.var_.characterEffect1084ui_story then
				arg_220_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= 0 + arg_223_0 then
				arg_220_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_223_4 = 0
			local var_223_5 = 0.125

			if 0 < arg_220_1.time_ and arg_220_1.time_ <= var_223_4 + arg_223_0 then
				arg_220_1.talkMaxDuration = 0
				arg_220_1.dialogCg_.alpha = 1

				arg_220_1.dialog_:SetActive(true)
				SetActive(arg_220_1.leftNameGo_, true)

				arg_220_1.leftNameTxt_.text = arg_220_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_220_1.leftNameTxt_.transform)

				arg_220_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_220_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_220_1:RecordName(arg_220_1.leftNameTxt_.text)
				SetActive(arg_220_1.iconTrs_.gameObject, false)
				arg_220_1.callingController_:SetSelectedState("normal")

				local var_223_6 = arg_220_1:GetWordFromCfg(319501053)
				local var_223_7 = arg_220_1:FormatText(var_223_6.content)

				arg_220_1.text_.text = var_223_7

				LuaForUtil.ClearLinePrefixSymbol(arg_220_1.text_)

				local var_223_9 = 5 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 5)

				if (5 <= 0 and var_223_5 or var_223_5 * (utf8.len(var_223_7) / 5)) > 0 and var_223_5 < var_223_9 then
					arg_220_1.talkMaxDuration = var_223_9

					if var_223_9 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_9 + var_223_4
					end
				end

				arg_220_1.text_.text = var_223_7
				arg_220_1.typewritter.percent = 0

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501053", "story_v_out_319501.awb") ~= 0 then
					local var_223_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501053", "story_v_out_319501.awb") / 1000

					if var_223_10 + var_223_4 > arg_220_1.duration_ then
						arg_220_1.duration_ = var_223_10 + var_223_4
					end

					if var_223_6.prefab_name ~= "" and arg_220_1.actors_[var_223_6.prefab_name] ~= nil then
						local var_223_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_220_1.actors_[var_223_6.prefab_name].transform, "story_v_out_319501", "319501053", "story_v_out_319501.awb")

						arg_220_1:RecordAudio("319501053", var_223_11)
						arg_220_1:RecordAudio("319501053", var_223_11)
					else
						arg_220_1:AudioAction("play", "voice", "story_v_out_319501", "319501053", "story_v_out_319501.awb")
					end

					arg_220_1:RecordHistoryTalkVoice("story_v_out_319501", "319501053", "story_v_out_319501.awb")
				end

				arg_220_1:RecordContent(arg_220_1.text_.text)
			end

			local var_223_12 = math.max(var_223_5, arg_220_1.talkMaxDuration)

			if var_223_4 <= arg_220_1.time_ and arg_220_1.time_ < var_223_4 + var_223_12 then
				arg_220_1.typewritter.percent = (arg_220_1.time_ - var_223_4) / var_223_12

				arg_220_1.typewritter:SetDirty()
			end

			if arg_220_1.time_ >= var_223_4 + var_223_12 and arg_220_1.time_ < var_223_4 + var_223_12 + arg_223_0 then
				arg_220_1.typewritter.percent = 1

				arg_220_1.typewritter:SetDirty()
				arg_220_1:ShowNextGo(true)
			end
		end

		arg_220_1.nodeConfigList_ = {
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

		arg_220_1:InitPlayNodeList()
	end,
	Play319501054 = function(arg_224_0, arg_224_1)
		arg_224_1.time_ = 0
		arg_224_1.frameCnt_ = 0
		arg_224_1.state_ = "playing"
		arg_224_1.curTalkId_ = 319501054
		arg_224_1.duration_ = 2

		SetActive(arg_224_1.tipsGo_, false)

		function arg_224_1.onSingleLineFinish_()
			arg_224_1.onSingleLineUpdate_ = nil
			arg_224_1.onSingleLineFinish_ = nil
			arg_224_1.state_ = "waiting"
		end

		function arg_224_1.playNext_(arg_226_0)
			if arg_226_0 == 1 then
				arg_224_0:Play319501055(arg_224_1)
			end
		end

		function arg_224_1.onSingleLineUpdate_(arg_227_0)
			if arg_224_1.actors_["10068ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10068ui_story"))) then
				local var_227_0 = Object.Instantiate(Asset.Load("Char/" .. "10068ui_story"), arg_224_1.stage_.transform)

				var_227_0.name = "10068ui_story"
				var_227_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_224_1.actors_["10068ui_story"] = var_227_0

				local var_227_1 = var_227_0:GetComponentInChildren(typeof(CharacterEffect))

				var_227_1.enabled = true

				local var_227_2 = GameObjectTools.GetOrAddComponent(var_227_0, typeof(DynamicBoneHelper))

				if var_227_2 then
					var_227_2:EnableDynamicBone(false)
				end

				arg_224_1:ShowWeapon(var_227_1.transform, false)

				arg_224_1.var_["10068ui_story" .. "Animator"] = var_227_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_224_1.var_["10068ui_story" .. "Animator"].applyRootMotion = true
				arg_224_1.var_["10068ui_story" .. "LipSync"] = var_227_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_227_3 = arg_224_1.actors_["10068ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos10068ui_story = var_227_3.localPosition
			end

			local var_227_4 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_4 then
				var_227_3.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos10068ui_story, Vector3.New(0.7, -0.75, -6.18), (arg_224_1.time_ - 0) / var_227_4)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_4 and arg_224_1.time_ < 0 + var_227_4 + arg_227_0 then
				var_227_3.localPosition = Vector3.New(0.7, -0.75, -6.18)
				var_227_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_3.position).x, (manager.ui.mainCamera.transform.position - var_227_3.position).y, (manager.ui.mainCamera.transform.position - var_227_3.position).z)
				var_227_3.localEulerAngles.z = 0
				var_227_3.localEulerAngles.x = 0
				var_227_3.localEulerAngles = var_227_3.localEulerAngles
			end

			local var_227_5 = arg_224_1.actors_["10068ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect10068ui_story == nil then
				arg_224_1.var_.characterEffect10068ui_story = var_227_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_6 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_6 and not isNil(var_227_5) then
				if arg_224_1.var_.characterEffect10068ui_story and not isNil(var_227_5) then
					arg_224_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_224_1.time_ >= 0 + var_227_6 and arg_224_1.time_ < 0 + var_227_6 + arg_227_0 and not isNil(var_227_5) and arg_224_1.var_.characterEffect10068ui_story then
				arg_224_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_227_8 = arg_224_1.actors_["1084ui_story"].transform

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1.var_.moveOldPos1084ui_story = var_227_8.localPosition
			end

			local var_227_9 = 0.001

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_9 then
				var_227_8.localPosition = Vector3.Lerp(arg_224_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_224_1.time_ - 0) / var_227_9)
				var_227_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_8.position).x, (manager.ui.mainCamera.transform.position - var_227_8.position).y, (manager.ui.mainCamera.transform.position - var_227_8.position).z)
				var_227_8.localEulerAngles.z = 0
				var_227_8.localEulerAngles.x = 0
				var_227_8.localEulerAngles = var_227_8.localEulerAngles
			end

			if arg_224_1.time_ >= 0 + var_227_9 and arg_224_1.time_ < 0 + var_227_9 + arg_227_0 then
				var_227_8.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_227_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_227_8.position).x, (manager.ui.mainCamera.transform.position - var_227_8.position).y, (manager.ui.mainCamera.transform.position - var_227_8.position).z)
				var_227_8.localEulerAngles.z = 0
				var_227_8.localEulerAngles.x = 0
				var_227_8.localEulerAngles = var_227_8.localEulerAngles
			end

			local var_227_10 = arg_224_1.actors_["1084ui_story"]

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 and not isNil(var_227_10) and arg_224_1.var_.characterEffect1084ui_story == nil then
				arg_224_1.var_.characterEffect1084ui_story = var_227_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_227_11 = 0.200000002980232

			if 0 <= arg_224_1.time_ and arg_224_1.time_ < 0 + var_227_11 and not isNil(var_227_10) then
				if arg_224_1.var_.characterEffect1084ui_story and not isNil(var_227_10) then
					arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_224_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_224_1.time_ - 0) / var_227_11)
				end
			end

			if arg_224_1.time_ >= 0 + var_227_11 and arg_224_1.time_ < 0 + var_227_11 + arg_227_0 and not isNil(var_227_10) and arg_224_1.var_.characterEffect1084ui_story then
				arg_224_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_224_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= 0 + arg_227_0 then
				arg_224_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_227_14 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_224_1.bgmTxt_.text ~= var_227_14 and arg_224_1.bgmTxt_.text ~= "" then
						if arg_224_1.bgmTxt2_.text ~= "" then
							arg_224_1.bgmTxt_.text = arg_224_1.bgmTxt2_.text
						end

						arg_224_1.bgmTxt2_.text = var_227_14

						arg_224_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_224_1.bgmTxt_.text = var_227_14
						arg_224_1.bgmTxt2_.text = var_227_14
					end

					if arg_224_1.bgmTimer then
						arg_224_1.bgmTimer:Stop()

						arg_224_1.bgmTimer = nil
					end

					if arg_224_1.settingData.show_music_name == 1 then
						arg_224_1.musicController:SetSelectedState("show")
						arg_224_1.musicAnimator_:Play("open", 0, 0)

						if arg_224_1.settingData.music_time ~= 0 then
							arg_224_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_224_1.settingData.music_time), function()
								if arg_224_1 == nil or isNil(arg_224_1.bgmTxt_) then
									return
								end

								arg_224_1.musicController:SetSelectedState("hide")
								arg_224_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 0.1 < arg_224_1.time_ and arg_224_1.time_ <= 0.1 + arg_227_0 then
				arg_224_1:AudioAction("play", "music", "bgm_activity_3_0_story_theme_orgel", "bgm_activity_3_0_story_theme_orgel", "bgm_activity_3_0_story_theme_orgel.awb")

				local var_227_17 = manager.audio:GetAudioName("bgm_activity_3_0_story_theme_orgel", "bgm_activity_3_0_story_theme_orgel")

				if "" ~= "" then
					if arg_224_1.bgmTxt_.text ~= var_227_17 and arg_224_1.bgmTxt_.text ~= "" then
						if arg_224_1.bgmTxt2_.text ~= "" then
							arg_224_1.bgmTxt_.text = arg_224_1.bgmTxt2_.text
						end

						arg_224_1.bgmTxt2_.text = var_227_17

						arg_224_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_224_1.bgmTxt_.text = var_227_17
						arg_224_1.bgmTxt2_.text = var_227_17
					end

					if arg_224_1.bgmTimer then
						arg_224_1.bgmTimer:Stop()

						arg_224_1.bgmTimer = nil
					end

					if arg_224_1.settingData.show_music_name == 1 then
						arg_224_1.musicController:SetSelectedState("show")
						arg_224_1.musicAnimator_:Play("open", 0, 0)

						if arg_224_1.settingData.music_time ~= 0 then
							arg_224_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_224_1.settingData.music_time), function()
								if arg_224_1 == nil or isNil(arg_224_1.bgmTxt_) then
									return
								end

								arg_224_1.musicController:SetSelectedState("hide")
								arg_224_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_227_18 = 0
			local var_227_19 = 0.05

			if 0 < arg_224_1.time_ and arg_224_1.time_ <= var_227_18 + arg_227_0 then
				arg_224_1.talkMaxDuration = 0
				arg_224_1.dialogCg_.alpha = 1

				arg_224_1.dialog_:SetActive(true)
				SetActive(arg_224_1.leftNameGo_, true)

				arg_224_1.leftNameTxt_.text = arg_224_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_224_1.leftNameTxt_.transform)

				arg_224_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_224_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_224_1:RecordName(arg_224_1.leftNameTxt_.text)
				SetActive(arg_224_1.iconTrs_.gameObject, false)
				arg_224_1.callingController_:SetSelectedState("normal")

				local var_227_20 = arg_224_1:GetWordFromCfg(319501054)
				local var_227_21 = arg_224_1:FormatText(var_227_20.content)

				arg_224_1.text_.text = var_227_21

				LuaForUtil.ClearLinePrefixSymbol(arg_224_1.text_)

				local var_227_23 = 2 <= 0 and var_227_19 or var_227_19 * (utf8.len(var_227_21) / 2)

				if (2 <= 0 and var_227_19 or var_227_19 * (utf8.len(var_227_21) / 2)) > 0 and var_227_19 < var_227_23 then
					arg_224_1.talkMaxDuration = var_227_23

					if var_227_23 + var_227_18 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_23 + var_227_18
					end
				end

				arg_224_1.text_.text = var_227_21
				arg_224_1.typewritter.percent = 0

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501054", "story_v_out_319501.awb") ~= 0 then
					local var_227_24 = manager.audio:GetVoiceLength("story_v_out_319501", "319501054", "story_v_out_319501.awb") / 1000

					if var_227_24 + var_227_18 > arg_224_1.duration_ then
						arg_224_1.duration_ = var_227_24 + var_227_18
					end

					if var_227_20.prefab_name ~= "" and arg_224_1.actors_[var_227_20.prefab_name] ~= nil then
						local var_227_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_224_1.actors_[var_227_20.prefab_name].transform, "story_v_out_319501", "319501054", "story_v_out_319501.awb")

						arg_224_1:RecordAudio("319501054", var_227_25)
						arg_224_1:RecordAudio("319501054", var_227_25)
					else
						arg_224_1:AudioAction("play", "voice", "story_v_out_319501", "319501054", "story_v_out_319501.awb")
					end

					arg_224_1:RecordHistoryTalkVoice("story_v_out_319501", "319501054", "story_v_out_319501.awb")
				end

				arg_224_1:RecordContent(arg_224_1.text_.text)
			end

			local var_227_26 = math.max(var_227_19, arg_224_1.talkMaxDuration)

			if var_227_18 <= arg_224_1.time_ and arg_224_1.time_ < var_227_18 + var_227_26 then
				arg_224_1.typewritter.percent = (arg_224_1.time_ - var_227_18) / var_227_26

				arg_224_1.typewritter:SetDirty()
			end

			if arg_224_1.time_ >= var_227_18 + var_227_26 and arg_224_1.time_ < var_227_18 + var_227_26 + arg_227_0 then
				arg_224_1.typewritter.percent = 1

				arg_224_1.typewritter:SetDirty()
				arg_224_1:ShowNextGo(true)
			end
		end

		arg_224_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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

		arg_224_1:InitPlayNodeList()
	end,
	Play319501055 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 319501055
		arg_230_1.duration_ = 5.87

		local var_230_0 = {
			zh = 1.8,
			ja = 5.866
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
				arg_230_0:Play319501056(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.175

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, true)

				arg_230_1.leftNameTxt_.text = arg_230_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_230_1.leftNameTxt_.transform)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1.leftNameTxt_.text)
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:GetWordFromCfg(319501055)
				local var_233_2 = arg_230_1:FormatText(var_233_1.content)

				arg_230_1.text_.text = var_233_2

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_4 = 7 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 7)

				if (7 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_2) / 7)) > 0 and var_233_0 < var_233_4 then
					arg_230_1.talkMaxDuration = var_233_4

					if var_233_4 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_4 + 0
					end
				end

				arg_230_1.text_.text = var_233_2
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501055", "story_v_out_319501.awb") ~= 0 then
					local var_233_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501055", "story_v_out_319501.awb") / 1000

					if var_233_5 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_5 + 0
					end

					if var_233_1.prefab_name ~= "" and arg_230_1.actors_[var_233_1.prefab_name] ~= nil then
						local var_233_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_230_1.actors_[var_233_1.prefab_name].transform, "story_v_out_319501", "319501055", "story_v_out_319501.awb")

						arg_230_1:RecordAudio("319501055", var_233_6)
						arg_230_1:RecordAudio("319501055", var_233_6)
					else
						arg_230_1:AudioAction("play", "voice", "story_v_out_319501", "319501055", "story_v_out_319501.awb")
					end

					arg_230_1:RecordHistoryTalkVoice("story_v_out_319501", "319501055", "story_v_out_319501.awb")
				end

				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_7 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_7 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_7

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_7 and arg_230_1.time_ < 0 + var_233_7 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play319501056 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 319501056
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play319501057(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(arg_234_1.actors_["10068ui_story"]) and arg_234_1.var_.characterEffect10068ui_story == nil then
				arg_234_1.var_.characterEffect10068ui_story = arg_234_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_0 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_0 and not isNil(arg_234_1.actors_["10068ui_story"]) then
				if arg_234_1.var_.characterEffect10068ui_story and not isNil(arg_234_1.actors_["10068ui_story"]) then
					arg_234_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_234_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_234_1.time_ - 0) / var_237_0)
				end
			end

			if arg_234_1.time_ >= 0 + var_237_0 and arg_234_1.time_ < 0 + var_237_0 + arg_237_0 and not isNil(arg_234_1.actors_["10068ui_story"]) and arg_234_1.var_.characterEffect10068ui_story then
				arg_234_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_234_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_237_1 = 0
			local var_237_2 = 1.1

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_1 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, false)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_3 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(319501056).content)

				arg_234_1.text_.text = var_237_3

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_5 = 44 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 44)

				if (44 <= 0 and var_237_2 or var_237_2 * (utf8.len(var_237_3) / 44)) > 0 and var_237_2 < var_237_5 then
					arg_234_1.talkMaxDuration = var_237_5

					if var_237_5 + var_237_1 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_5 + var_237_1
					end
				end

				arg_234_1.text_.text = var_237_3
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_6 = math.max(var_237_2, arg_234_1.talkMaxDuration)

			if var_237_1 <= arg_234_1.time_ and arg_234_1.time_ < var_237_1 + var_237_6 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_1) / var_237_6

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_1 + var_237_6 and arg_234_1.time_ < var_237_1 + var_237_6 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {}

		arg_234_1:InitPlayNodeList()
	end,
	Play319501057 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 319501057
		arg_238_1.duration_ = 14.87

		local var_238_0 = {
			zh = 6.166,
			ja = 14.866
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
				arg_238_0:Play319501058(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1.var_.moveOldPos1084ui_story = arg_238_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_241_0 = 0.001

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 then
				arg_238_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_238_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_238_1.time_ - 0) / var_241_0)
				arg_238_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).z)
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles = arg_238_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 then
				arg_238_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_238_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_238_1.actors_["1084ui_story"].transform.position).z)
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_238_1.actors_["1084ui_story"].transform.localEulerAngles = arg_238_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_241_1 = arg_238_1.actors_["1084ui_story"]

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1084ui_story == nil then
				arg_238_1.var_.characterEffect1084ui_story = var_241_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_2 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_2 and not isNil(var_241_1) then
				if arg_238_1.var_.characterEffect1084ui_story and not isNil(var_241_1) then
					arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_238_1.time_ >= 0 + var_241_2 and arg_238_1.time_ < 0 + var_241_2 + arg_241_0 and not isNil(var_241_1) and arg_238_1.var_.characterEffect1084ui_story then
				arg_238_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 then
				arg_238_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_241_4 = 0
			local var_241_5 = 0.675

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_4 + arg_241_0 then
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

				local var_241_6 = arg_238_1:GetWordFromCfg(319501057)
				local var_241_7 = arg_238_1:FormatText(var_241_6.content)

				arg_238_1.text_.text = var_241_7

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_9 = 27 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 27)

				if (27 <= 0 and var_241_5 or var_241_5 * (utf8.len(var_241_7) / 27)) > 0 and var_241_5 < var_241_9 then
					arg_238_1.talkMaxDuration = var_241_9

					if var_241_9 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_9 + var_241_4
					end
				end

				arg_238_1.text_.text = var_241_7
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501057", "story_v_out_319501.awb") ~= 0 then
					local var_241_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501057", "story_v_out_319501.awb") / 1000

					if var_241_10 + var_241_4 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_10 + var_241_4
					end

					if var_241_6.prefab_name ~= "" and arg_238_1.actors_[var_241_6.prefab_name] ~= nil then
						local var_241_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_238_1.actors_[var_241_6.prefab_name].transform, "story_v_out_319501", "319501057", "story_v_out_319501.awb")

						arg_238_1:RecordAudio("319501057", var_241_11)
						arg_238_1:RecordAudio("319501057", var_241_11)
					else
						arg_238_1:AudioAction("play", "voice", "story_v_out_319501", "319501057", "story_v_out_319501.awb")
					end

					arg_238_1:RecordHistoryTalkVoice("story_v_out_319501", "319501057", "story_v_out_319501.awb")
				end

				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_12 = math.max(var_241_5, arg_238_1.talkMaxDuration)

			if var_241_4 <= arg_238_1.time_ and arg_238_1.time_ < var_241_4 + var_241_12 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_4) / var_241_12

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_4 + var_241_12 and arg_238_1.time_ < var_241_4 + var_241_12 + arg_241_0 then
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
			}
		}

		arg_238_1:InitPlayNodeList()
	end,
	Play319501058 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 319501058
		arg_242_1.duration_ = 4.77

		local var_242_0 = {
			zh = 1.866,
			ja = 4.766
		}
		local var_242_1 = manager.audio:GetLocalizationFlag()

		if var_242_0[var_242_1] ~= nil then
			arg_242_1.duration_ = var_242_0[var_242_1]
		end

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play319501059(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			local var_245_0 = 0.225

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_1 = arg_242_1:GetWordFromCfg(319501058)
				local var_245_2 = arg_242_1:FormatText(var_245_1.content)

				arg_242_1.text_.text = var_245_2

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_4 = 9 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 9)

				if (9 <= 0 and var_245_0 or var_245_0 * (utf8.len(var_245_2) / 9)) > 0 and var_245_0 < var_245_4 then
					arg_242_1.talkMaxDuration = var_245_4

					if var_245_4 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_4 + 0
					end
				end

				arg_242_1.text_.text = var_245_2
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501058", "story_v_out_319501.awb") ~= 0 then
					local var_245_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501058", "story_v_out_319501.awb") / 1000

					if var_245_5 + 0 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_5 + 0
					end

					if var_245_1.prefab_name ~= "" and arg_242_1.actors_[var_245_1.prefab_name] ~= nil then
						local var_245_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_242_1.actors_[var_245_1.prefab_name].transform, "story_v_out_319501", "319501058", "story_v_out_319501.awb")

						arg_242_1:RecordAudio("319501058", var_245_6)
						arg_242_1:RecordAudio("319501058", var_245_6)
					else
						arg_242_1:AudioAction("play", "voice", "story_v_out_319501", "319501058", "story_v_out_319501.awb")
					end

					arg_242_1:RecordHistoryTalkVoice("story_v_out_319501", "319501058", "story_v_out_319501.awb")
				end

				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_7 = math.max(var_245_0, arg_242_1.talkMaxDuration)

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_7 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - 0) / var_245_7

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= 0 + var_245_7 and arg_242_1.time_ < 0 + var_245_7 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {}

		arg_242_1:InitPlayNodeList()
	end,
	Play319501059 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 319501059
		arg_246_1.duration_ = 5

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play319501060(arg_246_1)
			end
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1084ui_story"]) and arg_246_1.var_.characterEffect1084ui_story == nil then
				arg_246_1.var_.characterEffect1084ui_story = arg_246_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1084ui_story"]) then
				if arg_246_1.var_.characterEffect1084ui_story and not isNil(arg_246_1.actors_["1084ui_story"]) then
					arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1084ui_story"]) and arg_246_1.var_.characterEffect1084ui_story then
				arg_246_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0
			local var_249_2 = 1.1

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.talkMaxDuration = 0
				arg_246_1.dialogCg_.alpha = 1

				arg_246_1.dialog_:SetActive(true)
				SetActive(arg_246_1.leftNameGo_, false)

				arg_246_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_246_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_246_1:RecordName(arg_246_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_246_1.iconTrs_.gameObject, false)
				arg_246_1.callingController_:SetSelectedState("normal")

				local var_249_3 = arg_246_1:FormatText(arg_246_1:GetWordFromCfg(319501059).content)

				arg_246_1.text_.text = var_249_3

				LuaForUtil.ClearLinePrefixSymbol(arg_246_1.text_)

				local var_249_5 = 51 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 51)

				if (51 <= 0 and var_249_2 or var_249_2 * (utf8.len(var_249_3) / 51)) > 0 and var_249_2 < var_249_5 then
					arg_246_1.talkMaxDuration = var_249_5

					if var_249_5 + var_249_1 > arg_246_1.duration_ then
						arg_246_1.duration_ = var_249_5 + var_249_1
					end
				end

				arg_246_1.text_.text = var_249_3
				arg_246_1.typewritter.percent = 0

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(false)
				arg_246_1:RecordContent(arg_246_1.text_.text)
			end

			local var_249_6 = math.max(var_249_2, arg_246_1.talkMaxDuration)

			if var_249_1 <= arg_246_1.time_ and arg_246_1.time_ < var_249_1 + var_249_6 then
				arg_246_1.typewritter.percent = (arg_246_1.time_ - var_249_1) / var_249_6

				arg_246_1.typewritter:SetDirty()
			end

			if arg_246_1.time_ >= var_249_1 + var_249_6 and arg_246_1.time_ < var_249_1 + var_249_6 + arg_249_0 then
				arg_246_1.typewritter.percent = 1

				arg_246_1.typewritter:SetDirty()
				arg_246_1:ShowNextGo(true)
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play319501060 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 319501060
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play319501061(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			local var_253_0 = 0.775

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_1 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(319501060).content)

				arg_250_1.text_.text = var_253_1

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_3 = 31 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 31)

				if (31 <= 0 and var_253_0 or var_253_0 * (utf8.len(var_253_1) / 31)) > 0 and var_253_0 < var_253_3 then
					arg_250_1.talkMaxDuration = var_253_3

					if var_253_3 + 0 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_3 + 0
					end
				end

				arg_250_1.text_.text = var_253_1
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_4 = math.max(var_253_0, arg_250_1.talkMaxDuration)

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_4 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - 0) / var_253_4

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= 0 + var_253_4 and arg_250_1.time_ < 0 + var_253_4 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {}

		arg_250_1:InitPlayNodeList()
	end,
	Play319501061 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 319501061
		arg_254_1.duration_ = 2.5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play319501062(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(arg_254_1.actors_["10068ui_story"]) and arg_254_1.var_.characterEffect10068ui_story == nil then
				arg_254_1.var_.characterEffect10068ui_story = arg_254_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_0 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 and not isNil(arg_254_1.actors_["10068ui_story"]) then
				if arg_254_1.var_.characterEffect10068ui_story and not isNil(arg_254_1.actors_["10068ui_story"]) then
					arg_254_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 and not isNil(arg_254_1.actors_["10068ui_story"]) and arg_254_1.var_.characterEffect10068ui_story then
				arg_254_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_2")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_257_2 = 0
			local var_257_3 = 0.125

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_2 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_4 = arg_254_1:GetWordFromCfg(319501061)
				local var_257_5 = arg_254_1:FormatText(var_257_4.content)

				arg_254_1.text_.text = var_257_5

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_7 = 5 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 5)

				if (5 <= 0 and var_257_3 or var_257_3 * (utf8.len(var_257_5) / 5)) > 0 and var_257_3 < var_257_7 then
					arg_254_1.talkMaxDuration = var_257_7

					if var_257_7 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_7 + var_257_2
					end
				end

				arg_254_1.text_.text = var_257_5
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501061", "story_v_out_319501.awb") ~= 0 then
					local var_257_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501061", "story_v_out_319501.awb") / 1000

					if var_257_8 + var_257_2 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_2
					end

					if var_257_4.prefab_name ~= "" and arg_254_1.actors_[var_257_4.prefab_name] ~= nil then
						local var_257_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_254_1.actors_[var_257_4.prefab_name].transform, "story_v_out_319501", "319501061", "story_v_out_319501.awb")

						arg_254_1:RecordAudio("319501061", var_257_9)
						arg_254_1:RecordAudio("319501061", var_257_9)
					else
						arg_254_1:AudioAction("play", "voice", "story_v_out_319501", "319501061", "story_v_out_319501.awb")
					end

					arg_254_1:RecordHistoryTalkVoice("story_v_out_319501", "319501061", "story_v_out_319501.awb")
				end

				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_10 = math.max(var_257_3, arg_254_1.talkMaxDuration)

			if var_257_2 <= arg_254_1.time_ and arg_254_1.time_ < var_257_2 + var_257_10 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_2) / var_257_10

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_2 + var_257_10 and arg_254_1.time_ < var_257_2 + var_257_10 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {}

		arg_254_1:InitPlayNodeList()
	end,
	Play319501062 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 319501062
		arg_258_1.duration_ = 5.93

		local var_258_0 = {
			zh = 3.4,
			ja = 5.933
		}
		local var_258_1 = manager.audio:GetLocalizationFlag()

		if var_258_0[var_258_1] ~= nil then
			arg_258_1.duration_ = var_258_0[var_258_1]
		end

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play319501063(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(arg_258_1.actors_["10068ui_story"]) and arg_258_1.var_.characterEffect10068ui_story == nil then
				arg_258_1.var_.characterEffect10068ui_story = arg_258_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_0 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_0 and not isNil(arg_258_1.actors_["10068ui_story"]) then
				if arg_258_1.var_.characterEffect10068ui_story and not isNil(arg_258_1.actors_["10068ui_story"]) then
					arg_258_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_258_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_0)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_0 and arg_258_1.time_ < 0 + var_261_0 + arg_261_0 and not isNil(arg_258_1.actors_["10068ui_story"]) and arg_258_1.var_.characterEffect10068ui_story then
				arg_258_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_258_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_261_1 = arg_258_1.actors_["1084ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1084ui_story == nil then
				arg_258_1.var_.characterEffect1084ui_story = var_261_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_2 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_2 and not isNil(var_261_1) then
				if arg_258_1.var_.characterEffect1084ui_story and not isNil(var_261_1) then
					arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_2 and arg_258_1.time_ < 0 + var_261_2 + arg_261_0 and not isNil(var_261_1) and arg_258_1.var_.characterEffect1084ui_story then
				arg_258_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_261_4 = 0
			local var_261_5 = 0.35

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_4 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_6 = arg_258_1:GetWordFromCfg(319501062)
				local var_261_7 = arg_258_1:FormatText(var_261_6.content)

				arg_258_1.text_.text = var_261_7

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_9 = 14 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 14)

				if (14 <= 0 and var_261_5 or var_261_5 * (utf8.len(var_261_7) / 14)) > 0 and var_261_5 < var_261_9 then
					arg_258_1.talkMaxDuration = var_261_9

					if var_261_9 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_9 + var_261_4
					end
				end

				arg_258_1.text_.text = var_261_7
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501062", "story_v_out_319501.awb") ~= 0 then
					local var_261_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501062", "story_v_out_319501.awb") / 1000

					if var_261_10 + var_261_4 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_10 + var_261_4
					end

					if var_261_6.prefab_name ~= "" and arg_258_1.actors_[var_261_6.prefab_name] ~= nil then
						local var_261_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_258_1.actors_[var_261_6.prefab_name].transform, "story_v_out_319501", "319501062", "story_v_out_319501.awb")

						arg_258_1:RecordAudio("319501062", var_261_11)
						arg_258_1:RecordAudio("319501062", var_261_11)
					else
						arg_258_1:AudioAction("play", "voice", "story_v_out_319501", "319501062", "story_v_out_319501.awb")
					end

					arg_258_1:RecordHistoryTalkVoice("story_v_out_319501", "319501062", "story_v_out_319501.awb")
				end

				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_12 = math.max(var_261_5, arg_258_1.talkMaxDuration)

			if var_261_4 <= arg_258_1.time_ and arg_258_1.time_ < var_261_4 + var_261_12 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_4) / var_261_12

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_4 + var_261_12 and arg_258_1.time_ < var_261_4 + var_261_12 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {}

		arg_258_1:InitPlayNodeList()
	end,
	Play319501063 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 319501063
		arg_262_1.duration_ = 4.1

		local var_262_0 = {
			zh = 2.8,
			ja = 4.1
		}
		local var_262_1 = manager.audio:GetLocalizationFlag()

		if var_262_0[var_262_1] ~= nil then
			arg_262_1.duration_ = var_262_0[var_262_1]
		end

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play319501064(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(arg_262_1.actors_["10068ui_story"]) and arg_262_1.var_.characterEffect10068ui_story == nil then
				arg_262_1.var_.characterEffect10068ui_story = arg_262_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_0 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_0 and not isNil(arg_262_1.actors_["10068ui_story"]) then
				if arg_262_1.var_.characterEffect10068ui_story and not isNil(arg_262_1.actors_["10068ui_story"]) then
					arg_262_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_262_1.time_ >= 0 + var_265_0 and arg_262_1.time_ < 0 + var_265_0 + arg_265_0 and not isNil(arg_262_1.actors_["10068ui_story"]) and arg_262_1.var_.characterEffect10068ui_story then
				arg_262_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_265_2 = arg_262_1.actors_["1084ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect1084ui_story == nil then
				arg_262_1.var_.characterEffect1084ui_story = var_265_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_3 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_3 and not isNil(var_265_2) then
				if arg_262_1.var_.characterEffect1084ui_story and not isNil(var_265_2) then
					arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_262_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_3)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_3 and arg_262_1.time_ < 0 + var_265_3 + arg_265_0 and not isNil(var_265_2) and arg_262_1.var_.characterEffect1084ui_story then
				arg_262_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_262_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_265_4 = 0
			local var_265_5 = 0.2

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_4 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, true)

				arg_262_1.leftNameTxt_.text = arg_262_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_262_1.leftNameTxt_.transform)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1.leftNameTxt_.text)
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_6 = arg_262_1:GetWordFromCfg(319501063)
				local var_265_7 = arg_262_1:FormatText(var_265_6.content)

				arg_262_1.text_.text = var_265_7

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_9 = 8 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 8)

				if (8 <= 0 and var_265_5 or var_265_5 * (utf8.len(var_265_7) / 8)) > 0 and var_265_5 < var_265_9 then
					arg_262_1.talkMaxDuration = var_265_9

					if var_265_9 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_9 + var_265_4
					end
				end

				arg_262_1.text_.text = var_265_7
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501063", "story_v_out_319501.awb") ~= 0 then
					local var_265_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501063", "story_v_out_319501.awb") / 1000

					if var_265_10 + var_265_4 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_10 + var_265_4
					end

					if var_265_6.prefab_name ~= "" and arg_262_1.actors_[var_265_6.prefab_name] ~= nil then
						local var_265_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_262_1.actors_[var_265_6.prefab_name].transform, "story_v_out_319501", "319501063", "story_v_out_319501.awb")

						arg_262_1:RecordAudio("319501063", var_265_11)
						arg_262_1:RecordAudio("319501063", var_265_11)
					else
						arg_262_1:AudioAction("play", "voice", "story_v_out_319501", "319501063", "story_v_out_319501.awb")
					end

					arg_262_1:RecordHistoryTalkVoice("story_v_out_319501", "319501063", "story_v_out_319501.awb")
				end

				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_5, arg_262_1.talkMaxDuration)

			if var_265_4 <= arg_262_1.time_ and arg_262_1.time_ < var_265_4 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_4) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_4 + var_265_12 and arg_262_1.time_ < var_265_4 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {}

		arg_262_1:InitPlayNodeList()
	end,
	Play319501064 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 319501064
		arg_266_1.duration_ = 14.67

		local var_266_0 = {
			zh = 8.266,
			ja = 14.666
		}
		local var_266_1 = manager.audio:GetLocalizationFlag()

		if var_266_0[var_266_1] ~= nil then
			arg_266_1.duration_ = var_266_0[var_266_1]
		end

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play319501065(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(arg_266_1.actors_["10068ui_story"]) and arg_266_1.var_.characterEffect10068ui_story == nil then
				arg_266_1.var_.characterEffect10068ui_story = arg_266_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_0 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_0 and not isNil(arg_266_1.actors_["10068ui_story"]) then
				if arg_266_1.var_.characterEffect10068ui_story and not isNil(arg_266_1.actors_["10068ui_story"]) then
					arg_266_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_266_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_266_1.time_ - 0) / var_269_0)
				end
			end

			if arg_266_1.time_ >= 0 + var_269_0 and arg_266_1.time_ < 0 + var_269_0 + arg_269_0 and not isNil(arg_266_1.actors_["10068ui_story"]) and arg_266_1.var_.characterEffect10068ui_story then
				arg_266_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_266_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_269_1 = arg_266_1.actors_["1084ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1084ui_story == nil then
				arg_266_1.var_.characterEffect1084ui_story = var_269_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_2 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_2 and not isNil(var_269_1) then
				if arg_266_1.var_.characterEffect1084ui_story and not isNil(var_269_1) then
					arg_266_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_2 and arg_266_1.time_ < 0 + var_269_2 + arg_269_0 and not isNil(var_269_1) and arg_266_1.var_.characterEffect1084ui_story then
				arg_266_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_269_4 = 0
			local var_269_5 = 1.025

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_4 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_6 = arg_266_1:GetWordFromCfg(319501064)
				local var_269_7 = arg_266_1:FormatText(var_269_6.content)

				arg_266_1.text_.text = var_269_7

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_9 = 41 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 41)

				if (41 <= 0 and var_269_5 or var_269_5 * (utf8.len(var_269_7) / 41)) > 0 and var_269_5 < var_269_9 then
					arg_266_1.talkMaxDuration = var_269_9

					if var_269_9 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_9 + var_269_4
					end
				end

				arg_266_1.text_.text = var_269_7
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501064", "story_v_out_319501.awb") ~= 0 then
					local var_269_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501064", "story_v_out_319501.awb") / 1000

					if var_269_10 + var_269_4 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_4
					end

					if var_269_6.prefab_name ~= "" and arg_266_1.actors_[var_269_6.prefab_name] ~= nil then
						local var_269_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_266_1.actors_[var_269_6.prefab_name].transform, "story_v_out_319501", "319501064", "story_v_out_319501.awb")

						arg_266_1:RecordAudio("319501064", var_269_11)
						arg_266_1:RecordAudio("319501064", var_269_11)
					else
						arg_266_1:AudioAction("play", "voice", "story_v_out_319501", "319501064", "story_v_out_319501.awb")
					end

					arg_266_1:RecordHistoryTalkVoice("story_v_out_319501", "319501064", "story_v_out_319501.awb")
				end

				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_12 = math.max(var_269_5, arg_266_1.talkMaxDuration)

			if var_269_4 <= arg_266_1.time_ and arg_266_1.time_ < var_269_4 + var_269_12 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_4) / var_269_12

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_4 + var_269_12 and arg_266_1.time_ < var_269_4 + var_269_12 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {}

		arg_266_1:InitPlayNodeList()
	end,
	Play319501065 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 319501065
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play319501066(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(arg_270_1.actors_["1084ui_story"]) and arg_270_1.var_.characterEffect1084ui_story == nil then
				arg_270_1.var_.characterEffect1084ui_story = arg_270_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_0 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_0 and not isNil(arg_270_1.actors_["1084ui_story"]) then
				if arg_270_1.var_.characterEffect1084ui_story and not isNil(arg_270_1.actors_["1084ui_story"]) then
					arg_270_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_0)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_0 and arg_270_1.time_ < 0 + var_273_0 + arg_273_0 and not isNil(arg_270_1.actors_["1084ui_story"]) and arg_270_1.var_.characterEffect1084ui_story then
				arg_270_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_273_1 = 0
			local var_273_2 = 1.75

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_1 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, false)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_3 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(319501065).content)

				arg_270_1.text_.text = var_273_3

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_5 = 69 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 69)

				if (69 <= 0 and var_273_2 or var_273_2 * (utf8.len(var_273_3) / 69)) > 0 and var_273_2 < var_273_5 then
					arg_270_1.talkMaxDuration = var_273_5

					if var_273_5 + var_273_1 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_5 + var_273_1
					end
				end

				arg_270_1.text_.text = var_273_3
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_6 = math.max(var_273_2, arg_270_1.talkMaxDuration)

			if var_273_1 <= arg_270_1.time_ and arg_270_1.time_ < var_273_1 + var_273_6 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_1) / var_273_6

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_1 + var_273_6 and arg_270_1.time_ < var_273_1 + var_273_6 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {}

		arg_270_1:InitPlayNodeList()
	end,
	Play319501066 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 319501066
		arg_274_1.duration_ = 14.77

		local var_274_0 = {
			zh = 6.966,
			ja = 14.766
		}
		local var_274_1 = manager.audio:GetLocalizationFlag()

		if var_274_0[var_274_1] ~= nil then
			arg_274_1.duration_ = var_274_0[var_274_1]
		end

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play319501067(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(arg_274_1.actors_["1084ui_story"]) and arg_274_1.var_.characterEffect1084ui_story == nil then
				arg_274_1.var_.characterEffect1084ui_story = arg_274_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_0 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 and not isNil(arg_274_1.actors_["1084ui_story"]) then
				if arg_274_1.var_.characterEffect1084ui_story and not isNil(arg_274_1.actors_["1084ui_story"]) then
					arg_274_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 and not isNil(arg_274_1.actors_["1084ui_story"]) and arg_274_1.var_.characterEffect1084ui_story then
				arg_274_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_277_2 = 0
			local var_277_3 = 0.825

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_2 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, true)

				arg_274_1.leftNameTxt_.text = arg_274_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_274_1.leftNameTxt_.transform)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1.leftNameTxt_.text)
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_4 = arg_274_1:GetWordFromCfg(319501066)
				local var_277_5 = arg_274_1:FormatText(var_277_4.content)

				arg_274_1.text_.text = var_277_5

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_7 = 33 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 33)

				if (33 <= 0 and var_277_3 or var_277_3 * (utf8.len(var_277_5) / 33)) > 0 and var_277_3 < var_277_7 then
					arg_274_1.talkMaxDuration = var_277_7

					if var_277_7 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_7 + var_277_2
					end
				end

				arg_274_1.text_.text = var_277_5
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501066", "story_v_out_319501.awb") ~= 0 then
					local var_277_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501066", "story_v_out_319501.awb") / 1000

					if var_277_8 + var_277_2 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_8 + var_277_2
					end

					if var_277_4.prefab_name ~= "" and arg_274_1.actors_[var_277_4.prefab_name] ~= nil then
						local var_277_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_274_1.actors_[var_277_4.prefab_name].transform, "story_v_out_319501", "319501066", "story_v_out_319501.awb")

						arg_274_1:RecordAudio("319501066", var_277_9)
						arg_274_1:RecordAudio("319501066", var_277_9)
					else
						arg_274_1:AudioAction("play", "voice", "story_v_out_319501", "319501066", "story_v_out_319501.awb")
					end

					arg_274_1:RecordHistoryTalkVoice("story_v_out_319501", "319501066", "story_v_out_319501.awb")
				end

				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_10 = math.max(var_277_3, arg_274_1.talkMaxDuration)

			if var_277_2 <= arg_274_1.time_ and arg_274_1.time_ < var_277_2 + var_277_10 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_2) / var_277_10

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_2 + var_277_10 and arg_274_1.time_ < var_277_2 + var_277_10 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {}

		arg_274_1:InitPlayNodeList()
	end,
	Play319501067 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 319501067
		arg_278_1.duration_ = 10.2

		local var_278_0 = {
			zh = 3.633,
			ja = 10.2
		}
		local var_278_1 = manager.audio:GetLocalizationFlag()

		if var_278_0[var_278_1] ~= nil then
			arg_278_1.duration_ = var_278_0[var_278_1]
		end

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play319501068(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_281_0 = 0
			local var_281_1 = 0.425

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_0 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_2 = arg_278_1:GetWordFromCfg(319501067)
				local var_281_3 = arg_278_1:FormatText(var_281_2.content)

				arg_278_1.text_.text = var_281_3

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_5 = 17 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 17)

				if (17 <= 0 and var_281_1 or var_281_1 * (utf8.len(var_281_3) / 17)) > 0 and var_281_1 < var_281_5 then
					arg_278_1.talkMaxDuration = var_281_5

					if var_281_5 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_5 + var_281_0
					end
				end

				arg_278_1.text_.text = var_281_3
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501067", "story_v_out_319501.awb") ~= 0 then
					local var_281_6 = manager.audio:GetVoiceLength("story_v_out_319501", "319501067", "story_v_out_319501.awb") / 1000

					if var_281_6 + var_281_0 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_6 + var_281_0
					end

					if var_281_2.prefab_name ~= "" and arg_278_1.actors_[var_281_2.prefab_name] ~= nil then
						local var_281_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_278_1.actors_[var_281_2.prefab_name].transform, "story_v_out_319501", "319501067", "story_v_out_319501.awb")

						arg_278_1:RecordAudio("319501067", var_281_7)
						arg_278_1:RecordAudio("319501067", var_281_7)
					else
						arg_278_1:AudioAction("play", "voice", "story_v_out_319501", "319501067", "story_v_out_319501.awb")
					end

					arg_278_1:RecordHistoryTalkVoice("story_v_out_319501", "319501067", "story_v_out_319501.awb")
				end

				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_8 = math.max(var_281_1, arg_278_1.talkMaxDuration)

			if var_281_0 <= arg_278_1.time_ and arg_278_1.time_ < var_281_0 + var_281_8 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_0) / var_281_8

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_0 + var_281_8 and arg_278_1.time_ < var_281_0 + var_281_8 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {}

		arg_278_1:InitPlayNodeList()
	end,
	Play319501068 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 319501068
		arg_282_1.duration_ = 2

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play319501069(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(arg_282_1.actors_["10068ui_story"]) and arg_282_1.var_.characterEffect10068ui_story == nil then
				arg_282_1.var_.characterEffect10068ui_story = arg_282_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_0 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 and not isNil(arg_282_1.actors_["10068ui_story"]) then
				if arg_282_1.var_.characterEffect10068ui_story and not isNil(arg_282_1.actors_["10068ui_story"]) then
					arg_282_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 and not isNil(arg_282_1.actors_["10068ui_story"]) and arg_282_1.var_.characterEffect10068ui_story then
				arg_282_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action4_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_285_2 = arg_282_1.actors_["1084ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.characterEffect1084ui_story == nil then
				arg_282_1.var_.characterEffect1084ui_story = var_285_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_3 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_3 and not isNil(var_285_2) then
				if arg_282_1.var_.characterEffect1084ui_story and not isNil(var_285_2) then
					arg_282_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_282_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_3)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_3 and arg_282_1.time_ < 0 + var_285_3 + arg_285_0 and not isNil(var_285_2) and arg_282_1.var_.characterEffect1084ui_story then
				arg_282_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_282_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_285_4 = 0
			local var_285_5 = 0.2

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_4 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_6 = arg_282_1:GetWordFromCfg(319501068)
				local var_285_7 = arg_282_1:FormatText(var_285_6.content)

				arg_282_1.text_.text = var_285_7

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_9 = 8 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 8)

				if (8 <= 0 and var_285_5 or var_285_5 * (utf8.len(var_285_7) / 8)) > 0 and var_285_5 < var_285_9 then
					arg_282_1.talkMaxDuration = var_285_9

					if var_285_9 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_9 + var_285_4
					end
				end

				arg_282_1.text_.text = var_285_7
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501068", "story_v_out_319501.awb") ~= 0 then
					local var_285_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501068", "story_v_out_319501.awb") / 1000

					if var_285_10 + var_285_4 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_4
					end

					if var_285_6.prefab_name ~= "" and arg_282_1.actors_[var_285_6.prefab_name] ~= nil then
						local var_285_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_282_1.actors_[var_285_6.prefab_name].transform, "story_v_out_319501", "319501068", "story_v_out_319501.awb")

						arg_282_1:RecordAudio("319501068", var_285_11)
						arg_282_1:RecordAudio("319501068", var_285_11)
					else
						arg_282_1:AudioAction("play", "voice", "story_v_out_319501", "319501068", "story_v_out_319501.awb")
					end

					arg_282_1:RecordHistoryTalkVoice("story_v_out_319501", "319501068", "story_v_out_319501.awb")
				end

				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_12 = math.max(var_285_5, arg_282_1.talkMaxDuration)

			if var_285_4 <= arg_282_1.time_ and arg_282_1.time_ < var_285_4 + var_285_12 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_4) / var_285_12

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_4 + var_285_12 and arg_282_1.time_ < var_285_4 + var_285_12 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {}

		arg_282_1:InitPlayNodeList()
	end,
	Play319501069 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 319501069
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play319501070(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(arg_286_1.actors_["10068ui_story"]) and arg_286_1.var_.characterEffect10068ui_story == nil then
				arg_286_1.var_.characterEffect10068ui_story = arg_286_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_0 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_0 and not isNil(arg_286_1.actors_["10068ui_story"]) then
				if arg_286_1.var_.characterEffect10068ui_story and not isNil(arg_286_1.actors_["10068ui_story"]) then
					arg_286_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_286_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_0)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_0 and arg_286_1.time_ < 0 + var_289_0 + arg_289_0 and not isNil(arg_286_1.actors_["10068ui_story"]) and arg_286_1.var_.characterEffect10068ui_story then
				arg_286_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_286_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_289_1 = 0
			local var_289_2 = 1.475

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_1 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, false)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_3 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(319501069).content)

				arg_286_1.text_.text = var_289_3

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_5 = 59 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 59)

				if (59 <= 0 and var_289_2 or var_289_2 * (utf8.len(var_289_3) / 59)) > 0 and var_289_2 < var_289_5 then
					arg_286_1.talkMaxDuration = var_289_5

					if var_289_5 + var_289_1 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_5 + var_289_1
					end
				end

				arg_286_1.text_.text = var_289_3
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_6 = math.max(var_289_2, arg_286_1.talkMaxDuration)

			if var_289_1 <= arg_286_1.time_ and arg_286_1.time_ < var_289_1 + var_289_6 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_1) / var_289_6

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_1 + var_289_6 and arg_286_1.time_ < var_289_1 + var_289_6 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {}

		arg_286_1:InitPlayNodeList()
	end,
	Play319501070 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 319501070
		arg_290_1.duration_ = 8.17

		local var_290_0 = {
			zh = 3.7,
			ja = 8.166
		}
		local var_290_1 = manager.audio:GetLocalizationFlag()

		if var_290_0[var_290_1] ~= nil then
			arg_290_1.duration_ = var_290_0[var_290_1]
		end

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play319501071(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(arg_290_1.actors_["1084ui_story"]) and arg_290_1.var_.characterEffect1084ui_story == nil then
				arg_290_1.var_.characterEffect1084ui_story = arg_290_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_0 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 and not isNil(arg_290_1.actors_["1084ui_story"]) then
				if arg_290_1.var_.characterEffect1084ui_story and not isNil(arg_290_1.actors_["1084ui_story"]) then
					arg_290_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 and not isNil(arg_290_1.actors_["1084ui_story"]) and arg_290_1.var_.characterEffect1084ui_story then
				arg_290_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_2")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_293_2 = 0
			local var_293_3 = 0.5

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_2 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_4 = arg_290_1:GetWordFromCfg(319501070)
				local var_293_5 = arg_290_1:FormatText(var_293_4.content)

				arg_290_1.text_.text = var_293_5

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_7 = 20 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 20)

				if (20 <= 0 and var_293_3 or var_293_3 * (utf8.len(var_293_5) / 20)) > 0 and var_293_3 < var_293_7 then
					arg_290_1.talkMaxDuration = var_293_7

					if var_293_7 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_7 + var_293_2
					end
				end

				arg_290_1.text_.text = var_293_5
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501070", "story_v_out_319501.awb") ~= 0 then
					local var_293_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501070", "story_v_out_319501.awb") / 1000

					if var_293_8 + var_293_2 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_8 + var_293_2
					end

					if var_293_4.prefab_name ~= "" and arg_290_1.actors_[var_293_4.prefab_name] ~= nil then
						local var_293_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_290_1.actors_[var_293_4.prefab_name].transform, "story_v_out_319501", "319501070", "story_v_out_319501.awb")

						arg_290_1:RecordAudio("319501070", var_293_9)
						arg_290_1:RecordAudio("319501070", var_293_9)
					else
						arg_290_1:AudioAction("play", "voice", "story_v_out_319501", "319501070", "story_v_out_319501.awb")
					end

					arg_290_1:RecordHistoryTalkVoice("story_v_out_319501", "319501070", "story_v_out_319501.awb")
				end

				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_10 = math.max(var_293_3, arg_290_1.talkMaxDuration)

			if var_293_2 <= arg_290_1.time_ and arg_290_1.time_ < var_293_2 + var_293_10 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_2) / var_293_10

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_2 + var_293_10 and arg_290_1.time_ < var_293_2 + var_293_10 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {}

		arg_290_1:InitPlayNodeList()
	end,
	Play319501071 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 319501071
		arg_294_1.duration_ = 6.2

		local var_294_0 = {
			zh = 4.433,
			ja = 6.2
		}
		local var_294_1 = manager.audio:GetLocalizationFlag()

		if var_294_0[var_294_1] ~= nil then
			arg_294_1.duration_ = var_294_0[var_294_1]
		end

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play319501072(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1.var_.moveOldPos10068ui_story = arg_294_1.actors_["10068ui_story"].transform.localPosition
			end

			local var_297_0 = 0.001

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 then
				arg_294_1.actors_["10068ui_story"].transform.localPosition = Vector3.Lerp(arg_294_1.var_.moveOldPos10068ui_story, Vector3.New(0.7, -0.75, -6.18), (arg_294_1.time_ - 0) / var_297_0)
				arg_294_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10068ui_story"].transform.position).z)
				arg_294_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["10068ui_story"].transform.localEulerAngles = arg_294_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 then
				arg_294_1.actors_["10068ui_story"].transform.localPosition = Vector3.New(0.7, -0.75, -6.18)
				arg_294_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_294_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_294_1.actors_["10068ui_story"].transform.position).z)
				arg_294_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_294_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_294_1.actors_["10068ui_story"].transform.localEulerAngles = arg_294_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			local var_297_1 = arg_294_1.actors_["10068ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect10068ui_story == nil then
				arg_294_1.var_.characterEffect10068ui_story = var_297_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_2 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_2 and not isNil(var_297_1) then
				if arg_294_1.var_.characterEffect10068ui_story and not isNil(var_297_1) then
					arg_294_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_294_1.time_ >= 0 + var_297_2 and arg_294_1.time_ < 0 + var_297_2 + arg_297_0 and not isNil(var_297_1) and arg_294_1.var_.characterEffect10068ui_story then
				arg_294_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 then
				arg_294_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_297_4 = arg_294_1.actors_["1084ui_story"]

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(var_297_4) and arg_294_1.var_.characterEffect1084ui_story == nil then
				arg_294_1.var_.characterEffect1084ui_story = var_297_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_5 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_5 and not isNil(var_297_4) then
				if arg_294_1.var_.characterEffect1084ui_story and not isNil(var_297_4) then
					arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_5)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_5 and arg_294_1.time_ < 0 + var_297_5 + arg_297_0 and not isNil(var_297_4) and arg_294_1.var_.characterEffect1084ui_story then
				arg_294_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_297_6 = 0
			local var_297_7 = 0.45

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_6 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, false)
				arg_294_1.callingController_:SetSelectedState("normal")

				local var_297_8 = arg_294_1:GetWordFromCfg(319501071)
				local var_297_9 = arg_294_1:FormatText(var_297_8.content)

				arg_294_1.text_.text = var_297_9

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_11 = 18 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_9) / 18)

				if (18 <= 0 and var_297_7 or var_297_7 * (utf8.len(var_297_9) / 18)) > 0 and var_297_7 < var_297_11 then
					arg_294_1.talkMaxDuration = var_297_11

					if var_297_11 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_11 + var_297_6
					end
				end

				arg_294_1.text_.text = var_297_9
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501071", "story_v_out_319501.awb") ~= 0 then
					local var_297_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501071", "story_v_out_319501.awb") / 1000

					if var_297_12 + var_297_6 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_12 + var_297_6
					end

					if var_297_8.prefab_name ~= "" and arg_294_1.actors_[var_297_8.prefab_name] ~= nil then
						local var_297_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_294_1.actors_[var_297_8.prefab_name].transform, "story_v_out_319501", "319501071", "story_v_out_319501.awb")

						arg_294_1:RecordAudio("319501071", var_297_13)
						arg_294_1:RecordAudio("319501071", var_297_13)
					else
						arg_294_1:AudioAction("play", "voice", "story_v_out_319501", "319501071", "story_v_out_319501.awb")
					end

					arg_294_1:RecordHistoryTalkVoice("story_v_out_319501", "319501071", "story_v_out_319501.awb")
				end

				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_14 = math.max(var_297_7, arg_294_1.talkMaxDuration)

			if var_297_6 <= arg_294_1.time_ and arg_294_1.time_ < var_297_6 + var_297_14 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_6) / var_297_14

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_6 + var_297_14 and arg_294_1.time_ < var_297_6 + var_297_14 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_294_1:InitPlayNodeList()
	end,
	Play319501072 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 319501072
		arg_298_1.duration_ = 3.67

		local var_298_0 = {
			zh = 2.5,
			ja = 3.666
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
				arg_298_0:Play319501073(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			local var_301_0 = 0.3

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_1 = arg_298_1:GetWordFromCfg(319501072)
				local var_301_2 = arg_298_1:FormatText(var_301_1.content)

				arg_298_1.text_.text = var_301_2

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_4 = 12 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 12)

				if (12 <= 0 and var_301_0 or var_301_0 * (utf8.len(var_301_2) / 12)) > 0 and var_301_0 < var_301_4 then
					arg_298_1.talkMaxDuration = var_301_4

					if var_301_4 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_4 + 0
					end
				end

				arg_298_1.text_.text = var_301_2
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501072", "story_v_out_319501.awb") ~= 0 then
					local var_301_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501072", "story_v_out_319501.awb") / 1000

					if var_301_5 + 0 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_5 + 0
					end

					if var_301_1.prefab_name ~= "" and arg_298_1.actors_[var_301_1.prefab_name] ~= nil then
						local var_301_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_298_1.actors_[var_301_1.prefab_name].transform, "story_v_out_319501", "319501072", "story_v_out_319501.awb")

						arg_298_1:RecordAudio("319501072", var_301_6)
						arg_298_1:RecordAudio("319501072", var_301_6)
					else
						arg_298_1:AudioAction("play", "voice", "story_v_out_319501", "319501072", "story_v_out_319501.awb")
					end

					arg_298_1:RecordHistoryTalkVoice("story_v_out_319501", "319501072", "story_v_out_319501.awb")
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
	Play319501073 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 319501073
		arg_302_1.duration_ = 14.17

		local var_302_0 = {
			zh = 8.033,
			ja = 14.166
		}
		local var_302_1 = manager.audio:GetLocalizationFlag()

		if var_302_0[var_302_1] ~= nil then
			arg_302_1.duration_ = var_302_0[var_302_1]
		end

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play319501074(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1084ui_story = arg_302_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_305_0 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_0 then
				arg_302_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_302_1.time_ - 0) / var_305_0)
				arg_302_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1084ui_story"].transform.position).z)
				arg_302_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1084ui_story"].transform.localEulerAngles = arg_302_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_0 and arg_302_1.time_ < 0 + var_305_0 + arg_305_0 then
				arg_302_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_302_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_302_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_302_1.actors_["1084ui_story"].transform.position).z)
				arg_302_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_302_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_302_1.actors_["1084ui_story"].transform.localEulerAngles = arg_302_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_305_1 = arg_302_1.actors_["1084ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1084ui_story == nil then
				arg_302_1.var_.characterEffect1084ui_story = var_305_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_2 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_2 and not isNil(var_305_1) then
				if arg_302_1.var_.characterEffect1084ui_story and not isNil(var_305_1) then
					arg_302_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_2 and arg_302_1.time_ < 0 + var_305_2 + arg_305_0 and not isNil(var_305_1) and arg_302_1.var_.characterEffect1084ui_story then
				arg_302_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_305_4 = arg_302_1.actors_["10068ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_4) and arg_302_1.var_.characterEffect10068ui_story == nil then
				arg_302_1.var_.characterEffect10068ui_story = var_305_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_5 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_5 and not isNil(var_305_4) then
				if arg_302_1.var_.characterEffect10068ui_story and not isNil(var_305_4) then
					arg_302_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_302_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_302_1.time_ - 0) / var_305_5)
				end
			end

			if arg_302_1.time_ >= 0 + var_305_5 and arg_302_1.time_ < 0 + var_305_5 + arg_305_0 and not isNil(var_305_4) and arg_302_1.var_.characterEffect10068ui_story then
				arg_302_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_302_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_305_6 = 0
			local var_305_7 = 1.025

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_6 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_8 = arg_302_1:GetWordFromCfg(319501073)
				local var_305_9 = arg_302_1:FormatText(var_305_8.content)

				arg_302_1.text_.text = var_305_9

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_11 = 41 <= 0 and var_305_7 or var_305_7 * (utf8.len(var_305_9) / 41)

				if (41 <= 0 and var_305_7 or var_305_7 * (utf8.len(var_305_9) / 41)) > 0 and var_305_7 < var_305_11 then
					arg_302_1.talkMaxDuration = var_305_11

					if var_305_11 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_11 + var_305_6
					end
				end

				arg_302_1.text_.text = var_305_9
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501073", "story_v_out_319501.awb") ~= 0 then
					local var_305_12 = manager.audio:GetVoiceLength("story_v_out_319501", "319501073", "story_v_out_319501.awb") / 1000

					if var_305_12 + var_305_6 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_12 + var_305_6
					end

					if var_305_8.prefab_name ~= "" and arg_302_1.actors_[var_305_8.prefab_name] ~= nil then
						local var_305_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_302_1.actors_[var_305_8.prefab_name].transform, "story_v_out_319501", "319501073", "story_v_out_319501.awb")

						arg_302_1:RecordAudio("319501073", var_305_13)
						arg_302_1:RecordAudio("319501073", var_305_13)
					else
						arg_302_1:AudioAction("play", "voice", "story_v_out_319501", "319501073", "story_v_out_319501.awb")
					end

					arg_302_1:RecordHistoryTalkVoice("story_v_out_319501", "319501073", "story_v_out_319501.awb")
				end

				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_14 = math.max(var_305_7, arg_302_1.talkMaxDuration)

			if var_305_6 <= arg_302_1.time_ and arg_302_1.time_ < var_305_6 + var_305_14 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_6) / var_305_14

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_6 + var_305_14 and arg_302_1.time_ < var_305_6 + var_305_14 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
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

		arg_302_1:InitPlayNodeList()
	end,
	Play319501074 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 319501074
		arg_306_1.duration_ = 6.67

		local var_306_0 = {
			zh = 3.266,
			ja = 6.666
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
				arg_306_0:Play319501075(arg_306_1)
			end
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["10068ui_story"]) and arg_306_1.var_.characterEffect10068ui_story == nil then
				arg_306_1.var_.characterEffect10068ui_story = arg_306_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["10068ui_story"]) then
				if arg_306_1.var_.characterEffect10068ui_story and not isNil(arg_306_1.actors_["10068ui_story"]) then
					arg_306_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["10068ui_story"]) and arg_306_1.var_.characterEffect10068ui_story then
				arg_306_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 then
				arg_306_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_309_2 = arg_306_1.actors_["1084ui_story"]

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.characterEffect1084ui_story == nil then
				arg_306_1.var_.characterEffect1084ui_story = var_309_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_3 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_3 and not isNil(var_309_2) then
				if arg_306_1.var_.characterEffect1084ui_story and not isNil(var_309_2) then
					arg_306_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_3)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_3 and arg_306_1.time_ < 0 + var_309_3 + arg_309_0 and not isNil(var_309_2) and arg_306_1.var_.characterEffect1084ui_story then
				arg_306_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_309_4 = 0
			local var_309_5 = 0.325

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_4 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, false)
				arg_306_1.callingController_:SetSelectedState("normal")

				local var_309_6 = arg_306_1:GetWordFromCfg(319501074)
				local var_309_7 = arg_306_1:FormatText(var_309_6.content)

				arg_306_1.text_.text = var_309_7

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_9 = 13 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 13)

				if (13 <= 0 and var_309_5 or var_309_5 * (utf8.len(var_309_7) / 13)) > 0 and var_309_5 < var_309_9 then
					arg_306_1.talkMaxDuration = var_309_9

					if var_309_9 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_9 + var_309_4
					end
				end

				arg_306_1.text_.text = var_309_7
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501074", "story_v_out_319501.awb") ~= 0 then
					local var_309_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501074", "story_v_out_319501.awb") / 1000

					if var_309_10 + var_309_4 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_10 + var_309_4
					end

					if var_309_6.prefab_name ~= "" and arg_306_1.actors_[var_309_6.prefab_name] ~= nil then
						local var_309_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_306_1.actors_[var_309_6.prefab_name].transform, "story_v_out_319501", "319501074", "story_v_out_319501.awb")

						arg_306_1:RecordAudio("319501074", var_309_11)
						arg_306_1:RecordAudio("319501074", var_309_11)
					else
						arg_306_1:AudioAction("play", "voice", "story_v_out_319501", "319501074", "story_v_out_319501.awb")
					end

					arg_306_1:RecordHistoryTalkVoice("story_v_out_319501", "319501074", "story_v_out_319501.awb")
				end

				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_12 = math.max(var_309_5, arg_306_1.talkMaxDuration)

			if var_309_4 <= arg_306_1.time_ and arg_306_1.time_ < var_309_4 + var_309_12 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_4) / var_309_12

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_4 + var_309_12 and arg_306_1.time_ < var_309_4 + var_309_12 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	Play319501075 = function(arg_310_0, arg_310_1)
		arg_310_1.time_ = 0
		arg_310_1.frameCnt_ = 0
		arg_310_1.state_ = "playing"
		arg_310_1.curTalkId_ = 319501075
		arg_310_1.duration_ = 9.93

		local var_310_0 = {
			zh = 5.733,
			ja = 9.933
		}
		local var_310_1 = manager.audio:GetLocalizationFlag()

		if var_310_0[var_310_1] ~= nil then
			arg_310_1.duration_ = var_310_0[var_310_1]
		end

		SetActive(arg_310_1.tipsGo_, false)

		function arg_310_1.onSingleLineFinish_()
			arg_310_1.onSingleLineUpdate_ = nil
			arg_310_1.onSingleLineFinish_ = nil
			arg_310_1.state_ = "waiting"
		end

		function arg_310_1.playNext_(arg_312_0)
			if arg_312_0 == 1 then
				arg_310_0:Play319501076(arg_310_1)
			end
		end

		function arg_310_1.onSingleLineUpdate_(arg_313_0)
			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(arg_310_1.actors_["10068ui_story"]) and arg_310_1.var_.characterEffect10068ui_story == nil then
				arg_310_1.var_.characterEffect10068ui_story = arg_310_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_0 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_0 and not isNil(arg_310_1.actors_["10068ui_story"]) then
				if arg_310_1.var_.characterEffect10068ui_story and not isNil(arg_310_1.actors_["10068ui_story"]) then
					arg_310_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_310_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_310_1.time_ - 0) / var_313_0)
				end
			end

			if arg_310_1.time_ >= 0 + var_313_0 and arg_310_1.time_ < 0 + var_313_0 + arg_313_0 and not isNil(arg_310_1.actors_["10068ui_story"]) and arg_310_1.var_.characterEffect10068ui_story then
				arg_310_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_310_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_313_1 = arg_310_1.actors_["1084ui_story"]

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= 0 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1084ui_story == nil then
				arg_310_1.var_.characterEffect1084ui_story = var_313_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_313_2 = 0.200000002980232

			if 0 <= arg_310_1.time_ and arg_310_1.time_ < 0 + var_313_2 and not isNil(var_313_1) then
				if arg_310_1.var_.characterEffect1084ui_story and not isNil(var_313_1) then
					arg_310_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_310_1.time_ >= 0 + var_313_2 and arg_310_1.time_ < 0 + var_313_2 + arg_313_0 and not isNil(var_313_1) and arg_310_1.var_.characterEffect1084ui_story then
				arg_310_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_313_4 = 0
			local var_313_5 = 0.7

			if 0 < arg_310_1.time_ and arg_310_1.time_ <= var_313_4 + arg_313_0 then
				arg_310_1.talkMaxDuration = 0
				arg_310_1.dialogCg_.alpha = 1

				arg_310_1.dialog_:SetActive(true)
				SetActive(arg_310_1.leftNameGo_, true)

				arg_310_1.leftNameTxt_.text = arg_310_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_310_1.leftNameTxt_.transform)

				arg_310_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_310_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_310_1:RecordName(arg_310_1.leftNameTxt_.text)
				SetActive(arg_310_1.iconTrs_.gameObject, false)
				arg_310_1.callingController_:SetSelectedState("normal")

				local var_313_6 = arg_310_1:GetWordFromCfg(319501075)
				local var_313_7 = arg_310_1:FormatText(var_313_6.content)

				arg_310_1.text_.text = var_313_7

				LuaForUtil.ClearLinePrefixSymbol(arg_310_1.text_)

				local var_313_9 = 28 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 28)

				if (28 <= 0 and var_313_5 or var_313_5 * (utf8.len(var_313_7) / 28)) > 0 and var_313_5 < var_313_9 then
					arg_310_1.talkMaxDuration = var_313_9

					if var_313_9 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_9 + var_313_4
					end
				end

				arg_310_1.text_.text = var_313_7
				arg_310_1.typewritter.percent = 0

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501075", "story_v_out_319501.awb") ~= 0 then
					local var_313_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501075", "story_v_out_319501.awb") / 1000

					if var_313_10 + var_313_4 > arg_310_1.duration_ then
						arg_310_1.duration_ = var_313_10 + var_313_4
					end

					if var_313_6.prefab_name ~= "" and arg_310_1.actors_[var_313_6.prefab_name] ~= nil then
						local var_313_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_310_1.actors_[var_313_6.prefab_name].transform, "story_v_out_319501", "319501075", "story_v_out_319501.awb")

						arg_310_1:RecordAudio("319501075", var_313_11)
						arg_310_1:RecordAudio("319501075", var_313_11)
					else
						arg_310_1:AudioAction("play", "voice", "story_v_out_319501", "319501075", "story_v_out_319501.awb")
					end

					arg_310_1:RecordHistoryTalkVoice("story_v_out_319501", "319501075", "story_v_out_319501.awb")
				end

				arg_310_1:RecordContent(arg_310_1.text_.text)
			end

			local var_313_12 = math.max(var_313_5, arg_310_1.talkMaxDuration)

			if var_313_4 <= arg_310_1.time_ and arg_310_1.time_ < var_313_4 + var_313_12 then
				arg_310_1.typewritter.percent = (arg_310_1.time_ - var_313_4) / var_313_12

				arg_310_1.typewritter:SetDirty()
			end

			if arg_310_1.time_ >= var_313_4 + var_313_12 and arg_310_1.time_ < var_313_4 + var_313_12 + arg_313_0 then
				arg_310_1.typewritter.percent = 1

				arg_310_1.typewritter:SetDirty()
				arg_310_1:ShowNextGo(true)
			end
		end

		arg_310_1.nodeConfigList_ = {}

		arg_310_1:InitPlayNodeList()
	end,
	Play319501076 = function(arg_314_0, arg_314_1)
		arg_314_1.time_ = 0
		arg_314_1.frameCnt_ = 0
		arg_314_1.state_ = "playing"
		arg_314_1.curTalkId_ = 319501076
		arg_314_1.duration_ = 2.27

		local var_314_0 = {
			zh = 1.6,
			ja = 2.266
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
				arg_314_0:Play319501077(arg_314_1)
			end
		end

		function arg_314_1.onSingleLineUpdate_(arg_317_0)
			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(arg_314_1.actors_["10068ui_story"]) and arg_314_1.var_.characterEffect10068ui_story == nil then
				arg_314_1.var_.characterEffect10068ui_story = arg_314_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_0 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_0 and not isNil(arg_314_1.actors_["10068ui_story"]) then
				if arg_314_1.var_.characterEffect10068ui_story and not isNil(arg_314_1.actors_["10068ui_story"]) then
					arg_314_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_314_1.time_ >= 0 + var_317_0 and arg_314_1.time_ < 0 + var_317_0 + arg_317_0 and not isNil(arg_314_1.actors_["10068ui_story"]) and arg_314_1.var_.characterEffect10068ui_story then
				arg_314_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_317_2 = arg_314_1.actors_["1084ui_story"]

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= 0 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect1084ui_story == nil then
				arg_314_1.var_.characterEffect1084ui_story = var_317_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_317_3 = 0.200000002980232

			if 0 <= arg_314_1.time_ and arg_314_1.time_ < 0 + var_317_3 and not isNil(var_317_2) then
				if arg_314_1.var_.characterEffect1084ui_story and not isNil(var_317_2) then
					arg_314_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_314_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_314_1.time_ - 0) / var_317_3)
				end
			end

			if arg_314_1.time_ >= 0 + var_317_3 and arg_314_1.time_ < 0 + var_317_3 + arg_317_0 and not isNil(var_317_2) and arg_314_1.var_.characterEffect1084ui_story then
				arg_314_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_314_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_317_4 = 0
			local var_317_5 = 0.1

			if 0 < arg_314_1.time_ and arg_314_1.time_ <= var_317_4 + arg_317_0 then
				arg_314_1.talkMaxDuration = 0
				arg_314_1.dialogCg_.alpha = 1

				arg_314_1.dialog_:SetActive(true)
				SetActive(arg_314_1.leftNameGo_, true)

				arg_314_1.leftNameTxt_.text = arg_314_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_314_1.leftNameTxt_.transform)

				arg_314_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_314_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_314_1:RecordName(arg_314_1.leftNameTxt_.text)
				SetActive(arg_314_1.iconTrs_.gameObject, false)
				arg_314_1.callingController_:SetSelectedState("normal")

				local var_317_6 = arg_314_1:GetWordFromCfg(319501076)
				local var_317_7 = arg_314_1:FormatText(var_317_6.content)

				arg_314_1.text_.text = var_317_7

				LuaForUtil.ClearLinePrefixSymbol(arg_314_1.text_)

				local var_317_9 = 4 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 4)

				if (4 <= 0 and var_317_5 or var_317_5 * (utf8.len(var_317_7) / 4)) > 0 and var_317_5 < var_317_9 then
					arg_314_1.talkMaxDuration = var_317_9

					if var_317_9 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_9 + var_317_4
					end
				end

				arg_314_1.text_.text = var_317_7
				arg_314_1.typewritter.percent = 0

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501076", "story_v_out_319501.awb") ~= 0 then
					local var_317_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501076", "story_v_out_319501.awb") / 1000

					if var_317_10 + var_317_4 > arg_314_1.duration_ then
						arg_314_1.duration_ = var_317_10 + var_317_4
					end

					if var_317_6.prefab_name ~= "" and arg_314_1.actors_[var_317_6.prefab_name] ~= nil then
						local var_317_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_314_1.actors_[var_317_6.prefab_name].transform, "story_v_out_319501", "319501076", "story_v_out_319501.awb")

						arg_314_1:RecordAudio("319501076", var_317_11)
						arg_314_1:RecordAudio("319501076", var_317_11)
					else
						arg_314_1:AudioAction("play", "voice", "story_v_out_319501", "319501076", "story_v_out_319501.awb")
					end

					arg_314_1:RecordHistoryTalkVoice("story_v_out_319501", "319501076", "story_v_out_319501.awb")
				end

				arg_314_1:RecordContent(arg_314_1.text_.text)
			end

			local var_317_12 = math.max(var_317_5, arg_314_1.talkMaxDuration)

			if var_317_4 <= arg_314_1.time_ and arg_314_1.time_ < var_317_4 + var_317_12 then
				arg_314_1.typewritter.percent = (arg_314_1.time_ - var_317_4) / var_317_12

				arg_314_1.typewritter:SetDirty()
			end

			if arg_314_1.time_ >= var_317_4 + var_317_12 and arg_314_1.time_ < var_317_4 + var_317_12 + arg_317_0 then
				arg_314_1.typewritter.percent = 1

				arg_314_1.typewritter:SetDirty()
				arg_314_1:ShowNextGo(true)
			end
		end

		arg_314_1.nodeConfigList_ = {}

		arg_314_1:InitPlayNodeList()
	end,
	Play319501077 = function(arg_318_0, arg_318_1)
		arg_318_1.time_ = 0
		arg_318_1.frameCnt_ = 0
		arg_318_1.state_ = "playing"
		arg_318_1.curTalkId_ = 319501077
		arg_318_1.duration_ = 5

		SetActive(arg_318_1.tipsGo_, false)

		function arg_318_1.onSingleLineFinish_()
			arg_318_1.onSingleLineUpdate_ = nil
			arg_318_1.onSingleLineFinish_ = nil
			arg_318_1.state_ = "waiting"
		end

		function arg_318_1.playNext_(arg_320_0)
			if arg_320_0 == 1 then
				arg_318_0:Play319501078(arg_318_1)
			end
		end

		function arg_318_1.onSingleLineUpdate_(arg_321_0)
			if 0 < arg_318_1.time_ and arg_318_1.time_ <= 0 + arg_321_0 and not isNil(arg_318_1.actors_["10068ui_story"]) and arg_318_1.var_.characterEffect10068ui_story == nil then
				arg_318_1.var_.characterEffect10068ui_story = arg_318_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_321_0 = 0.200000002980232

			if 0 <= arg_318_1.time_ and arg_318_1.time_ < 0 + var_321_0 and not isNil(arg_318_1.actors_["10068ui_story"]) then
				if arg_318_1.var_.characterEffect10068ui_story and not isNil(arg_318_1.actors_["10068ui_story"]) then
					arg_318_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_318_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_318_1.time_ - 0) / var_321_0)
				end
			end

			if arg_318_1.time_ >= 0 + var_321_0 and arg_318_1.time_ < 0 + var_321_0 + arg_321_0 and not isNil(arg_318_1.actors_["10068ui_story"]) and arg_318_1.var_.characterEffect10068ui_story then
				arg_318_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_318_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_321_1 = 0
			local var_321_2 = 1.05

			if 0 < arg_318_1.time_ and arg_318_1.time_ <= var_321_1 + arg_321_0 then
				arg_318_1.talkMaxDuration = 0
				arg_318_1.dialogCg_.alpha = 1

				arg_318_1.dialog_:SetActive(true)
				SetActive(arg_318_1.leftNameGo_, false)

				arg_318_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_318_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_318_1:RecordName(arg_318_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_318_1.iconTrs_.gameObject, false)
				arg_318_1.callingController_:SetSelectedState("normal")

				local var_321_3 = arg_318_1:FormatText(arg_318_1:GetWordFromCfg(319501077).content)

				arg_318_1.text_.text = var_321_3

				LuaForUtil.ClearLinePrefixSymbol(arg_318_1.text_)

				local var_321_5 = 42 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 42)

				if (42 <= 0 and var_321_2 or var_321_2 * (utf8.len(var_321_3) / 42)) > 0 and var_321_2 < var_321_5 then
					arg_318_1.talkMaxDuration = var_321_5

					if var_321_5 + var_321_1 > arg_318_1.duration_ then
						arg_318_1.duration_ = var_321_5 + var_321_1
					end
				end

				arg_318_1.text_.text = var_321_3
				arg_318_1.typewritter.percent = 0

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(false)
				arg_318_1:RecordContent(arg_318_1.text_.text)
			end

			local var_321_6 = math.max(var_321_2, arg_318_1.talkMaxDuration)

			if var_321_1 <= arg_318_1.time_ and arg_318_1.time_ < var_321_1 + var_321_6 then
				arg_318_1.typewritter.percent = (arg_318_1.time_ - var_321_1) / var_321_6

				arg_318_1.typewritter:SetDirty()
			end

			if arg_318_1.time_ >= var_321_1 + var_321_6 and arg_318_1.time_ < var_321_1 + var_321_6 + arg_321_0 then
				arg_318_1.typewritter.percent = 1

				arg_318_1.typewritter:SetDirty()
				arg_318_1:ShowNextGo(true)
			end
		end

		arg_318_1.nodeConfigList_ = {}

		arg_318_1:InitPlayNodeList()
	end,
	Play319501078 = function(arg_322_0, arg_322_1)
		arg_322_1.time_ = 0
		arg_322_1.frameCnt_ = 0
		arg_322_1.state_ = "playing"
		arg_322_1.curTalkId_ = 319501078
		arg_322_1.duration_ = 5

		SetActive(arg_322_1.tipsGo_, false)

		function arg_322_1.onSingleLineFinish_()
			arg_322_1.onSingleLineUpdate_ = nil
			arg_322_1.onSingleLineFinish_ = nil
			arg_322_1.state_ = "waiting"
		end

		function arg_322_1.playNext_(arg_324_0)
			if arg_324_0 == 1 then
				arg_322_0:Play319501079(arg_322_1)
			end
		end

		function arg_322_1.onSingleLineUpdate_(arg_325_0)
			local var_325_0 = 1.125

			if 0 < arg_322_1.time_ and arg_322_1.time_ <= 0 + arg_325_0 then
				arg_322_1.talkMaxDuration = 0
				arg_322_1.dialogCg_.alpha = 1

				arg_322_1.dialog_:SetActive(true)
				SetActive(arg_322_1.leftNameGo_, false)

				arg_322_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_322_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_322_1:RecordName(arg_322_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_322_1.iconTrs_.gameObject, false)
				arg_322_1.callingController_:SetSelectedState("normal")

				local var_325_1 = arg_322_1:FormatText(arg_322_1:GetWordFromCfg(319501078).content)

				arg_322_1.text_.text = var_325_1

				LuaForUtil.ClearLinePrefixSymbol(arg_322_1.text_)

				local var_325_3 = 45 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 45)

				if (45 <= 0 and var_325_0 or var_325_0 * (utf8.len(var_325_1) / 45)) > 0 and var_325_0 < var_325_3 then
					arg_322_1.talkMaxDuration = var_325_3

					if var_325_3 + 0 > arg_322_1.duration_ then
						arg_322_1.duration_ = var_325_3 + 0
					end
				end

				arg_322_1.text_.text = var_325_1
				arg_322_1.typewritter.percent = 0

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(false)
				arg_322_1:RecordContent(arg_322_1.text_.text)
			end

			local var_325_4 = math.max(var_325_0, arg_322_1.talkMaxDuration)

			if 0 <= arg_322_1.time_ and arg_322_1.time_ < 0 + var_325_4 then
				arg_322_1.typewritter.percent = (arg_322_1.time_ - 0) / var_325_4

				arg_322_1.typewritter:SetDirty()
			end

			if arg_322_1.time_ >= 0 + var_325_4 and arg_322_1.time_ < 0 + var_325_4 + arg_325_0 then
				arg_322_1.typewritter.percent = 1

				arg_322_1.typewritter:SetDirty()
				arg_322_1:ShowNextGo(true)
			end
		end

		arg_322_1.nodeConfigList_ = {}

		arg_322_1:InitPlayNodeList()
	end,
	Play319501079 = function(arg_326_0, arg_326_1)
		arg_326_1.time_ = 0
		arg_326_1.frameCnt_ = 0
		arg_326_1.state_ = "playing"
		arg_326_1.curTalkId_ = 319501079
		arg_326_1.duration_ = 5

		SetActive(arg_326_1.tipsGo_, false)

		function arg_326_1.onSingleLineFinish_()
			arg_326_1.onSingleLineUpdate_ = nil
			arg_326_1.onSingleLineFinish_ = nil
			arg_326_1.state_ = "waiting"
		end

		function arg_326_1.playNext_(arg_328_0)
			if arg_328_0 == 1 then
				arg_326_0:Play319501080(arg_326_1)
			end
		end

		function arg_326_1.onSingleLineUpdate_(arg_329_0)
			local var_329_0 = 0.925

			if 0 < arg_326_1.time_ and arg_326_1.time_ <= 0 + arg_329_0 then
				arg_326_1.talkMaxDuration = 0
				arg_326_1.dialogCg_.alpha = 1

				arg_326_1.dialog_:SetActive(true)
				SetActive(arg_326_1.leftNameGo_, false)

				arg_326_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_326_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_326_1:RecordName(arg_326_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_326_1.iconTrs_.gameObject, false)
				arg_326_1.callingController_:SetSelectedState("normal")

				local var_329_1 = arg_326_1:FormatText(arg_326_1:GetWordFromCfg(319501079).content)

				arg_326_1.text_.text = var_329_1

				LuaForUtil.ClearLinePrefixSymbol(arg_326_1.text_)

				local var_329_3 = 37 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 37)

				if (37 <= 0 and var_329_0 or var_329_0 * (utf8.len(var_329_1) / 37)) > 0 and var_329_0 < var_329_3 then
					arg_326_1.talkMaxDuration = var_329_3

					if var_329_3 + 0 > arg_326_1.duration_ then
						arg_326_1.duration_ = var_329_3 + 0
					end
				end

				arg_326_1.text_.text = var_329_1
				arg_326_1.typewritter.percent = 0

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(false)
				arg_326_1:RecordContent(arg_326_1.text_.text)
			end

			local var_329_4 = math.max(var_329_0, arg_326_1.talkMaxDuration)

			if 0 <= arg_326_1.time_ and arg_326_1.time_ < 0 + var_329_4 then
				arg_326_1.typewritter.percent = (arg_326_1.time_ - 0) / var_329_4

				arg_326_1.typewritter:SetDirty()
			end

			if arg_326_1.time_ >= 0 + var_329_4 and arg_326_1.time_ < 0 + var_329_4 + arg_329_0 then
				arg_326_1.typewritter.percent = 1

				arg_326_1.typewritter:SetDirty()
				arg_326_1:ShowNextGo(true)
			end
		end

		arg_326_1.nodeConfigList_ = {}

		arg_326_1:InitPlayNodeList()
	end,
	Play319501080 = function(arg_330_0, arg_330_1)
		arg_330_1.time_ = 0
		arg_330_1.frameCnt_ = 0
		arg_330_1.state_ = "playing"
		arg_330_1.curTalkId_ = 319501080
		arg_330_1.duration_ = 5

		SetActive(arg_330_1.tipsGo_, false)

		function arg_330_1.onSingleLineFinish_()
			arg_330_1.onSingleLineUpdate_ = nil
			arg_330_1.onSingleLineFinish_ = nil
			arg_330_1.state_ = "waiting"
		end

		function arg_330_1.playNext_(arg_332_0)
			if arg_332_0 == 1 then
				arg_330_0:Play319501081(arg_330_1)
			end
		end

		function arg_330_1.onSingleLineUpdate_(arg_333_0)
			local var_333_0 = 0.95

			if 0 < arg_330_1.time_ and arg_330_1.time_ <= 0 + arg_333_0 then
				arg_330_1.talkMaxDuration = 0
				arg_330_1.dialogCg_.alpha = 1

				arg_330_1.dialog_:SetActive(true)
				SetActive(arg_330_1.leftNameGo_, false)

				arg_330_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_330_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_330_1:RecordName(arg_330_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_330_1.iconTrs_.gameObject, false)
				arg_330_1.callingController_:SetSelectedState("normal")

				local var_333_1 = arg_330_1:FormatText(arg_330_1:GetWordFromCfg(319501080).content)

				arg_330_1.text_.text = var_333_1

				LuaForUtil.ClearLinePrefixSymbol(arg_330_1.text_)

				local var_333_3 = 38 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 38)

				if (38 <= 0 and var_333_0 or var_333_0 * (utf8.len(var_333_1) / 38)) > 0 and var_333_0 < var_333_3 then
					arg_330_1.talkMaxDuration = var_333_3

					if var_333_3 + 0 > arg_330_1.duration_ then
						arg_330_1.duration_ = var_333_3 + 0
					end
				end

				arg_330_1.text_.text = var_333_1
				arg_330_1.typewritter.percent = 0

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(false)
				arg_330_1:RecordContent(arg_330_1.text_.text)
			end

			local var_333_4 = math.max(var_333_0, arg_330_1.talkMaxDuration)

			if 0 <= arg_330_1.time_ and arg_330_1.time_ < 0 + var_333_4 then
				arg_330_1.typewritter.percent = (arg_330_1.time_ - 0) / var_333_4

				arg_330_1.typewritter:SetDirty()
			end

			if arg_330_1.time_ >= 0 + var_333_4 and arg_330_1.time_ < 0 + var_333_4 + arg_333_0 then
				arg_330_1.typewritter.percent = 1

				arg_330_1.typewritter:SetDirty()
				arg_330_1:ShowNextGo(true)
			end
		end

		arg_330_1.nodeConfigList_ = {}

		arg_330_1:InitPlayNodeList()
	end,
	Play319501081 = function(arg_334_0, arg_334_1)
		arg_334_1.time_ = 0
		arg_334_1.frameCnt_ = 0
		arg_334_1.state_ = "playing"
		arg_334_1.curTalkId_ = 319501081
		arg_334_1.duration_ = 6.73

		local var_334_0 = {
			zh = 5.5,
			ja = 6.733
		}
		local var_334_1 = manager.audio:GetLocalizationFlag()

		if var_334_0[var_334_1] ~= nil then
			arg_334_1.duration_ = var_334_0[var_334_1]
		end

		SetActive(arg_334_1.tipsGo_, false)

		function arg_334_1.onSingleLineFinish_()
			arg_334_1.onSingleLineUpdate_ = nil
			arg_334_1.onSingleLineFinish_ = nil
			arg_334_1.state_ = "waiting"
		end

		function arg_334_1.playNext_(arg_336_0)
			if arg_336_0 == 1 then
				arg_334_0:Play319501082(arg_334_1)
			end
		end

		function arg_334_1.onSingleLineUpdate_(arg_337_0)
			if arg_334_1.bgs_.ML0105 == nil then
				local var_337_0 = Object.Instantiate(arg_334_1.paintGo_)

				var_337_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ML0105")
				var_337_0.name = "ML0105"
				var_337_0.transform.parent = arg_334_1.stage_.transform
				var_337_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_334_1.bgs_.ML0105 = var_337_0
			end

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				local var_337_1 = arg_334_1.bgs_.ML0105

				arg_334_1.bgs_.ML0105.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_337_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_337_2 = var_337_1:GetComponent("SpriteRenderer")

				if var_337_2 and var_337_2.sprite then
					local var_337_3 = 2 * (var_337_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_337_1.transform.localScale = Vector3.New(var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, var_337_3 / var_337_2.sprite.bounds.size.y < var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x and var_337_3 * manager.ui.mainCameraCom_.aspect / var_337_2.sprite.bounds.size.x or var_337_3 / var_337_2.sprite.bounds.size.y, 0)
				end

				for iter_337_0, iter_337_1 in pairs(arg_334_1.bgs_) do
					if iter_337_0 ~= "ML0105" then
						iter_337_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_337_4 = 3

			if 3 < arg_334_1.time_ and arg_334_1.time_ <= var_337_4 + arg_337_0 then
				arg_334_1.allBtn_.enabled = false
			end

			if arg_334_1.time_ >= var_337_4 + 0.3 and arg_334_1.time_ < var_337_4 + 0.3 + arg_337_0 then
				arg_334_1.allBtn_.enabled = true
			end

			local var_337_5 = 0

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= var_337_5 + arg_337_0 then
				arg_334_1.mask_.enabled = true
				arg_334_1.mask_.raycastTarget = true

				arg_334_1:SetGaussion(false)
			end

			local var_337_6 = 3

			if var_337_5 <= arg_334_1.time_ and arg_334_1.time_ < var_337_5 + var_337_6 then
				local var_337_7 = Color.New(1, 1, 1)

				var_337_7.a = Mathf.Lerp(1, 0, (arg_334_1.time_ - var_337_5) / var_337_6)
				arg_334_1.mask_.color = var_337_7
			end

			if arg_334_1.time_ >= var_337_5 + var_337_6 and arg_334_1.time_ < var_337_5 + var_337_6 + arg_337_0 then
				local var_337_8 = Color.New(1, 1, 1)

				arg_334_1.mask_.enabled = false
				var_337_8.a = 0
				arg_334_1.mask_.color = var_337_8
			end

			local var_337_9 = arg_334_1.actors_["10068ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos10068ui_story = var_337_9.localPosition
			end

			local var_337_10 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_10 then
				var_337_9.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_334_1.time_ - 0) / var_337_10)
				var_337_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_9.position).x, (manager.ui.mainCamera.transform.position - var_337_9.position).y, (manager.ui.mainCamera.transform.position - var_337_9.position).z)
				var_337_9.localEulerAngles.z = 0
				var_337_9.localEulerAngles.x = 0
				var_337_9.localEulerAngles = var_337_9.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_10 and arg_334_1.time_ < 0 + var_337_10 + arg_337_0 then
				var_337_9.localPosition = Vector3.New(0, 100, 0)
				var_337_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_9.position).x, (manager.ui.mainCamera.transform.position - var_337_9.position).y, (manager.ui.mainCamera.transform.position - var_337_9.position).z)
				var_337_9.localEulerAngles.z = 0
				var_337_9.localEulerAngles.x = 0
				var_337_9.localEulerAngles = var_337_9.localEulerAngles
			end

			local var_337_11 = arg_334_1.actors_["10068ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect10068ui_story == nil then
				arg_334_1.var_.characterEffect10068ui_story = var_337_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_12 = 0.034000001847744

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_12 and not isNil(var_337_11) then
				if arg_334_1.var_.characterEffect10068ui_story and not isNil(var_337_11) then
					arg_334_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_334_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_334_1.time_ - 0) / var_337_12)
				end
			end

			if arg_334_1.time_ >= 0 + var_337_12 and arg_334_1.time_ < 0 + var_337_12 + arg_337_0 and not isNil(var_337_11) and arg_334_1.var_.characterEffect10068ui_story then
				arg_334_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_334_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_337_13 = arg_334_1.actors_["1084ui_story"].transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPos1084ui_story = var_337_13.localPosition
			end

			local var_337_14 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_14 then
				var_337_13.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_334_1.time_ - 0) / var_337_14)
				var_337_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_13.position).x, (manager.ui.mainCamera.transform.position - var_337_13.position).y, (manager.ui.mainCamera.transform.position - var_337_13.position).z)
				var_337_13.localEulerAngles.z = 0
				var_337_13.localEulerAngles.x = 0
				var_337_13.localEulerAngles = var_337_13.localEulerAngles
			end

			if arg_334_1.time_ >= 0 + var_337_14 and arg_334_1.time_ < 0 + var_337_14 + arg_337_0 then
				var_337_13.localPosition = Vector3.New(0, 100, 0)
				var_337_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_337_13.position).x, (manager.ui.mainCamera.transform.position - var_337_13.position).y, (manager.ui.mainCamera.transform.position - var_337_13.position).z)
				var_337_13.localEulerAngles.z = 0
				var_337_13.localEulerAngles.x = 0
				var_337_13.localEulerAngles = var_337_13.localEulerAngles
			end

			local var_337_15 = arg_334_1.actors_["1084ui_story"]

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 and not isNil(var_337_15) and arg_334_1.var_.characterEffect1084ui_story == nil then
				arg_334_1.var_.characterEffect1084ui_story = var_337_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_337_16 = 0.034000001847744

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_16 and not isNil(var_337_15) then
				if arg_334_1.var_.characterEffect1084ui_story and not isNil(var_337_15) then
					arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_334_1.time_ >= 0 + var_337_16 and arg_334_1.time_ < 0 + var_337_16 + arg_337_0 and not isNil(var_337_15) and arg_334_1.var_.characterEffect1084ui_story then
				arg_334_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_337_18 = arg_334_1.bgs_.ML0105.transform

			if 0 < arg_334_1.time_ and arg_334_1.time_ <= 0 + arg_337_0 then
				arg_334_1.var_.moveOldPosML0105 = var_337_18.localPosition
			end

			local var_337_19 = 0.001

			if 0 <= arg_334_1.time_ and arg_334_1.time_ < 0 + var_337_19 then
				var_337_18.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPosML0105, Vector3.New(0, 2, 5), (arg_334_1.time_ - 0) / var_337_19)
			end

			if arg_334_1.time_ >= 0 + var_337_19 and arg_334_1.time_ < 0 + var_337_19 + arg_337_0 then
				var_337_18.localPosition = Vector3.New(0, 2, 5)
			end

			local var_337_20 = arg_334_1.bgs_.ML0105.transform

			if 0.0166666666666667 < arg_334_1.time_ and arg_334_1.time_ <= 0.0166666666666667 + arg_337_0 then
				arg_334_1.var_.moveOldPosML0105 = var_337_20.localPosition
			end

			local var_337_21 = 4.5

			if 0.0166666666666667 <= arg_334_1.time_ and arg_334_1.time_ < 0.0166666666666667 + var_337_21 then
				var_337_20.localPosition = Vector3.Lerp(arg_334_1.var_.moveOldPosML0105, Vector3.New(0, 1.5, 5), (arg_334_1.time_ - 0.0166666666666667) / var_337_21)
			end

			if arg_334_1.time_ >= 0.0166666666666667 + var_337_21 and arg_334_1.time_ < 0.0166666666666667 + var_337_21 + arg_337_0 then
				var_337_20.localPosition = Vector3.New(0, 1.5, 5)
			end

			if arg_334_1.frameCnt_ <= 1 then
				arg_334_1.dialog_:SetActive(false)
			end

			local var_337_22 = 3
			local var_337_23 = 0.25

			if 3 < arg_334_1.time_ and arg_334_1.time_ <= var_337_22 + arg_337_0 then
				arg_334_1.talkMaxDuration = 0

				arg_334_1.dialog_:SetActive(true)

				arg_334_1.dialogCg_.alpha = 0

				local var_337_24 = LeanTween.value(arg_334_1.dialog_, 0, 1, 0.3)

				var_337_24:setOnUpdate(LuaHelper.FloatAction(function(arg_338_0)
					arg_334_1.dialogCg_.alpha = arg_338_0
				end))
				var_337_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_334_1.dialog_)
					var_337_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_334_1.duration_ = arg_334_1.duration_ + 0.3

				SetActive(arg_334_1.leftNameGo_, true)

				arg_334_1.leftNameTxt_.text = arg_334_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_334_1.leftNameTxt_.transform)

				arg_334_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_334_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_334_1:RecordName(arg_334_1.leftNameTxt_.text)
				SetActive(arg_334_1.iconTrs_.gameObject, false)
				arg_334_1.callingController_:SetSelectedState("normal")

				local var_337_25 = arg_334_1:GetWordFromCfg(319501081)
				local var_337_26 = arg_334_1:FormatText(var_337_25.content)

				arg_334_1.text_.text = var_337_26

				LuaForUtil.ClearLinePrefixSymbol(arg_334_1.text_)

				local var_337_28 = 10 <= 0 and var_337_23 or var_337_23 * (utf8.len(var_337_26) / 10)

				if (10 <= 0 and var_337_23 or var_337_23 * (utf8.len(var_337_26) / 10)) > 0 and var_337_23 < var_337_28 then
					arg_334_1.talkMaxDuration = var_337_28
					var_337_22 = var_337_22 + 0.3

					if var_337_28 + var_337_22 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_28 + var_337_22
					end
				end

				arg_334_1.text_.text = var_337_26
				arg_334_1.typewritter.percent = 0

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501081", "story_v_out_319501.awb") ~= 0 then
					local var_337_29 = manager.audio:GetVoiceLength("story_v_out_319501", "319501081", "story_v_out_319501.awb") / 1000

					if var_337_29 + var_337_22 > arg_334_1.duration_ then
						arg_334_1.duration_ = var_337_29 + var_337_22
					end

					if var_337_25.prefab_name ~= "" and arg_334_1.actors_[var_337_25.prefab_name] ~= nil then
						local var_337_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_334_1.actors_[var_337_25.prefab_name].transform, "story_v_out_319501", "319501081", "story_v_out_319501.awb")

						arg_334_1:RecordAudio("319501081", var_337_30)
						arg_334_1:RecordAudio("319501081", var_337_30)
					else
						arg_334_1:AudioAction("play", "voice", "story_v_out_319501", "319501081", "story_v_out_319501.awb")
					end

					arg_334_1:RecordHistoryTalkVoice("story_v_out_319501", "319501081", "story_v_out_319501.awb")
				end

				arg_334_1:RecordContent(arg_334_1.text_.text)
			end

			local var_337_31 = var_337_22 + 0.3
			local var_337_32 = math.max(var_337_23, arg_334_1.talkMaxDuration)

			if var_337_22 + 0.3 <= arg_334_1.time_ and arg_334_1.time_ < var_337_31 + var_337_32 then
				arg_334_1.typewritter.percent = (arg_334_1.time_ - var_337_31) / var_337_32

				arg_334_1.typewritter:SetDirty()
			end

			if arg_334_1.time_ >= var_337_31 + var_337_32 and arg_334_1.time_ < var_337_31 + var_337_32 + arg_337_0 then
				arg_334_1.typewritter.percent = 1

				arg_334_1.typewritter:SetDirty()
				arg_334_1:ShowNextGo(true)
			end
		end

		arg_334_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_334_1:InitPlayNodeList()
	end,
	Play319501082 = function(arg_340_0, arg_340_1)
		arg_340_1.time_ = 0
		arg_340_1.frameCnt_ = 0
		arg_340_1.state_ = "playing"
		arg_340_1.curTalkId_ = 319501082
		arg_340_1.duration_ = 2.13

		local var_340_0 = {
			zh = 1.766,
			ja = 2.133
		}
		local var_340_1 = manager.audio:GetLocalizationFlag()

		if var_340_0[var_340_1] ~= nil then
			arg_340_1.duration_ = var_340_0[var_340_1]
		end

		SetActive(arg_340_1.tipsGo_, false)

		function arg_340_1.onSingleLineFinish_()
			arg_340_1.onSingleLineUpdate_ = nil
			arg_340_1.onSingleLineFinish_ = nil
			arg_340_1.state_ = "waiting"
		end

		function arg_340_1.playNext_(arg_342_0)
			if arg_342_0 == 1 then
				arg_340_0:Play319501083(arg_340_1)
			end
		end

		function arg_340_1.onSingleLineUpdate_(arg_343_0)
			if 0 < arg_340_1.time_ and arg_340_1.time_ <= 0 + arg_343_0 and not isNil(arg_340_1.actors_["1084ui_story"]) and arg_340_1.var_.characterEffect1084ui_story == nil then
				arg_340_1.var_.characterEffect1084ui_story = arg_340_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_343_0 = 0.200000002980232

			if 0 <= arg_340_1.time_ and arg_340_1.time_ < 0 + var_343_0 and not isNil(arg_340_1.actors_["1084ui_story"]) then
				if arg_340_1.var_.characterEffect1084ui_story and not isNil(arg_340_1.actors_["1084ui_story"]) then
					arg_340_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_340_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_340_1.time_ - 0) / var_343_0)
				end
			end

			if arg_340_1.time_ >= 0 + var_343_0 and arg_340_1.time_ < 0 + var_343_0 + arg_343_0 and not isNil(arg_340_1.actors_["1084ui_story"]) and arg_340_1.var_.characterEffect1084ui_story then
				arg_340_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_340_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_343_1 = 0
			local var_343_2 = 0.175

			if 0 < arg_340_1.time_ and arg_340_1.time_ <= var_343_1 + arg_343_0 then
				arg_340_1.talkMaxDuration = 0
				arg_340_1.dialogCg_.alpha = 1

				arg_340_1.dialog_:SetActive(true)
				SetActive(arg_340_1.leftNameGo_, true)

				arg_340_1.leftNameTxt_.text = arg_340_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_340_1.leftNameTxt_.transform)

				arg_340_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_340_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_340_1:RecordName(arg_340_1.leftNameTxt_.text)
				SetActive(arg_340_1.iconTrs_.gameObject, false)
				arg_340_1.callingController_:SetSelectedState("normal")

				local var_343_3 = arg_340_1:GetWordFromCfg(319501082)
				local var_343_4 = arg_340_1:FormatText(var_343_3.content)

				arg_340_1.text_.text = var_343_4

				LuaForUtil.ClearLinePrefixSymbol(arg_340_1.text_)

				local var_343_6 = 7 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_4) / 7)

				if (7 <= 0 and var_343_2 or var_343_2 * (utf8.len(var_343_4) / 7)) > 0 and var_343_2 < var_343_6 then
					arg_340_1.talkMaxDuration = var_343_6

					if var_343_6 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_6 + var_343_1
					end
				end

				arg_340_1.text_.text = var_343_4
				arg_340_1.typewritter.percent = 0

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501082", "story_v_out_319501.awb") ~= 0 then
					local var_343_7 = manager.audio:GetVoiceLength("story_v_out_319501", "319501082", "story_v_out_319501.awb") / 1000

					if var_343_7 + var_343_1 > arg_340_1.duration_ then
						arg_340_1.duration_ = var_343_7 + var_343_1
					end

					if var_343_3.prefab_name ~= "" and arg_340_1.actors_[var_343_3.prefab_name] ~= nil then
						local var_343_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_340_1.actors_[var_343_3.prefab_name].transform, "story_v_out_319501", "319501082", "story_v_out_319501.awb")

						arg_340_1:RecordAudio("319501082", var_343_8)
						arg_340_1:RecordAudio("319501082", var_343_8)
					else
						arg_340_1:AudioAction("play", "voice", "story_v_out_319501", "319501082", "story_v_out_319501.awb")
					end

					arg_340_1:RecordHistoryTalkVoice("story_v_out_319501", "319501082", "story_v_out_319501.awb")
				end

				arg_340_1:RecordContent(arg_340_1.text_.text)
			end

			local var_343_9 = math.max(var_343_2, arg_340_1.talkMaxDuration)

			if var_343_1 <= arg_340_1.time_ and arg_340_1.time_ < var_343_1 + var_343_9 then
				arg_340_1.typewritter.percent = (arg_340_1.time_ - var_343_1) / var_343_9

				arg_340_1.typewritter:SetDirty()
			end

			if arg_340_1.time_ >= var_343_1 + var_343_9 and arg_340_1.time_ < var_343_1 + var_343_9 + arg_343_0 then
				arg_340_1.typewritter.percent = 1

				arg_340_1.typewritter:SetDirty()
				arg_340_1:ShowNextGo(true)
			end
		end

		arg_340_1.nodeConfigList_ = {}

		arg_340_1:InitPlayNodeList()
	end,
	Play319501083 = function(arg_344_0, arg_344_1)
		arg_344_1.time_ = 0
		arg_344_1.frameCnt_ = 0
		arg_344_1.state_ = "playing"
		arg_344_1.curTalkId_ = 319501083
		arg_344_1.duration_ = 4.67

		local var_344_0 = {
			zh = 4.433,
			ja = 4.666
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
				arg_344_0:Play319501084(arg_344_1)
			end
		end

		function arg_344_1.onSingleLineUpdate_(arg_347_0)
			local var_347_0 = 0.475

			if 0 < arg_344_1.time_ and arg_344_1.time_ <= 0 + arg_347_0 then
				arg_344_1.talkMaxDuration = 0
				arg_344_1.dialogCg_.alpha = 1

				arg_344_1.dialog_:SetActive(true)
				SetActive(arg_344_1.leftNameGo_, true)

				arg_344_1.leftNameTxt_.text = arg_344_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_344_1.leftNameTxt_.transform)

				arg_344_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_344_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_344_1:RecordName(arg_344_1.leftNameTxt_.text)
				SetActive(arg_344_1.iconTrs_.gameObject, false)
				arg_344_1.callingController_:SetSelectedState("normal")

				local var_347_1 = arg_344_1:GetWordFromCfg(319501083)
				local var_347_2 = arg_344_1:FormatText(var_347_1.content)

				arg_344_1.text_.text = var_347_2

				LuaForUtil.ClearLinePrefixSymbol(arg_344_1.text_)

				local var_347_4 = 19 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 19)

				if (19 <= 0 and var_347_0 or var_347_0 * (utf8.len(var_347_2) / 19)) > 0 and var_347_0 < var_347_4 then
					arg_344_1.talkMaxDuration = var_347_4

					if var_347_4 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_4 + 0
					end
				end

				arg_344_1.text_.text = var_347_2
				arg_344_1.typewritter.percent = 0

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501083", "story_v_out_319501.awb") ~= 0 then
					local var_347_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501083", "story_v_out_319501.awb") / 1000

					if var_347_5 + 0 > arg_344_1.duration_ then
						arg_344_1.duration_ = var_347_5 + 0
					end

					if var_347_1.prefab_name ~= "" and arg_344_1.actors_[var_347_1.prefab_name] ~= nil then
						local var_347_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_344_1.actors_[var_347_1.prefab_name].transform, "story_v_out_319501", "319501083", "story_v_out_319501.awb")

						arg_344_1:RecordAudio("319501083", var_347_6)
						arg_344_1:RecordAudio("319501083", var_347_6)
					else
						arg_344_1:AudioAction("play", "voice", "story_v_out_319501", "319501083", "story_v_out_319501.awb")
					end

					arg_344_1:RecordHistoryTalkVoice("story_v_out_319501", "319501083", "story_v_out_319501.awb")
				end

				arg_344_1:RecordContent(arg_344_1.text_.text)
			end

			local var_347_7 = math.max(var_347_0, arg_344_1.talkMaxDuration)

			if 0 <= arg_344_1.time_ and arg_344_1.time_ < 0 + var_347_7 then
				arg_344_1.typewritter.percent = (arg_344_1.time_ - 0) / var_347_7

				arg_344_1.typewritter:SetDirty()
			end

			if arg_344_1.time_ >= 0 + var_347_7 and arg_344_1.time_ < 0 + var_347_7 + arg_347_0 then
				arg_344_1.typewritter.percent = 1

				arg_344_1.typewritter:SetDirty()
				arg_344_1:ShowNextGo(true)
			end
		end

		arg_344_1.nodeConfigList_ = {}

		arg_344_1:InitPlayNodeList()
	end,
	Play319501084 = function(arg_348_0, arg_348_1)
		arg_348_1.time_ = 0
		arg_348_1.frameCnt_ = 0
		arg_348_1.state_ = "playing"
		arg_348_1.curTalkId_ = 319501084
		arg_348_1.duration_ = 4.43

		local var_348_0 = {
			zh = 3.5,
			ja = 4.433
		}
		local var_348_1 = manager.audio:GetLocalizationFlag()

		if var_348_0[var_348_1] ~= nil then
			arg_348_1.duration_ = var_348_0[var_348_1]
		end

		SetActive(arg_348_1.tipsGo_, false)

		function arg_348_1.onSingleLineFinish_()
			arg_348_1.onSingleLineUpdate_ = nil
			arg_348_1.onSingleLineFinish_ = nil
			arg_348_1.state_ = "waiting"
		end

		function arg_348_1.playNext_(arg_350_0)
			if arg_350_0 == 1 then
				arg_348_0:Play319501085(arg_348_1)
			end
		end

		function arg_348_1.onSingleLineUpdate_(arg_351_0)
			local var_351_0 = 0.425

			if 0 < arg_348_1.time_ and arg_348_1.time_ <= 0 + arg_351_0 then
				arg_348_1.talkMaxDuration = 0
				arg_348_1.dialogCg_.alpha = 1

				arg_348_1.dialog_:SetActive(true)
				SetActive(arg_348_1.leftNameGo_, true)

				arg_348_1.leftNameTxt_.text = arg_348_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_348_1.leftNameTxt_.transform)

				arg_348_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_348_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_348_1:RecordName(arg_348_1.leftNameTxt_.text)
				SetActive(arg_348_1.iconTrs_.gameObject, false)
				arg_348_1.callingController_:SetSelectedState("normal")

				local var_351_1 = arg_348_1:GetWordFromCfg(319501084)
				local var_351_2 = arg_348_1:FormatText(var_351_1.content)

				arg_348_1.text_.text = var_351_2

				LuaForUtil.ClearLinePrefixSymbol(arg_348_1.text_)

				local var_351_4 = 17 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 17)

				if (17 <= 0 and var_351_0 or var_351_0 * (utf8.len(var_351_2) / 17)) > 0 and var_351_0 < var_351_4 then
					arg_348_1.talkMaxDuration = var_351_4

					if var_351_4 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_4 + 0
					end
				end

				arg_348_1.text_.text = var_351_2
				arg_348_1.typewritter.percent = 0

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501084", "story_v_out_319501.awb") ~= 0 then
					local var_351_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501084", "story_v_out_319501.awb") / 1000

					if var_351_5 + 0 > arg_348_1.duration_ then
						arg_348_1.duration_ = var_351_5 + 0
					end

					if var_351_1.prefab_name ~= "" and arg_348_1.actors_[var_351_1.prefab_name] ~= nil then
						local var_351_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_348_1.actors_[var_351_1.prefab_name].transform, "story_v_out_319501", "319501084", "story_v_out_319501.awb")

						arg_348_1:RecordAudio("319501084", var_351_6)
						arg_348_1:RecordAudio("319501084", var_351_6)
					else
						arg_348_1:AudioAction("play", "voice", "story_v_out_319501", "319501084", "story_v_out_319501.awb")
					end

					arg_348_1:RecordHistoryTalkVoice("story_v_out_319501", "319501084", "story_v_out_319501.awb")
				end

				arg_348_1:RecordContent(arg_348_1.text_.text)
			end

			local var_351_7 = math.max(var_351_0, arg_348_1.talkMaxDuration)

			if 0 <= arg_348_1.time_ and arg_348_1.time_ < 0 + var_351_7 then
				arg_348_1.typewritter.percent = (arg_348_1.time_ - 0) / var_351_7

				arg_348_1.typewritter:SetDirty()
			end

			if arg_348_1.time_ >= 0 + var_351_7 and arg_348_1.time_ < 0 + var_351_7 + arg_351_0 then
				arg_348_1.typewritter.percent = 1

				arg_348_1.typewritter:SetDirty()
				arg_348_1:ShowNextGo(true)
			end
		end

		arg_348_1.nodeConfigList_ = {}

		arg_348_1:InitPlayNodeList()
	end,
	Play319501085 = function(arg_352_0, arg_352_1)
		arg_352_1.time_ = 0
		arg_352_1.frameCnt_ = 0
		arg_352_1.state_ = "playing"
		arg_352_1.curTalkId_ = 319501085
		arg_352_1.duration_ = 1.9

		local var_352_0 = {
			zh = 1.6,
			ja = 1.9
		}
		local var_352_1 = manager.audio:GetLocalizationFlag()

		if var_352_0[var_352_1] ~= nil then
			arg_352_1.duration_ = var_352_0[var_352_1]
		end

		SetActive(arg_352_1.tipsGo_, false)

		function arg_352_1.onSingleLineFinish_()
			arg_352_1.onSingleLineUpdate_ = nil
			arg_352_1.onSingleLineFinish_ = nil
			arg_352_1.state_ = "waiting"
		end

		function arg_352_1.playNext_(arg_354_0)
			if arg_354_0 == 1 then
				arg_352_0:Play319501086(arg_352_1)
			end
		end

		function arg_352_1.onSingleLineUpdate_(arg_355_0)
			local var_355_0 = 0.05

			if 0 < arg_352_1.time_ and arg_352_1.time_ <= 0 + arg_355_0 then
				arg_352_1.talkMaxDuration = 0
				arg_352_1.dialogCg_.alpha = 1

				arg_352_1.dialog_:SetActive(true)
				SetActive(arg_352_1.leftNameGo_, true)

				arg_352_1.leftNameTxt_.text = arg_352_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_352_1.leftNameTxt_.transform)

				arg_352_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_352_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_352_1:RecordName(arg_352_1.leftNameTxt_.text)
				SetActive(arg_352_1.iconTrs_.gameObject, false)
				arg_352_1.callingController_:SetSelectedState("normal")

				local var_355_1 = arg_352_1:GetWordFromCfg(319501085)
				local var_355_2 = arg_352_1:FormatText(var_355_1.content)

				arg_352_1.text_.text = var_355_2

				LuaForUtil.ClearLinePrefixSymbol(arg_352_1.text_)

				local var_355_4 = 2 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 2)

				if (2 <= 0 and var_355_0 or var_355_0 * (utf8.len(var_355_2) / 2)) > 0 and var_355_0 < var_355_4 then
					arg_352_1.talkMaxDuration = var_355_4

					if var_355_4 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_4 + 0
					end
				end

				arg_352_1.text_.text = var_355_2
				arg_352_1.typewritter.percent = 0

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501085", "story_v_out_319501.awb") ~= 0 then
					local var_355_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501085", "story_v_out_319501.awb") / 1000

					if var_355_5 + 0 > arg_352_1.duration_ then
						arg_352_1.duration_ = var_355_5 + 0
					end

					if var_355_1.prefab_name ~= "" and arg_352_1.actors_[var_355_1.prefab_name] ~= nil then
						local var_355_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_352_1.actors_[var_355_1.prefab_name].transform, "story_v_out_319501", "319501085", "story_v_out_319501.awb")

						arg_352_1:RecordAudio("319501085", var_355_6)
						arg_352_1:RecordAudio("319501085", var_355_6)
					else
						arg_352_1:AudioAction("play", "voice", "story_v_out_319501", "319501085", "story_v_out_319501.awb")
					end

					arg_352_1:RecordHistoryTalkVoice("story_v_out_319501", "319501085", "story_v_out_319501.awb")
				end

				arg_352_1:RecordContent(arg_352_1.text_.text)
			end

			local var_355_7 = math.max(var_355_0, arg_352_1.talkMaxDuration)

			if 0 <= arg_352_1.time_ and arg_352_1.time_ < 0 + var_355_7 then
				arg_352_1.typewritter.percent = (arg_352_1.time_ - 0) / var_355_7

				arg_352_1.typewritter:SetDirty()
			end

			if arg_352_1.time_ >= 0 + var_355_7 and arg_352_1.time_ < 0 + var_355_7 + arg_355_0 then
				arg_352_1.typewritter.percent = 1

				arg_352_1.typewritter:SetDirty()
				arg_352_1:ShowNextGo(true)
			end
		end

		arg_352_1.nodeConfigList_ = {}

		arg_352_1:InitPlayNodeList()
	end,
	Play319501086 = function(arg_356_0, arg_356_1)
		arg_356_1.time_ = 0
		arg_356_1.frameCnt_ = 0
		arg_356_1.state_ = "playing"
		arg_356_1.curTalkId_ = 319501086
		arg_356_1.duration_ = 5

		SetActive(arg_356_1.tipsGo_, false)

		function arg_356_1.onSingleLineFinish_()
			arg_356_1.onSingleLineUpdate_ = nil
			arg_356_1.onSingleLineFinish_ = nil
			arg_356_1.state_ = "waiting"
		end

		function arg_356_1.playNext_(arg_358_0)
			if arg_358_0 == 1 then
				arg_356_0:Play319501087(arg_356_1)
			end
		end

		function arg_356_1.onSingleLineUpdate_(arg_359_0)
			local var_359_0 = 1.45

			if 0 < arg_356_1.time_ and arg_356_1.time_ <= 0 + arg_359_0 then
				arg_356_1.talkMaxDuration = 0
				arg_356_1.dialogCg_.alpha = 1

				arg_356_1.dialog_:SetActive(true)
				SetActive(arg_356_1.leftNameGo_, false)

				arg_356_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_356_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_356_1:RecordName(arg_356_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_356_1.iconTrs_.gameObject, false)
				arg_356_1.callingController_:SetSelectedState("normal")

				local var_359_1 = arg_356_1:FormatText(arg_356_1:GetWordFromCfg(319501086).content)

				arg_356_1.text_.text = var_359_1

				LuaForUtil.ClearLinePrefixSymbol(arg_356_1.text_)

				local var_359_3 = 57 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 57)

				if (57 <= 0 and var_359_0 or var_359_0 * (utf8.len(var_359_1) / 57)) > 0 and var_359_0 < var_359_3 then
					arg_356_1.talkMaxDuration = var_359_3

					if var_359_3 + 0 > arg_356_1.duration_ then
						arg_356_1.duration_ = var_359_3 + 0
					end
				end

				arg_356_1.text_.text = var_359_1
				arg_356_1.typewritter.percent = 0

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(false)
				arg_356_1:RecordContent(arg_356_1.text_.text)
			end

			local var_359_4 = math.max(var_359_0, arg_356_1.talkMaxDuration)

			if 0 <= arg_356_1.time_ and arg_356_1.time_ < 0 + var_359_4 then
				arg_356_1.typewritter.percent = (arg_356_1.time_ - 0) / var_359_4

				arg_356_1.typewritter:SetDirty()
			end

			if arg_356_1.time_ >= 0 + var_359_4 and arg_356_1.time_ < 0 + var_359_4 + arg_359_0 then
				arg_356_1.typewritter.percent = 1

				arg_356_1.typewritter:SetDirty()
				arg_356_1:ShowNextGo(true)
			end
		end

		arg_356_1.nodeConfigList_ = {}

		arg_356_1:InitPlayNodeList()
	end,
	Play319501087 = function(arg_360_0, arg_360_1)
		arg_360_1.time_ = 0
		arg_360_1.frameCnt_ = 0
		arg_360_1.state_ = "playing"
		arg_360_1.curTalkId_ = 319501087
		arg_360_1.duration_ = 5

		SetActive(arg_360_1.tipsGo_, false)

		function arg_360_1.onSingleLineFinish_()
			arg_360_1.onSingleLineUpdate_ = nil
			arg_360_1.onSingleLineFinish_ = nil
			arg_360_1.state_ = "waiting"
		end

		function arg_360_1.playNext_(arg_362_0)
			if arg_362_0 == 1 then
				arg_360_0:Play319501088(arg_360_1)
			end
		end

		function arg_360_1.onSingleLineUpdate_(arg_363_0)
			local var_363_0 = 1.3

			if 0 < arg_360_1.time_ and arg_360_1.time_ <= 0 + arg_363_0 then
				arg_360_1.talkMaxDuration = 0
				arg_360_1.dialogCg_.alpha = 1

				arg_360_1.dialog_:SetActive(true)
				SetActive(arg_360_1.leftNameGo_, false)

				arg_360_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_360_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_360_1:RecordName(arg_360_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_360_1.iconTrs_.gameObject, false)
				arg_360_1.callingController_:SetSelectedState("normal")

				local var_363_1 = arg_360_1:FormatText(arg_360_1:GetWordFromCfg(319501087).content)

				arg_360_1.text_.text = var_363_1

				LuaForUtil.ClearLinePrefixSymbol(arg_360_1.text_)

				local var_363_3 = 52 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 52)

				if (52 <= 0 and var_363_0 or var_363_0 * (utf8.len(var_363_1) / 52)) > 0 and var_363_0 < var_363_3 then
					arg_360_1.talkMaxDuration = var_363_3

					if var_363_3 + 0 > arg_360_1.duration_ then
						arg_360_1.duration_ = var_363_3 + 0
					end
				end

				arg_360_1.text_.text = var_363_1
				arg_360_1.typewritter.percent = 0

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(false)
				arg_360_1:RecordContent(arg_360_1.text_.text)
			end

			local var_363_4 = math.max(var_363_0, arg_360_1.talkMaxDuration)

			if 0 <= arg_360_1.time_ and arg_360_1.time_ < 0 + var_363_4 then
				arg_360_1.typewritter.percent = (arg_360_1.time_ - 0) / var_363_4

				arg_360_1.typewritter:SetDirty()
			end

			if arg_360_1.time_ >= 0 + var_363_4 and arg_360_1.time_ < 0 + var_363_4 + arg_363_0 then
				arg_360_1.typewritter.percent = 1

				arg_360_1.typewritter:SetDirty()
				arg_360_1:ShowNextGo(true)
			end
		end

		arg_360_1.nodeConfigList_ = {}

		arg_360_1:InitPlayNodeList()
	end,
	Play319501088 = function(arg_364_0, arg_364_1)
		arg_364_1.time_ = 0
		arg_364_1.frameCnt_ = 0
		arg_364_1.state_ = "playing"
		arg_364_1.curTalkId_ = 319501088
		arg_364_1.duration_ = 9.27

		local var_364_0 = {
			zh = 9.266,
			ja = 6.8
		}
		local var_364_1 = manager.audio:GetLocalizationFlag()

		if var_364_0[var_364_1] ~= nil then
			arg_364_1.duration_ = var_364_0[var_364_1]
		end

		SetActive(arg_364_1.tipsGo_, false)

		function arg_364_1.onSingleLineFinish_()
			arg_364_1.onSingleLineUpdate_ = nil
			arg_364_1.onSingleLineFinish_ = nil
			arg_364_1.state_ = "waiting"
		end

		function arg_364_1.playNext_(arg_366_0)
			if arg_366_0 == 1 then
				arg_364_0:Play319501089(arg_364_1)
			end
		end

		function arg_364_1.onSingleLineUpdate_(arg_367_0)
			local var_367_0 = 1

			if 0 < arg_364_1.time_ and arg_364_1.time_ <= 0 + arg_367_0 then
				arg_364_1.talkMaxDuration = 0
				arg_364_1.dialogCg_.alpha = 1

				arg_364_1.dialog_:SetActive(true)
				SetActive(arg_364_1.leftNameGo_, true)

				arg_364_1.leftNameTxt_.text = arg_364_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_364_1.leftNameTxt_.transform)

				arg_364_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_364_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_364_1:RecordName(arg_364_1.leftNameTxt_.text)
				SetActive(arg_364_1.iconTrs_.gameObject, false)
				arg_364_1.callingController_:SetSelectedState("normal")

				local var_367_1 = arg_364_1:GetWordFromCfg(319501088)
				local var_367_2 = arg_364_1:FormatText(var_367_1.content)

				arg_364_1.text_.text = var_367_2

				LuaForUtil.ClearLinePrefixSymbol(arg_364_1.text_)

				local var_367_4 = 40 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 40)

				if (40 <= 0 and var_367_0 or var_367_0 * (utf8.len(var_367_2) / 40)) > 0 and var_367_0 < var_367_4 then
					arg_364_1.talkMaxDuration = var_367_4

					if var_367_4 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_4 + 0
					end
				end

				arg_364_1.text_.text = var_367_2
				arg_364_1.typewritter.percent = 0

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501088", "story_v_out_319501.awb") ~= 0 then
					local var_367_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501088", "story_v_out_319501.awb") / 1000

					if var_367_5 + 0 > arg_364_1.duration_ then
						arg_364_1.duration_ = var_367_5 + 0
					end

					if var_367_1.prefab_name ~= "" and arg_364_1.actors_[var_367_1.prefab_name] ~= nil then
						local var_367_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_364_1.actors_[var_367_1.prefab_name].transform, "story_v_out_319501", "319501088", "story_v_out_319501.awb")

						arg_364_1:RecordAudio("319501088", var_367_6)
						arg_364_1:RecordAudio("319501088", var_367_6)
					else
						arg_364_1:AudioAction("play", "voice", "story_v_out_319501", "319501088", "story_v_out_319501.awb")
					end

					arg_364_1:RecordHistoryTalkVoice("story_v_out_319501", "319501088", "story_v_out_319501.awb")
				end

				arg_364_1:RecordContent(arg_364_1.text_.text)
			end

			local var_367_7 = math.max(var_367_0, arg_364_1.talkMaxDuration)

			if 0 <= arg_364_1.time_ and arg_364_1.time_ < 0 + var_367_7 then
				arg_364_1.typewritter.percent = (arg_364_1.time_ - 0) / var_367_7

				arg_364_1.typewritter:SetDirty()
			end

			if arg_364_1.time_ >= 0 + var_367_7 and arg_364_1.time_ < 0 + var_367_7 + arg_367_0 then
				arg_364_1.typewritter.percent = 1

				arg_364_1.typewritter:SetDirty()
				arg_364_1:ShowNextGo(true)
			end
		end

		arg_364_1.nodeConfigList_ = {}

		arg_364_1:InitPlayNodeList()
	end,
	Play319501089 = function(arg_368_0, arg_368_1)
		arg_368_1.time_ = 0
		arg_368_1.frameCnt_ = 0
		arg_368_1.state_ = "playing"
		arg_368_1.curTalkId_ = 319501089
		arg_368_1.duration_ = 16.93

		local var_368_0 = {
			zh = 9.833,
			ja = 16.933
		}
		local var_368_1 = manager.audio:GetLocalizationFlag()

		if var_368_0[var_368_1] ~= nil then
			arg_368_1.duration_ = var_368_0[var_368_1]
		end

		SetActive(arg_368_1.tipsGo_, false)

		function arg_368_1.onSingleLineFinish_()
			arg_368_1.onSingleLineUpdate_ = nil
			arg_368_1.onSingleLineFinish_ = nil
			arg_368_1.state_ = "waiting"
		end

		function arg_368_1.playNext_(arg_370_0)
			if arg_370_0 == 1 then
				arg_368_0:Play319501090(arg_368_1)
			end
		end

		function arg_368_1.onSingleLineUpdate_(arg_371_0)
			local var_371_0 = 1.025

			if 0 < arg_368_1.time_ and arg_368_1.time_ <= 0 + arg_371_0 then
				arg_368_1.talkMaxDuration = 0
				arg_368_1.dialogCg_.alpha = 1

				arg_368_1.dialog_:SetActive(true)
				SetActive(arg_368_1.leftNameGo_, true)

				arg_368_1.leftNameTxt_.text = arg_368_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_368_1.leftNameTxt_.transform)

				arg_368_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_368_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_368_1:RecordName(arg_368_1.leftNameTxt_.text)
				SetActive(arg_368_1.iconTrs_.gameObject, false)
				arg_368_1.callingController_:SetSelectedState("normal")

				local var_371_1 = arg_368_1:GetWordFromCfg(319501089)
				local var_371_2 = arg_368_1:FormatText(var_371_1.content)

				arg_368_1.text_.text = var_371_2

				LuaForUtil.ClearLinePrefixSymbol(arg_368_1.text_)

				local var_371_4 = 41 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 41)

				if (41 <= 0 and var_371_0 or var_371_0 * (utf8.len(var_371_2) / 41)) > 0 and var_371_0 < var_371_4 then
					arg_368_1.talkMaxDuration = var_371_4

					if var_371_4 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_4 + 0
					end
				end

				arg_368_1.text_.text = var_371_2
				arg_368_1.typewritter.percent = 0

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501089", "story_v_out_319501.awb") ~= 0 then
					local var_371_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501089", "story_v_out_319501.awb") / 1000

					if var_371_5 + 0 > arg_368_1.duration_ then
						arg_368_1.duration_ = var_371_5 + 0
					end

					if var_371_1.prefab_name ~= "" and arg_368_1.actors_[var_371_1.prefab_name] ~= nil then
						local var_371_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_368_1.actors_[var_371_1.prefab_name].transform, "story_v_out_319501", "319501089", "story_v_out_319501.awb")

						arg_368_1:RecordAudio("319501089", var_371_6)
						arg_368_1:RecordAudio("319501089", var_371_6)
					else
						arg_368_1:AudioAction("play", "voice", "story_v_out_319501", "319501089", "story_v_out_319501.awb")
					end

					arg_368_1:RecordHistoryTalkVoice("story_v_out_319501", "319501089", "story_v_out_319501.awb")
				end

				arg_368_1:RecordContent(arg_368_1.text_.text)
			end

			local var_371_7 = math.max(var_371_0, arg_368_1.talkMaxDuration)

			if 0 <= arg_368_1.time_ and arg_368_1.time_ < 0 + var_371_7 then
				arg_368_1.typewritter.percent = (arg_368_1.time_ - 0) / var_371_7

				arg_368_1.typewritter:SetDirty()
			end

			if arg_368_1.time_ >= 0 + var_371_7 and arg_368_1.time_ < 0 + var_371_7 + arg_371_0 then
				arg_368_1.typewritter.percent = 1

				arg_368_1.typewritter:SetDirty()
				arg_368_1:ShowNextGo(true)
			end
		end

		arg_368_1.nodeConfigList_ = {}

		arg_368_1:InitPlayNodeList()
	end,
	Play319501090 = function(arg_372_0, arg_372_1)
		arg_372_1.time_ = 0
		arg_372_1.frameCnt_ = 0
		arg_372_1.state_ = "playing"
		arg_372_1.curTalkId_ = 319501090
		arg_372_1.duration_ = 8.57

		local var_372_0 = {
			zh = 4.566,
			ja = 8.566
		}
		local var_372_1 = manager.audio:GetLocalizationFlag()

		if var_372_0[var_372_1] ~= nil then
			arg_372_1.duration_ = var_372_0[var_372_1]
		end

		SetActive(arg_372_1.tipsGo_, false)

		function arg_372_1.onSingleLineFinish_()
			arg_372_1.onSingleLineUpdate_ = nil
			arg_372_1.onSingleLineFinish_ = nil
			arg_372_1.state_ = "waiting"
		end

		function arg_372_1.playNext_(arg_374_0)
			if arg_374_0 == 1 then
				arg_372_0:Play319501091(arg_372_1)
			end
		end

		function arg_372_1.onSingleLineUpdate_(arg_375_0)
			local var_375_0 = 0.375

			if 0 < arg_372_1.time_ and arg_372_1.time_ <= 0 + arg_375_0 then
				arg_372_1.talkMaxDuration = 0
				arg_372_1.dialogCg_.alpha = 1

				arg_372_1.dialog_:SetActive(true)
				SetActive(arg_372_1.leftNameGo_, true)

				arg_372_1.leftNameTxt_.text = arg_372_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_372_1.leftNameTxt_.transform)

				arg_372_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_372_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_372_1:RecordName(arg_372_1.leftNameTxt_.text)
				SetActive(arg_372_1.iconTrs_.gameObject, false)
				arg_372_1.callingController_:SetSelectedState("normal")

				local var_375_1 = arg_372_1:GetWordFromCfg(319501090)
				local var_375_2 = arg_372_1:FormatText(var_375_1.content)

				arg_372_1.text_.text = var_375_2

				LuaForUtil.ClearLinePrefixSymbol(arg_372_1.text_)

				local var_375_4 = 15 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 15)

				if (15 <= 0 and var_375_0 or var_375_0 * (utf8.len(var_375_2) / 15)) > 0 and var_375_0 < var_375_4 then
					arg_372_1.talkMaxDuration = var_375_4

					if var_375_4 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_4 + 0
					end
				end

				arg_372_1.text_.text = var_375_2
				arg_372_1.typewritter.percent = 0

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501090", "story_v_out_319501.awb") ~= 0 then
					local var_375_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501090", "story_v_out_319501.awb") / 1000

					if var_375_5 + 0 > arg_372_1.duration_ then
						arg_372_1.duration_ = var_375_5 + 0
					end

					if var_375_1.prefab_name ~= "" and arg_372_1.actors_[var_375_1.prefab_name] ~= nil then
						local var_375_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_372_1.actors_[var_375_1.prefab_name].transform, "story_v_out_319501", "319501090", "story_v_out_319501.awb")

						arg_372_1:RecordAudio("319501090", var_375_6)
						arg_372_1:RecordAudio("319501090", var_375_6)
					else
						arg_372_1:AudioAction("play", "voice", "story_v_out_319501", "319501090", "story_v_out_319501.awb")
					end

					arg_372_1:RecordHistoryTalkVoice("story_v_out_319501", "319501090", "story_v_out_319501.awb")
				end

				arg_372_1:RecordContent(arg_372_1.text_.text)
			end

			local var_375_7 = math.max(var_375_0, arg_372_1.talkMaxDuration)

			if 0 <= arg_372_1.time_ and arg_372_1.time_ < 0 + var_375_7 then
				arg_372_1.typewritter.percent = (arg_372_1.time_ - 0) / var_375_7

				arg_372_1.typewritter:SetDirty()
			end

			if arg_372_1.time_ >= 0 + var_375_7 and arg_372_1.time_ < 0 + var_375_7 + arg_375_0 then
				arg_372_1.typewritter.percent = 1

				arg_372_1.typewritter:SetDirty()
				arg_372_1:ShowNextGo(true)
			end
		end

		arg_372_1.nodeConfigList_ = {}

		arg_372_1:InitPlayNodeList()
	end,
	Play319501091 = function(arg_376_0, arg_376_1)
		arg_376_1.time_ = 0
		arg_376_1.frameCnt_ = 0
		arg_376_1.state_ = "playing"
		arg_376_1.curTalkId_ = 319501091
		arg_376_1.duration_ = 1

		local var_376_0 = {
			zh = 0.999999999999,
			ja = 1
		}
		local var_376_1 = manager.audio:GetLocalizationFlag()

		if var_376_0[var_376_1] ~= nil then
			arg_376_1.duration_ = var_376_0[var_376_1]
		end

		SetActive(arg_376_1.tipsGo_, false)

		function arg_376_1.onSingleLineFinish_()
			arg_376_1.onSingleLineUpdate_ = nil
			arg_376_1.onSingleLineFinish_ = nil
			arg_376_1.state_ = "waiting"
		end

		function arg_376_1.playNext_(arg_378_0)
			if arg_378_0 == 1 then
				arg_376_0:Play319501092(arg_376_1)
			end
		end

		function arg_376_1.onSingleLineUpdate_(arg_379_0)
			local var_379_0 = 0.1

			if 0 < arg_376_1.time_ and arg_376_1.time_ <= 0 + arg_379_0 then
				arg_376_1.talkMaxDuration = 0
				arg_376_1.dialogCg_.alpha = 1

				arg_376_1.dialog_:SetActive(true)
				SetActive(arg_376_1.leftNameGo_, true)

				arg_376_1.leftNameTxt_.text = arg_376_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_376_1.leftNameTxt_.transform)

				arg_376_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_376_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_376_1:RecordName(arg_376_1.leftNameTxt_.text)
				SetActive(arg_376_1.iconTrs_.gameObject, false)
				arg_376_1.callingController_:SetSelectedState("normal")

				local var_379_1 = arg_376_1:GetWordFromCfg(319501091)
				local var_379_2 = arg_376_1:FormatText(var_379_1.content)

				arg_376_1.text_.text = var_379_2

				LuaForUtil.ClearLinePrefixSymbol(arg_376_1.text_)

				local var_379_4 = 4 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 4)

				if (4 <= 0 and var_379_0 or var_379_0 * (utf8.len(var_379_2) / 4)) > 0 and var_379_0 < var_379_4 then
					arg_376_1.talkMaxDuration = var_379_4

					if var_379_4 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_4 + 0
					end
				end

				arg_376_1.text_.text = var_379_2
				arg_376_1.typewritter.percent = 0

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501091", "story_v_out_319501.awb") ~= 0 then
					local var_379_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501091", "story_v_out_319501.awb") / 1000

					if var_379_5 + 0 > arg_376_1.duration_ then
						arg_376_1.duration_ = var_379_5 + 0
					end

					if var_379_1.prefab_name ~= "" and arg_376_1.actors_[var_379_1.prefab_name] ~= nil then
						local var_379_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_376_1.actors_[var_379_1.prefab_name].transform, "story_v_out_319501", "319501091", "story_v_out_319501.awb")

						arg_376_1:RecordAudio("319501091", var_379_6)
						arg_376_1:RecordAudio("319501091", var_379_6)
					else
						arg_376_1:AudioAction("play", "voice", "story_v_out_319501", "319501091", "story_v_out_319501.awb")
					end

					arg_376_1:RecordHistoryTalkVoice("story_v_out_319501", "319501091", "story_v_out_319501.awb")
				end

				arg_376_1:RecordContent(arg_376_1.text_.text)
			end

			local var_379_7 = math.max(var_379_0, arg_376_1.talkMaxDuration)

			if 0 <= arg_376_1.time_ and arg_376_1.time_ < 0 + var_379_7 then
				arg_376_1.typewritter.percent = (arg_376_1.time_ - 0) / var_379_7

				arg_376_1.typewritter:SetDirty()
			end

			if arg_376_1.time_ >= 0 + var_379_7 and arg_376_1.time_ < 0 + var_379_7 + arg_379_0 then
				arg_376_1.typewritter.percent = 1

				arg_376_1.typewritter:SetDirty()
				arg_376_1:ShowNextGo(true)
			end
		end

		arg_376_1.nodeConfigList_ = {}

		arg_376_1:InitPlayNodeList()
	end,
	Play319501092 = function(arg_380_0, arg_380_1)
		arg_380_1.time_ = 0
		arg_380_1.frameCnt_ = 0
		arg_380_1.state_ = "playing"
		arg_380_1.curTalkId_ = 319501092
		arg_380_1.duration_ = 5

		SetActive(arg_380_1.tipsGo_, false)

		function arg_380_1.onSingleLineFinish_()
			arg_380_1.onSingleLineUpdate_ = nil
			arg_380_1.onSingleLineFinish_ = nil
			arg_380_1.state_ = "waiting"
		end

		function arg_380_1.playNext_(arg_382_0)
			if arg_382_0 == 1 then
				arg_380_0:Play319501093(arg_380_1)
			end
		end

		function arg_380_1.onSingleLineUpdate_(arg_383_0)
			local var_383_0 = 1.225

			if 0 < arg_380_1.time_ and arg_380_1.time_ <= 0 + arg_383_0 then
				arg_380_1.talkMaxDuration = 0
				arg_380_1.dialogCg_.alpha = 1

				arg_380_1.dialog_:SetActive(true)
				SetActive(arg_380_1.leftNameGo_, false)

				arg_380_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_380_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_380_1:RecordName(arg_380_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_380_1.iconTrs_.gameObject, false)
				arg_380_1.callingController_:SetSelectedState("normal")

				local var_383_1 = arg_380_1:FormatText(arg_380_1:GetWordFromCfg(319501092).content)

				arg_380_1.text_.text = var_383_1

				LuaForUtil.ClearLinePrefixSymbol(arg_380_1.text_)

				local var_383_3 = 49 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 49)

				if (49 <= 0 and var_383_0 or var_383_0 * (utf8.len(var_383_1) / 49)) > 0 and var_383_0 < var_383_3 then
					arg_380_1.talkMaxDuration = var_383_3

					if var_383_3 + 0 > arg_380_1.duration_ then
						arg_380_1.duration_ = var_383_3 + 0
					end
				end

				arg_380_1.text_.text = var_383_1
				arg_380_1.typewritter.percent = 0

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(false)
				arg_380_1:RecordContent(arg_380_1.text_.text)
			end

			local var_383_4 = math.max(var_383_0, arg_380_1.talkMaxDuration)

			if 0 <= arg_380_1.time_ and arg_380_1.time_ < 0 + var_383_4 then
				arg_380_1.typewritter.percent = (arg_380_1.time_ - 0) / var_383_4

				arg_380_1.typewritter:SetDirty()
			end

			if arg_380_1.time_ >= 0 + var_383_4 and arg_380_1.time_ < 0 + var_383_4 + arg_383_0 then
				arg_380_1.typewritter.percent = 1

				arg_380_1.typewritter:SetDirty()
				arg_380_1:ShowNextGo(true)
			end
		end

		arg_380_1.nodeConfigList_ = {}

		arg_380_1:InitPlayNodeList()
	end,
	Play319501093 = function(arg_384_0, arg_384_1)
		arg_384_1.time_ = 0
		arg_384_1.frameCnt_ = 0
		arg_384_1.state_ = "playing"
		arg_384_1.curTalkId_ = 319501093
		arg_384_1.duration_ = 10.97

		local var_384_0 = {
			zh = 6.733,
			ja = 10.966
		}
		local var_384_1 = manager.audio:GetLocalizationFlag()

		if var_384_0[var_384_1] ~= nil then
			arg_384_1.duration_ = var_384_0[var_384_1]
		end

		SetActive(arg_384_1.tipsGo_, false)

		function arg_384_1.onSingleLineFinish_()
			arg_384_1.onSingleLineUpdate_ = nil
			arg_384_1.onSingleLineFinish_ = nil
			arg_384_1.state_ = "waiting"
		end

		function arg_384_1.playNext_(arg_386_0)
			if arg_386_0 == 1 then
				arg_384_0:Play319501094(arg_384_1)
			end
		end

		function arg_384_1.onSingleLineUpdate_(arg_387_0)
			local var_387_0 = 0.75

			if 0 < arg_384_1.time_ and arg_384_1.time_ <= 0 + arg_387_0 then
				arg_384_1.talkMaxDuration = 0
				arg_384_1.dialogCg_.alpha = 1

				arg_384_1.dialog_:SetActive(true)
				SetActive(arg_384_1.leftNameGo_, true)

				arg_384_1.leftNameTxt_.text = arg_384_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_384_1.leftNameTxt_.transform)

				arg_384_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_384_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_384_1:RecordName(arg_384_1.leftNameTxt_.text)
				SetActive(arg_384_1.iconTrs_.gameObject, false)
				arg_384_1.callingController_:SetSelectedState("normal")

				local var_387_1 = arg_384_1:GetWordFromCfg(319501093)
				local var_387_2 = arg_384_1:FormatText(var_387_1.content)

				arg_384_1.text_.text = var_387_2

				LuaForUtil.ClearLinePrefixSymbol(arg_384_1.text_)

				local var_387_4 = 30 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 30)

				if (30 <= 0 and var_387_0 or var_387_0 * (utf8.len(var_387_2) / 30)) > 0 and var_387_0 < var_387_4 then
					arg_384_1.talkMaxDuration = var_387_4

					if var_387_4 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_4 + 0
					end
				end

				arg_384_1.text_.text = var_387_2
				arg_384_1.typewritter.percent = 0

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501093", "story_v_out_319501.awb") ~= 0 then
					local var_387_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501093", "story_v_out_319501.awb") / 1000

					if var_387_5 + 0 > arg_384_1.duration_ then
						arg_384_1.duration_ = var_387_5 + 0
					end

					if var_387_1.prefab_name ~= "" and arg_384_1.actors_[var_387_1.prefab_name] ~= nil then
						local var_387_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_384_1.actors_[var_387_1.prefab_name].transform, "story_v_out_319501", "319501093", "story_v_out_319501.awb")

						arg_384_1:RecordAudio("319501093", var_387_6)
						arg_384_1:RecordAudio("319501093", var_387_6)
					else
						arg_384_1:AudioAction("play", "voice", "story_v_out_319501", "319501093", "story_v_out_319501.awb")
					end

					arg_384_1:RecordHistoryTalkVoice("story_v_out_319501", "319501093", "story_v_out_319501.awb")
				end

				arg_384_1:RecordContent(arg_384_1.text_.text)
			end

			local var_387_7 = math.max(var_387_0, arg_384_1.talkMaxDuration)

			if 0 <= arg_384_1.time_ and arg_384_1.time_ < 0 + var_387_7 then
				arg_384_1.typewritter.percent = (arg_384_1.time_ - 0) / var_387_7

				arg_384_1.typewritter:SetDirty()
			end

			if arg_384_1.time_ >= 0 + var_387_7 and arg_384_1.time_ < 0 + var_387_7 + arg_387_0 then
				arg_384_1.typewritter.percent = 1

				arg_384_1.typewritter:SetDirty()
				arg_384_1:ShowNextGo(true)
			end
		end

		arg_384_1.nodeConfigList_ = {}

		arg_384_1:InitPlayNodeList()
	end,
	Play319501094 = function(arg_388_0, arg_388_1)
		arg_388_1.time_ = 0
		arg_388_1.frameCnt_ = 0
		arg_388_1.state_ = "playing"
		arg_388_1.curTalkId_ = 319501094
		arg_388_1.duration_ = 6.83

		local var_388_0 = {
			zh = 6.833,
			ja = 6.233
		}
		local var_388_1 = manager.audio:GetLocalizationFlag()

		if var_388_0[var_388_1] ~= nil then
			arg_388_1.duration_ = var_388_0[var_388_1]
		end

		SetActive(arg_388_1.tipsGo_, false)

		function arg_388_1.onSingleLineFinish_()
			arg_388_1.onSingleLineUpdate_ = nil
			arg_388_1.onSingleLineFinish_ = nil
			arg_388_1.state_ = "waiting"
		end

		function arg_388_1.playNext_(arg_390_0)
			if arg_390_0 == 1 then
				arg_388_0:Play319501095(arg_388_1)
			end
		end

		function arg_388_1.onSingleLineUpdate_(arg_391_0)
			local var_391_0 = 0.725

			if 0 < arg_388_1.time_ and arg_388_1.time_ <= 0 + arg_391_0 then
				arg_388_1.talkMaxDuration = 0
				arg_388_1.dialogCg_.alpha = 1

				arg_388_1.dialog_:SetActive(true)
				SetActive(arg_388_1.leftNameGo_, true)

				arg_388_1.leftNameTxt_.text = arg_388_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_388_1.leftNameTxt_.transform)

				arg_388_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_388_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_388_1:RecordName(arg_388_1.leftNameTxt_.text)
				SetActive(arg_388_1.iconTrs_.gameObject, false)
				arg_388_1.callingController_:SetSelectedState("normal")

				local var_391_1 = arg_388_1:GetWordFromCfg(319501094)
				local var_391_2 = arg_388_1:FormatText(var_391_1.content)

				arg_388_1.text_.text = var_391_2

				LuaForUtil.ClearLinePrefixSymbol(arg_388_1.text_)

				local var_391_4 = 29 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 29)

				if (29 <= 0 and var_391_0 or var_391_0 * (utf8.len(var_391_2) / 29)) > 0 and var_391_0 < var_391_4 then
					arg_388_1.talkMaxDuration = var_391_4

					if var_391_4 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_4 + 0
					end
				end

				arg_388_1.text_.text = var_391_2
				arg_388_1.typewritter.percent = 0

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501094", "story_v_out_319501.awb") ~= 0 then
					local var_391_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501094", "story_v_out_319501.awb") / 1000

					if var_391_5 + 0 > arg_388_1.duration_ then
						arg_388_1.duration_ = var_391_5 + 0
					end

					if var_391_1.prefab_name ~= "" and arg_388_1.actors_[var_391_1.prefab_name] ~= nil then
						local var_391_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_388_1.actors_[var_391_1.prefab_name].transform, "story_v_out_319501", "319501094", "story_v_out_319501.awb")

						arg_388_1:RecordAudio("319501094", var_391_6)
						arg_388_1:RecordAudio("319501094", var_391_6)
					else
						arg_388_1:AudioAction("play", "voice", "story_v_out_319501", "319501094", "story_v_out_319501.awb")
					end

					arg_388_1:RecordHistoryTalkVoice("story_v_out_319501", "319501094", "story_v_out_319501.awb")
				end

				arg_388_1:RecordContent(arg_388_1.text_.text)
			end

			local var_391_7 = math.max(var_391_0, arg_388_1.talkMaxDuration)

			if 0 <= arg_388_1.time_ and arg_388_1.time_ < 0 + var_391_7 then
				arg_388_1.typewritter.percent = (arg_388_1.time_ - 0) / var_391_7

				arg_388_1.typewritter:SetDirty()
			end

			if arg_388_1.time_ >= 0 + var_391_7 and arg_388_1.time_ < 0 + var_391_7 + arg_391_0 then
				arg_388_1.typewritter.percent = 1

				arg_388_1.typewritter:SetDirty()
				arg_388_1:ShowNextGo(true)
			end
		end

		arg_388_1.nodeConfigList_ = {}

		arg_388_1:InitPlayNodeList()
	end,
	Play319501095 = function(arg_392_0, arg_392_1)
		arg_392_1.time_ = 0
		arg_392_1.frameCnt_ = 0
		arg_392_1.state_ = "playing"
		arg_392_1.curTalkId_ = 319501095
		arg_392_1.duration_ = 16.37

		local var_392_0 = {
			zh = 12.066,
			ja = 16.366
		}
		local var_392_1 = manager.audio:GetLocalizationFlag()

		if var_392_0[var_392_1] ~= nil then
			arg_392_1.duration_ = var_392_0[var_392_1]
		end

		SetActive(arg_392_1.tipsGo_, false)

		function arg_392_1.onSingleLineFinish_()
			arg_392_1.onSingleLineUpdate_ = nil
			arg_392_1.onSingleLineFinish_ = nil
			arg_392_1.state_ = "waiting"
		end

		function arg_392_1.playNext_(arg_394_0)
			if arg_394_0 == 1 then
				arg_392_0:Play319501096(arg_392_1)
			end
		end

		function arg_392_1.onSingleLineUpdate_(arg_395_0)
			local var_395_0 = 1.275

			if 0 < arg_392_1.time_ and arg_392_1.time_ <= 0 + arg_395_0 then
				arg_392_1.talkMaxDuration = 0
				arg_392_1.dialogCg_.alpha = 1

				arg_392_1.dialog_:SetActive(true)
				SetActive(arg_392_1.leftNameGo_, true)

				arg_392_1.leftNameTxt_.text = arg_392_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_392_1.leftNameTxt_.transform)

				arg_392_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_392_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_392_1:RecordName(arg_392_1.leftNameTxt_.text)
				SetActive(arg_392_1.iconTrs_.gameObject, false)
				arg_392_1.callingController_:SetSelectedState("normal")

				local var_395_1 = arg_392_1:GetWordFromCfg(319501095)
				local var_395_2 = arg_392_1:FormatText(var_395_1.content)

				arg_392_1.text_.text = var_395_2

				LuaForUtil.ClearLinePrefixSymbol(arg_392_1.text_)

				local var_395_4 = 51 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 51)

				if (51 <= 0 and var_395_0 or var_395_0 * (utf8.len(var_395_2) / 51)) > 0 and var_395_0 < var_395_4 then
					arg_392_1.talkMaxDuration = var_395_4

					if var_395_4 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_4 + 0
					end
				end

				arg_392_1.text_.text = var_395_2
				arg_392_1.typewritter.percent = 0

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501095", "story_v_out_319501.awb") ~= 0 then
					local var_395_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501095", "story_v_out_319501.awb") / 1000

					if var_395_5 + 0 > arg_392_1.duration_ then
						arg_392_1.duration_ = var_395_5 + 0
					end

					if var_395_1.prefab_name ~= "" and arg_392_1.actors_[var_395_1.prefab_name] ~= nil then
						local var_395_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_392_1.actors_[var_395_1.prefab_name].transform, "story_v_out_319501", "319501095", "story_v_out_319501.awb")

						arg_392_1:RecordAudio("319501095", var_395_6)
						arg_392_1:RecordAudio("319501095", var_395_6)
					else
						arg_392_1:AudioAction("play", "voice", "story_v_out_319501", "319501095", "story_v_out_319501.awb")
					end

					arg_392_1:RecordHistoryTalkVoice("story_v_out_319501", "319501095", "story_v_out_319501.awb")
				end

				arg_392_1:RecordContent(arg_392_1.text_.text)
			end

			local var_395_7 = math.max(var_395_0, arg_392_1.talkMaxDuration)

			if 0 <= arg_392_1.time_ and arg_392_1.time_ < 0 + var_395_7 then
				arg_392_1.typewritter.percent = (arg_392_1.time_ - 0) / var_395_7

				arg_392_1.typewritter:SetDirty()
			end

			if arg_392_1.time_ >= 0 + var_395_7 and arg_392_1.time_ < 0 + var_395_7 + arg_395_0 then
				arg_392_1.typewritter.percent = 1

				arg_392_1.typewritter:SetDirty()
				arg_392_1:ShowNextGo(true)
			end
		end

		arg_392_1.nodeConfigList_ = {}

		arg_392_1:InitPlayNodeList()
	end,
	Play319501096 = function(arg_396_0, arg_396_1)
		arg_396_1.time_ = 0
		arg_396_1.frameCnt_ = 0
		arg_396_1.state_ = "playing"
		arg_396_1.curTalkId_ = 319501096
		arg_396_1.duration_ = 10.73

		local var_396_0 = {
			zh = 7.8,
			ja = 10.733
		}
		local var_396_1 = manager.audio:GetLocalizationFlag()

		if var_396_0[var_396_1] ~= nil then
			arg_396_1.duration_ = var_396_0[var_396_1]
		end

		SetActive(arg_396_1.tipsGo_, false)

		function arg_396_1.onSingleLineFinish_()
			arg_396_1.onSingleLineUpdate_ = nil
			arg_396_1.onSingleLineFinish_ = nil
			arg_396_1.state_ = "waiting"
		end

		function arg_396_1.playNext_(arg_398_0)
			if arg_398_0 == 1 then
				arg_396_0:Play319501097(arg_396_1)
			end
		end

		function arg_396_1.onSingleLineUpdate_(arg_399_0)
			local var_399_0 = 0.775

			if 0 < arg_396_1.time_ and arg_396_1.time_ <= 0 + arg_399_0 then
				arg_396_1.talkMaxDuration = 0
				arg_396_1.dialogCg_.alpha = 1

				arg_396_1.dialog_:SetActive(true)
				SetActive(arg_396_1.leftNameGo_, true)

				arg_396_1.leftNameTxt_.text = arg_396_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_396_1.leftNameTxt_.transform)

				arg_396_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_396_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_396_1:RecordName(arg_396_1.leftNameTxt_.text)
				SetActive(arg_396_1.iconTrs_.gameObject, false)
				arg_396_1.callingController_:SetSelectedState("normal")

				local var_399_1 = arg_396_1:GetWordFromCfg(319501096)
				local var_399_2 = arg_396_1:FormatText(var_399_1.content)

				arg_396_1.text_.text = var_399_2

				LuaForUtil.ClearLinePrefixSymbol(arg_396_1.text_)

				local var_399_4 = 31 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 31)

				if (31 <= 0 and var_399_0 or var_399_0 * (utf8.len(var_399_2) / 31)) > 0 and var_399_0 < var_399_4 then
					arg_396_1.talkMaxDuration = var_399_4

					if var_399_4 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_4 + 0
					end
				end

				arg_396_1.text_.text = var_399_2
				arg_396_1.typewritter.percent = 0

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501096", "story_v_out_319501.awb") ~= 0 then
					local var_399_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501096", "story_v_out_319501.awb") / 1000

					if var_399_5 + 0 > arg_396_1.duration_ then
						arg_396_1.duration_ = var_399_5 + 0
					end

					if var_399_1.prefab_name ~= "" and arg_396_1.actors_[var_399_1.prefab_name] ~= nil then
						local var_399_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_396_1.actors_[var_399_1.prefab_name].transform, "story_v_out_319501", "319501096", "story_v_out_319501.awb")

						arg_396_1:RecordAudio("319501096", var_399_6)
						arg_396_1:RecordAudio("319501096", var_399_6)
					else
						arg_396_1:AudioAction("play", "voice", "story_v_out_319501", "319501096", "story_v_out_319501.awb")
					end

					arg_396_1:RecordHistoryTalkVoice("story_v_out_319501", "319501096", "story_v_out_319501.awb")
				end

				arg_396_1:RecordContent(arg_396_1.text_.text)
			end

			local var_399_7 = math.max(var_399_0, arg_396_1.talkMaxDuration)

			if 0 <= arg_396_1.time_ and arg_396_1.time_ < 0 + var_399_7 then
				arg_396_1.typewritter.percent = (arg_396_1.time_ - 0) / var_399_7

				arg_396_1.typewritter:SetDirty()
			end

			if arg_396_1.time_ >= 0 + var_399_7 and arg_396_1.time_ < 0 + var_399_7 + arg_399_0 then
				arg_396_1.typewritter.percent = 1

				arg_396_1.typewritter:SetDirty()
				arg_396_1:ShowNextGo(true)
			end
		end

		arg_396_1.nodeConfigList_ = {}

		arg_396_1:InitPlayNodeList()
	end,
	Play319501097 = function(arg_400_0, arg_400_1)
		arg_400_1.time_ = 0
		arg_400_1.frameCnt_ = 0
		arg_400_1.state_ = "playing"
		arg_400_1.curTalkId_ = 319501097
		arg_400_1.duration_ = 14.17

		local var_400_0 = {
			zh = 8.566,
			ja = 14.166
		}
		local var_400_1 = manager.audio:GetLocalizationFlag()

		if var_400_0[var_400_1] ~= nil then
			arg_400_1.duration_ = var_400_0[var_400_1]
		end

		SetActive(arg_400_1.tipsGo_, false)

		function arg_400_1.onSingleLineFinish_()
			arg_400_1.onSingleLineUpdate_ = nil
			arg_400_1.onSingleLineFinish_ = nil
			arg_400_1.state_ = "waiting"
		end

		function arg_400_1.playNext_(arg_402_0)
			if arg_402_0 == 1 then
				arg_400_0:Play319501098(arg_400_1)
			end
		end

		function arg_400_1.onSingleLineUpdate_(arg_403_0)
			local var_403_0 = 0.925

			if 0 < arg_400_1.time_ and arg_400_1.time_ <= 0 + arg_403_0 then
				arg_400_1.talkMaxDuration = 0
				arg_400_1.dialogCg_.alpha = 1

				arg_400_1.dialog_:SetActive(true)
				SetActive(arg_400_1.leftNameGo_, true)

				arg_400_1.leftNameTxt_.text = arg_400_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_400_1.leftNameTxt_.transform)

				arg_400_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_400_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_400_1:RecordName(arg_400_1.leftNameTxt_.text)
				SetActive(arg_400_1.iconTrs_.gameObject, false)
				arg_400_1.callingController_:SetSelectedState("normal")

				local var_403_1 = arg_400_1:GetWordFromCfg(319501097)
				local var_403_2 = arg_400_1:FormatText(var_403_1.content)

				arg_400_1.text_.text = var_403_2

				LuaForUtil.ClearLinePrefixSymbol(arg_400_1.text_)

				local var_403_4 = 37 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 37)

				if (37 <= 0 and var_403_0 or var_403_0 * (utf8.len(var_403_2) / 37)) > 0 and var_403_0 < var_403_4 then
					arg_400_1.talkMaxDuration = var_403_4

					if var_403_4 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_4 + 0
					end
				end

				arg_400_1.text_.text = var_403_2
				arg_400_1.typewritter.percent = 0

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501097", "story_v_out_319501.awb") ~= 0 then
					local var_403_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501097", "story_v_out_319501.awb") / 1000

					if var_403_5 + 0 > arg_400_1.duration_ then
						arg_400_1.duration_ = var_403_5 + 0
					end

					if var_403_1.prefab_name ~= "" and arg_400_1.actors_[var_403_1.prefab_name] ~= nil then
						local var_403_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_400_1.actors_[var_403_1.prefab_name].transform, "story_v_out_319501", "319501097", "story_v_out_319501.awb")

						arg_400_1:RecordAudio("319501097", var_403_6)
						arg_400_1:RecordAudio("319501097", var_403_6)
					else
						arg_400_1:AudioAction("play", "voice", "story_v_out_319501", "319501097", "story_v_out_319501.awb")
					end

					arg_400_1:RecordHistoryTalkVoice("story_v_out_319501", "319501097", "story_v_out_319501.awb")
				end

				arg_400_1:RecordContent(arg_400_1.text_.text)
			end

			local var_403_7 = math.max(var_403_0, arg_400_1.talkMaxDuration)

			if 0 <= arg_400_1.time_ and arg_400_1.time_ < 0 + var_403_7 then
				arg_400_1.typewritter.percent = (arg_400_1.time_ - 0) / var_403_7

				arg_400_1.typewritter:SetDirty()
			end

			if arg_400_1.time_ >= 0 + var_403_7 and arg_400_1.time_ < 0 + var_403_7 + arg_403_0 then
				arg_400_1.typewritter.percent = 1

				arg_400_1.typewritter:SetDirty()
				arg_400_1:ShowNextGo(true)
			end
		end

		arg_400_1.nodeConfigList_ = {}

		arg_400_1:InitPlayNodeList()
	end,
	Play319501098 = function(arg_404_0, arg_404_1)
		arg_404_1.time_ = 0
		arg_404_1.frameCnt_ = 0
		arg_404_1.state_ = "playing"
		arg_404_1.curTalkId_ = 319501098
		arg_404_1.duration_ = 16.7

		local var_404_0 = {
			zh = 11.3,
			ja = 16.7
		}
		local var_404_1 = manager.audio:GetLocalizationFlag()

		if var_404_0[var_404_1] ~= nil then
			arg_404_1.duration_ = var_404_0[var_404_1]
		end

		SetActive(arg_404_1.tipsGo_, false)

		function arg_404_1.onSingleLineFinish_()
			arg_404_1.onSingleLineUpdate_ = nil
			arg_404_1.onSingleLineFinish_ = nil
			arg_404_1.state_ = "waiting"
		end

		function arg_404_1.playNext_(arg_406_0)
			if arg_406_0 == 1 then
				arg_404_0:Play319501099(arg_404_1)
			end
		end

		function arg_404_1.onSingleLineUpdate_(arg_407_0)
			local var_407_0 = 1.275

			if 0 < arg_404_1.time_ and arg_404_1.time_ <= 0 + arg_407_0 then
				arg_404_1.talkMaxDuration = 0
				arg_404_1.dialogCg_.alpha = 1

				arg_404_1.dialog_:SetActive(true)
				SetActive(arg_404_1.leftNameGo_, true)

				arg_404_1.leftNameTxt_.text = arg_404_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_404_1.leftNameTxt_.transform)

				arg_404_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_404_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_404_1:RecordName(arg_404_1.leftNameTxt_.text)
				SetActive(arg_404_1.iconTrs_.gameObject, false)
				arg_404_1.callingController_:SetSelectedState("normal")

				local var_407_1 = arg_404_1:GetWordFromCfg(319501098)
				local var_407_2 = arg_404_1:FormatText(var_407_1.content)

				arg_404_1.text_.text = var_407_2

				LuaForUtil.ClearLinePrefixSymbol(arg_404_1.text_)

				local var_407_4 = 51 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 51)

				if (51 <= 0 and var_407_0 or var_407_0 * (utf8.len(var_407_2) / 51)) > 0 and var_407_0 < var_407_4 then
					arg_404_1.talkMaxDuration = var_407_4

					if var_407_4 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_4 + 0
					end
				end

				arg_404_1.text_.text = var_407_2
				arg_404_1.typewritter.percent = 0

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501098", "story_v_out_319501.awb") ~= 0 then
					local var_407_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501098", "story_v_out_319501.awb") / 1000

					if var_407_5 + 0 > arg_404_1.duration_ then
						arg_404_1.duration_ = var_407_5 + 0
					end

					if var_407_1.prefab_name ~= "" and arg_404_1.actors_[var_407_1.prefab_name] ~= nil then
						local var_407_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_404_1.actors_[var_407_1.prefab_name].transform, "story_v_out_319501", "319501098", "story_v_out_319501.awb")

						arg_404_1:RecordAudio("319501098", var_407_6)
						arg_404_1:RecordAudio("319501098", var_407_6)
					else
						arg_404_1:AudioAction("play", "voice", "story_v_out_319501", "319501098", "story_v_out_319501.awb")
					end

					arg_404_1:RecordHistoryTalkVoice("story_v_out_319501", "319501098", "story_v_out_319501.awb")
				end

				arg_404_1:RecordContent(arg_404_1.text_.text)
			end

			local var_407_7 = math.max(var_407_0, arg_404_1.talkMaxDuration)

			if 0 <= arg_404_1.time_ and arg_404_1.time_ < 0 + var_407_7 then
				arg_404_1.typewritter.percent = (arg_404_1.time_ - 0) / var_407_7

				arg_404_1.typewritter:SetDirty()
			end

			if arg_404_1.time_ >= 0 + var_407_7 and arg_404_1.time_ < 0 + var_407_7 + arg_407_0 then
				arg_404_1.typewritter.percent = 1

				arg_404_1.typewritter:SetDirty()
				arg_404_1:ShowNextGo(true)
			end
		end

		arg_404_1.nodeConfigList_ = {}

		arg_404_1:InitPlayNodeList()
	end,
	Play319501099 = function(arg_408_0, arg_408_1)
		arg_408_1.time_ = 0
		arg_408_1.frameCnt_ = 0
		arg_408_1.state_ = "playing"
		arg_408_1.curTalkId_ = 319501099
		arg_408_1.duration_ = 11.7

		local var_408_0 = {
			zh = 7.8,
			ja = 11.7
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
				arg_408_0:Play319501100(arg_408_1)
			end
		end

		function arg_408_1.onSingleLineUpdate_(arg_411_0)
			local var_411_0 = 0.95

			if 0 < arg_408_1.time_ and arg_408_1.time_ <= 0 + arg_411_0 then
				arg_408_1.talkMaxDuration = 0
				arg_408_1.dialogCg_.alpha = 1

				arg_408_1.dialog_:SetActive(true)
				SetActive(arg_408_1.leftNameGo_, true)

				arg_408_1.leftNameTxt_.text = arg_408_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_408_1.leftNameTxt_.transform)

				arg_408_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_408_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_408_1:RecordName(arg_408_1.leftNameTxt_.text)
				SetActive(arg_408_1.iconTrs_.gameObject, false)
				arg_408_1.callingController_:SetSelectedState("normal")

				local var_411_1 = arg_408_1:GetWordFromCfg(319501099)
				local var_411_2 = arg_408_1:FormatText(var_411_1.content)

				arg_408_1.text_.text = var_411_2

				LuaForUtil.ClearLinePrefixSymbol(arg_408_1.text_)

				local var_411_4 = 38 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 38)

				if (38 <= 0 and var_411_0 or var_411_0 * (utf8.len(var_411_2) / 38)) > 0 and var_411_0 < var_411_4 then
					arg_408_1.talkMaxDuration = var_411_4

					if var_411_4 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_4 + 0
					end
				end

				arg_408_1.text_.text = var_411_2
				arg_408_1.typewritter.percent = 0

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501099", "story_v_out_319501.awb") ~= 0 then
					local var_411_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501099", "story_v_out_319501.awb") / 1000

					if var_411_5 + 0 > arg_408_1.duration_ then
						arg_408_1.duration_ = var_411_5 + 0
					end

					if var_411_1.prefab_name ~= "" and arg_408_1.actors_[var_411_1.prefab_name] ~= nil then
						local var_411_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_408_1.actors_[var_411_1.prefab_name].transform, "story_v_out_319501", "319501099", "story_v_out_319501.awb")

						arg_408_1:RecordAudio("319501099", var_411_6)
						arg_408_1:RecordAudio("319501099", var_411_6)
					else
						arg_408_1:AudioAction("play", "voice", "story_v_out_319501", "319501099", "story_v_out_319501.awb")
					end

					arg_408_1:RecordHistoryTalkVoice("story_v_out_319501", "319501099", "story_v_out_319501.awb")
				end

				arg_408_1:RecordContent(arg_408_1.text_.text)
			end

			local var_411_7 = math.max(var_411_0, arg_408_1.talkMaxDuration)

			if 0 <= arg_408_1.time_ and arg_408_1.time_ < 0 + var_411_7 then
				arg_408_1.typewritter.percent = (arg_408_1.time_ - 0) / var_411_7

				arg_408_1.typewritter:SetDirty()
			end

			if arg_408_1.time_ >= 0 + var_411_7 and arg_408_1.time_ < 0 + var_411_7 + arg_411_0 then
				arg_408_1.typewritter.percent = 1

				arg_408_1.typewritter:SetDirty()
				arg_408_1:ShowNextGo(true)
			end
		end

		arg_408_1.nodeConfigList_ = {}

		arg_408_1:InitPlayNodeList()
	end,
	Play319501100 = function(arg_412_0, arg_412_1)
		arg_412_1.time_ = 0
		arg_412_1.frameCnt_ = 0
		arg_412_1.state_ = "playing"
		arg_412_1.curTalkId_ = 319501100
		arg_412_1.duration_ = 6.8

		local var_412_0 = {
			zh = 5.833,
			ja = 6.8
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
				arg_412_0:Play319501101(arg_412_1)
			end
		end

		function arg_412_1.onSingleLineUpdate_(arg_415_0)
			local var_415_0 = 0.675

			if 0 < arg_412_1.time_ and arg_412_1.time_ <= 0 + arg_415_0 then
				arg_412_1.talkMaxDuration = 0
				arg_412_1.dialogCg_.alpha = 1

				arg_412_1.dialog_:SetActive(true)
				SetActive(arg_412_1.leftNameGo_, true)

				arg_412_1.leftNameTxt_.text = arg_412_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_412_1.leftNameTxt_.transform)

				arg_412_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_412_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_412_1:RecordName(arg_412_1.leftNameTxt_.text)
				SetActive(arg_412_1.iconTrs_.gameObject, false)
				arg_412_1.callingController_:SetSelectedState("normal")

				local var_415_1 = arg_412_1:GetWordFromCfg(319501100)
				local var_415_2 = arg_412_1:FormatText(var_415_1.content)

				arg_412_1.text_.text = var_415_2

				LuaForUtil.ClearLinePrefixSymbol(arg_412_1.text_)

				local var_415_4 = 27 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 27)

				if (27 <= 0 and var_415_0 or var_415_0 * (utf8.len(var_415_2) / 27)) > 0 and var_415_0 < var_415_4 then
					arg_412_1.talkMaxDuration = var_415_4

					if var_415_4 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_4 + 0
					end
				end

				arg_412_1.text_.text = var_415_2
				arg_412_1.typewritter.percent = 0

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501100", "story_v_out_319501.awb") ~= 0 then
					local var_415_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501100", "story_v_out_319501.awb") / 1000

					if var_415_5 + 0 > arg_412_1.duration_ then
						arg_412_1.duration_ = var_415_5 + 0
					end

					if var_415_1.prefab_name ~= "" and arg_412_1.actors_[var_415_1.prefab_name] ~= nil then
						local var_415_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_412_1.actors_[var_415_1.prefab_name].transform, "story_v_out_319501", "319501100", "story_v_out_319501.awb")

						arg_412_1:RecordAudio("319501100", var_415_6)
						arg_412_1:RecordAudio("319501100", var_415_6)
					else
						arg_412_1:AudioAction("play", "voice", "story_v_out_319501", "319501100", "story_v_out_319501.awb")
					end

					arg_412_1:RecordHistoryTalkVoice("story_v_out_319501", "319501100", "story_v_out_319501.awb")
				end

				arg_412_1:RecordContent(arg_412_1.text_.text)
			end

			local var_415_7 = math.max(var_415_0, arg_412_1.talkMaxDuration)

			if 0 <= arg_412_1.time_ and arg_412_1.time_ < 0 + var_415_7 then
				arg_412_1.typewritter.percent = (arg_412_1.time_ - 0) / var_415_7

				arg_412_1.typewritter:SetDirty()
			end

			if arg_412_1.time_ >= 0 + var_415_7 and arg_412_1.time_ < 0 + var_415_7 + arg_415_0 then
				arg_412_1.typewritter.percent = 1

				arg_412_1.typewritter:SetDirty()
				arg_412_1:ShowNextGo(true)
			end
		end

		arg_412_1.nodeConfigList_ = {}

		arg_412_1:InitPlayNodeList()
	end,
	Play319501101 = function(arg_416_0, arg_416_1)
		arg_416_1.time_ = 0
		arg_416_1.frameCnt_ = 0
		arg_416_1.state_ = "playing"
		arg_416_1.curTalkId_ = 319501101
		arg_416_1.duration_ = 2.43

		local var_416_0 = {
			zh = 1.033,
			ja = 2.433
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
				arg_416_0:Play319501102(arg_416_1)
			end
		end

		function arg_416_1.onSingleLineUpdate_(arg_419_0)
			local var_419_0 = 0.1

			if 0 < arg_416_1.time_ and arg_416_1.time_ <= 0 + arg_419_0 then
				arg_416_1.talkMaxDuration = 0
				arg_416_1.dialogCg_.alpha = 1

				arg_416_1.dialog_:SetActive(true)
				SetActive(arg_416_1.leftNameGo_, true)

				arg_416_1.leftNameTxt_.text = arg_416_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_416_1.leftNameTxt_.transform)

				arg_416_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_416_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_416_1:RecordName(arg_416_1.leftNameTxt_.text)
				SetActive(arg_416_1.iconTrs_.gameObject, false)
				arg_416_1.callingController_:SetSelectedState("normal")

				local var_419_1 = arg_416_1:GetWordFromCfg(319501101)
				local var_419_2 = arg_416_1:FormatText(var_419_1.content)

				arg_416_1.text_.text = var_419_2

				LuaForUtil.ClearLinePrefixSymbol(arg_416_1.text_)

				local var_419_4 = 4 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 4)

				if (4 <= 0 and var_419_0 or var_419_0 * (utf8.len(var_419_2) / 4)) > 0 and var_419_0 < var_419_4 then
					arg_416_1.talkMaxDuration = var_419_4

					if var_419_4 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_4 + 0
					end
				end

				arg_416_1.text_.text = var_419_2
				arg_416_1.typewritter.percent = 0

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501101", "story_v_out_319501.awb") ~= 0 then
					local var_419_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501101", "story_v_out_319501.awb") / 1000

					if var_419_5 + 0 > arg_416_1.duration_ then
						arg_416_1.duration_ = var_419_5 + 0
					end

					if var_419_1.prefab_name ~= "" and arg_416_1.actors_[var_419_1.prefab_name] ~= nil then
						local var_419_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_416_1.actors_[var_419_1.prefab_name].transform, "story_v_out_319501", "319501101", "story_v_out_319501.awb")

						arg_416_1:RecordAudio("319501101", var_419_6)
						arg_416_1:RecordAudio("319501101", var_419_6)
					else
						arg_416_1:AudioAction("play", "voice", "story_v_out_319501", "319501101", "story_v_out_319501.awb")
					end

					arg_416_1:RecordHistoryTalkVoice("story_v_out_319501", "319501101", "story_v_out_319501.awb")
				end

				arg_416_1:RecordContent(arg_416_1.text_.text)
			end

			local var_419_7 = math.max(var_419_0, arg_416_1.talkMaxDuration)

			if 0 <= arg_416_1.time_ and arg_416_1.time_ < 0 + var_419_7 then
				arg_416_1.typewritter.percent = (arg_416_1.time_ - 0) / var_419_7

				arg_416_1.typewritter:SetDirty()
			end

			if arg_416_1.time_ >= 0 + var_419_7 and arg_416_1.time_ < 0 + var_419_7 + arg_419_0 then
				arg_416_1.typewritter.percent = 1

				arg_416_1.typewritter:SetDirty()
				arg_416_1:ShowNextGo(true)
			end
		end

		arg_416_1.nodeConfigList_ = {}

		arg_416_1:InitPlayNodeList()
	end,
	Play319501102 = function(arg_420_0, arg_420_1)
		arg_420_1.time_ = 0
		arg_420_1.frameCnt_ = 0
		arg_420_1.state_ = "playing"
		arg_420_1.curTalkId_ = 319501102
		arg_420_1.duration_ = 4.52

		SetActive(arg_420_1.tipsGo_, false)

		function arg_420_1.onSingleLineFinish_()
			arg_420_1.onSingleLineUpdate_ = nil
			arg_420_1.onSingleLineFinish_ = nil
			arg_420_1.state_ = "waiting"
		end

		function arg_420_1.playNext_(arg_422_0)
			if arg_422_0 == 1 then
				arg_420_0:Play319501103(arg_420_1)
			end
		end

		function arg_420_1.onSingleLineUpdate_(arg_423_0)
			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.mask_.enabled = true
				arg_420_1.mask_.raycastTarget = true

				arg_420_1:SetGaussion(false)
			end

			local var_423_0 = 2

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_0 then
				local var_423_1 = Color.New(1, 1, 1)

				var_423_1.a = Mathf.Lerp(1, 0, (arg_420_1.time_ - 0) / var_423_0)
				arg_420_1.mask_.color = var_423_1
			end

			if arg_420_1.time_ >= 0 + var_423_0 and arg_420_1.time_ < 0 + var_423_0 + arg_423_0 then
				local var_423_2 = Color.New(1, 1, 1)

				arg_420_1.mask_.enabled = false
				var_423_2.a = 0
				arg_420_1.mask_.color = var_423_2
			end

			local var_423_3 = arg_420_1.bgs_.ML0105.transform

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= 0 + arg_423_0 then
				arg_420_1.var_.moveOldPosML0105 = var_423_3.localPosition
			end

			local var_423_4 = 0.001

			if 0 <= arg_420_1.time_ and arg_420_1.time_ < 0 + var_423_4 then
				var_423_3.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosML0105, Vector3.New(0, 1, 9.5), (arg_420_1.time_ - 0) / var_423_4)
			end

			if arg_420_1.time_ >= 0 + var_423_4 and arg_420_1.time_ < 0 + var_423_4 + arg_423_0 then
				var_423_3.localPosition = Vector3.New(0, 1, 9.5)
			end

			local var_423_5 = arg_420_1.bgs_.ML0105.transform

			if 0.0166666666666667 < arg_420_1.time_ and arg_420_1.time_ <= 0.0166666666666667 + arg_423_0 then
				arg_420_1.var_.moveOldPosML0105 = var_423_5.localPosition
			end

			local var_423_6 = 4.5

			if 0.0166666666666667 <= arg_420_1.time_ and arg_420_1.time_ < 0.0166666666666667 + var_423_6 then
				var_423_5.localPosition = Vector3.Lerp(arg_420_1.var_.moveOldPosML0105, Vector3.New(0, 1, 10), (arg_420_1.time_ - 0.0166666666666667) / var_423_6)
			end

			if arg_420_1.time_ >= 0.0166666666666667 + var_423_6 and arg_420_1.time_ < 0.0166666666666667 + var_423_6 + arg_423_0 then
				var_423_5.localPosition = Vector3.New(0, 1, 10)
			end

			local var_423_7 = 0
			local var_423_8 = 0.4

			if 0 < arg_420_1.time_ and arg_420_1.time_ <= var_423_7 + arg_423_0 then
				arg_420_1.talkMaxDuration = 0
				arg_420_1.dialogCg_.alpha = 1

				arg_420_1.dialog_:SetActive(true)
				SetActive(arg_420_1.leftNameGo_, true)

				arg_420_1.leftNameTxt_.text = arg_420_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_420_1.leftNameTxt_.transform)

				arg_420_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_420_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_420_1:RecordName(arg_420_1.leftNameTxt_.text)
				SetActive(arg_420_1.iconTrs_.gameObject, false)
				arg_420_1.callingController_:SetSelectedState("normal")

				local var_423_9 = arg_420_1:GetWordFromCfg(319501102)
				local var_423_10 = arg_420_1:FormatText(var_423_9.content)

				arg_420_1.text_.text = var_423_10

				LuaForUtil.ClearLinePrefixSymbol(arg_420_1.text_)

				local var_423_12 = 16 <= 0 and var_423_8 or var_423_8 * (utf8.len(var_423_10) / 16)

				if (16 <= 0 and var_423_8 or var_423_8 * (utf8.len(var_423_10) / 16)) > 0 and var_423_8 < var_423_12 then
					arg_420_1.talkMaxDuration = var_423_12

					if var_423_12 + var_423_7 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_12 + var_423_7
					end
				end

				arg_420_1.text_.text = var_423_10
				arg_420_1.typewritter.percent = 0

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501102", "story_v_out_319501.awb") ~= 0 then
					local var_423_13 = manager.audio:GetVoiceLength("story_v_out_319501", "319501102", "story_v_out_319501.awb") / 1000

					if var_423_13 + var_423_7 > arg_420_1.duration_ then
						arg_420_1.duration_ = var_423_13 + var_423_7
					end

					if var_423_9.prefab_name ~= "" and arg_420_1.actors_[var_423_9.prefab_name] ~= nil then
						local var_423_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_420_1.actors_[var_423_9.prefab_name].transform, "story_v_out_319501", "319501102", "story_v_out_319501.awb")

						arg_420_1:RecordAudio("319501102", var_423_14)
						arg_420_1:RecordAudio("319501102", var_423_14)
					else
						arg_420_1:AudioAction("play", "voice", "story_v_out_319501", "319501102", "story_v_out_319501.awb")
					end

					arg_420_1:RecordHistoryTalkVoice("story_v_out_319501", "319501102", "story_v_out_319501.awb")
				end

				arg_420_1:RecordContent(arg_420_1.text_.text)
			end

			local var_423_15 = math.max(var_423_8, arg_420_1.talkMaxDuration)

			if var_423_7 <= arg_420_1.time_ and arg_420_1.time_ < var_423_7 + var_423_15 then
				arg_420_1.typewritter.percent = (arg_420_1.time_ - var_423_7) / var_423_15

				arg_420_1.typewritter:SetDirty()
			end

			if arg_420_1.time_ >= var_423_7 + var_423_15 and arg_420_1.time_ < var_423_7 + var_423_15 + arg_423_0 then
				arg_420_1.typewritter.percent = 1

				arg_420_1.typewritter:SetDirty()
				arg_420_1:ShowNextGo(true)
			end
		end

		arg_420_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "ML0105",
				changeDisplayLayer = false,
				needEase = false,
				duration = 4.5,
				className = "StoryMoveNode",
				startTime = 0.0166666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_420_1:InitPlayNodeList()
	end,
	Play319501103 = function(arg_424_0, arg_424_1)
		arg_424_1.time_ = 0
		arg_424_1.frameCnt_ = 0
		arg_424_1.state_ = "playing"
		arg_424_1.curTalkId_ = 319501103
		arg_424_1.duration_ = 5.8

		local var_424_0 = {
			zh = 5.8,
			ja = 5.166
		}
		local var_424_1 = manager.audio:GetLocalizationFlag()

		if var_424_0[var_424_1] ~= nil then
			arg_424_1.duration_ = var_424_0[var_424_1]
		end

		SetActive(arg_424_1.tipsGo_, false)

		function arg_424_1.onSingleLineFinish_()
			arg_424_1.onSingleLineUpdate_ = nil
			arg_424_1.onSingleLineFinish_ = nil
			arg_424_1.state_ = "waiting"
		end

		function arg_424_1.playNext_(arg_426_0)
			if arg_426_0 == 1 then
				arg_424_0:Play319501104(arg_424_1)
			end
		end

		function arg_424_1.onSingleLineUpdate_(arg_427_0)
			local var_427_0 = 0.45

			if 0 < arg_424_1.time_ and arg_424_1.time_ <= 0 + arg_427_0 then
				arg_424_1.talkMaxDuration = 0
				arg_424_1.dialogCg_.alpha = 1

				arg_424_1.dialog_:SetActive(true)
				SetActive(arg_424_1.leftNameGo_, true)

				arg_424_1.leftNameTxt_.text = arg_424_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_424_1.leftNameTxt_.transform)

				arg_424_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_424_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_424_1:RecordName(arg_424_1.leftNameTxt_.text)
				SetActive(arg_424_1.iconTrs_.gameObject, false)
				arg_424_1.callingController_:SetSelectedState("normal")

				local var_427_1 = arg_424_1:GetWordFromCfg(319501103)
				local var_427_2 = arg_424_1:FormatText(var_427_1.content)

				arg_424_1.text_.text = var_427_2

				LuaForUtil.ClearLinePrefixSymbol(arg_424_1.text_)

				local var_427_4 = 18 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 18)

				if (18 <= 0 and var_427_0 or var_427_0 * (utf8.len(var_427_2) / 18)) > 0 and var_427_0 < var_427_4 then
					arg_424_1.talkMaxDuration = var_427_4

					if var_427_4 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_4 + 0
					end
				end

				arg_424_1.text_.text = var_427_2
				arg_424_1.typewritter.percent = 0

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501103", "story_v_out_319501.awb") ~= 0 then
					local var_427_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501103", "story_v_out_319501.awb") / 1000

					if var_427_5 + 0 > arg_424_1.duration_ then
						arg_424_1.duration_ = var_427_5 + 0
					end

					if var_427_1.prefab_name ~= "" and arg_424_1.actors_[var_427_1.prefab_name] ~= nil then
						local var_427_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_424_1.actors_[var_427_1.prefab_name].transform, "story_v_out_319501", "319501103", "story_v_out_319501.awb")

						arg_424_1:RecordAudio("319501103", var_427_6)
						arg_424_1:RecordAudio("319501103", var_427_6)
					else
						arg_424_1:AudioAction("play", "voice", "story_v_out_319501", "319501103", "story_v_out_319501.awb")
					end

					arg_424_1:RecordHistoryTalkVoice("story_v_out_319501", "319501103", "story_v_out_319501.awb")
				end

				arg_424_1:RecordContent(arg_424_1.text_.text)
			end

			local var_427_7 = math.max(var_427_0, arg_424_1.talkMaxDuration)

			if 0 <= arg_424_1.time_ and arg_424_1.time_ < 0 + var_427_7 then
				arg_424_1.typewritter.percent = (arg_424_1.time_ - 0) / var_427_7

				arg_424_1.typewritter:SetDirty()
			end

			if arg_424_1.time_ >= 0 + var_427_7 and arg_424_1.time_ < 0 + var_427_7 + arg_427_0 then
				arg_424_1.typewritter.percent = 1

				arg_424_1.typewritter:SetDirty()
				arg_424_1:ShowNextGo(true)
			end
		end

		arg_424_1.nodeConfigList_ = {}

		arg_424_1:InitPlayNodeList()
	end,
	Play319501104 = function(arg_428_0, arg_428_1)
		arg_428_1.time_ = 0
		arg_428_1.frameCnt_ = 0
		arg_428_1.state_ = "playing"
		arg_428_1.curTalkId_ = 319501104
		arg_428_1.duration_ = 9

		SetActive(arg_428_1.tipsGo_, false)

		function arg_428_1.onSingleLineFinish_()
			arg_428_1.onSingleLineUpdate_ = nil
			arg_428_1.onSingleLineFinish_ = nil
			arg_428_1.state_ = "waiting"
		end

		function arg_428_1.playNext_(arg_430_0)
			if arg_430_0 == 1 then
				arg_428_0:Play319501105(arg_428_1)
			end
		end

		function arg_428_1.onSingleLineUpdate_(arg_431_0)
			if 2 < arg_428_1.time_ and arg_428_1.time_ <= 2 + arg_431_0 then
				local var_431_0 = arg_428_1.bgs_.ST71

				arg_428_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_431_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_431_1 = var_431_0:GetComponent("SpriteRenderer")

				if var_431_1 and var_431_1.sprite then
					local var_431_2 = 2 * (var_431_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_431_0.transform.localScale = Vector3.New(var_431_2 / var_431_1.sprite.bounds.size.y < var_431_2 * manager.ui.mainCameraCom_.aspect / var_431_1.sprite.bounds.size.x and var_431_2 * manager.ui.mainCameraCom_.aspect / var_431_1.sprite.bounds.size.x or var_431_2 / var_431_1.sprite.bounds.size.y, var_431_2 / var_431_1.sprite.bounds.size.y < var_431_2 * manager.ui.mainCameraCom_.aspect / var_431_1.sprite.bounds.size.x and var_431_2 * manager.ui.mainCameraCom_.aspect / var_431_1.sprite.bounds.size.x or var_431_2 / var_431_1.sprite.bounds.size.y, 0)
				end

				for iter_431_0, iter_431_1 in pairs(arg_428_1.bgs_) do
					if iter_431_0 ~= "ST71" then
						iter_431_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_431_3 = 4

			if 4 < arg_428_1.time_ and arg_428_1.time_ <= var_431_3 + arg_431_0 then
				arg_428_1.allBtn_.enabled = false
			end

			if arg_428_1.time_ >= var_431_3 + 0.3 and arg_428_1.time_ < var_431_3 + 0.3 + arg_431_0 then
				arg_428_1.allBtn_.enabled = true
			end

			local var_431_4 = 0

			if 0 < arg_428_1.time_ and arg_428_1.time_ <= var_431_4 + arg_431_0 then
				arg_428_1.mask_.enabled = true
				arg_428_1.mask_.raycastTarget = true

				arg_428_1:SetGaussion(false)
			end

			local var_431_5 = 2

			if var_431_4 <= arg_428_1.time_ and arg_428_1.time_ < var_431_4 + var_431_5 then
				local var_431_6 = Color.New(0, 0, 0)

				var_431_6.a = Mathf.Lerp(0, 1, (arg_428_1.time_ - var_431_4) / var_431_5)
				arg_428_1.mask_.color = var_431_6
			end

			if arg_428_1.time_ >= var_431_4 + var_431_5 and arg_428_1.time_ < var_431_4 + var_431_5 + arg_431_0 then
				local var_431_7 = Color.New(0, 0, 0)

				var_431_7.a = 1
				arg_428_1.mask_.color = var_431_7
			end

			local var_431_8 = 2

			if 2 < arg_428_1.time_ and arg_428_1.time_ <= var_431_8 + arg_431_0 then
				arg_428_1.mask_.enabled = true
				arg_428_1.mask_.raycastTarget = true

				arg_428_1:SetGaussion(false)
			end

			local var_431_9 = 2

			if var_431_8 <= arg_428_1.time_ and arg_428_1.time_ < var_431_8 + var_431_9 then
				local var_431_10 = Color.New(0, 0, 0)

				var_431_10.a = Mathf.Lerp(1, 0, (arg_428_1.time_ - var_431_8) / var_431_9)
				arg_428_1.mask_.color = var_431_10
			end

			if arg_428_1.time_ >= var_431_8 + var_431_9 and arg_428_1.time_ < var_431_8 + var_431_9 + arg_431_0 then
				local var_431_11 = Color.New(0, 0, 0)

				arg_428_1.mask_.enabled = false
				var_431_11.a = 0
				arg_428_1.mask_.color = var_431_11
			end

			if arg_428_1.frameCnt_ <= 1 then
				arg_428_1.dialog_:SetActive(false)
			end

			local var_431_12 = 4
			local var_431_13 = 1.525

			if 4 < arg_428_1.time_ and arg_428_1.time_ <= var_431_12 + arg_431_0 then
				arg_428_1.talkMaxDuration = 0

				arg_428_1.dialog_:SetActive(true)

				arg_428_1.dialogCg_.alpha = 0

				local var_431_14 = LeanTween.value(arg_428_1.dialog_, 0, 1, 0.3)

				var_431_14:setOnUpdate(LuaHelper.FloatAction(function(arg_432_0)
					arg_428_1.dialogCg_.alpha = arg_432_0
				end))
				var_431_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_428_1.dialog_)
					var_431_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_428_1.duration_ = arg_428_1.duration_ + 0.3

				SetActive(arg_428_1.leftNameGo_, false)

				arg_428_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_428_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_428_1:RecordName(arg_428_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_428_1.iconTrs_.gameObject, false)
				arg_428_1.callingController_:SetSelectedState("normal")

				local var_431_15 = arg_428_1:FormatText(arg_428_1:GetWordFromCfg(319501104).content)

				arg_428_1.text_.text = var_431_15

				LuaForUtil.ClearLinePrefixSymbol(arg_428_1.text_)

				local var_431_17 = 61 <= 0 and var_431_13 or var_431_13 * (utf8.len(var_431_15) / 61)

				if (61 <= 0 and var_431_13 or var_431_13 * (utf8.len(var_431_15) / 61)) > 0 and var_431_13 < var_431_17 then
					arg_428_1.talkMaxDuration = var_431_17
					var_431_12 = var_431_12 + 0.3

					if var_431_17 + var_431_12 > arg_428_1.duration_ then
						arg_428_1.duration_ = var_431_17 + var_431_12
					end
				end

				arg_428_1.text_.text = var_431_15
				arg_428_1.typewritter.percent = 0

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(false)
				arg_428_1:RecordContent(arg_428_1.text_.text)
			end

			local var_431_18 = var_431_12 + 0.3
			local var_431_19 = math.max(var_431_13, arg_428_1.talkMaxDuration)

			if var_431_12 + 0.3 <= arg_428_1.time_ and arg_428_1.time_ < var_431_18 + var_431_19 then
				arg_428_1.typewritter.percent = (arg_428_1.time_ - var_431_18) / var_431_19

				arg_428_1.typewritter:SetDirty()
			end

			if arg_428_1.time_ >= var_431_18 + var_431_19 and arg_428_1.time_ < var_431_18 + var_431_19 + arg_431_0 then
				arg_428_1.typewritter.percent = 1

				arg_428_1.typewritter:SetDirty()
				arg_428_1:ShowNextGo(true)
			end
		end

		arg_428_1.nodeConfigList_ = {}

		arg_428_1:InitPlayNodeList()
	end,
	Play319501105 = function(arg_434_0, arg_434_1)
		arg_434_1.time_ = 0
		arg_434_1.frameCnt_ = 0
		arg_434_1.state_ = "playing"
		arg_434_1.curTalkId_ = 319501105
		arg_434_1.duration_ = 5

		SetActive(arg_434_1.tipsGo_, false)

		function arg_434_1.onSingleLineFinish_()
			arg_434_1.onSingleLineUpdate_ = nil
			arg_434_1.onSingleLineFinish_ = nil
			arg_434_1.state_ = "waiting"
		end

		function arg_434_1.playNext_(arg_436_0)
			if arg_436_0 == 1 then
				arg_434_0:Play319501106(arg_434_1)
			end
		end

		function arg_434_1.onSingleLineUpdate_(arg_437_0)
			local var_437_0 = 1.525

			if 0 < arg_434_1.time_ and arg_434_1.time_ <= 0 + arg_437_0 then
				arg_434_1.talkMaxDuration = 0
				arg_434_1.dialogCg_.alpha = 1

				arg_434_1.dialog_:SetActive(true)
				SetActive(arg_434_1.leftNameGo_, false)

				arg_434_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_434_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_434_1:RecordName(arg_434_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_434_1.iconTrs_.gameObject, false)
				arg_434_1.callingController_:SetSelectedState("normal")

				local var_437_1 = arg_434_1:FormatText(arg_434_1:GetWordFromCfg(319501105).content)

				arg_434_1.text_.text = var_437_1

				LuaForUtil.ClearLinePrefixSymbol(arg_434_1.text_)

				local var_437_3 = 61 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 61)

				if (61 <= 0 and var_437_0 or var_437_0 * (utf8.len(var_437_1) / 61)) > 0 and var_437_0 < var_437_3 then
					arg_434_1.talkMaxDuration = var_437_3

					if var_437_3 + 0 > arg_434_1.duration_ then
						arg_434_1.duration_ = var_437_3 + 0
					end
				end

				arg_434_1.text_.text = var_437_1
				arg_434_1.typewritter.percent = 0

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(false)
				arg_434_1:RecordContent(arg_434_1.text_.text)
			end

			local var_437_4 = math.max(var_437_0, arg_434_1.talkMaxDuration)

			if 0 <= arg_434_1.time_ and arg_434_1.time_ < 0 + var_437_4 then
				arg_434_1.typewritter.percent = (arg_434_1.time_ - 0) / var_437_4

				arg_434_1.typewritter:SetDirty()
			end

			if arg_434_1.time_ >= 0 + var_437_4 and arg_434_1.time_ < 0 + var_437_4 + arg_437_0 then
				arg_434_1.typewritter.percent = 1

				arg_434_1.typewritter:SetDirty()
				arg_434_1:ShowNextGo(true)
			end
		end

		arg_434_1.nodeConfigList_ = {}

		arg_434_1:InitPlayNodeList()
	end,
	Play319501106 = function(arg_438_0, arg_438_1)
		arg_438_1.time_ = 0
		arg_438_1.frameCnt_ = 0
		arg_438_1.state_ = "playing"
		arg_438_1.curTalkId_ = 319501106
		arg_438_1.duration_ = 5.9

		local var_438_0 = {
			zh = 1.833,
			ja = 5.9
		}
		local var_438_1 = manager.audio:GetLocalizationFlag()

		if var_438_0[var_438_1] ~= nil then
			arg_438_1.duration_ = var_438_0[var_438_1]
		end

		SetActive(arg_438_1.tipsGo_, false)

		function arg_438_1.onSingleLineFinish_()
			arg_438_1.onSingleLineUpdate_ = nil
			arg_438_1.onSingleLineFinish_ = nil
			arg_438_1.state_ = "waiting"
		end

		function arg_438_1.playNext_(arg_440_0)
			if arg_440_0 == 1 then
				arg_438_0:Play319501107(arg_438_1)
			end
		end

		function arg_438_1.onSingleLineUpdate_(arg_441_0)
			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1.var_.moveOldPos1084ui_story = arg_438_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_441_0 = 0.001

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_0 then
				arg_438_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_438_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_438_1.time_ - 0) / var_441_0)
				arg_438_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1084ui_story"].transform.position).z)
				arg_438_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1084ui_story"].transform.localEulerAngles = arg_438_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_438_1.time_ >= 0 + var_441_0 and arg_438_1.time_ < 0 + var_441_0 + arg_441_0 then
				arg_438_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_438_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_438_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_438_1.actors_["1084ui_story"].transform.position).z)
				arg_438_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_438_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_438_1.actors_["1084ui_story"].transform.localEulerAngles = arg_438_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_441_1 = arg_438_1.actors_["1084ui_story"]

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect1084ui_story == nil then
				arg_438_1.var_.characterEffect1084ui_story = var_441_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_441_2 = 0.200000002980232

			if 0 <= arg_438_1.time_ and arg_438_1.time_ < 0 + var_441_2 and not isNil(var_441_1) then
				if arg_438_1.var_.characterEffect1084ui_story and not isNil(var_441_1) then
					arg_438_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_438_1.time_ >= 0 + var_441_2 and arg_438_1.time_ < 0 + var_441_2 + arg_441_0 and not isNil(var_441_1) and arg_438_1.var_.characterEffect1084ui_story then
				arg_438_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= 0 + arg_441_0 then
				arg_438_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_441_4 = 0
			local var_441_5 = 0.175

			if 0 < arg_438_1.time_ and arg_438_1.time_ <= var_441_4 + arg_441_0 then
				arg_438_1.talkMaxDuration = 0
				arg_438_1.dialogCg_.alpha = 1

				arg_438_1.dialog_:SetActive(true)
				SetActive(arg_438_1.leftNameGo_, true)

				arg_438_1.leftNameTxt_.text = arg_438_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_438_1.leftNameTxt_.transform)

				arg_438_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_438_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_438_1:RecordName(arg_438_1.leftNameTxt_.text)
				SetActive(arg_438_1.iconTrs_.gameObject, false)
				arg_438_1.callingController_:SetSelectedState("normal")

				local var_441_6 = arg_438_1:GetWordFromCfg(319501106)
				local var_441_7 = arg_438_1:FormatText(var_441_6.content)

				arg_438_1.text_.text = var_441_7

				LuaForUtil.ClearLinePrefixSymbol(arg_438_1.text_)

				local var_441_9 = 7 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 7)

				if (7 <= 0 and var_441_5 or var_441_5 * (utf8.len(var_441_7) / 7)) > 0 and var_441_5 < var_441_9 then
					arg_438_1.talkMaxDuration = var_441_9

					if var_441_9 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_9 + var_441_4
					end
				end

				arg_438_1.text_.text = var_441_7
				arg_438_1.typewritter.percent = 0

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501106", "story_v_out_319501.awb") ~= 0 then
					local var_441_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501106", "story_v_out_319501.awb") / 1000

					if var_441_10 + var_441_4 > arg_438_1.duration_ then
						arg_438_1.duration_ = var_441_10 + var_441_4
					end

					if var_441_6.prefab_name ~= "" and arg_438_1.actors_[var_441_6.prefab_name] ~= nil then
						local var_441_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_438_1.actors_[var_441_6.prefab_name].transform, "story_v_out_319501", "319501106", "story_v_out_319501.awb")

						arg_438_1:RecordAudio("319501106", var_441_11)
						arg_438_1:RecordAudio("319501106", var_441_11)
					else
						arg_438_1:AudioAction("play", "voice", "story_v_out_319501", "319501106", "story_v_out_319501.awb")
					end

					arg_438_1:RecordHistoryTalkVoice("story_v_out_319501", "319501106", "story_v_out_319501.awb")
				end

				arg_438_1:RecordContent(arg_438_1.text_.text)
			end

			local var_441_12 = math.max(var_441_5, arg_438_1.talkMaxDuration)

			if var_441_4 <= arg_438_1.time_ and arg_438_1.time_ < var_441_4 + var_441_12 then
				arg_438_1.typewritter.percent = (arg_438_1.time_ - var_441_4) / var_441_12

				arg_438_1.typewritter:SetDirty()
			end

			if arg_438_1.time_ >= var_441_4 + var_441_12 and arg_438_1.time_ < var_441_4 + var_441_12 + arg_441_0 then
				arg_438_1.typewritter.percent = 1

				arg_438_1.typewritter:SetDirty()
				arg_438_1:ShowNextGo(true)
			end
		end

		arg_438_1.nodeConfigList_ = {
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

		arg_438_1:InitPlayNodeList()
	end,
	Play319501107 = function(arg_442_0, arg_442_1)
		arg_442_1.time_ = 0
		arg_442_1.frameCnt_ = 0
		arg_442_1.state_ = "playing"
		arg_442_1.curTalkId_ = 319501107
		arg_442_1.duration_ = 1.67

		local var_442_0 = {
			zh = 1.566,
			ja = 1.666
		}
		local var_442_1 = manager.audio:GetLocalizationFlag()

		if var_442_0[var_442_1] ~= nil then
			arg_442_1.duration_ = var_442_0[var_442_1]
		end

		SetActive(arg_442_1.tipsGo_, false)

		function arg_442_1.onSingleLineFinish_()
			arg_442_1.onSingleLineUpdate_ = nil
			arg_442_1.onSingleLineFinish_ = nil
			arg_442_1.state_ = "waiting"
		end

		function arg_442_1.playNext_(arg_444_0)
			if arg_444_0 == 1 then
				arg_442_0:Play319501108(arg_442_1)
			end
		end

		function arg_442_1.onSingleLineUpdate_(arg_445_0)
			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos10068ui_story = arg_442_1.actors_["10068ui_story"].transform.localPosition
			end

			local var_445_0 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_0 then
				arg_442_1.actors_["10068ui_story"].transform.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos10068ui_story, Vector3.New(0.7, -0.75, -6.18), (arg_442_1.time_ - 0) / var_445_0)
				arg_442_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10068ui_story"].transform.position).z)
				arg_442_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["10068ui_story"].transform.localEulerAngles = arg_442_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_0 and arg_442_1.time_ < 0 + var_445_0 + arg_445_0 then
				arg_442_1.actors_["10068ui_story"].transform.localPosition = Vector3.New(0.7, -0.75, -6.18)
				arg_442_1.actors_["10068ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_442_1.actors_["10068ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10068ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_442_1.actors_["10068ui_story"].transform.position).z)
				arg_442_1.actors_["10068ui_story"].transform.localEulerAngles.z = 0
				arg_442_1.actors_["10068ui_story"].transform.localEulerAngles.x = 0
				arg_442_1.actors_["10068ui_story"].transform.localEulerAngles = arg_442_1.actors_["10068ui_story"].transform.localEulerAngles
			end

			local var_445_1 = arg_442_1.actors_["10068ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect10068ui_story == nil then
				arg_442_1.var_.characterEffect10068ui_story = var_445_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_2 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_2 and not isNil(var_445_1) then
				if arg_442_1.var_.characterEffect10068ui_story and not isNil(var_445_1) then
					arg_442_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_442_1.time_ >= 0 + var_445_2 and arg_442_1.time_ < 0 + var_445_2 + arg_445_0 and not isNil(var_445_1) and arg_442_1.var_.characterEffect10068ui_story then
				arg_442_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action1_1")
			end

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_445_4 = arg_442_1.actors_["1084ui_story"].transform

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 then
				arg_442_1.var_.moveOldPos1084ui_story = var_445_4.localPosition
			end

			local var_445_5 = 0.001

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_5 then
				var_445_4.localPosition = Vector3.Lerp(arg_442_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_442_1.time_ - 0) / var_445_5)
				var_445_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_4.position).x, (manager.ui.mainCamera.transform.position - var_445_4.position).y, (manager.ui.mainCamera.transform.position - var_445_4.position).z)
				var_445_4.localEulerAngles.z = 0
				var_445_4.localEulerAngles.x = 0
				var_445_4.localEulerAngles = var_445_4.localEulerAngles
			end

			if arg_442_1.time_ >= 0 + var_445_5 and arg_442_1.time_ < 0 + var_445_5 + arg_445_0 then
				var_445_4.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_445_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_445_4.position).x, (manager.ui.mainCamera.transform.position - var_445_4.position).y, (manager.ui.mainCamera.transform.position - var_445_4.position).z)
				var_445_4.localEulerAngles.z = 0
				var_445_4.localEulerAngles.x = 0
				var_445_4.localEulerAngles = var_445_4.localEulerAngles
			end

			local var_445_6 = arg_442_1.actors_["1084ui_story"]

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= 0 + arg_445_0 and not isNil(var_445_6) and arg_442_1.var_.characterEffect1084ui_story == nil then
				arg_442_1.var_.characterEffect1084ui_story = var_445_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_445_7 = 0.200000002980232

			if 0 <= arg_442_1.time_ and arg_442_1.time_ < 0 + var_445_7 and not isNil(var_445_6) then
				if arg_442_1.var_.characterEffect1084ui_story and not isNil(var_445_6) then
					arg_442_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_442_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_442_1.time_ - 0) / var_445_7)
				end
			end

			if arg_442_1.time_ >= 0 + var_445_7 and arg_442_1.time_ < 0 + var_445_7 + arg_445_0 and not isNil(var_445_6) and arg_442_1.var_.characterEffect1084ui_story then
				arg_442_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_442_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_445_8 = 0
			local var_445_9 = 0.1

			if 0 < arg_442_1.time_ and arg_442_1.time_ <= var_445_8 + arg_445_0 then
				arg_442_1.talkMaxDuration = 0
				arg_442_1.dialogCg_.alpha = 1

				arg_442_1.dialog_:SetActive(true)
				SetActive(arg_442_1.leftNameGo_, true)

				arg_442_1.leftNameTxt_.text = arg_442_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_442_1.leftNameTxt_.transform)

				arg_442_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_442_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_442_1:RecordName(arg_442_1.leftNameTxt_.text)
				SetActive(arg_442_1.iconTrs_.gameObject, false)
				arg_442_1.callingController_:SetSelectedState("normal")

				local var_445_10 = arg_442_1:GetWordFromCfg(319501107)
				local var_445_11 = arg_442_1:FormatText(var_445_10.content)

				arg_442_1.text_.text = var_445_11

				LuaForUtil.ClearLinePrefixSymbol(arg_442_1.text_)

				local var_445_13 = 4 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 4)

				if (4 <= 0 and var_445_9 or var_445_9 * (utf8.len(var_445_11) / 4)) > 0 and var_445_9 < var_445_13 then
					arg_442_1.talkMaxDuration = var_445_13

					if var_445_13 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_13 + var_445_8
					end
				end

				arg_442_1.text_.text = var_445_11
				arg_442_1.typewritter.percent = 0

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501107", "story_v_out_319501.awb") ~= 0 then
					local var_445_14 = manager.audio:GetVoiceLength("story_v_out_319501", "319501107", "story_v_out_319501.awb") / 1000

					if var_445_14 + var_445_8 > arg_442_1.duration_ then
						arg_442_1.duration_ = var_445_14 + var_445_8
					end

					if var_445_10.prefab_name ~= "" and arg_442_1.actors_[var_445_10.prefab_name] ~= nil then
						local var_445_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_442_1.actors_[var_445_10.prefab_name].transform, "story_v_out_319501", "319501107", "story_v_out_319501.awb")

						arg_442_1:RecordAudio("319501107", var_445_15)
						arg_442_1:RecordAudio("319501107", var_445_15)
					else
						arg_442_1:AudioAction("play", "voice", "story_v_out_319501", "319501107", "story_v_out_319501.awb")
					end

					arg_442_1:RecordHistoryTalkVoice("story_v_out_319501", "319501107", "story_v_out_319501.awb")
				end

				arg_442_1:RecordContent(arg_442_1.text_.text)
			end

			local var_445_16 = math.max(var_445_9, arg_442_1.talkMaxDuration)

			if var_445_8 <= arg_442_1.time_ and arg_442_1.time_ < var_445_8 + var_445_16 then
				arg_442_1.typewritter.percent = (arg_442_1.time_ - var_445_8) / var_445_16

				arg_442_1.typewritter:SetDirty()
			end

			if arg_442_1.time_ >= var_445_8 + var_445_16 and arg_442_1.time_ < var_445_8 + var_445_16 + arg_445_0 then
				arg_442_1.typewritter.percent = 1

				arg_442_1.typewritter:SetDirty()
				arg_442_1:ShowNextGo(true)
			end
		end

		arg_442_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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

		arg_442_1:InitPlayNodeList()
	end,
	Play319501108 = function(arg_446_0, arg_446_1)
		arg_446_1.time_ = 0
		arg_446_1.frameCnt_ = 0
		arg_446_1.state_ = "playing"
		arg_446_1.curTalkId_ = 319501108
		arg_446_1.duration_ = 6.1

		local var_446_0 = {
			zh = 5.366,
			ja = 6.1
		}
		local var_446_1 = manager.audio:GetLocalizationFlag()

		if var_446_0[var_446_1] ~= nil then
			arg_446_1.duration_ = var_446_0[var_446_1]
		end

		SetActive(arg_446_1.tipsGo_, false)

		function arg_446_1.onSingleLineFinish_()
			arg_446_1.onSingleLineUpdate_ = nil
			arg_446_1.onSingleLineFinish_ = nil
			arg_446_1.state_ = "waiting"
		end

		function arg_446_1.playNext_(arg_448_0)
			if arg_448_0 == 1 then
				arg_446_0:Play319501109(arg_446_1)
			end
		end

		function arg_446_1.onSingleLineUpdate_(arg_449_0)
			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(arg_446_1.actors_["10068ui_story"]) and arg_446_1.var_.characterEffect10068ui_story == nil then
				arg_446_1.var_.characterEffect10068ui_story = arg_446_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_0 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_0 and not isNil(arg_446_1.actors_["10068ui_story"]) then
				if arg_446_1.var_.characterEffect10068ui_story and not isNil(arg_446_1.actors_["10068ui_story"]) then
					arg_446_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_446_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_446_1.time_ - 0) / var_449_0)
				end
			end

			if arg_446_1.time_ >= 0 + var_449_0 and arg_446_1.time_ < 0 + var_449_0 + arg_449_0 and not isNil(arg_446_1.actors_["10068ui_story"]) and arg_446_1.var_.characterEffect10068ui_story then
				arg_446_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_446_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_449_1 = arg_446_1.actors_["1084ui_story"]

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= 0 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1084ui_story == nil then
				arg_446_1.var_.characterEffect1084ui_story = var_449_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_449_2 = 0.200000002980232

			if 0 <= arg_446_1.time_ and arg_446_1.time_ < 0 + var_449_2 and not isNil(var_449_1) then
				if arg_446_1.var_.characterEffect1084ui_story and not isNil(var_449_1) then
					arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_446_1.time_ >= 0 + var_449_2 and arg_446_1.time_ < 0 + var_449_2 + arg_449_0 and not isNil(var_449_1) and arg_446_1.var_.characterEffect1084ui_story then
				arg_446_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_449_4 = 0
			local var_449_5 = 0.5

			if 0 < arg_446_1.time_ and arg_446_1.time_ <= var_449_4 + arg_449_0 then
				arg_446_1.talkMaxDuration = 0
				arg_446_1.dialogCg_.alpha = 1

				arg_446_1.dialog_:SetActive(true)
				SetActive(arg_446_1.leftNameGo_, true)

				arg_446_1.leftNameTxt_.text = arg_446_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_446_1.leftNameTxt_.transform)

				arg_446_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_446_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_446_1:RecordName(arg_446_1.leftNameTxt_.text)
				SetActive(arg_446_1.iconTrs_.gameObject, false)
				arg_446_1.callingController_:SetSelectedState("normal")

				local var_449_6 = arg_446_1:GetWordFromCfg(319501108)
				local var_449_7 = arg_446_1:FormatText(var_449_6.content)

				arg_446_1.text_.text = var_449_7

				LuaForUtil.ClearLinePrefixSymbol(arg_446_1.text_)

				local var_449_9 = 20 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 20)

				if (20 <= 0 and var_449_5 or var_449_5 * (utf8.len(var_449_7) / 20)) > 0 and var_449_5 < var_449_9 then
					arg_446_1.talkMaxDuration = var_449_9

					if var_449_9 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_9 + var_449_4
					end
				end

				arg_446_1.text_.text = var_449_7
				arg_446_1.typewritter.percent = 0

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501108", "story_v_out_319501.awb") ~= 0 then
					local var_449_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501108", "story_v_out_319501.awb") / 1000

					if var_449_10 + var_449_4 > arg_446_1.duration_ then
						arg_446_1.duration_ = var_449_10 + var_449_4
					end

					if var_449_6.prefab_name ~= "" and arg_446_1.actors_[var_449_6.prefab_name] ~= nil then
						local var_449_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_446_1.actors_[var_449_6.prefab_name].transform, "story_v_out_319501", "319501108", "story_v_out_319501.awb")

						arg_446_1:RecordAudio("319501108", var_449_11)
						arg_446_1:RecordAudio("319501108", var_449_11)
					else
						arg_446_1:AudioAction("play", "voice", "story_v_out_319501", "319501108", "story_v_out_319501.awb")
					end

					arg_446_1:RecordHistoryTalkVoice("story_v_out_319501", "319501108", "story_v_out_319501.awb")
				end

				arg_446_1:RecordContent(arg_446_1.text_.text)
			end

			local var_449_12 = math.max(var_449_5, arg_446_1.talkMaxDuration)

			if var_449_4 <= arg_446_1.time_ and arg_446_1.time_ < var_449_4 + var_449_12 then
				arg_446_1.typewritter.percent = (arg_446_1.time_ - var_449_4) / var_449_12

				arg_446_1.typewritter:SetDirty()
			end

			if arg_446_1.time_ >= var_449_4 + var_449_12 and arg_446_1.time_ < var_449_4 + var_449_12 + arg_449_0 then
				arg_446_1.typewritter.percent = 1

				arg_446_1.typewritter:SetDirty()
				arg_446_1:ShowNextGo(true)
			end
		end

		arg_446_1.nodeConfigList_ = {}

		arg_446_1:InitPlayNodeList()
	end,
	Play319501109 = function(arg_450_0, arg_450_1)
		arg_450_1.time_ = 0
		arg_450_1.frameCnt_ = 0
		arg_450_1.state_ = "playing"
		arg_450_1.curTalkId_ = 319501109
		arg_450_1.duration_ = 5

		SetActive(arg_450_1.tipsGo_, false)

		function arg_450_1.onSingleLineFinish_()
			arg_450_1.onSingleLineUpdate_ = nil
			arg_450_1.onSingleLineFinish_ = nil
			arg_450_1.state_ = "waiting"
		end

		function arg_450_1.playNext_(arg_452_0)
			if arg_452_0 == 1 then
				arg_450_0:Play319501110(arg_450_1)
			end
		end

		function arg_450_1.onSingleLineUpdate_(arg_453_0)
			if 0 < arg_450_1.time_ and arg_450_1.time_ <= 0 + arg_453_0 and not isNil(arg_450_1.actors_["1084ui_story"]) and arg_450_1.var_.characterEffect1084ui_story == nil then
				arg_450_1.var_.characterEffect1084ui_story = arg_450_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_453_0 = 0.200000002980232

			if 0 <= arg_450_1.time_ and arg_450_1.time_ < 0 + var_453_0 and not isNil(arg_450_1.actors_["1084ui_story"]) then
				if arg_450_1.var_.characterEffect1084ui_story and not isNil(arg_450_1.actors_["1084ui_story"]) then
					arg_450_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_450_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_450_1.time_ - 0) / var_453_0)
				end
			end

			if arg_450_1.time_ >= 0 + var_453_0 and arg_450_1.time_ < 0 + var_453_0 + arg_453_0 and not isNil(arg_450_1.actors_["1084ui_story"]) and arg_450_1.var_.characterEffect1084ui_story then
				arg_450_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_450_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_453_1 = 0
			local var_453_2 = 0.975

			if 0 < arg_450_1.time_ and arg_450_1.time_ <= var_453_1 + arg_453_0 then
				arg_450_1.talkMaxDuration = 0
				arg_450_1.dialogCg_.alpha = 1

				arg_450_1.dialog_:SetActive(true)
				SetActive(arg_450_1.leftNameGo_, false)

				arg_450_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_450_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_450_1:RecordName(arg_450_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_450_1.iconTrs_.gameObject, false)
				arg_450_1.callingController_:SetSelectedState("normal")

				local var_453_3 = arg_450_1:FormatText(arg_450_1:GetWordFromCfg(319501109).content)

				arg_450_1.text_.text = var_453_3

				LuaForUtil.ClearLinePrefixSymbol(arg_450_1.text_)

				local var_453_5 = 39 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 39)

				if (39 <= 0 and var_453_2 or var_453_2 * (utf8.len(var_453_3) / 39)) > 0 and var_453_2 < var_453_5 then
					arg_450_1.talkMaxDuration = var_453_5

					if var_453_5 + var_453_1 > arg_450_1.duration_ then
						arg_450_1.duration_ = var_453_5 + var_453_1
					end
				end

				arg_450_1.text_.text = var_453_3
				arg_450_1.typewritter.percent = 0

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(false)
				arg_450_1:RecordContent(arg_450_1.text_.text)
			end

			local var_453_6 = math.max(var_453_2, arg_450_1.talkMaxDuration)

			if var_453_1 <= arg_450_1.time_ and arg_450_1.time_ < var_453_1 + var_453_6 then
				arg_450_1.typewritter.percent = (arg_450_1.time_ - var_453_1) / var_453_6

				arg_450_1.typewritter:SetDirty()
			end

			if arg_450_1.time_ >= var_453_1 + var_453_6 and arg_450_1.time_ < var_453_1 + var_453_6 + arg_453_0 then
				arg_450_1.typewritter.percent = 1

				arg_450_1.typewritter:SetDirty()
				arg_450_1:ShowNextGo(true)
			end
		end

		arg_450_1.nodeConfigList_ = {}

		arg_450_1:InitPlayNodeList()
	end,
	Play319501110 = function(arg_454_0, arg_454_1)
		arg_454_1.time_ = 0
		arg_454_1.frameCnt_ = 0
		arg_454_1.state_ = "playing"
		arg_454_1.curTalkId_ = 319501110
		arg_454_1.duration_ = 2.87

		SetActive(arg_454_1.tipsGo_, false)

		function arg_454_1.onSingleLineFinish_()
			arg_454_1.onSingleLineUpdate_ = nil
			arg_454_1.onSingleLineFinish_ = nil
			arg_454_1.state_ = "waiting"
		end

		function arg_454_1.playNext_(arg_456_0)
			if arg_456_0 == 1 then
				arg_454_0:Play319501111(arg_454_1)
			end
		end

		function arg_454_1.onSingleLineUpdate_(arg_457_0)
			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				local var_457_0 = arg_454_1.bgs_.STblack

				arg_454_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_457_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_457_1 = var_457_0:GetComponent("SpriteRenderer")

				if var_457_1 and var_457_1.sprite then
					local var_457_2 = 2 * (var_457_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_457_0.transform.localScale = Vector3.New(var_457_2 / var_457_1.sprite.bounds.size.y < var_457_2 * manager.ui.mainCameraCom_.aspect / var_457_1.sprite.bounds.size.x and var_457_2 * manager.ui.mainCameraCom_.aspect / var_457_1.sprite.bounds.size.x or var_457_2 / var_457_1.sprite.bounds.size.y, var_457_2 / var_457_1.sprite.bounds.size.y < var_457_2 * manager.ui.mainCameraCom_.aspect / var_457_1.sprite.bounds.size.x and var_457_2 * manager.ui.mainCameraCom_.aspect / var_457_1.sprite.bounds.size.x or var_457_2 / var_457_1.sprite.bounds.size.y, 0)
				end

				for iter_457_0, iter_457_1 in pairs(arg_454_1.bgs_) do
					if iter_457_0 ~= "STblack" then
						iter_457_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				local var_457_3 = arg_454_1.fswbg_.transform:Find("textbox/adapt/content") or arg_454_1.fswbg_.transform:Find("textbox/content")
				local var_457_4 = arg_454_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_457_5 = var_457_3:GetComponent("RectTransform")

				var_457_3:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_457_5.offsetMin = Vector2.New(0, 0)
				var_457_5.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.fswbg_:SetActive(true)
				arg_454_1.dialog_:SetActive(false)

				arg_454_1.fswtw_.percent = 0
				arg_454_1.fswt_.text = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(319501110).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.fswt_)

				arg_454_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_454_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_454_1.fswtw_:SetDirty()

				arg_454_1.typewritterCharCountI18N = 0

				SetActive(arg_454_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_454_1:ShowNextGo(false)
			end

			local var_457_6 = 0.466666666666667

			if 0.466666666666667 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.var_.oldValueTypewriter = arg_454_1.fswtw_.percent

				SetActive(arg_454_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_454_1:ShowNextGo(false)
			end

			local var_457_7 = 9
			local var_457_8 = 0.6
			local var_457_9, var_457_10 = arg_454_1:GetPercentByPara(arg_454_1:FormatText(arg_454_1:GetWordFromCfg(319501110).content), 1)

			if var_457_6 < arg_454_1.time_ and arg_454_1.time_ <= var_457_6 + arg_457_0 then
				arg_454_1.talkMaxDuration = 0

				local var_457_11 = var_457_7 <= 0 and var_457_8 or var_457_8 * ((var_457_10 - arg_454_1.typewritterCharCountI18N) / var_457_7)

				if (var_457_7 <= 0 and var_457_8 or var_457_8 * ((var_457_10 - arg_454_1.typewritterCharCountI18N) / var_457_7)) > 0 and var_457_8 < var_457_11 then
					arg_454_1.talkMaxDuration = var_457_11

					if var_457_11 + var_457_6 > arg_454_1.duration_ then
						arg_454_1.duration_ = var_457_11 + var_457_6
					end
				end
			end

			local var_457_12 = math.max(0.6, arg_454_1.talkMaxDuration)

			if var_457_6 <= arg_454_1.time_ and arg_454_1.time_ < var_457_6 + var_457_12 then
				arg_454_1.fswtw_.percent = Mathf.Lerp(arg_454_1.var_.oldValueTypewriter, var_457_9, (arg_454_1.time_ - var_457_6) / var_457_12)
				arg_454_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_454_1.fswtw_:SetDirty()
			end

			if arg_454_1.time_ >= var_457_6 + var_457_12 and arg_454_1.time_ < var_457_6 + var_457_12 + arg_457_0 then
				arg_454_1.fswtw_.percent = var_457_9

				arg_454_1.fswtw_:SetDirty()
				arg_454_1:ShowNextGo(true)

				arg_454_1.typewritterCharCountI18N = var_457_10
			end

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.cswbg_:SetActive(true)

				local var_457_13 = arg_454_1.cswt_:GetComponent("RectTransform")

				arg_454_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_457_13.offsetMin = Vector2.New(410, 330)
				var_457_13.offsetMax = Vector2.New(-400, -175)
				arg_454_1.cswt_.text = arg_454_1:FormatText(arg_454_1:GetWordFromCfg(419025).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_454_1.cswt_)

				arg_454_1.cswt_.fontSize = 180
				arg_454_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_454_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_454_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_457_14 = arg_454_1.actors_["10068ui_story"].transform

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos10068ui_story = var_457_14.localPosition
			end

			local var_457_15 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_15 then
				var_457_14.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos10068ui_story, Vector3.New(0, 100, 0), (arg_454_1.time_ - 0) / var_457_15)
				var_457_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_14.position).x, (manager.ui.mainCamera.transform.position - var_457_14.position).y, (manager.ui.mainCamera.transform.position - var_457_14.position).z)
				var_457_14.localEulerAngles.z = 0
				var_457_14.localEulerAngles.x = 0
				var_457_14.localEulerAngles = var_457_14.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_15 and arg_454_1.time_ < 0 + var_457_15 + arg_457_0 then
				var_457_14.localPosition = Vector3.New(0, 100, 0)
				var_457_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_14.position).x, (manager.ui.mainCamera.transform.position - var_457_14.position).y, (manager.ui.mainCamera.transform.position - var_457_14.position).z)
				var_457_14.localEulerAngles.z = 0
				var_457_14.localEulerAngles.x = 0
				var_457_14.localEulerAngles = var_457_14.localEulerAngles
			end

			local var_457_16 = arg_454_1.actors_["1084ui_story"].transform

			if 0 < arg_454_1.time_ and arg_454_1.time_ <= 0 + arg_457_0 then
				arg_454_1.var_.moveOldPos1084ui_story = var_457_16.localPosition
			end

			local var_457_17 = 0.001

			if 0 <= arg_454_1.time_ and arg_454_1.time_ < 0 + var_457_17 then
				var_457_16.localPosition = Vector3.Lerp(arg_454_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_454_1.time_ - 0) / var_457_17)
				var_457_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_16.position).x, (manager.ui.mainCamera.transform.position - var_457_16.position).y, (manager.ui.mainCamera.transform.position - var_457_16.position).z)
				var_457_16.localEulerAngles.z = 0
				var_457_16.localEulerAngles.x = 0
				var_457_16.localEulerAngles = var_457_16.localEulerAngles
			end

			if arg_454_1.time_ >= 0 + var_457_17 and arg_454_1.time_ < 0 + var_457_17 + arg_457_0 then
				var_457_16.localPosition = Vector3.New(0, 100, 0)
				var_457_16.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_457_16.position).x, (manager.ui.mainCamera.transform.position - var_457_16.position).y, (manager.ui.mainCamera.transform.position - var_457_16.position).z)
				var_457_16.localEulerAngles.z = 0
				var_457_16.localEulerAngles.x = 0
				var_457_16.localEulerAngles = var_457_16.localEulerAngles
			end

			local var_457_18 = 0.466666666666667
			local var_457_19 = manager.audio:GetVoiceLength("story_v_out_319501", "319501110", "story_v_out_319501.awb") / 1000

			if var_457_19 > 0 and 2.4 < var_457_19 and var_457_19 + var_457_18 > arg_454_1.duration_ then
				arg_454_1.duration_ = var_457_19 + var_457_18
			end

			if var_457_18 < arg_454_1.time_ and arg_454_1.time_ <= var_457_18 + arg_457_0 then
				arg_454_1:AudioAction("play", "voice", "story_v_out_319501", "319501110", "story_v_out_319501.awb")
			end
		end

		arg_454_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10068ui_story",
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

		arg_454_1:InitPlayNodeList()
	end,
	Play319501111 = function(arg_458_0, arg_458_1)
		arg_458_1.time_ = 0
		arg_458_1.frameCnt_ = 0
		arg_458_1.state_ = "playing"
		arg_458_1.curTalkId_ = 319501111
		arg_458_1.duration_ = 3.13

		SetActive(arg_458_1.tipsGo_, false)

		function arg_458_1.onSingleLineFinish_()
			arg_458_1.onSingleLineUpdate_ = nil
			arg_458_1.onSingleLineFinish_ = nil
			arg_458_1.state_ = "waiting"
		end

		function arg_458_1.playNext_(arg_460_0)
			if arg_460_0 == 1 then
				arg_458_0:Play319501112(arg_458_1)
			end
		end

		function arg_458_1.onSingleLineUpdate_(arg_461_0)
			if 0 < arg_458_1.time_ and arg_458_1.time_ <= 0 + arg_461_0 then
				arg_458_1.fswbg_:SetActive(true)
				arg_458_1.dialog_:SetActive(false)

				arg_458_1.fswtw_.percent = 0
				arg_458_1.fswt_.text = arg_458_1:FormatText(arg_458_1:GetWordFromCfg(319501111).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_458_1.fswt_)

				arg_458_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_458_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_458_1.fswtw_:SetDirty()

				arg_458_1.typewritterCharCountI18N = 0

				SetActive(arg_458_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_458_1:ShowNextGo(false)
			end

			local var_461_0 = 0.2

			if 0.2 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.var_.oldValueTypewriter = arg_458_1.fswtw_.percent

				SetActive(arg_458_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_458_1:ShowNextGo(false)
			end

			local var_461_1 = 44
			local var_461_2 = 2.93333333333333
			local var_461_3, var_461_4 = arg_458_1:GetPercentByPara(arg_458_1:FormatText(arg_458_1:GetWordFromCfg(319501111).content), 1)

			if var_461_0 < arg_458_1.time_ and arg_458_1.time_ <= var_461_0 + arg_461_0 then
				arg_458_1.talkMaxDuration = 0

				local var_461_5 = var_461_1 <= 0 and var_461_2 or var_461_2 * ((var_461_4 - arg_458_1.typewritterCharCountI18N) / var_461_1)

				if (var_461_1 <= 0 and var_461_2 or var_461_2 * ((var_461_4 - arg_458_1.typewritterCharCountI18N) / var_461_1)) > 0 and var_461_2 < var_461_5 then
					arg_458_1.talkMaxDuration = var_461_5

					if var_461_5 + var_461_0 > arg_458_1.duration_ then
						arg_458_1.duration_ = var_461_5 + var_461_0
					end
				end
			end

			local var_461_6 = math.max(2.93333333333333, arg_458_1.talkMaxDuration)

			if var_461_0 <= arg_458_1.time_ and arg_458_1.time_ < var_461_0 + var_461_6 then
				arg_458_1.fswtw_.percent = Mathf.Lerp(arg_458_1.var_.oldValueTypewriter, var_461_3, (arg_458_1.time_ - var_461_0) / var_461_6)
				arg_458_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_458_1.fswtw_:SetDirty()
			end

			if arg_458_1.time_ >= var_461_0 + var_461_6 and arg_458_1.time_ < var_461_0 + var_461_6 + arg_461_0 then
				arg_458_1.fswtw_.percent = var_461_3

				arg_458_1.fswtw_:SetDirty()
				arg_458_1:ShowNextGo(true)

				arg_458_1.typewritterCharCountI18N = var_461_4
			end

			local var_461_7 = 0.2
			local var_461_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501111", "story_v_out_319501.awb") / 1000

			if var_461_8 > 0 and 0.266666666666667 < var_461_8 and var_461_8 + var_461_7 > arg_458_1.duration_ then
				arg_458_1.duration_ = var_461_8 + var_461_7
			end

			if var_461_7 < arg_458_1.time_ and arg_458_1.time_ <= var_461_7 + arg_461_0 then
				arg_458_1:AudioAction("play", "voice", "story_v_out_319501", "319501111", "story_v_out_319501.awb")
			end
		end

		arg_458_1.nodeConfigList_ = {}

		arg_458_1:InitPlayNodeList()
	end,
	Play319501112 = function(arg_462_0, arg_462_1)
		arg_462_1.time_ = 0
		arg_462_1.frameCnt_ = 0
		arg_462_1.state_ = "playing"
		arg_462_1.curTalkId_ = 319501112
		arg_462_1.duration_ = 1

		SetActive(arg_462_1.tipsGo_, false)

		function arg_462_1.onSingleLineFinish_()
			arg_462_1.onSingleLineUpdate_ = nil
			arg_462_1.onSingleLineFinish_ = nil
			arg_462_1.state_ = "waiting"
		end

		function arg_462_1.playNext_(arg_464_0)
			if arg_464_0 == 1 then
				arg_462_0:Play319501113(arg_462_1)
			end
		end

		function arg_462_1.onSingleLineUpdate_(arg_465_0)
			if 0 < arg_462_1.time_ and arg_462_1.time_ <= 0 + arg_465_0 then
				arg_462_1.fswbg_:SetActive(true)
				arg_462_1.dialog_:SetActive(false)

				arg_462_1.fswtw_.percent = 0
				arg_462_1.fswt_.text = arg_462_1:FormatText(arg_462_1:GetWordFromCfg(319501112).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_462_1.fswt_)

				arg_462_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_462_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_462_1.fswtw_:SetDirty()

				arg_462_1.typewritterCharCountI18N = 0

				SetActive(arg_462_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_462_1:ShowNextGo(false)
			end

			local var_465_0 = 0.2

			if 0.2 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.var_.oldValueTypewriter = arg_462_1.fswtw_.percent

				SetActive(arg_462_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_462_1:ShowNextGo(false)
			end

			local var_465_1 = 11
			local var_465_2 = 0.733333333333333
			local var_465_3, var_465_4 = arg_462_1:GetPercentByPara(arg_462_1:FormatText(arg_462_1:GetWordFromCfg(319501112).content), 1)

			if var_465_0 < arg_462_1.time_ and arg_462_1.time_ <= var_465_0 + arg_465_0 then
				arg_462_1.talkMaxDuration = 0

				local var_465_5 = var_465_1 <= 0 and var_465_2 or var_465_2 * ((var_465_4 - arg_462_1.typewritterCharCountI18N) / var_465_1)

				if (var_465_1 <= 0 and var_465_2 or var_465_2 * ((var_465_4 - arg_462_1.typewritterCharCountI18N) / var_465_1)) > 0 and var_465_2 < var_465_5 then
					arg_462_1.talkMaxDuration = var_465_5

					if var_465_5 + var_465_0 > arg_462_1.duration_ then
						arg_462_1.duration_ = var_465_5 + var_465_0
					end
				end
			end

			local var_465_6 = math.max(0.733333333333333, arg_462_1.talkMaxDuration)

			if var_465_0 <= arg_462_1.time_ and arg_462_1.time_ < var_465_0 + var_465_6 then
				arg_462_1.fswtw_.percent = Mathf.Lerp(arg_462_1.var_.oldValueTypewriter, var_465_3, (arg_462_1.time_ - var_465_0) / var_465_6)
				arg_462_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_462_1.fswtw_:SetDirty()
			end

			if arg_462_1.time_ >= var_465_0 + var_465_6 and arg_462_1.time_ < var_465_0 + var_465_6 + arg_465_0 then
				arg_462_1.fswtw_.percent = var_465_3

				arg_462_1.fswtw_:SetDirty()
				arg_462_1:ShowNextGo(true)

				arg_462_1.typewritterCharCountI18N = var_465_4
			end

			local var_465_7 = 0.2
			local var_465_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501112", "story_v_out_319501.awb") / 1000

			if var_465_8 > 0 and 0.266666666666667 < var_465_8 and var_465_8 + var_465_7 > arg_462_1.duration_ then
				arg_462_1.duration_ = var_465_8 + var_465_7
			end

			if var_465_7 < arg_462_1.time_ and arg_462_1.time_ <= var_465_7 + arg_465_0 then
				arg_462_1:AudioAction("play", "voice", "story_v_out_319501", "319501112", "story_v_out_319501.awb")
			end
		end

		arg_462_1.nodeConfigList_ = {}

		arg_462_1:InitPlayNodeList()
	end,
	Play319501113 = function(arg_466_0, arg_466_1)
		arg_466_1.time_ = 0
		arg_466_1.frameCnt_ = 0
		arg_466_1.state_ = "playing"
		arg_466_1.curTalkId_ = 319501113
		arg_466_1.duration_ = 1

		SetActive(arg_466_1.tipsGo_, false)

		function arg_466_1.onSingleLineFinish_()
			arg_466_1.onSingleLineUpdate_ = nil
			arg_466_1.onSingleLineFinish_ = nil
			arg_466_1.state_ = "waiting"
		end

		function arg_466_1.playNext_(arg_468_0)
			if arg_468_0 == 1 then
				arg_466_0:Play319501114(arg_466_1)
			end
		end

		function arg_466_1.onSingleLineUpdate_(arg_469_0)
			if 0 < arg_466_1.time_ and arg_466_1.time_ <= 0 + arg_469_0 then
				arg_466_1.fswbg_:SetActive(true)
				arg_466_1.dialog_:SetActive(false)

				arg_466_1.fswtw_.percent = 0
				arg_466_1.fswt_.text = arg_466_1:FormatText(arg_466_1:GetWordFromCfg(319501113).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_466_1.fswt_)

				arg_466_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_466_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_466_1.fswtw_:SetDirty()

				arg_466_1.typewritterCharCountI18N = 0

				SetActive(arg_466_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_466_1:ShowNextGo(false)
			end

			local var_469_0 = 0.2

			if 0.2 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.var_.oldValueTypewriter = arg_466_1.fswtw_.percent

				SetActive(arg_466_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_466_1:ShowNextGo(false)
			end

			local var_469_1 = 9
			local var_469_2 = 0.6
			local var_469_3, var_469_4 = arg_466_1:GetPercentByPara(arg_466_1:FormatText(arg_466_1:GetWordFromCfg(319501113).content), 1)

			if var_469_0 < arg_466_1.time_ and arg_466_1.time_ <= var_469_0 + arg_469_0 then
				arg_466_1.talkMaxDuration = 0

				local var_469_5 = var_469_1 <= 0 and var_469_2 or var_469_2 * ((var_469_4 - arg_466_1.typewritterCharCountI18N) / var_469_1)

				if (var_469_1 <= 0 and var_469_2 or var_469_2 * ((var_469_4 - arg_466_1.typewritterCharCountI18N) / var_469_1)) > 0 and var_469_2 < var_469_5 then
					arg_466_1.talkMaxDuration = var_469_5

					if var_469_5 + var_469_0 > arg_466_1.duration_ then
						arg_466_1.duration_ = var_469_5 + var_469_0
					end
				end
			end

			local var_469_6 = math.max(0.6, arg_466_1.talkMaxDuration)

			if var_469_0 <= arg_466_1.time_ and arg_466_1.time_ < var_469_0 + var_469_6 then
				arg_466_1.fswtw_.percent = Mathf.Lerp(arg_466_1.var_.oldValueTypewriter, var_469_3, (arg_466_1.time_ - var_469_0) / var_469_6)
				arg_466_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_466_1.fswtw_:SetDirty()
			end

			if arg_466_1.time_ >= var_469_0 + var_469_6 and arg_466_1.time_ < var_469_0 + var_469_6 + arg_469_0 then
				arg_466_1.fswtw_.percent = var_469_3

				arg_466_1.fswtw_:SetDirty()
				arg_466_1:ShowNextGo(true)

				arg_466_1.typewritterCharCountI18N = var_469_4
			end

			local var_469_7 = 0.2
			local var_469_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501113", "story_v_out_319501.awb") / 1000

			if var_469_8 > 0 and 0.266666666666667 < var_469_8 and var_469_8 + var_469_7 > arg_466_1.duration_ then
				arg_466_1.duration_ = var_469_8 + var_469_7
			end

			if var_469_7 < arg_466_1.time_ and arg_466_1.time_ <= var_469_7 + arg_469_0 then
				arg_466_1:AudioAction("play", "voice", "story_v_out_319501", "319501113", "story_v_out_319501.awb")
			end
		end

		arg_466_1.nodeConfigList_ = {}

		arg_466_1:InitPlayNodeList()
	end,
	Play319501114 = function(arg_470_0, arg_470_1)
		arg_470_1.time_ = 0
		arg_470_1.frameCnt_ = 0
		arg_470_1.state_ = "playing"
		arg_470_1.curTalkId_ = 319501114
		arg_470_1.duration_ = 11.48

		local var_470_0 = {
			zh = 5.85,
			ja = 11.483
		}
		local var_470_1 = manager.audio:GetLocalizationFlag()

		if var_470_0[var_470_1] ~= nil then
			arg_470_1.duration_ = var_470_0[var_470_1]
		end

		SetActive(arg_470_1.tipsGo_, false)

		function arg_470_1.onSingleLineFinish_()
			arg_470_1.onSingleLineUpdate_ = nil
			arg_470_1.onSingleLineFinish_ = nil
			arg_470_1.state_ = "waiting"
		end

		function arg_470_1.playNext_(arg_472_0)
			if arg_472_0 == 1 then
				arg_470_0:Play319501115(arg_470_1)
			end
		end

		function arg_470_1.onSingleLineUpdate_(arg_473_0)
			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				local var_473_0 = arg_470_1.bgs_.ST71

				arg_470_1.bgs_.ST71.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_473_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_473_1 = var_473_0:GetComponent("SpriteRenderer")

				if var_473_1 and var_473_1.sprite then
					local var_473_2 = 2 * (var_473_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_473_0.transform.localScale = Vector3.New(var_473_2 / var_473_1.sprite.bounds.size.y < var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x and var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x or var_473_2 / var_473_1.sprite.bounds.size.y, var_473_2 / var_473_1.sprite.bounds.size.y < var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x and var_473_2 * manager.ui.mainCameraCom_.aspect / var_473_1.sprite.bounds.size.x or var_473_2 / var_473_1.sprite.bounds.size.y, 0)
				end

				for iter_473_0, iter_473_1 in pairs(arg_470_1.bgs_) do
					if iter_473_0 ~= "ST71" then
						iter_473_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.fswbg_:SetActive(false)
				arg_470_1.dialog_:SetActive(false)
				SetActive(arg_470_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_470_1:ShowNextGo(false)
			end

			if 0 < arg_470_1.time_ and arg_470_1.time_ <= 0 + arg_473_0 then
				arg_470_1.cswbg_:SetActive(false)
			end

			local var_473_3 = arg_470_1.actors_["1084ui_story"].transform

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= 1.35 + arg_473_0 then
				arg_470_1.var_.moveOldPos1084ui_story = var_473_3.localPosition
			end

			local var_473_4 = 0.001

			if 1.35 <= arg_470_1.time_ and arg_470_1.time_ < 1.35 + var_473_4 then
				var_473_3.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_470_1.time_ - 1.35) / var_473_4)
				var_473_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_3.position).x, (manager.ui.mainCamera.transform.position - var_473_3.position).y, (manager.ui.mainCamera.transform.position - var_473_3.position).z)
				var_473_3.localEulerAngles.z = 0
				var_473_3.localEulerAngles.x = 0
				var_473_3.localEulerAngles = var_473_3.localEulerAngles
			end

			if arg_470_1.time_ >= 1.35 + var_473_4 and arg_470_1.time_ < 1.35 + var_473_4 + arg_473_0 then
				var_473_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_473_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_3.position).x, (manager.ui.mainCamera.transform.position - var_473_3.position).y, (manager.ui.mainCamera.transform.position - var_473_3.position).z)
				var_473_3.localEulerAngles.z = 0
				var_473_3.localEulerAngles.x = 0
				var_473_3.localEulerAngles = var_473_3.localEulerAngles
			end

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= 1.35 + arg_473_0 then
				arg_470_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= 1.35 + arg_473_0 then
				arg_470_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_473_5 = arg_470_1.actors_["1084ui_story"]

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= 1.35 + arg_473_0 and not isNil(var_473_5) and arg_470_1.var_.characterEffect1084ui_story == nil then
				arg_470_1.var_.characterEffect1084ui_story = var_473_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_6 = 0.2

			if 1.35 <= arg_470_1.time_ and arg_470_1.time_ < 1.35 + var_473_6 and not isNil(var_473_5) then
				if arg_470_1.var_.characterEffect1084ui_story and not isNil(var_473_5) then
					arg_470_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_470_1.time_ >= 1.35 + var_473_6 and arg_470_1.time_ < 1.35 + var_473_6 + arg_473_0 and not isNil(var_473_5) and arg_470_1.var_.characterEffect1084ui_story then
				arg_470_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_473_8 = arg_470_1.actors_["10068ui_story"].transform

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= 1.35 + arg_473_0 then
				arg_470_1.var_.moveOldPos10068ui_story = var_473_8.localPosition
			end

			local var_473_9 = 0.001

			if 1.35 <= arg_470_1.time_ and arg_470_1.time_ < 1.35 + var_473_9 then
				var_473_8.localPosition = Vector3.Lerp(arg_470_1.var_.moveOldPos10068ui_story, Vector3.New(0.7, -0.75, -6.18), (arg_470_1.time_ - 1.35) / var_473_9)
				var_473_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_8.position).x, (manager.ui.mainCamera.transform.position - var_473_8.position).y, (manager.ui.mainCamera.transform.position - var_473_8.position).z)
				var_473_8.localEulerAngles.z = 0
				var_473_8.localEulerAngles.x = 0
				var_473_8.localEulerAngles = var_473_8.localEulerAngles
			end

			if arg_470_1.time_ >= 1.35 + var_473_9 and arg_470_1.time_ < 1.35 + var_473_9 + arg_473_0 then
				var_473_8.localPosition = Vector3.New(0.7, -0.75, -6.18)
				var_473_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_473_8.position).x, (manager.ui.mainCamera.transform.position - var_473_8.position).y, (manager.ui.mainCamera.transform.position - var_473_8.position).z)
				var_473_8.localEulerAngles.z = 0
				var_473_8.localEulerAngles.x = 0
				var_473_8.localEulerAngles = var_473_8.localEulerAngles
			end

			local var_473_10 = arg_470_1.actors_["10068ui_story"]

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= 1.35 + arg_473_0 and not isNil(var_473_10) and arg_470_1.var_.characterEffect10068ui_story == nil then
				arg_470_1.var_.characterEffect10068ui_story = var_473_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_473_11 = 0.2

			if 1.35 <= arg_470_1.time_ and arg_470_1.time_ < 1.35 + var_473_11 and not isNil(var_473_10) then
				if arg_470_1.var_.characterEffect10068ui_story and not isNil(var_473_10) then
					arg_470_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_470_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_470_1.time_ - 1.35) / var_473_11)
				end
			end

			if arg_470_1.time_ >= 1.35 + var_473_11 and arg_470_1.time_ < 1.35 + var_473_11 + arg_473_0 and not isNil(var_473_10) and arg_470_1.var_.characterEffect10068ui_story then
				arg_470_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_470_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_473_12 = 1.35
			local var_473_13 = 0.65

			if 1.35 < arg_470_1.time_ and arg_470_1.time_ <= var_473_12 + arg_473_0 then
				arg_470_1.talkMaxDuration = 0
				arg_470_1.dialogCg_.alpha = 1

				arg_470_1.dialog_:SetActive(true)
				SetActive(arg_470_1.leftNameGo_, true)

				arg_470_1.leftNameTxt_.text = arg_470_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_470_1.leftNameTxt_.transform)

				arg_470_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_470_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_470_1:RecordName(arg_470_1.leftNameTxt_.text)
				SetActive(arg_470_1.iconTrs_.gameObject, false)
				arg_470_1.callingController_:SetSelectedState("normal")

				local var_473_14 = arg_470_1:GetWordFromCfg(319501114)
				local var_473_15 = arg_470_1:FormatText(var_473_14.content)

				arg_470_1.text_.text = var_473_15

				LuaForUtil.ClearLinePrefixSymbol(arg_470_1.text_)

				local var_473_17 = 26 <= 0 and var_473_13 or var_473_13 * (utf8.len(var_473_15) / 26)

				if (26 <= 0 and var_473_13 or var_473_13 * (utf8.len(var_473_15) / 26)) > 0 and var_473_13 < var_473_17 then
					arg_470_1.talkMaxDuration = var_473_17

					if var_473_17 + var_473_12 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_17 + var_473_12
					end
				end

				arg_470_1.text_.text = var_473_15
				arg_470_1.typewritter.percent = 0

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501114", "story_v_out_319501.awb") ~= 0 then
					local var_473_18 = manager.audio:GetVoiceLength("story_v_out_319501", "319501114", "story_v_out_319501.awb") / 1000

					if var_473_18 + var_473_12 > arg_470_1.duration_ then
						arg_470_1.duration_ = var_473_18 + var_473_12
					end

					if var_473_14.prefab_name ~= "" and arg_470_1.actors_[var_473_14.prefab_name] ~= nil then
						local var_473_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_470_1.actors_[var_473_14.prefab_name].transform, "story_v_out_319501", "319501114", "story_v_out_319501.awb")

						arg_470_1:RecordAudio("319501114", var_473_19)
						arg_470_1:RecordAudio("319501114", var_473_19)
					else
						arg_470_1:AudioAction("play", "voice", "story_v_out_319501", "319501114", "story_v_out_319501.awb")
					end

					arg_470_1:RecordHistoryTalkVoice("story_v_out_319501", "319501114", "story_v_out_319501.awb")
				end

				arg_470_1:RecordContent(arg_470_1.text_.text)
			end

			local var_473_20 = math.max(var_473_13, arg_470_1.talkMaxDuration)

			if var_473_12 <= arg_470_1.time_ and arg_470_1.time_ < var_473_12 + var_473_20 then
				arg_470_1.typewritter.percent = (arg_470_1.time_ - var_473_12) / var_473_20

				arg_470_1.typewritter:SetDirty()
			end

			if arg_470_1.time_ >= var_473_12 + var_473_20 and arg_470_1.time_ < var_473_12 + var_473_20 + arg_473_0 then
				arg_470_1.typewritter.percent = 1

				arg_470_1.typewritter:SetDirty()
				arg_470_1:ShowNextGo(true)
			end
		end

		arg_470_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10068ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.35,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_470_1:InitPlayNodeList()
	end,
	Play319501115 = function(arg_474_0, arg_474_1)
		arg_474_1.time_ = 0
		arg_474_1.frameCnt_ = 0
		arg_474_1.state_ = "playing"
		arg_474_1.curTalkId_ = 319501115
		arg_474_1.duration_ = 20.1

		local var_474_0 = {
			zh = 12.2,
			ja = 20.1
		}
		local var_474_1 = manager.audio:GetLocalizationFlag()

		if var_474_0[var_474_1] ~= nil then
			arg_474_1.duration_ = var_474_0[var_474_1]
		end

		SetActive(arg_474_1.tipsGo_, false)

		function arg_474_1.onSingleLineFinish_()
			arg_474_1.onSingleLineUpdate_ = nil
			arg_474_1.onSingleLineFinish_ = nil
			arg_474_1.state_ = "waiting"
		end

		function arg_474_1.playNext_(arg_476_0)
			if arg_476_0 == 1 then
				arg_474_0:Play319501116(arg_474_1)
			end
		end

		function arg_474_1.onSingleLineUpdate_(arg_477_0)
			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= 0 + arg_477_0 then
				arg_474_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_477_0 = 0
			local var_477_1 = 1.325

			if 0 < arg_474_1.time_ and arg_474_1.time_ <= var_477_0 + arg_477_0 then
				arg_474_1.talkMaxDuration = 0
				arg_474_1.dialogCg_.alpha = 1

				arg_474_1.dialog_:SetActive(true)
				SetActive(arg_474_1.leftNameGo_, true)

				arg_474_1.leftNameTxt_.text = arg_474_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_474_1.leftNameTxt_.transform)

				arg_474_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_474_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_474_1:RecordName(arg_474_1.leftNameTxt_.text)
				SetActive(arg_474_1.iconTrs_.gameObject, false)
				arg_474_1.callingController_:SetSelectedState("normal")

				local var_477_2 = arg_474_1:GetWordFromCfg(319501115)
				local var_477_3 = arg_474_1:FormatText(var_477_2.content)

				arg_474_1.text_.text = var_477_3

				LuaForUtil.ClearLinePrefixSymbol(arg_474_1.text_)

				local var_477_5 = 53 <= 0 and var_477_1 or var_477_1 * (utf8.len(var_477_3) / 53)

				if (53 <= 0 and var_477_1 or var_477_1 * (utf8.len(var_477_3) / 53)) > 0 and var_477_1 < var_477_5 then
					arg_474_1.talkMaxDuration = var_477_5

					if var_477_5 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_5 + var_477_0
					end
				end

				arg_474_1.text_.text = var_477_3
				arg_474_1.typewritter.percent = 0

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501115", "story_v_out_319501.awb") ~= 0 then
					local var_477_6 = manager.audio:GetVoiceLength("story_v_out_319501", "319501115", "story_v_out_319501.awb") / 1000

					if var_477_6 + var_477_0 > arg_474_1.duration_ then
						arg_474_1.duration_ = var_477_6 + var_477_0
					end

					if var_477_2.prefab_name ~= "" and arg_474_1.actors_[var_477_2.prefab_name] ~= nil then
						local var_477_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_474_1.actors_[var_477_2.prefab_name].transform, "story_v_out_319501", "319501115", "story_v_out_319501.awb")

						arg_474_1:RecordAudio("319501115", var_477_7)
						arg_474_1:RecordAudio("319501115", var_477_7)
					else
						arg_474_1:AudioAction("play", "voice", "story_v_out_319501", "319501115", "story_v_out_319501.awb")
					end

					arg_474_1:RecordHistoryTalkVoice("story_v_out_319501", "319501115", "story_v_out_319501.awb")
				end

				arg_474_1:RecordContent(arg_474_1.text_.text)
			end

			local var_477_8 = math.max(var_477_1, arg_474_1.talkMaxDuration)

			if var_477_0 <= arg_474_1.time_ and arg_474_1.time_ < var_477_0 + var_477_8 then
				arg_474_1.typewritter.percent = (arg_474_1.time_ - var_477_0) / var_477_8

				arg_474_1.typewritter:SetDirty()
			end

			if arg_474_1.time_ >= var_477_0 + var_477_8 and arg_474_1.time_ < var_477_0 + var_477_8 + arg_477_0 then
				arg_474_1.typewritter.percent = 1

				arg_474_1.typewritter:SetDirty()
				arg_474_1:ShowNextGo(true)
			end
		end

		arg_474_1.nodeConfigList_ = {}

		arg_474_1:InitPlayNodeList()
	end,
	Play319501116 = function(arg_478_0, arg_478_1)
		arg_478_1.time_ = 0
		arg_478_1.frameCnt_ = 0
		arg_478_1.state_ = "playing"
		arg_478_1.curTalkId_ = 319501116
		arg_478_1.duration_ = 4.83

		local var_478_0 = {
			zh = 4.366,
			ja = 4.833
		}
		local var_478_1 = manager.audio:GetLocalizationFlag()

		if var_478_0[var_478_1] ~= nil then
			arg_478_1.duration_ = var_478_0[var_478_1]
		end

		SetActive(arg_478_1.tipsGo_, false)

		function arg_478_1.onSingleLineFinish_()
			arg_478_1.onSingleLineUpdate_ = nil
			arg_478_1.onSingleLineFinish_ = nil
			arg_478_1.state_ = "waiting"
		end

		function arg_478_1.playNext_(arg_480_0)
			if arg_480_0 == 1 then
				arg_478_0:Play319501117(arg_478_1)
			end
		end

		function arg_478_1.onSingleLineUpdate_(arg_481_0)
			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(arg_478_1.actors_["10068ui_story"]) and arg_478_1.var_.characterEffect10068ui_story == nil then
				arg_478_1.var_.characterEffect10068ui_story = arg_478_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_0 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_0 and not isNil(arg_478_1.actors_["10068ui_story"]) then
				if arg_478_1.var_.characterEffect10068ui_story and not isNil(arg_478_1.actors_["10068ui_story"]) then
					arg_478_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_478_1.time_ >= 0 + var_481_0 and arg_478_1.time_ < 0 + var_481_0 + arg_481_0 and not isNil(arg_478_1.actors_["10068ui_story"]) and arg_478_1.var_.characterEffect10068ui_story then
				arg_478_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 then
				arg_478_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_481_2 = arg_478_1.actors_["1084ui_story"]

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= 0 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.characterEffect1084ui_story == nil then
				arg_478_1.var_.characterEffect1084ui_story = var_481_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_481_3 = 0.200000002980232

			if 0 <= arg_478_1.time_ and arg_478_1.time_ < 0 + var_481_3 and not isNil(var_481_2) then
				if arg_478_1.var_.characterEffect1084ui_story and not isNil(var_481_2) then
					arg_478_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_478_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_478_1.time_ - 0) / var_481_3)
				end
			end

			if arg_478_1.time_ >= 0 + var_481_3 and arg_478_1.time_ < 0 + var_481_3 + arg_481_0 and not isNil(var_481_2) and arg_478_1.var_.characterEffect1084ui_story then
				arg_478_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_478_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_481_4 = 0
			local var_481_5 = 0.325

			if 0 < arg_478_1.time_ and arg_478_1.time_ <= var_481_4 + arg_481_0 then
				arg_478_1.talkMaxDuration = 0
				arg_478_1.dialogCg_.alpha = 1

				arg_478_1.dialog_:SetActive(true)
				SetActive(arg_478_1.leftNameGo_, true)

				arg_478_1.leftNameTxt_.text = arg_478_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_478_1.leftNameTxt_.transform)

				arg_478_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_478_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_478_1:RecordName(arg_478_1.leftNameTxt_.text)
				SetActive(arg_478_1.iconTrs_.gameObject, false)
				arg_478_1.callingController_:SetSelectedState("normal")

				local var_481_6 = arg_478_1:GetWordFromCfg(319501116)
				local var_481_7 = arg_478_1:FormatText(var_481_6.content)

				arg_478_1.text_.text = var_481_7

				LuaForUtil.ClearLinePrefixSymbol(arg_478_1.text_)

				local var_481_9 = 13 <= 0 and var_481_5 or var_481_5 * (utf8.len(var_481_7) / 13)

				if (13 <= 0 and var_481_5 or var_481_5 * (utf8.len(var_481_7) / 13)) > 0 and var_481_5 < var_481_9 then
					arg_478_1.talkMaxDuration = var_481_9

					if var_481_9 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_9 + var_481_4
					end
				end

				arg_478_1.text_.text = var_481_7
				arg_478_1.typewritter.percent = 0

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501116", "story_v_out_319501.awb") ~= 0 then
					local var_481_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501116", "story_v_out_319501.awb") / 1000

					if var_481_10 + var_481_4 > arg_478_1.duration_ then
						arg_478_1.duration_ = var_481_10 + var_481_4
					end

					if var_481_6.prefab_name ~= "" and arg_478_1.actors_[var_481_6.prefab_name] ~= nil then
						local var_481_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_478_1.actors_[var_481_6.prefab_name].transform, "story_v_out_319501", "319501116", "story_v_out_319501.awb")

						arg_478_1:RecordAudio("319501116", var_481_11)
						arg_478_1:RecordAudio("319501116", var_481_11)
					else
						arg_478_1:AudioAction("play", "voice", "story_v_out_319501", "319501116", "story_v_out_319501.awb")
					end

					arg_478_1:RecordHistoryTalkVoice("story_v_out_319501", "319501116", "story_v_out_319501.awb")
				end

				arg_478_1:RecordContent(arg_478_1.text_.text)
			end

			local var_481_12 = math.max(var_481_5, arg_478_1.talkMaxDuration)

			if var_481_4 <= arg_478_1.time_ and arg_478_1.time_ < var_481_4 + var_481_12 then
				arg_478_1.typewritter.percent = (arg_478_1.time_ - var_481_4) / var_481_12

				arg_478_1.typewritter:SetDirty()
			end

			if arg_478_1.time_ >= var_481_4 + var_481_12 and arg_478_1.time_ < var_481_4 + var_481_12 + arg_481_0 then
				arg_478_1.typewritter.percent = 1

				arg_478_1.typewritter:SetDirty()
				arg_478_1:ShowNextGo(true)
			end
		end

		arg_478_1.nodeConfigList_ = {}

		arg_478_1:InitPlayNodeList()
	end,
	Play319501117 = function(arg_482_0, arg_482_1)
		arg_482_1.time_ = 0
		arg_482_1.frameCnt_ = 0
		arg_482_1.state_ = "playing"
		arg_482_1.curTalkId_ = 319501117
		arg_482_1.duration_ = 8.07

		local var_482_0 = {
			zh = 3.1,
			ja = 8.066
		}
		local var_482_1 = manager.audio:GetLocalizationFlag()

		if var_482_0[var_482_1] ~= nil then
			arg_482_1.duration_ = var_482_0[var_482_1]
		end

		SetActive(arg_482_1.tipsGo_, false)

		function arg_482_1.onSingleLineFinish_()
			arg_482_1.onSingleLineUpdate_ = nil
			arg_482_1.onSingleLineFinish_ = nil
			arg_482_1.state_ = "waiting"
		end

		function arg_482_1.playNext_(arg_484_0)
			if arg_484_0 == 1 then
				arg_482_0:Play319501118(arg_482_1)
			end
		end

		function arg_482_1.onSingleLineUpdate_(arg_485_0)
			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(arg_482_1.actors_["10068ui_story"]) and arg_482_1.var_.characterEffect10068ui_story == nil then
				arg_482_1.var_.characterEffect10068ui_story = arg_482_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_0 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_0 and not isNil(arg_482_1.actors_["10068ui_story"]) then
				if arg_482_1.var_.characterEffect10068ui_story and not isNil(arg_482_1.actors_["10068ui_story"]) then
					arg_482_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_482_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_482_1.time_ - 0) / var_485_0)
				end
			end

			if arg_482_1.time_ >= 0 + var_485_0 and arg_482_1.time_ < 0 + var_485_0 + arg_485_0 and not isNil(arg_482_1.actors_["10068ui_story"]) and arg_482_1.var_.characterEffect10068ui_story then
				arg_482_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_482_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_485_1 = arg_482_1.actors_["1084ui_story"]

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect1084ui_story == nil then
				arg_482_1.var_.characterEffect1084ui_story = var_485_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_485_2 = 0.200000002980232

			if 0 <= arg_482_1.time_ and arg_482_1.time_ < 0 + var_485_2 and not isNil(var_485_1) then
				if arg_482_1.var_.characterEffect1084ui_story and not isNil(var_485_1) then
					arg_482_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_482_1.time_ >= 0 + var_485_2 and arg_482_1.time_ < 0 + var_485_2 + arg_485_0 and not isNil(var_485_1) and arg_482_1.var_.characterEffect1084ui_story then
				arg_482_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_2")
			end

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= 0 + arg_485_0 then
				arg_482_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_485_4 = 0
			local var_485_5 = 0.25

			if 0 < arg_482_1.time_ and arg_482_1.time_ <= var_485_4 + arg_485_0 then
				arg_482_1.talkMaxDuration = 0
				arg_482_1.dialogCg_.alpha = 1

				arg_482_1.dialog_:SetActive(true)
				SetActive(arg_482_1.leftNameGo_, true)

				arg_482_1.leftNameTxt_.text = arg_482_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_482_1.leftNameTxt_.transform)

				arg_482_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_482_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_482_1:RecordName(arg_482_1.leftNameTxt_.text)
				SetActive(arg_482_1.iconTrs_.gameObject, false)
				arg_482_1.callingController_:SetSelectedState("normal")

				local var_485_6 = arg_482_1:GetWordFromCfg(319501117)
				local var_485_7 = arg_482_1:FormatText(var_485_6.content)

				arg_482_1.text_.text = var_485_7

				LuaForUtil.ClearLinePrefixSymbol(arg_482_1.text_)

				local var_485_9 = 10 <= 0 and var_485_5 or var_485_5 * (utf8.len(var_485_7) / 10)

				if (10 <= 0 and var_485_5 or var_485_5 * (utf8.len(var_485_7) / 10)) > 0 and var_485_5 < var_485_9 then
					arg_482_1.talkMaxDuration = var_485_9

					if var_485_9 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_9 + var_485_4
					end
				end

				arg_482_1.text_.text = var_485_7
				arg_482_1.typewritter.percent = 0

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501117", "story_v_out_319501.awb") ~= 0 then
					local var_485_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501117", "story_v_out_319501.awb") / 1000

					if var_485_10 + var_485_4 > arg_482_1.duration_ then
						arg_482_1.duration_ = var_485_10 + var_485_4
					end

					if var_485_6.prefab_name ~= "" and arg_482_1.actors_[var_485_6.prefab_name] ~= nil then
						local var_485_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_482_1.actors_[var_485_6.prefab_name].transform, "story_v_out_319501", "319501117", "story_v_out_319501.awb")

						arg_482_1:RecordAudio("319501117", var_485_11)
						arg_482_1:RecordAudio("319501117", var_485_11)
					else
						arg_482_1:AudioAction("play", "voice", "story_v_out_319501", "319501117", "story_v_out_319501.awb")
					end

					arg_482_1:RecordHistoryTalkVoice("story_v_out_319501", "319501117", "story_v_out_319501.awb")
				end

				arg_482_1:RecordContent(arg_482_1.text_.text)
			end

			local var_485_12 = math.max(var_485_5, arg_482_1.talkMaxDuration)

			if var_485_4 <= arg_482_1.time_ and arg_482_1.time_ < var_485_4 + var_485_12 then
				arg_482_1.typewritter.percent = (arg_482_1.time_ - var_485_4) / var_485_12

				arg_482_1.typewritter:SetDirty()
			end

			if arg_482_1.time_ >= var_485_4 + var_485_12 and arg_482_1.time_ < var_485_4 + var_485_12 + arg_485_0 then
				arg_482_1.typewritter.percent = 1

				arg_482_1.typewritter:SetDirty()
				arg_482_1:ShowNextGo(true)
			end
		end

		arg_482_1.nodeConfigList_ = {}

		arg_482_1:InitPlayNodeList()
	end,
	Play319501118 = function(arg_486_0, arg_486_1)
		arg_486_1.time_ = 0
		arg_486_1.frameCnt_ = 0
		arg_486_1.state_ = "playing"
		arg_486_1.curTalkId_ = 319501118
		arg_486_1.duration_ = 5

		SetActive(arg_486_1.tipsGo_, false)

		function arg_486_1.onSingleLineFinish_()
			arg_486_1.onSingleLineUpdate_ = nil
			arg_486_1.onSingleLineFinish_ = nil
			arg_486_1.state_ = "waiting"
		end

		function arg_486_1.playNext_(arg_488_0)
			if arg_488_0 == 1 then
				arg_486_0:Play319501119(arg_486_1)
			end
		end

		function arg_486_1.onSingleLineUpdate_(arg_489_0)
			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_2")
			end

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 then
				arg_486_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_489_0 = arg_486_1.actors_["1084ui_story"]

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= 0 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1084ui_story == nil then
				arg_486_1.var_.characterEffect1084ui_story = var_489_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_489_1 = 0.200000002980232

			if 0 <= arg_486_1.time_ and arg_486_1.time_ < 0 + var_489_1 and not isNil(var_489_0) then
				if arg_486_1.var_.characterEffect1084ui_story and not isNil(var_489_0) then
					arg_486_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_486_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_486_1.time_ - 0) / var_489_1)
				end
			end

			if arg_486_1.time_ >= 0 + var_489_1 and arg_486_1.time_ < 0 + var_489_1 + arg_489_0 and not isNil(var_489_0) and arg_486_1.var_.characterEffect1084ui_story then
				arg_486_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_486_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_489_2 = 0
			local var_489_3 = 0.65

			if 0 < arg_486_1.time_ and arg_486_1.time_ <= var_489_2 + arg_489_0 then
				arg_486_1.talkMaxDuration = 0
				arg_486_1.dialogCg_.alpha = 1

				arg_486_1.dialog_:SetActive(true)
				SetActive(arg_486_1.leftNameGo_, false)

				arg_486_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_486_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_486_1:RecordName(arg_486_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_486_1.iconTrs_.gameObject, false)
				arg_486_1.callingController_:SetSelectedState("normal")

				local var_489_4 = arg_486_1:FormatText(arg_486_1:GetWordFromCfg(319501118).content)

				arg_486_1.text_.text = var_489_4

				LuaForUtil.ClearLinePrefixSymbol(arg_486_1.text_)

				local var_489_6 = 26 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_4) / 26)

				if (26 <= 0 and var_489_3 or var_489_3 * (utf8.len(var_489_4) / 26)) > 0 and var_489_3 < var_489_6 then
					arg_486_1.talkMaxDuration = var_489_6

					if var_489_6 + var_489_2 > arg_486_1.duration_ then
						arg_486_1.duration_ = var_489_6 + var_489_2
					end
				end

				arg_486_1.text_.text = var_489_4
				arg_486_1.typewritter.percent = 0

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(false)
				arg_486_1:RecordContent(arg_486_1.text_.text)
			end

			local var_489_7 = math.max(var_489_3, arg_486_1.talkMaxDuration)

			if var_489_2 <= arg_486_1.time_ and arg_486_1.time_ < var_489_2 + var_489_7 then
				arg_486_1.typewritter.percent = (arg_486_1.time_ - var_489_2) / var_489_7

				arg_486_1.typewritter:SetDirty()
			end

			if arg_486_1.time_ >= var_489_2 + var_489_7 and arg_486_1.time_ < var_489_2 + var_489_7 + arg_489_0 then
				arg_486_1.typewritter.percent = 1

				arg_486_1.typewritter:SetDirty()
				arg_486_1:ShowNextGo(true)
			end
		end

		arg_486_1.nodeConfigList_ = {}

		arg_486_1:InitPlayNodeList()
	end,
	Play319501119 = function(arg_490_0, arg_490_1)
		arg_490_1.time_ = 0
		arg_490_1.frameCnt_ = 0
		arg_490_1.state_ = "playing"
		arg_490_1.curTalkId_ = 319501119
		arg_490_1.duration_ = 5

		SetActive(arg_490_1.tipsGo_, false)

		function arg_490_1.onSingleLineFinish_()
			arg_490_1.onSingleLineUpdate_ = nil
			arg_490_1.onSingleLineFinish_ = nil
			arg_490_1.state_ = "waiting"
		end

		function arg_490_1.playNext_(arg_492_0)
			if arg_492_0 == 1 then
				arg_490_0:Play319501120(arg_490_1)
			end
		end

		function arg_490_1.onSingleLineUpdate_(arg_493_0)
			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= 0 + arg_493_0 then
				arg_490_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_493_1 = 0
			local var_493_2 = 1.475

			if 0 < arg_490_1.time_ and arg_490_1.time_ <= var_493_1 + arg_493_0 then
				arg_490_1.talkMaxDuration = 0
				arg_490_1.dialogCg_.alpha = 1

				arg_490_1.dialog_:SetActive(true)
				SetActive(arg_490_1.leftNameGo_, false)

				arg_490_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_490_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_490_1:RecordName(arg_490_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_490_1.iconTrs_.gameObject, false)
				arg_490_1.callingController_:SetSelectedState("normal")

				local var_493_3 = arg_490_1:FormatText(arg_490_1:GetWordFromCfg(319501119).content)

				arg_490_1.text_.text = var_493_3

				LuaForUtil.ClearLinePrefixSymbol(arg_490_1.text_)

				local var_493_5 = 59 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 59)

				if (59 <= 0 and var_493_2 or var_493_2 * (utf8.len(var_493_3) / 59)) > 0 and var_493_2 < var_493_5 then
					arg_490_1.talkMaxDuration = var_493_5

					if var_493_5 + var_493_1 > arg_490_1.duration_ then
						arg_490_1.duration_ = var_493_5 + var_493_1
					end
				end

				arg_490_1.text_.text = var_493_3
				arg_490_1.typewritter.percent = 0

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(false)
				arg_490_1:RecordContent(arg_490_1.text_.text)
			end

			local var_493_6 = math.max(var_493_2, arg_490_1.talkMaxDuration)

			if var_493_1 <= arg_490_1.time_ and arg_490_1.time_ < var_493_1 + var_493_6 then
				arg_490_1.typewritter.percent = (arg_490_1.time_ - var_493_1) / var_493_6

				arg_490_1.typewritter:SetDirty()
			end

			if arg_490_1.time_ >= var_493_1 + var_493_6 and arg_490_1.time_ < var_493_1 + var_493_6 + arg_493_0 then
				arg_490_1.typewritter.percent = 1

				arg_490_1.typewritter:SetDirty()
				arg_490_1:ShowNextGo(true)
			end
		end

		arg_490_1.nodeConfigList_ = {}

		arg_490_1:InitPlayNodeList()
	end,
	Play319501120 = function(arg_494_0, arg_494_1)
		arg_494_1.time_ = 0
		arg_494_1.frameCnt_ = 0
		arg_494_1.state_ = "playing"
		arg_494_1.curTalkId_ = 319501120
		arg_494_1.duration_ = 8.5

		local var_494_0 = {
			zh = 5.5,
			ja = 8.5
		}
		local var_494_1 = manager.audio:GetLocalizationFlag()

		if var_494_0[var_494_1] ~= nil then
			arg_494_1.duration_ = var_494_0[var_494_1]
		end

		SetActive(arg_494_1.tipsGo_, false)

		function arg_494_1.onSingleLineFinish_()
			arg_494_1.onSingleLineUpdate_ = nil
			arg_494_1.onSingleLineFinish_ = nil
			arg_494_1.state_ = "waiting"
		end

		function arg_494_1.playNext_(arg_496_0)
			if arg_496_0 == 1 then
				arg_494_0:Play319501121(arg_494_1)
			end
		end

		function arg_494_1.onSingleLineUpdate_(arg_497_0)
			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 and not isNil(arg_494_1.actors_["1084ui_story"]) and arg_494_1.var_.characterEffect1084ui_story == nil then
				arg_494_1.var_.characterEffect1084ui_story = arg_494_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_497_0 = 0.200000002980232

			if 0 <= arg_494_1.time_ and arg_494_1.time_ < 0 + var_497_0 and not isNil(arg_494_1.actors_["1084ui_story"]) then
				if arg_494_1.var_.characterEffect1084ui_story and not isNil(arg_494_1.actors_["1084ui_story"]) then
					arg_494_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_494_1.time_ >= 0 + var_497_0 and arg_494_1.time_ < 0 + var_497_0 + arg_497_0 and not isNil(arg_494_1.actors_["1084ui_story"]) and arg_494_1.var_.characterEffect1084ui_story then
				arg_494_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= 0 + arg_497_0 then
				arg_494_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_497_3 = 0
			local var_497_4 = 0.575

			if 0 < arg_494_1.time_ and arg_494_1.time_ <= var_497_3 + arg_497_0 then
				arg_494_1.talkMaxDuration = 0
				arg_494_1.dialogCg_.alpha = 1

				arg_494_1.dialog_:SetActive(true)
				SetActive(arg_494_1.leftNameGo_, true)

				arg_494_1.leftNameTxt_.text = arg_494_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_494_1.leftNameTxt_.transform)

				arg_494_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_494_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_494_1:RecordName(arg_494_1.leftNameTxt_.text)
				SetActive(arg_494_1.iconTrs_.gameObject, false)
				arg_494_1.callingController_:SetSelectedState("normal")

				local var_497_5 = arg_494_1:GetWordFromCfg(319501120)
				local var_497_6 = arg_494_1:FormatText(var_497_5.content)

				arg_494_1.text_.text = var_497_6

				LuaForUtil.ClearLinePrefixSymbol(arg_494_1.text_)

				local var_497_8 = 23 <= 0 and var_497_4 or var_497_4 * (utf8.len(var_497_6) / 23)

				if (23 <= 0 and var_497_4 or var_497_4 * (utf8.len(var_497_6) / 23)) > 0 and var_497_4 < var_497_8 then
					arg_494_1.talkMaxDuration = var_497_8

					if var_497_8 + var_497_3 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_8 + var_497_3
					end
				end

				arg_494_1.text_.text = var_497_6
				arg_494_1.typewritter.percent = 0

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501120", "story_v_out_319501.awb") ~= 0 then
					local var_497_9 = manager.audio:GetVoiceLength("story_v_out_319501", "319501120", "story_v_out_319501.awb") / 1000

					if var_497_9 + var_497_3 > arg_494_1.duration_ then
						arg_494_1.duration_ = var_497_9 + var_497_3
					end

					if var_497_5.prefab_name ~= "" and arg_494_1.actors_[var_497_5.prefab_name] ~= nil then
						local var_497_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_494_1.actors_[var_497_5.prefab_name].transform, "story_v_out_319501", "319501120", "story_v_out_319501.awb")

						arg_494_1:RecordAudio("319501120", var_497_10)
						arg_494_1:RecordAudio("319501120", var_497_10)
					else
						arg_494_1:AudioAction("play", "voice", "story_v_out_319501", "319501120", "story_v_out_319501.awb")
					end

					arg_494_1:RecordHistoryTalkVoice("story_v_out_319501", "319501120", "story_v_out_319501.awb")
				end

				arg_494_1:RecordContent(arg_494_1.text_.text)
			end

			local var_497_11 = math.max(var_497_4, arg_494_1.talkMaxDuration)

			if var_497_3 <= arg_494_1.time_ and arg_494_1.time_ < var_497_3 + var_497_11 then
				arg_494_1.typewritter.percent = (arg_494_1.time_ - var_497_3) / var_497_11

				arg_494_1.typewritter:SetDirty()
			end

			if arg_494_1.time_ >= var_497_3 + var_497_11 and arg_494_1.time_ < var_497_3 + var_497_11 + arg_497_0 then
				arg_494_1.typewritter.percent = 1

				arg_494_1.typewritter:SetDirty()
				arg_494_1:ShowNextGo(true)
			end
		end

		arg_494_1.nodeConfigList_ = {}

		arg_494_1:InitPlayNodeList()
	end,
	Play319501121 = function(arg_498_0, arg_498_1)
		arg_498_1.time_ = 0
		arg_498_1.frameCnt_ = 0
		arg_498_1.state_ = "playing"
		arg_498_1.curTalkId_ = 319501121
		arg_498_1.duration_ = 3.8

		local var_498_0 = {
			zh = 1.999999999999,
			ja = 3.8
		}
		local var_498_1 = manager.audio:GetLocalizationFlag()

		if var_498_0[var_498_1] ~= nil then
			arg_498_1.duration_ = var_498_0[var_498_1]
		end

		SetActive(arg_498_1.tipsGo_, false)

		function arg_498_1.onSingleLineFinish_()
			arg_498_1.onSingleLineUpdate_ = nil
			arg_498_1.onSingleLineFinish_ = nil
			arg_498_1.state_ = "waiting"
		end

		function arg_498_1.playNext_(arg_500_0)
			if arg_500_0 == 1 then
				arg_498_0:Play319501122(arg_498_1)
			end
		end

		function arg_498_1.onSingleLineUpdate_(arg_501_0)
			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(arg_498_1.actors_["1084ui_story"]) and arg_498_1.var_.characterEffect1084ui_story == nil then
				arg_498_1.var_.characterEffect1084ui_story = arg_498_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_0 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_0 and not isNil(arg_498_1.actors_["1084ui_story"]) then
				if arg_498_1.var_.characterEffect1084ui_story and not isNil(arg_498_1.actors_["1084ui_story"]) then
					arg_498_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_498_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_498_1.time_ - 0) / var_501_0)
				end
			end

			if arg_498_1.time_ >= 0 + var_501_0 and arg_498_1.time_ < 0 + var_501_0 + arg_501_0 and not isNil(arg_498_1.actors_["1084ui_story"]) and arg_498_1.var_.characterEffect1084ui_story then
				arg_498_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_498_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 then
				arg_498_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_501_1 = arg_498_1.actors_["10068ui_story"]

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= 0 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect10068ui_story == nil then
				arg_498_1.var_.characterEffect10068ui_story = var_501_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_501_2 = 0.200000002980232

			if 0 <= arg_498_1.time_ and arg_498_1.time_ < 0 + var_501_2 and not isNil(var_501_1) then
				if arg_498_1.var_.characterEffect10068ui_story and not isNil(var_501_1) then
					arg_498_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_498_1.time_ >= 0 + var_501_2 and arg_498_1.time_ < 0 + var_501_2 + arg_501_0 and not isNil(var_501_1) and arg_498_1.var_.characterEffect10068ui_story then
				arg_498_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_501_4 = 0
			local var_501_5 = 0.125

			if 0 < arg_498_1.time_ and arg_498_1.time_ <= var_501_4 + arg_501_0 then
				arg_498_1.talkMaxDuration = 0
				arg_498_1.dialogCg_.alpha = 1

				arg_498_1.dialog_:SetActive(true)
				SetActive(arg_498_1.leftNameGo_, true)

				arg_498_1.leftNameTxt_.text = arg_498_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_498_1.leftNameTxt_.transform)

				arg_498_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_498_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_498_1:RecordName(arg_498_1.leftNameTxt_.text)
				SetActive(arg_498_1.iconTrs_.gameObject, false)
				arg_498_1.callingController_:SetSelectedState("normal")

				local var_501_6 = arg_498_1:GetWordFromCfg(319501121)
				local var_501_7 = arg_498_1:FormatText(var_501_6.content)

				arg_498_1.text_.text = var_501_7

				LuaForUtil.ClearLinePrefixSymbol(arg_498_1.text_)

				local var_501_9 = 5 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 5)

				if (5 <= 0 and var_501_5 or var_501_5 * (utf8.len(var_501_7) / 5)) > 0 and var_501_5 < var_501_9 then
					arg_498_1.talkMaxDuration = var_501_9

					if var_501_9 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_9 + var_501_4
					end
				end

				arg_498_1.text_.text = var_501_7
				arg_498_1.typewritter.percent = 0

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501121", "story_v_out_319501.awb") ~= 0 then
					local var_501_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501121", "story_v_out_319501.awb") / 1000

					if var_501_10 + var_501_4 > arg_498_1.duration_ then
						arg_498_1.duration_ = var_501_10 + var_501_4
					end

					if var_501_6.prefab_name ~= "" and arg_498_1.actors_[var_501_6.prefab_name] ~= nil then
						local var_501_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_498_1.actors_[var_501_6.prefab_name].transform, "story_v_out_319501", "319501121", "story_v_out_319501.awb")

						arg_498_1:RecordAudio("319501121", var_501_11)
						arg_498_1:RecordAudio("319501121", var_501_11)
					else
						arg_498_1:AudioAction("play", "voice", "story_v_out_319501", "319501121", "story_v_out_319501.awb")
					end

					arg_498_1:RecordHistoryTalkVoice("story_v_out_319501", "319501121", "story_v_out_319501.awb")
				end

				arg_498_1:RecordContent(arg_498_1.text_.text)
			end

			local var_501_12 = math.max(var_501_5, arg_498_1.talkMaxDuration)

			if var_501_4 <= arg_498_1.time_ and arg_498_1.time_ < var_501_4 + var_501_12 then
				arg_498_1.typewritter.percent = (arg_498_1.time_ - var_501_4) / var_501_12

				arg_498_1.typewritter:SetDirty()
			end

			if arg_498_1.time_ >= var_501_4 + var_501_12 and arg_498_1.time_ < var_501_4 + var_501_12 + arg_501_0 then
				arg_498_1.typewritter.percent = 1

				arg_498_1.typewritter:SetDirty()
				arg_498_1:ShowNextGo(true)
			end
		end

		arg_498_1.nodeConfigList_ = {}

		arg_498_1:InitPlayNodeList()
	end,
	Play319501122 = function(arg_502_0, arg_502_1)
		arg_502_1.time_ = 0
		arg_502_1.frameCnt_ = 0
		arg_502_1.state_ = "playing"
		arg_502_1.curTalkId_ = 319501122
		arg_502_1.duration_ = 2.57

		local var_502_0 = {
			zh = 1.633,
			ja = 2.566
		}
		local var_502_1 = manager.audio:GetLocalizationFlag()

		if var_502_0[var_502_1] ~= nil then
			arg_502_1.duration_ = var_502_0[var_502_1]
		end

		SetActive(arg_502_1.tipsGo_, false)

		function arg_502_1.onSingleLineFinish_()
			arg_502_1.onSingleLineUpdate_ = nil
			arg_502_1.onSingleLineFinish_ = nil
			arg_502_1.state_ = "waiting"
		end

		function arg_502_1.playNext_(arg_504_0)
			if arg_504_0 == 1 then
				arg_502_0:Play319501123(arg_502_1)
			end
		end

		function arg_502_1.onSingleLineUpdate_(arg_505_0)
			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(arg_502_1.actors_["1084ui_story"]) and arg_502_1.var_.characterEffect1084ui_story == nil then
				arg_502_1.var_.characterEffect1084ui_story = arg_502_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_0 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_0 and not isNil(arg_502_1.actors_["1084ui_story"]) then
				if arg_502_1.var_.characterEffect1084ui_story and not isNil(arg_502_1.actors_["1084ui_story"]) then
					arg_502_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_502_1.time_ >= 0 + var_505_0 and arg_502_1.time_ < 0 + var_505_0 + arg_505_0 and not isNil(arg_502_1.actors_["1084ui_story"]) and arg_502_1.var_.characterEffect1084ui_story then
				arg_502_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_505_2 = arg_502_1.actors_["10068ui_story"]

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= 0 + arg_505_0 and not isNil(var_505_2) and arg_502_1.var_.characterEffect10068ui_story == nil then
				arg_502_1.var_.characterEffect10068ui_story = var_505_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_505_3 = 0.200000002980232

			if 0 <= arg_502_1.time_ and arg_502_1.time_ < 0 + var_505_3 and not isNil(var_505_2) then
				if arg_502_1.var_.characterEffect10068ui_story and not isNil(var_505_2) then
					arg_502_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_502_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_502_1.time_ - 0) / var_505_3)
				end
			end

			if arg_502_1.time_ >= 0 + var_505_3 and arg_502_1.time_ < 0 + var_505_3 + arg_505_0 and not isNil(var_505_2) and arg_502_1.var_.characterEffect10068ui_story then
				arg_502_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_502_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_505_4 = 0
			local var_505_5 = 0.15

			if 0 < arg_502_1.time_ and arg_502_1.time_ <= var_505_4 + arg_505_0 then
				arg_502_1.talkMaxDuration = 0
				arg_502_1.dialogCg_.alpha = 1

				arg_502_1.dialog_:SetActive(true)
				SetActive(arg_502_1.leftNameGo_, true)

				arg_502_1.leftNameTxt_.text = arg_502_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_502_1.leftNameTxt_.transform)

				arg_502_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_502_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_502_1:RecordName(arg_502_1.leftNameTxt_.text)
				SetActive(arg_502_1.iconTrs_.gameObject, false)
				arg_502_1.callingController_:SetSelectedState("normal")

				local var_505_6 = arg_502_1:GetWordFromCfg(319501122)
				local var_505_7 = arg_502_1:FormatText(var_505_6.content)

				arg_502_1.text_.text = var_505_7

				LuaForUtil.ClearLinePrefixSymbol(arg_502_1.text_)

				local var_505_9 = 6 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 6)

				if (6 <= 0 and var_505_5 or var_505_5 * (utf8.len(var_505_7) / 6)) > 0 and var_505_5 < var_505_9 then
					arg_502_1.talkMaxDuration = var_505_9

					if var_505_9 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_9 + var_505_4
					end
				end

				arg_502_1.text_.text = var_505_7
				arg_502_1.typewritter.percent = 0

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501122", "story_v_out_319501.awb") ~= 0 then
					local var_505_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501122", "story_v_out_319501.awb") / 1000

					if var_505_10 + var_505_4 > arg_502_1.duration_ then
						arg_502_1.duration_ = var_505_10 + var_505_4
					end

					if var_505_6.prefab_name ~= "" and arg_502_1.actors_[var_505_6.prefab_name] ~= nil then
						local var_505_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_502_1.actors_[var_505_6.prefab_name].transform, "story_v_out_319501", "319501122", "story_v_out_319501.awb")

						arg_502_1:RecordAudio("319501122", var_505_11)
						arg_502_1:RecordAudio("319501122", var_505_11)
					else
						arg_502_1:AudioAction("play", "voice", "story_v_out_319501", "319501122", "story_v_out_319501.awb")
					end

					arg_502_1:RecordHistoryTalkVoice("story_v_out_319501", "319501122", "story_v_out_319501.awb")
				end

				arg_502_1:RecordContent(arg_502_1.text_.text)
			end

			local var_505_12 = math.max(var_505_5, arg_502_1.talkMaxDuration)

			if var_505_4 <= arg_502_1.time_ and arg_502_1.time_ < var_505_4 + var_505_12 then
				arg_502_1.typewritter.percent = (arg_502_1.time_ - var_505_4) / var_505_12

				arg_502_1.typewritter:SetDirty()
			end

			if arg_502_1.time_ >= var_505_4 + var_505_12 and arg_502_1.time_ < var_505_4 + var_505_12 + arg_505_0 then
				arg_502_1.typewritter.percent = 1

				arg_502_1.typewritter:SetDirty()
				arg_502_1:ShowNextGo(true)
			end
		end

		arg_502_1.nodeConfigList_ = {}

		arg_502_1:InitPlayNodeList()
	end,
	Play319501123 = function(arg_506_0, arg_506_1)
		arg_506_1.time_ = 0
		arg_506_1.frameCnt_ = 0
		arg_506_1.state_ = "playing"
		arg_506_1.curTalkId_ = 319501123
		arg_506_1.duration_ = 3.83

		local var_506_0 = {
			zh = 3.466,
			ja = 3.833
		}
		local var_506_1 = manager.audio:GetLocalizationFlag()

		if var_506_0[var_506_1] ~= nil then
			arg_506_1.duration_ = var_506_0[var_506_1]
		end

		SetActive(arg_506_1.tipsGo_, false)

		function arg_506_1.onSingleLineFinish_()
			arg_506_1.onSingleLineUpdate_ = nil
			arg_506_1.onSingleLineFinish_ = nil
			arg_506_1.state_ = "waiting"
		end

		function arg_506_1.playNext_(arg_508_0)
			if arg_508_0 == 1 then
				arg_506_0:Play319501124(arg_506_1)
			end
		end

		function arg_506_1.onSingleLineUpdate_(arg_509_0)
			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(arg_506_1.actors_["1084ui_story"]) and arg_506_1.var_.characterEffect1084ui_story == nil then
				arg_506_1.var_.characterEffect1084ui_story = arg_506_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_0 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_0 and not isNil(arg_506_1.actors_["1084ui_story"]) then
				if arg_506_1.var_.characterEffect1084ui_story and not isNil(arg_506_1.actors_["1084ui_story"]) then
					arg_506_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_506_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_506_1.time_ - 0) / var_509_0)
				end
			end

			if arg_506_1.time_ >= 0 + var_509_0 and arg_506_1.time_ < 0 + var_509_0 + arg_509_0 and not isNil(arg_506_1.actors_["1084ui_story"]) and arg_506_1.var_.characterEffect1084ui_story then
				arg_506_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_506_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_509_1 = arg_506_1.actors_["10068ui_story"]

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= 0 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect10068ui_story == nil then
				arg_506_1.var_.characterEffect10068ui_story = var_509_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_509_2 = 0.200000002980232

			if 0 <= arg_506_1.time_ and arg_506_1.time_ < 0 + var_509_2 and not isNil(var_509_1) then
				if arg_506_1.var_.characterEffect10068ui_story and not isNil(var_509_1) then
					arg_506_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_506_1.time_ >= 0 + var_509_2 and arg_506_1.time_ < 0 + var_509_2 + arg_509_0 and not isNil(var_509_1) and arg_506_1.var_.characterEffect10068ui_story then
				arg_506_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			local var_509_4 = 0
			local var_509_5 = 0.225

			if 0 < arg_506_1.time_ and arg_506_1.time_ <= var_509_4 + arg_509_0 then
				arg_506_1.talkMaxDuration = 0
				arg_506_1.dialogCg_.alpha = 1

				arg_506_1.dialog_:SetActive(true)
				SetActive(arg_506_1.leftNameGo_, true)

				arg_506_1.leftNameTxt_.text = arg_506_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_506_1.leftNameTxt_.transform)

				arg_506_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_506_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_506_1:RecordName(arg_506_1.leftNameTxt_.text)
				SetActive(arg_506_1.iconTrs_.gameObject, false)
				arg_506_1.callingController_:SetSelectedState("normal")

				local var_509_6 = arg_506_1:GetWordFromCfg(319501123)
				local var_509_7 = arg_506_1:FormatText(var_509_6.content)

				arg_506_1.text_.text = var_509_7

				LuaForUtil.ClearLinePrefixSymbol(arg_506_1.text_)

				local var_509_9 = 9 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_7) / 9)

				if (9 <= 0 and var_509_5 or var_509_5 * (utf8.len(var_509_7) / 9)) > 0 and var_509_5 < var_509_9 then
					arg_506_1.talkMaxDuration = var_509_9

					if var_509_9 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_9 + var_509_4
					end
				end

				arg_506_1.text_.text = var_509_7
				arg_506_1.typewritter.percent = 0

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501123", "story_v_out_319501.awb") ~= 0 then
					local var_509_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501123", "story_v_out_319501.awb") / 1000

					if var_509_10 + var_509_4 > arg_506_1.duration_ then
						arg_506_1.duration_ = var_509_10 + var_509_4
					end

					if var_509_6.prefab_name ~= "" and arg_506_1.actors_[var_509_6.prefab_name] ~= nil then
						local var_509_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_506_1.actors_[var_509_6.prefab_name].transform, "story_v_out_319501", "319501123", "story_v_out_319501.awb")

						arg_506_1:RecordAudio("319501123", var_509_11)
						arg_506_1:RecordAudio("319501123", var_509_11)
					else
						arg_506_1:AudioAction("play", "voice", "story_v_out_319501", "319501123", "story_v_out_319501.awb")
					end

					arg_506_1:RecordHistoryTalkVoice("story_v_out_319501", "319501123", "story_v_out_319501.awb")
				end

				arg_506_1:RecordContent(arg_506_1.text_.text)
			end

			local var_509_12 = math.max(var_509_5, arg_506_1.talkMaxDuration)

			if var_509_4 <= arg_506_1.time_ and arg_506_1.time_ < var_509_4 + var_509_12 then
				arg_506_1.typewritter.percent = (arg_506_1.time_ - var_509_4) / var_509_12

				arg_506_1.typewritter:SetDirty()
			end

			if arg_506_1.time_ >= var_509_4 + var_509_12 and arg_506_1.time_ < var_509_4 + var_509_12 + arg_509_0 then
				arg_506_1.typewritter.percent = 1

				arg_506_1.typewritter:SetDirty()
				arg_506_1:ShowNextGo(true)
			end
		end

		arg_506_1.nodeConfigList_ = {}

		arg_506_1:InitPlayNodeList()
	end,
	Play319501124 = function(arg_510_0, arg_510_1)
		arg_510_1.time_ = 0
		arg_510_1.frameCnt_ = 0
		arg_510_1.state_ = "playing"
		arg_510_1.curTalkId_ = 319501124
		arg_510_1.duration_ = 5

		SetActive(arg_510_1.tipsGo_, false)

		function arg_510_1.onSingleLineFinish_()
			arg_510_1.onSingleLineUpdate_ = nil
			arg_510_1.onSingleLineFinish_ = nil
			arg_510_1.state_ = "waiting"
		end

		function arg_510_1.playNext_(arg_512_0)
			if arg_512_0 == 1 then
				arg_510_0:Play319501125(arg_510_1)
			end
		end

		function arg_510_1.onSingleLineUpdate_(arg_513_0)
			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 and not isNil(arg_510_1.actors_["10068ui_story"]) and arg_510_1.var_.characterEffect10068ui_story == nil then
				arg_510_1.var_.characterEffect10068ui_story = arg_510_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_513_0 = 0.200000002980232

			if 0 <= arg_510_1.time_ and arg_510_1.time_ < 0 + var_513_0 and not isNil(arg_510_1.actors_["10068ui_story"]) then
				if arg_510_1.var_.characterEffect10068ui_story and not isNil(arg_510_1.actors_["10068ui_story"]) then
					arg_510_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_510_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_510_1.time_ - 0) / var_513_0)
				end
			end

			if arg_510_1.time_ >= 0 + var_513_0 and arg_510_1.time_ < 0 + var_513_0 + arg_513_0 and not isNil(arg_510_1.actors_["10068ui_story"]) and arg_510_1.var_.characterEffect10068ui_story then
				arg_510_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_510_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= 0 + arg_513_0 then
				arg_510_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_513_1 = 0
			local var_513_2 = 1.15

			if 0 < arg_510_1.time_ and arg_510_1.time_ <= var_513_1 + arg_513_0 then
				arg_510_1.talkMaxDuration = 0
				arg_510_1.dialogCg_.alpha = 1

				arg_510_1.dialog_:SetActive(true)
				SetActive(arg_510_1.leftNameGo_, false)

				arg_510_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_510_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_510_1:RecordName(arg_510_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_510_1.iconTrs_.gameObject, false)
				arg_510_1.callingController_:SetSelectedState("normal")

				local var_513_3 = arg_510_1:FormatText(arg_510_1:GetWordFromCfg(319501124).content)

				arg_510_1.text_.text = var_513_3

				LuaForUtil.ClearLinePrefixSymbol(arg_510_1.text_)

				local var_513_5 = 46 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 46)

				if (46 <= 0 and var_513_2 or var_513_2 * (utf8.len(var_513_3) / 46)) > 0 and var_513_2 < var_513_5 then
					arg_510_1.talkMaxDuration = var_513_5

					if var_513_5 + var_513_1 > arg_510_1.duration_ then
						arg_510_1.duration_ = var_513_5 + var_513_1
					end
				end

				arg_510_1.text_.text = var_513_3
				arg_510_1.typewritter.percent = 0

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(false)
				arg_510_1:RecordContent(arg_510_1.text_.text)
			end

			local var_513_6 = math.max(var_513_2, arg_510_1.talkMaxDuration)

			if var_513_1 <= arg_510_1.time_ and arg_510_1.time_ < var_513_1 + var_513_6 then
				arg_510_1.typewritter.percent = (arg_510_1.time_ - var_513_1) / var_513_6

				arg_510_1.typewritter:SetDirty()
			end

			if arg_510_1.time_ >= var_513_1 + var_513_6 and arg_510_1.time_ < var_513_1 + var_513_6 + arg_513_0 then
				arg_510_1.typewritter.percent = 1

				arg_510_1.typewritter:SetDirty()
				arg_510_1:ShowNextGo(true)
			end
		end

		arg_510_1.nodeConfigList_ = {}

		arg_510_1:InitPlayNodeList()
	end,
	Play319501125 = function(arg_514_0, arg_514_1)
		arg_514_1.time_ = 0
		arg_514_1.frameCnt_ = 0
		arg_514_1.state_ = "playing"
		arg_514_1.curTalkId_ = 319501125
		arg_514_1.duration_ = 5.9

		local var_514_0 = {
			zh = 2.766,
			ja = 5.9
		}
		local var_514_1 = manager.audio:GetLocalizationFlag()

		if var_514_0[var_514_1] ~= nil then
			arg_514_1.duration_ = var_514_0[var_514_1]
		end

		SetActive(arg_514_1.tipsGo_, false)

		function arg_514_1.onSingleLineFinish_()
			arg_514_1.onSingleLineUpdate_ = nil
			arg_514_1.onSingleLineFinish_ = nil
			arg_514_1.state_ = "waiting"
		end

		function arg_514_1.playNext_(arg_516_0)
			if arg_516_0 == 1 then
				arg_514_0:Play319501126(arg_514_1)
			end
		end

		function arg_514_1.onSingleLineUpdate_(arg_517_0)
			if 0 < arg_514_1.time_ and arg_514_1.time_ <= 0 + arg_517_0 and not isNil(arg_514_1.actors_["1084ui_story"]) and arg_514_1.var_.characterEffect1084ui_story == nil then
				arg_514_1.var_.characterEffect1084ui_story = arg_514_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_517_0 = 0.200000002980232

			if 0 <= arg_514_1.time_ and arg_514_1.time_ < 0 + var_517_0 and not isNil(arg_514_1.actors_["1084ui_story"]) then
				if arg_514_1.var_.characterEffect1084ui_story and not isNil(arg_514_1.actors_["1084ui_story"]) then
					arg_514_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_514_1.time_ >= 0 + var_517_0 and arg_514_1.time_ < 0 + var_517_0 + arg_517_0 and not isNil(arg_514_1.actors_["1084ui_story"]) and arg_514_1.var_.characterEffect1084ui_story then
				arg_514_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_517_2 = 0
			local var_517_3 = 0.3

			if 0 < arg_514_1.time_ and arg_514_1.time_ <= var_517_2 + arg_517_0 then
				arg_514_1.talkMaxDuration = 0
				arg_514_1.dialogCg_.alpha = 1

				arg_514_1.dialog_:SetActive(true)
				SetActive(arg_514_1.leftNameGo_, true)

				arg_514_1.leftNameTxt_.text = arg_514_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_514_1.leftNameTxt_.transform)

				arg_514_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_514_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_514_1:RecordName(arg_514_1.leftNameTxt_.text)
				SetActive(arg_514_1.iconTrs_.gameObject, false)
				arg_514_1.callingController_:SetSelectedState("normal")

				local var_517_4 = arg_514_1:GetWordFromCfg(319501125)
				local var_517_5 = arg_514_1:FormatText(var_517_4.content)

				arg_514_1.text_.text = var_517_5

				LuaForUtil.ClearLinePrefixSymbol(arg_514_1.text_)

				local var_517_7 = 12 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 12)

				if (12 <= 0 and var_517_3 or var_517_3 * (utf8.len(var_517_5) / 12)) > 0 and var_517_3 < var_517_7 then
					arg_514_1.talkMaxDuration = var_517_7

					if var_517_7 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_7 + var_517_2
					end
				end

				arg_514_1.text_.text = var_517_5
				arg_514_1.typewritter.percent = 0

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501125", "story_v_out_319501.awb") ~= 0 then
					local var_517_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501125", "story_v_out_319501.awb") / 1000

					if var_517_8 + var_517_2 > arg_514_1.duration_ then
						arg_514_1.duration_ = var_517_8 + var_517_2
					end

					if var_517_4.prefab_name ~= "" and arg_514_1.actors_[var_517_4.prefab_name] ~= nil then
						local var_517_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_514_1.actors_[var_517_4.prefab_name].transform, "story_v_out_319501", "319501125", "story_v_out_319501.awb")

						arg_514_1:RecordAudio("319501125", var_517_9)
						arg_514_1:RecordAudio("319501125", var_517_9)
					else
						arg_514_1:AudioAction("play", "voice", "story_v_out_319501", "319501125", "story_v_out_319501.awb")
					end

					arg_514_1:RecordHistoryTalkVoice("story_v_out_319501", "319501125", "story_v_out_319501.awb")
				end

				arg_514_1:RecordContent(arg_514_1.text_.text)
			end

			local var_517_10 = math.max(var_517_3, arg_514_1.talkMaxDuration)

			if var_517_2 <= arg_514_1.time_ and arg_514_1.time_ < var_517_2 + var_517_10 then
				arg_514_1.typewritter.percent = (arg_514_1.time_ - var_517_2) / var_517_10

				arg_514_1.typewritter:SetDirty()
			end

			if arg_514_1.time_ >= var_517_2 + var_517_10 and arg_514_1.time_ < var_517_2 + var_517_10 + arg_517_0 then
				arg_514_1.typewritter.percent = 1

				arg_514_1.typewritter:SetDirty()
				arg_514_1:ShowNextGo(true)
			end
		end

		arg_514_1.nodeConfigList_ = {}

		arg_514_1:InitPlayNodeList()
	end,
	Play319501126 = function(arg_518_0, arg_518_1)
		arg_518_1.time_ = 0
		arg_518_1.frameCnt_ = 0
		arg_518_1.state_ = "playing"
		arg_518_1.curTalkId_ = 319501126
		arg_518_1.duration_ = 5.9

		local var_518_0 = {
			zh = 2.6,
			ja = 5.9
		}
		local var_518_1 = manager.audio:GetLocalizationFlag()

		if var_518_0[var_518_1] ~= nil then
			arg_518_1.duration_ = var_518_0[var_518_1]
		end

		SetActive(arg_518_1.tipsGo_, false)

		function arg_518_1.onSingleLineFinish_()
			arg_518_1.onSingleLineUpdate_ = nil
			arg_518_1.onSingleLineFinish_ = nil
			arg_518_1.state_ = "waiting"
		end

		function arg_518_1.playNext_(arg_520_0)
			if arg_520_0 == 1 then
				arg_518_0:Play319501127(arg_518_1)
			end
		end

		function arg_518_1.onSingleLineUpdate_(arg_521_0)
			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(arg_518_1.actors_["10068ui_story"]) and arg_518_1.var_.characterEffect10068ui_story == nil then
				arg_518_1.var_.characterEffect10068ui_story = arg_518_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_0 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_0 and not isNil(arg_518_1.actors_["10068ui_story"]) then
				if arg_518_1.var_.characterEffect10068ui_story and not isNil(arg_518_1.actors_["10068ui_story"]) then
					arg_518_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_518_1.time_ >= 0 + var_521_0 and arg_518_1.time_ < 0 + var_521_0 + arg_521_0 and not isNil(arg_518_1.actors_["10068ui_story"]) and arg_518_1.var_.characterEffect10068ui_story then
				arg_518_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_1")
			end

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 then
				arg_518_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_521_2 = arg_518_1.actors_["1084ui_story"]

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= 0 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1084ui_story == nil then
				arg_518_1.var_.characterEffect1084ui_story = var_521_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_521_3 = 0.200000002980232

			if 0 <= arg_518_1.time_ and arg_518_1.time_ < 0 + var_521_3 and not isNil(var_521_2) then
				if arg_518_1.var_.characterEffect1084ui_story and not isNil(var_521_2) then
					arg_518_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_518_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_518_1.time_ - 0) / var_521_3)
				end
			end

			if arg_518_1.time_ >= 0 + var_521_3 and arg_518_1.time_ < 0 + var_521_3 + arg_521_0 and not isNil(var_521_2) and arg_518_1.var_.characterEffect1084ui_story then
				arg_518_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_518_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_521_4 = 0
			local var_521_5 = 0.225

			if 0 < arg_518_1.time_ and arg_518_1.time_ <= var_521_4 + arg_521_0 then
				arg_518_1.talkMaxDuration = 0
				arg_518_1.dialogCg_.alpha = 1

				arg_518_1.dialog_:SetActive(true)
				SetActive(arg_518_1.leftNameGo_, true)

				arg_518_1.leftNameTxt_.text = arg_518_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_518_1.leftNameTxt_.transform)

				arg_518_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_518_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_518_1:RecordName(arg_518_1.leftNameTxt_.text)
				SetActive(arg_518_1.iconTrs_.gameObject, false)
				arg_518_1.callingController_:SetSelectedState("normal")

				local var_521_6 = arg_518_1:GetWordFromCfg(319501126)
				local var_521_7 = arg_518_1:FormatText(var_521_6.content)

				arg_518_1.text_.text = var_521_7

				LuaForUtil.ClearLinePrefixSymbol(arg_518_1.text_)

				local var_521_9 = 9 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 9)

				if (9 <= 0 and var_521_5 or var_521_5 * (utf8.len(var_521_7) / 9)) > 0 and var_521_5 < var_521_9 then
					arg_518_1.talkMaxDuration = var_521_9

					if var_521_9 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_9 + var_521_4
					end
				end

				arg_518_1.text_.text = var_521_7
				arg_518_1.typewritter.percent = 0

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501126", "story_v_out_319501.awb") ~= 0 then
					local var_521_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501126", "story_v_out_319501.awb") / 1000

					if var_521_10 + var_521_4 > arg_518_1.duration_ then
						arg_518_1.duration_ = var_521_10 + var_521_4
					end

					if var_521_6.prefab_name ~= "" and arg_518_1.actors_[var_521_6.prefab_name] ~= nil then
						local var_521_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_518_1.actors_[var_521_6.prefab_name].transform, "story_v_out_319501", "319501126", "story_v_out_319501.awb")

						arg_518_1:RecordAudio("319501126", var_521_11)
						arg_518_1:RecordAudio("319501126", var_521_11)
					else
						arg_518_1:AudioAction("play", "voice", "story_v_out_319501", "319501126", "story_v_out_319501.awb")
					end

					arg_518_1:RecordHistoryTalkVoice("story_v_out_319501", "319501126", "story_v_out_319501.awb")
				end

				arg_518_1:RecordContent(arg_518_1.text_.text)
			end

			local var_521_12 = math.max(var_521_5, arg_518_1.talkMaxDuration)

			if var_521_4 <= arg_518_1.time_ and arg_518_1.time_ < var_521_4 + var_521_12 then
				arg_518_1.typewritter.percent = (arg_518_1.time_ - var_521_4) / var_521_12

				arg_518_1.typewritter:SetDirty()
			end

			if arg_518_1.time_ >= var_521_4 + var_521_12 and arg_518_1.time_ < var_521_4 + var_521_12 + arg_521_0 then
				arg_518_1.typewritter.percent = 1

				arg_518_1.typewritter:SetDirty()
				arg_518_1:ShowNextGo(true)
			end
		end

		arg_518_1.nodeConfigList_ = {}

		arg_518_1:InitPlayNodeList()
	end,
	Play319501127 = function(arg_522_0, arg_522_1)
		arg_522_1.time_ = 0
		arg_522_1.frameCnt_ = 0
		arg_522_1.state_ = "playing"
		arg_522_1.curTalkId_ = 319501127
		arg_522_1.duration_ = 13.2

		local var_522_0 = {
			zh = 5.1,
			ja = 13.2
		}
		local var_522_1 = manager.audio:GetLocalizationFlag()

		if var_522_0[var_522_1] ~= nil then
			arg_522_1.duration_ = var_522_0[var_522_1]
		end

		SetActive(arg_522_1.tipsGo_, false)

		function arg_522_1.onSingleLineFinish_()
			arg_522_1.onSingleLineUpdate_ = nil
			arg_522_1.onSingleLineFinish_ = nil
			arg_522_1.state_ = "waiting"
		end

		function arg_522_1.playNext_(arg_524_0)
			if arg_524_0 == 1 then
				arg_522_0:Play319501128(arg_522_1)
			end
		end

		function arg_522_1.onSingleLineUpdate_(arg_525_0)
			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(arg_522_1.actors_["1084ui_story"]) and arg_522_1.var_.characterEffect1084ui_story == nil then
				arg_522_1.var_.characterEffect1084ui_story = arg_522_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_0 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_0 and not isNil(arg_522_1.actors_["1084ui_story"]) then
				if arg_522_1.var_.characterEffect1084ui_story and not isNil(arg_522_1.actors_["1084ui_story"]) then
					arg_522_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_522_1.time_ >= 0 + var_525_0 and arg_522_1.time_ < 0 + var_525_0 + arg_525_0 and not isNil(arg_522_1.actors_["1084ui_story"]) and arg_522_1.var_.characterEffect1084ui_story then
				arg_522_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 then
				arg_522_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_525_2 = arg_522_1.actors_["10068ui_story"]

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= 0 + arg_525_0 and not isNil(var_525_2) and arg_522_1.var_.characterEffect10068ui_story == nil then
				arg_522_1.var_.characterEffect10068ui_story = var_525_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_525_3 = 0.200000002980232

			if 0 <= arg_522_1.time_ and arg_522_1.time_ < 0 + var_525_3 and not isNil(var_525_2) then
				if arg_522_1.var_.characterEffect10068ui_story and not isNil(var_525_2) then
					arg_522_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_522_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_522_1.time_ - 0) / var_525_3)
				end
			end

			if arg_522_1.time_ >= 0 + var_525_3 and arg_522_1.time_ < 0 + var_525_3 + arg_525_0 and not isNil(var_525_2) and arg_522_1.var_.characterEffect10068ui_story then
				arg_522_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_522_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_525_4 = 0
			local var_525_5 = 0.65

			if 0 < arg_522_1.time_ and arg_522_1.time_ <= var_525_4 + arg_525_0 then
				arg_522_1.talkMaxDuration = 0
				arg_522_1.dialogCg_.alpha = 1

				arg_522_1.dialog_:SetActive(true)
				SetActive(arg_522_1.leftNameGo_, true)

				arg_522_1.leftNameTxt_.text = arg_522_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_522_1.leftNameTxt_.transform)

				arg_522_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_522_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_522_1:RecordName(arg_522_1.leftNameTxt_.text)
				SetActive(arg_522_1.iconTrs_.gameObject, false)
				arg_522_1.callingController_:SetSelectedState("normal")

				local var_525_6 = arg_522_1:GetWordFromCfg(319501127)
				local var_525_7 = arg_522_1:FormatText(var_525_6.content)

				arg_522_1.text_.text = var_525_7

				LuaForUtil.ClearLinePrefixSymbol(arg_522_1.text_)

				local var_525_9 = 26 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 26)

				if (26 <= 0 and var_525_5 or var_525_5 * (utf8.len(var_525_7) / 26)) > 0 and var_525_5 < var_525_9 then
					arg_522_1.talkMaxDuration = var_525_9

					if var_525_9 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_9 + var_525_4
					end
				end

				arg_522_1.text_.text = var_525_7
				arg_522_1.typewritter.percent = 0

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501127", "story_v_out_319501.awb") ~= 0 then
					local var_525_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501127", "story_v_out_319501.awb") / 1000

					if var_525_10 + var_525_4 > arg_522_1.duration_ then
						arg_522_1.duration_ = var_525_10 + var_525_4
					end

					if var_525_6.prefab_name ~= "" and arg_522_1.actors_[var_525_6.prefab_name] ~= nil then
						local var_525_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_522_1.actors_[var_525_6.prefab_name].transform, "story_v_out_319501", "319501127", "story_v_out_319501.awb")

						arg_522_1:RecordAudio("319501127", var_525_11)
						arg_522_1:RecordAudio("319501127", var_525_11)
					else
						arg_522_1:AudioAction("play", "voice", "story_v_out_319501", "319501127", "story_v_out_319501.awb")
					end

					arg_522_1:RecordHistoryTalkVoice("story_v_out_319501", "319501127", "story_v_out_319501.awb")
				end

				arg_522_1:RecordContent(arg_522_1.text_.text)
			end

			local var_525_12 = math.max(var_525_5, arg_522_1.talkMaxDuration)

			if var_525_4 <= arg_522_1.time_ and arg_522_1.time_ < var_525_4 + var_525_12 then
				arg_522_1.typewritter.percent = (arg_522_1.time_ - var_525_4) / var_525_12

				arg_522_1.typewritter:SetDirty()
			end

			if arg_522_1.time_ >= var_525_4 + var_525_12 and arg_522_1.time_ < var_525_4 + var_525_12 + arg_525_0 then
				arg_522_1.typewritter.percent = 1

				arg_522_1.typewritter:SetDirty()
				arg_522_1:ShowNextGo(true)
			end
		end

		arg_522_1.nodeConfigList_ = {}

		arg_522_1:InitPlayNodeList()
	end,
	Play319501128 = function(arg_526_0, arg_526_1)
		arg_526_1.time_ = 0
		arg_526_1.frameCnt_ = 0
		arg_526_1.state_ = "playing"
		arg_526_1.curTalkId_ = 319501128
		arg_526_1.duration_ = 5.73

		local var_526_0 = {
			zh = 3,
			ja = 5.733
		}
		local var_526_1 = manager.audio:GetLocalizationFlag()

		if var_526_0[var_526_1] ~= nil then
			arg_526_1.duration_ = var_526_0[var_526_1]
		end

		SetActive(arg_526_1.tipsGo_, false)

		function arg_526_1.onSingleLineFinish_()
			arg_526_1.onSingleLineUpdate_ = nil
			arg_526_1.onSingleLineFinish_ = nil
			arg_526_1.state_ = "waiting"
		end

		function arg_526_1.playNext_(arg_528_0)
			if arg_528_0 == 1 then
				arg_526_0:Play319501129(arg_526_1)
			end
		end

		function arg_526_1.onSingleLineUpdate_(arg_529_0)
			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= 0 + arg_529_0 then
				arg_526_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_529_0 = 0
			local var_529_1 = 0.35

			if 0 < arg_526_1.time_ and arg_526_1.time_ <= var_529_0 + arg_529_0 then
				arg_526_1.talkMaxDuration = 0
				arg_526_1.dialogCg_.alpha = 1

				arg_526_1.dialog_:SetActive(true)
				SetActive(arg_526_1.leftNameGo_, true)

				arg_526_1.leftNameTxt_.text = arg_526_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_526_1.leftNameTxt_.transform)

				arg_526_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_526_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_526_1:RecordName(arg_526_1.leftNameTxt_.text)
				SetActive(arg_526_1.iconTrs_.gameObject, false)
				arg_526_1.callingController_:SetSelectedState("normal")

				local var_529_2 = arg_526_1:GetWordFromCfg(319501128)
				local var_529_3 = arg_526_1:FormatText(var_529_2.content)

				arg_526_1.text_.text = var_529_3

				LuaForUtil.ClearLinePrefixSymbol(arg_526_1.text_)

				local var_529_5 = 14 <= 0 and var_529_1 or var_529_1 * (utf8.len(var_529_3) / 14)

				if (14 <= 0 and var_529_1 or var_529_1 * (utf8.len(var_529_3) / 14)) > 0 and var_529_1 < var_529_5 then
					arg_526_1.talkMaxDuration = var_529_5

					if var_529_5 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_5 + var_529_0
					end
				end

				arg_526_1.text_.text = var_529_3
				arg_526_1.typewritter.percent = 0

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501128", "story_v_out_319501.awb") ~= 0 then
					local var_529_6 = manager.audio:GetVoiceLength("story_v_out_319501", "319501128", "story_v_out_319501.awb") / 1000

					if var_529_6 + var_529_0 > arg_526_1.duration_ then
						arg_526_1.duration_ = var_529_6 + var_529_0
					end

					if var_529_2.prefab_name ~= "" and arg_526_1.actors_[var_529_2.prefab_name] ~= nil then
						local var_529_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_526_1.actors_[var_529_2.prefab_name].transform, "story_v_out_319501", "319501128", "story_v_out_319501.awb")

						arg_526_1:RecordAudio("319501128", var_529_7)
						arg_526_1:RecordAudio("319501128", var_529_7)
					else
						arg_526_1:AudioAction("play", "voice", "story_v_out_319501", "319501128", "story_v_out_319501.awb")
					end

					arg_526_1:RecordHistoryTalkVoice("story_v_out_319501", "319501128", "story_v_out_319501.awb")
				end

				arg_526_1:RecordContent(arg_526_1.text_.text)
			end

			local var_529_8 = math.max(var_529_1, arg_526_1.talkMaxDuration)

			if var_529_0 <= arg_526_1.time_ and arg_526_1.time_ < var_529_0 + var_529_8 then
				arg_526_1.typewritter.percent = (arg_526_1.time_ - var_529_0) / var_529_8

				arg_526_1.typewritter:SetDirty()
			end

			if arg_526_1.time_ >= var_529_0 + var_529_8 and arg_526_1.time_ < var_529_0 + var_529_8 + arg_529_0 then
				arg_526_1.typewritter.percent = 1

				arg_526_1.typewritter:SetDirty()
				arg_526_1:ShowNextGo(true)
			end
		end

		arg_526_1.nodeConfigList_ = {}

		arg_526_1:InitPlayNodeList()
	end,
	Play319501129 = function(arg_530_0, arg_530_1)
		arg_530_1.time_ = 0
		arg_530_1.frameCnt_ = 0
		arg_530_1.state_ = "playing"
		arg_530_1.curTalkId_ = 319501129
		arg_530_1.duration_ = 5

		SetActive(arg_530_1.tipsGo_, false)

		function arg_530_1.onSingleLineFinish_()
			arg_530_1.onSingleLineUpdate_ = nil
			arg_530_1.onSingleLineFinish_ = nil
			arg_530_1.state_ = "waiting"
		end

		function arg_530_1.playNext_(arg_532_0)
			if arg_532_0 == 1 then
				arg_530_0:Play319501130(arg_530_1)
			end
		end

		function arg_530_1.onSingleLineUpdate_(arg_533_0)
			if 0 < arg_530_1.time_ and arg_530_1.time_ <= 0 + arg_533_0 and not isNil(arg_530_1.actors_["1084ui_story"]) and arg_530_1.var_.characterEffect1084ui_story == nil then
				arg_530_1.var_.characterEffect1084ui_story = arg_530_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_533_0 = 0.200000002980232

			if 0 <= arg_530_1.time_ and arg_530_1.time_ < 0 + var_533_0 and not isNil(arg_530_1.actors_["1084ui_story"]) then
				if arg_530_1.var_.characterEffect1084ui_story and not isNil(arg_530_1.actors_["1084ui_story"]) then
					arg_530_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_530_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_530_1.time_ - 0) / var_533_0)
				end
			end

			if arg_530_1.time_ >= 0 + var_533_0 and arg_530_1.time_ < 0 + var_533_0 + arg_533_0 and not isNil(arg_530_1.actors_["1084ui_story"]) and arg_530_1.var_.characterEffect1084ui_story then
				arg_530_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_530_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_533_1 = 0
			local var_533_2 = 0.8

			if 0 < arg_530_1.time_ and arg_530_1.time_ <= var_533_1 + arg_533_0 then
				arg_530_1.talkMaxDuration = 0
				arg_530_1.dialogCg_.alpha = 1

				arg_530_1.dialog_:SetActive(true)
				SetActive(arg_530_1.leftNameGo_, false)

				arg_530_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_530_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_530_1:RecordName(arg_530_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_530_1.iconTrs_.gameObject, false)
				arg_530_1.callingController_:SetSelectedState("normal")

				local var_533_3 = arg_530_1:FormatText(arg_530_1:GetWordFromCfg(319501129).content)

				arg_530_1.text_.text = var_533_3

				LuaForUtil.ClearLinePrefixSymbol(arg_530_1.text_)

				local var_533_5 = 32 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_3) / 32)

				if (32 <= 0 and var_533_2 or var_533_2 * (utf8.len(var_533_3) / 32)) > 0 and var_533_2 < var_533_5 then
					arg_530_1.talkMaxDuration = var_533_5

					if var_533_5 + var_533_1 > arg_530_1.duration_ then
						arg_530_1.duration_ = var_533_5 + var_533_1
					end
				end

				arg_530_1.text_.text = var_533_3
				arg_530_1.typewritter.percent = 0

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(false)
				arg_530_1:RecordContent(arg_530_1.text_.text)
			end

			local var_533_6 = math.max(var_533_2, arg_530_1.talkMaxDuration)

			if var_533_1 <= arg_530_1.time_ and arg_530_1.time_ < var_533_1 + var_533_6 then
				arg_530_1.typewritter.percent = (arg_530_1.time_ - var_533_1) / var_533_6

				arg_530_1.typewritter:SetDirty()
			end

			if arg_530_1.time_ >= var_533_1 + var_533_6 and arg_530_1.time_ < var_533_1 + var_533_6 + arg_533_0 then
				arg_530_1.typewritter.percent = 1

				arg_530_1.typewritter:SetDirty()
				arg_530_1:ShowNextGo(true)
			end
		end

		arg_530_1.nodeConfigList_ = {}

		arg_530_1:InitPlayNodeList()
	end,
	Play319501130 = function(arg_534_0, arg_534_1)
		arg_534_1.time_ = 0
		arg_534_1.frameCnt_ = 0
		arg_534_1.state_ = "playing"
		arg_534_1.curTalkId_ = 319501130
		arg_534_1.duration_ = 5

		SetActive(arg_534_1.tipsGo_, false)

		function arg_534_1.onSingleLineFinish_()
			arg_534_1.onSingleLineUpdate_ = nil
			arg_534_1.onSingleLineFinish_ = nil
			arg_534_1.state_ = "waiting"
		end

		function arg_534_1.playNext_(arg_536_0)
			if arg_536_0 == 1 then
				arg_534_0:Play319501131(arg_534_1)
			end
		end

		function arg_534_1.onSingleLineUpdate_(arg_537_0)
			local var_537_0 = 0.75

			if 0 < arg_534_1.time_ and arg_534_1.time_ <= 0 + arg_537_0 then
				arg_534_1.talkMaxDuration = 0
				arg_534_1.dialogCg_.alpha = 1

				arg_534_1.dialog_:SetActive(true)
				SetActive(arg_534_1.leftNameGo_, false)

				arg_534_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_534_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_534_1:RecordName(arg_534_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_534_1.iconTrs_.gameObject, false)
				arg_534_1.callingController_:SetSelectedState("normal")

				local var_537_1 = arg_534_1:FormatText(arg_534_1:GetWordFromCfg(319501130).content)

				arg_534_1.text_.text = var_537_1

				LuaForUtil.ClearLinePrefixSymbol(arg_534_1.text_)

				local var_537_3 = 30 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_1) / 30)

				if (30 <= 0 and var_537_0 or var_537_0 * (utf8.len(var_537_1) / 30)) > 0 and var_537_0 < var_537_3 then
					arg_534_1.talkMaxDuration = var_537_3

					if var_537_3 + 0 > arg_534_1.duration_ then
						arg_534_1.duration_ = var_537_3 + 0
					end
				end

				arg_534_1.text_.text = var_537_1
				arg_534_1.typewritter.percent = 0

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(false)
				arg_534_1:RecordContent(arg_534_1.text_.text)
			end

			local var_537_4 = math.max(var_537_0, arg_534_1.talkMaxDuration)

			if 0 <= arg_534_1.time_ and arg_534_1.time_ < 0 + var_537_4 then
				arg_534_1.typewritter.percent = (arg_534_1.time_ - 0) / var_537_4

				arg_534_1.typewritter:SetDirty()
			end

			if arg_534_1.time_ >= 0 + var_537_4 and arg_534_1.time_ < 0 + var_537_4 + arg_537_0 then
				arg_534_1.typewritter.percent = 1

				arg_534_1.typewritter:SetDirty()
				arg_534_1:ShowNextGo(true)
			end
		end

		arg_534_1.nodeConfigList_ = {}

		arg_534_1:InitPlayNodeList()
	end,
	Play319501131 = function(arg_538_0, arg_538_1)
		arg_538_1.time_ = 0
		arg_538_1.frameCnt_ = 0
		arg_538_1.state_ = "playing"
		arg_538_1.curTalkId_ = 319501131
		arg_538_1.duration_ = 2.1

		local var_538_0 = {
			zh = 2.1,
			ja = 1.999999999999
		}
		local var_538_1 = manager.audio:GetLocalizationFlag()

		if var_538_0[var_538_1] ~= nil then
			arg_538_1.duration_ = var_538_0[var_538_1]
		end

		SetActive(arg_538_1.tipsGo_, false)

		function arg_538_1.onSingleLineFinish_()
			arg_538_1.onSingleLineUpdate_ = nil
			arg_538_1.onSingleLineFinish_ = nil
			arg_538_1.state_ = "waiting"
		end

		function arg_538_1.playNext_(arg_540_0)
			if arg_540_0 == 1 then
				arg_538_0:Play319501132(arg_538_1)
			end
		end

		function arg_538_1.onSingleLineUpdate_(arg_541_0)
			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 and not isNil(arg_538_1.actors_["10068ui_story"]) and arg_538_1.var_.characterEffect10068ui_story == nil then
				arg_538_1.var_.characterEffect10068ui_story = arg_538_1.actors_["10068ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_541_0 = 0.200000002980232

			if 0 <= arg_538_1.time_ and arg_538_1.time_ < 0 + var_541_0 and not isNil(arg_538_1.actors_["10068ui_story"]) then
				if arg_538_1.var_.characterEffect10068ui_story and not isNil(arg_538_1.actors_["10068ui_story"]) then
					arg_538_1.var_.characterEffect10068ui_story.fillFlat = false
				end
			end

			if arg_538_1.time_ >= 0 + var_541_0 and arg_538_1.time_ < 0 + var_541_0 + arg_541_0 and not isNil(arg_538_1.actors_["10068ui_story"]) and arg_538_1.var_.characterEffect10068ui_story then
				arg_538_1.var_.characterEffect10068ui_story.fillFlat = false
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/story10068/story10068action/10068action2_2")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("10068ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= 0 + arg_541_0 then
				arg_538_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_541_2 = 0
			local var_541_3 = 0.15

			if 0 < arg_538_1.time_ and arg_538_1.time_ <= var_541_2 + arg_541_0 then
				arg_538_1.talkMaxDuration = 0
				arg_538_1.dialogCg_.alpha = 1

				arg_538_1.dialog_:SetActive(true)
				SetActive(arg_538_1.leftNameGo_, true)

				arg_538_1.leftNameTxt_.text = arg_538_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_538_1.leftNameTxt_.transform)

				arg_538_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_538_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_538_1:RecordName(arg_538_1.leftNameTxt_.text)
				SetActive(arg_538_1.iconTrs_.gameObject, false)
				arg_538_1.callingController_:SetSelectedState("normal")

				local var_541_4 = arg_538_1:GetWordFromCfg(319501131)
				local var_541_5 = arg_538_1:FormatText(var_541_4.content)

				arg_538_1.text_.text = var_541_5

				LuaForUtil.ClearLinePrefixSymbol(arg_538_1.text_)

				local var_541_7 = 6 <= 0 and var_541_3 or var_541_3 * (utf8.len(var_541_5) / 6)

				if (6 <= 0 and var_541_3 or var_541_3 * (utf8.len(var_541_5) / 6)) > 0 and var_541_3 < var_541_7 then
					arg_538_1.talkMaxDuration = var_541_7

					if var_541_7 + var_541_2 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_7 + var_541_2
					end
				end

				arg_538_1.text_.text = var_541_5
				arg_538_1.typewritter.percent = 0

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501131", "story_v_out_319501.awb") ~= 0 then
					local var_541_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501131", "story_v_out_319501.awb") / 1000

					if var_541_8 + var_541_2 > arg_538_1.duration_ then
						arg_538_1.duration_ = var_541_8 + var_541_2
					end

					if var_541_4.prefab_name ~= "" and arg_538_1.actors_[var_541_4.prefab_name] ~= nil then
						local var_541_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_538_1.actors_[var_541_4.prefab_name].transform, "story_v_out_319501", "319501131", "story_v_out_319501.awb")

						arg_538_1:RecordAudio("319501131", var_541_9)
						arg_538_1:RecordAudio("319501131", var_541_9)
					else
						arg_538_1:AudioAction("play", "voice", "story_v_out_319501", "319501131", "story_v_out_319501.awb")
					end

					arg_538_1:RecordHistoryTalkVoice("story_v_out_319501", "319501131", "story_v_out_319501.awb")
				end

				arg_538_1:RecordContent(arg_538_1.text_.text)
			end

			local var_541_10 = math.max(var_541_3, arg_538_1.talkMaxDuration)

			if var_541_2 <= arg_538_1.time_ and arg_538_1.time_ < var_541_2 + var_541_10 then
				arg_538_1.typewritter.percent = (arg_538_1.time_ - var_541_2) / var_541_10

				arg_538_1.typewritter:SetDirty()
			end

			if arg_538_1.time_ >= var_541_2 + var_541_10 and arg_538_1.time_ < var_541_2 + var_541_10 + arg_541_0 then
				arg_538_1.typewritter.percent = 1

				arg_538_1.typewritter:SetDirty()
				arg_538_1:ShowNextGo(true)
			end
		end

		arg_538_1.nodeConfigList_ = {}

		arg_538_1:InitPlayNodeList()
	end,
	Play319501132 = function(arg_542_0, arg_542_1)
		arg_542_1.time_ = 0
		arg_542_1.frameCnt_ = 0
		arg_542_1.state_ = "playing"
		arg_542_1.curTalkId_ = 319501132
		arg_542_1.duration_ = 16.47

		local var_542_0 = {
			zh = 9.766,
			ja = 16.466
		}
		local var_542_1 = manager.audio:GetLocalizationFlag()

		if var_542_0[var_542_1] ~= nil then
			arg_542_1.duration_ = var_542_0[var_542_1]
		end

		SetActive(arg_542_1.tipsGo_, false)

		function arg_542_1.onSingleLineFinish_()
			arg_542_1.onSingleLineUpdate_ = nil
			arg_542_1.onSingleLineFinish_ = nil
			arg_542_1.state_ = "waiting"
		end

		function arg_542_1.playNext_(arg_544_0)
			if arg_544_0 == 1 then
				arg_542_0:Play319501133(arg_542_1)
			end
		end

		function arg_542_1.onSingleLineUpdate_(arg_545_0)
			local var_545_0 = 0.925

			if 0 < arg_542_1.time_ and arg_542_1.time_ <= 0 + arg_545_0 then
				arg_542_1.talkMaxDuration = 0
				arg_542_1.dialogCg_.alpha = 1

				arg_542_1.dialog_:SetActive(true)
				SetActive(arg_542_1.leftNameGo_, true)

				arg_542_1.leftNameTxt_.text = arg_542_1:FormatText(StoryNameCfg[697].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_542_1.leftNameTxt_.transform)

				arg_542_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_542_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_542_1:RecordName(arg_542_1.leftNameTxt_.text)
				SetActive(arg_542_1.iconTrs_.gameObject, false)
				arg_542_1.callingController_:SetSelectedState("normal")

				local var_545_1 = arg_542_1:GetWordFromCfg(319501132)
				local var_545_2 = arg_542_1:FormatText(var_545_1.content)

				arg_542_1.text_.text = var_545_2

				LuaForUtil.ClearLinePrefixSymbol(arg_542_1.text_)

				local var_545_4 = 37 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_2) / 37)

				if (37 <= 0 and var_545_0 or var_545_0 * (utf8.len(var_545_2) / 37)) > 0 and var_545_0 < var_545_4 then
					arg_542_1.talkMaxDuration = var_545_4

					if var_545_4 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_4 + 0
					end
				end

				arg_542_1.text_.text = var_545_2
				arg_542_1.typewritter.percent = 0

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501132", "story_v_out_319501.awb") ~= 0 then
					local var_545_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501132", "story_v_out_319501.awb") / 1000

					if var_545_5 + 0 > arg_542_1.duration_ then
						arg_542_1.duration_ = var_545_5 + 0
					end

					if var_545_1.prefab_name ~= "" and arg_542_1.actors_[var_545_1.prefab_name] ~= nil then
						local var_545_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_542_1.actors_[var_545_1.prefab_name].transform, "story_v_out_319501", "319501132", "story_v_out_319501.awb")

						arg_542_1:RecordAudio("319501132", var_545_6)
						arg_542_1:RecordAudio("319501132", var_545_6)
					else
						arg_542_1:AudioAction("play", "voice", "story_v_out_319501", "319501132", "story_v_out_319501.awb")
					end

					arg_542_1:RecordHistoryTalkVoice("story_v_out_319501", "319501132", "story_v_out_319501.awb")
				end

				arg_542_1:RecordContent(arg_542_1.text_.text)
			end

			local var_545_7 = math.max(var_545_0, arg_542_1.talkMaxDuration)

			if 0 <= arg_542_1.time_ and arg_542_1.time_ < 0 + var_545_7 then
				arg_542_1.typewritter.percent = (arg_542_1.time_ - 0) / var_545_7

				arg_542_1.typewritter:SetDirty()
			end

			if arg_542_1.time_ >= 0 + var_545_7 and arg_542_1.time_ < 0 + var_545_7 + arg_545_0 then
				arg_542_1.typewritter.percent = 1

				arg_542_1.typewritter:SetDirty()
				arg_542_1:ShowNextGo(true)
			end
		end

		arg_542_1.nodeConfigList_ = {}

		arg_542_1:InitPlayNodeList()
	end,
	Play319501133 = function(arg_546_0, arg_546_1)
		arg_546_1.time_ = 0
		arg_546_1.frameCnt_ = 0
		arg_546_1.state_ = "playing"
		arg_546_1.curTalkId_ = 319501133
		arg_546_1.duration_ = 4.47

		local var_546_0 = {
			zh = 1.999999999999,
			ja = 4.466
		}
		local var_546_1 = manager.audio:GetLocalizationFlag()

		if var_546_0[var_546_1] ~= nil then
			arg_546_1.duration_ = var_546_0[var_546_1]
		end

		SetActive(arg_546_1.tipsGo_, false)

		function arg_546_1.onSingleLineFinish_()
			arg_546_1.onSingleLineUpdate_ = nil
			arg_546_1.onSingleLineFinish_ = nil
			arg_546_1.state_ = "waiting"
		end

		function arg_546_1.playNext_(arg_548_0)
			if arg_548_0 == 1 then
				arg_546_0:Play319501134(arg_546_1)
			end
		end

		function arg_546_1.onSingleLineUpdate_(arg_549_0)
			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 and not isNil(arg_546_1.actors_["1084ui_story"]) and arg_546_1.var_.characterEffect1084ui_story == nil then
				arg_546_1.var_.characterEffect1084ui_story = arg_546_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_0 = 0.200000002980232

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_0 and not isNil(arg_546_1.actors_["1084ui_story"]) then
				if arg_546_1.var_.characterEffect1084ui_story and not isNil(arg_546_1.actors_["1084ui_story"]) then
					arg_546_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_546_1.time_ >= 0 + var_549_0 and arg_546_1.time_ < 0 + var_549_0 + arg_549_0 and not isNil(arg_546_1.actors_["1084ui_story"]) and arg_546_1.var_.characterEffect1084ui_story then
				arg_546_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 then
				arg_546_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_549_2 = arg_546_1.actors_["10068ui_story"]

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= 0 + arg_549_0 and not isNil(var_549_2) and arg_546_1.var_.characterEffect10068ui_story == nil then
				arg_546_1.var_.characterEffect10068ui_story = var_549_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_549_3 = 0.200000002980232

			if 0 <= arg_546_1.time_ and arg_546_1.time_ < 0 + var_549_3 and not isNil(var_549_2) then
				if arg_546_1.var_.characterEffect10068ui_story and not isNil(var_549_2) then
					arg_546_1.var_.characterEffect10068ui_story.fillFlat = true
					arg_546_1.var_.characterEffect10068ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_546_1.time_ - 0) / var_549_3)
				end
			end

			if arg_546_1.time_ >= 0 + var_549_3 and arg_546_1.time_ < 0 + var_549_3 + arg_549_0 and not isNil(var_549_2) and arg_546_1.var_.characterEffect10068ui_story then
				arg_546_1.var_.characterEffect10068ui_story.fillFlat = true
				arg_546_1.var_.characterEffect10068ui_story.fillRatio = 0.5
			end

			local var_549_4 = 0
			local var_549_5 = 0.15

			if 0 < arg_546_1.time_ and arg_546_1.time_ <= var_549_4 + arg_549_0 then
				arg_546_1.talkMaxDuration = 0
				arg_546_1.dialogCg_.alpha = 1

				arg_546_1.dialog_:SetActive(true)
				SetActive(arg_546_1.leftNameGo_, true)

				arg_546_1.leftNameTxt_.text = arg_546_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_546_1.leftNameTxt_.transform)

				arg_546_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_546_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_546_1:RecordName(arg_546_1.leftNameTxt_.text)
				SetActive(arg_546_1.iconTrs_.gameObject, false)
				arg_546_1.callingController_:SetSelectedState("normal")

				local var_549_6 = arg_546_1:GetWordFromCfg(319501133)
				local var_549_7 = arg_546_1:FormatText(var_549_6.content)

				arg_546_1.text_.text = var_549_7

				LuaForUtil.ClearLinePrefixSymbol(arg_546_1.text_)

				local var_549_9 = 6 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_7) / 6)

				if (6 <= 0 and var_549_5 or var_549_5 * (utf8.len(var_549_7) / 6)) > 0 and var_549_5 < var_549_9 then
					arg_546_1.talkMaxDuration = var_549_9

					if var_549_9 + var_549_4 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_9 + var_549_4
					end
				end

				arg_546_1.text_.text = var_549_7
				arg_546_1.typewritter.percent = 0

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501133", "story_v_out_319501.awb") ~= 0 then
					local var_549_10 = manager.audio:GetVoiceLength("story_v_out_319501", "319501133", "story_v_out_319501.awb") / 1000

					if var_549_10 + var_549_4 > arg_546_1.duration_ then
						arg_546_1.duration_ = var_549_10 + var_549_4
					end

					if var_549_6.prefab_name ~= "" and arg_546_1.actors_[var_549_6.prefab_name] ~= nil then
						local var_549_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_546_1.actors_[var_549_6.prefab_name].transform, "story_v_out_319501", "319501133", "story_v_out_319501.awb")

						arg_546_1:RecordAudio("319501133", var_549_11)
						arg_546_1:RecordAudio("319501133", var_549_11)
					else
						arg_546_1:AudioAction("play", "voice", "story_v_out_319501", "319501133", "story_v_out_319501.awb")
					end

					arg_546_1:RecordHistoryTalkVoice("story_v_out_319501", "319501133", "story_v_out_319501.awb")
				end

				arg_546_1:RecordContent(arg_546_1.text_.text)
			end

			local var_549_12 = math.max(var_549_5, arg_546_1.talkMaxDuration)

			if var_549_4 <= arg_546_1.time_ and arg_546_1.time_ < var_549_4 + var_549_12 then
				arg_546_1.typewritter.percent = (arg_546_1.time_ - var_549_4) / var_549_12

				arg_546_1.typewritter:SetDirty()
			end

			if arg_546_1.time_ >= var_549_4 + var_549_12 and arg_546_1.time_ < var_549_4 + var_549_12 + arg_549_0 then
				arg_546_1.typewritter.percent = 1

				arg_546_1.typewritter:SetDirty()
				arg_546_1:ShowNextGo(true)
			end
		end

		arg_546_1.nodeConfigList_ = {}

		arg_546_1:InitPlayNodeList()
	end,
	Play319501134 = function(arg_550_0, arg_550_1)
		arg_550_1.time_ = 0
		arg_550_1.frameCnt_ = 0
		arg_550_1.state_ = "playing"
		arg_550_1.curTalkId_ = 319501134
		arg_550_1.duration_ = 5

		SetActive(arg_550_1.tipsGo_, false)

		function arg_550_1.onSingleLineFinish_()
			arg_550_1.onSingleLineUpdate_ = nil
			arg_550_1.onSingleLineFinish_ = nil
			arg_550_1.state_ = "waiting"
		end

		function arg_550_1.playNext_(arg_552_0)
			if arg_552_0 == 1 then
				arg_550_0:Play319501135(arg_550_1)
			end
		end

		function arg_550_1.onSingleLineUpdate_(arg_553_0)
			if 0 < arg_550_1.time_ and arg_550_1.time_ <= 0 + arg_553_0 and not isNil(arg_550_1.actors_["1084ui_story"]) and arg_550_1.var_.characterEffect1084ui_story == nil then
				arg_550_1.var_.characterEffect1084ui_story = arg_550_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_553_0 = 0.200000002980232

			if 0 <= arg_550_1.time_ and arg_550_1.time_ < 0 + var_553_0 and not isNil(arg_550_1.actors_["1084ui_story"]) then
				if arg_550_1.var_.characterEffect1084ui_story and not isNil(arg_550_1.actors_["1084ui_story"]) then
					arg_550_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_550_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_550_1.time_ - 0) / var_553_0)
				end
			end

			if arg_550_1.time_ >= 0 + var_553_0 and arg_550_1.time_ < 0 + var_553_0 + arg_553_0 and not isNil(arg_550_1.actors_["1084ui_story"]) and arg_550_1.var_.characterEffect1084ui_story then
				arg_550_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_550_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_553_1 = 0
			local var_553_2 = 0.825

			if 0 < arg_550_1.time_ and arg_550_1.time_ <= var_553_1 + arg_553_0 then
				arg_550_1.talkMaxDuration = 0
				arg_550_1.dialogCg_.alpha = 1

				arg_550_1.dialog_:SetActive(true)
				SetActive(arg_550_1.leftNameGo_, false)

				arg_550_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_550_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_550_1:RecordName(arg_550_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_550_1.iconTrs_.gameObject, false)
				arg_550_1.callingController_:SetSelectedState("normal")

				local var_553_3 = arg_550_1:FormatText(arg_550_1:GetWordFromCfg(319501134).content)

				arg_550_1.text_.text = var_553_3

				LuaForUtil.ClearLinePrefixSymbol(arg_550_1.text_)

				local var_553_5 = 33 <= 0 and var_553_2 or var_553_2 * (utf8.len(var_553_3) / 33)

				if (33 <= 0 and var_553_2 or var_553_2 * (utf8.len(var_553_3) / 33)) > 0 and var_553_2 < var_553_5 then
					arg_550_1.talkMaxDuration = var_553_5

					if var_553_5 + var_553_1 > arg_550_1.duration_ then
						arg_550_1.duration_ = var_553_5 + var_553_1
					end
				end

				arg_550_1.text_.text = var_553_3
				arg_550_1.typewritter.percent = 0

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(false)
				arg_550_1:RecordContent(arg_550_1.text_.text)
			end

			local var_553_6 = math.max(var_553_2, arg_550_1.talkMaxDuration)

			if var_553_1 <= arg_550_1.time_ and arg_550_1.time_ < var_553_1 + var_553_6 then
				arg_550_1.typewritter.percent = (arg_550_1.time_ - var_553_1) / var_553_6

				arg_550_1.typewritter:SetDirty()
			end

			if arg_550_1.time_ >= var_553_1 + var_553_6 and arg_550_1.time_ < var_553_1 + var_553_6 + arg_553_0 then
				arg_550_1.typewritter.percent = 1

				arg_550_1.typewritter:SetDirty()
				arg_550_1:ShowNextGo(true)
			end
		end

		arg_550_1.nodeConfigList_ = {}

		arg_550_1:InitPlayNodeList()
	end,
	Play319501135 = function(arg_554_0, arg_554_1)
		arg_554_1.time_ = 0
		arg_554_1.frameCnt_ = 0
		arg_554_1.state_ = "playing"
		arg_554_1.curTalkId_ = 319501135
		arg_554_1.duration_ = 9.1

		local var_554_0 = {
			zh = 4.733,
			ja = 9.1
		}
		local var_554_1 = manager.audio:GetLocalizationFlag()

		if var_554_0[var_554_1] ~= nil then
			arg_554_1.duration_ = var_554_0[var_554_1]
		end

		SetActive(arg_554_1.tipsGo_, false)

		function arg_554_1.onSingleLineFinish_()
			arg_554_1.onSingleLineUpdate_ = nil
			arg_554_1.onSingleLineFinish_ = nil
			arg_554_1.state_ = "waiting"
		end

		function arg_554_1.playNext_(arg_556_0)
			if arg_556_0 == 1 then
				arg_554_0:Play319501136(arg_554_1)
			end
		end

		function arg_554_1.onSingleLineUpdate_(arg_557_0)
			if 0 < arg_554_1.time_ and arg_554_1.time_ <= 0 + arg_557_0 and not isNil(arg_554_1.actors_["1084ui_story"]) and arg_554_1.var_.characterEffect1084ui_story == nil then
				arg_554_1.var_.characterEffect1084ui_story = arg_554_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_557_0 = 0.200000002980232

			if 0 <= arg_554_1.time_ and arg_554_1.time_ < 0 + var_557_0 and not isNil(arg_554_1.actors_["1084ui_story"]) then
				if arg_554_1.var_.characterEffect1084ui_story and not isNil(arg_554_1.actors_["1084ui_story"]) then
					arg_554_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_554_1.time_ >= 0 + var_557_0 and arg_554_1.time_ < 0 + var_557_0 + arg_557_0 and not isNil(arg_554_1.actors_["1084ui_story"]) and arg_554_1.var_.characterEffect1084ui_story then
				arg_554_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_557_2 = 0
			local var_557_3 = 0.6

			if 0 < arg_554_1.time_ and arg_554_1.time_ <= var_557_2 + arg_557_0 then
				arg_554_1.talkMaxDuration = 0
				arg_554_1.dialogCg_.alpha = 1

				arg_554_1.dialog_:SetActive(true)
				SetActive(arg_554_1.leftNameGo_, true)

				arg_554_1.leftNameTxt_.text = arg_554_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_554_1.leftNameTxt_.transform)

				arg_554_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_554_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_554_1:RecordName(arg_554_1.leftNameTxt_.text)
				SetActive(arg_554_1.iconTrs_.gameObject, false)
				arg_554_1.callingController_:SetSelectedState("normal")

				local var_557_4 = arg_554_1:GetWordFromCfg(319501135)
				local var_557_5 = arg_554_1:FormatText(var_557_4.content)

				arg_554_1.text_.text = var_557_5

				LuaForUtil.ClearLinePrefixSymbol(arg_554_1.text_)

				local var_557_7 = 24 <= 0 and var_557_3 or var_557_3 * (utf8.len(var_557_5) / 24)

				if (24 <= 0 and var_557_3 or var_557_3 * (utf8.len(var_557_5) / 24)) > 0 and var_557_3 < var_557_7 then
					arg_554_1.talkMaxDuration = var_557_7

					if var_557_7 + var_557_2 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_7 + var_557_2
					end
				end

				arg_554_1.text_.text = var_557_5
				arg_554_1.typewritter.percent = 0

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501135", "story_v_out_319501.awb") ~= 0 then
					local var_557_8 = manager.audio:GetVoiceLength("story_v_out_319501", "319501135", "story_v_out_319501.awb") / 1000

					if var_557_8 + var_557_2 > arg_554_1.duration_ then
						arg_554_1.duration_ = var_557_8 + var_557_2
					end

					if var_557_4.prefab_name ~= "" and arg_554_1.actors_[var_557_4.prefab_name] ~= nil then
						local var_557_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_554_1.actors_[var_557_4.prefab_name].transform, "story_v_out_319501", "319501135", "story_v_out_319501.awb")

						arg_554_1:RecordAudio("319501135", var_557_9)
						arg_554_1:RecordAudio("319501135", var_557_9)
					else
						arg_554_1:AudioAction("play", "voice", "story_v_out_319501", "319501135", "story_v_out_319501.awb")
					end

					arg_554_1:RecordHistoryTalkVoice("story_v_out_319501", "319501135", "story_v_out_319501.awb")
				end

				arg_554_1:RecordContent(arg_554_1.text_.text)
			end

			local var_557_10 = math.max(var_557_3, arg_554_1.talkMaxDuration)

			if var_557_2 <= arg_554_1.time_ and arg_554_1.time_ < var_557_2 + var_557_10 then
				arg_554_1.typewritter.percent = (arg_554_1.time_ - var_557_2) / var_557_10

				arg_554_1.typewritter:SetDirty()
			end

			if arg_554_1.time_ >= var_557_2 + var_557_10 and arg_554_1.time_ < var_557_2 + var_557_10 + arg_557_0 then
				arg_554_1.typewritter.percent = 1

				arg_554_1.typewritter:SetDirty()
				arg_554_1:ShowNextGo(true)
			end
		end

		arg_554_1.nodeConfigList_ = {}

		arg_554_1:InitPlayNodeList()
	end,
	Play319501136 = function(arg_558_0, arg_558_1)
		arg_558_1.time_ = 0
		arg_558_1.frameCnt_ = 0
		arg_558_1.state_ = "playing"
		arg_558_1.curTalkId_ = 319501136
		arg_558_1.duration_ = 9.97

		local var_558_0 = {
			zh = 5.9,
			ja = 9.966
		}
		local var_558_1 = manager.audio:GetLocalizationFlag()

		if var_558_0[var_558_1] ~= nil then
			arg_558_1.duration_ = var_558_0[var_558_1]
		end

		SetActive(arg_558_1.tipsGo_, false)

		function arg_558_1.onSingleLineFinish_()
			arg_558_1.onSingleLineUpdate_ = nil
			arg_558_1.onSingleLineFinish_ = nil
			arg_558_1.state_ = "waiting"
			arg_558_1.auto_ = false
		end

		function arg_558_1.playNext_(arg_560_0)
			arg_558_1.onStoryFinished_()
		end

		function arg_558_1.onSingleLineUpdate_(arg_561_0)
			local var_561_0 = 0.725

			if 0 < arg_558_1.time_ and arg_558_1.time_ <= 0 + arg_561_0 then
				arg_558_1.talkMaxDuration = 0
				arg_558_1.dialogCg_.alpha = 1

				arg_558_1.dialog_:SetActive(true)
				SetActive(arg_558_1.leftNameGo_, true)

				arg_558_1.leftNameTxt_.text = arg_558_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_558_1.leftNameTxt_.transform)

				arg_558_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_558_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_558_1:RecordName(arg_558_1.leftNameTxt_.text)
				SetActive(arg_558_1.iconTrs_.gameObject, false)
				arg_558_1.callingController_:SetSelectedState("normal")

				local var_561_1 = arg_558_1:GetWordFromCfg(319501136)
				local var_561_2 = arg_558_1:FormatText(var_561_1.content)

				arg_558_1.text_.text = var_561_2

				LuaForUtil.ClearLinePrefixSymbol(arg_558_1.text_)

				local var_561_4 = 29 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 29)

				if (29 <= 0 and var_561_0 or var_561_0 * (utf8.len(var_561_2) / 29)) > 0 and var_561_0 < var_561_4 then
					arg_558_1.talkMaxDuration = var_561_4

					if var_561_4 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_4 + 0
					end
				end

				arg_558_1.text_.text = var_561_2
				arg_558_1.typewritter.percent = 0

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319501", "319501136", "story_v_out_319501.awb") ~= 0 then
					local var_561_5 = manager.audio:GetVoiceLength("story_v_out_319501", "319501136", "story_v_out_319501.awb") / 1000

					if var_561_5 + 0 > arg_558_1.duration_ then
						arg_558_1.duration_ = var_561_5 + 0
					end

					if var_561_1.prefab_name ~= "" and arg_558_1.actors_[var_561_1.prefab_name] ~= nil then
						local var_561_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_558_1.actors_[var_561_1.prefab_name].transform, "story_v_out_319501", "319501136", "story_v_out_319501.awb")

						arg_558_1:RecordAudio("319501136", var_561_6)
						arg_558_1:RecordAudio("319501136", var_561_6)
					else
						arg_558_1:AudioAction("play", "voice", "story_v_out_319501", "319501136", "story_v_out_319501.awb")
					end

					arg_558_1:RecordHistoryTalkVoice("story_v_out_319501", "319501136", "story_v_out_319501.awb")
				end

				arg_558_1:RecordContent(arg_558_1.text_.text)
			end

			local var_561_7 = math.max(var_561_0, arg_558_1.talkMaxDuration)

			if 0 <= arg_558_1.time_ and arg_558_1.time_ < 0 + var_561_7 then
				arg_558_1.typewritter.percent = (arg_558_1.time_ - 0) / var_561_7

				arg_558_1.typewritter:SetDirty()
			end

			if arg_558_1.time_ >= 0 + var_561_7 and arg_558_1.time_ < 0 + var_561_7 + arg_561_0 then
				arg_558_1.typewritter.percent = 1

				arg_558_1.typewritter:SetDirty()
				arg_558_1:ShowNextGo(true)
			end
		end

		arg_558_1.nodeConfigList_ = {}

		arg_558_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST72",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST71",
		"TextureConfig/Background/ML0105"
	},
	voices = {
		"story_v_out_319501.awb"
	}
}
