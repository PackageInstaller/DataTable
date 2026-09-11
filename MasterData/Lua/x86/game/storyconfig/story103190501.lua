return {
	Play319051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319051001
		arg_1_1.duration_ = 7.83

		local var_1_0 = {
			zh = 5.5,
			ja = 7.833
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
				arg_1_0:Play319051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I11n == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I11n")
				var_4_0.name = "I11n"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I11n = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I11n

				arg_1_1.bgs_.I11n.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I11n" then
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

			local var_4_8 = "10079ui_story"

			if arg_1_1.actors_["10079ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10079ui_story"))) then
				local var_4_9 = Object.Instantiate(Asset.Load("Char/" .. "10079ui_story"), arg_1_1.stage_.transform)

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

			local var_4_12 = arg_1_1.actors_["10079ui_story"].transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos10079ui_story = var_4_12.localPosition

				arg_1_1:ShowWeapon(arg_1_1.var_["10079ui_story" .. "Animator"].transform, false)
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.95, -6.05)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["10079ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10079ui_story == nil then
				arg_1_1.var_.characterEffect10079ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10079ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10079ui_story then
				arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
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

			if 0.133333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.133333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_piano", "bgm_activity_3_0_story_intense_piano")

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

			local var_4_23 = 2
			local var_4_24 = 0.325

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_26 = arg_1_1:GetWordFromCfg(319051001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 13 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 13)

				if (13 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 13)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051001", "story_v_out_319051.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_319051", "319051001", "story_v_out_319051.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_319051", "319051001", "story_v_out_319051.awb")

						arg_1_1:RecordAudio("319051001", var_4_31)
						arg_1_1:RecordAudio("319051001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319051", "319051001", "story_v_out_319051.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319051", "319051001", "story_v_out_319051.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319051002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319051002
		arg_9_1.duration_ = 9.33

		local var_9_0 = {
			zh = 9.333,
			ja = 8.233
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
				arg_9_0:Play319051003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["10066ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10066ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "10066ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "10066ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["10066ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["10066ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["10066ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["10066ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["10066ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10066ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.99, -5.83)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["10066ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10066ui_story == nil then
				arg_9_1.var_.characterEffect10066ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect10066ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect10066ui_story then
				arg_9_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_12_8 = arg_9_1.actors_["10079ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos10079ui_story = var_12_8.localPosition
			end

			local var_12_9 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 then
				var_12_8.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_9_1.time_ - 0) / var_12_9)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 then
				var_12_8.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_12_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_8.position).x, (manager.ui.mainCamera.transform.position - var_12_8.position).y, (manager.ui.mainCamera.transform.position - var_12_8.position).z)
				var_12_8.localEulerAngles.z = 0
				var_12_8.localEulerAngles.x = 0
				var_12_8.localEulerAngles = var_12_8.localEulerAngles
			end

			local var_12_10 = arg_9_1.actors_["10079ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10079ui_story == nil then
				arg_9_1.var_.characterEffect10079ui_story = var_12_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_11 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_11 and not isNil(var_12_10) then
				if arg_9_1.var_.characterEffect10079ui_story and not isNil(var_12_10) then
					arg_9_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_9_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_11)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_11 and arg_9_1.time_ < 0 + var_12_11 + arg_12_0 and not isNil(var_12_10) and arg_9_1.var_.characterEffect10079ui_story then
				arg_9_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_9_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_12_12 = 0
			local var_12_13 = 0.825

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(319051002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 33 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 33)

				if (33 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 33)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051002", "story_v_out_319051.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_319051", "319051002", "story_v_out_319051.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_319051", "319051002", "story_v_out_319051.awb")

						arg_9_1:RecordAudio("319051002", var_12_19)
						arg_9_1:RecordAudio("319051002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319051", "319051002", "story_v_out_319051.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319051", "319051002", "story_v_out_319051.awb")
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play319051003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319051003
		arg_13_1.duration_ = 5.47

		local var_13_0 = {
			zh = 1.966,
			ja = 5.466
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
				arg_13_0:Play319051004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["10066ui_story"]) and arg_13_1.var_.characterEffect10066ui_story == nil then
				arg_13_1.var_.characterEffect10066ui_story = arg_13_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["10066ui_story"]) then
				if arg_13_1.var_.characterEffect10066ui_story and not isNil(arg_13_1.actors_["10066ui_story"]) then
					arg_13_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_13_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["10066ui_story"]) and arg_13_1.var_.characterEffect10066ui_story then
				arg_13_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_13_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_16_1 = arg_13_1.actors_["10079ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10079ui_story == nil then
				arg_13_1.var_.characterEffect10079ui_story = var_16_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_2 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_2 and not isNil(var_16_1) then
				if arg_13_1.var_.characterEffect10079ui_story and not isNil(var_16_1) then
					arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_2 and arg_13_1.time_ < 0 + var_16_2 + arg_16_0 and not isNil(var_16_1) and arg_13_1.var_.characterEffect10079ui_story then
				arg_13_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_16_4 = 0
			local var_16_5 = 0.125

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_4 + arg_16_0 then
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

				local var_16_6 = arg_13_1:GetWordFromCfg(319051003)
				local var_16_7 = arg_13_1:FormatText(var_16_6.content)

				arg_13_1.text_.text = var_16_7

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_9 = 5 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 5)

				if (5 <= 0 and var_16_5 or var_16_5 * (utf8.len(var_16_7) / 5)) > 0 and var_16_5 < var_16_9 then
					arg_13_1.talkMaxDuration = var_16_9

					if var_16_9 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_9 + var_16_4
					end
				end

				arg_13_1.text_.text = var_16_7
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051003", "story_v_out_319051.awb") ~= 0 then
					local var_16_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051003", "story_v_out_319051.awb") / 1000

					if var_16_10 + var_16_4 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_10 + var_16_4
					end

					if var_16_6.prefab_name ~= "" and arg_13_1.actors_[var_16_6.prefab_name] ~= nil then
						local var_16_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_6.prefab_name].transform, "story_v_out_319051", "319051003", "story_v_out_319051.awb")

						arg_13_1:RecordAudio("319051003", var_16_11)
						arg_13_1:RecordAudio("319051003", var_16_11)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319051", "319051003", "story_v_out_319051.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319051", "319051003", "story_v_out_319051.awb")
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
	Play319051004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319051004
		arg_17_1.duration_ = 6.33

		local var_17_0 = {
			zh = 1.6,
			ja = 6.333
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
				arg_17_0:Play319051005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["10066ui_story"]) and arg_17_1.var_.characterEffect10066ui_story == nil then
				arg_17_1.var_.characterEffect10066ui_story = arg_17_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["10066ui_story"]) then
				if arg_17_1.var_.characterEffect10066ui_story and not isNil(arg_17_1.actors_["10066ui_story"]) then
					arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["10066ui_story"]) and arg_17_1.var_.characterEffect10066ui_story then
				arg_17_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			local var_20_2 = arg_17_1.actors_["10079ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect10079ui_story == nil then
				arg_17_1.var_.characterEffect10079ui_story = var_20_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_3 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_3 and not isNil(var_20_2) then
				if arg_17_1.var_.characterEffect10079ui_story and not isNil(var_20_2) then
					arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_17_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_3)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_3 and arg_17_1.time_ < 0 + var_20_3 + arg_20_0 and not isNil(var_20_2) and arg_17_1.var_.characterEffect10079ui_story then
				arg_17_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_17_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_20_4 = 0
			local var_20_5 = 0.1

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_4 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_6 = arg_17_1:GetWordFromCfg(319051004)
				local var_20_7 = arg_17_1:FormatText(var_20_6.content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 4 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 4)

				if (4 <= 0 and var_20_5 or var_20_5 * (utf8.len(var_20_7) / 4)) > 0 and var_20_5 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_4
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051004", "story_v_out_319051.awb") ~= 0 then
					local var_20_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051004", "story_v_out_319051.awb") / 1000

					if var_20_10 + var_20_4 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_10 + var_20_4
					end

					if var_20_6.prefab_name ~= "" and arg_17_1.actors_[var_20_6.prefab_name] ~= nil then
						local var_20_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_6.prefab_name].transform, "story_v_out_319051", "319051004", "story_v_out_319051.awb")

						arg_17_1:RecordAudio("319051004", var_20_11)
						arg_17_1:RecordAudio("319051004", var_20_11)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_319051", "319051004", "story_v_out_319051.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_319051", "319051004", "story_v_out_319051.awb")
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
	Play319051005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319051005
		arg_21_1.duration_ = 5.47

		local var_21_0 = {
			zh = 3.533,
			ja = 5.466
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
				arg_21_0:Play319051006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(arg_21_1.actors_["10079ui_story"]) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = arg_21_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_0 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 and not isNil(arg_21_1.actors_["10079ui_story"]) then
				if arg_21_1.var_.characterEffect10079ui_story and not isNil(arg_21_1.actors_["10079ui_story"]) then
					arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 and not isNil(arg_21_1.actors_["10079ui_story"]) and arg_21_1.var_.characterEffect10079ui_story then
				arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_24_2 = arg_21_1.actors_["10066ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect10066ui_story == nil then
				arg_21_1.var_.characterEffect10066ui_story = var_24_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_3 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_3 and not isNil(var_24_2) then
				if arg_21_1.var_.characterEffect10066ui_story and not isNil(var_24_2) then
					arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_21_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_3)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_3 and arg_21_1.time_ < 0 + var_24_3 + arg_24_0 and not isNil(var_24_2) and arg_21_1.var_.characterEffect10066ui_story then
				arg_21_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_21_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			local var_24_4 = 0
			local var_24_5 = 0.5

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:GetWordFromCfg(319051005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 20 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 20)

				if (20 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 20)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051005", "story_v_out_319051.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051005", "story_v_out_319051.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319051", "319051005", "story_v_out_319051.awb")

						arg_21_1:RecordAudio("319051005", var_24_11)
						arg_21_1:RecordAudio("319051005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319051", "319051005", "story_v_out_319051.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319051", "319051005", "story_v_out_319051.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_12 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_12 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_12

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_12 and arg_21_1.time_ < var_24_4 + var_24_12 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play319051006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319051006
		arg_25_1.duration_ = 8.67

		local var_25_0 = {
			zh = 6,
			ja = 8.666
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
				arg_25_0:Play319051007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			local var_28_0 = 0.725

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
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

				local var_28_1 = arg_25_1:GetWordFromCfg(319051006)
				local var_28_2 = arg_25_1:FormatText(var_28_1.content)

				arg_25_1.text_.text = var_28_2

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_4 = 29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 29)

				if (29 <= 0 and var_28_0 or var_28_0 * (utf8.len(var_28_2) / 29)) > 0 and var_28_0 < var_28_4 then
					arg_25_1.talkMaxDuration = var_28_4

					if var_28_4 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_4 + 0
					end
				end

				arg_25_1.text_.text = var_28_2
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051006", "story_v_out_319051.awb") ~= 0 then
					local var_28_5 = manager.audio:GetVoiceLength("story_v_out_319051", "319051006", "story_v_out_319051.awb") / 1000

					if var_28_5 + 0 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_5 + 0
					end

					if var_28_1.prefab_name ~= "" and arg_25_1.actors_[var_28_1.prefab_name] ~= nil then
						local var_28_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_1.prefab_name].transform, "story_v_out_319051", "319051006", "story_v_out_319051.awb")

						arg_25_1:RecordAudio("319051006", var_28_6)
						arg_25_1:RecordAudio("319051006", var_28_6)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319051", "319051006", "story_v_out_319051.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319051", "319051006", "story_v_out_319051.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_7 = math.max(var_28_0, arg_25_1.talkMaxDuration)

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - 0) / var_28_7

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play319051007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319051007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play319051008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10079ui_story = arg_29_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10079ui_story"].transform.position).z)
				arg_29_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10079ui_story"].transform.localEulerAngles = arg_29_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_29_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["10079ui_story"].transform.position).z)
				arg_29_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["10079ui_story"].transform.localEulerAngles = arg_29_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["10066ui_story"].transform

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos10066ui_story = var_32_1.localPosition
			end

			local var_32_2 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 then
				var_32_1.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_29_1.time_ - 0) / var_32_2)
				var_32_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_1.position).x, (manager.ui.mainCamera.transform.position - var_32_1.position).y, (manager.ui.mainCamera.transform.position - var_32_1.position).z)
				var_32_1.localEulerAngles.z = 0
				var_32_1.localEulerAngles.x = 0
				var_32_1.localEulerAngles = var_32_1.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 then
				var_32_1.localPosition = Vector3.New(0, 100, 0)
				var_32_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_32_1.position).x, (manager.ui.mainCamera.transform.position - var_32_1.position).y, (manager.ui.mainCamera.transform.position - var_32_1.position).z)
				var_32_1.localEulerAngles.z = 0
				var_32_1.localEulerAngles.x = 0
				var_32_1.localEulerAngles = var_32_1.localEulerAngles
			end

			local var_32_3 = 0
			local var_32_4 = 0.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_3 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, false)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_5 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(319051007).content)

				arg_29_1.text_.text = var_32_5

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_7 = 37 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 37)

				if (37 <= 0 and var_32_4 or var_32_4 * (utf8.len(var_32_5) / 37)) > 0 and var_32_4 < var_32_7 then
					arg_29_1.talkMaxDuration = var_32_7

					if var_32_7 + var_32_3 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_7 + var_32_3
					end
				end

				arg_29_1.text_.text = var_32_5
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_8 = math.max(var_32_4, arg_29_1.talkMaxDuration)

			if var_32_3 <= arg_29_1.time_ and arg_29_1.time_ < var_32_3 + var_32_8 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_3) / var_32_8

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_3 + var_32_8 and arg_29_1.time_ < var_32_3 + var_32_8 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
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

		arg_29_1:InitPlayNodeList()
	end,
	Play319051008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319051008
		arg_33_1.duration_ = 7.33

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play319051009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if arg_33_1.bgs_.STblack == nil then
				local var_36_0 = Object.Instantiate(arg_33_1.paintGo_)

				var_36_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_36_0.name = "STblack"
				var_36_0.transform.parent = arg_33_1.stage_.transform
				var_36_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_33_1.bgs_.STblack = var_36_0
			end

			if 1.36666666666667 < arg_33_1.time_ and arg_33_1.time_ <= 1.36666666666667 + arg_36_0 then
				local var_36_1 = arg_33_1.bgs_.STblack

				arg_33_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_36_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_36_2 = var_36_1:GetComponent("SpriteRenderer")

				if var_36_2 and var_36_2.sprite then
					local var_36_3 = 2 * (var_36_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_36_1.transform.localScale = Vector3.New(var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, var_36_3 / var_36_2.sprite.bounds.size.y < var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x and var_36_3 * manager.ui.mainCameraCom_.aspect / var_36_2.sprite.bounds.size.x or var_36_3 / var_36_2.sprite.bounds.size.y, 0)
				end

				for iter_36_0, iter_36_1 in pairs(arg_33_1.bgs_) do
					if iter_36_0 ~= "STblack" then
						iter_36_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_36_4 = 0

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_5 = 1.36666666666667

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_5 then
				local var_36_6 = Color.New(0, 0, 0)

				var_36_6.a = Mathf.Lerp(0, 1, (arg_33_1.time_ - var_36_4) / var_36_5)
				arg_33_1.mask_.color = var_36_6
			end

			if arg_33_1.time_ >= var_36_4 + var_36_5 and arg_33_1.time_ < var_36_4 + var_36_5 + arg_36_0 then
				local var_36_7 = Color.New(0, 0, 0)

				var_36_7.a = 1
				arg_33_1.mask_.color = var_36_7
			end

			local var_36_8 = 1.36666666666667

			if 1.36666666666667 < arg_33_1.time_ and arg_33_1.time_ <= var_36_8 + arg_36_0 then
				arg_33_1.mask_.enabled = true
				arg_33_1.mask_.raycastTarget = true

				arg_33_1:SetGaussion(false)
			end

			local var_36_9 = 0.966666666666667

			if var_36_8 <= arg_33_1.time_ and arg_33_1.time_ < var_36_8 + var_36_9 then
				local var_36_10 = Color.New(0, 0, 0)

				var_36_10.a = Mathf.Lerp(1, 0, (arg_33_1.time_ - var_36_8) / var_36_9)
				arg_33_1.mask_.color = var_36_10
			end

			if arg_33_1.time_ >= var_36_8 + var_36_9 and arg_33_1.time_ < var_36_8 + var_36_9 + arg_36_0 then
				local var_36_11 = Color.New(0, 0, 0)

				arg_33_1.mask_.enabled = false
				var_36_11.a = 0
				arg_33_1.mask_.color = var_36_11
			end

			local var_36_12 = 2.33333333333333
			local var_36_13 = 1.45

			if 2.33333333333333 < arg_33_1.time_ and arg_33_1.time_ <= var_36_12 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, false)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_14 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(319051008).content)

				arg_33_1.text_.text = var_36_14

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_16 = 58 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_14) / 58)

				if (58 <= 0 and var_36_13 or var_36_13 * (utf8.len(var_36_14) / 58)) > 0 and var_36_13 < var_36_16 then
					arg_33_1.talkMaxDuration = var_36_16

					if var_36_16 + var_36_12 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_16 + var_36_12
					end
				end

				arg_33_1.text_.text = var_36_14
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_17 = math.max(var_36_13, arg_33_1.talkMaxDuration)

			if var_36_12 <= arg_33_1.time_ and arg_33_1.time_ < var_36_12 + var_36_17 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_12) / var_36_17

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_12 + var_36_17 and arg_33_1.time_ < var_36_12 + var_36_17 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play319051009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319051009
		arg_37_1.duration_ = 8.23

		local var_37_0 = {
			zh = 6.49933333333333,
			ja = 8.23333333333333
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
				arg_37_0:Play319051010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0.6 < arg_37_1.time_ and arg_37_1.time_ <= 0.6 + arg_40_0 then
				arg_37_1.var_.moveOldPos10079ui_story = arg_37_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0.6 <= arg_37_1.time_ and arg_37_1.time_ < 0.6 + var_40_0 then
				arg_37_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_37_1.time_ - 0.6) / var_40_0)
				arg_37_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10079ui_story"].transform.position).z)
				arg_37_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10079ui_story"].transform.localEulerAngles = arg_37_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0.6 + var_40_0 and arg_37_1.time_ < 0.6 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_37_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["10079ui_story"].transform.position).z)
				arg_37_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["10079ui_story"].transform.localEulerAngles = arg_37_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["10079ui_story"]

			if 0.6 < arg_37_1.time_ and arg_37_1.time_ <= 0.6 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0.6 <= arg_37_1.time_ and arg_37_1.time_ < 0.6 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0.6 + var_40_2 and arg_37_1.time_ < 0.6 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect10079ui_story then
				arg_37_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0.6 < arg_37_1.time_ and arg_37_1.time_ <= 0.6 + arg_40_0 then
				local var_40_4 = arg_37_1.bgs_.I11n

				arg_37_1.bgs_.I11n.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_40_4.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_40_5 = var_40_4:GetComponent("SpriteRenderer")

				if var_40_5 and var_40_5.sprite then
					local var_40_6 = 2 * (var_40_4.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_40_4.transform.localScale = Vector3.New(var_40_6 / var_40_5.sprite.bounds.size.y < var_40_6 * manager.ui.mainCameraCom_.aspect / var_40_5.sprite.bounds.size.x and var_40_6 * manager.ui.mainCameraCom_.aspect / var_40_5.sprite.bounds.size.x or var_40_6 / var_40_5.sprite.bounds.size.y, var_40_6 / var_40_5.sprite.bounds.size.y < var_40_6 * manager.ui.mainCameraCom_.aspect / var_40_5.sprite.bounds.size.x and var_40_6 * manager.ui.mainCameraCom_.aspect / var_40_5.sprite.bounds.size.x or var_40_6 / var_40_5.sprite.bounds.size.y, 0)
				end

				for iter_40_0, iter_40_1 in pairs(arg_37_1.bgs_) do
					if iter_40_0 ~= "I11n" then
						iter_40_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_40_7 = 0

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_7 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_8 = 0.6

			if var_40_7 <= arg_37_1.time_ and arg_37_1.time_ < var_40_7 + var_40_8 then
				local var_40_9 = Color.New(0, 0, 0)

				var_40_9.a = Mathf.Lerp(0, 1, (arg_37_1.time_ - var_40_7) / var_40_8)
				arg_37_1.mask_.color = var_40_9
			end

			if arg_37_1.time_ >= var_40_7 + var_40_8 and arg_37_1.time_ < var_40_7 + var_40_8 + arg_40_0 then
				local var_40_10 = Color.New(0, 0, 0)

				var_40_10.a = 1
				arg_37_1.mask_.color = var_40_10
			end

			local var_40_11 = 0.6

			if 0.6 < arg_37_1.time_ and arg_37_1.time_ <= var_40_11 + arg_40_0 then
				arg_37_1.mask_.enabled = true
				arg_37_1.mask_.raycastTarget = true

				arg_37_1:SetGaussion(false)
			end

			local var_40_12 = 1.73333333333333

			if var_40_11 <= arg_37_1.time_ and arg_37_1.time_ < var_40_11 + var_40_12 then
				local var_40_13 = Color.New(0, 0, 0)

				var_40_13.a = Mathf.Lerp(1, 0, (arg_37_1.time_ - var_40_11) / var_40_12)
				arg_37_1.mask_.color = var_40_13
			end

			if arg_37_1.time_ >= var_40_11 + var_40_12 and arg_37_1.time_ < var_40_11 + var_40_12 + arg_40_0 then
				local var_40_14 = Color.New(0, 0, 0)

				arg_37_1.mask_.enabled = false
				var_40_14.a = 0
				arg_37_1.mask_.color = var_40_14
			end

			local var_40_15 = 1.53333333333333
			local var_40_16 = 0.7

			if 1.53333333333333 < arg_37_1.time_ and arg_37_1.time_ <= var_40_15 + arg_40_0 then
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

				local var_40_17 = arg_37_1:GetWordFromCfg(319051009)
				local var_40_18 = arg_37_1:FormatText(var_40_17.content)

				arg_37_1.text_.text = var_40_18

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_20 = 28 <= 0 and var_40_16 or var_40_16 * (utf8.len(var_40_18) / 28)

				if (28 <= 0 and var_40_16 or var_40_16 * (utf8.len(var_40_18) / 28)) > 0 and var_40_16 < var_40_20 then
					arg_37_1.talkMaxDuration = var_40_20

					if var_40_20 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_20 + var_40_15
					end
				end

				arg_37_1.text_.text = var_40_18
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051009", "story_v_out_319051.awb") ~= 0 then
					local var_40_21 = manager.audio:GetVoiceLength("story_v_out_319051", "319051009", "story_v_out_319051.awb") / 1000

					if var_40_21 + var_40_15 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_21 + var_40_15
					end

					if var_40_17.prefab_name ~= "" and arg_37_1.actors_[var_40_17.prefab_name] ~= nil then
						local var_40_22 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_17.prefab_name].transform, "story_v_out_319051", "319051009", "story_v_out_319051.awb")

						arg_37_1:RecordAudio("319051009", var_40_22)
						arg_37_1:RecordAudio("319051009", var_40_22)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319051", "319051009", "story_v_out_319051.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319051", "319051009", "story_v_out_319051.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_23 = math.max(var_40_16, arg_37_1.talkMaxDuration)

			if var_40_15 <= arg_37_1.time_ and arg_37_1.time_ < var_40_15 + var_40_23 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_15) / var_40_23

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_15 + var_40_23 and arg_37_1.time_ < var_40_15 + var_40_23 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0.6,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_37_1:InitPlayNodeList()
	end,
	Play319051010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319051010
		arg_41_1.duration_ = 10.33

		local var_41_0 = {
			zh = 8.133,
			ja = 10.333
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
				arg_41_0:Play319051011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_44_0 = 0
			local var_44_1 = 0.95

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_2 = arg_41_1:GetWordFromCfg(319051010)
				local var_44_3 = arg_41_1:FormatText(var_44_2.content)

				arg_41_1.text_.text = var_44_3

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_5 = 38 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 38)

				if (38 <= 0 and var_44_1 or var_44_1 * (utf8.len(var_44_3) / 38)) > 0 and var_44_1 < var_44_5 then
					arg_41_1.talkMaxDuration = var_44_5

					if var_44_5 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + var_44_0
					end
				end

				arg_41_1.text_.text = var_44_3
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051010", "story_v_out_319051.awb") ~= 0 then
					local var_44_6 = manager.audio:GetVoiceLength("story_v_out_319051", "319051010", "story_v_out_319051.awb") / 1000

					if var_44_6 + var_44_0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_6 + var_44_0
					end

					if var_44_2.prefab_name ~= "" and arg_41_1.actors_[var_44_2.prefab_name] ~= nil then
						local var_44_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_2.prefab_name].transform, "story_v_out_319051", "319051010", "story_v_out_319051.awb")

						arg_41_1:RecordAudio("319051010", var_44_7)
						arg_41_1:RecordAudio("319051010", var_44_7)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319051", "319051010", "story_v_out_319051.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319051", "319051010", "story_v_out_319051.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_1, arg_41_1.talkMaxDuration)

			if var_44_0 <= arg_41_1.time_ and arg_41_1.time_ < var_44_0 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_0) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_0 + var_44_8 and arg_41_1.time_ < var_44_0 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319051011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319051011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319051012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["10079ui_story"]) and arg_45_1.var_.characterEffect10079ui_story == nil then
				arg_45_1.var_.characterEffect10079ui_story = arg_45_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["10079ui_story"]) then
				if arg_45_1.var_.characterEffect10079ui_story and not isNil(arg_45_1.actors_["10079ui_story"]) then
					arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_0)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["10079ui_story"]) and arg_45_1.var_.characterEffect10079ui_story then
				arg_45_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action473")
			end

			local var_48_1 = 0
			local var_48_2 = 1.025

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_1 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, false)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_3 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(319051011).content)

				arg_45_1.text_.text = var_48_3

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_5 = 41 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 41)

				if (41 <= 0 and var_48_2 or var_48_2 * (utf8.len(var_48_3) / 41)) > 0 and var_48_2 < var_48_5 then
					arg_45_1.talkMaxDuration = var_48_5

					if var_48_5 + var_48_1 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + var_48_1
					end
				end

				arg_45_1.text_.text = var_48_3
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_6 = math.max(var_48_2, arg_45_1.talkMaxDuration)

			if var_48_1 <= arg_45_1.time_ and arg_45_1.time_ < var_48_1 + var_48_6 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_1) / var_48_6

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_1 + var_48_6 and arg_45_1.time_ < var_48_1 + var_48_6 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319051012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319051012
		arg_49_1.duration_ = 8.53

		local var_49_0 = {
			zh = 6.966,
			ja = 8.533
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
				arg_49_0:Play319051013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10066ui_story = arg_49_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10066ui_story"].transform.position).z)
				arg_49_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10066ui_story"].transform.localEulerAngles = arg_49_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_49_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10066ui_story"].transform.position).z)
				arg_49_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10066ui_story"].transform.localEulerAngles = arg_49_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10066ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10066ui_story == nil then
				arg_49_1.var_.characterEffect10066ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10066ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10066ui_story then
				arg_49_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_52_4 = arg_49_1.actors_["10079ui_story"].transform

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10079ui_story = var_52_4.localPosition
			end

			local var_52_5 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 then
				var_52_4.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_49_1.time_ - 0) / var_52_5)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 then
				var_52_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_52_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_52_4.position).x, (manager.ui.mainCamera.transform.position - var_52_4.position).y, (manager.ui.mainCamera.transform.position - var_52_4.position).z)
				var_52_4.localEulerAngles.z = 0
				var_52_4.localEulerAngles.x = 0
				var_52_4.localEulerAngles = var_52_4.localEulerAngles
			end

			local var_52_6 = arg_49_1.actors_["10079ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10079ui_story == nil then
				arg_49_1.var_.characterEffect10079ui_story = var_52_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_7 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 and not isNil(var_52_6) then
				if arg_49_1.var_.characterEffect10079ui_story and not isNil(var_52_6) then
					arg_49_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_49_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_7)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 and not isNil(var_52_6) and arg_49_1.var_.characterEffect10079ui_story then
				arg_49_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_49_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_52_8 = 0
			local var_52_9 = 0.8

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_8 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_10 = arg_49_1:GetWordFromCfg(319051012)
				local var_52_11 = arg_49_1:FormatText(var_52_10.content)

				arg_49_1.text_.text = var_52_11

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_13 = 32 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 32)

				if (32 <= 0 and var_52_9 or var_52_9 * (utf8.len(var_52_11) / 32)) > 0 and var_52_9 < var_52_13 then
					arg_49_1.talkMaxDuration = var_52_13

					if var_52_13 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_13 + var_52_8
					end
				end

				arg_49_1.text_.text = var_52_11
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051012", "story_v_out_319051.awb") ~= 0 then
					local var_52_14 = manager.audio:GetVoiceLength("story_v_out_319051", "319051012", "story_v_out_319051.awb") / 1000

					if var_52_14 + var_52_8 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_14 + var_52_8
					end

					if var_52_10.prefab_name ~= "" and arg_49_1.actors_[var_52_10.prefab_name] ~= nil then
						local var_52_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_10.prefab_name].transform, "story_v_out_319051", "319051012", "story_v_out_319051.awb")

						arg_49_1:RecordAudio("319051012", var_52_15)
						arg_49_1:RecordAudio("319051012", var_52_15)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319051", "319051012", "story_v_out_319051.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319051", "319051012", "story_v_out_319051.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_16 = math.max(var_52_9, arg_49_1.talkMaxDuration)

			if var_52_8 <= arg_49_1.time_ and arg_49_1.time_ < var_52_8 + var_52_16 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_8) / var_52_16

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_8 + var_52_16 and arg_49_1.time_ < var_52_8 + var_52_16 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
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
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play319051013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319051013
		arg_53_1.duration_ = 13.6

		local var_53_0 = {
			zh = 11.566,
			ja = 13.6
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
				arg_53_0:Play319051014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 1.15

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(319051013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 46 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 46)

				if (46 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 46)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051013", "story_v_out_319051.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_319051", "319051013", "story_v_out_319051.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_319051", "319051013", "story_v_out_319051.awb")

						arg_53_1:RecordAudio("319051013", var_56_6)
						arg_53_1:RecordAudio("319051013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319051", "319051013", "story_v_out_319051.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319051", "319051013", "story_v_out_319051.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_7 = math.max(var_56_0, arg_53_1.talkMaxDuration)

			if 0 <= arg_53_1.time_ and arg_53_1.time_ < 0 + var_56_7 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - 0) / var_56_7

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= 0 + var_56_7 and arg_53_1.time_ < 0 + var_56_7 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play319051014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319051014
		arg_57_1.duration_ = 6.23

		local var_57_0 = {
			zh = 6.233,
			ja = 6.033
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
				arg_57_0:Play319051015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.var_.moveOldPos10066ui_story = arg_57_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_60_0 = 0.001

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 then
				arg_57_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_57_1.var_.moveOldPos10066ui_story, Vector3.New(0.7, -0.99, -5.83), (arg_57_1.time_ - 0) / var_60_0)
				arg_57_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).z)
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles = arg_57_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 then
				arg_57_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0.7, -0.99, -5.83)
				arg_57_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_57_1.actors_["10066ui_story"].transform.position).z)
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_57_1.actors_["10066ui_story"].transform.localEulerAngles = arg_57_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_60_1 = arg_57_1.actors_["10066ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10066ui_story == nil then
				arg_57_1.var_.characterEffect10066ui_story = var_60_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_2 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_2 and not isNil(var_60_1) then
				if arg_57_1.var_.characterEffect10066ui_story and not isNil(var_60_1) then
					arg_57_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_2 and arg_57_1.time_ < 0 + var_60_2 + arg_60_0 and not isNil(var_60_1) and arg_57_1.var_.characterEffect10066ui_story then
				arg_57_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action7_1")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_60_4 = 0
			local var_60_5 = 0.55

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:GetWordFromCfg(319051014)
				local var_60_7 = arg_57_1:FormatText(var_60_6.content)

				arg_57_1.text_.text = var_60_7

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_9 = 22 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 22)

				if (22 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_7) / 22)) > 0 and var_60_5 < var_60_9 then
					arg_57_1.talkMaxDuration = var_60_9

					if var_60_9 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_9 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_7
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051014", "story_v_out_319051.awb") ~= 0 then
					local var_60_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051014", "story_v_out_319051.awb") / 1000

					if var_60_10 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_10 + var_60_4
					end

					if var_60_6.prefab_name ~= "" and arg_57_1.actors_[var_60_6.prefab_name] ~= nil then
						local var_60_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_6.prefab_name].transform, "story_v_out_319051", "319051014", "story_v_out_319051.awb")

						arg_57_1:RecordAudio("319051014", var_60_11)
						arg_57_1:RecordAudio("319051014", var_60_11)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319051", "319051014", "story_v_out_319051.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319051", "319051014", "story_v_out_319051.awb")
				end

				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_12 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_12 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_12

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_12 and arg_57_1.time_ < var_60_4 + var_60_12 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {
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

		arg_57_1:InitPlayNodeList()
	end,
	Play319051015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319051015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319051016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["10066ui_story"]) and arg_61_1.var_.characterEffect10066ui_story == nil then
				arg_61_1.var_.characterEffect10066ui_story = arg_61_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["10066ui_story"]) then
				if arg_61_1.var_.characterEffect10066ui_story and not isNil(arg_61_1.actors_["10066ui_story"]) then
					arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_0)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["10066ui_story"]) and arg_61_1.var_.characterEffect10066ui_story then
				arg_61_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_64_1 = arg_61_1.actors_["10079ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_2)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10079ui_story then
				arg_61_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_64_3 = 0
			local var_64_4 = 1.3

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_3 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, false)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_5 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(319051015).content)

				arg_61_1.text_.text = var_64_5

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_7 = 52 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 52)

				if (52 <= 0 and var_64_4 or var_64_4 * (utf8.len(var_64_5) / 52)) > 0 and var_64_4 < var_64_7 then
					arg_61_1.talkMaxDuration = var_64_7

					if var_64_7 + var_64_3 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_7 + var_64_3
					end
				end

				arg_61_1.text_.text = var_64_5
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_8 = math.max(var_64_4, arg_61_1.talkMaxDuration)

			if var_64_3 <= arg_61_1.time_ and arg_61_1.time_ < var_64_3 + var_64_8 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_3) / var_64_8

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_3 + var_64_8 and arg_61_1.time_ < var_64_3 + var_64_8 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play319051016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319051016
		arg_65_1.duration_ = 4.07

		local var_65_0 = {
			zh = 4.066,
			ja = 3.933
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
				arg_65_0:Play319051017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10079ui_story"]) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = arg_65_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10079ui_story"]) then
				if arg_65_1.var_.characterEffect10079ui_story and not isNil(arg_65_1.actors_["10079ui_story"]) then
					arg_65_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10079ui_story"]) and arg_65_1.var_.characterEffect10079ui_story then
				arg_65_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4312")
			end

			local var_68_2 = arg_65_1.actors_["10066ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect10066ui_story == nil then
				arg_65_1.var_.characterEffect10066ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect10066ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect10066ui_story then
				arg_65_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_68_4 = 0
			local var_68_5 = 0.45

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

				local var_68_6 = arg_65_1:GetWordFromCfg(319051016)
				local var_68_7 = arg_65_1:FormatText(var_68_6.content)

				arg_65_1.text_.text = var_68_7

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_9 = 18 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 18)

				if (18 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_7) / 18)) > 0 and var_68_5 < var_68_9 then
					arg_65_1.talkMaxDuration = var_68_9

					if var_68_9 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_9 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_7
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051016", "story_v_out_319051.awb") ~= 0 then
					local var_68_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051016", "story_v_out_319051.awb") / 1000

					if var_68_10 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_10 + var_68_4
					end

					if var_68_6.prefab_name ~= "" and arg_65_1.actors_[var_68_6.prefab_name] ~= nil then
						local var_68_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_6.prefab_name].transform, "story_v_out_319051", "319051016", "story_v_out_319051.awb")

						arg_65_1:RecordAudio("319051016", var_68_11)
						arg_65_1:RecordAudio("319051016", var_68_11)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319051", "319051016", "story_v_out_319051.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319051", "319051016", "story_v_out_319051.awb")
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
	Play319051017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319051017
		arg_69_1.duration_ = 3.97

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play319051018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if arg_69_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_72_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_69_1.stage_.transform)

				var_72_0.name = "1095ui_story"
				var_72_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.actors_["1095ui_story"] = var_72_0

				local var_72_1 = var_72_0:GetComponentInChildren(typeof(CharacterEffect))

				var_72_1.enabled = true

				local var_72_2 = GameObjectTools.GetOrAddComponent(var_72_0, typeof(DynamicBoneHelper))

				if var_72_2 then
					var_72_2:EnableDynamicBone(false)
				end

				arg_69_1:ShowWeapon(var_72_1.transform, false)

				arg_69_1.var_["1095ui_story" .. "Animator"] = var_72_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_69_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_69_1.var_["1095ui_story" .. "LipSync"] = var_72_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_72_3 = arg_69_1.actors_["1095ui_story"].transform

			if 1.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 1.96666666666667 + arg_72_0 then
				arg_69_1.var_.moveOldPos1095ui_story = var_72_3.localPosition
			end

			local var_72_4 = 0.001

			if 1.96666666666667 <= arg_69_1.time_ and arg_69_1.time_ < 1.96666666666667 + var_72_4 then
				var_72_3.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_69_1.time_ - 1.96666666666667) / var_72_4)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			if arg_69_1.time_ >= 1.96666666666667 + var_72_4 and arg_69_1.time_ < 1.96666666666667 + var_72_4 + arg_72_0 then
				var_72_3.localPosition = Vector3.New(0, -0.98, -6.1)
				var_72_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_3.position).x, (manager.ui.mainCamera.transform.position - var_72_3.position).y, (manager.ui.mainCamera.transform.position - var_72_3.position).z)
				var_72_3.localEulerAngles.z = 0
				var_72_3.localEulerAngles.x = 0
				var_72_3.localEulerAngles = var_72_3.localEulerAngles
			end

			local var_72_5 = arg_69_1.actors_["1095ui_story"]

			if 1.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 1.96666666666667 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = var_72_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_6 = 0.200000002980232

			if 1.96666666666667 <= arg_69_1.time_ and arg_69_1.time_ < 1.96666666666667 + var_72_6 and not isNil(var_72_5) then
				if arg_69_1.var_.characterEffect1095ui_story and not isNil(var_72_5) then
					arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 1.96666666666667 + var_72_6 and arg_69_1.time_ < 1.96666666666667 + var_72_6 + arg_72_0 and not isNil(var_72_5) and arg_69_1.var_.characterEffect1095ui_story then
				arg_69_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 1.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 1.96666666666667 + arg_72_0 then
				arg_69_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 1.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= 1.96666666666667 + arg_72_0 then
				arg_69_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= 1 + arg_72_0 then
				local var_72_8 = arg_69_1.bgs_.I11n

				arg_69_1.bgs_.I11n.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_9 = var_72_8:GetComponent("SpriteRenderer")

				if var_72_9 and var_72_9.sprite then
					local var_72_10 = 2 * (var_72_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_8.transform.localScale = Vector3.New(var_72_10 / var_72_9.sprite.bounds.size.y < var_72_10 * manager.ui.mainCameraCom_.aspect / var_72_9.sprite.bounds.size.x and var_72_10 * manager.ui.mainCameraCom_.aspect / var_72_9.sprite.bounds.size.x or var_72_10 / var_72_9.sprite.bounds.size.y, var_72_10 / var_72_9.sprite.bounds.size.y < var_72_10 * manager.ui.mainCameraCom_.aspect / var_72_9.sprite.bounds.size.x and var_72_10 * manager.ui.mainCameraCom_.aspect / var_72_9.sprite.bounds.size.x or var_72_10 / var_72_9.sprite.bounds.size.y, 0)
				end

				for iter_72_0, iter_72_1 in pairs(arg_69_1.bgs_) do
					if iter_72_0 ~= "I11n" then
						iter_72_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_72_11 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_11 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_12 = 1

			if var_72_11 <= arg_69_1.time_ and arg_69_1.time_ < var_72_11 + var_72_12 then
				local var_72_13 = Color.New(0, 0, 0)

				var_72_13.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_11) / var_72_12)
				arg_69_1.mask_.color = var_72_13
			end

			if arg_69_1.time_ >= var_72_11 + var_72_12 and arg_69_1.time_ < var_72_11 + var_72_12 + arg_72_0 then
				local var_72_14 = Color.New(0, 0, 0)

				var_72_14.a = 1
				arg_69_1.mask_.color = var_72_14
			end

			local var_72_15 = 1

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= var_72_15 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_16 = 1.3

			if var_72_15 <= arg_69_1.time_ and arg_69_1.time_ < var_72_15 + var_72_16 then
				local var_72_17 = Color.New(0, 0, 0)

				var_72_17.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_15) / var_72_16)
				arg_69_1.mask_.color = var_72_17
			end

			if arg_69_1.time_ >= var_72_15 + var_72_16 and arg_69_1.time_ < var_72_15 + var_72_16 + arg_72_0 then
				local var_72_18 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_18.a = 0
				arg_69_1.mask_.color = var_72_18
			end

			local var_72_19 = arg_69_1.actors_["10066ui_story"].transform

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= 1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10066ui_story = var_72_19.localPosition
			end

			local var_72_20 = 0.001

			if 1 <= arg_69_1.time_ and arg_69_1.time_ < 1 + var_72_20 then
				var_72_19.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 1) / var_72_20)
				var_72_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_19.position).x, (manager.ui.mainCamera.transform.position - var_72_19.position).y, (manager.ui.mainCamera.transform.position - var_72_19.position).z)
				var_72_19.localEulerAngles.z = 0
				var_72_19.localEulerAngles.x = 0
				var_72_19.localEulerAngles = var_72_19.localEulerAngles
			end

			if arg_69_1.time_ >= 1 + var_72_20 and arg_69_1.time_ < 1 + var_72_20 + arg_72_0 then
				var_72_19.localPosition = Vector3.New(0, 100, 0)
				var_72_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_19.position).x, (manager.ui.mainCamera.transform.position - var_72_19.position).y, (manager.ui.mainCamera.transform.position - var_72_19.position).z)
				var_72_19.localEulerAngles.z = 0
				var_72_19.localEulerAngles.x = 0
				var_72_19.localEulerAngles = var_72_19.localEulerAngles
			end

			local var_72_21 = arg_69_1.actors_["10079ui_story"].transform

			if 1 < arg_69_1.time_ and arg_69_1.time_ <= 1 + arg_72_0 then
				arg_69_1.var_.moveOldPos10079ui_story = var_72_21.localPosition
			end

			local var_72_22 = 0.001

			if 1 <= arg_69_1.time_ and arg_69_1.time_ < 1 + var_72_22 then
				var_72_21.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 1) / var_72_22)
				var_72_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_21.position).x, (manager.ui.mainCamera.transform.position - var_72_21.position).y, (manager.ui.mainCamera.transform.position - var_72_21.position).z)
				var_72_21.localEulerAngles.z = 0
				var_72_21.localEulerAngles.x = 0
				var_72_21.localEulerAngles = var_72_21.localEulerAngles
			end

			if arg_69_1.time_ >= 1 + var_72_22 and arg_69_1.time_ < 1 + var_72_22 + arg_72_0 then
				var_72_21.localPosition = Vector3.New(0, 100, 0)
				var_72_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_21.position).x, (manager.ui.mainCamera.transform.position - var_72_21.position).y, (manager.ui.mainCamera.transform.position - var_72_21.position).z)
				var_72_21.localEulerAngles.z = 0
				var_72_21.localEulerAngles.x = 0
				var_72_21.localEulerAngles = var_72_21.localEulerAngles
			end

			if arg_69_1.frameCnt_ <= 1 then
				arg_69_1.dialog_:SetActive(false)
			end

			local var_72_23 = 1.96666666666667
			local var_72_24 = 0.05

			if 1.96666666666667 < arg_69_1.time_ and arg_69_1.time_ <= var_72_23 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0

				arg_69_1.dialog_:SetActive(true)

				arg_69_1.dialogCg_.alpha = 0

				local var_72_25 = LeanTween.value(arg_69_1.dialog_, 0, 1, 0.3)

				var_72_25:setOnUpdate(LuaHelper.FloatAction(function(arg_73_0)
					arg_69_1.dialogCg_.alpha = arg_73_0
				end))
				var_72_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_69_1.dialog_)
					var_72_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_69_1.duration_ = arg_69_1.duration_ + 0.3

				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_26 = arg_69_1:GetWordFromCfg(319051017)
				local var_72_27 = arg_69_1:FormatText(var_72_26.content)

				arg_69_1.text_.text = var_72_27

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_29 = 2 <= 0 and var_72_24 or var_72_24 * (utf8.len(var_72_27) / 2)

				if (2 <= 0 and var_72_24 or var_72_24 * (utf8.len(var_72_27) / 2)) > 0 and var_72_24 < var_72_29 then
					arg_69_1.talkMaxDuration = var_72_29
					var_72_23 = var_72_23 + 0.3

					if var_72_29 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_29 + var_72_23
					end
				end

				arg_69_1.text_.text = var_72_27
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051017", "story_v_out_319051.awb") ~= 0 then
					local var_72_30 = manager.audio:GetVoiceLength("story_v_out_319051", "319051017", "story_v_out_319051.awb") / 1000

					if var_72_30 + var_72_23 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_30 + var_72_23
					end

					if var_72_26.prefab_name ~= "" and arg_69_1.actors_[var_72_26.prefab_name] ~= nil then
						local var_72_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_26.prefab_name].transform, "story_v_out_319051", "319051017", "story_v_out_319051.awb")

						arg_69_1:RecordAudio("319051017", var_72_31)
						arg_69_1:RecordAudio("319051017", var_72_31)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319051", "319051017", "story_v_out_319051.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319051", "319051017", "story_v_out_319051.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_32 = var_72_23 + 0.3
			local var_72_33 = math.max(var_72_24, arg_69_1.talkMaxDuration)

			if var_72_23 + 0.3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_32 + var_72_33 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_32) / var_72_33

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_32 + var_72_33 and arg_69_1.time_ < var_72_32 + var_72_33 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10066ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_69_1:InitPlayNodeList()
	end,
	Play319051018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 319051018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play319051019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(arg_75_1.actors_["1095ui_story"]) and arg_75_1.var_.characterEffect1095ui_story == nil then
				arg_75_1.var_.characterEffect1095ui_story = arg_75_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_0 = 0.200000002980232

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 and not isNil(arg_75_1.actors_["1095ui_story"]) then
				if arg_75_1.var_.characterEffect1095ui_story and not isNil(arg_75_1.actors_["1095ui_story"]) then
					arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_75_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_75_1.time_ - 0) / var_78_0)
				end
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 and not isNil(arg_75_1.actors_["1095ui_story"]) and arg_75_1.var_.characterEffect1095ui_story then
				arg_75_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_75_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_78_1 = 0
			local var_78_2 = 1.275

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_1 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(319051018).content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 51 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 51)

				if (51 <= 0 and var_78_2 or var_78_2 * (utf8.len(var_78_3) / 51)) > 0 and var_78_2 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_1 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_1
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_6 = math.max(var_78_2, arg_75_1.talkMaxDuration)

			if var_78_1 <= arg_75_1.time_ and arg_75_1.time_ < var_78_1 + var_78_6 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_1) / var_78_6

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_1 + var_78_6 and arg_75_1.time_ < var_78_1 + var_78_6 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play319051019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 319051019
		arg_79_1.duration_ = 6.9

		local var_79_0 = {
			zh = 4.966,
			ja = 6.9
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
				arg_79_0:Play319051020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(arg_79_1.actors_["10079ui_story"]) and arg_79_1.var_.characterEffect10079ui_story == nil then
				arg_79_1.var_.characterEffect10079ui_story = arg_79_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_0 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 and not isNil(arg_79_1.actors_["10079ui_story"]) then
				if arg_79_1.var_.characterEffect10079ui_story and not isNil(arg_79_1.actors_["10079ui_story"]) then
					arg_79_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 and not isNil(arg_79_1.actors_["10079ui_story"]) and arg_79_1.var_.characterEffect10079ui_story then
				arg_79_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_82_2 = arg_79_1.actors_["1095ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos1095ui_story = var_82_2.localPosition
			end

			local var_82_3 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_3 then
				var_82_2.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_79_1.time_ - 0) / var_82_3)
				var_82_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_2.position).x, (manager.ui.mainCamera.transform.position - var_82_2.position).y, (manager.ui.mainCamera.transform.position - var_82_2.position).z)
				var_82_2.localEulerAngles.z = 0
				var_82_2.localEulerAngles.x = 0
				var_82_2.localEulerAngles = var_82_2.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_3 and arg_79_1.time_ < 0 + var_82_3 + arg_82_0 then
				var_82_2.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_82_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_2.position).x, (manager.ui.mainCamera.transform.position - var_82_2.position).y, (manager.ui.mainCamera.transform.position - var_82_2.position).z)
				var_82_2.localEulerAngles.z = 0
				var_82_2.localEulerAngles.x = 0
				var_82_2.localEulerAngles = var_82_2.localEulerAngles
			end

			local var_82_4 = arg_79_1.actors_["1095ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1095ui_story == nil then
				arg_79_1.var_.characterEffect1095ui_story = var_82_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_5 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_5 and not isNil(var_82_4) then
				if arg_79_1.var_.characterEffect1095ui_story and not isNil(var_82_4) then
					arg_79_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_5)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_5 and arg_79_1.time_ < 0 + var_82_5 + arg_82_0 and not isNil(var_82_4) and arg_79_1.var_.characterEffect1095ui_story then
				arg_79_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_82_6 = arg_79_1.actors_["10079ui_story"].transform

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10079ui_story = var_82_6.localPosition
			end

			local var_82_7 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_7 then
				var_82_6.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_79_1.time_ - 0) / var_82_7)
				var_82_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_6.position).x, (manager.ui.mainCamera.transform.position - var_82_6.position).y, (manager.ui.mainCamera.transform.position - var_82_6.position).z)
				var_82_6.localEulerAngles.z = 0
				var_82_6.localEulerAngles.x = 0
				var_82_6.localEulerAngles = var_82_6.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_7 and arg_79_1.time_ < 0 + var_82_7 + arg_82_0 then
				var_82_6.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_82_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_82_6.position).x, (manager.ui.mainCamera.transform.position - var_82_6.position).y, (manager.ui.mainCamera.transform.position - var_82_6.position).z)
				var_82_6.localEulerAngles.z = 0
				var_82_6.localEulerAngles.x = 0
				var_82_6.localEulerAngles = var_82_6.localEulerAngles
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_2")
			end

			local var_82_8 = 0
			local var_82_9 = 0.575

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_8 + arg_82_0 then
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

				local var_82_10 = arg_79_1:GetWordFromCfg(319051019)
				local var_82_11 = arg_79_1:FormatText(var_82_10.content)

				arg_79_1.text_.text = var_82_11

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_13 = 23 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 23)

				if (23 <= 0 and var_82_9 or var_82_9 * (utf8.len(var_82_11) / 23)) > 0 and var_82_9 < var_82_13 then
					arg_79_1.talkMaxDuration = var_82_13

					if var_82_13 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_13 + var_82_8
					end
				end

				arg_79_1.text_.text = var_82_11
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051019", "story_v_out_319051.awb") ~= 0 then
					local var_82_14 = manager.audio:GetVoiceLength("story_v_out_319051", "319051019", "story_v_out_319051.awb") / 1000

					if var_82_14 + var_82_8 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_14 + var_82_8
					end

					if var_82_10.prefab_name ~= "" and arg_79_1.actors_[var_82_10.prefab_name] ~= nil then
						local var_82_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_10.prefab_name].transform, "story_v_out_319051", "319051019", "story_v_out_319051.awb")

						arg_79_1:RecordAudio("319051019", var_82_15)
						arg_79_1:RecordAudio("319051019", var_82_15)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_319051", "319051019", "story_v_out_319051.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_319051", "319051019", "story_v_out_319051.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_16 = math.max(var_82_9, arg_79_1.talkMaxDuration)

			if var_82_8 <= arg_79_1.time_ and arg_79_1.time_ < var_82_8 + var_82_16 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_8) / var_82_16

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_8 + var_82_16 and arg_79_1.time_ < var_82_8 + var_82_16 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play319051020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 319051020
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play319051021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(arg_83_1.actors_["10079ui_story"]) and arg_83_1.var_.characterEffect10079ui_story == nil then
				arg_83_1.var_.characterEffect10079ui_story = arg_83_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_0 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 and not isNil(arg_83_1.actors_["10079ui_story"]) then
				if arg_83_1.var_.characterEffect10079ui_story and not isNil(arg_83_1.actors_["10079ui_story"]) then
					arg_83_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_0)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 and not isNil(arg_83_1.actors_["10079ui_story"]) and arg_83_1.var_.characterEffect10079ui_story then
				arg_83_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_86_1 = arg_83_1.actors_["10079ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect10079ui_story == nil then
				arg_83_1.var_.characterEffect10079ui_story = var_86_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_2 = 0.200000002980232

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_2 and not isNil(var_86_1) then
				if arg_83_1.var_.characterEffect10079ui_story and not isNil(var_86_1) then
					arg_83_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_83_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_2)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_2 and arg_83_1.time_ < 0 + var_86_2 + arg_86_0 and not isNil(var_86_1) and arg_83_1.var_.characterEffect10079ui_story then
				arg_83_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_83_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_86_3 = 0
			local var_86_4 = 0.9

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_3 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_5 = arg_83_1:FormatText(arg_83_1:GetWordFromCfg(319051020).content)

				arg_83_1.text_.text = var_86_5

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_7 = 36 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 36)

				if (36 <= 0 and var_86_4 or var_86_4 * (utf8.len(var_86_5) / 36)) > 0 and var_86_4 < var_86_7 then
					arg_83_1.talkMaxDuration = var_86_7

					if var_86_7 + var_86_3 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_7 + var_86_3
					end
				end

				arg_83_1.text_.text = var_86_5
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_8 = math.max(var_86_4, arg_83_1.talkMaxDuration)

			if var_86_3 <= arg_83_1.time_ and arg_83_1.time_ < var_86_3 + var_86_8 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_3) / var_86_8

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_3 + var_86_8 and arg_83_1.time_ < var_86_3 + var_86_8 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play319051021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 319051021
		arg_87_1.duration_ = 6.2

		local var_87_0 = {
			zh = 4.933,
			ja = 6.2
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
				arg_87_0:Play319051022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1095ui_story = arg_87_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_87_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1095ui_story"].transform.position).z)
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1095ui_story"].transform.localEulerAngles = arg_87_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_90_1 = arg_87_1.actors_["1095ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story == nil then
				arg_87_1.var_.characterEffect1095ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.200000002980232

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1095ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1095ui_story then
				arg_87_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.45

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(319051021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 18 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 18)

				if (18 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 18)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051021", "story_v_out_319051.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051021", "story_v_out_319051.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_319051", "319051021", "story_v_out_319051.awb")

						arg_87_1:RecordAudio("319051021", var_90_11)
						arg_87_1:RecordAudio("319051021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_319051", "319051021", "story_v_out_319051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_319051", "319051021", "story_v_out_319051.awb")
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

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_87_1:InitPlayNodeList()
	end,
	Play319051022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 319051022
		arg_91_1.duration_ = 8.5

		local var_91_0 = {
			zh = 8.5,
			ja = 4.766
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
				arg_91_0:Play319051023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10066ui_story = arg_91_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_94_0 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 then
				arg_91_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_91_1.time_ - 0) / var_94_0)
				arg_91_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).z)
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles = arg_91_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 then
				arg_91_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_91_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_91_1.actors_["10066ui_story"].transform.position).z)
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_91_1.actors_["10066ui_story"].transform.localEulerAngles = arg_91_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_94_1 = arg_91_1.actors_["10066ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10066ui_story == nil then
				arg_91_1.var_.characterEffect10066ui_story = var_94_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_2 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_2 and not isNil(var_94_1) then
				if arg_91_1.var_.characterEffect10066ui_story and not isNil(var_94_1) then
					arg_91_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_2 and arg_91_1.time_ < 0 + var_94_2 + arg_94_0 and not isNil(var_94_1) and arg_91_1.var_.characterEffect10066ui_story then
				arg_91_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action5_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_94_4 = arg_91_1.actors_["1095ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos1095ui_story = var_94_4.localPosition
			end

			local var_94_5 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_5 then
				var_94_4.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_5)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_5 and arg_91_1.time_ < 0 + var_94_5 + arg_94_0 then
				var_94_4.localPosition = Vector3.New(0, 100, 0)
				var_94_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_4.position).x, (manager.ui.mainCamera.transform.position - var_94_4.position).y, (manager.ui.mainCamera.transform.position - var_94_4.position).z)
				var_94_4.localEulerAngles.z = 0
				var_94_4.localEulerAngles.x = 0
				var_94_4.localEulerAngles = var_94_4.localEulerAngles
			end

			local var_94_6 = arg_91_1.actors_["1095ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect1095ui_story == nil then
				arg_91_1.var_.characterEffect1095ui_story = var_94_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_7 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_7 and not isNil(var_94_6) then
				if arg_91_1.var_.characterEffect1095ui_story and not isNil(var_94_6) then
					arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_7)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_7 and arg_91_1.time_ < 0 + var_94_7 + arg_94_0 and not isNil(var_94_6) and arg_91_1.var_.characterEffect1095ui_story then
				arg_91_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_94_8 = arg_91_1.actors_["10079ui_story"].transform

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1.var_.moveOldPos10079ui_story = var_94_8.localPosition
			end

			local var_94_9 = 0.001

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_9 then
				var_94_8.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 0) / var_94_9)
				var_94_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_8.position).x, (manager.ui.mainCamera.transform.position - var_94_8.position).y, (manager.ui.mainCamera.transform.position - var_94_8.position).z)
				var_94_8.localEulerAngles.z = 0
				var_94_8.localEulerAngles.x = 0
				var_94_8.localEulerAngles = var_94_8.localEulerAngles
			end

			if arg_91_1.time_ >= 0 + var_94_9 and arg_91_1.time_ < 0 + var_94_9 + arg_94_0 then
				var_94_8.localPosition = Vector3.New(0, 100, 0)
				var_94_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_8.position).x, (manager.ui.mainCamera.transform.position - var_94_8.position).y, (manager.ui.mainCamera.transform.position - var_94_8.position).z)
				var_94_8.localEulerAngles.z = 0
				var_94_8.localEulerAngles.x = 0
				var_94_8.localEulerAngles = var_94_8.localEulerAngles
			end

			local var_94_10 = arg_91_1.actors_["10079ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.characterEffect10079ui_story == nil then
				arg_91_1.var_.characterEffect10079ui_story = var_94_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_11 = 0.200000002980232

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_11 and not isNil(var_94_10) then
				if arg_91_1.var_.characterEffect10079ui_story and not isNil(var_94_10) then
					arg_91_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_91_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_11)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_11 and arg_91_1.time_ < 0 + var_94_11 + arg_94_0 and not isNil(var_94_10) and arg_91_1.var_.characterEffect10079ui_story then
				arg_91_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_91_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_94_12 = 0
			local var_94_13 = 0.85

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_12 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_14 = arg_91_1:GetWordFromCfg(319051022)
				local var_94_15 = arg_91_1:FormatText(var_94_14.content)

				arg_91_1.text_.text = var_94_15

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_17 = 34 <= 0 and var_94_13 or var_94_13 * (utf8.len(var_94_15) / 34)

				if (34 <= 0 and var_94_13 or var_94_13 * (utf8.len(var_94_15) / 34)) > 0 and var_94_13 < var_94_17 then
					arg_91_1.talkMaxDuration = var_94_17

					if var_94_17 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_17 + var_94_12
					end
				end

				arg_91_1.text_.text = var_94_15
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051022", "story_v_out_319051.awb") ~= 0 then
					local var_94_18 = manager.audio:GetVoiceLength("story_v_out_319051", "319051022", "story_v_out_319051.awb") / 1000

					if var_94_18 + var_94_12 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_18 + var_94_12
					end

					if var_94_14.prefab_name ~= "" and arg_91_1.actors_[var_94_14.prefab_name] ~= nil then
						local var_94_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_14.prefab_name].transform, "story_v_out_319051", "319051022", "story_v_out_319051.awb")

						arg_91_1:RecordAudio("319051022", var_94_19)
						arg_91_1:RecordAudio("319051022", var_94_19)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_319051", "319051022", "story_v_out_319051.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_319051", "319051022", "story_v_out_319051.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_20 = math.max(var_94_13, arg_91_1.talkMaxDuration)

			if var_94_12 <= arg_91_1.time_ and arg_91_1.time_ < var_94_12 + var_94_20 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_12) / var_94_20

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_12 + var_94_20 and arg_91_1.time_ < var_94_12 + var_94_20 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play319051023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 319051023
		arg_95_1.duration_ = 13.6

		local var_95_0 = {
			zh = 10.033,
			ja = 13.6
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
				arg_95_0:Play319051024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1.var_.moveOldPos10066ui_story = arg_95_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_98_0 = 0.001

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 then
				arg_95_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_95_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_95_1.time_ - 0) / var_98_0)
				arg_95_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10066ui_story"].transform.position).z)
				arg_95_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10066ui_story"].transform.localEulerAngles = arg_95_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 then
				arg_95_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_95_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_95_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_95_1.actors_["10066ui_story"].transform.position).z)
				arg_95_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_95_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_95_1.actors_["10066ui_story"].transform.localEulerAngles = arg_95_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_98_1 = arg_95_1.actors_["10066ui_story"]

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10066ui_story == nil then
				arg_95_1.var_.characterEffect10066ui_story = var_98_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_2 = 0.200000002980232

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_2 and not isNil(var_98_1) then
				if arg_95_1.var_.characterEffect10066ui_story and not isNil(var_98_1) then
					arg_95_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_2 and arg_95_1.time_ < 0 + var_98_2 + arg_98_0 and not isNil(var_98_1) and arg_95_1.var_.characterEffect10066ui_story then
				arg_95_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066actionlink/10066action454")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_98_4 = 0
			local var_98_5 = 1.2

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_4 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_6 = arg_95_1:GetWordFromCfg(319051023)
				local var_98_7 = arg_95_1:FormatText(var_98_6.content)

				arg_95_1.text_.text = var_98_7

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_9 = 48 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 48)

				if (48 <= 0 and var_98_5 or var_98_5 * (utf8.len(var_98_7) / 48)) > 0 and var_98_5 < var_98_9 then
					arg_95_1.talkMaxDuration = var_98_9

					if var_98_9 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_9 + var_98_4
					end
				end

				arg_95_1.text_.text = var_98_7
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051023", "story_v_out_319051.awb") ~= 0 then
					local var_98_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051023", "story_v_out_319051.awb") / 1000

					if var_98_10 + var_98_4 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_10 + var_98_4
					end

					if var_98_6.prefab_name ~= "" and arg_95_1.actors_[var_98_6.prefab_name] ~= nil then
						local var_98_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_6.prefab_name].transform, "story_v_out_319051", "319051023", "story_v_out_319051.awb")

						arg_95_1:RecordAudio("319051023", var_98_11)
						arg_95_1:RecordAudio("319051023", var_98_11)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_319051", "319051023", "story_v_out_319051.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_319051", "319051023", "story_v_out_319051.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_12 = math.max(var_98_5, arg_95_1.talkMaxDuration)

			if var_98_4 <= arg_95_1.time_ and arg_95_1.time_ < var_98_4 + var_98_12 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_4) / var_98_12

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_4 + var_98_12 and arg_95_1.time_ < var_98_4 + var_98_12 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {
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

		arg_95_1:InitPlayNodeList()
	end,
	Play319051024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 319051024
		arg_99_1.duration_ = 2.63

		local var_99_0 = {
			zh = 1.999999999999,
			ja = 2.633
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
				arg_99_0:Play319051025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1095ui_story = arg_99_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1095ui_story"].transform.position).z)
				arg_99_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1095ui_story"].transform.localEulerAngles = arg_99_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_99_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1095ui_story"].transform.position).z)
				arg_99_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1095ui_story"].transform.localEulerAngles = arg_99_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1095ui_story"]

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1095ui_story == nil then
				arg_99_1.var_.characterEffect1095ui_story = var_102_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_102_2 = 0.200000002980232

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 and not isNil(var_102_1) then
				if arg_99_1.var_.characterEffect1095ui_story and not isNil(var_102_1) then
					arg_99_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 and not isNil(var_102_1) and arg_99_1.var_.characterEffect1095ui_story then
				arg_99_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_102_4 = arg_99_1.actors_["10066ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos10066ui_story = var_102_4.localPosition
			end

			local var_102_5 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_5 then
				var_102_4.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_5)
				var_102_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_4.position).x, (manager.ui.mainCamera.transform.position - var_102_4.position).y, (manager.ui.mainCamera.transform.position - var_102_4.position).z)
				var_102_4.localEulerAngles.z = 0
				var_102_4.localEulerAngles.x = 0
				var_102_4.localEulerAngles = var_102_4.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_5 and arg_99_1.time_ < 0 + var_102_5 + arg_102_0 then
				var_102_4.localPosition = Vector3.New(0, 100, 0)
				var_102_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_4.position).x, (manager.ui.mainCamera.transform.position - var_102_4.position).y, (manager.ui.mainCamera.transform.position - var_102_4.position).z)
				var_102_4.localEulerAngles.z = 0
				var_102_4.localEulerAngles.x = 0
				var_102_4.localEulerAngles = var_102_4.localEulerAngles
			end

			local var_102_6 = 0
			local var_102_7 = 0.075

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_6 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, true)

				arg_99_1.leftNameTxt_.text = arg_99_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_99_1.leftNameTxt_.transform)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1.leftNameTxt_.text)
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_8 = arg_99_1:GetWordFromCfg(319051024)
				local var_102_9 = arg_99_1:FormatText(var_102_8.content)

				arg_99_1.text_.text = var_102_9

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_11 = 3 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 3)

				if (3 <= 0 and var_102_7 or var_102_7 * (utf8.len(var_102_9) / 3)) > 0 and var_102_7 < var_102_11 then
					arg_99_1.talkMaxDuration = var_102_11

					if var_102_11 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_11 + var_102_6
					end
				end

				arg_99_1.text_.text = var_102_9
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051024", "story_v_out_319051.awb") ~= 0 then
					local var_102_12 = manager.audio:GetVoiceLength("story_v_out_319051", "319051024", "story_v_out_319051.awb") / 1000

					if var_102_12 + var_102_6 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_12 + var_102_6
					end

					if var_102_8.prefab_name ~= "" and arg_99_1.actors_[var_102_8.prefab_name] ~= nil then
						local var_102_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_99_1.actors_[var_102_8.prefab_name].transform, "story_v_out_319051", "319051024", "story_v_out_319051.awb")

						arg_99_1:RecordAudio("319051024", var_102_13)
						arg_99_1:RecordAudio("319051024", var_102_13)
					else
						arg_99_1:AudioAction("play", "voice", "story_v_out_319051", "319051024", "story_v_out_319051.awb")
					end

					arg_99_1:RecordHistoryTalkVoice("story_v_out_319051", "319051024", "story_v_out_319051.awb")
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
				actorName = "1095ui_story",
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

		arg_99_1:InitPlayNodeList()
	end,
	Play319051025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 319051025
		arg_103_1.duration_ = 5

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play319051026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(arg_103_1.actors_["1095ui_story"]) and arg_103_1.var_.characterEffect1095ui_story == nil then
				arg_103_1.var_.characterEffect1095ui_story = arg_103_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_0 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 and not isNil(arg_103_1.actors_["1095ui_story"]) then
				if arg_103_1.var_.characterEffect1095ui_story and not isNil(arg_103_1.actors_["1095ui_story"]) then
					arg_103_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_103_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_103_1.time_ - 0) / var_106_0)
				end
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 and not isNil(arg_103_1.actors_["1095ui_story"]) and arg_103_1.var_.characterEffect1095ui_story then
				arg_103_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_103_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_106_1 = 0
			local var_106_2 = 1.475

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_1 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, false)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_3 = arg_103_1:FormatText(arg_103_1:GetWordFromCfg(319051025).content)

				arg_103_1.text_.text = var_106_3

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_5 = 59 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 59)

				if (59 <= 0 and var_106_2 or var_106_2 * (utf8.len(var_106_3) / 59)) > 0 and var_106_2 < var_106_5 then
					arg_103_1.talkMaxDuration = var_106_5

					if var_106_5 + var_106_1 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_5 + var_106_1
					end
				end

				arg_103_1.text_.text = var_106_3
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)
				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_6 = math.max(var_106_2, arg_103_1.talkMaxDuration)

			if var_106_1 <= arg_103_1.time_ and arg_103_1.time_ < var_106_1 + var_106_6 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_1) / var_106_6

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_1 + var_106_6 and arg_103_1.time_ < var_106_1 + var_106_6 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {}

		arg_103_1:InitPlayNodeList()
	end,
	Play319051026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 319051026
		arg_107_1.duration_ = 14.5

		local var_107_0 = {
			zh = 8.433,
			ja = 14.5
		}
		local var_107_1 = manager.audio:GetLocalizationFlag()

		if var_107_0[var_107_1] ~= nil then
			arg_107_1.duration_ = var_107_0[var_107_1]
		end

		SetActive(arg_107_1.tipsGo_, false)

		function arg_107_1.onSingleLineFinish_()
			arg_107_1.onSingleLineUpdate_ = nil
			arg_107_1.onSingleLineFinish_ = nil
			arg_107_1.state_ = "waiting"
		end

		function arg_107_1.playNext_(arg_109_0)
			if arg_109_0 == 1 then
				arg_107_0:Play319051027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["10079ui_story"]) and arg_107_1.var_.characterEffect10079ui_story == nil then
				arg_107_1.var_.characterEffect10079ui_story = arg_107_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["10079ui_story"]) then
				if arg_107_1.var_.characterEffect10079ui_story and not isNil(arg_107_1.actors_["10079ui_story"]) then
					arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["10079ui_story"]) and arg_107_1.var_.characterEffect10079ui_story then
				arg_107_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_110_2 = arg_107_1.actors_["10079ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos10079ui_story = var_110_2.localPosition
			end

			local var_110_3 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_3 then
				var_110_2.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_107_1.time_ - 0) / var_110_3)
				var_110_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_2.position).x, (manager.ui.mainCamera.transform.position - var_110_2.position).y, (manager.ui.mainCamera.transform.position - var_110_2.position).z)
				var_110_2.localEulerAngles.z = 0
				var_110_2.localEulerAngles.x = 0
				var_110_2.localEulerAngles = var_110_2.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_3 and arg_107_1.time_ < 0 + var_110_3 + arg_110_0 then
				var_110_2.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_110_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_2.position).x, (manager.ui.mainCamera.transform.position - var_110_2.position).y, (manager.ui.mainCamera.transform.position - var_110_2.position).z)
				var_110_2.localEulerAngles.z = 0
				var_110_2.localEulerAngles.x = 0
				var_110_2.localEulerAngles = var_110_2.localEulerAngles
			end

			local var_110_4 = arg_107_1.actors_["1095ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1095ui_story = var_110_4.localPosition
			end

			local var_110_5 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_5 then
				var_110_4.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_107_1.time_ - 0) / var_110_5)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_5 and arg_107_1.time_ < 0 + var_110_5 + arg_110_0 then
				var_110_4.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				var_110_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_4.position).x, (manager.ui.mainCamera.transform.position - var_110_4.position).y, (manager.ui.mainCamera.transform.position - var_110_4.position).z)
				var_110_4.localEulerAngles.z = 0
				var_110_4.localEulerAngles.x = 0
				var_110_4.localEulerAngles = var_110_4.localEulerAngles
			end

			local var_110_6 = arg_107_1.actors_["1095ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1095ui_story == nil then
				arg_107_1.var_.characterEffect1095ui_story = var_110_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_7 = 0.200000002980232

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_7 and not isNil(var_110_6) then
				if arg_107_1.var_.characterEffect1095ui_story and not isNil(var_110_6) then
					arg_107_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_7)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_7 and arg_107_1.time_ < 0 + var_110_7 + arg_110_0 and not isNil(var_110_6) and arg_107_1.var_.characterEffect1095ui_story then
				arg_107_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_110_8 = 0
			local var_110_9 = 1.025

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_8 + arg_110_0 then
				arg_107_1.talkMaxDuration = 0
				arg_107_1.dialogCg_.alpha = 1

				arg_107_1.dialog_:SetActive(true)
				SetActive(arg_107_1.leftNameGo_, true)

				arg_107_1.leftNameTxt_.text = arg_107_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_107_1.leftNameTxt_.transform)

				arg_107_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_107_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_107_1:RecordName(arg_107_1.leftNameTxt_.text)
				SetActive(arg_107_1.iconTrs_.gameObject, false)
				arg_107_1.callingController_:SetSelectedState("normal")

				local var_110_10 = arg_107_1:GetWordFromCfg(319051026)
				local var_110_11 = arg_107_1:FormatText(var_110_10.content)

				arg_107_1.text_.text = var_110_11

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_13 = 41 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 41)

				if (41 <= 0 and var_110_9 or var_110_9 * (utf8.len(var_110_11) / 41)) > 0 and var_110_9 < var_110_13 then
					arg_107_1.talkMaxDuration = var_110_13

					if var_110_13 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_13 + var_110_8
					end
				end

				arg_107_1.text_.text = var_110_11
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051026", "story_v_out_319051.awb") ~= 0 then
					local var_110_14 = manager.audio:GetVoiceLength("story_v_out_319051", "319051026", "story_v_out_319051.awb") / 1000

					if var_110_14 + var_110_8 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_14 + var_110_8
					end

					if var_110_10.prefab_name ~= "" and arg_107_1.actors_[var_110_10.prefab_name] ~= nil then
						local var_110_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_10.prefab_name].transform, "story_v_out_319051", "319051026", "story_v_out_319051.awb")

						arg_107_1:RecordAudio("319051026", var_110_15)
						arg_107_1:RecordAudio("319051026", var_110_15)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_319051", "319051026", "story_v_out_319051.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_319051", "319051026", "story_v_out_319051.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_16 = math.max(var_110_9, arg_107_1.talkMaxDuration)

			if var_110_8 <= arg_107_1.time_ and arg_107_1.time_ < var_110_8 + var_110_16 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_8) / var_110_16

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_8 + var_110_16 and arg_107_1.time_ < var_110_8 + var_110_16 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_107_1:InitPlayNodeList()
	end,
	Play319051027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 319051027
		arg_111_1.duration_ = 5

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play319051028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["10079ui_story"]) and arg_111_1.var_.characterEffect10079ui_story == nil then
				arg_111_1.var_.characterEffect10079ui_story = arg_111_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.200000002980232

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["10079ui_story"]) then
				if arg_111_1.var_.characterEffect10079ui_story and not isNil(arg_111_1.actors_["10079ui_story"]) then
					arg_111_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["10079ui_story"]) and arg_111_1.var_.characterEffect10079ui_story then
				arg_111_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_114_1 = 0
			local var_114_2 = 1.075

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, false)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_3 = arg_111_1:FormatText(arg_111_1:GetWordFromCfg(319051027).content)

				arg_111_1.text_.text = var_114_3

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_5 = 43 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 43)

				if (43 <= 0 and var_114_2 or var_114_2 * (utf8.len(var_114_3) / 43)) > 0 and var_114_2 < var_114_5 then
					arg_111_1.talkMaxDuration = var_114_5

					if var_114_5 + var_114_1 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_5 + var_114_1
					end
				end

				arg_111_1.text_.text = var_114_3
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)
				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_6 = math.max(var_114_2, arg_111_1.talkMaxDuration)

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_6 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_1) / var_114_6

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_1 + var_114_6 and arg_111_1.time_ < var_114_1 + var_114_6 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play319051028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 319051028
		arg_115_1.duration_ = 7.43

		local var_115_0 = {
			zh = 4.1,
			ja = 7.433
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
				arg_115_0:Play319051029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 and not isNil(arg_115_1.actors_["1095ui_story"]) and arg_115_1.var_.characterEffect1095ui_story == nil then
				arg_115_1.var_.characterEffect1095ui_story = arg_115_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_0 = 0.200000002980232

			if 0 <= arg_115_1.time_ and arg_115_1.time_ < 0 + var_118_0 and not isNil(arg_115_1.actors_["1095ui_story"]) then
				if arg_115_1.var_.characterEffect1095ui_story and not isNil(arg_115_1.actors_["1095ui_story"]) then
					arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_115_1.time_ >= 0 + var_118_0 and arg_115_1.time_ < 0 + var_118_0 + arg_118_0 and not isNil(arg_115_1.actors_["1095ui_story"]) and arg_115_1.var_.characterEffect1095ui_story then
				arg_115_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_2")
			end

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_118_2 = 0
			local var_118_3 = 0.525

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_2 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_4 = arg_115_1:GetWordFromCfg(319051028)
				local var_118_5 = arg_115_1:FormatText(var_118_4.content)

				arg_115_1.text_.text = var_118_5

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_7 = 21 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 21)

				if (21 <= 0 and var_118_3 or var_118_3 * (utf8.len(var_118_5) / 21)) > 0 and var_118_3 < var_118_7 then
					arg_115_1.talkMaxDuration = var_118_7

					if var_118_7 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_7 + var_118_2
					end
				end

				arg_115_1.text_.text = var_118_5
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051028", "story_v_out_319051.awb") ~= 0 then
					local var_118_8 = manager.audio:GetVoiceLength("story_v_out_319051", "319051028", "story_v_out_319051.awb") / 1000

					if var_118_8 + var_118_2 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_8 + var_118_2
					end

					if var_118_4.prefab_name ~= "" and arg_115_1.actors_[var_118_4.prefab_name] ~= nil then
						local var_118_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_4.prefab_name].transform, "story_v_out_319051", "319051028", "story_v_out_319051.awb")

						arg_115_1:RecordAudio("319051028", var_118_9)
						arg_115_1:RecordAudio("319051028", var_118_9)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_319051", "319051028", "story_v_out_319051.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_319051", "319051028", "story_v_out_319051.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_10 = math.max(var_118_3, arg_115_1.talkMaxDuration)

			if var_118_2 <= arg_115_1.time_ and arg_115_1.time_ < var_118_2 + var_118_10 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_2) / var_118_10

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_2 + var_118_10 and arg_115_1.time_ < var_118_2 + var_118_10 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play319051029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 319051029
		arg_119_1.duration_ = 8

		local var_119_0 = {
			zh = 3.766,
			ja = 8
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
				arg_119_0:Play319051030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10066ui_story = arg_119_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_122_0 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_0 then
				arg_119_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_119_1.time_ - 0) / var_122_0)
				arg_119_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10066ui_story"].transform.position).z)
				arg_119_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10066ui_story"].transform.localEulerAngles = arg_119_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_0 and arg_119_1.time_ < 0 + var_122_0 + arg_122_0 then
				arg_119_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_119_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_119_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_119_1.actors_["10066ui_story"].transform.position).z)
				arg_119_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_119_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_119_1.actors_["10066ui_story"].transform.localEulerAngles = arg_119_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_122_1 = arg_119_1.actors_["10066ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10066ui_story == nil then
				arg_119_1.var_.characterEffect10066ui_story = var_122_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_2 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_2 and not isNil(var_122_1) then
				if arg_119_1.var_.characterEffect10066ui_story and not isNil(var_122_1) then
					arg_119_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_119_1.time_ >= 0 + var_122_2 and arg_119_1.time_ < 0 + var_122_2 + arg_122_0 and not isNil(var_122_1) and arg_119_1.var_.characterEffect10066ui_story then
				arg_119_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action4_2")
			end

			local var_122_4 = arg_119_1.actors_["1095ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos1095ui_story = var_122_4.localPosition
			end

			local var_122_5 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_5 then
				var_122_4.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_5)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_5 and arg_119_1.time_ < 0 + var_122_5 + arg_122_0 then
				var_122_4.localPosition = Vector3.New(0, 100, 0)
				var_122_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_4.position).x, (manager.ui.mainCamera.transform.position - var_122_4.position).y, (manager.ui.mainCamera.transform.position - var_122_4.position).z)
				var_122_4.localEulerAngles.z = 0
				var_122_4.localEulerAngles.x = 0
				var_122_4.localEulerAngles = var_122_4.localEulerAngles
			end

			local var_122_6 = arg_119_1.actors_["1095ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1095ui_story == nil then
				arg_119_1.var_.characterEffect1095ui_story = var_122_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_7 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_7 and not isNil(var_122_6) then
				if arg_119_1.var_.characterEffect1095ui_story and not isNil(var_122_6) then
					arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_119_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_7)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_7 and arg_119_1.time_ < 0 + var_122_7 + arg_122_0 and not isNil(var_122_6) and arg_119_1.var_.characterEffect1095ui_story then
				arg_119_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_119_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_122_8 = arg_119_1.actors_["10079ui_story"].transform

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1.var_.moveOldPos10079ui_story = var_122_8.localPosition
			end

			local var_122_9 = 0.001

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_9 then
				var_122_8.localPosition = Vector3.Lerp(arg_119_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_119_1.time_ - 0) / var_122_9)
				var_122_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_8.position).x, (manager.ui.mainCamera.transform.position - var_122_8.position).y, (manager.ui.mainCamera.transform.position - var_122_8.position).z)
				var_122_8.localEulerAngles.z = 0
				var_122_8.localEulerAngles.x = 0
				var_122_8.localEulerAngles = var_122_8.localEulerAngles
			end

			if arg_119_1.time_ >= 0 + var_122_9 and arg_119_1.time_ < 0 + var_122_9 + arg_122_0 then
				var_122_8.localPosition = Vector3.New(0, 100, 0)
				var_122_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_122_8.position).x, (manager.ui.mainCamera.transform.position - var_122_8.position).y, (manager.ui.mainCamera.transform.position - var_122_8.position).z)
				var_122_8.localEulerAngles.z = 0
				var_122_8.localEulerAngles.x = 0
				var_122_8.localEulerAngles = var_122_8.localEulerAngles
			end

			local var_122_10 = arg_119_1.actors_["10079ui_story"]

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 and not isNil(var_122_10) and arg_119_1.var_.characterEffect10079ui_story == nil then
				arg_119_1.var_.characterEffect10079ui_story = var_122_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_122_11 = 0.200000002980232

			if 0 <= arg_119_1.time_ and arg_119_1.time_ < 0 + var_122_11 and not isNil(var_122_10) then
				if arg_119_1.var_.characterEffect10079ui_story and not isNil(var_122_10) then
					arg_119_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_119_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_119_1.time_ - 0) / var_122_11)
				end
			end

			if arg_119_1.time_ >= 0 + var_122_11 and arg_119_1.time_ < 0 + var_122_11 + arg_122_0 and not isNil(var_122_10) and arg_119_1.var_.characterEffect10079ui_story then
				arg_119_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_119_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_122_12 = 0
			local var_122_13 = 0.375

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_12 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_14 = arg_119_1:GetWordFromCfg(319051029)
				local var_122_15 = arg_119_1:FormatText(var_122_14.content)

				arg_119_1.text_.text = var_122_15

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_17 = 15 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_15) / 15)

				if (15 <= 0 and var_122_13 or var_122_13 * (utf8.len(var_122_15) / 15)) > 0 and var_122_13 < var_122_17 then
					arg_119_1.talkMaxDuration = var_122_17

					if var_122_17 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_17 + var_122_12
					end
				end

				arg_119_1.text_.text = var_122_15
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051029", "story_v_out_319051.awb") ~= 0 then
					local var_122_18 = manager.audio:GetVoiceLength("story_v_out_319051", "319051029", "story_v_out_319051.awb") / 1000

					if var_122_18 + var_122_12 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_18 + var_122_12
					end

					if var_122_14.prefab_name ~= "" and arg_119_1.actors_[var_122_14.prefab_name] ~= nil then
						local var_122_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_14.prefab_name].transform, "story_v_out_319051", "319051029", "story_v_out_319051.awb")

						arg_119_1:RecordAudio("319051029", var_122_19)
						arg_119_1:RecordAudio("319051029", var_122_19)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_319051", "319051029", "story_v_out_319051.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_319051", "319051029", "story_v_out_319051.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_20 = math.max(var_122_13, arg_119_1.talkMaxDuration)

			if var_122_12 <= arg_119_1.time_ and arg_119_1.time_ < var_122_12 + var_122_20 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_12) / var_122_20

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_12 + var_122_20 and arg_119_1.time_ < var_122_12 + var_122_20 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_119_1:InitPlayNodeList()
	end,
	Play319051030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 319051030
		arg_123_1.duration_ = 6.63

		local var_123_0 = {
			zh = 3.066,
			ja = 6.633
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
				arg_123_0:Play319051031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos1095ui_story = arg_123_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_126_0 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_0 then
				arg_123_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos1095ui_story, Vector3.New(-0.7, -0.98, -6.1), (arg_123_1.time_ - 0) / var_126_0)
				arg_123_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1095ui_story"].transform.position).z)
				arg_123_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1095ui_story"].transform.localEulerAngles = arg_123_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_0 and arg_123_1.time_ < 0 + var_126_0 + arg_126_0 then
				arg_123_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(-0.7, -0.98, -6.1)
				arg_123_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_123_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_123_1.actors_["1095ui_story"].transform.position).z)
				arg_123_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_123_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_123_1.actors_["1095ui_story"].transform.localEulerAngles = arg_123_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_126_1 = arg_123_1.actors_["1095ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1095ui_story == nil then
				arg_123_1.var_.characterEffect1095ui_story = var_126_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_2 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_2 and not isNil(var_126_1) then
				if arg_123_1.var_.characterEffect1095ui_story and not isNil(var_126_1) then
					arg_123_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_2)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_2 and arg_123_1.time_ < 0 + var_126_2 + arg_126_0 and not isNil(var_126_1) and arg_123_1.var_.characterEffect1095ui_story then
				arg_123_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_126_3 = arg_123_1.actors_["10079ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10079ui_story = var_126_3.localPosition
			end

			local var_126_4 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 then
				var_126_3.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_123_1.time_ - 0) / var_126_4)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 then
				var_126_3.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_126_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_3.position).x, (manager.ui.mainCamera.transform.position - var_126_3.position).y, (manager.ui.mainCamera.transform.position - var_126_3.position).z)
				var_126_3.localEulerAngles.z = 0
				var_126_3.localEulerAngles.x = 0
				var_126_3.localEulerAngles = var_126_3.localEulerAngles
			end

			local var_126_5 = arg_123_1.actors_["10079ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect10079ui_story == nil then
				arg_123_1.var_.characterEffect10079ui_story = var_126_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_6 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_6 and not isNil(var_126_5) then
				if arg_123_1.var_.characterEffect10079ui_story and not isNil(var_126_5) then
					arg_123_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_6 and arg_123_1.time_ < 0 + var_126_6 + arg_126_0 and not isNil(var_126_5) and arg_123_1.var_.characterEffect10079ui_story then
				arg_123_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_126_8 = arg_123_1.actors_["10066ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10066ui_story = var_126_8.localPosition
			end

			local var_126_9 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_9 then
				var_126_8.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_9)
				var_126_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_8.position).x, (manager.ui.mainCamera.transform.position - var_126_8.position).y, (manager.ui.mainCamera.transform.position - var_126_8.position).z)
				var_126_8.localEulerAngles.z = 0
				var_126_8.localEulerAngles.x = 0
				var_126_8.localEulerAngles = var_126_8.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_9 and arg_123_1.time_ < 0 + var_126_9 + arg_126_0 then
				var_126_8.localPosition = Vector3.New(0, 100, 0)
				var_126_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_8.position).x, (manager.ui.mainCamera.transform.position - var_126_8.position).y, (manager.ui.mainCamera.transform.position - var_126_8.position).z)
				var_126_8.localEulerAngles.z = 0
				var_126_8.localEulerAngles.x = 0
				var_126_8.localEulerAngles = var_126_8.localEulerAngles
			end

			local var_126_10 = arg_123_1.actors_["10066ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_10) and arg_123_1.var_.characterEffect10066ui_story == nil then
				arg_123_1.var_.characterEffect10066ui_story = var_126_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_11 = 0.200000002980232

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_11 and not isNil(var_126_10) then
				if arg_123_1.var_.characterEffect10066ui_story and not isNil(var_126_10) then
					arg_123_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_123_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_11)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_11 and arg_123_1.time_ < 0 + var_126_11 + arg_126_0 and not isNil(var_126_10) and arg_123_1.var_.characterEffect10066ui_story then
				arg_123_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_123_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			local var_126_12 = arg_123_1.actors_["10066ui_story"].transform

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1.var_.moveOldPos10066ui_story = var_126_12.localPosition
			end

			local var_126_13 = 0.001

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_13 then
				var_126_12.localPosition = Vector3.Lerp(arg_123_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_123_1.time_ - 0) / var_126_13)
				var_126_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_12.position).x, (manager.ui.mainCamera.transform.position - var_126_12.position).y, (manager.ui.mainCamera.transform.position - var_126_12.position).z)
				var_126_12.localEulerAngles.z = 0
				var_126_12.localEulerAngles.x = 0
				var_126_12.localEulerAngles = var_126_12.localEulerAngles
			end

			if arg_123_1.time_ >= 0 + var_126_13 and arg_123_1.time_ < 0 + var_126_13 + arg_126_0 then
				var_126_12.localPosition = Vector3.New(0, 100, 0)
				var_126_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_126_12.position).x, (manager.ui.mainCamera.transform.position - var_126_12.position).y, (manager.ui.mainCamera.transform.position - var_126_12.position).z)
				var_126_12.localEulerAngles.z = 0
				var_126_12.localEulerAngles.x = 0
				var_126_12.localEulerAngles = var_126_12.localEulerAngles
			end

			local var_126_14 = 0
			local var_126_15 = 0.3

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_14 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, true)

				arg_123_1.leftNameTxt_.text = arg_123_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_123_1.leftNameTxt_.transform)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1.leftNameTxt_.text)
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_16 = arg_123_1:GetWordFromCfg(319051030)
				local var_126_17 = arg_123_1:FormatText(var_126_16.content)

				arg_123_1.text_.text = var_126_17

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_19 = 12 <= 0 and var_126_15 or var_126_15 * (utf8.len(var_126_17) / 12)

				if (12 <= 0 and var_126_15 or var_126_15 * (utf8.len(var_126_17) / 12)) > 0 and var_126_15 < var_126_19 then
					arg_123_1.talkMaxDuration = var_126_19

					if var_126_19 + var_126_14 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_19 + var_126_14
					end
				end

				arg_123_1.text_.text = var_126_17
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051030", "story_v_out_319051.awb") ~= 0 then
					local var_126_20 = manager.audio:GetVoiceLength("story_v_out_319051", "319051030", "story_v_out_319051.awb") / 1000

					if var_126_20 + var_126_14 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_20 + var_126_14
					end

					if var_126_16.prefab_name ~= "" and arg_123_1.actors_[var_126_16.prefab_name] ~= nil then
						local var_126_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_16.prefab_name].transform, "story_v_out_319051", "319051030", "story_v_out_319051.awb")

						arg_123_1:RecordAudio("319051030", var_126_21)
						arg_123_1:RecordAudio("319051030", var_126_21)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_319051", "319051030", "story_v_out_319051.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_319051", "319051030", "story_v_out_319051.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_22 = math.max(var_126_15, arg_123_1.talkMaxDuration)

			if var_126_14 <= arg_123_1.time_ and arg_123_1.time_ < var_126_14 + var_126_22 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_14) / var_126_22

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_14 + var_126_22 and arg_123_1.time_ < var_126_14 + var_126_22 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
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
				actorName = "10066ui_story",
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
	Play319051031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319051031
		arg_127_1.duration_ = 6.7

		local var_127_0 = {
			zh = 5.833,
			ja = 6.7
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
				arg_127_0:Play319051032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["10079ui_story"]) and arg_127_1.var_.characterEffect10079ui_story == nil then
				arg_127_1.var_.characterEffect10079ui_story = arg_127_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["10079ui_story"]) then
				if arg_127_1.var_.characterEffect10079ui_story and not isNil(arg_127_1.actors_["10079ui_story"]) then
					arg_127_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_127_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["10079ui_story"]) and arg_127_1.var_.characterEffect10079ui_story then
				arg_127_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_127_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_130_1 = arg_127_1.actors_["1095ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1095ui_story == nil then
				arg_127_1.var_.characterEffect1095ui_story = var_130_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_2 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 and not isNil(var_130_1) then
				if arg_127_1.var_.characterEffect1095ui_story and not isNil(var_130_1) then
					arg_127_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 and not isNil(var_130_1) and arg_127_1.var_.characterEffect1095ui_story then
				arg_127_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_130_4 = 0
			local var_130_5 = 0.775

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_6 = arg_127_1:GetWordFromCfg(319051031)
				local var_130_7 = arg_127_1:FormatText(var_130_6.content)

				arg_127_1.text_.text = var_130_7

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_9 = 31 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 31)

				if (31 <= 0 and var_130_5 or var_130_5 * (utf8.len(var_130_7) / 31)) > 0 and var_130_5 < var_130_9 then
					arg_127_1.talkMaxDuration = var_130_9

					if var_130_9 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_9 + var_130_4
					end
				end

				arg_127_1.text_.text = var_130_7
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051031", "story_v_out_319051.awb") ~= 0 then
					local var_130_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051031", "story_v_out_319051.awb") / 1000

					if var_130_10 + var_130_4 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_10 + var_130_4
					end

					if var_130_6.prefab_name ~= "" and arg_127_1.actors_[var_130_6.prefab_name] ~= nil then
						local var_130_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_6.prefab_name].transform, "story_v_out_319051", "319051031", "story_v_out_319051.awb")

						arg_127_1:RecordAudio("319051031", var_130_11)
						arg_127_1:RecordAudio("319051031", var_130_11)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_319051", "319051031", "story_v_out_319051.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_319051", "319051031", "story_v_out_319051.awb")
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
	Play319051032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319051032
		arg_131_1.duration_ = 2.77

		local var_131_0 = {
			zh = 1.999999999999,
			ja = 2.766
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
				arg_131_0:Play319051033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["10079ui_story"]) and arg_131_1.var_.characterEffect10079ui_story == nil then
				arg_131_1.var_.characterEffect10079ui_story = arg_131_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["10079ui_story"]) then
				if arg_131_1.var_.characterEffect10079ui_story and not isNil(arg_131_1.actors_["10079ui_story"]) then
					arg_131_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["10079ui_story"]) and arg_131_1.var_.characterEffect10079ui_story then
				arg_131_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_134_2 = arg_131_1.actors_["1095ui_story"]

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1095ui_story == nil then
				arg_131_1.var_.characterEffect1095ui_story = var_134_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_3 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_3 and not isNil(var_134_2) then
				if arg_131_1.var_.characterEffect1095ui_story and not isNil(var_134_2) then
					arg_131_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_3)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_3 and arg_131_1.time_ < 0 + var_134_3 + arg_134_0 and not isNil(var_134_2) and arg_131_1.var_.characterEffect1095ui_story then
				arg_131_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_134_4 = 0
			local var_134_5 = 0.075

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_4 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_6 = arg_131_1:GetWordFromCfg(319051032)
				local var_134_7 = arg_131_1:FormatText(var_134_6.content)

				arg_131_1.text_.text = var_134_7

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_9 = 3 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 3)

				if (3 <= 0 and var_134_5 or var_134_5 * (utf8.len(var_134_7) / 3)) > 0 and var_134_5 < var_134_9 then
					arg_131_1.talkMaxDuration = var_134_9

					if var_134_9 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_9 + var_134_4
					end
				end

				arg_131_1.text_.text = var_134_7
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051032", "story_v_out_319051.awb") ~= 0 then
					local var_134_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051032", "story_v_out_319051.awb") / 1000

					if var_134_10 + var_134_4 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_10 + var_134_4
					end

					if var_134_6.prefab_name ~= "" and arg_131_1.actors_[var_134_6.prefab_name] ~= nil then
						local var_134_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_6.prefab_name].transform, "story_v_out_319051", "319051032", "story_v_out_319051.awb")

						arg_131_1:RecordAudio("319051032", var_134_11)
						arg_131_1:RecordAudio("319051032", var_134_11)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319051", "319051032", "story_v_out_319051.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319051", "319051032", "story_v_out_319051.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_12 = math.max(var_134_5, arg_131_1.talkMaxDuration)

			if var_134_4 <= arg_131_1.time_ and arg_131_1.time_ < var_134_4 + var_134_12 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_4) / var_134_12

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_4 + var_134_12 and arg_131_1.time_ < var_134_4 + var_134_12 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319051033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319051033
		arg_135_1.duration_ = 9.3

		local var_135_0 = {
			zh = 6.4,
			ja = 9.3
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
				arg_135_0:Play319051034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.65

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:GetWordFromCfg(319051033)
				local var_138_2 = arg_135_1:FormatText(var_138_1.content)

				arg_135_1.text_.text = var_138_2

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_4 = 26 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 26)

				if (26 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_2) / 26)) > 0 and var_138_0 < var_138_4 then
					arg_135_1.talkMaxDuration = var_138_4

					if var_138_4 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_4 + 0
					end
				end

				arg_135_1.text_.text = var_138_2
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051033", "story_v_out_319051.awb") ~= 0 then
					local var_138_5 = manager.audio:GetVoiceLength("story_v_out_319051", "319051033", "story_v_out_319051.awb") / 1000

					if var_138_5 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_5 + 0
					end

					if var_138_1.prefab_name ~= "" and arg_135_1.actors_[var_138_1.prefab_name] ~= nil then
						local var_138_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_1.prefab_name].transform, "story_v_out_319051", "319051033", "story_v_out_319051.awb")

						arg_135_1:RecordAudio("319051033", var_138_6)
						arg_135_1:RecordAudio("319051033", var_138_6)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319051", "319051033", "story_v_out_319051.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319051", "319051033", "story_v_out_319051.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_7 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_7 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_7

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_7 and arg_135_1.time_ < 0 + var_138_7 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play319051034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319051034
		arg_139_1.duration_ = 11.9

		local var_139_0 = {
			zh = 4.066,
			ja = 11.9
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
				arg_139_0:Play319051035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["1095ui_story"]) and arg_139_1.var_.characterEffect1095ui_story == nil then
				arg_139_1.var_.characterEffect1095ui_story = arg_139_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["1095ui_story"]) then
				if arg_139_1.var_.characterEffect1095ui_story and not isNil(arg_139_1.actors_["1095ui_story"]) then
					arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["1095ui_story"]) and arg_139_1.var_.characterEffect1095ui_story then
				arg_139_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_142_2 = arg_139_1.actors_["10079ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.characterEffect10079ui_story == nil then
				arg_139_1.var_.characterEffect10079ui_story = var_142_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_3 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 and not isNil(var_142_2) then
				if arg_139_1.var_.characterEffect10079ui_story and not isNil(var_142_2) then
					arg_139_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_3)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 and not isNil(var_142_2) and arg_139_1.var_.characterEffect10079ui_story then
				arg_139_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_142_4 = 0
			local var_142_5 = 0.4

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:GetWordFromCfg(319051034)
				local var_142_7 = arg_139_1:FormatText(var_142_6.content)

				arg_139_1.text_.text = var_142_7

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_9 = 16 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 16)

				if (16 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_7) / 16)) > 0 and var_142_5 < var_142_9 then
					arg_139_1.talkMaxDuration = var_142_9

					if var_142_9 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_9 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_7
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051034", "story_v_out_319051.awb") ~= 0 then
					local var_142_10 = manager.audio:GetVoiceLength("story_v_out_319051", "319051034", "story_v_out_319051.awb") / 1000

					if var_142_10 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_10 + var_142_4
					end

					if var_142_6.prefab_name ~= "" and arg_139_1.actors_[var_142_6.prefab_name] ~= nil then
						local var_142_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_6.prefab_name].transform, "story_v_out_319051", "319051034", "story_v_out_319051.awb")

						arg_139_1:RecordAudio("319051034", var_142_11)
						arg_139_1:RecordAudio("319051034", var_142_11)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319051", "319051034", "story_v_out_319051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319051", "319051034", "story_v_out_319051.awb")
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
	Play319051035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319051035
		arg_143_1.duration_ = 8.2

		local var_143_0 = {
			zh = 5.633,
			ja = 8.2
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
				arg_143_0:Play319051036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10066ui_story = arg_143_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10066ui_story"].transform.position).z)
				arg_143_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10066ui_story"].transform.localEulerAngles = arg_143_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_143_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["10066ui_story"].transform.position).z)
				arg_143_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["10066ui_story"].transform.localEulerAngles = arg_143_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["10066ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10066ui_story == nil then
				arg_143_1.var_.characterEffect10066ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect10066ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect10066ui_story then
				arg_143_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_146_4 = arg_143_1.actors_["1095ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1095ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(0, 100, 0)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			local var_146_6 = arg_143_1.actors_["1095ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1095ui_story == nil then
				arg_143_1.var_.characterEffect1095ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 and not isNil(var_146_6) then
				if arg_143_1.var_.characterEffect1095ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_143_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_7)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect1095ui_story then
				arg_143_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_143_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_146_8 = arg_143_1.actors_["10079ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos10079ui_story = var_146_8.localPosition
			end

			local var_146_9 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_9 then
				var_146_8.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_9)
				var_146_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_8.position).x, (manager.ui.mainCamera.transform.position - var_146_8.position).y, (manager.ui.mainCamera.transform.position - var_146_8.position).z)
				var_146_8.localEulerAngles.z = 0
				var_146_8.localEulerAngles.x = 0
				var_146_8.localEulerAngles = var_146_8.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_9 and arg_143_1.time_ < 0 + var_146_9 + arg_146_0 then
				var_146_8.localPosition = Vector3.New(0, 100, 0)
				var_146_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_8.position).x, (manager.ui.mainCamera.transform.position - var_146_8.position).y, (manager.ui.mainCamera.transform.position - var_146_8.position).z)
				var_146_8.localEulerAngles.z = 0
				var_146_8.localEulerAngles.x = 0
				var_146_8.localEulerAngles = var_146_8.localEulerAngles
			end

			local var_146_10 = arg_143_1.actors_["10079ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_10) and arg_143_1.var_.characterEffect10079ui_story == nil then
				arg_143_1.var_.characterEffect10079ui_story = var_146_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_11 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_11 and not isNil(var_146_10) then
				if arg_143_1.var_.characterEffect10079ui_story and not isNil(var_146_10) then
					arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_11)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_11 and arg_143_1.time_ < 0 + var_146_11 + arg_146_0 and not isNil(var_146_10) and arg_143_1.var_.characterEffect10079ui_story then
				arg_143_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_1")
			end

			local var_146_12 = 0
			local var_146_13 = 0.45

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_12 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_14 = arg_143_1:GetWordFromCfg(319051035)
				local var_146_15 = arg_143_1:FormatText(var_146_14.content)

				arg_143_1.text_.text = var_146_15

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_17 = 18 <= 0 and var_146_13 or var_146_13 * (utf8.len(var_146_15) / 18)

				if (18 <= 0 and var_146_13 or var_146_13 * (utf8.len(var_146_15) / 18)) > 0 and var_146_13 < var_146_17 then
					arg_143_1.talkMaxDuration = var_146_17

					if var_146_17 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_17 + var_146_12
					end
				end

				arg_143_1.text_.text = var_146_15
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051035", "story_v_out_319051.awb") ~= 0 then
					local var_146_18 = manager.audio:GetVoiceLength("story_v_out_319051", "319051035", "story_v_out_319051.awb") / 1000

					if var_146_18 + var_146_12 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_18 + var_146_12
					end

					if var_146_14.prefab_name ~= "" and arg_143_1.actors_[var_146_14.prefab_name] ~= nil then
						local var_146_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_14.prefab_name].transform, "story_v_out_319051", "319051035", "story_v_out_319051.awb")

						arg_143_1:RecordAudio("319051035", var_146_19)
						arg_143_1:RecordAudio("319051035", var_146_19)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319051", "319051035", "story_v_out_319051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319051", "319051035", "story_v_out_319051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_20 = math.max(var_146_13, arg_143_1.talkMaxDuration)

			if var_146_12 <= arg_143_1.time_ and arg_143_1.time_ < var_146_12 + var_146_20 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_12) / var_146_20

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_12 + var_146_20 and arg_143_1.time_ < var_146_12 + var_146_20 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play319051036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319051036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play319051037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["10066ui_story"]) and arg_147_1.var_.characterEffect10066ui_story == nil then
				arg_147_1.var_.characterEffect10066ui_story = arg_147_1.actors_["10066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["10066ui_story"]) then
				if arg_147_1.var_.characterEffect10066ui_story and not isNil(arg_147_1.actors_["10066ui_story"]) then
					arg_147_1.var_.characterEffect10066ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["10066ui_story"]) and arg_147_1.var_.characterEffect10066ui_story then
				arg_147_1.var_.characterEffect10066ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10066ui_story.fillRatio = 0.5
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:AudioAction("play", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_150_2 = arg_147_1.actors_["10066ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos10066ui_story = var_150_2.localPosition
			end

			local var_150_3 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_3 then
				var_150_2.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10066ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_3)
				var_150_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_2.position).x, (manager.ui.mainCamera.transform.position - var_150_2.position).y, (manager.ui.mainCamera.transform.position - var_150_2.position).z)
				var_150_2.localEulerAngles.z = 0
				var_150_2.localEulerAngles.x = 0
				var_150_2.localEulerAngles = var_150_2.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_3 and arg_147_1.time_ < 0 + var_150_3 + arg_150_0 then
				var_150_2.localPosition = Vector3.New(0, 100, 0)
				var_150_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_2.position).x, (manager.ui.mainCamera.transform.position - var_150_2.position).y, (manager.ui.mainCamera.transform.position - var_150_2.position).z)
				var_150_2.localEulerAngles.z = 0
				var_150_2.localEulerAngles.x = 0
				var_150_2.localEulerAngles = var_150_2.localEulerAngles
			end

			local var_150_4 = 0

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_4 + arg_150_0 then
				arg_147_1.mask_.enabled = true
				arg_147_1.mask_.raycastTarget = false

				arg_147_1:SetGaussion(false)
			end

			local var_150_5 = 0.433333333333333

			if var_150_4 <= arg_147_1.time_ and arg_147_1.time_ < var_150_4 + var_150_5 then
				local var_150_6 = Color.New(1, 1, 1)

				var_150_6.a = Mathf.Lerp(1, 0, (arg_147_1.time_ - var_150_4) / var_150_5)
				arg_147_1.mask_.color = var_150_6
			end

			if arg_147_1.time_ >= var_150_4 + var_150_5 and arg_147_1.time_ < var_150_4 + var_150_5 + arg_150_0 then
				local var_150_7 = Color.New(1, 1, 1)

				arg_147_1.mask_.enabled = false
				var_150_7.a = 0
				arg_147_1.mask_.color = var_150_7
			end

			local var_150_8 = 0
			local var_150_9 = 1.425

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(319051036).content)

				arg_147_1.text_.text = var_150_10

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_12 = 57 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_10) / 57)

				if (57 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_10) / 57)) > 0 and var_150_9 < var_150_12 then
					arg_147_1.talkMaxDuration = var_150_12

					if var_150_12 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_10
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_13 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_13 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_13

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_13 and arg_147_1.time_ < var_150_8 + var_150_13 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play319051037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319051037
		arg_151_1.duration_ = 10.8

		local var_151_0 = {
			zh = 3.666,
			ja = 10.8
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
			arg_151_1.auto_ = false
		end

		function arg_151_1.playNext_(arg_153_0)
			arg_151_1.onStoryFinished_()
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1.var_.moveOldPos10066ui_story = arg_151_1.actors_["10066ui_story"].transform.localPosition
			end

			local var_154_0 = 0.001

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 then
				arg_151_1.actors_["10066ui_story"].transform.localPosition = Vector3.Lerp(arg_151_1.var_.moveOldPos10066ui_story, Vector3.New(0, -0.99, -5.83), (arg_151_1.time_ - 0) / var_154_0)
				arg_151_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10066ui_story"].transform.position).z)
				arg_151_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10066ui_story"].transform.localEulerAngles = arg_151_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 then
				arg_151_1.actors_["10066ui_story"].transform.localPosition = Vector3.New(0, -0.99, -5.83)
				arg_151_1.actors_["10066ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_151_1.actors_["10066ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10066ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_151_1.actors_["10066ui_story"].transform.position).z)
				arg_151_1.actors_["10066ui_story"].transform.localEulerAngles.z = 0
				arg_151_1.actors_["10066ui_story"].transform.localEulerAngles.x = 0
				arg_151_1.actors_["10066ui_story"].transform.localEulerAngles = arg_151_1.actors_["10066ui_story"].transform.localEulerAngles
			end

			local var_154_1 = arg_151_1.actors_["10066ui_story"]

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10066ui_story == nil then
				arg_151_1.var_.characterEffect10066ui_story = var_154_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_2 and not isNil(var_154_1) then
				if arg_151_1.var_.characterEffect10066ui_story and not isNil(var_154_1) then
					arg_151_1.var_.characterEffect10066ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_2 and arg_151_1.time_ < 0 + var_154_2 + arg_154_0 and not isNil(var_154_1) and arg_151_1.var_.characterEffect10066ui_story then
				arg_151_1.var_.characterEffect10066ui_story.fillFlat = false
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/story10066/story10066action/10066action3_2")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:PlayTimeline("10066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 then
				arg_151_1:AudioAction("stop", "effect", "se_story_130", "se_story_130_didi", "")
			end

			local var_154_5 = 0
			local var_154_6 = 0.375

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_5 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[640].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_7 = arg_151_1:GetWordFromCfg(319051037)
				local var_154_8 = arg_151_1:FormatText(var_154_7.content)

				arg_151_1.text_.text = var_154_8

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_10 = 15 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 15)

				if (15 <= 0 and var_154_6 or var_154_6 * (utf8.len(var_154_8) / 15)) > 0 and var_154_6 < var_154_10 then
					arg_151_1.talkMaxDuration = var_154_10

					if var_154_10 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_10 + var_154_5
					end
				end

				arg_151_1.text_.text = var_154_8
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319051", "319051037", "story_v_out_319051.awb") ~= 0 then
					local var_154_11 = manager.audio:GetVoiceLength("story_v_out_319051", "319051037", "story_v_out_319051.awb") / 1000

					if var_154_11 + var_154_5 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_11 + var_154_5
					end

					if var_154_7.prefab_name ~= "" and arg_151_1.actors_[var_154_7.prefab_name] ~= nil then
						local var_154_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_7.prefab_name].transform, "story_v_out_319051", "319051037", "story_v_out_319051.awb")

						arg_151_1:RecordAudio("319051037", var_154_12)
						arg_151_1:RecordAudio("319051037", var_154_12)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_319051", "319051037", "story_v_out_319051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_319051", "319051037", "story_v_out_319051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_13 = math.max(var_154_6, arg_151_1.talkMaxDuration)

			if var_154_5 <= arg_151_1.time_ and arg_151_1.time_ < var_154_5 + var_154_13 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_5) / var_154_13

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_5 + var_154_13 and arg_151_1.time_ < var_154_5 + var_154_13 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {
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
	assets = {
		"TextureConfig/Background/I11n",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_319051.awb"
	}
}
