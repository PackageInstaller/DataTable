return {
	Play319601001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 319601001
		arg_1_1.duration_ = 8.1

		local var_1_0 = {
			zh = 3.799999999999,
			ja = 8.1
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
				arg_1_0:Play319601002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A08f == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A08f")
				var_4_0.name = "A08f"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A08f = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A08f

				arg_1_1.bgs_.A08f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A08f" then
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

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1.var_.moveOldPos10079ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_1_1.time_ - 1.8) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 1.8 + var_4_13 and arg_1_1.time_ < 1.8 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.95, -6.05)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["10079ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10079ui_story == nil then
				arg_1_1.var_.characterEffect10079ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect10079ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_15 and arg_1_1.time_ < 1.8 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect10079ui_story then
				arg_1_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "", "", "")

				local var_4_19 = manager.audio:GetAudioName("", "")

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
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_3_0_story_forbidden_space", "bgm_activity_3_0_story_forbidden_space")

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
			local var_4_24 = 0.125

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

				local var_4_26 = arg_1_1:GetWordFromCfg(319601001)
				local var_4_27 = arg_1_1:FormatText(var_4_26.content)

				arg_1_1.text_.text = var_4_27

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_29 = 5 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 5)

				if (5 <= 0 and var_4_24 or var_4_24 * (utf8.len(var_4_27) / 5)) > 0 and var_4_24 < var_4_29 then
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

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601001", "story_v_out_319601.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_319601", "319601001", "story_v_out_319601.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_319601", "319601001", "story_v_out_319601.awb")

						arg_1_1:RecordAudio("319601001", var_4_31)
						arg_1_1:RecordAudio("319601001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_319601", "319601001", "story_v_out_319601.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_319601", "319601001", "story_v_out_319601.awb")
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
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play319601002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 319601002
		arg_9_1.duration_ = 11.33

		local var_9_0 = {
			zh = 4.266,
			ja = 11.333
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
				arg_9_0:Play319601003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1095ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1095ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1095ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1095ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1095ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1095ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1095ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1095ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1095ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1095ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(0.7, -0.98, -6.1)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1095ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1095ui_story == nil then
				arg_9_1.var_.characterEffect1095ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1095ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1095ui_story then
				arg_9_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
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
			local var_12_13 = 0.375

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_14 = arg_9_1:GetWordFromCfg(319601002)
				local var_12_15 = arg_9_1:FormatText(var_12_14.content)

				arg_9_1.text_.text = var_12_15

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_17 = 15 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 15)

				if (15 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_15) / 15)) > 0 and var_12_13 < var_12_17 then
					arg_9_1.talkMaxDuration = var_12_17

					if var_12_17 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_17 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_15
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601002", "story_v_out_319601.awb") ~= 0 then
					local var_12_18 = manager.audio:GetVoiceLength("story_v_out_319601", "319601002", "story_v_out_319601.awb") / 1000

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end

					if var_12_14.prefab_name ~= "" and arg_9_1.actors_[var_12_14.prefab_name] ~= nil then
						local var_12_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_14.prefab_name].transform, "story_v_out_319601", "319601002", "story_v_out_319601.awb")

						arg_9_1:RecordAudio("319601002", var_12_19)
						arg_9_1:RecordAudio("319601002", var_12_19)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_319601", "319601002", "story_v_out_319601.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_319601", "319601002", "story_v_out_319601.awb")
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

		arg_9_1:InitPlayNodeList()
	end,
	Play319601003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 319601003
		arg_13_1.duration_ = 6.07

		local var_13_0 = {
			zh = 5.066,
			ja = 6.066
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
				arg_13_0:Play319601004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			local var_16_0 = 0.45

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_1 = arg_13_1:GetWordFromCfg(319601003)
				local var_16_2 = arg_13_1:FormatText(var_16_1.content)

				arg_13_1.text_.text = var_16_2

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_4 = 18 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 18)

				if (18 <= 0 and var_16_0 or var_16_0 * (utf8.len(var_16_2) / 18)) > 0 and var_16_0 < var_16_4 then
					arg_13_1.talkMaxDuration = var_16_4

					if var_16_4 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_4 + 0
					end
				end

				arg_13_1.text_.text = var_16_2
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601003", "story_v_out_319601.awb") ~= 0 then
					local var_16_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601003", "story_v_out_319601.awb") / 1000

					if var_16_5 + 0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + 0
					end

					if var_16_1.prefab_name ~= "" and arg_13_1.actors_[var_16_1.prefab_name] ~= nil then
						local var_16_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_1.prefab_name].transform, "story_v_out_319601", "319601003", "story_v_out_319601.awb")

						arg_13_1:RecordAudio("319601003", var_16_6)
						arg_13_1:RecordAudio("319601003", var_16_6)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_319601", "319601003", "story_v_out_319601.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_319601", "319601003", "story_v_out_319601.awb")
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
	Play319601004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 319601004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play319601005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story == nil then
				arg_17_1.var_.characterEffect1095ui_story = arg_17_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_0 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) then
				if arg_17_1.var_.characterEffect1095ui_story and not isNil(arg_17_1.actors_["1095ui_story"]) then
					arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_0)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 and not isNil(arg_17_1.actors_["1095ui_story"]) and arg_17_1.var_.characterEffect1095ui_story then
				arg_17_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_20_1 = 0
			local var_20_2 = 1.05

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

				local var_20_3 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(319601004).content)

				arg_17_1.text_.text = var_20_3

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_5 = 42 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 42)

				if (42 <= 0 and var_20_2 or var_20_2 * (utf8.len(var_20_3) / 42)) > 0 and var_20_2 < var_20_5 then
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
	Play319601005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 319601005
		arg_21_1.duration_ = 8.03

		local var_21_0 = {
			zh = 4.166,
			ja = 8.033
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
				arg_21_0:Play319601006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos10079ui_story = arg_21_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).z)
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles = arg_21_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_21_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["10079ui_story"].transform.position).z)
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["10079ui_story"].transform.localEulerAngles = arg_21_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["10079ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10079ui_story == nil then
				arg_21_1.var_.characterEffect10079ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect10079ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect10079ui_story then
				arg_21_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_24_4 = 0
			local var_24_5 = 0.55

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

				local var_24_6 = arg_21_1:GetWordFromCfg(319601005)
				local var_24_7 = arg_21_1:FormatText(var_24_6.content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 22 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 22)

				if (22 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_7) / 22)) > 0 and var_24_5 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601005", "story_v_out_319601.awb") ~= 0 then
					local var_24_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601005", "story_v_out_319601.awb") / 1000

					if var_24_10 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_10 + var_24_4
					end

					if var_24_6.prefab_name ~= "" and arg_21_1.actors_[var_24_6.prefab_name] ~= nil then
						local var_24_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_6.prefab_name].transform, "story_v_out_319601", "319601005", "story_v_out_319601.awb")

						arg_21_1:RecordAudio("319601005", var_24_11)
						arg_21_1:RecordAudio("319601005", var_24_11)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_319601", "319601005", "story_v_out_319601.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_319601", "319601005", "story_v_out_319601.awb")
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

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play319601006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 319601006
		arg_25_1.duration_ = 9.47

		local var_25_0 = {
			zh = 6.233,
			ja = 9.466
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
				arg_25_0:Play319601007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["10079ui_story"]) and arg_25_1.var_.characterEffect10079ui_story == nil then
				arg_25_1.var_.characterEffect10079ui_story = arg_25_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["10079ui_story"]) then
				if arg_25_1.var_.characterEffect10079ui_story and not isNil(arg_25_1.actors_["10079ui_story"]) then
					arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_25_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["10079ui_story"]) and arg_25_1.var_.characterEffect10079ui_story then
				arg_25_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_25_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_28_1 = arg_25_1.actors_["1095ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1095ui_story == nil then
				arg_25_1.var_.characterEffect1095ui_story = var_28_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_2 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 and not isNil(var_28_1) then
				if arg_25_1.var_.characterEffect1095ui_story and not isNil(var_28_1) then
					arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 and not isNil(var_28_1) and arg_25_1.var_.characterEffect1095ui_story then
				arg_25_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_28_4 = 0
			local var_28_5 = 0.8

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_4 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_6 = arg_25_1:GetWordFromCfg(319601006)
				local var_28_7 = arg_25_1:FormatText(var_28_6.content)

				arg_25_1.text_.text = var_28_7

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_9 = 32 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 32)

				if (32 <= 0 and var_28_5 or var_28_5 * (utf8.len(var_28_7) / 32)) > 0 and var_28_5 < var_28_9 then
					arg_25_1.talkMaxDuration = var_28_9

					if var_28_9 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_9 + var_28_4
					end
				end

				arg_25_1.text_.text = var_28_7
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601006", "story_v_out_319601.awb") ~= 0 then
					local var_28_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601006", "story_v_out_319601.awb") / 1000

					if var_28_10 + var_28_4 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_10 + var_28_4
					end

					if var_28_6.prefab_name ~= "" and arg_25_1.actors_[var_28_6.prefab_name] ~= nil then
						local var_28_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_6.prefab_name].transform, "story_v_out_319601", "319601006", "story_v_out_319601.awb")

						arg_25_1:RecordAudio("319601006", var_28_11)
						arg_25_1:RecordAudio("319601006", var_28_11)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_319601", "319601006", "story_v_out_319601.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_319601", "319601006", "story_v_out_319601.awb")
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
	Play319601007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 319601007
		arg_29_1.duration_ = 9.8

		local var_29_0 = {
			zh = 5.566,
			ja = 9.8
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
				arg_29_0:Play319601008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			local var_32_0 = 0.7

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_1 = arg_29_1:GetWordFromCfg(319601007)
				local var_32_2 = arg_29_1:FormatText(var_32_1.content)

				arg_29_1.text_.text = var_32_2

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_4 = 28 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 28)

				if (28 <= 0 and var_32_0 or var_32_0 * (utf8.len(var_32_2) / 28)) > 0 and var_32_0 < var_32_4 then
					arg_29_1.talkMaxDuration = var_32_4

					if var_32_4 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_4 + 0
					end
				end

				arg_29_1.text_.text = var_32_2
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601007", "story_v_out_319601.awb") ~= 0 then
					local var_32_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601007", "story_v_out_319601.awb") / 1000

					if var_32_5 + 0 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_5 + 0
					end

					if var_32_1.prefab_name ~= "" and arg_29_1.actors_[var_32_1.prefab_name] ~= nil then
						local var_32_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_1.prefab_name].transform, "story_v_out_319601", "319601007", "story_v_out_319601.awb")

						arg_29_1:RecordAudio("319601007", var_32_6)
						arg_29_1:RecordAudio("319601007", var_32_6)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_319601", "319601007", "story_v_out_319601.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_319601", "319601007", "story_v_out_319601.awb")
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
	Play319601008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 319601008
		arg_33_1.duration_ = 3.33

		local var_33_0 = {
			zh = 3.333,
			ja = 1.333
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
				arg_33_0:Play319601009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10079ui_story"]) and arg_33_1.var_.characterEffect10079ui_story == nil then
				arg_33_1.var_.characterEffect10079ui_story = arg_33_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10079ui_story"]) then
				if arg_33_1.var_.characterEffect10079ui_story and not isNil(arg_33_1.actors_["10079ui_story"]) then
					arg_33_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10079ui_story"]) and arg_33_1.var_.characterEffect10079ui_story then
				arg_33_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["1095ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1095ui_story == nil then
				arg_33_1.var_.characterEffect1095ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1095ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1095ui_story then
				arg_33_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_36_4 = 0
			local var_36_5 = 0.325

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

				local var_36_6 = arg_33_1:GetWordFromCfg(319601008)
				local var_36_7 = arg_33_1:FormatText(var_36_6.content)

				arg_33_1.text_.text = var_36_7

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_9 = 13 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 13)

				if (13 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_7) / 13)) > 0 and var_36_5 < var_36_9 then
					arg_33_1.talkMaxDuration = var_36_9

					if var_36_9 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_7
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601008", "story_v_out_319601.awb") ~= 0 then
					local var_36_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601008", "story_v_out_319601.awb") / 1000

					if var_36_10 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_10 + var_36_4
					end

					if var_36_6.prefab_name ~= "" and arg_33_1.actors_[var_36_6.prefab_name] ~= nil then
						local var_36_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_6.prefab_name].transform, "story_v_out_319601", "319601008", "story_v_out_319601.awb")

						arg_33_1:RecordAudio("319601008", var_36_11)
						arg_33_1:RecordAudio("319601008", var_36_11)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_319601", "319601008", "story_v_out_319601.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_319601", "319601008", "story_v_out_319601.awb")
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
	Play319601009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 319601009
		arg_37_1.duration_ = 8.4

		local var_37_0 = {
			zh = 1.999999999999,
			ja = 8.4
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
				arg_37_0:Play319601010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1095ui_story = arg_37_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).z)
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles = arg_37_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_37_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1095ui_story"].transform.position).z)
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1095ui_story"].transform.localEulerAngles = arg_37_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1095ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1095ui_story == nil then
				arg_37_1.var_.characterEffect1095ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1095ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1095ui_story then
				arg_37_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_40_4 = arg_37_1.actors_["10079ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10079ui_story == nil then
				arg_37_1.var_.characterEffect10079ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect10079ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10079ui_story then
				arg_37_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_40_6 = 0
			local var_40_7 = 0.25

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(319601009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 10 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 10)

				if (10 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 10)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601009", "story_v_out_319601.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_319601", "319601009", "story_v_out_319601.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_319601", "319601009", "story_v_out_319601.awb")

						arg_37_1:RecordAudio("319601009", var_40_13)
						arg_37_1:RecordAudio("319601009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_319601", "319601009", "story_v_out_319601.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_319601", "319601009", "story_v_out_319601.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play319601010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 319601010
		arg_41_1.duration_ = 8.87

		local var_41_0 = {
			zh = 7.2,
			ja = 8.866
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
				arg_41_0:Play319601011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			local var_44_0 = 0.925

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_1 = arg_41_1:GetWordFromCfg(319601010)
				local var_44_2 = arg_41_1:FormatText(var_44_1.content)

				arg_41_1.text_.text = var_44_2

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_4 = 37 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 37)

				if (37 <= 0 and var_44_0 or var_44_0 * (utf8.len(var_44_2) / 37)) > 0 and var_44_0 < var_44_4 then
					arg_41_1.talkMaxDuration = var_44_4

					if var_44_4 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_4 + 0
					end
				end

				arg_41_1.text_.text = var_44_2
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601010", "story_v_out_319601.awb") ~= 0 then
					local var_44_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601010", "story_v_out_319601.awb") / 1000

					if var_44_5 + 0 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_5 + 0
					end

					if var_44_1.prefab_name ~= "" and arg_41_1.actors_[var_44_1.prefab_name] ~= nil then
						local var_44_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_1.prefab_name].transform, "story_v_out_319601", "319601010", "story_v_out_319601.awb")

						arg_41_1:RecordAudio("319601010", var_44_6)
						arg_41_1:RecordAudio("319601010", var_44_6)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_319601", "319601010", "story_v_out_319601.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_319601", "319601010", "story_v_out_319601.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_7 = math.max(var_44_0, arg_41_1.talkMaxDuration)

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_7 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - 0) / var_44_7

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= 0 + var_44_7 and arg_41_1.time_ < 0 + var_44_7 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {}

		arg_41_1:InitPlayNodeList()
	end,
	Play319601011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 319601011
		arg_45_1.duration_ = 11.3

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play319601012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			local var_48_0 = 1.45

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_1 = arg_45_1:GetWordFromCfg(319601011)
				local var_48_2 = arg_45_1:FormatText(var_48_1.content)

				arg_45_1.text_.text = var_48_2

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_4 = 58 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 58)

				if (58 <= 0 and var_48_0 or var_48_0 * (utf8.len(var_48_2) / 58)) > 0 and var_48_0 < var_48_4 then
					arg_45_1.talkMaxDuration = var_48_4

					if var_48_4 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_4 + 0
					end
				end

				arg_45_1.text_.text = var_48_2
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601011", "story_v_out_319601.awb") ~= 0 then
					local var_48_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601011", "story_v_out_319601.awb") / 1000

					if var_48_5 + 0 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_5 + 0
					end

					if var_48_1.prefab_name ~= "" and arg_45_1.actors_[var_48_1.prefab_name] ~= nil then
						local var_48_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_1.prefab_name].transform, "story_v_out_319601", "319601011", "story_v_out_319601.awb")

						arg_45_1:RecordAudio("319601011", var_48_6)
						arg_45_1:RecordAudio("319601011", var_48_6)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_319601", "319601011", "story_v_out_319601.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_319601", "319601011", "story_v_out_319601.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_7 = math.max(var_48_0, arg_45_1.talkMaxDuration)

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_7 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - 0) / var_48_7

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= 0 + var_48_7 and arg_45_1.time_ < 0 + var_48_7 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {}

		arg_45_1:InitPlayNodeList()
	end,
	Play319601012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 319601012
		arg_49_1.duration_ = 14.43

		local var_49_0 = {
			zh = 9.333,
			ja = 14.433
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
				arg_49_0:Play319601013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 1.1

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:GetWordFromCfg(319601012)
				local var_52_2 = arg_49_1:FormatText(var_52_1.content)

				arg_49_1.text_.text = var_52_2

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_4 = 44 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 44)

				if (44 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_2) / 44)) > 0 and var_52_0 < var_52_4 then
					arg_49_1.talkMaxDuration = var_52_4

					if var_52_4 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_4 + 0
					end
				end

				arg_49_1.text_.text = var_52_2
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601012", "story_v_out_319601.awb") ~= 0 then
					local var_52_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601012", "story_v_out_319601.awb") / 1000

					if var_52_5 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_5 + 0
					end

					if var_52_1.prefab_name ~= "" and arg_49_1.actors_[var_52_1.prefab_name] ~= nil then
						local var_52_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_1.prefab_name].transform, "story_v_out_319601", "319601012", "story_v_out_319601.awb")

						arg_49_1:RecordAudio("319601012", var_52_6)
						arg_49_1:RecordAudio("319601012", var_52_6)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_319601", "319601012", "story_v_out_319601.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_319601", "319601012", "story_v_out_319601.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_7 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_7 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_7

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_7 and arg_49_1.time_ < 0 + var_52_7 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play319601013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 319601013
		arg_53_1.duration_ = 11.2

		local var_53_0 = {
			zh = 7.666,
			ja = 11.2
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
				arg_53_0:Play319601014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			local var_56_0 = 0.875

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_1 = arg_53_1:GetWordFromCfg(319601013)
				local var_56_2 = arg_53_1:FormatText(var_56_1.content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 35 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 35)

				if (35 <= 0 and var_56_0 or var_56_0 * (utf8.len(var_56_2) / 35)) > 0 and var_56_0 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + 0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601013", "story_v_out_319601.awb") ~= 0 then
					local var_56_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601013", "story_v_out_319601.awb") / 1000

					if var_56_5 + 0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_5 + 0
					end

					if var_56_1.prefab_name ~= "" and arg_53_1.actors_[var_56_1.prefab_name] ~= nil then
						local var_56_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_1.prefab_name].transform, "story_v_out_319601", "319601013", "story_v_out_319601.awb")

						arg_53_1:RecordAudio("319601013", var_56_6)
						arg_53_1:RecordAudio("319601013", var_56_6)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_319601", "319601013", "story_v_out_319601.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_319601", "319601013", "story_v_out_319601.awb")
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
	Play319601014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 319601014
		arg_57_1.duration_ = 13.4

		local var_57_0 = {
			zh = 5.166,
			ja = 13.4
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
				arg_57_0:Play319601015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			local var_60_0 = 0.55

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_1 = arg_57_1:GetWordFromCfg(319601014)
				local var_60_2 = arg_57_1:FormatText(var_60_1.content)

				arg_57_1.text_.text = var_60_2

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_4 = 22 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 22)

				if (22 <= 0 and var_60_0 or var_60_0 * (utf8.len(var_60_2) / 22)) > 0 and var_60_0 < var_60_4 then
					arg_57_1.talkMaxDuration = var_60_4

					if var_60_4 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_4 + 0
					end
				end

				arg_57_1.text_.text = var_60_2
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601014", "story_v_out_319601.awb") ~= 0 then
					local var_60_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601014", "story_v_out_319601.awb") / 1000

					if var_60_5 + 0 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_5 + 0
					end

					if var_60_1.prefab_name ~= "" and arg_57_1.actors_[var_60_1.prefab_name] ~= nil then
						local var_60_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_57_1.actors_[var_60_1.prefab_name].transform, "story_v_out_319601", "319601014", "story_v_out_319601.awb")

						arg_57_1:RecordAudio("319601014", var_60_6)
						arg_57_1:RecordAudio("319601014", var_60_6)
					else
						arg_57_1:AudioAction("play", "voice", "story_v_out_319601", "319601014", "story_v_out_319601.awb")
					end

					arg_57_1:RecordHistoryTalkVoice("story_v_out_319601", "319601014", "story_v_out_319601.awb")
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
	Play319601015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 319601015
		arg_61_1.duration_ = 5.83

		local var_61_0 = {
			zh = 2.633,
			ja = 5.833
		}
		local var_61_1 = manager.audio:GetLocalizationFlag()

		if var_61_0[var_61_1] ~= nil then
			arg_61_1.duration_ = var_61_0[var_61_1]
		end

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play319601016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1.var_.moveOldPos10079ui_story = arg_61_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_64_0 = 0.001

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 then
				arg_61_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_61_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_61_1.time_ - 0) / var_64_0)
				arg_61_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10079ui_story"].transform.position).z)
				arg_61_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10079ui_story"].transform.localEulerAngles = arg_61_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 then
				arg_61_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_61_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_61_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_61_1.actors_["10079ui_story"].transform.position).z)
				arg_61_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_61_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_61_1.actors_["10079ui_story"].transform.localEulerAngles = arg_61_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_64_1 = arg_61_1.actors_["10079ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10079ui_story == nil then
				arg_61_1.var_.characterEffect10079ui_story = var_64_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_2 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_2 and not isNil(var_64_1) then
				if arg_61_1.var_.characterEffect10079ui_story and not isNil(var_64_1) then
					arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_2 and arg_61_1.time_ < 0 + var_64_2 + arg_64_0 and not isNil(var_64_1) and arg_61_1.var_.characterEffect10079ui_story then
				arg_61_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action3_2")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_64_4 = arg_61_1.actors_["1095ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1095ui_story == nil then
				arg_61_1.var_.characterEffect1095ui_story = var_64_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_5 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_5 and not isNil(var_64_4) then
				if arg_61_1.var_.characterEffect1095ui_story and not isNil(var_64_4) then
					arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_61_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_5)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_5 and arg_61_1.time_ < 0 + var_64_5 + arg_64_0 and not isNil(var_64_4) and arg_61_1.var_.characterEffect1095ui_story then
				arg_61_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_61_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_64_6 = 0
			local var_64_7 = 0.3

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_6 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_8 = arg_61_1:GetWordFromCfg(319601015)
				local var_64_9 = arg_61_1:FormatText(var_64_8.content)

				arg_61_1.text_.text = var_64_9

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_11 = 12 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 12)

				if (12 <= 0 and var_64_7 or var_64_7 * (utf8.len(var_64_9) / 12)) > 0 and var_64_7 < var_64_11 then
					arg_61_1.talkMaxDuration = var_64_11

					if var_64_11 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_11 + var_64_6
					end
				end

				arg_61_1.text_.text = var_64_9
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601015", "story_v_out_319601.awb") ~= 0 then
					local var_64_12 = manager.audio:GetVoiceLength("story_v_out_319601", "319601015", "story_v_out_319601.awb") / 1000

					if var_64_12 + var_64_6 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_12 + var_64_6
					end

					if var_64_8.prefab_name ~= "" and arg_61_1.actors_[var_64_8.prefab_name] ~= nil then
						local var_64_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_61_1.actors_[var_64_8.prefab_name].transform, "story_v_out_319601", "319601015", "story_v_out_319601.awb")

						arg_61_1:RecordAudio("319601015", var_64_13)
						arg_61_1:RecordAudio("319601015", var_64_13)
					else
						arg_61_1:AudioAction("play", "voice", "story_v_out_319601", "319601015", "story_v_out_319601.awb")
					end

					arg_61_1:RecordHistoryTalkVoice("story_v_out_319601", "319601015", "story_v_out_319601.awb")
				end

				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_14 = math.max(var_64_7, arg_61_1.talkMaxDuration)

			if var_64_6 <= arg_61_1.time_ and arg_61_1.time_ < var_64_6 + var_64_14 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_6) / var_64_14

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_6 + var_64_14 and arg_61_1.time_ < var_64_6 + var_64_14 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {
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

		arg_61_1:InitPlayNodeList()
	end,
	Play319601016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 319601016
		arg_65_1.duration_ = 6.13

		local var_65_0 = {
			zh = 3.466,
			ja = 6.133
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
				arg_65_0:Play319601017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1.var_.moveOldPos1095ui_story = arg_65_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_68_0 = 0.001

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 then
				arg_65_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_65_1.var_.moveOldPos1095ui_story, Vector3.New(0.7, -0.98, -6.1), (arg_65_1.time_ - 0) / var_68_0)
				arg_65_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).z)
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles = arg_65_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 then
				arg_65_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0.7, -0.98, -6.1)
				arg_65_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_65_1.actors_["1095ui_story"].transform.position).z)
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_65_1.actors_["1095ui_story"].transform.localEulerAngles = arg_65_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_68_1 = arg_65_1.actors_["1095ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1095ui_story == nil then
				arg_65_1.var_.characterEffect1095ui_story = var_68_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_2 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_2 and not isNil(var_68_1) then
				if arg_65_1.var_.characterEffect1095ui_story and not isNil(var_68_1) then
					arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_2 and arg_65_1.time_ < 0 + var_68_2 + arg_68_0 and not isNil(var_68_1) and arg_65_1.var_.characterEffect1095ui_story then
				arg_65_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action425")
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_68_4 = arg_65_1.actors_["10079ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect10079ui_story == nil then
				arg_65_1.var_.characterEffect10079ui_story = var_68_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_5 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_5 and not isNil(var_68_4) then
				if arg_65_1.var_.characterEffect10079ui_story and not isNil(var_68_4) then
					arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_65_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_5)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_5 and arg_65_1.time_ < 0 + var_68_5 + arg_68_0 and not isNil(var_68_4) and arg_65_1.var_.characterEffect10079ui_story then
				arg_65_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_65_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_68_6 = 0
			local var_68_7 = 0.425

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_6 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_8 = arg_65_1:GetWordFromCfg(319601016)
				local var_68_9 = arg_65_1:FormatText(var_68_8.content)

				arg_65_1.text_.text = var_68_9

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_11 = 17 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 17)

				if (17 <= 0 and var_68_7 or var_68_7 * (utf8.len(var_68_9) / 17)) > 0 and var_68_7 < var_68_11 then
					arg_65_1.talkMaxDuration = var_68_11

					if var_68_11 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_11 + var_68_6
					end
				end

				arg_65_1.text_.text = var_68_9
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601016", "story_v_out_319601.awb") ~= 0 then
					local var_68_12 = manager.audio:GetVoiceLength("story_v_out_319601", "319601016", "story_v_out_319601.awb") / 1000

					if var_68_12 + var_68_6 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_12 + var_68_6
					end

					if var_68_8.prefab_name ~= "" and arg_65_1.actors_[var_68_8.prefab_name] ~= nil then
						local var_68_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_65_1.actors_[var_68_8.prefab_name].transform, "story_v_out_319601", "319601016", "story_v_out_319601.awb")

						arg_65_1:RecordAudio("319601016", var_68_13)
						arg_65_1:RecordAudio("319601016", var_68_13)
					else
						arg_65_1:AudioAction("play", "voice", "story_v_out_319601", "319601016", "story_v_out_319601.awb")
					end

					arg_65_1:RecordHistoryTalkVoice("story_v_out_319601", "319601016", "story_v_out_319601.awb")
				end

				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_14 = math.max(var_68_7, arg_65_1.talkMaxDuration)

			if var_68_6 <= arg_65_1.time_ and arg_65_1.time_ < var_68_6 + var_68_14 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_6) / var_68_14

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_6 + var_68_14 and arg_65_1.time_ < var_68_6 + var_68_14 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {
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

		arg_65_1:InitPlayNodeList()
	end,
	Play319601017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 319601017
		arg_69_1.duration_ = 3

		local var_69_0 = {
			zh = 3,
			ja = 2.666
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
				arg_69_0:Play319601018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) and arg_69_1.var_.characterEffect1095ui_story == nil then
				arg_69_1.var_.characterEffect1095ui_story = arg_69_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) then
				if arg_69_1.var_.characterEffect1095ui_story and not isNil(arg_69_1.actors_["1095ui_story"]) then
					arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_69_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_0)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1095ui_story"]) and arg_69_1.var_.characterEffect1095ui_story then
				arg_69_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_69_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_72_1 = 0
			local var_72_2 = 0.3

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_1 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_3 = arg_69_1:GetWordFromCfg(319601017)
				local var_72_4 = arg_69_1:FormatText(var_72_3.content)

				arg_69_1.text_.text = var_72_4

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_6 = 12 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 12)

				if (12 <= 0 and var_72_2 or var_72_2 * (utf8.len(var_72_4) / 12)) > 0 and var_72_2 < var_72_6 then
					arg_69_1.talkMaxDuration = var_72_6

					if var_72_6 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_6 + var_72_1
					end
				end

				arg_69_1.text_.text = var_72_4
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601017", "story_v_out_319601.awb") ~= 0 then
					local var_72_7 = manager.audio:GetVoiceLength("story_v_out_319601", "319601017", "story_v_out_319601.awb") / 1000

					if var_72_7 + var_72_1 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_7 + var_72_1
					end

					if var_72_3.prefab_name ~= "" and arg_69_1.actors_[var_72_3.prefab_name] ~= nil then
						local var_72_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_69_1.actors_[var_72_3.prefab_name].transform, "story_v_out_319601", "319601017", "story_v_out_319601.awb")

						arg_69_1:RecordAudio("319601017", var_72_8)
						arg_69_1:RecordAudio("319601017", var_72_8)
					else
						arg_69_1:AudioAction("play", "voice", "story_v_out_319601", "319601017", "story_v_out_319601.awb")
					end

					arg_69_1:RecordHistoryTalkVoice("story_v_out_319601", "319601017", "story_v_out_319601.awb")
				end

				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_2, arg_69_1.talkMaxDuration)

			if var_72_1 <= arg_69_1.time_ and arg_69_1.time_ < var_72_1 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_1) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_1 + var_72_9 and arg_69_1.time_ < var_72_1 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play319601018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 319601018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play319601019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 1.3

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_1 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(319601018).content)

				arg_73_1.text_.text = var_76_1

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_3 = 52 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 52)

				if (52 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_1) / 52)) > 0 and var_76_0 < var_76_3 then
					arg_73_1.talkMaxDuration = var_76_3

					if var_76_3 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_3 + 0
					end
				end

				arg_73_1.text_.text = var_76_1
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_4 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_4 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_4

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_4 and arg_73_1.time_ < 0 + var_76_4 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play319601019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 319601019
		arg_77_1.duration_ = 3.37

		local var_77_0 = {
			zh = 2.233,
			ja = 3.366
		}
		local var_77_1 = manager.audio:GetLocalizationFlag()

		if var_77_0[var_77_1] ~= nil then
			arg_77_1.duration_ = var_77_0[var_77_1]
		end

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play319601020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["10079ui_story"]) and arg_77_1.var_.characterEffect10079ui_story == nil then
				arg_77_1.var_.characterEffect10079ui_story = arg_77_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["10079ui_story"]) then
				if arg_77_1.var_.characterEffect10079ui_story and not isNil(arg_77_1.actors_["10079ui_story"]) then
					arg_77_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["10079ui_story"]) and arg_77_1.var_.characterEffect10079ui_story then
				arg_77_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_80_2 = arg_77_1.actors_["1095ui_story"]

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1095ui_story == nil then
				arg_77_1.var_.characterEffect1095ui_story = var_80_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_3 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_3 and not isNil(var_80_2) then
				if arg_77_1.var_.characterEffect1095ui_story and not isNil(var_80_2) then
					arg_77_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_77_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_77_1.time_ - 0) / var_80_3)
				end
			end

			if arg_77_1.time_ >= 0 + var_80_3 and arg_77_1.time_ < 0 + var_80_3 + arg_80_0 and not isNil(var_80_2) and arg_77_1.var_.characterEffect1095ui_story then
				arg_77_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_77_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_80_4 = 0
			local var_80_5 = 0.35

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_4 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_6 = arg_77_1:GetWordFromCfg(319601019)
				local var_80_7 = arg_77_1:FormatText(var_80_6.content)

				arg_77_1.text_.text = var_80_7

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_9 = 14 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 14)

				if (14 <= 0 and var_80_5 or var_80_5 * (utf8.len(var_80_7) / 14)) > 0 and var_80_5 < var_80_9 then
					arg_77_1.talkMaxDuration = var_80_9

					if var_80_9 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_9 + var_80_4
					end
				end

				arg_77_1.text_.text = var_80_7
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601019", "story_v_out_319601.awb") ~= 0 then
					local var_80_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601019", "story_v_out_319601.awb") / 1000

					if var_80_10 + var_80_4 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_10 + var_80_4
					end

					if var_80_6.prefab_name ~= "" and arg_77_1.actors_[var_80_6.prefab_name] ~= nil then
						local var_80_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_6.prefab_name].transform, "story_v_out_319601", "319601019", "story_v_out_319601.awb")

						arg_77_1:RecordAudio("319601019", var_80_11)
						arg_77_1:RecordAudio("319601019", var_80_11)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_319601", "319601019", "story_v_out_319601.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_319601", "319601019", "story_v_out_319601.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_12 = math.max(var_80_5, arg_77_1.talkMaxDuration)

			if var_80_4 <= arg_77_1.time_ and arg_77_1.time_ < var_80_4 + var_80_12 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_4) / var_80_12

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_4 + var_80_12 and arg_77_1.time_ < var_80_4 + var_80_12 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play319601020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 319601020
		arg_81_1.duration_ = 2

		local var_81_0 = {
			zh = 1.999999999999,
			ja = 2
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
				arg_81_0:Play319601021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(arg_81_1.actors_["10079ui_story"]) and arg_81_1.var_.characterEffect10079ui_story == nil then
				arg_81_1.var_.characterEffect10079ui_story = arg_81_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_0 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_0 and not isNil(arg_81_1.actors_["10079ui_story"]) then
				if arg_81_1.var_.characterEffect10079ui_story and not isNil(arg_81_1.actors_["10079ui_story"]) then
					arg_81_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_81_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_81_1.time_ - 0) / var_84_0)
				end
			end

			if arg_81_1.time_ >= 0 + var_84_0 and arg_81_1.time_ < 0 + var_84_0 + arg_84_0 and not isNil(arg_81_1.actors_["10079ui_story"]) and arg_81_1.var_.characterEffect10079ui_story then
				arg_81_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_81_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_84_1 = arg_81_1.actors_["1095ui_story"]

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1095ui_story == nil then
				arg_81_1.var_.characterEffect1095ui_story = var_84_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_84_2 = 0.200000002980232

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_2 and not isNil(var_84_1) then
				if arg_81_1.var_.characterEffect1095ui_story and not isNil(var_84_1) then
					arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_81_1.time_ >= 0 + var_84_2 and arg_81_1.time_ < 0 + var_84_2 + arg_84_0 and not isNil(var_84_1) and arg_81_1.var_.characterEffect1095ui_story then
				arg_81_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action5_2")
			end

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_84_4 = arg_81_1.actors_["10079ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos10079ui_story = var_84_4.localPosition
			end

			local var_84_5 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_5 then
				var_84_4.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_81_1.time_ - 0) / var_84_5)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_5 and arg_81_1.time_ < 0 + var_84_5 + arg_84_0 then
				var_84_4.localPosition = Vector3.New(0, 100, 0)
				var_84_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_4.position).x, (manager.ui.mainCamera.transform.position - var_84_4.position).y, (manager.ui.mainCamera.transform.position - var_84_4.position).z)
				var_84_4.localEulerAngles.z = 0
				var_84_4.localEulerAngles.x = 0
				var_84_4.localEulerAngles = var_84_4.localEulerAngles
			end

			local var_84_6 = arg_81_1.actors_["1095ui_story"].transform

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1.var_.moveOldPos1095ui_story = var_84_6.localPosition
			end

			local var_84_7 = 0.001

			if 0 <= arg_81_1.time_ and arg_81_1.time_ < 0 + var_84_7 then
				var_84_6.localPosition = Vector3.Lerp(arg_81_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_81_1.time_ - 0) / var_84_7)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			if arg_81_1.time_ >= 0 + var_84_7 and arg_81_1.time_ < 0 + var_84_7 + arg_84_0 then
				var_84_6.localPosition = Vector3.New(0, -0.98, -6.1)
				var_84_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_84_6.position).x, (manager.ui.mainCamera.transform.position - var_84_6.position).y, (manager.ui.mainCamera.transform.position - var_84_6.position).z)
				var_84_6.localEulerAngles.z = 0
				var_84_6.localEulerAngles.x = 0
				var_84_6.localEulerAngles = var_84_6.localEulerAngles
			end

			local var_84_8 = 0
			local var_84_9 = 0.1

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_8 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_10 = arg_81_1:GetWordFromCfg(319601020)
				local var_84_11 = arg_81_1:FormatText(var_84_10.content)

				arg_81_1.text_.text = var_84_11

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_13 = 4 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 4)

				if (4 <= 0 and var_84_9 or var_84_9 * (utf8.len(var_84_11) / 4)) > 0 and var_84_9 < var_84_13 then
					arg_81_1.talkMaxDuration = var_84_13

					if var_84_13 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_13 + var_84_8
					end
				end

				arg_81_1.text_.text = var_84_11
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601020", "story_v_out_319601.awb") ~= 0 then
					local var_84_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601020", "story_v_out_319601.awb") / 1000

					if var_84_14 + var_84_8 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_14 + var_84_8
					end

					if var_84_10.prefab_name ~= "" and arg_81_1.actors_[var_84_10.prefab_name] ~= nil then
						local var_84_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_81_1.actors_[var_84_10.prefab_name].transform, "story_v_out_319601", "319601020", "story_v_out_319601.awb")

						arg_81_1:RecordAudio("319601020", var_84_15)
						arg_81_1:RecordAudio("319601020", var_84_15)
					else
						arg_81_1:AudioAction("play", "voice", "story_v_out_319601", "319601020", "story_v_out_319601.awb")
					end

					arg_81_1:RecordHistoryTalkVoice("story_v_out_319601", "319601020", "story_v_out_319601.awb")
				end

				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_16 = math.max(var_84_9, arg_81_1.talkMaxDuration)

			if var_84_8 <= arg_81_1.time_ and arg_81_1.time_ < var_84_8 + var_84_16 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_8) / var_84_16

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_8 + var_84_16 and arg_81_1.time_ < var_84_8 + var_84_16 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {
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
				actorName = "1095ui_story",
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
	Play319601021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 319601021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play319601022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story == nil then
				arg_85_1.var_.characterEffect1095ui_story = arg_85_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_88_0 = 0.200000002980232

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) then
				if arg_85_1.var_.characterEffect1095ui_story and not isNil(arg_85_1.actors_["1095ui_story"]) then
					arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_85_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_85_1.time_ - 0) / var_88_0)
				end
			end

			if arg_85_1.time_ >= 0 + var_88_0 and arg_85_1.time_ < 0 + var_88_0 + arg_88_0 and not isNil(arg_85_1.actors_["1095ui_story"]) and arg_85_1.var_.characterEffect1095ui_story then
				arg_85_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_85_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_88_1 = arg_85_1.actors_["1095ui_story"].transform

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1.var_.moveOldPos1095ui_story = var_88_1.localPosition
			end

			local var_88_2 = 0.001

			if 0 <= arg_85_1.time_ and arg_85_1.time_ < 0 + var_88_2 then
				var_88_1.localPosition = Vector3.Lerp(arg_85_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_85_1.time_ - 0) / var_88_2)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			if arg_85_1.time_ >= 0 + var_88_2 and arg_85_1.time_ < 0 + var_88_2 + arg_88_0 then
				var_88_1.localPosition = Vector3.New(0, 100, 0)
				var_88_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_88_1.position).x, (manager.ui.mainCamera.transform.position - var_88_1.position).y, (manager.ui.mainCamera.transform.position - var_88_1.position).z)
				var_88_1.localEulerAngles.z = 0
				var_88_1.localEulerAngles.x = 0
				var_88_1.localEulerAngles = var_88_1.localEulerAngles
			end

			local var_88_3 = 0
			local var_88_4 = 1.45

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_3 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, false)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_5 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(319601021).content)

				arg_85_1.text_.text = var_88_5

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_7 = 58 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 58)

				if (58 <= 0 and var_88_4 or var_88_4 * (utf8.len(var_88_5) / 58)) > 0 and var_88_4 < var_88_7 then
					arg_85_1.talkMaxDuration = var_88_7

					if var_88_7 + var_88_3 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_7 + var_88_3
					end
				end

				arg_85_1.text_.text = var_88_5
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_8 = math.max(var_88_4, arg_85_1.talkMaxDuration)

			if var_88_3 <= arg_85_1.time_ and arg_85_1.time_ < var_88_3 + var_88_8 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_3) / var_88_8

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_3 + var_88_8 and arg_85_1.time_ < var_88_3 + var_88_8 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
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
	Play319601022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 319601022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play319601023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			local var_92_0 = 0.425

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_1 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(319601022).content)

				arg_89_1.text_.text = var_92_1

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_3 = 17 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 17)

				if (17 <= 0 and var_92_0 or var_92_0 * (utf8.len(var_92_1) / 17)) > 0 and var_92_0 < var_92_3 then
					arg_89_1.talkMaxDuration = var_92_3

					if var_92_3 + 0 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_3 + 0
					end
				end

				arg_89_1.text_.text = var_92_1
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_4 = math.max(var_92_0, arg_89_1.talkMaxDuration)

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_4 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - 0) / var_92_4

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= 0 + var_92_4 and arg_89_1.time_ < 0 + var_92_4 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play319601023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 319601023
		arg_93_1.duration_ = 9.7

		local var_93_0 = {
			zh = 5.733,
			ja = 9.7
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play319601024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos1095ui_story = arg_93_1.actors_["1095ui_story"].transform.localPosition
			end

			local var_96_0 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_0 then
				arg_93_1.actors_["1095ui_story"].transform.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos1095ui_story, Vector3.New(0, -0.98, -6.1), (arg_93_1.time_ - 0) / var_96_0)
				arg_93_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1095ui_story"].transform.position).z)
				arg_93_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1095ui_story"].transform.localEulerAngles = arg_93_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_0 and arg_93_1.time_ < 0 + var_96_0 + arg_96_0 then
				arg_93_1.actors_["1095ui_story"].transform.localPosition = Vector3.New(0, -0.98, -6.1)
				arg_93_1.actors_["1095ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_93_1.actors_["1095ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1095ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_93_1.actors_["1095ui_story"].transform.position).z)
				arg_93_1.actors_["1095ui_story"].transform.localEulerAngles.z = 0
				arg_93_1.actors_["1095ui_story"].transform.localEulerAngles.x = 0
				arg_93_1.actors_["1095ui_story"].transform.localEulerAngles = arg_93_1.actors_["1095ui_story"].transform.localEulerAngles
			end

			local var_96_1 = arg_93_1.actors_["1095ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1095ui_story == nil then
				arg_93_1.var_.characterEffect1095ui_story = var_96_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_2 and not isNil(var_96_1) then
				if arg_93_1.var_.characterEffect1095ui_story and not isNil(var_96_1) then
					arg_93_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_93_1.time_ >= 0 + var_96_2 and arg_93_1.time_ < 0 + var_96_2 + arg_96_0 and not isNil(var_96_1) and arg_93_1.var_.characterEffect1095ui_story then
				arg_93_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_96_4 = arg_93_1.actors_["10079ui_story"]

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10079ui_story == nil then
				arg_93_1.var_.characterEffect10079ui_story = var_96_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_5 = 0.200000002980232

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_5 and not isNil(var_96_4) then
				if arg_93_1.var_.characterEffect10079ui_story and not isNil(var_96_4) then
					arg_93_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_93_1.time_ - 0) / var_96_5)
				end
			end

			if arg_93_1.time_ >= 0 + var_96_5 and arg_93_1.time_ < 0 + var_96_5 + arg_96_0 and not isNil(var_96_4) and arg_93_1.var_.characterEffect10079ui_story then
				arg_93_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_96_6 = arg_93_1.actors_["10079ui_story"].transform

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.var_.moveOldPos10079ui_story = var_96_6.localPosition
			end

			local var_96_7 = 0.001

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_7 then
				var_96_6.localPosition = Vector3.Lerp(arg_93_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_93_1.time_ - 0) / var_96_7)
				var_96_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_6.position).x, (manager.ui.mainCamera.transform.position - var_96_6.position).y, (manager.ui.mainCamera.transform.position - var_96_6.position).z)
				var_96_6.localEulerAngles.z = 0
				var_96_6.localEulerAngles.x = 0
				var_96_6.localEulerAngles = var_96_6.localEulerAngles
			end

			if arg_93_1.time_ >= 0 + var_96_7 and arg_93_1.time_ < 0 + var_96_7 + arg_96_0 then
				var_96_6.localPosition = Vector3.New(0, 100, 0)
				var_96_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_96_6.position).x, (manager.ui.mainCamera.transform.position - var_96_6.position).y, (manager.ui.mainCamera.transform.position - var_96_6.position).z)
				var_96_6.localEulerAngles.z = 0
				var_96_6.localEulerAngles.x = 0
				var_96_6.localEulerAngles = var_96_6.localEulerAngles
			end

			local var_96_8 = 0
			local var_96_9 = 0.475

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= var_96_8 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				arg_93_1.leftNameTxt_.text = arg_93_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_10 = arg_93_1:GetWordFromCfg(319601023)
				local var_96_11 = arg_93_1:FormatText(var_96_10.content)

				arg_93_1.text_.text = var_96_11

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_13 = 19 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 19)

				if (19 <= 0 and var_96_9 or var_96_9 * (utf8.len(var_96_11) / 19)) > 0 and var_96_9 < var_96_13 then
					arg_93_1.talkMaxDuration = var_96_13

					if var_96_13 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_13 + var_96_8
					end
				end

				arg_93_1.text_.text = var_96_11
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601023", "story_v_out_319601.awb") ~= 0 then
					local var_96_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601023", "story_v_out_319601.awb") / 1000

					if var_96_14 + var_96_8 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_14 + var_96_8
					end

					if var_96_10.prefab_name ~= "" and arg_93_1.actors_[var_96_10.prefab_name] ~= nil then
						local var_96_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_10.prefab_name].transform, "story_v_out_319601", "319601023", "story_v_out_319601.awb")

						arg_93_1:RecordAudio("319601023", var_96_15)
						arg_93_1:RecordAudio("319601023", var_96_15)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_319601", "319601023", "story_v_out_319601.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_319601", "319601023", "story_v_out_319601.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_16 = math.max(var_96_9, arg_93_1.talkMaxDuration)

			if var_96_8 <= arg_93_1.time_ and arg_93_1.time_ < var_96_8 + var_96_16 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_8) / var_96_16

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_8 + var_96_16 and arg_93_1.time_ < var_96_8 + var_96_16 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {
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

		arg_93_1:InitPlayNodeList()
	end,
	Play319601024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 319601024
		arg_97_1.duration_ = 2.03

		local var_97_0 = {
			zh = 2.033,
			ja = 1.733
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
				arg_97_0:Play319601025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["1095ui_story"]) and arg_97_1.var_.characterEffect1095ui_story == nil then
				arg_97_1.var_.characterEffect1095ui_story = arg_97_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["1095ui_story"]) then
				if arg_97_1.var_.characterEffect1095ui_story and not isNil(arg_97_1.actors_["1095ui_story"]) then
					arg_97_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_97_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_97_1.time_ - 0) / var_100_0)
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["1095ui_story"]) and arg_97_1.var_.characterEffect1095ui_story then
				arg_97_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_97_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_100_1 = 0
			local var_100_2 = 0.25

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[694].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, true)
				arg_97_1.iconController_:SetSelectedState("hero")

				arg_97_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10072")

				arg_97_1.callingController_:SetSelectedState("normal")

				arg_97_1.keyicon_.color = Color.New(1, 1, 1)
				arg_97_1.icon_.color = Color.New(1, 1, 1)

				local var_100_3 = arg_97_1:GetWordFromCfg(319601024)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 10 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 10)

				if (10 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 10)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601024", "story_v_out_319601.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_319601", "319601024", "story_v_out_319601.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_319601", "319601024", "story_v_out_319601.awb")

						arg_97_1:RecordAudio("319601024", var_100_8)
						arg_97_1:RecordAudio("319601024", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_319601", "319601024", "story_v_out_319601.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_319601", "319601024", "story_v_out_319601.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play319601025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 319601025
		arg_101_1.duration_ = 9.67

		local var_101_0 = {
			zh = 3.266,
			ja = 9.666
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
				arg_101_0:Play319601026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1095ui_story"]) and arg_101_1.var_.characterEffect1095ui_story == nil then
				arg_101_1.var_.characterEffect1095ui_story = arg_101_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1095ui_story"]) then
				if arg_101_1.var_.characterEffect1095ui_story and not isNil(arg_101_1.actors_["1095ui_story"]) then
					arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1095ui_story"]) and arg_101_1.var_.characterEffect1095ui_story then
				arg_101_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_104_2 = 0
			local var_104_3 = 0.4

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_2 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_4 = arg_101_1:GetWordFromCfg(319601025)
				local var_104_5 = arg_101_1:FormatText(var_104_4.content)

				arg_101_1.text_.text = var_104_5

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_7 = 16 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 16)

				if (16 <= 0 and var_104_3 or var_104_3 * (utf8.len(var_104_5) / 16)) > 0 and var_104_3 < var_104_7 then
					arg_101_1.talkMaxDuration = var_104_7

					if var_104_7 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_7 + var_104_2
					end
				end

				arg_101_1.text_.text = var_104_5
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601025", "story_v_out_319601.awb") ~= 0 then
					local var_104_8 = manager.audio:GetVoiceLength("story_v_out_319601", "319601025", "story_v_out_319601.awb") / 1000

					if var_104_8 + var_104_2 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_2
					end

					if var_104_4.prefab_name ~= "" and arg_101_1.actors_[var_104_4.prefab_name] ~= nil then
						local var_104_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_4.prefab_name].transform, "story_v_out_319601", "319601025", "story_v_out_319601.awb")

						arg_101_1:RecordAudio("319601025", var_104_9)
						arg_101_1:RecordAudio("319601025", var_104_9)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_319601", "319601025", "story_v_out_319601.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_319601", "319601025", "story_v_out_319601.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_10 = math.max(var_104_3, arg_101_1.talkMaxDuration)

			if var_104_2 <= arg_101_1.time_ and arg_101_1.time_ < var_104_2 + var_104_10 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_2) / var_104_10

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_2 + var_104_10 and arg_101_1.time_ < var_104_2 + var_104_10 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play319601026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 319601026
		arg_105_1.duration_ = 5.07

		local var_105_0 = {
			zh = 5.066,
			ja = 4
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
				arg_105_0:Play319601027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = 0.725

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_1 = arg_105_1:GetWordFromCfg(319601026)
				local var_108_2 = arg_105_1:FormatText(var_108_1.content)

				arg_105_1.text_.text = var_108_2

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_4 = 29 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 29)

				if (29 <= 0 and var_108_0 or var_108_0 * (utf8.len(var_108_2) / 29)) > 0 and var_108_0 < var_108_4 then
					arg_105_1.talkMaxDuration = var_108_4

					if var_108_4 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_4 + 0
					end
				end

				arg_105_1.text_.text = var_108_2
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601026", "story_v_out_319601.awb") ~= 0 then
					local var_108_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601026", "story_v_out_319601.awb") / 1000

					if var_108_5 + 0 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + 0
					end

					if var_108_1.prefab_name ~= "" and arg_105_1.actors_[var_108_1.prefab_name] ~= nil then
						local var_108_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_1.prefab_name].transform, "story_v_out_319601", "319601026", "story_v_out_319601.awb")

						arg_105_1:RecordAudio("319601026", var_108_6)
						arg_105_1:RecordAudio("319601026", var_108_6)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_319601", "319601026", "story_v_out_319601.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_319601", "319601026", "story_v_out_319601.awb")
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
	Play319601027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 319601027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play319601028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:AudioAction("play", "effect", "se_story", "se_story_communication", "")
			end

			local var_112_1 = arg_109_1.actors_["1095ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story == nil then
				arg_109_1.var_.characterEffect1095ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1095ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_109_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_2)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1095ui_story then
				arg_109_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_109_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_112_3 = 0
			local var_112_4 = 1.025

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_3 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, false)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_5 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(319601027).content)

				arg_109_1.text_.text = var_112_5

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_7 = 41 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 41)

				if (41 <= 0 and var_112_4 or var_112_4 * (utf8.len(var_112_5) / 41)) > 0 and var_112_4 < var_112_7 then
					arg_109_1.talkMaxDuration = var_112_7

					if var_112_7 + var_112_3 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_7 + var_112_3
					end
				end

				arg_109_1.text_.text = var_112_5
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_8 = math.max(var_112_4, arg_109_1.talkMaxDuration)

			if var_112_3 <= arg_109_1.time_ and arg_109_1.time_ < var_112_3 + var_112_8 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_3) / var_112_8

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_3 + var_112_8 and arg_109_1.time_ < var_112_3 + var_112_8 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play319601028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 319601028
		arg_113_1.duration_ = 7.27

		local var_113_0 = {
			zh = 4.233,
			ja = 7.266
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
				arg_113_0:Play319601029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) and arg_113_1.var_.characterEffect1095ui_story == nil then
				arg_113_1.var_.characterEffect1095ui_story = arg_113_1.actors_["1095ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) then
				if arg_113_1.var_.characterEffect1095ui_story and not isNil(arg_113_1.actors_["1095ui_story"]) then
					arg_113_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1095ui_story"]) and arg_113_1.var_.characterEffect1095ui_story then
				arg_113_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_116_2 = 0
			local var_116_3 = 0.425

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_2 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_4 = arg_113_1:GetWordFromCfg(319601028)
				local var_116_5 = arg_113_1:FormatText(var_116_4.content)

				arg_113_1.text_.text = var_116_5

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_7 = 17 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 17)

				if (17 <= 0 and var_116_3 or var_116_3 * (utf8.len(var_116_5) / 17)) > 0 and var_116_3 < var_116_7 then
					arg_113_1.talkMaxDuration = var_116_7

					if var_116_7 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_7 + var_116_2
					end
				end

				arg_113_1.text_.text = var_116_5
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601028", "story_v_out_319601.awb") ~= 0 then
					local var_116_8 = manager.audio:GetVoiceLength("story_v_out_319601", "319601028", "story_v_out_319601.awb") / 1000

					if var_116_8 + var_116_2 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_2
					end

					if var_116_4.prefab_name ~= "" and arg_113_1.actors_[var_116_4.prefab_name] ~= nil then
						local var_116_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_4.prefab_name].transform, "story_v_out_319601", "319601028", "story_v_out_319601.awb")

						arg_113_1:RecordAudio("319601028", var_116_9)
						arg_113_1:RecordAudio("319601028", var_116_9)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_319601", "319601028", "story_v_out_319601.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_319601", "319601028", "story_v_out_319601.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_10 = math.max(var_116_3, arg_113_1.talkMaxDuration)

			if var_116_2 <= arg_113_1.time_ and arg_113_1.time_ < var_116_2 + var_116_10 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_2) / var_116_10

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_2 + var_116_10 and arg_113_1.time_ < var_116_2 + var_116_10 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play319601029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 319601029
		arg_117_1.duration_ = 7.67

		local var_117_0 = {
			zh = 2.833,
			ja = 7.666
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
				arg_117_0:Play319601030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_120_0 = 0
			local var_120_1 = 0.35

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_0 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_2 = arg_117_1:GetWordFromCfg(319601029)
				local var_120_3 = arg_117_1:FormatText(var_120_2.content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 14 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 14)

				if (14 <= 0 and var_120_1 or var_120_1 * (utf8.len(var_120_3) / 14)) > 0 and var_120_1 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_0
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601029", "story_v_out_319601.awb") ~= 0 then
					local var_120_6 = manager.audio:GetVoiceLength("story_v_out_319601", "319601029", "story_v_out_319601.awb") / 1000

					if var_120_6 + var_120_0 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_6 + var_120_0
					end

					if var_120_2.prefab_name ~= "" and arg_117_1.actors_[var_120_2.prefab_name] ~= nil then
						local var_120_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_2.prefab_name].transform, "story_v_out_319601", "319601029", "story_v_out_319601.awb")

						arg_117_1:RecordAudio("319601029", var_120_7)
						arg_117_1:RecordAudio("319601029", var_120_7)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_319601", "319601029", "story_v_out_319601.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_319601", "319601029", "story_v_out_319601.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_8 = math.max(var_120_1, arg_117_1.talkMaxDuration)

			if var_120_0 <= arg_117_1.time_ and arg_117_1.time_ < var_120_0 + var_120_8 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_0) / var_120_8

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_0 + var_120_8 and arg_117_1.time_ < var_120_0 + var_120_8 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play319601030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 319601030
		arg_121_1.duration_ = 7.4

		local var_121_0 = {
			zh = 6.299999999998,
			ja = 7.399999999998
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
				arg_121_0:Play319601031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if arg_121_1.bgs_.I10f == nil then
				local var_124_0 = Object.Instantiate(arg_121_1.paintGo_)

				var_124_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I10f")
				var_124_0.name = "I10f"
				var_124_0.transform.parent = arg_121_1.stage_.transform
				var_124_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.bgs_.I10f = var_124_0
			end

			if 1.999999999999 < arg_121_1.time_ and arg_121_1.time_ <= 1.999999999999 + arg_124_0 then
				local var_124_1 = arg_121_1.bgs_.I10f

				arg_121_1.bgs_.I10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_124_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_124_2 = var_124_1:GetComponent("SpriteRenderer")

				if var_124_2 and var_124_2.sprite then
					local var_124_3 = 2 * (var_124_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_124_1.transform.localScale = Vector3.New(var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, var_124_3 / var_124_2.sprite.bounds.size.y < var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x and var_124_3 * manager.ui.mainCameraCom_.aspect / var_124_2.sprite.bounds.size.x or var_124_3 / var_124_2.sprite.bounds.size.y, 0)
				end

				for iter_124_0, iter_124_1 in pairs(arg_121_1.bgs_) do
					if iter_124_0 ~= "I10f" then
						iter_124_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_124_4 = 0

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_4 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_5 = 2

			if var_124_4 <= arg_121_1.time_ and arg_121_1.time_ < var_124_4 + var_124_5 then
				local var_124_6 = Color.New(0, 0, 0)

				var_124_6.a = Mathf.Lerp(0, 1, (arg_121_1.time_ - var_124_4) / var_124_5)
				arg_121_1.mask_.color = var_124_6
			end

			if arg_121_1.time_ >= var_124_4 + var_124_5 and arg_121_1.time_ < var_124_4 + var_124_5 + arg_124_0 then
				local var_124_7 = Color.New(0, 0, 0)

				var_124_7.a = 1
				arg_121_1.mask_.color = var_124_7
			end

			local var_124_8 = 1.999999999999

			if 1.999999999999 < arg_121_1.time_ and arg_121_1.time_ <= var_124_8 + arg_124_0 then
				arg_121_1.mask_.enabled = true
				arg_121_1.mask_.raycastTarget = true

				arg_121_1:SetGaussion(false)
			end

			local var_124_9 = 2

			if var_124_8 <= arg_121_1.time_ and arg_121_1.time_ < var_124_8 + var_124_9 then
				local var_124_10 = Color.New(0, 0, 0)

				var_124_10.a = Mathf.Lerp(1, 0, (arg_121_1.time_ - var_124_8) / var_124_9)
				arg_121_1.mask_.color = var_124_10
			end

			if arg_121_1.time_ >= var_124_8 + var_124_9 and arg_121_1.time_ < var_124_8 + var_124_9 + arg_124_0 then
				local var_124_11 = Color.New(0, 0, 0)

				arg_121_1.mask_.enabled = false
				var_124_11.a = 0
				arg_121_1.mask_.color = var_124_11
			end

			local var_124_12 = arg_121_1.actors_["1095ui_story"].transform

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 then
				arg_121_1.var_.moveOldPos1095ui_story = var_124_12.localPosition
			end

			local var_124_13 = 0.001

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_13 then
				var_124_12.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.96599999815226) / var_124_13)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_13 and arg_121_1.time_ < 1.96599999815226 + var_124_13 + arg_124_0 then
				var_124_12.localPosition = Vector3.New(0, 100, 0)
				var_124_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_12.position).x, (manager.ui.mainCamera.transform.position - var_124_12.position).y, (manager.ui.mainCamera.transform.position - var_124_12.position).z)
				var_124_12.localEulerAngles.z = 0
				var_124_12.localEulerAngles.x = 0
				var_124_12.localEulerAngles = var_124_12.localEulerAngles
			end

			local var_124_14 = arg_121_1.actors_["1095ui_story"].transform

			if 4.46666666666667 < arg_121_1.time_ and arg_121_1.time_ <= 4.46666666666667 + arg_124_0 then
				arg_121_1.var_.moveOldPos1095ui_story = var_124_14.localPosition
			end

			local var_124_15 = 0.001

			if 4.46666666666667 <= arg_121_1.time_ and arg_121_1.time_ < 4.46666666666667 + var_124_15 then
				var_124_14.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1095ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 4.46666666666667) / var_124_15)
				var_124_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_14.position).x, (manager.ui.mainCamera.transform.position - var_124_14.position).y, (manager.ui.mainCamera.transform.position - var_124_14.position).z)
				var_124_14.localEulerAngles.z = 0
				var_124_14.localEulerAngles.x = 0
				var_124_14.localEulerAngles = var_124_14.localEulerAngles
			end

			if arg_121_1.time_ >= 4.46666666666667 + var_124_15 and arg_121_1.time_ < 4.46666666666667 + var_124_15 + arg_124_0 then
				var_124_14.localPosition = Vector3.New(0, 100, 0)
				var_124_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_14.position).x, (manager.ui.mainCamera.transform.position - var_124_14.position).y, (manager.ui.mainCamera.transform.position - var_124_14.position).z)
				var_124_14.localEulerAngles.z = 0
				var_124_14.localEulerAngles.x = 0
				var_124_14.localEulerAngles = var_124_14.localEulerAngles
			end

			local var_124_16 = arg_121_1.actors_["1095ui_story"]

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 and not isNil(var_124_16) and arg_121_1.var_.characterEffect1095ui_story == nil then
				arg_121_1.var_.characterEffect1095ui_story = var_124_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_17 = 0.034000001847744

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_17 and not isNil(var_124_16) then
				if arg_121_1.var_.characterEffect1095ui_story and not isNil(var_124_16) then
					arg_121_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_121_1.var_.characterEffect1095ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.96599999815226) / var_124_17)
				end
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_17 and arg_121_1.time_ < 1.96599999815226 + var_124_17 + arg_124_0 and not isNil(var_124_16) and arg_121_1.var_.characterEffect1095ui_story then
				arg_121_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_121_1.var_.characterEffect1095ui_story.fillRatio = 0.5
			end

			local var_124_18 = arg_121_1.actors_["10079ui_story"].transform

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 then
				arg_121_1.var_.moveOldPos10079ui_story = var_124_18.localPosition
			end

			local var_124_19 = 0.001

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_19 then
				var_124_18.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_121_1.time_ - 1.96599999815226) / var_124_19)
				var_124_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_18.position).x, (manager.ui.mainCamera.transform.position - var_124_18.position).y, (manager.ui.mainCamera.transform.position - var_124_18.position).z)
				var_124_18.localEulerAngles.z = 0
				var_124_18.localEulerAngles.x = 0
				var_124_18.localEulerAngles = var_124_18.localEulerAngles
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_19 and arg_121_1.time_ < 1.96599999815226 + var_124_19 + arg_124_0 then
				var_124_18.localPosition = Vector3.New(0, 100, 0)
				var_124_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_18.position).x, (manager.ui.mainCamera.transform.position - var_124_18.position).y, (manager.ui.mainCamera.transform.position - var_124_18.position).z)
				var_124_18.localEulerAngles.z = 0
				var_124_18.localEulerAngles.x = 0
				var_124_18.localEulerAngles = var_124_18.localEulerAngles
			end

			local var_124_20 = arg_121_1.actors_["10079ui_story"]

			if 1.96599999815226 < arg_121_1.time_ and arg_121_1.time_ <= 1.96599999815226 + arg_124_0 and not isNil(var_124_20) and arg_121_1.var_.characterEffect10079ui_story == nil then
				arg_121_1.var_.characterEffect10079ui_story = var_124_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_21 = 0.034000001847744

			if 1.96599999815226 <= arg_121_1.time_ and arg_121_1.time_ < 1.96599999815226 + var_124_21 and not isNil(var_124_20) then
				if arg_121_1.var_.characterEffect10079ui_story and not isNil(var_124_20) then
					arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_121_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_121_1.time_ - 1.96599999815226) / var_124_21)
				end
			end

			if arg_121_1.time_ >= 1.96599999815226 + var_124_21 and arg_121_1.time_ < 1.96599999815226 + var_124_21 + arg_124_0 and not isNil(var_124_20) and arg_121_1.var_.characterEffect10079ui_story then
				arg_121_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_121_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_124_22 = "4037ui_story"

			if arg_121_1.actors_["4037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4037ui_story"))) then
				local var_124_23 = Object.Instantiate(Asset.Load("Char/" .. "4037ui_story"), arg_121_1.stage_.transform)

				var_124_23.name = var_124_22
				var_124_23.transform.localPosition = Vector3.New(0, 100, 0)
				arg_121_1.actors_[var_124_22] = var_124_23

				local var_124_24 = var_124_23:GetComponentInChildren(typeof(CharacterEffect))

				var_124_24.enabled = true

				local var_124_25 = GameObjectTools.GetOrAddComponent(var_124_23, typeof(DynamicBoneHelper))

				if var_124_25 then
					var_124_25:EnableDynamicBone(false)
				end

				arg_121_1:ShowWeapon(var_124_24.transform, false)

				arg_121_1.var_[var_124_22 .. "Animator"] = var_124_24.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_121_1.var_[var_124_22 .. "Animator"].applyRootMotion = true
				arg_121_1.var_[var_124_22 .. "LipSync"] = var_124_24.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_124_26 = arg_121_1.actors_["4037ui_story"].transform

			if 3.8 < arg_121_1.time_ and arg_121_1.time_ <= 3.8 + arg_124_0 then
				arg_121_1.var_.moveOldPos4037ui_story = var_124_26.localPosition
			end

			local var_124_27 = 0.001

			if 3.8 <= arg_121_1.time_ and arg_121_1.time_ < 3.8 + var_124_27 then
				var_124_26.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_121_1.time_ - 3.8) / var_124_27)
				var_124_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_26.position).x, (manager.ui.mainCamera.transform.position - var_124_26.position).y, (manager.ui.mainCamera.transform.position - var_124_26.position).z)
				var_124_26.localEulerAngles.z = 0
				var_124_26.localEulerAngles.x = 0
				var_124_26.localEulerAngles = var_124_26.localEulerAngles
			end

			if arg_121_1.time_ >= 3.8 + var_124_27 and arg_121_1.time_ < 3.8 + var_124_27 + arg_124_0 then
				var_124_26.localPosition = Vector3.New(0, -1.12, -6.2)
				var_124_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_124_26.position).x, (manager.ui.mainCamera.transform.position - var_124_26.position).y, (manager.ui.mainCamera.transform.position - var_124_26.position).z)
				var_124_26.localEulerAngles.z = 0
				var_124_26.localEulerAngles.x = 0
				var_124_26.localEulerAngles = var_124_26.localEulerAngles
			end

			local var_124_28 = arg_121_1.actors_["4037ui_story"]

			if 3.8 < arg_121_1.time_ and arg_121_1.time_ <= 3.8 + arg_124_0 and not isNil(var_124_28) and arg_121_1.var_.characterEffect4037ui_story == nil then
				arg_121_1.var_.characterEffect4037ui_story = var_124_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_29 = 0.2

			if 3.8 <= arg_121_1.time_ and arg_121_1.time_ < 3.8 + var_124_29 and not isNil(var_124_28) then
				if arg_121_1.var_.characterEffect4037ui_story and not isNil(var_124_28) then
					arg_121_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 3.8 + var_124_29 and arg_121_1.time_ < 3.8 + var_124_29 + arg_124_0 and not isNil(var_124_28) and arg_121_1.var_.characterEffect4037ui_story then
				arg_121_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 3.8 < arg_121_1.time_ and arg_121_1.time_ <= 3.8 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 3.8 < arg_121_1.time_ and arg_121_1.time_ <= 3.8 + arg_124_0 then
				arg_121_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			if arg_121_1.frameCnt_ <= 1 then
				arg_121_1.dialog_:SetActive(false)
			end

			local var_124_31 = 3.999999999998
			local var_124_32 = 0.225

			if 3.999999999998 < arg_121_1.time_ and arg_121_1.time_ <= var_124_31 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0

				arg_121_1.dialog_:SetActive(true)

				arg_121_1.dialogCg_.alpha = 0

				local var_124_33 = LeanTween.value(arg_121_1.dialog_, 0, 1, 0.3)

				var_124_33:setOnUpdate(LuaHelper.FloatAction(function(arg_125_0)
					arg_121_1.dialogCg_.alpha = arg_125_0
				end))
				var_124_33:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_121_1.dialog_)
					var_124_33:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_121_1.duration_ = arg_121_1.duration_ + 0.3

				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_34 = arg_121_1:GetWordFromCfg(319601030)
				local var_124_35 = arg_121_1:FormatText(var_124_34.content)

				arg_121_1.text_.text = var_124_35

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_37 = 9 <= 0 and var_124_32 or var_124_32 * (utf8.len(var_124_35) / 9)

				if (9 <= 0 and var_124_32 or var_124_32 * (utf8.len(var_124_35) / 9)) > 0 and var_124_32 < var_124_37 then
					arg_121_1.talkMaxDuration = var_124_37
					var_124_31 = var_124_31 + 0.3

					if var_124_37 + var_124_31 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_37 + var_124_31
					end
				end

				arg_121_1.text_.text = var_124_35
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601030", "story_v_out_319601.awb") ~= 0 then
					local var_124_38 = manager.audio:GetVoiceLength("story_v_out_319601", "319601030", "story_v_out_319601.awb") / 1000

					if var_124_38 + var_124_31 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_38 + var_124_31
					end

					if var_124_34.prefab_name ~= "" and arg_121_1.actors_[var_124_34.prefab_name] ~= nil then
						local var_124_39 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_34.prefab_name].transform, "story_v_out_319601", "319601030", "story_v_out_319601.awb")

						arg_121_1:RecordAudio("319601030", var_124_39)
						arg_121_1:RecordAudio("319601030", var_124_39)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_319601", "319601030", "story_v_out_319601.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_319601", "319601030", "story_v_out_319601.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_40 = var_124_31 + 0.3
			local var_124_41 = math.max(var_124_32, arg_121_1.talkMaxDuration)

			if var_124_31 + 0.3 <= arg_121_1.time_ and arg_121_1.time_ < var_124_40 + var_124_41 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_40) / var_124_41

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_40 + var_124_41 and arg_121_1.time_ < var_124_40 + var_124_41 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1095ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 4.46666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10079ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_121_1:InitPlayNodeList()
	end,
	Play319601031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 319601031
		arg_127_1.duration_ = 5

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play319601032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(arg_127_1.actors_["4037ui_story"]) and arg_127_1.var_.characterEffect4037ui_story == nil then
				arg_127_1.var_.characterEffect4037ui_story = arg_127_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_0 = 0.200000002980232

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 and not isNil(arg_127_1.actors_["4037ui_story"]) then
				if arg_127_1.var_.characterEffect4037ui_story and not isNil(arg_127_1.actors_["4037ui_story"]) then
					arg_127_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_127_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_0)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 and not isNil(arg_127_1.actors_["4037ui_story"]) and arg_127_1.var_.characterEffect4037ui_story then
				arg_127_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_127_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:AudioAction("play", "effect", "se_story_side_1093", "se_story_1093_hit", "")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			local var_130_2 = 0
			local var_130_3 = 1.025

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_2 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_4 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(319601031).content)

				arg_127_1.text_.text = var_130_4

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_6 = 41 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 41)

				if (41 <= 0 and var_130_3 or var_130_3 * (utf8.len(var_130_4) / 41)) > 0 and var_130_3 < var_130_6 then
					arg_127_1.talkMaxDuration = var_130_6

					if var_130_6 + var_130_2 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_6 + var_130_2
					end
				end

				arg_127_1.text_.text = var_130_4
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_7 = math.max(var_130_3, arg_127_1.talkMaxDuration)

			if var_130_2 <= arg_127_1.time_ and arg_127_1.time_ < var_130_2 + var_130_7 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_2) / var_130_7

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_2 + var_130_7 and arg_127_1.time_ < var_130_2 + var_130_7 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play319601032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 319601032
		arg_131_1.duration_ = 10.53

		local var_131_0 = {
			zh = 7.166,
			ja = 10.533
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
				arg_131_0:Play319601033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["4037ui_story"]) and arg_131_1.var_.characterEffect4037ui_story == nil then
				arg_131_1.var_.characterEffect4037ui_story = arg_131_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.200000002980232

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["4037ui_story"]) then
				if arg_131_1.var_.characterEffect4037ui_story and not isNil(arg_131_1.actors_["4037ui_story"]) then
					arg_131_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["4037ui_story"]) and arg_131_1.var_.characterEffect4037ui_story then
				arg_131_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_1")
			end

			local var_134_2 = 0
			local var_134_3 = 0.775

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_2 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				arg_131_1.leftNameTxt_.text = arg_131_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_4 = arg_131_1:GetWordFromCfg(319601032)
				local var_134_5 = arg_131_1:FormatText(var_134_4.content)

				arg_131_1.text_.text = var_134_5

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_7 = 31 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 31)

				if (31 <= 0 and var_134_3 or var_134_3 * (utf8.len(var_134_5) / 31)) > 0 and var_134_3 < var_134_7 then
					arg_131_1.talkMaxDuration = var_134_7

					if var_134_7 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_7 + var_134_2
					end
				end

				arg_131_1.text_.text = var_134_5
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601032", "story_v_out_319601.awb") ~= 0 then
					local var_134_8 = manager.audio:GetVoiceLength("story_v_out_319601", "319601032", "story_v_out_319601.awb") / 1000

					if var_134_8 + var_134_2 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_8 + var_134_2
					end

					if var_134_4.prefab_name ~= "" and arg_131_1.actors_[var_134_4.prefab_name] ~= nil then
						local var_134_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_4.prefab_name].transform, "story_v_out_319601", "319601032", "story_v_out_319601.awb")

						arg_131_1:RecordAudio("319601032", var_134_9)
						arg_131_1:RecordAudio("319601032", var_134_9)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_319601", "319601032", "story_v_out_319601.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_319601", "319601032", "story_v_out_319601.awb")
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

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play319601033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 319601033
		arg_135_1.duration_ = 12.8

		local var_135_0 = {
			zh = 5.6,
			ja = 12.8
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
				arg_135_0:Play319601034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if arg_135_1.actors_["4040ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4040ui_story"))) then
				local var_138_0 = Object.Instantiate(Asset.Load("Char/" .. "4040ui_story"), arg_135_1.stage_.transform)

				var_138_0.name = "4040ui_story"
				var_138_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_135_1.actors_["4040ui_story"] = var_138_0

				local var_138_1 = var_138_0:GetComponentInChildren(typeof(CharacterEffect))

				var_138_1.enabled = true

				local var_138_2 = GameObjectTools.GetOrAddComponent(var_138_0, typeof(DynamicBoneHelper))

				if var_138_2 then
					var_138_2:EnableDynamicBone(false)
				end

				arg_135_1:ShowWeapon(var_138_1.transform, false)

				arg_135_1.var_["4040ui_story" .. "Animator"] = var_138_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_135_1.var_["4040ui_story" .. "Animator"].applyRootMotion = true
				arg_135_1.var_["4040ui_story" .. "LipSync"] = var_138_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_138_3 = arg_135_1.actors_["4040ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos4040ui_story = var_138_3.localPosition
			end

			local var_138_4 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				var_138_3.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_135_1.time_ - 0) / var_138_4)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				var_138_3.localPosition = Vector3.New(0, -1.55, -5.5)
				var_138_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_3.position).x, (manager.ui.mainCamera.transform.position - var_138_3.position).y, (manager.ui.mainCamera.transform.position - var_138_3.position).z)
				var_138_3.localEulerAngles.z = 0
				var_138_3.localEulerAngles.x = 0
				var_138_3.localEulerAngles = var_138_3.localEulerAngles
			end

			local var_138_5 = arg_135_1.actors_["4040ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect4040ui_story == nil then
				arg_135_1.var_.characterEffect4040ui_story = var_138_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_6 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_6 and not isNil(var_138_5) then
				if arg_135_1.var_.characterEffect4040ui_story and not isNil(var_138_5) then
					arg_135_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_6 and arg_135_1.time_ < 0 + var_138_6 + arg_138_0 and not isNil(var_138_5) and arg_135_1.var_.characterEffect4040ui_story then
				arg_135_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action2_1")
			end

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_138_8 = arg_135_1.actors_["4037ui_story"].transform

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.var_.moveOldPos4037ui_story = var_138_8.localPosition
			end

			local var_138_9 = 0.001

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_9 then
				var_138_8.localPosition = Vector3.Lerp(arg_135_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_135_1.time_ - 0) / var_138_9)
				var_138_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_8.position).x, (manager.ui.mainCamera.transform.position - var_138_8.position).y, (manager.ui.mainCamera.transform.position - var_138_8.position).z)
				var_138_8.localEulerAngles.z = 0
				var_138_8.localEulerAngles.x = 0
				var_138_8.localEulerAngles = var_138_8.localEulerAngles
			end

			if arg_135_1.time_ >= 0 + var_138_9 and arg_135_1.time_ < 0 + var_138_9 + arg_138_0 then
				var_138_8.localPosition = Vector3.New(0, 100, 0)
				var_138_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_138_8.position).x, (manager.ui.mainCamera.transform.position - var_138_8.position).y, (manager.ui.mainCamera.transform.position - var_138_8.position).z)
				var_138_8.localEulerAngles.z = 0
				var_138_8.localEulerAngles.x = 0
				var_138_8.localEulerAngles = var_138_8.localEulerAngles
			end

			local var_138_10 = arg_135_1.actors_["4037ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_10) and arg_135_1.var_.characterEffect4037ui_story == nil then
				arg_135_1.var_.characterEffect4037ui_story = var_138_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_11 = 0.200000002980232

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_11 and not isNil(var_138_10) then
				if arg_135_1.var_.characterEffect4037ui_story and not isNil(var_138_10) then
					arg_135_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_135_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_135_1.time_ - 0) / var_138_11)
				end
			end

			if arg_135_1.time_ >= 0 + var_138_11 and arg_135_1.time_ < 0 + var_138_11 + arg_138_0 and not isNil(var_138_10) and arg_135_1.var_.characterEffect4037ui_story then
				arg_135_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_135_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_138_12 = 0
			local var_138_13 = 0.525

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_12 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_14 = arg_135_1:GetWordFromCfg(319601033)
				local var_138_15 = arg_135_1:FormatText(var_138_14.content)

				arg_135_1.text_.text = var_138_15

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_17 = 21 <= 0 and var_138_13 or var_138_13 * (utf8.len(var_138_15) / 21)

				if (21 <= 0 and var_138_13 or var_138_13 * (utf8.len(var_138_15) / 21)) > 0 and var_138_13 < var_138_17 then
					arg_135_1.talkMaxDuration = var_138_17

					if var_138_17 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_12
					end
				end

				arg_135_1.text_.text = var_138_15
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601033", "story_v_out_319601.awb") ~= 0 then
					local var_138_18 = manager.audio:GetVoiceLength("story_v_out_319601", "319601033", "story_v_out_319601.awb") / 1000

					if var_138_18 + var_138_12 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_12
					end

					if var_138_14.prefab_name ~= "" and arg_135_1.actors_[var_138_14.prefab_name] ~= nil then
						local var_138_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_14.prefab_name].transform, "story_v_out_319601", "319601033", "story_v_out_319601.awb")

						arg_135_1:RecordAudio("319601033", var_138_19)
						arg_135_1:RecordAudio("319601033", var_138_19)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_319601", "319601033", "story_v_out_319601.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_319601", "319601033", "story_v_out_319601.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_20 = math.max(var_138_13, arg_135_1.talkMaxDuration)

			if var_138_12 <= arg_135_1.time_ and arg_135_1.time_ < var_138_12 + var_138_20 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_12) / var_138_20

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_12 + var_138_20 and arg_135_1.time_ < var_138_12 + var_138_20 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play319601034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 319601034
		arg_139_1.duration_ = 18.33

		local var_139_0 = {
			zh = 7.3,
			ja = 18.333
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
				arg_139_0:Play319601035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos4037ui_story = arg_139_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["4037ui_story"].transform.position).z)
				arg_139_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["4037ui_story"].transform.localEulerAngles = arg_139_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_139_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["4037ui_story"].transform.position).z)
				arg_139_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["4037ui_story"].transform.localEulerAngles = arg_139_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["4037ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect4037ui_story == nil then
				arg_139_1.var_.characterEffect4037ui_story = var_142_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 and not isNil(var_142_1) then
				if arg_139_1.var_.characterEffect4037ui_story and not isNil(var_142_1) then
					arg_139_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 and not isNil(var_142_1) and arg_139_1.var_.characterEffect4037ui_story then
				arg_139_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action2_2")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_142_4 = arg_139_1.actors_["4040ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos4040ui_story = var_142_4.localPosition
			end

			local var_142_5 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_5 then
				var_142_4.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_5)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_5 and arg_139_1.time_ < 0 + var_142_5 + arg_142_0 then
				var_142_4.localPosition = Vector3.New(0, 100, 0)
				var_142_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_4.position).x, (manager.ui.mainCamera.transform.position - var_142_4.position).y, (manager.ui.mainCamera.transform.position - var_142_4.position).z)
				var_142_4.localEulerAngles.z = 0
				var_142_4.localEulerAngles.x = 0
				var_142_4.localEulerAngles = var_142_4.localEulerAngles
			end

			local var_142_6 = arg_139_1.actors_["4040ui_story"]

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect4040ui_story == nil then
				arg_139_1.var_.characterEffect4040ui_story = var_142_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_7 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_7 and not isNil(var_142_6) then
				if arg_139_1.var_.characterEffect4040ui_story and not isNil(var_142_6) then
					arg_139_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_139_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_139_1.time_ - 0) / var_142_7)
				end
			end

			if arg_139_1.time_ >= 0 + var_142_7 and arg_139_1.time_ < 0 + var_142_7 + arg_142_0 and not isNil(var_142_6) and arg_139_1.var_.characterEffect4040ui_story then
				arg_139_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_139_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_142_8 = 0
			local var_142_9 = 0.7

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_8 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_10 = arg_139_1:GetWordFromCfg(319601034)
				local var_142_11 = arg_139_1:FormatText(var_142_10.content)

				arg_139_1.text_.text = var_142_11

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_13 = 28 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 28)

				if (28 <= 0 and var_142_9 or var_142_9 * (utf8.len(var_142_11) / 28)) > 0 and var_142_9 < var_142_13 then
					arg_139_1.talkMaxDuration = var_142_13

					if var_142_13 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_13 + var_142_8
					end
				end

				arg_139_1.text_.text = var_142_11
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601034", "story_v_out_319601.awb") ~= 0 then
					local var_142_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601034", "story_v_out_319601.awb") / 1000

					if var_142_14 + var_142_8 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_14 + var_142_8
					end

					if var_142_10.prefab_name ~= "" and arg_139_1.actors_[var_142_10.prefab_name] ~= nil then
						local var_142_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_10.prefab_name].transform, "story_v_out_319601", "319601034", "story_v_out_319601.awb")

						arg_139_1:RecordAudio("319601034", var_142_15)
						arg_139_1:RecordAudio("319601034", var_142_15)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_319601", "319601034", "story_v_out_319601.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_319601", "319601034", "story_v_out_319601.awb")
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
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319601035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 319601035
		arg_143_1.duration_ = 12.63

		local var_143_0 = {
			zh = 9.266,
			ja = 12.633
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
				arg_143_0:Play319601036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos4040ui_story = arg_143_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4040ui_story"].transform.position).z)
				arg_143_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["4040ui_story"].transform.localEulerAngles = arg_143_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_143_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["4040ui_story"].transform.position).z)
				arg_143_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["4040ui_story"].transform.localEulerAngles = arg_143_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_146_1 = arg_143_1.actors_["4040ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect4040ui_story == nil then
				arg_143_1.var_.characterEffect4040ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect4040ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect4040ui_story then
				arg_143_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_4 = arg_143_1.actors_["4037ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos4037ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_143_1.time_ - 0) / var_146_5)
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

			local var_146_6 = arg_143_1.actors_["4037ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect4037ui_story == nil then
				arg_143_1.var_.characterEffect4037ui_story = var_146_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_7 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_7 and not isNil(var_146_6) then
				if arg_143_1.var_.characterEffect4037ui_story and not isNil(var_146_6) then
					arg_143_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_143_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_7)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_7 and arg_143_1.time_ < 0 + var_146_7 + arg_146_0 and not isNil(var_146_6) and arg_143_1.var_.characterEffect4037ui_story then
				arg_143_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_143_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_146_8 = 0
			local var_146_9 = 0.9

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_8 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_10 = arg_143_1:GetWordFromCfg(319601035)
				local var_146_11 = arg_143_1:FormatText(var_146_10.content)

				arg_143_1.text_.text = var_146_11

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_13 = 36 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 36)

				if (36 <= 0 and var_146_9 or var_146_9 * (utf8.len(var_146_11) / 36)) > 0 and var_146_9 < var_146_13 then
					arg_143_1.talkMaxDuration = var_146_13

					if var_146_13 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_13 + var_146_8
					end
				end

				arg_143_1.text_.text = var_146_11
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601035", "story_v_out_319601.awb") ~= 0 then
					local var_146_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601035", "story_v_out_319601.awb") / 1000

					if var_146_14 + var_146_8 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_14 + var_146_8
					end

					if var_146_10.prefab_name ~= "" and arg_143_1.actors_[var_146_10.prefab_name] ~= nil then
						local var_146_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_10.prefab_name].transform, "story_v_out_319601", "319601035", "story_v_out_319601.awb")

						arg_143_1:RecordAudio("319601035", var_146_15)
						arg_143_1:RecordAudio("319601035", var_146_15)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_319601", "319601035", "story_v_out_319601.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_319601", "319601035", "story_v_out_319601.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_16 = math.max(var_146_9, arg_143_1.talkMaxDuration)

			if var_146_8 <= arg_143_1.time_ and arg_143_1.time_ < var_146_8 + var_146_16 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_8) / var_146_16

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_8 + var_146_16 and arg_143_1.time_ < var_146_8 + var_146_16 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play319601036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 319601036
		arg_147_1.duration_ = 12.67

		local var_147_0 = {
			zh = 1.933,
			ja = 12.666
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
				arg_147_0:Play319601037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos4037ui_story = arg_147_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["4037ui_story"].transform.position).z)
				arg_147_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["4037ui_story"].transform.localEulerAngles = arg_147_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_147_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["4037ui_story"].transform.position).z)
				arg_147_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["4037ui_story"].transform.localEulerAngles = arg_147_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_150_1 = arg_147_1.actors_["4037ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect4037ui_story == nil then
				arg_147_1.var_.characterEffect4037ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect4037ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect4037ui_story then
				arg_147_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_4 = arg_147_1.actors_["4040ui_story"].transform

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos4040ui_story = var_150_4.localPosition
			end

			local var_150_5 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 then
				var_150_4.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_147_1.time_ - 0) / var_150_5)
				var_150_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_4.position).x, (manager.ui.mainCamera.transform.position - var_150_4.position).y, (manager.ui.mainCamera.transform.position - var_150_4.position).z)
				var_150_4.localEulerAngles.z = 0
				var_150_4.localEulerAngles.x = 0
				var_150_4.localEulerAngles = var_150_4.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 then
				var_150_4.localPosition = Vector3.New(0, 100, 0)
				var_150_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_150_4.position).x, (manager.ui.mainCamera.transform.position - var_150_4.position).y, (manager.ui.mainCamera.transform.position - var_150_4.position).z)
				var_150_4.localEulerAngles.z = 0
				var_150_4.localEulerAngles.x = 0
				var_150_4.localEulerAngles = var_150_4.localEulerAngles
			end

			local var_150_6 = arg_147_1.actors_["4040ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect4040ui_story == nil then
				arg_147_1.var_.characterEffect4040ui_story = var_150_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_7 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_7 and not isNil(var_150_6) then
				if arg_147_1.var_.characterEffect4040ui_story and not isNil(var_150_6) then
					arg_147_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_147_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_7)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_7 and arg_147_1.time_ < 0 + var_150_7 + arg_150_0 and not isNil(var_150_6) and arg_147_1.var_.characterEffect4040ui_story then
				arg_147_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_147_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_150_8 = 0
			local var_150_9 = 0.175

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_8 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_10 = arg_147_1:GetWordFromCfg(319601036)
				local var_150_11 = arg_147_1:FormatText(var_150_10.content)

				arg_147_1.text_.text = var_150_11

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_13 = 7 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 7)

				if (7 <= 0 and var_150_9 or var_150_9 * (utf8.len(var_150_11) / 7)) > 0 and var_150_9 < var_150_13 then
					arg_147_1.talkMaxDuration = var_150_13

					if var_150_13 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_13 + var_150_8
					end
				end

				arg_147_1.text_.text = var_150_11
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601036", "story_v_out_319601.awb") ~= 0 then
					local var_150_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601036", "story_v_out_319601.awb") / 1000

					if var_150_14 + var_150_8 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_14 + var_150_8
					end

					if var_150_10.prefab_name ~= "" and arg_147_1.actors_[var_150_10.prefab_name] ~= nil then
						local var_150_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_10.prefab_name].transform, "story_v_out_319601", "319601036", "story_v_out_319601.awb")

						arg_147_1:RecordAudio("319601036", var_150_15)
						arg_147_1:RecordAudio("319601036", var_150_15)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_319601", "319601036", "story_v_out_319601.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_319601", "319601036", "story_v_out_319601.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_16 = math.max(var_150_9, arg_147_1.talkMaxDuration)

			if var_150_8 <= arg_147_1.time_ and arg_147_1.time_ < var_150_8 + var_150_16 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_8) / var_150_16

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_8 + var_150_16 and arg_147_1.time_ < var_150_8 + var_150_16 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319601037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 319601037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play319601038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["4037ui_story"]) and arg_151_1.var_.characterEffect4037ui_story == nil then
				arg_151_1.var_.characterEffect4037ui_story = arg_151_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["4037ui_story"]) then
				if arg_151_1.var_.characterEffect4037ui_story and not isNil(arg_151_1.actors_["4037ui_story"]) then
					arg_151_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_151_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["4037ui_story"]) and arg_151_1.var_.characterEffect4037ui_story then
				arg_151_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_151_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 1.2

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, false)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(319601037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 48 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 48)

				if (48 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 48)) > 0 and var_154_2 < var_154_5 then
					arg_151_1.talkMaxDuration = var_154_5

					if var_154_5 + var_154_1 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_5 + var_154_1
					end
				end

				arg_151_1.text_.text = var_154_3
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_6 = math.max(var_154_2, arg_151_1.talkMaxDuration)

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_6 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_1) / var_154_6

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_1 + var_154_6 and arg_151_1.time_ < var_154_1 + var_154_6 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play319601038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 319601038
		arg_155_1.duration_ = 12.33

		local var_155_0 = {
			zh = 5.9,
			ja = 12.333
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
				arg_155_0:Play319601039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos4040ui_story = arg_155_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4040ui_story"].transform.position).z)
				arg_155_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["4040ui_story"].transform.localEulerAngles = arg_155_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_155_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["4040ui_story"].transform.position).z)
				arg_155_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["4040ui_story"].transform.localEulerAngles = arg_155_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["4040ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect4040ui_story == nil then
				arg_155_1.var_.characterEffect4040ui_story = var_158_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 and not isNil(var_158_1) then
				if arg_155_1.var_.characterEffect4040ui_story and not isNil(var_158_1) then
					arg_155_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 and not isNil(var_158_1) and arg_155_1.var_.characterEffect4040ui_story then
				arg_155_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action7_1")
			end

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva")
			end

			local var_158_4 = arg_155_1.actors_["4037ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos4037ui_story = var_158_4.localPosition
			end

			local var_158_5 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_5 then
				var_158_4.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_5)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_5 and arg_155_1.time_ < 0 + var_158_5 + arg_158_0 then
				var_158_4.localPosition = Vector3.New(0, 100, 0)
				var_158_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_4.position).x, (manager.ui.mainCamera.transform.position - var_158_4.position).y, (manager.ui.mainCamera.transform.position - var_158_4.position).z)
				var_158_4.localEulerAngles.z = 0
				var_158_4.localEulerAngles.x = 0
				var_158_4.localEulerAngles = var_158_4.localEulerAngles
			end

			local var_158_6 = arg_155_1.actors_["4037ui_story"]

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect4037ui_story == nil then
				arg_155_1.var_.characterEffect4037ui_story = var_158_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_7 = 0.200000002980232

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_7 and not isNil(var_158_6) then
				if arg_155_1.var_.characterEffect4037ui_story and not isNil(var_158_6) then
					arg_155_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_155_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_155_1.time_ - 0) / var_158_7)
				end
			end

			if arg_155_1.time_ >= 0 + var_158_7 and arg_155_1.time_ < 0 + var_158_7 + arg_158_0 and not isNil(var_158_6) and arg_155_1.var_.characterEffect4037ui_story then
				arg_155_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_155_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_158_8 = 0
			local var_158_9 = 0.4

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_8 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_10 = arg_155_1:GetWordFromCfg(319601038)
				local var_158_11 = arg_155_1:FormatText(var_158_10.content)

				arg_155_1.text_.text = var_158_11

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_13 = 16 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 16)

				if (16 <= 0 and var_158_9 or var_158_9 * (utf8.len(var_158_11) / 16)) > 0 and var_158_9 < var_158_13 then
					arg_155_1.talkMaxDuration = var_158_13

					if var_158_13 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_13 + var_158_8
					end
				end

				arg_155_1.text_.text = var_158_11
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601038", "story_v_out_319601.awb") ~= 0 then
					local var_158_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601038", "story_v_out_319601.awb") / 1000

					if var_158_14 + var_158_8 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_14 + var_158_8
					end

					if var_158_10.prefab_name ~= "" and arg_155_1.actors_[var_158_10.prefab_name] ~= nil then
						local var_158_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_10.prefab_name].transform, "story_v_out_319601", "319601038", "story_v_out_319601.awb")

						arg_155_1:RecordAudio("319601038", var_158_15)
						arg_155_1:RecordAudio("319601038", var_158_15)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_319601", "319601038", "story_v_out_319601.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_319601", "319601038", "story_v_out_319601.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_16 = math.max(var_158_9, arg_155_1.talkMaxDuration)

			if var_158_8 <= arg_155_1.time_ and arg_155_1.time_ < var_158_8 + var_158_16 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_8) / var_158_16

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_8 + var_158_16 and arg_155_1.time_ < var_158_8 + var_158_16 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
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
	Play319601039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 319601039
		arg_159_1.duration_ = 1.93

		local var_159_0 = {
			zh = 1.933,
			ja = 1.3
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
				arg_159_0:Play319601040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos4037ui_story = arg_159_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_162_0 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 then
				arg_159_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_159_1.time_ - 0) / var_162_0)
				arg_159_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4037ui_story"].transform.position).z)
				arg_159_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["4037ui_story"].transform.localEulerAngles = arg_159_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 then
				arg_159_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_159_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_159_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_159_1.actors_["4037ui_story"].transform.position).z)
				arg_159_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_159_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_159_1.actors_["4037ui_story"].transform.localEulerAngles = arg_159_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_162_1 = arg_159_1.actors_["4037ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect4037ui_story == nil then
				arg_159_1.var_.characterEffect4037ui_story = var_162_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_2 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_2 and not isNil(var_162_1) then
				if arg_159_1.var_.characterEffect4037ui_story and not isNil(var_162_1) then
					arg_159_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_2 and arg_159_1.time_ < 0 + var_162_2 + arg_162_0 and not isNil(var_162_1) and arg_159_1.var_.characterEffect4037ui_story then
				arg_159_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_162_4 = arg_159_1.actors_["4040ui_story"].transform

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.var_.moveOldPos4040ui_story = var_162_4.localPosition
			end

			local var_162_5 = 0.001

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_5 then
				var_162_4.localPosition = Vector3.Lerp(arg_159_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_159_1.time_ - 0) / var_162_5)
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

			local var_162_6 = arg_159_1.actors_["4040ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect4040ui_story == nil then
				arg_159_1.var_.characterEffect4040ui_story = var_162_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_7 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_7 and not isNil(var_162_6) then
				if arg_159_1.var_.characterEffect4040ui_story and not isNil(var_162_6) then
					arg_159_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_159_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_7)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_7 and arg_159_1.time_ < 0 + var_162_7 + arg_162_0 and not isNil(var_162_6) and arg_159_1.var_.characterEffect4040ui_story then
				arg_159_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_159_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_162_8 = 0
			local var_162_9 = 0.1

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_8 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_10 = arg_159_1:GetWordFromCfg(319601039)
				local var_162_11 = arg_159_1:FormatText(var_162_10.content)

				arg_159_1.text_.text = var_162_11

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_13 = 4 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 4)

				if (4 <= 0 and var_162_9 or var_162_9 * (utf8.len(var_162_11) / 4)) > 0 and var_162_9 < var_162_13 then
					arg_159_1.talkMaxDuration = var_162_13

					if var_162_13 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_13 + var_162_8
					end
				end

				arg_159_1.text_.text = var_162_11
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601039", "story_v_out_319601.awb") ~= 0 then
					local var_162_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601039", "story_v_out_319601.awb") / 1000

					if var_162_14 + var_162_8 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_14 + var_162_8
					end

					if var_162_10.prefab_name ~= "" and arg_159_1.actors_[var_162_10.prefab_name] ~= nil then
						local var_162_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_10.prefab_name].transform, "story_v_out_319601", "319601039", "story_v_out_319601.awb")

						arg_159_1:RecordAudio("319601039", var_162_15)
						arg_159_1:RecordAudio("319601039", var_162_15)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_319601", "319601039", "story_v_out_319601.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_319601", "319601039", "story_v_out_319601.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_16 = math.max(var_162_9, arg_159_1.talkMaxDuration)

			if var_162_8 <= arg_159_1.time_ and arg_159_1.time_ < var_162_8 + var_162_16 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_8) / var_162_16

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_8 + var_162_16 and arg_159_1.time_ < var_162_8 + var_162_16 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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
	Play319601040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 319601040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play319601041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos4037ui_story = arg_163_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4037ui_story"].transform.position).z)
				arg_163_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4037ui_story"].transform.localEulerAngles = arg_163_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_163_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["4037ui_story"].transform.position).z)
				arg_163_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["4037ui_story"].transform.localEulerAngles = arg_163_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_166_1 = arg_163_1.actors_["4037ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4037ui_story == nil then
				arg_163_1.var_.characterEffect4037ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect4037ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_163_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_2)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect4037ui_story then
				arg_163_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_163_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "effect", "se_story_122_02", "se_story_122_02_punch", "")
			end

			local var_166_4 = manager.ui.mainCamera.transform

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.shakeOldPos = var_166_4.localPosition
			end

			local var_166_5 = 0.6

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_5 then
				local var_166_6, var_166_7 = math.modf((arg_163_1.time_ - 0) / 0.066)

				var_166_4.localPosition = Vector3.New(var_166_7 * 0.13, var_166_7 * 0.13, var_166_7 * 0.13) + arg_163_1.var_.shakeOldPos
			end

			if arg_163_1.time_ >= 0 + var_166_5 and arg_163_1.time_ < 0 + var_166_5 + arg_166_0 then
				var_166_4.localPosition = arg_163_1.var_.shakeOldPos
			end

			local var_166_8 = 0

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_8 + arg_166_0 then
				arg_163_1.allBtn_.enabled = false
			end

			if arg_163_1.time_ >= var_166_8 + 0.6 and arg_163_1.time_ < var_166_8 + 0.6 + arg_166_0 then
				arg_163_1.allBtn_.enabled = true
			end

			local var_166_9 = 0
			local var_166_10 = 1.075

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_9 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, false)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_11 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(319601040).content)

				arg_163_1.text_.text = var_166_11

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_13 = 43 <= 0 and var_166_10 or var_166_10 * (utf8.len(var_166_11) / 43)

				if (43 <= 0 and var_166_10 or var_166_10 * (utf8.len(var_166_11) / 43)) > 0 and var_166_10 < var_166_13 then
					arg_163_1.talkMaxDuration = var_166_13

					if var_166_13 + var_166_9 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_9
					end
				end

				arg_163_1.text_.text = var_166_11
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_14 = math.max(var_166_10, arg_163_1.talkMaxDuration)

			if var_166_9 <= arg_163_1.time_ and arg_163_1.time_ < var_166_9 + var_166_14 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_9) / var_166_14

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_9 + var_166_14 and arg_163_1.time_ < var_166_9 + var_166_14 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play319601041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 319601041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play319601042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = 1.175

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, false)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_1 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(319601041).content)

				arg_167_1.text_.text = var_170_1

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_3 = 47 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 47)

				if (47 <= 0 and var_170_0 or var_170_0 * (utf8.len(var_170_1) / 47)) > 0 and var_170_0 < var_170_3 then
					arg_167_1.talkMaxDuration = var_170_3

					if var_170_3 + 0 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_3 + 0
					end
				end

				arg_167_1.text_.text = var_170_1
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_4 = math.max(var_170_0, arg_167_1.talkMaxDuration)

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_4 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - 0) / var_170_4

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= 0 + var_170_4 and arg_167_1.time_ < 0 + var_170_4 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play319601042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 319601042
		arg_171_1.duration_ = 2

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play319601043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1.var_.moveOldPos10079ui_story = arg_171_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_174_0 = 0.001

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 then
				arg_171_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_171_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_171_1.time_ - 0) / var_174_0)
				arg_171_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10079ui_story"].transform.position).z)
				arg_171_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10079ui_story"].transform.localEulerAngles = arg_171_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 then
				arg_171_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_171_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_171_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_171_1.actors_["10079ui_story"].transform.position).z)
				arg_171_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_171_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_171_1.actors_["10079ui_story"].transform.localEulerAngles = arg_171_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_174_1 = arg_171_1.actors_["10079ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10079ui_story == nil then
				arg_171_1.var_.characterEffect10079ui_story = var_174_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_2 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_2 and not isNil(var_174_1) then
				if arg_171_1.var_.characterEffect10079ui_story and not isNil(var_174_1) then
					arg_171_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_2 and arg_171_1.time_ < 0 + var_174_2 + arg_174_0 and not isNil(var_174_1) and arg_171_1.var_.characterEffect10079ui_story then
				arg_171_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_174_4 = 0
			local var_174_5 = 0.075

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:GetWordFromCfg(319601042)
				local var_174_7 = arg_171_1:FormatText(var_174_6.content)

				arg_171_1.text_.text = var_174_7

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_9 = 3 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 3)

				if (3 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_7) / 3)) > 0 and var_174_5 < var_174_9 then
					arg_171_1.talkMaxDuration = var_174_9

					if var_174_9 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_9 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_7
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601042", "story_v_out_319601.awb") ~= 0 then
					local var_174_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601042", "story_v_out_319601.awb") / 1000

					if var_174_10 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_10 + var_174_4
					end

					if var_174_6.prefab_name ~= "" and arg_171_1.actors_[var_174_6.prefab_name] ~= nil then
						local var_174_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_6.prefab_name].transform, "story_v_out_319601", "319601042", "story_v_out_319601.awb")

						arg_171_1:RecordAudio("319601042", var_174_11)
						arg_171_1:RecordAudio("319601042", var_174_11)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_319601", "319601042", "story_v_out_319601.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_319601", "319601042", "story_v_out_319601.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_12 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_12 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_12

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_12 and arg_171_1.time_ < var_174_4 + var_174_12 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {
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

		arg_171_1:InitPlayNodeList()
	end,
	Play319601043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 319601043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play319601044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_9000

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(arg_175_1.actors_["10079ui_story"]) and arg_175_1.var_.characterEffect10079ui_story == nil then
				arg_175_1.var_.characterEffect10079ui_story = arg_175_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_0 = 0.200000002980232

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 and not isNil(arg_175_1.actors_["10079ui_story"]) then
				if arg_175_1.var_.characterEffect10079ui_story and not isNil(arg_175_1.actors_["10079ui_story"]) then
					arg_175_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_175_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_175_1.time_ - 0) / var_178_0)
				end
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 and not isNil(arg_175_1.actors_["10079ui_story"]) and arg_175_1.var_.characterEffect10079ui_story then
				arg_175_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_175_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_178_1 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_1 + arg_178_0 then
				arg_175_1.mask_.enabled = true
				arg_175_1.mask_.raycastTarget = true

				arg_175_1:SetGaussion(false)
			end

			local var_178_2 = 0.200000002980232

			if var_178_1 <= arg_175_1.time_ and arg_175_1.time_ < var_178_1 + var_178_2 then
				local var_178_3 = Color.New(1, 1, 1)

				var_178_3.a = Mathf.Lerp(1, 0, (arg_175_1.time_ - var_178_1) / var_178_2)
				arg_175_1.mask_.color = var_178_3
			end

			if arg_175_1.time_ >= var_178_1 + var_178_2 and arg_175_1.time_ < var_178_1 + var_178_2 + arg_178_0 then
				local var_178_4 = Color.New(1, 1, 1)

				arg_175_1.mask_.enabled = false
				var_178_4.a = 0
				arg_175_1.mask_.color = var_178_4
			end

			local var_178_5 = manager.ui.mainCamera.transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.shakeOldPos = var_178_5.localPosition
			end

			local var_178_6 = 1

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_6 then
				local var_178_7, var_178_8 = math.modf((arg_175_1.time_ - 0) / 0.066)

				var_178_5.localPosition = Vector3.New(var_178_8 * 0.13, var_178_8 * 0.13, var_178_8 * 0.13) + arg_175_1.var_.shakeOldPos
			end

			if arg_175_1.time_ >= 0 + var_178_6 and arg_175_1.time_ < 0 + var_178_6 + arg_178_0 then
				var_178_5.localPosition = arg_175_1.var_.shakeOldPos
			end

			local var_178_9 = arg_175_1.actors_["10079ui_story"].transform

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos10079ui_story = var_178_9.localPosition
			end

			local var_178_10 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_10 then
				var_178_9.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_175_1.time_ - 0) / var_178_10)
				var_178_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_9.position).x, (manager.ui.mainCamera.transform.position - var_178_9.position).y, (manager.ui.mainCamera.transform.position - var_178_9.position).z)
				var_178_9.localEulerAngles.z = 0
				var_178_9.localEulerAngles.x = 0
				var_178_9.localEulerAngles = var_178_9.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_10 and arg_175_1.time_ < 0 + var_178_10 + arg_178_0 then
				var_178_9.localPosition = Vector3.New(0, 100, 0)
				var_178_9.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_178_9.position).x, (manager.ui.mainCamera.transform.position - var_178_9.position).y, (manager.ui.mainCamera.transform.position - var_178_9.position).z)
				var_178_9.localEulerAngles.z = 0
				var_178_9.localEulerAngles.x = 0
				var_178_9.localEulerAngles = var_178_9.localEulerAngles
			end

			local var_178_11 = 0

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_11 + arg_178_0 then
				arg_175_1.allBtn_.enabled = false
			end

			if arg_175_1.time_ >= var_178_11 + 1 and arg_175_1.time_ < var_178_11 + 1 + arg_178_0 then
				arg_175_1.allBtn_.enabled = true
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				local var_178_12 = arg_175_1.var_.effect薇儿挡剑

				if not arg_175_1.var_.effect薇儿挡剑 then
					var_178_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_178_12.name = "薇儿挡剑"
					arg_175_1.var_.effect薇儿挡剑 = var_178_12
				else
					var_178_12.transform:SetParent(var_178_9000)
				end

				var_178_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_178_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 1 < arg_175_1.time_ and arg_175_1.time_ <= 1 + arg_178_0 then
				if arg_175_1.var_.effect薇儿挡剑 then
					Object.Destroy(arg_175_1.var_.effect薇儿挡剑)

					arg_175_1.var_.effect薇儿挡剑 = nil
				end
			end

			local var_178_15 = 0
			local var_178_16 = 0.875

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_15 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, false)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_17 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(319601043).content)

				arg_175_1.text_.text = var_178_17

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_19 = 35 <= 0 and var_178_16 or var_178_16 * (utf8.len(var_178_17) / 35)

				if (35 <= 0 and var_178_16 or var_178_16 * (utf8.len(var_178_17) / 35)) > 0 and var_178_16 < var_178_19 then
					arg_175_1.talkMaxDuration = var_178_19

					if var_178_19 + var_178_15 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_19 + var_178_15
					end
				end

				arg_175_1.text_.text = var_178_17
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_20 = math.max(var_178_16, arg_175_1.talkMaxDuration)

			if var_178_15 <= arg_175_1.time_ and arg_175_1.time_ < var_178_15 + var_178_20 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_15) / var_178_20

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_15 + var_178_20 and arg_175_1.time_ < var_178_15 + var_178_20 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play319601044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 319601044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play319601045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:AudioAction("play", "effect", "se_story_122_03", "se_story_122_03_hit", "")
			end

			local var_182_1 = 0
			local var_182_2 = 1.425

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, false)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(319601044).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 57 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 57)

				if (57 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 57)) > 0 and var_182_2 < var_182_5 then
					arg_179_1.talkMaxDuration = var_182_5

					if var_182_5 + var_182_1 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_5 + var_182_1
					end
				end

				arg_179_1.text_.text = var_182_3
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_6 = math.max(var_182_2, arg_179_1.talkMaxDuration)

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_6 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_1) / var_182_6

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_1 + var_182_6 and arg_179_1.time_ < var_182_1 + var_182_6 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {}

		arg_179_1:InitPlayNodeList()
	end,
	Play319601045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 319601045
		arg_183_1.duration_ = 6.07

		local var_183_0 = {
			zh = 1.999999999999,
			ja = 6.066
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
				arg_183_0:Play319601046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["10079ui_story"]) and arg_183_1.var_.characterEffect10079ui_story == nil then
				arg_183_1.var_.characterEffect10079ui_story = arg_183_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["10079ui_story"]) then
				if arg_183_1.var_.characterEffect10079ui_story and not isNil(arg_183_1.actors_["10079ui_story"]) then
					arg_183_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["10079ui_story"]) and arg_183_1.var_.characterEffect10079ui_story then
				arg_183_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			local var_186_2 = arg_183_1.actors_["10079ui_story"].transform

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.moveOldPos10079ui_story = var_186_2.localPosition
			end

			local var_186_3 = 0.001

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_3 then
				var_186_2.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_183_1.time_ - 0) / var_186_3)
				var_186_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_2.position).x, (manager.ui.mainCamera.transform.position - var_186_2.position).y, (manager.ui.mainCamera.transform.position - var_186_2.position).z)
				var_186_2.localEulerAngles.z = 0
				var_186_2.localEulerAngles.x = 0
				var_186_2.localEulerAngles = var_186_2.localEulerAngles
			end

			if arg_183_1.time_ >= 0 + var_186_3 and arg_183_1.time_ < 0 + var_186_3 + arg_186_0 then
				var_186_2.localPosition = Vector3.New(0, -0.95, -6.05)
				var_186_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_186_2.position).x, (manager.ui.mainCamera.transform.position - var_186_2.position).y, (manager.ui.mainCamera.transform.position - var_186_2.position).z)
				var_186_2.localEulerAngles.z = 0
				var_186_2.localEulerAngles.x = 0
				var_186_2.localEulerAngles = var_186_2.localEulerAngles
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_186_4 = 0
			local var_186_5 = 0.225

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_4 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_6 = arg_183_1:GetWordFromCfg(319601045)
				local var_186_7 = arg_183_1:FormatText(var_186_6.content)

				arg_183_1.text_.text = var_186_7

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_9 = 9 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 9)

				if (9 <= 0 and var_186_5 or var_186_5 * (utf8.len(var_186_7) / 9)) > 0 and var_186_5 < var_186_9 then
					arg_183_1.talkMaxDuration = var_186_9

					if var_186_9 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_4
					end
				end

				arg_183_1.text_.text = var_186_7
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601045", "story_v_out_319601.awb") ~= 0 then
					local var_186_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601045", "story_v_out_319601.awb") / 1000

					if var_186_10 + var_186_4 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_10 + var_186_4
					end

					if var_186_6.prefab_name ~= "" and arg_183_1.actors_[var_186_6.prefab_name] ~= nil then
						local var_186_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_6.prefab_name].transform, "story_v_out_319601", "319601045", "story_v_out_319601.awb")

						arg_183_1:RecordAudio("319601045", var_186_11)
						arg_183_1:RecordAudio("319601045", var_186_11)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_319601", "319601045", "story_v_out_319601.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_319601", "319601045", "story_v_out_319601.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_12 = math.max(var_186_5, arg_183_1.talkMaxDuration)

			if var_186_4 <= arg_183_1.time_ and arg_183_1.time_ < var_186_4 + var_186_12 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_4) / var_186_12

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_4 + var_186_12 and arg_183_1.time_ < var_186_4 + var_186_12 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {
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

		arg_183_1:InitPlayNodeList()
	end,
	Play319601046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 319601046
		arg_187_1.duration_ = 4.6

		local var_187_0 = {
			zh = 2.066,
			ja = 4.6
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
				arg_187_0:Play319601047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos4040ui_story = arg_187_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_190_0 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_0 then
				arg_187_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos4040ui_story, Vector3.New(0.7, -1.55, -5.5), (arg_187_1.time_ - 0) / var_190_0)
				arg_187_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4040ui_story"].transform.position).z)
				arg_187_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["4040ui_story"].transform.localEulerAngles = arg_187_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_0 and arg_187_1.time_ < 0 + var_190_0 + arg_190_0 then
				arg_187_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0.7, -1.55, -5.5)
				arg_187_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_187_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_187_1.actors_["4040ui_story"].transform.position).z)
				arg_187_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_187_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_187_1.actors_["4040ui_story"].transform.localEulerAngles = arg_187_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_190_1 = arg_187_1.actors_["4040ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect4040ui_story == nil then
				arg_187_1.var_.characterEffect4040ui_story = var_190_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_2 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_2 and not isNil(var_190_1) then
				if arg_187_1.var_.characterEffect4040ui_story and not isNil(var_190_1) then
					arg_187_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 0 + var_190_2 and arg_187_1.time_ < 0 + var_190_2 + arg_190_0 and not isNil(var_190_1) and arg_187_1.var_.characterEffect4040ui_story then
				arg_187_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_4 = arg_187_1.actors_["10079ui_story"].transform

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.var_.moveOldPos10079ui_story = var_190_4.localPosition
			end

			local var_190_5 = 0.001

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_5 then
				var_190_4.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10079ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_187_1.time_ - 0) / var_190_5)
				var_190_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_4.position).x, (manager.ui.mainCamera.transform.position - var_190_4.position).y, (manager.ui.mainCamera.transform.position - var_190_4.position).z)
				var_190_4.localEulerAngles.z = 0
				var_190_4.localEulerAngles.x = 0
				var_190_4.localEulerAngles = var_190_4.localEulerAngles
			end

			if arg_187_1.time_ >= 0 + var_190_5 and arg_187_1.time_ < 0 + var_190_5 + arg_190_0 then
				var_190_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_190_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_4.position).x, (manager.ui.mainCamera.transform.position - var_190_4.position).y, (manager.ui.mainCamera.transform.position - var_190_4.position).z)
				var_190_4.localEulerAngles.z = 0
				var_190_4.localEulerAngles.x = 0
				var_190_4.localEulerAngles = var_190_4.localEulerAngles
			end

			local var_190_6 = arg_187_1.actors_["10079ui_story"]

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect10079ui_story == nil then
				arg_187_1.var_.characterEffect10079ui_story = var_190_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_7 = 0.200000002980232

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_7 and not isNil(var_190_6) then
				if arg_187_1.var_.characterEffect10079ui_story and not isNil(var_190_6) then
					arg_187_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_187_1.time_ - 0) / var_190_7)
				end
			end

			if arg_187_1.time_ >= 0 + var_190_7 and arg_187_1.time_ < 0 + var_190_7 + arg_190_0 and not isNil(var_190_6) and arg_187_1.var_.characterEffect10079ui_story then
				arg_187_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_190_8 = 0
			local var_190_9 = 0.2

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_8 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_10 = arg_187_1:GetWordFromCfg(319601046)
				local var_190_11 = arg_187_1:FormatText(var_190_10.content)

				arg_187_1.text_.text = var_190_11

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_13 = 8 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 8)

				if (8 <= 0 and var_190_9 or var_190_9 * (utf8.len(var_190_11) / 8)) > 0 and var_190_9 < var_190_13 then
					arg_187_1.talkMaxDuration = var_190_13

					if var_190_13 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_13 + var_190_8
					end
				end

				arg_187_1.text_.text = var_190_11
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601046", "story_v_out_319601.awb") ~= 0 then
					local var_190_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601046", "story_v_out_319601.awb") / 1000

					if var_190_14 + var_190_8 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_14 + var_190_8
					end

					if var_190_10.prefab_name ~= "" and arg_187_1.actors_[var_190_10.prefab_name] ~= nil then
						local var_190_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_10.prefab_name].transform, "story_v_out_319601", "319601046", "story_v_out_319601.awb")

						arg_187_1:RecordAudio("319601046", var_190_15)
						arg_187_1:RecordAudio("319601046", var_190_15)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_319601", "319601046", "story_v_out_319601.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_319601", "319601046", "story_v_out_319601.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_16 = math.max(var_190_9, arg_187_1.talkMaxDuration)

			if var_190_8 <= arg_187_1.time_ and arg_187_1.time_ < var_190_8 + var_190_16 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_8) / var_190_16

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_8 + var_190_16 and arg_187_1.time_ < var_190_8 + var_190_16 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_187_1:InitPlayNodeList()
	end,
	Play319601047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 319601047
		arg_191_1.duration_ = 6.57

		local var_191_0 = {
			zh = 4.5,
			ja = 6.566
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
				arg_191_0:Play319601048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(arg_191_1.actors_["4040ui_story"]) and arg_191_1.var_.characterEffect4040ui_story == nil then
				arg_191_1.var_.characterEffect4040ui_story = arg_191_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_0 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 and not isNil(arg_191_1.actors_["4040ui_story"]) then
				if arg_191_1.var_.characterEffect4040ui_story and not isNil(arg_191_1.actors_["4040ui_story"]) then
					arg_191_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_191_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_191_1.time_ - 0) / var_194_0)
				end
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 and not isNil(arg_191_1.actors_["4040ui_story"]) and arg_191_1.var_.characterEffect4040ui_story then
				arg_191_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_191_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_194_1 = arg_191_1.actors_["10079ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10079ui_story == nil then
				arg_191_1.var_.characterEffect10079ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect10079ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect10079ui_story then
				arg_191_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_194_4 = 0
			local var_194_5 = 0.55

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

				local var_194_6 = arg_191_1:GetWordFromCfg(319601047)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 22 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 22)

				if (22 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 22)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601047", "story_v_out_319601.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601047", "story_v_out_319601.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_319601", "319601047", "story_v_out_319601.awb")

						arg_191_1:RecordAudio("319601047", var_194_11)
						arg_191_1:RecordAudio("319601047", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_319601", "319601047", "story_v_out_319601.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_319601", "319601047", "story_v_out_319601.awb")
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

		arg_191_1.nodeConfigList_ = {}

		arg_191_1:InitPlayNodeList()
	end,
	Play319601048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 319601048
		arg_195_1.duration_ = 9.33

		local var_195_0 = {
			zh = 3.133,
			ja = 9.333
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
				arg_195_0:Play319601049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["4040ui_story"]) and arg_195_1.var_.characterEffect4040ui_story == nil then
				arg_195_1.var_.characterEffect4040ui_story = arg_195_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["4040ui_story"]) then
				if arg_195_1.var_.characterEffect4040ui_story and not isNil(arg_195_1.actors_["4040ui_story"]) then
					arg_195_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["4040ui_story"]) and arg_195_1.var_.characterEffect4040ui_story then
				arg_195_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			local var_198_2 = arg_195_1.actors_["10079ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect10079ui_story == nil then
				arg_195_1.var_.characterEffect10079ui_story = var_198_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_3 = 0.200000002980232

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_3 and not isNil(var_198_2) then
				if arg_195_1.var_.characterEffect10079ui_story and not isNil(var_198_2) then
					arg_195_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_3)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_3 and arg_195_1.time_ < 0 + var_198_3 + arg_198_0 and not isNil(var_198_2) and arg_195_1.var_.characterEffect10079ui_story then
				arg_195_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_198_4 = 0
			local var_198_5 = 0.275

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_4 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_6 = arg_195_1:GetWordFromCfg(319601048)
				local var_198_7 = arg_195_1:FormatText(var_198_6.content)

				arg_195_1.text_.text = var_198_7

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_9 = 11 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 11)

				if (11 <= 0 and var_198_5 or var_198_5 * (utf8.len(var_198_7) / 11)) > 0 and var_198_5 < var_198_9 then
					arg_195_1.talkMaxDuration = var_198_9

					if var_198_9 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_9 + var_198_4
					end
				end

				arg_195_1.text_.text = var_198_7
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601048", "story_v_out_319601.awb") ~= 0 then
					local var_198_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601048", "story_v_out_319601.awb") / 1000

					if var_198_10 + var_198_4 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_10 + var_198_4
					end

					if var_198_6.prefab_name ~= "" and arg_195_1.actors_[var_198_6.prefab_name] ~= nil then
						local var_198_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_6.prefab_name].transform, "story_v_out_319601", "319601048", "story_v_out_319601.awb")

						arg_195_1:RecordAudio("319601048", var_198_11)
						arg_195_1:RecordAudio("319601048", var_198_11)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_319601", "319601048", "story_v_out_319601.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_319601", "319601048", "story_v_out_319601.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_12 = math.max(var_198_5, arg_195_1.talkMaxDuration)

			if var_198_4 <= arg_195_1.time_ and arg_195_1.time_ < var_198_4 + var_198_12 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_4) / var_198_12

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_4 + var_198_12 and arg_195_1.time_ < var_198_4 + var_198_12 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {}

		arg_195_1:InitPlayNodeList()
	end,
	Play319601049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 319601049
		arg_199_1.duration_ = 5

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play319601050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(arg_199_1.actors_["4040ui_story"]) and arg_199_1.var_.characterEffect4040ui_story == nil then
				arg_199_1.var_.characterEffect4040ui_story = arg_199_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_0 = 0.200000002980232

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 and not isNil(arg_199_1.actors_["4040ui_story"]) then
				if arg_199_1.var_.characterEffect4040ui_story and not isNil(arg_199_1.actors_["4040ui_story"]) then
					arg_199_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_199_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_199_1.time_ - 0) / var_202_0)
				end
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 and not isNil(arg_199_1.actors_["4040ui_story"]) and arg_199_1.var_.characterEffect4040ui_story then
				arg_199_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_199_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_202_1 = 0
			local var_202_2 = 1

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, false)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_3 = arg_199_1:FormatText(arg_199_1:GetWordFromCfg(319601049).content)

				arg_199_1.text_.text = var_202_3

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_5 = 40 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 40)

				if (40 <= 0 and var_202_2 or var_202_2 * (utf8.len(var_202_3) / 40)) > 0 and var_202_2 < var_202_5 then
					arg_199_1.talkMaxDuration = var_202_5

					if var_202_5 + var_202_1 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_5 + var_202_1
					end
				end

				arg_199_1.text_.text = var_202_3
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)
				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_6 = math.max(var_202_2, arg_199_1.talkMaxDuration)

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_6 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_1) / var_202_6

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_1 + var_202_6 and arg_199_1.time_ < var_202_1 + var_202_6 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {}

		arg_199_1:InitPlayNodeList()
	end,
	Play319601050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 319601050
		arg_203_1.duration_ = 4.23

		local var_203_0 = {
			zh = 3,
			ja = 4.233
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
				arg_203_0:Play319601051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos4037ui_story = arg_203_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_206_0 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_0 then
				arg_203_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_203_1.time_ - 0) / var_206_0)
				arg_203_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["4037ui_story"].transform.position).z)
				arg_203_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["4037ui_story"].transform.localEulerAngles = arg_203_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_0 and arg_203_1.time_ < 0 + var_206_0 + arg_206_0 then
				arg_203_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_203_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_203_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_203_1.actors_["4037ui_story"].transform.position).z)
				arg_203_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_203_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_203_1.actors_["4037ui_story"].transform.localEulerAngles = arg_203_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_206_1 = arg_203_1.actors_["4037ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect4037ui_story == nil then
				arg_203_1.var_.characterEffect4037ui_story = var_206_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_2 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_2 and not isNil(var_206_1) then
				if arg_203_1.var_.characterEffect4037ui_story and not isNil(var_206_1) then
					arg_203_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_203_1.time_ >= 0 + var_206_2 and arg_203_1.time_ < 0 + var_206_2 + arg_206_0 and not isNil(var_206_1) and arg_203_1.var_.characterEffect4037ui_story then
				arg_203_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_206_4 = arg_203_1.actors_["4040ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos4040ui_story = var_206_4.localPosition
			end

			local var_206_5 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_5 then
				var_206_4.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_5)
				var_206_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_4.position).x, (manager.ui.mainCamera.transform.position - var_206_4.position).y, (manager.ui.mainCamera.transform.position - var_206_4.position).z)
				var_206_4.localEulerAngles.z = 0
				var_206_4.localEulerAngles.x = 0
				var_206_4.localEulerAngles = var_206_4.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_5 and arg_203_1.time_ < 0 + var_206_5 + arg_206_0 then
				var_206_4.localPosition = Vector3.New(0, 100, 0)
				var_206_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_4.position).x, (manager.ui.mainCamera.transform.position - var_206_4.position).y, (manager.ui.mainCamera.transform.position - var_206_4.position).z)
				var_206_4.localEulerAngles.z = 0
				var_206_4.localEulerAngles.x = 0
				var_206_4.localEulerAngles = var_206_4.localEulerAngles
			end

			local var_206_6 = arg_203_1.actors_["4040ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect4040ui_story == nil then
				arg_203_1.var_.characterEffect4040ui_story = var_206_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_7 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_7 and not isNil(var_206_6) then
				if arg_203_1.var_.characterEffect4040ui_story and not isNil(var_206_6) then
					arg_203_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_203_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_7)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_7 and arg_203_1.time_ < 0 + var_206_7 + arg_206_0 and not isNil(var_206_6) and arg_203_1.var_.characterEffect4040ui_story then
				arg_203_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_203_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_206_8 = arg_203_1.actors_["10079ui_story"].transform

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1.var_.moveOldPos10079ui_story = var_206_8.localPosition
			end

			local var_206_9 = 0.001

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_9 then
				var_206_8.localPosition = Vector3.Lerp(arg_203_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_203_1.time_ - 0) / var_206_9)
				var_206_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_8.position).x, (manager.ui.mainCamera.transform.position - var_206_8.position).y, (manager.ui.mainCamera.transform.position - var_206_8.position).z)
				var_206_8.localEulerAngles.z = 0
				var_206_8.localEulerAngles.x = 0
				var_206_8.localEulerAngles = var_206_8.localEulerAngles
			end

			if arg_203_1.time_ >= 0 + var_206_9 and arg_203_1.time_ < 0 + var_206_9 + arg_206_0 then
				var_206_8.localPosition = Vector3.New(0, 100, 0)
				var_206_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_206_8.position).x, (manager.ui.mainCamera.transform.position - var_206_8.position).y, (manager.ui.mainCamera.transform.position - var_206_8.position).z)
				var_206_8.localEulerAngles.z = 0
				var_206_8.localEulerAngles.x = 0
				var_206_8.localEulerAngles = var_206_8.localEulerAngles
			end

			local var_206_10 = arg_203_1.actors_["10079ui_story"]

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 and not isNil(var_206_10) and arg_203_1.var_.characterEffect10079ui_story == nil then
				arg_203_1.var_.characterEffect10079ui_story = var_206_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_206_11 = 0.200000002980232

			if 0 <= arg_203_1.time_ and arg_203_1.time_ < 0 + var_206_11 and not isNil(var_206_10) then
				if arg_203_1.var_.characterEffect10079ui_story and not isNil(var_206_10) then
					arg_203_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_203_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_203_1.time_ - 0) / var_206_11)
				end
			end

			if arg_203_1.time_ >= 0 + var_206_11 and arg_203_1.time_ < 0 + var_206_11 + arg_206_0 and not isNil(var_206_10) and arg_203_1.var_.characterEffect10079ui_story then
				arg_203_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_203_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_206_12 = 0
			local var_206_13 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_12 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_14 = arg_203_1:GetWordFromCfg(319601050)
				local var_206_15 = arg_203_1:FormatText(var_206_14.content)

				arg_203_1.text_.text = var_206_15

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_17 = 12 <= 0 and var_206_13 or var_206_13 * (utf8.len(var_206_15) / 12)

				if (12 <= 0 and var_206_13 or var_206_13 * (utf8.len(var_206_15) / 12)) > 0 and var_206_13 < var_206_17 then
					arg_203_1.talkMaxDuration = var_206_17

					if var_206_17 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_17 + var_206_12
					end
				end

				arg_203_1.text_.text = var_206_15
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601050", "story_v_out_319601.awb") ~= 0 then
					local var_206_18 = manager.audio:GetVoiceLength("story_v_out_319601", "319601050", "story_v_out_319601.awb") / 1000

					if var_206_18 + var_206_12 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_18 + var_206_12
					end

					if var_206_14.prefab_name ~= "" and arg_203_1.actors_[var_206_14.prefab_name] ~= nil then
						local var_206_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_14.prefab_name].transform, "story_v_out_319601", "319601050", "story_v_out_319601.awb")

						arg_203_1:RecordAudio("319601050", var_206_19)
						arg_203_1:RecordAudio("319601050", var_206_19)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_319601", "319601050", "story_v_out_319601.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_319601", "319601050", "story_v_out_319601.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_20 = math.max(var_206_13, arg_203_1.talkMaxDuration)

			if var_206_12 <= arg_203_1.time_ and arg_203_1.time_ < var_206_12 + var_206_20 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_12) / var_206_20

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_12 + var_206_20 and arg_203_1.time_ < var_206_12 + var_206_20 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_203_1:InitPlayNodeList()
	end,
	Play319601051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 319601051
		arg_207_1.duration_ = 5.97

		local var_207_0 = {
			zh = 3.9,
			ja = 5.966
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
				arg_207_0:Play319601052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos10079ui_story = arg_207_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_210_0 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 then
				arg_207_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_207_1.time_ - 0) / var_210_0)
				arg_207_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10079ui_story"].transform.position).z)
				arg_207_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10079ui_story"].transform.localEulerAngles = arg_207_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 then
				arg_207_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_207_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_207_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_207_1.actors_["10079ui_story"].transform.position).z)
				arg_207_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_207_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_207_1.actors_["10079ui_story"].transform.localEulerAngles = arg_207_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_210_1 = arg_207_1.actors_["10079ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10079ui_story == nil then
				arg_207_1.var_.characterEffect10079ui_story = var_210_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_2 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 and not isNil(var_210_1) then
				if arg_207_1.var_.characterEffect10079ui_story and not isNil(var_210_1) then
					arg_207_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 and not isNil(var_210_1) and arg_207_1.var_.characterEffect10079ui_story then
				arg_207_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_210_4 = arg_207_1.actors_["4037ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect4037ui_story == nil then
				arg_207_1.var_.characterEffect4037ui_story = var_210_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_5 = 0.200000002980232

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_5 and not isNil(var_210_4) then
				if arg_207_1.var_.characterEffect4037ui_story and not isNil(var_210_4) then
					arg_207_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_207_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_5)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_5 and arg_207_1.time_ < 0 + var_210_5 + arg_210_0 and not isNil(var_210_4) and arg_207_1.var_.characterEffect4037ui_story then
				arg_207_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_207_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_210_6 = arg_207_1.actors_["4037ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos4037ui_story = var_210_6.localPosition
			end

			local var_210_7 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_7 then
				var_210_6.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_207_1.time_ - 0) / var_210_7)
				var_210_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_6.position).x, (manager.ui.mainCamera.transform.position - var_210_6.position).y, (manager.ui.mainCamera.transform.position - var_210_6.position).z)
				var_210_6.localEulerAngles.z = 0
				var_210_6.localEulerAngles.x = 0
				var_210_6.localEulerAngles = var_210_6.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_7 and arg_207_1.time_ < 0 + var_210_7 + arg_210_0 then
				var_210_6.localPosition = Vector3.New(0, 100, 0)
				var_210_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_6.position).x, (manager.ui.mainCamera.transform.position - var_210_6.position).y, (manager.ui.mainCamera.transform.position - var_210_6.position).z)
				var_210_6.localEulerAngles.z = 0
				var_210_6.localEulerAngles.x = 0
				var_210_6.localEulerAngles = var_210_6.localEulerAngles
			end

			local var_210_8 = 0
			local var_210_9 = 0.525

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_8 + arg_210_0 then
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

				local var_210_10 = arg_207_1:GetWordFromCfg(319601051)
				local var_210_11 = arg_207_1:FormatText(var_210_10.content)

				arg_207_1.text_.text = var_210_11

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_13 = 21 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 21)

				if (21 <= 0 and var_210_9 or var_210_9 * (utf8.len(var_210_11) / 21)) > 0 and var_210_9 < var_210_13 then
					arg_207_1.talkMaxDuration = var_210_13

					if var_210_13 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_13 + var_210_8
					end
				end

				arg_207_1.text_.text = var_210_11
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601051", "story_v_out_319601.awb") ~= 0 then
					local var_210_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601051", "story_v_out_319601.awb") / 1000

					if var_210_14 + var_210_8 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_14 + var_210_8
					end

					if var_210_10.prefab_name ~= "" and arg_207_1.actors_[var_210_10.prefab_name] ~= nil then
						local var_210_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_10.prefab_name].transform, "story_v_out_319601", "319601051", "story_v_out_319601.awb")

						arg_207_1:RecordAudio("319601051", var_210_15)
						arg_207_1:RecordAudio("319601051", var_210_15)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_319601", "319601051", "story_v_out_319601.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_319601", "319601051", "story_v_out_319601.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_16 = math.max(var_210_9, arg_207_1.talkMaxDuration)

			if var_210_8 <= arg_207_1.time_ and arg_207_1.time_ < var_210_8 + var_210_16 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_8) / var_210_16

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_8 + var_210_16 and arg_207_1.time_ < var_210_8 + var_210_16 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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
				actorName = "4037ui_story",
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
	Play319601052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 319601052
		arg_211_1.duration_ = 5.9

		local var_211_0 = {
			zh = 2.7,
			ja = 5.9
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play319601053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos4037ui_story = arg_211_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["4037ui_story"].transform.position).z)
				arg_211_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["4037ui_story"].transform.localEulerAngles = arg_211_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_211_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["4037ui_story"].transform.position).z)
				arg_211_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["4037ui_story"].transform.localEulerAngles = arg_211_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["4037ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect4037ui_story == nil then
				arg_211_1.var_.characterEffect4037ui_story = var_214_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_2 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 and not isNil(var_214_1) then
				if arg_211_1.var_.characterEffect4037ui_story and not isNil(var_214_1) then
					arg_211_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 and not isNil(var_214_1) and arg_211_1.var_.characterEffect4037ui_story then
				arg_211_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_4 = arg_211_1.actors_["10079ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos10079ui_story = var_214_4.localPosition
			end

			local var_214_5 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_5 then
				var_214_4.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_5)
				var_214_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_4.position).x, (manager.ui.mainCamera.transform.position - var_214_4.position).y, (manager.ui.mainCamera.transform.position - var_214_4.position).z)
				var_214_4.localEulerAngles.z = 0
				var_214_4.localEulerAngles.x = 0
				var_214_4.localEulerAngles = var_214_4.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_5 and arg_211_1.time_ < 0 + var_214_5 + arg_214_0 then
				var_214_4.localPosition = Vector3.New(0, 100, 0)
				var_214_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_4.position).x, (manager.ui.mainCamera.transform.position - var_214_4.position).y, (manager.ui.mainCamera.transform.position - var_214_4.position).z)
				var_214_4.localEulerAngles.z = 0
				var_214_4.localEulerAngles.x = 0
				var_214_4.localEulerAngles = var_214_4.localEulerAngles
			end

			local var_214_6 = arg_211_1.actors_["10079ui_story"]

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect10079ui_story == nil then
				arg_211_1.var_.characterEffect10079ui_story = var_214_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_7 = 0.200000002980232

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_7 and not isNil(var_214_6) then
				if arg_211_1.var_.characterEffect10079ui_story and not isNil(var_214_6) then
					arg_211_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_211_1.time_ - 0) / var_214_7)
				end
			end

			if arg_211_1.time_ >= 0 + var_214_7 and arg_211_1.time_ < 0 + var_214_7 + arg_214_0 and not isNil(var_214_6) and arg_211_1.var_.characterEffect10079ui_story then
				arg_211_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_214_8 = 0
			local var_214_9 = 0.25

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_8 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				arg_211_1.leftNameTxt_.text = arg_211_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_10 = arg_211_1:GetWordFromCfg(319601052)
				local var_214_11 = arg_211_1:FormatText(var_214_10.content)

				arg_211_1.text_.text = var_214_11

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_13 = 10 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 10)

				if (10 <= 0 and var_214_9 or var_214_9 * (utf8.len(var_214_11) / 10)) > 0 and var_214_9 < var_214_13 then
					arg_211_1.talkMaxDuration = var_214_13

					if var_214_13 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_13 + var_214_8
					end
				end

				arg_211_1.text_.text = var_214_11
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601052", "story_v_out_319601.awb") ~= 0 then
					local var_214_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601052", "story_v_out_319601.awb") / 1000

					if var_214_14 + var_214_8 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_14 + var_214_8
					end

					if var_214_10.prefab_name ~= "" and arg_211_1.actors_[var_214_10.prefab_name] ~= nil then
						local var_214_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_10.prefab_name].transform, "story_v_out_319601", "319601052", "story_v_out_319601.awb")

						arg_211_1:RecordAudio("319601052", var_214_15)
						arg_211_1:RecordAudio("319601052", var_214_15)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_319601", "319601052", "story_v_out_319601.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_319601", "319601052", "story_v_out_319601.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_16 = math.max(var_214_9, arg_211_1.talkMaxDuration)

			if var_214_8 <= arg_211_1.time_ and arg_211_1.time_ < var_214_8 + var_214_16 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_8) / var_214_16

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_8 + var_214_16 and arg_211_1.time_ < var_214_8 + var_214_16 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_211_1:InitPlayNodeList()
	end,
	Play319601053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 319601053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play319601054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			if 0 < arg_215_1.time_ and arg_215_1.time_ <= 0 + arg_218_0 and not isNil(arg_215_1.actors_["4037ui_story"]) and arg_215_1.var_.characterEffect4037ui_story == nil then
				arg_215_1.var_.characterEffect4037ui_story = arg_215_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_0 = 0.200000002980232

			if 0 <= arg_215_1.time_ and arg_215_1.time_ < 0 + var_218_0 and not isNil(arg_215_1.actors_["4037ui_story"]) then
				if arg_215_1.var_.characterEffect4037ui_story and not isNil(arg_215_1.actors_["4037ui_story"]) then
					arg_215_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_215_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_215_1.time_ - 0) / var_218_0)
				end
			end

			if arg_215_1.time_ >= 0 + var_218_0 and arg_215_1.time_ < 0 + var_218_0 + arg_218_0 and not isNil(arg_215_1.actors_["4037ui_story"]) and arg_215_1.var_.characterEffect4037ui_story then
				arg_215_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_215_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_218_1 = 0
			local var_218_2 = 0.65

			if 0 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_3 = arg_215_1:FormatText(arg_215_1:GetWordFromCfg(319601053).content)

				arg_215_1.text_.text = var_218_3

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_5 = 26 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 26)

				if (26 <= 0 and var_218_2 or var_218_2 * (utf8.len(var_218_3) / 26)) > 0 and var_218_2 < var_218_5 then
					arg_215_1.talkMaxDuration = var_218_5

					if var_218_5 + var_218_1 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_5 + var_218_1
					end
				end

				arg_215_1.text_.text = var_218_3
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_6 = math.max(var_218_2, arg_215_1.talkMaxDuration)

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_6 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_1) / var_218_6

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_1 + var_218_6 and arg_215_1.time_ < var_218_1 + var_218_6 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end

		arg_215_1.nodeConfigList_ = {}

		arg_215_1:InitPlayNodeList()
	end,
	Play319601054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 319601054
		arg_219_1.duration_ = 12.5

		local var_219_0 = {
			zh = 5.6,
			ja = 12.5
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
				arg_219_0:Play319601055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			if 0 < arg_219_1.time_ and arg_219_1.time_ <= 0 + arg_222_0 and not isNil(arg_219_1.actors_["4037ui_story"]) and arg_219_1.var_.characterEffect4037ui_story == nil then
				arg_219_1.var_.characterEffect4037ui_story = arg_219_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_0 = 0.200000002980232

			if 0 <= arg_219_1.time_ and arg_219_1.time_ < 0 + var_222_0 and not isNil(arg_219_1.actors_["4037ui_story"]) then
				if arg_219_1.var_.characterEffect4037ui_story and not isNil(arg_219_1.actors_["4037ui_story"]) then
					arg_219_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= 0 + var_222_0 and arg_219_1.time_ < 0 + var_222_0 + arg_222_0 and not isNil(arg_219_1.actors_["4037ui_story"]) and arg_219_1.var_.characterEffect4037ui_story then
				arg_219_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			local var_222_2 = 0
			local var_222_3 = 0.5

			if 0 < arg_219_1.time_ and arg_219_1.time_ <= var_222_2 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				arg_219_1.leftNameTxt_.text = arg_219_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_4 = arg_219_1:GetWordFromCfg(319601054)
				local var_222_5 = arg_219_1:FormatText(var_222_4.content)

				arg_219_1.text_.text = var_222_5

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_7 = 20 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 20)

				if (20 <= 0 and var_222_3 or var_222_3 * (utf8.len(var_222_5) / 20)) > 0 and var_222_3 < var_222_7 then
					arg_219_1.talkMaxDuration = var_222_7

					if var_222_7 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_7 + var_222_2
					end
				end

				arg_219_1.text_.text = var_222_5
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601054", "story_v_out_319601.awb") ~= 0 then
					local var_222_8 = manager.audio:GetVoiceLength("story_v_out_319601", "319601054", "story_v_out_319601.awb") / 1000

					if var_222_8 + var_222_2 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_8 + var_222_2
					end

					if var_222_4.prefab_name ~= "" and arg_219_1.actors_[var_222_4.prefab_name] ~= nil then
						local var_222_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_4.prefab_name].transform, "story_v_out_319601", "319601054", "story_v_out_319601.awb")

						arg_219_1:RecordAudio("319601054", var_222_9)
						arg_219_1:RecordAudio("319601054", var_222_9)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_319601", "319601054", "story_v_out_319601.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_319601", "319601054", "story_v_out_319601.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_10 = math.max(var_222_3, arg_219_1.talkMaxDuration)

			if var_222_2 <= arg_219_1.time_ and arg_219_1.time_ < var_222_2 + var_222_10 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_2) / var_222_10

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_2 + var_222_10 and arg_219_1.time_ < var_222_2 + var_222_10 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end

		arg_219_1.nodeConfigList_ = {}

		arg_219_1:InitPlayNodeList()
	end,
	Play319601055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 319601055
		arg_223_1.duration_ = 5

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play319601056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			if 0 < arg_223_1.time_ and arg_223_1.time_ <= 0 + arg_226_0 and not isNil(arg_223_1.actors_["4037ui_story"]) and arg_223_1.var_.characterEffect4037ui_story == nil then
				arg_223_1.var_.characterEffect4037ui_story = arg_223_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_0 = 0.200000002980232

			if 0 <= arg_223_1.time_ and arg_223_1.time_ < 0 + var_226_0 and not isNil(arg_223_1.actors_["4037ui_story"]) then
				if arg_223_1.var_.characterEffect4037ui_story and not isNil(arg_223_1.actors_["4037ui_story"]) then
					arg_223_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_223_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_223_1.time_ - 0) / var_226_0)
				end
			end

			if arg_223_1.time_ >= 0 + var_226_0 and arg_223_1.time_ < 0 + var_226_0 + arg_226_0 and not isNil(arg_223_1.actors_["4037ui_story"]) and arg_223_1.var_.characterEffect4037ui_story then
				arg_223_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_223_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_226_1 = 0
			local var_226_2 = 1.3

			if 0 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, false)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_3 = arg_223_1:FormatText(arg_223_1:GetWordFromCfg(319601055).content)

				arg_223_1.text_.text = var_226_3

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_5 = 52 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 52)

				if (52 <= 0 and var_226_2 or var_226_2 * (utf8.len(var_226_3) / 52)) > 0 and var_226_2 < var_226_5 then
					arg_223_1.talkMaxDuration = var_226_5

					if var_226_5 + var_226_1 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_5 + var_226_1
					end
				end

				arg_223_1.text_.text = var_226_3
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)
				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_6 = math.max(var_226_2, arg_223_1.talkMaxDuration)

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_6 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_1) / var_226_6

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_1 + var_226_6 and arg_223_1.time_ < var_226_1 + var_226_6 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end

		arg_223_1.nodeConfigList_ = {}

		arg_223_1:InitPlayNodeList()
	end,
	Play319601056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 319601056
		arg_227_1.duration_ = 3.7

		local var_227_0 = {
			zh = 2.766,
			ja = 3.7
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
				arg_227_0:Play319601057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos4040ui_story = arg_227_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_230_0 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_0 then
				arg_227_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_227_1.time_ - 0) / var_230_0)
				arg_227_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4040ui_story"].transform.position).z)
				arg_227_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["4040ui_story"].transform.localEulerAngles = arg_227_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_0 and arg_227_1.time_ < 0 + var_230_0 + arg_230_0 then
				arg_227_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_227_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_227_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_227_1.actors_["4040ui_story"].transform.position).z)
				arg_227_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_227_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_227_1.actors_["4040ui_story"].transform.localEulerAngles = arg_227_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_230_1 = arg_227_1.actors_["4040ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect4040ui_story == nil then
				arg_227_1.var_.characterEffect4040ui_story = var_230_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_2 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_2 and not isNil(var_230_1) then
				if arg_227_1.var_.characterEffect4040ui_story and not isNil(var_230_1) then
					arg_227_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_227_1.time_ >= 0 + var_230_2 and arg_227_1.time_ < 0 + var_230_2 + arg_230_0 and not isNil(var_230_1) and arg_227_1.var_.characterEffect4040ui_story then
				arg_227_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_230_4 = arg_227_1.actors_["4037ui_story"].transform

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 then
				arg_227_1.var_.moveOldPos4037ui_story = var_230_4.localPosition
			end

			local var_230_5 = 0.001

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_5 then
				var_230_4.localPosition = Vector3.Lerp(arg_227_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_227_1.time_ - 0) / var_230_5)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			if arg_227_1.time_ >= 0 + var_230_5 and arg_227_1.time_ < 0 + var_230_5 + arg_230_0 then
				var_230_4.localPosition = Vector3.New(0, 100, 0)
				var_230_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_230_4.position).x, (manager.ui.mainCamera.transform.position - var_230_4.position).y, (manager.ui.mainCamera.transform.position - var_230_4.position).z)
				var_230_4.localEulerAngles.z = 0
				var_230_4.localEulerAngles.x = 0
				var_230_4.localEulerAngles = var_230_4.localEulerAngles
			end

			local var_230_6 = arg_227_1.actors_["4037ui_story"]

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= 0 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect4037ui_story == nil then
				arg_227_1.var_.characterEffect4037ui_story = var_230_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_230_7 = 0.200000002980232

			if 0 <= arg_227_1.time_ and arg_227_1.time_ < 0 + var_230_7 and not isNil(var_230_6) then
				if arg_227_1.var_.characterEffect4037ui_story and not isNil(var_230_6) then
					arg_227_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_227_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_227_1.time_ - 0) / var_230_7)
				end
			end

			if arg_227_1.time_ >= 0 + var_230_7 and arg_227_1.time_ < 0 + var_230_7 + arg_230_0 and not isNil(var_230_6) and arg_227_1.var_.characterEffect4037ui_story then
				arg_227_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_227_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_230_8 = 0
			local var_230_9 = 0.25

			if 0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_8 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				arg_227_1.leftNameTxt_.text = arg_227_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_10 = arg_227_1:GetWordFromCfg(319601056)
				local var_230_11 = arg_227_1:FormatText(var_230_10.content)

				arg_227_1.text_.text = var_230_11

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_13 = 10 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 10)

				if (10 <= 0 and var_230_9 or var_230_9 * (utf8.len(var_230_11) / 10)) > 0 and var_230_9 < var_230_13 then
					arg_227_1.talkMaxDuration = var_230_13

					if var_230_13 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_13 + var_230_8
					end
				end

				arg_227_1.text_.text = var_230_11
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601056", "story_v_out_319601.awb") ~= 0 then
					local var_230_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601056", "story_v_out_319601.awb") / 1000

					if var_230_14 + var_230_8 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_14 + var_230_8
					end

					if var_230_10.prefab_name ~= "" and arg_227_1.actors_[var_230_10.prefab_name] ~= nil then
						local var_230_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_10.prefab_name].transform, "story_v_out_319601", "319601056", "story_v_out_319601.awb")

						arg_227_1:RecordAudio("319601056", var_230_15)
						arg_227_1:RecordAudio("319601056", var_230_15)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_319601", "319601056", "story_v_out_319601.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_319601", "319601056", "story_v_out_319601.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_16 = math.max(var_230_9, arg_227_1.talkMaxDuration)

			if var_230_8 <= arg_227_1.time_ and arg_227_1.time_ < var_230_8 + var_230_16 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_8) / var_230_16

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_8 + var_230_16 and arg_227_1.time_ < var_230_8 + var_230_16 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end

		arg_227_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_227_1:InitPlayNodeList()
	end,
	Play319601057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 319601057
		arg_231_1.duration_ = 5

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play319601058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			if 0 < arg_231_1.time_ and arg_231_1.time_ <= 0 + arg_234_0 and not isNil(arg_231_1.actors_["4040ui_story"]) and arg_231_1.var_.characterEffect4040ui_story == nil then
				arg_231_1.var_.characterEffect4040ui_story = arg_231_1.actors_["4040ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_0 = 0.200000002980232

			if 0 <= arg_231_1.time_ and arg_231_1.time_ < 0 + var_234_0 and not isNil(arg_231_1.actors_["4040ui_story"]) then
				if arg_231_1.var_.characterEffect4040ui_story and not isNil(arg_231_1.actors_["4040ui_story"]) then
					arg_231_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_231_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_231_1.time_ - 0) / var_234_0)
				end
			end

			if arg_231_1.time_ >= 0 + var_234_0 and arg_231_1.time_ < 0 + var_234_0 + arg_234_0 and not isNil(arg_231_1.actors_["4040ui_story"]) and arg_231_1.var_.characterEffect4040ui_story then
				arg_231_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_231_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_234_1 = 0
			local var_234_2 = 1.4

			if 0 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, false)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_3 = arg_231_1:FormatText(arg_231_1:GetWordFromCfg(319601057).content)

				arg_231_1.text_.text = var_234_3

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_5 = 56 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 56)

				if (56 <= 0 and var_234_2 or var_234_2 * (utf8.len(var_234_3) / 56)) > 0 and var_234_2 < var_234_5 then
					arg_231_1.talkMaxDuration = var_234_5

					if var_234_5 + var_234_1 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_5 + var_234_1
					end
				end

				arg_231_1.text_.text = var_234_3
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)
				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_6 = math.max(var_234_2, arg_231_1.talkMaxDuration)

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_6 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_1) / var_234_6

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_1 + var_234_6 and arg_231_1.time_ < var_234_1 + var_234_6 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end

		arg_231_1.nodeConfigList_ = {}

		arg_231_1:InitPlayNodeList()
	end,
	Play319601058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 319601058
		arg_235_1.duration_ = 3.23

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play319601059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos10079ui_story = arg_235_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_238_0 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_0 then
				arg_235_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_0)
				arg_235_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10079ui_story"].transform.position).z)
				arg_235_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10079ui_story"].transform.localEulerAngles = arg_235_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_0 and arg_235_1.time_ < 0 + var_238_0 + arg_238_0 then
				arg_235_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_235_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_235_1.actors_["10079ui_story"].transform.position).z)
				arg_235_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_235_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_235_1.actors_["10079ui_story"].transform.localEulerAngles = arg_235_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_238_1 = arg_235_1.actors_["4040ui_story"].transform

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.var_.moveOldPos4040ui_story = var_238_1.localPosition
			end

			local var_238_2 = 0.001

			if 0 <= arg_235_1.time_ and arg_235_1.time_ < 0 + var_238_2 then
				var_238_1.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_235_1.time_ - 0) / var_238_2)
				var_238_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_1.position).x, (manager.ui.mainCamera.transform.position - var_238_1.position).y, (manager.ui.mainCamera.transform.position - var_238_1.position).z)
				var_238_1.localEulerAngles.z = 0
				var_238_1.localEulerAngles.x = 0
				var_238_1.localEulerAngles = var_238_1.localEulerAngles
			end

			if arg_235_1.time_ >= 0 + var_238_2 and arg_235_1.time_ < 0 + var_238_2 + arg_238_0 then
				var_238_1.localPosition = Vector3.New(0, 100, 0)
				var_238_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_238_1.position).x, (manager.ui.mainCamera.transform.position - var_238_1.position).y, (manager.ui.mainCamera.transform.position - var_238_1.position).z)
				var_238_1.localEulerAngles.z = 0
				var_238_1.localEulerAngles.x = 0
				var_238_1.localEulerAngles = var_238_1.localEulerAngles
			end

			local var_238_3 = "STblack"

			if arg_235_1.bgs_.STblack == nil then
				local var_238_4 = Object.Instantiate(arg_235_1.paintGo_)

				var_238_4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_238_3)
				var_238_4.name = var_238_3
				var_238_4.transform.parent = arg_235_1.stage_.transform
				var_238_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_235_1.bgs_[var_238_3] = var_238_4
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				local var_238_5 = arg_235_1.bgs_.STblack

				arg_235_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_238_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_238_6 = var_238_5:GetComponent("SpriteRenderer")

				if var_238_6 and var_238_6.sprite then
					local var_238_7 = 2 * (var_238_5.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_238_5.transform.localScale = Vector3.New(var_238_7 / var_238_6.sprite.bounds.size.y < var_238_7 * manager.ui.mainCameraCom_.aspect / var_238_6.sprite.bounds.size.x and var_238_7 * manager.ui.mainCameraCom_.aspect / var_238_6.sprite.bounds.size.x or var_238_7 / var_238_6.sprite.bounds.size.y, var_238_7 / var_238_6.sprite.bounds.size.y < var_238_7 * manager.ui.mainCameraCom_.aspect / var_238_6.sprite.bounds.size.x and var_238_7 * manager.ui.mainCameraCom_.aspect / var_238_6.sprite.bounds.size.x or var_238_7 / var_238_6.sprite.bounds.size.y, 0)
				end

				for iter_238_0, iter_238_1 in pairs(arg_235_1.bgs_) do
					if iter_238_0 ~= "STblack" then
						iter_238_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				local var_238_8 = arg_235_1.fswbg_.transform:Find("textbox/adapt/content") or arg_235_1.fswbg_.transform:Find("textbox/content")
				local var_238_9 = arg_235_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_238_10 = var_238_8:GetComponent("RectTransform")

				var_238_8:GetComponent("Text").alignment = UnityEngine.TextAnchor.LowerCenter
				var_238_10.offsetMin = Vector2.New(0, 0)
				var_238_10.offsetMax = Vector2.New(0, 0)
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.fswbg_:SetActive(true)
				arg_235_1.dialog_:SetActive(false)

				arg_235_1.fswtw_.percent = 0
				arg_235_1.fswt_.text = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(319601058).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.fswt_)

				arg_235_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_235_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_235_1.fswtw_:SetDirty()

				arg_235_1.typewritterCharCountI18N = 0

				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_11 = 0.983333333333334

			if 0.983333333333334 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.var_.oldValueTypewriter = arg_235_1.fswtw_.percent

				SetActive(arg_235_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_235_1:ShowNextGo(false)
			end

			local var_238_12 = 5
			local var_238_13 = 0.333333333333333
			local var_238_14, var_238_15 = arg_235_1:GetPercentByPara(arg_235_1:FormatText(arg_235_1:GetWordFromCfg(319601058).content), 1)

			if var_238_11 < arg_235_1.time_ and arg_235_1.time_ <= var_238_11 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0

				local var_238_16 = var_238_12 <= 0 and var_238_13 or var_238_13 * ((var_238_15 - arg_235_1.typewritterCharCountI18N) / var_238_12)

				if (var_238_12 <= 0 and var_238_13 or var_238_13 * ((var_238_15 - arg_235_1.typewritterCharCountI18N) / var_238_12)) > 0 and var_238_13 < var_238_16 then
					arg_235_1.talkMaxDuration = var_238_16

					if var_238_16 + var_238_11 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_16 + var_238_11
					end
				end
			end

			local var_238_17 = math.max(0.333333333333333, arg_235_1.talkMaxDuration)

			if var_238_11 <= arg_235_1.time_ and arg_235_1.time_ < var_238_11 + var_238_17 then
				arg_235_1.fswtw_.percent = Mathf.Lerp(arg_235_1.var_.oldValueTypewriter, var_238_14, (arg_235_1.time_ - var_238_11) / var_238_17)
				arg_235_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_235_1.fswtw_:SetDirty()
			end

			if arg_235_1.time_ >= var_238_11 + var_238_17 and arg_235_1.time_ < var_238_11 + var_238_17 + arg_238_0 then
				arg_235_1.fswtw_.percent = var_238_14

				arg_235_1.fswtw_:SetDirty()
				arg_235_1:ShowNextGo(true)

				arg_235_1.typewritterCharCountI18N = var_238_15
			end

			if 0 < arg_235_1.time_ and arg_235_1.time_ <= 0 + arg_238_0 then
				arg_235_1.cswbg_:SetActive(true)

				local var_238_18 = arg_235_1.cswt_:GetComponent("RectTransform")

				arg_235_1.cswt_.alignment = UnityEngine.TextAnchor.MiddleCenter
				var_238_18.offsetMin = Vector2.New(410, 330)
				var_238_18.offsetMax = Vector2.New(-400, -175)
				arg_235_1.cswt_.text = arg_235_1:FormatText(arg_235_1:GetWordFromCfg(419032).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.cswt_)

				arg_235_1.cswt_.fontSize = 180
				arg_235_1.cswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_235_1.cswt_:GetComponent("I18NTextKeyToValue"):SetFontPath("Fonts/SourceHanSerifCN-Bold-3.0")

				arg_235_1.cswt_.font = Asset.Load("Fonts/SourceHanSerifCN-Bold-3.0")
			end

			local var_238_19 = 1
			local var_238_20 = manager.audio:GetVoiceLength("story_v_out_319601", "319601058", "story_v_out_319601.awb") / 1000

			if var_238_20 > 0 and 2.233 < var_238_20 and var_238_20 + var_238_19 > arg_235_1.duration_ then
				arg_235_1.duration_ = var_238_20 + var_238_19
			end

			if var_238_19 < arg_235_1.time_ and arg_235_1.time_ <= var_238_19 + arg_238_0 then
				arg_235_1:AudioAction("play", "voice", "story_v_out_319601", "319601058", "story_v_out_319601.awb")
			end
		end

		arg_235_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_235_1:InitPlayNodeList()
	end,
	Play319601059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 319601059
		arg_239_1.duration_ = 5.28

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play319601060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_0 = arg_239_1.bgs_.STblack

				arg_239_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_242_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_242_1 = var_242_0:GetComponent("SpriteRenderer")

				if var_242_1 and var_242_1.sprite then
					local var_242_2 = 2 * (var_242_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_242_0.transform.localScale = Vector3.New(var_242_2 / var_242_1.sprite.bounds.size.y < var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x and var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x or var_242_2 / var_242_1.sprite.bounds.size.y, var_242_2 / var_242_1.sprite.bounds.size.y < var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x and var_242_2 * manager.ui.mainCameraCom_.aspect / var_242_1.sprite.bounds.size.x or var_242_2 / var_242_1.sprite.bounds.size.y, 0)
				end

				for iter_242_0, iter_242_1 in pairs(arg_239_1.bgs_) do
					if iter_242_0 ~= "STblack" then
						iter_242_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.fswbg_:SetActive(false)
				arg_239_1.dialog_:SetActive(false)
				SetActive(arg_239_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_239_1:ShowNextGo(false)
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1.cswbg_:SetActive(false)
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_3 = 0.275
			local var_242_4 = 0.725

			if 0.275 < arg_239_1.time_ and arg_239_1.time_ <= var_242_3 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_5 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_5:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_5:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_5:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_6 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(319601059).content)

				arg_239_1.text_.text = var_242_6

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_8 = 29 <= 0 and var_242_4 or var_242_4 * (utf8.len(var_242_6) / 29)

				if (29 <= 0 and var_242_4 or var_242_4 * (utf8.len(var_242_6) / 29)) > 0 and var_242_4 < var_242_8 then
					arg_239_1.talkMaxDuration = var_242_8
					var_242_3 = var_242_3 + 0.3

					if var_242_8 + var_242_3 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_3
					end
				end

				arg_239_1.text_.text = var_242_6
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_9 = var_242_3 + 0.3
			local var_242_10 = math.max(var_242_4, arg_239_1.talkMaxDuration)

			if var_242_3 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_9 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_9) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_9 + var_242_10 and arg_239_1.time_ < var_242_9 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play319601060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 319601060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play319601061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			local var_248_0 = 1.575

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_1 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(319601060).content)

				arg_245_1.text_.text = var_248_1

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_3 = 63 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 63)

				if (63 <= 0 and var_248_0 or var_248_0 * (utf8.len(var_248_1) / 63)) > 0 and var_248_0 < var_248_3 then
					arg_245_1.talkMaxDuration = var_248_3

					if var_248_3 + 0 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_3 + 0
					end
				end

				arg_245_1.text_.text = var_248_1
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_4 = math.max(var_248_0, arg_245_1.talkMaxDuration)

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_4 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - 0) / var_248_4

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= 0 + var_248_4 and arg_245_1.time_ < 0 + var_248_4 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play319601061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 319601061
		arg_249_1.duration_ = 3.87

		local var_249_0 = {
			zh = 2.7,
			ja = 3.866
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play319601062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.var_.moveOldPos10079ui_story = arg_249_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_252_0 = 0.001

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 then
				arg_249_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_249_1.var_.moveOldPos10079ui_story, Vector3.New(0, -0.95, -6.05), (arg_249_1.time_ - 0) / var_252_0)
				arg_249_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10079ui_story"].transform.position).z)
				arg_249_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10079ui_story"].transform.localEulerAngles = arg_249_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 then
				arg_249_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0, -0.95, -6.05)
				arg_249_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_249_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_249_1.actors_["10079ui_story"].transform.position).z)
				arg_249_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_249_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_249_1.actors_["10079ui_story"].transform.localEulerAngles = arg_249_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_252_1 = arg_249_1.actors_["10079ui_story"]

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10079ui_story == nil then
				arg_249_1.var_.characterEffect10079ui_story = var_252_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_2 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_2 and not isNil(var_252_1) then
				if arg_249_1.var_.characterEffect10079ui_story and not isNil(var_252_1) then
					arg_249_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_2 and arg_249_1.time_ < 0 + var_252_2 + arg_252_0 and not isNil(var_252_1) and arg_249_1.var_.characterEffect10079ui_story then
				arg_249_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_252_4 = 0
			local var_252_5 = 0.125

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_4 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_6 = arg_249_1:GetWordFromCfg(319601061)
				local var_252_7 = arg_249_1:FormatText(var_252_6.content)

				arg_249_1.text_.text = var_252_7

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_9 = 5 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 5)

				if (5 <= 0 and var_252_5 or var_252_5 * (utf8.len(var_252_7) / 5)) > 0 and var_252_5 < var_252_9 then
					arg_249_1.talkMaxDuration = var_252_9

					if var_252_9 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_9 + var_252_4
					end
				end

				arg_249_1.text_.text = var_252_7
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601061", "story_v_out_319601.awb") ~= 0 then
					local var_252_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601061", "story_v_out_319601.awb") / 1000

					if var_252_10 + var_252_4 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_10 + var_252_4
					end

					if var_252_6.prefab_name ~= "" and arg_249_1.actors_[var_252_6.prefab_name] ~= nil then
						local var_252_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_6.prefab_name].transform, "story_v_out_319601", "319601061", "story_v_out_319601.awb")

						arg_249_1:RecordAudio("319601061", var_252_11)
						arg_249_1:RecordAudio("319601061", var_252_11)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_319601", "319601061", "story_v_out_319601.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_319601", "319601061", "story_v_out_319601.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_12 = math.max(var_252_5, arg_249_1.talkMaxDuration)

			if var_252_4 <= arg_249_1.time_ and arg_249_1.time_ < var_252_4 + var_252_12 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_4) / var_252_12

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_4 + var_252_12 and arg_249_1.time_ < var_252_4 + var_252_12 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {
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

		arg_249_1:InitPlayNodeList()
	end,
	Play319601062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 319601062
		arg_253_1.duration_ = 7.03

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play319601063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if arg_253_1.bgs_.XH0407a == nil then
				local var_256_0 = Object.Instantiate(arg_253_1.paintGo_)

				var_256_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "XH0407a")
				var_256_0.name = "XH0407a"
				var_256_0.transform.parent = arg_253_1.stage_.transform
				var_256_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_253_1.bgs_.XH0407a = var_256_0
			end

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				local var_256_1 = arg_253_1.bgs_.XH0407a

				arg_253_1.bgs_.XH0407a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_256_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_256_2 = var_256_1:GetComponent("SpriteRenderer")

				if var_256_2 and var_256_2.sprite then
					local var_256_3 = 2 * (var_256_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_256_1.transform.localScale = Vector3.New(var_256_3 / var_256_2.sprite.bounds.size.y < var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x and var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x or var_256_3 / var_256_2.sprite.bounds.size.y, var_256_3 / var_256_2.sprite.bounds.size.y < var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x and var_256_3 * manager.ui.mainCameraCom_.aspect / var_256_2.sprite.bounds.size.x or var_256_3 / var_256_2.sprite.bounds.size.y, 0)
				end

				for iter_256_0, iter_256_1 in pairs(arg_253_1.bgs_) do
					if iter_256_0 ~= "XH0407a" then
						iter_256_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_256_4 = 0

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_4 + arg_256_0 then
				arg_253_1.mask_.enabled = true
				arg_253_1.mask_.raycastTarget = true

				arg_253_1:SetGaussion(false)
			end

			local var_256_5 = 2

			if var_256_4 <= arg_253_1.time_ and arg_253_1.time_ < var_256_4 + var_256_5 then
				local var_256_6 = Color.New(1, 1, 1)

				var_256_6.a = Mathf.Lerp(1, 0, (arg_253_1.time_ - var_256_4) / var_256_5)
				arg_253_1.mask_.color = var_256_6
			end

			if arg_253_1.time_ >= var_256_4 + var_256_5 and arg_253_1.time_ < var_256_4 + var_256_5 + arg_256_0 then
				local var_256_7 = Color.New(1, 1, 1)

				arg_253_1.mask_.enabled = false
				var_256_7.a = 0
				arg_253_1.mask_.color = var_256_7
			end

			local var_256_8 = arg_253_1.actors_["10079ui_story"]

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.characterEffect10079ui_story == nil then
				arg_253_1.var_.characterEffect10079ui_story = var_256_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_256_9 = 0.200000002980232

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_9 and not isNil(var_256_8) then
				if arg_253_1.var_.characterEffect10079ui_story and not isNil(var_256_8) then
					arg_253_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_253_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_253_1.time_ - 0) / var_256_9)
				end
			end

			if arg_253_1.time_ >= 0 + var_256_9 and arg_253_1.time_ < 0 + var_256_9 + arg_256_0 and not isNil(var_256_8) and arg_253_1.var_.characterEffect10079ui_story then
				arg_253_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_253_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_256_10 = arg_253_1.actors_["10079ui_story"].transform

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.var_.moveOldPos10079ui_story = var_256_10.localPosition
			end

			local var_256_11 = 0.001

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_11 then
				var_256_10.localPosition = Vector3.Lerp(arg_253_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_253_1.time_ - 0) / var_256_11)
				var_256_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_10.position).x, (manager.ui.mainCamera.transform.position - var_256_10.position).y, (manager.ui.mainCamera.transform.position - var_256_10.position).z)
				var_256_10.localEulerAngles.z = 0
				var_256_10.localEulerAngles.x = 0
				var_256_10.localEulerAngles = var_256_10.localEulerAngles
			end

			if arg_253_1.time_ >= 0 + var_256_11 and arg_253_1.time_ < 0 + var_256_11 + arg_256_0 then
				var_256_10.localPosition = Vector3.New(0, 100, 0)
				var_256_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_256_10.position).x, (manager.ui.mainCamera.transform.position - var_256_10.position).y, (manager.ui.mainCamera.transform.position - var_256_10.position).z)
				var_256_10.localEulerAngles.z = 0
				var_256_10.localEulerAngles.x = 0
				var_256_10.localEulerAngles = var_256_10.localEulerAngles
			end

			if arg_253_1.frameCnt_ <= 1 then
				arg_253_1.dialog_:SetActive(false)
			end

			local var_256_12 = 2.03400000184774
			local var_256_13 = 0.15

			if 2.03400000184774 < arg_253_1.time_ and arg_253_1.time_ <= var_256_12 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0

				arg_253_1.dialog_:SetActive(true)

				arg_253_1.dialogCg_.alpha = 0

				local var_256_14 = LeanTween.value(arg_253_1.dialog_, 0, 1, 0.3)

				var_256_14:setOnUpdate(LuaHelper.FloatAction(function(arg_257_0)
					arg_253_1.dialogCg_.alpha = arg_257_0
				end))
				var_256_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_253_1.dialog_)
					var_256_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_253_1.duration_ = arg_253_1.duration_ + 0.3

				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, true)
				arg_253_1.iconController_:SetSelectedState("hero")

				arg_253_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadowm")

				arg_253_1.callingController_:SetSelectedState("normal")

				arg_253_1.keyicon_.color = Color.New(1, 1, 1)
				arg_253_1.icon_.color = Color.New(1, 1, 1)

				local var_256_15 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(319601062).content)

				arg_253_1.text_.text = var_256_15

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_17 = 6 <= 0 and var_256_13 or var_256_13 * (utf8.len(var_256_15) / 6)

				if (6 <= 0 and var_256_13 or var_256_13 * (utf8.len(var_256_15) / 6)) > 0 and var_256_13 < var_256_17 then
					arg_253_1.talkMaxDuration = var_256_17
					var_256_12 = var_256_12 + 0.3

					if var_256_17 + var_256_12 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_17 + var_256_12
					end
				end

				arg_253_1.text_.text = var_256_15
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_18 = var_256_12 + 0.3
			local var_256_19 = math.max(var_256_13, arg_253_1.talkMaxDuration)

			if var_256_12 + 0.3 <= arg_253_1.time_ and arg_253_1.time_ < var_256_18 + var_256_19 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_18) / var_256_19

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_18 + var_256_19 and arg_253_1.time_ < var_256_18 + var_256_19 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {
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

		arg_253_1:InitPlayNodeList()
	end,
	Play319601063 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 319601063
		arg_259_1.duration_ = 7

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play319601064(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			if 0 < arg_259_1.time_ and arg_259_1.time_ <= 0 + arg_262_0 then
				local var_262_0 = arg_259_1.bgs_.STblack

				arg_259_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_262_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_262_1 = var_262_0:GetComponent("SpriteRenderer")

				if var_262_1 and var_262_1.sprite then
					local var_262_2 = 2 * (var_262_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_262_0.transform.localScale = Vector3.New(var_262_2 / var_262_1.sprite.bounds.size.y < var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x and var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x or var_262_2 / var_262_1.sprite.bounds.size.y, var_262_2 / var_262_1.sprite.bounds.size.y < var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x and var_262_2 * manager.ui.mainCameraCom_.aspect / var_262_1.sprite.bounds.size.x or var_262_2 / var_262_1.sprite.bounds.size.y, 0)
				end

				for iter_262_0, iter_262_1 in pairs(arg_259_1.bgs_) do
					if iter_262_0 ~= "STblack" then
						iter_262_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_262_3 = 0

			if 0 < arg_259_1.time_ and arg_259_1.time_ <= var_262_3 + arg_262_0 then
				arg_259_1.mask_.enabled = true
				arg_259_1.mask_.raycastTarget = true

				arg_259_1:SetGaussion(false)
			end

			local var_262_4 = 2

			if var_262_3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_3 + var_262_4 then
				local var_262_5 = Color.New(1, 1, 1)

				var_262_5.a = Mathf.Lerp(1, 0, (arg_259_1.time_ - var_262_3) / var_262_4)
				arg_259_1.mask_.color = var_262_5
			end

			if arg_259_1.time_ >= var_262_3 + var_262_4 and arg_259_1.time_ < var_262_3 + var_262_4 + arg_262_0 then
				local var_262_6 = Color.New(1, 1, 1)

				arg_259_1.mask_.enabled = false
				var_262_6.a = 0
				arg_259_1.mask_.color = var_262_6
			end

			if arg_259_1.frameCnt_ <= 1 then
				arg_259_1.dialog_:SetActive(false)
			end

			local var_262_7 = 2
			local var_262_8 = 1.125

			if 2 < arg_259_1.time_ and arg_259_1.time_ <= var_262_7 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0

				arg_259_1.dialog_:SetActive(true)

				arg_259_1.dialogCg_.alpha = 0

				local var_262_9 = LeanTween.value(arg_259_1.dialog_, 0, 1, 0.3)

				var_262_9:setOnUpdate(LuaHelper.FloatAction(function(arg_263_0)
					arg_259_1.dialogCg_.alpha = arg_263_0
				end))
				var_262_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_259_1.dialog_)
					var_262_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_259_1.duration_ = arg_259_1.duration_ + 0.3

				SetActive(arg_259_1.leftNameGo_, false)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_10 = arg_259_1:FormatText(arg_259_1:GetWordFromCfg(319601063).content)

				arg_259_1.text_.text = var_262_10

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_12 = 45 <= 0 and var_262_8 or var_262_8 * (utf8.len(var_262_10) / 45)

				if (45 <= 0 and var_262_8 or var_262_8 * (utf8.len(var_262_10) / 45)) > 0 and var_262_8 < var_262_12 then
					arg_259_1.talkMaxDuration = var_262_12
					var_262_7 = var_262_7 + 0.3

					if var_262_12 + var_262_7 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_12 + var_262_7
					end
				end

				arg_259_1.text_.text = var_262_10
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)
				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_13 = var_262_7 + 0.3
			local var_262_14 = math.max(var_262_8, arg_259_1.talkMaxDuration)

			if var_262_7 + 0.3 <= arg_259_1.time_ and arg_259_1.time_ < var_262_13 + var_262_14 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_13) / var_262_14

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_13 + var_262_14 and arg_259_1.time_ < var_262_13 + var_262_14 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end

		arg_259_1.nodeConfigList_ = {}

		arg_259_1:InitPlayNodeList()
	end,
	Play319601064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 319601064
		arg_265_1.duration_ = 7

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play319601065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				local var_268_0 = arg_265_1.bgs_.I10f

				arg_265_1.bgs_.I10f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_268_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_268_1 = var_268_0:GetComponent("SpriteRenderer")

				if var_268_1 and var_268_1.sprite then
					local var_268_2 = 2 * (var_268_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_268_0.transform.localScale = Vector3.New(var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, var_268_2 / var_268_1.sprite.bounds.size.y < var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x and var_268_2 * manager.ui.mainCameraCom_.aspect / var_268_1.sprite.bounds.size.x or var_268_2 / var_268_1.sprite.bounds.size.y, 0)
				end

				for iter_268_0, iter_268_1 in pairs(arg_265_1.bgs_) do
					if iter_268_0 ~= "I10f" then
						iter_268_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_268_3 = 0

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_3 + arg_268_0 then
				arg_265_1.mask_.enabled = true
				arg_265_1.mask_.raycastTarget = true

				arg_265_1:SetGaussion(false)
			end

			local var_268_4 = 2

			if var_268_3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_3 + var_268_4 then
				local var_268_5 = Color.New(0, 0, 0)

				var_268_5.a = Mathf.Lerp(1, 0, (arg_265_1.time_ - var_268_3) / var_268_4)
				arg_265_1.mask_.color = var_268_5
			end

			if arg_265_1.time_ >= var_268_3 + var_268_4 and arg_265_1.time_ < var_268_3 + var_268_4 + arg_268_0 then
				local var_268_6 = Color.New(0, 0, 0)

				arg_265_1.mask_.enabled = false
				var_268_6.a = 0
				arg_265_1.mask_.color = var_268_6
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			if arg_265_1.frameCnt_ <= 1 then
				arg_265_1.dialog_:SetActive(false)
			end

			local var_268_8 = 2
			local var_268_9 = 1.625

			if 2 < arg_265_1.time_ and arg_265_1.time_ <= var_268_8 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0

				arg_265_1.dialog_:SetActive(true)

				arg_265_1.dialogCg_.alpha = 0

				local var_268_10 = LeanTween.value(arg_265_1.dialog_, 0, 1, 0.3)

				var_268_10:setOnUpdate(LuaHelper.FloatAction(function(arg_269_0)
					arg_265_1.dialogCg_.alpha = arg_269_0
				end))
				var_268_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_265_1.dialog_)
					var_268_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_265_1.duration_ = arg_265_1.duration_ + 0.3

				SetActive(arg_265_1.leftNameGo_, false)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_11 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(319601064).content)

				arg_265_1.text_.text = var_268_11

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_13 = 65 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 65)

				if (65 <= 0 and var_268_9 or var_268_9 * (utf8.len(var_268_11) / 65)) > 0 and var_268_9 < var_268_13 then
					arg_265_1.talkMaxDuration = var_268_13
					var_268_8 = var_268_8 + 0.3

					if var_268_13 + var_268_8 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_13 + var_268_8
					end
				end

				arg_265_1.text_.text = var_268_11
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_14 = var_268_8 + 0.3
			local var_268_15 = math.max(var_268_9, arg_265_1.talkMaxDuration)

			if var_268_8 + 0.3 <= arg_265_1.time_ and arg_265_1.time_ < var_268_14 + var_268_15 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_14) / var_268_15

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_14 + var_268_15 and arg_265_1.time_ < var_268_14 + var_268_15 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play319601065 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 319601065
		arg_271_1.duration_ = 2.37

		local var_271_0 = {
			zh = 2.133,
			ja = 2.366
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
				arg_271_0:Play319601066(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos4037ui_story = arg_271_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_274_0 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_0 then
				arg_271_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_271_1.time_ - 0) / var_274_0)
				arg_271_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["4037ui_story"].transform.position).z)
				arg_271_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["4037ui_story"].transform.localEulerAngles = arg_271_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_0 and arg_271_1.time_ < 0 + var_274_0 + arg_274_0 then
				arg_271_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_271_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_271_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_271_1.actors_["4037ui_story"].transform.position).z)
				arg_271_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_271_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_271_1.actors_["4037ui_story"].transform.localEulerAngles = arg_271_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_274_1 = arg_271_1.actors_["4037ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect4037ui_story == nil then
				arg_271_1.var_.characterEffect4037ui_story = var_274_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_2 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_2 and not isNil(var_274_1) then
				if arg_271_1.var_.characterEffect4037ui_story and not isNil(var_274_1) then
					arg_271_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_271_1.time_ >= 0 + var_274_2 and arg_271_1.time_ < 0 + var_274_2 + arg_274_0 and not isNil(var_274_1) and arg_271_1.var_.characterEffect4037ui_story then
				arg_271_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_274_4 = arg_271_1.actors_["10079ui_story"].transform

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 then
				arg_271_1.var_.moveOldPos10079ui_story = var_274_4.localPosition
			end

			local var_274_5 = 0.001

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_5 then
				var_274_4.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_271_1.time_ - 0) / var_274_5)
				var_274_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_4.position).x, (manager.ui.mainCamera.transform.position - var_274_4.position).y, (manager.ui.mainCamera.transform.position - var_274_4.position).z)
				var_274_4.localEulerAngles.z = 0
				var_274_4.localEulerAngles.x = 0
				var_274_4.localEulerAngles = var_274_4.localEulerAngles
			end

			if arg_271_1.time_ >= 0 + var_274_5 and arg_271_1.time_ < 0 + var_274_5 + arg_274_0 then
				var_274_4.localPosition = Vector3.New(0, 100, 0)
				var_274_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_274_4.position).x, (manager.ui.mainCamera.transform.position - var_274_4.position).y, (manager.ui.mainCamera.transform.position - var_274_4.position).z)
				var_274_4.localEulerAngles.z = 0
				var_274_4.localEulerAngles.x = 0
				var_274_4.localEulerAngles = var_274_4.localEulerAngles
			end

			local var_274_6 = arg_271_1.actors_["10079ui_story"]

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= 0 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10079ui_story == nil then
				arg_271_1.var_.characterEffect10079ui_story = var_274_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_7 = 0.200000002980232

			if 0 <= arg_271_1.time_ and arg_271_1.time_ < 0 + var_274_7 and not isNil(var_274_6) then
				if arg_271_1.var_.characterEffect10079ui_story and not isNil(var_274_6) then
					arg_271_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_271_1.time_ - 0) / var_274_7)
				end
			end

			if arg_271_1.time_ >= 0 + var_274_7 and arg_271_1.time_ < 0 + var_274_7 + arg_274_0 and not isNil(var_274_6) and arg_271_1.var_.characterEffect10079ui_story then
				arg_271_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_274_8 = 0
			local var_274_9 = 0.15

			if 0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_8 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0
				arg_271_1.dialogCg_.alpha = 1

				arg_271_1.dialog_:SetActive(true)
				SetActive(arg_271_1.leftNameGo_, true)

				arg_271_1.leftNameTxt_.text = arg_271_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_271_1.leftNameTxt_.transform)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1.leftNameTxt_.text)
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_10 = arg_271_1:GetWordFromCfg(319601065)
				local var_274_11 = arg_271_1:FormatText(var_274_10.content)

				arg_271_1.text_.text = var_274_11

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_13 = 6 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 6)

				if (6 <= 0 and var_274_9 or var_274_9 * (utf8.len(var_274_11) / 6)) > 0 and var_274_9 < var_274_13 then
					arg_271_1.talkMaxDuration = var_274_13

					if var_274_13 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_13 + var_274_8
					end
				end

				arg_271_1.text_.text = var_274_11
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601065", "story_v_out_319601.awb") ~= 0 then
					local var_274_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601065", "story_v_out_319601.awb") / 1000

					if var_274_14 + var_274_8 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_14 + var_274_8
					end

					if var_274_10.prefab_name ~= "" and arg_271_1.actors_[var_274_10.prefab_name] ~= nil then
						local var_274_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_271_1.actors_[var_274_10.prefab_name].transform, "story_v_out_319601", "319601065", "story_v_out_319601.awb")

						arg_271_1:RecordAudio("319601065", var_274_15)
						arg_271_1:RecordAudio("319601065", var_274_15)
					else
						arg_271_1:AudioAction("play", "voice", "story_v_out_319601", "319601065", "story_v_out_319601.awb")
					end

					arg_271_1:RecordHistoryTalkVoice("story_v_out_319601", "319601065", "story_v_out_319601.awb")
				end

				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_16 = math.max(var_274_9, arg_271_1.talkMaxDuration)

			if var_274_8 <= arg_271_1.time_ and arg_271_1.time_ < var_274_8 + var_274_16 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_8) / var_274_16

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_8 + var_274_16 and arg_271_1.time_ < var_274_8 + var_274_16 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end

		arg_271_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
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

		arg_271_1:InitPlayNodeList()
	end,
	Play319601066 = function(arg_275_0, arg_275_1)
		arg_275_1.time_ = 0
		arg_275_1.frameCnt_ = 0
		arg_275_1.state_ = "playing"
		arg_275_1.curTalkId_ = 319601066
		arg_275_1.duration_ = 13.1

		local var_275_0 = {
			zh = 9.466,
			ja = 13.1
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
				arg_275_0:Play319601067(arg_275_1)
			end
		end

		function arg_275_1.onSingleLineUpdate_(arg_278_0)
			local var_278_0 = 0.95

			if 0 < arg_275_1.time_ and arg_275_1.time_ <= 0 + arg_278_0 then
				arg_275_1.talkMaxDuration = 0
				arg_275_1.dialogCg_.alpha = 1

				arg_275_1.dialog_:SetActive(true)
				SetActive(arg_275_1.leftNameGo_, true)

				arg_275_1.leftNameTxt_.text = arg_275_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_275_1.leftNameTxt_.transform)

				arg_275_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_275_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_275_1:RecordName(arg_275_1.leftNameTxt_.text)
				SetActive(arg_275_1.iconTrs_.gameObject, false)
				arg_275_1.callingController_:SetSelectedState("normal")

				local var_278_1 = arg_275_1:GetWordFromCfg(319601066)
				local var_278_2 = arg_275_1:FormatText(var_278_1.content)

				arg_275_1.text_.text = var_278_2

				LuaForUtil.ClearLinePrefixSymbol(arg_275_1.text_)

				local var_278_4 = 38 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 38)

				if (38 <= 0 and var_278_0 or var_278_0 * (utf8.len(var_278_2) / 38)) > 0 and var_278_0 < var_278_4 then
					arg_275_1.talkMaxDuration = var_278_4

					if var_278_4 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_4 + 0
					end
				end

				arg_275_1.text_.text = var_278_2
				arg_275_1.typewritter.percent = 0

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601066", "story_v_out_319601.awb") ~= 0 then
					local var_278_5 = manager.audio:GetVoiceLength("story_v_out_319601", "319601066", "story_v_out_319601.awb") / 1000

					if var_278_5 + 0 > arg_275_1.duration_ then
						arg_275_1.duration_ = var_278_5 + 0
					end

					if var_278_1.prefab_name ~= "" and arg_275_1.actors_[var_278_1.prefab_name] ~= nil then
						local var_278_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_275_1.actors_[var_278_1.prefab_name].transform, "story_v_out_319601", "319601066", "story_v_out_319601.awb")

						arg_275_1:RecordAudio("319601066", var_278_6)
						arg_275_1:RecordAudio("319601066", var_278_6)
					else
						arg_275_1:AudioAction("play", "voice", "story_v_out_319601", "319601066", "story_v_out_319601.awb")
					end

					arg_275_1:RecordHistoryTalkVoice("story_v_out_319601", "319601066", "story_v_out_319601.awb")
				end

				arg_275_1:RecordContent(arg_275_1.text_.text)
			end

			local var_278_7 = math.max(var_278_0, arg_275_1.talkMaxDuration)

			if 0 <= arg_275_1.time_ and arg_275_1.time_ < 0 + var_278_7 then
				arg_275_1.typewritter.percent = (arg_275_1.time_ - 0) / var_278_7

				arg_275_1.typewritter:SetDirty()
			end

			if arg_275_1.time_ >= 0 + var_278_7 and arg_275_1.time_ < 0 + var_278_7 + arg_278_0 then
				arg_275_1.typewritter.percent = 1

				arg_275_1.typewritter:SetDirty()
				arg_275_1:ShowNextGo(true)
			end
		end

		arg_275_1.nodeConfigList_ = {}

		arg_275_1:InitPlayNodeList()
	end,
	Play319601067 = function(arg_279_0, arg_279_1)
		arg_279_1.time_ = 0
		arg_279_1.frameCnt_ = 0
		arg_279_1.state_ = "playing"
		arg_279_1.curTalkId_ = 319601067
		arg_279_1.duration_ = 5

		SetActive(arg_279_1.tipsGo_, false)

		function arg_279_1.onSingleLineFinish_()
			arg_279_1.onSingleLineUpdate_ = nil
			arg_279_1.onSingleLineFinish_ = nil
			arg_279_1.state_ = "waiting"
		end

		function arg_279_1.playNext_(arg_281_0)
			if arg_281_0 == 1 then
				arg_279_0:Play319601068(arg_279_1)
			end
		end

		function arg_279_1.onSingleLineUpdate_(arg_282_0)
			if 0 < arg_279_1.time_ and arg_279_1.time_ <= 0 + arg_282_0 and not isNil(arg_279_1.actors_["4037ui_story"]) and arg_279_1.var_.characterEffect4037ui_story == nil then
				arg_279_1.var_.characterEffect4037ui_story = arg_279_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_282_0 = 0.200000002980232

			if 0 <= arg_279_1.time_ and arg_279_1.time_ < 0 + var_282_0 and not isNil(arg_279_1.actors_["4037ui_story"]) then
				if arg_279_1.var_.characterEffect4037ui_story and not isNil(arg_279_1.actors_["4037ui_story"]) then
					arg_279_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_279_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_279_1.time_ - 0) / var_282_0)
				end
			end

			if arg_279_1.time_ >= 0 + var_282_0 and arg_279_1.time_ < 0 + var_282_0 + arg_282_0 and not isNil(arg_279_1.actors_["4037ui_story"]) and arg_279_1.var_.characterEffect4037ui_story then
				arg_279_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_279_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_282_1 = 0
			local var_282_2 = 1.4

			if 0 < arg_279_1.time_ and arg_279_1.time_ <= var_282_1 + arg_282_0 then
				arg_279_1.talkMaxDuration = 0
				arg_279_1.dialogCg_.alpha = 1

				arg_279_1.dialog_:SetActive(true)
				SetActive(arg_279_1.leftNameGo_, false)

				arg_279_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_279_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_279_1:RecordName(arg_279_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_279_1.iconTrs_.gameObject, false)
				arg_279_1.callingController_:SetSelectedState("normal")

				local var_282_3 = arg_279_1:FormatText(arg_279_1:GetWordFromCfg(319601067).content)

				arg_279_1.text_.text = var_282_3

				LuaForUtil.ClearLinePrefixSymbol(arg_279_1.text_)

				local var_282_5 = 56 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 56)

				if (56 <= 0 and var_282_2 or var_282_2 * (utf8.len(var_282_3) / 56)) > 0 and var_282_2 < var_282_5 then
					arg_279_1.talkMaxDuration = var_282_5

					if var_282_5 + var_282_1 > arg_279_1.duration_ then
						arg_279_1.duration_ = var_282_5 + var_282_1
					end
				end

				arg_279_1.text_.text = var_282_3
				arg_279_1.typewritter.percent = 0

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(false)
				arg_279_1:RecordContent(arg_279_1.text_.text)
			end

			local var_282_6 = math.max(var_282_2, arg_279_1.talkMaxDuration)

			if var_282_1 <= arg_279_1.time_ and arg_279_1.time_ < var_282_1 + var_282_6 then
				arg_279_1.typewritter.percent = (arg_279_1.time_ - var_282_1) / var_282_6

				arg_279_1.typewritter:SetDirty()
			end

			if arg_279_1.time_ >= var_282_1 + var_282_6 and arg_279_1.time_ < var_282_1 + var_282_6 + arg_282_0 then
				arg_279_1.typewritter.percent = 1

				arg_279_1.typewritter:SetDirty()
				arg_279_1:ShowNextGo(true)
			end
		end

		arg_279_1.nodeConfigList_ = {}

		arg_279_1:InitPlayNodeList()
	end,
	Play319601068 = function(arg_283_0, arg_283_1)
		arg_283_1.time_ = 0
		arg_283_1.frameCnt_ = 0
		arg_283_1.state_ = "playing"
		arg_283_1.curTalkId_ = 319601068
		arg_283_1.duration_ = 2.67

		local var_283_0 = {
			zh = 1.999999999999,
			ja = 2.666
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
				arg_283_0:Play319601069(arg_283_1)
			end
		end

		function arg_283_1.onSingleLineUpdate_(arg_286_0)
			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos4040ui_story = arg_283_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_286_0 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_0 then
				arg_283_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_283_1.time_ - 0) / var_286_0)
				arg_283_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).z)
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles = arg_283_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_0 and arg_283_1.time_ < 0 + var_286_0 + arg_286_0 then
				arg_283_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_283_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_283_1.actors_["4040ui_story"].transform.position).z)
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_283_1.actors_["4040ui_story"].transform.localEulerAngles = arg_283_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_286_1 = arg_283_1.actors_["4040ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect4040ui_story == nil then
				arg_283_1.var_.characterEffect4040ui_story = var_286_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_2 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_2 and not isNil(var_286_1) then
				if arg_283_1.var_.characterEffect4040ui_story and not isNil(var_286_1) then
					arg_283_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_283_1.time_ >= 0 + var_286_2 and arg_283_1.time_ < 0 + var_286_2 + arg_286_0 and not isNil(var_286_1) and arg_283_1.var_.characterEffect4040ui_story then
				arg_283_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_286_4 = arg_283_1.actors_["4037ui_story"].transform

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 then
				arg_283_1.var_.moveOldPos4037ui_story = var_286_4.localPosition
			end

			local var_286_5 = 0.001

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_5 then
				var_286_4.localPosition = Vector3.Lerp(arg_283_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_283_1.time_ - 0) / var_286_5)
				var_286_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_4.position).x, (manager.ui.mainCamera.transform.position - var_286_4.position).y, (manager.ui.mainCamera.transform.position - var_286_4.position).z)
				var_286_4.localEulerAngles.z = 0
				var_286_4.localEulerAngles.x = 0
				var_286_4.localEulerAngles = var_286_4.localEulerAngles
			end

			if arg_283_1.time_ >= 0 + var_286_5 and arg_283_1.time_ < 0 + var_286_5 + arg_286_0 then
				var_286_4.localPosition = Vector3.New(0, 100, 0)
				var_286_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_286_4.position).x, (manager.ui.mainCamera.transform.position - var_286_4.position).y, (manager.ui.mainCamera.transform.position - var_286_4.position).z)
				var_286_4.localEulerAngles.z = 0
				var_286_4.localEulerAngles.x = 0
				var_286_4.localEulerAngles = var_286_4.localEulerAngles
			end

			local var_286_6 = arg_283_1.actors_["4037ui_story"]

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= 0 + arg_286_0 and not isNil(var_286_6) and arg_283_1.var_.characterEffect4037ui_story == nil then
				arg_283_1.var_.characterEffect4037ui_story = var_286_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_286_7 = 0.200000002980232

			if 0 <= arg_283_1.time_ and arg_283_1.time_ < 0 + var_286_7 and not isNil(var_286_6) then
				if arg_283_1.var_.characterEffect4037ui_story and not isNil(var_286_6) then
					arg_283_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_283_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_283_1.time_ - 0) / var_286_7)
				end
			end

			if arg_283_1.time_ >= 0 + var_286_7 and arg_283_1.time_ < 0 + var_286_7 + arg_286_0 and not isNil(var_286_6) and arg_283_1.var_.characterEffect4037ui_story then
				arg_283_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_283_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_286_8 = 0
			local var_286_9 = 0.125

			if 0 < arg_283_1.time_ and arg_283_1.time_ <= var_286_8 + arg_286_0 then
				arg_283_1.talkMaxDuration = 0
				arg_283_1.dialogCg_.alpha = 1

				arg_283_1.dialog_:SetActive(true)
				SetActive(arg_283_1.leftNameGo_, true)

				arg_283_1.leftNameTxt_.text = arg_283_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_283_1.leftNameTxt_.transform)

				arg_283_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_283_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_283_1:RecordName(arg_283_1.leftNameTxt_.text)
				SetActive(arg_283_1.iconTrs_.gameObject, false)
				arg_283_1.callingController_:SetSelectedState("normal")

				local var_286_10 = arg_283_1:GetWordFromCfg(319601068)
				local var_286_11 = arg_283_1:FormatText(var_286_10.content)

				arg_283_1.text_.text = var_286_11

				LuaForUtil.ClearLinePrefixSymbol(arg_283_1.text_)

				local var_286_13 = 5 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 5)

				if (5 <= 0 and var_286_9 or var_286_9 * (utf8.len(var_286_11) / 5)) > 0 and var_286_9 < var_286_13 then
					arg_283_1.talkMaxDuration = var_286_13

					if var_286_13 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_13 + var_286_8
					end
				end

				arg_283_1.text_.text = var_286_11
				arg_283_1.typewritter.percent = 0

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601068", "story_v_out_319601.awb") ~= 0 then
					local var_286_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601068", "story_v_out_319601.awb") / 1000

					if var_286_14 + var_286_8 > arg_283_1.duration_ then
						arg_283_1.duration_ = var_286_14 + var_286_8
					end

					if var_286_10.prefab_name ~= "" and arg_283_1.actors_[var_286_10.prefab_name] ~= nil then
						local var_286_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_283_1.actors_[var_286_10.prefab_name].transform, "story_v_out_319601", "319601068", "story_v_out_319601.awb")

						arg_283_1:RecordAudio("319601068", var_286_15)
						arg_283_1:RecordAudio("319601068", var_286_15)
					else
						arg_283_1:AudioAction("play", "voice", "story_v_out_319601", "319601068", "story_v_out_319601.awb")
					end

					arg_283_1:RecordHistoryTalkVoice("story_v_out_319601", "319601068", "story_v_out_319601.awb")
				end

				arg_283_1:RecordContent(arg_283_1.text_.text)
			end

			local var_286_16 = math.max(var_286_9, arg_283_1.talkMaxDuration)

			if var_286_8 <= arg_283_1.time_ and arg_283_1.time_ < var_286_8 + var_286_16 then
				arg_283_1.typewritter.percent = (arg_283_1.time_ - var_286_8) / var_286_16

				arg_283_1.typewritter:SetDirty()
			end

			if arg_283_1.time_ >= var_286_8 + var_286_16 and arg_283_1.time_ < var_286_8 + var_286_16 + arg_286_0 then
				arg_283_1.typewritter.percent = 1

				arg_283_1.typewritter:SetDirty()
				arg_283_1:ShowNextGo(true)
			end
		end

		arg_283_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_283_1:InitPlayNodeList()
	end,
	Play319601069 = function(arg_287_0, arg_287_1)
		arg_287_1.time_ = 0
		arg_287_1.frameCnt_ = 0
		arg_287_1.state_ = "playing"
		arg_287_1.curTalkId_ = 319601069
		arg_287_1.duration_ = 7.2

		local var_287_0 = {
			zh = 3.633,
			ja = 7.2
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
				arg_287_0:Play319601070(arg_287_1)
			end
		end

		function arg_287_1.onSingleLineUpdate_(arg_290_0)
			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos10079ui_story = arg_287_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_290_0 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_0 then
				arg_287_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_287_1.time_ - 0) / var_290_0)
				arg_287_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).z)
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles = arg_287_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_0 and arg_287_1.time_ < 0 + var_290_0 + arg_290_0 then
				arg_287_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_287_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_287_1.actors_["10079ui_story"].transform.position).z)
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_287_1.actors_["10079ui_story"].transform.localEulerAngles = arg_287_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_290_1 = arg_287_1.actors_["10079ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10079ui_story == nil then
				arg_287_1.var_.characterEffect10079ui_story = var_290_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_2 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_2 and not isNil(var_290_1) then
				if arg_287_1.var_.characterEffect10079ui_story and not isNil(var_290_1) then
					arg_287_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_287_1.time_ >= 0 + var_290_2 and arg_287_1.time_ < 0 + var_290_2 + arg_290_0 and not isNil(var_290_1) and arg_287_1.var_.characterEffect10079ui_story then
				arg_287_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action10_2")
			end

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_290_4 = arg_287_1.actors_["4040ui_story"].transform

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 then
				arg_287_1.var_.moveOldPos4040ui_story = var_290_4.localPosition
			end

			local var_290_5 = 0.001

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_5 then
				var_290_4.localPosition = Vector3.Lerp(arg_287_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_287_1.time_ - 0) / var_290_5)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			if arg_287_1.time_ >= 0 + var_290_5 and arg_287_1.time_ < 0 + var_290_5 + arg_290_0 then
				var_290_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_290_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_290_4.position).x, (manager.ui.mainCamera.transform.position - var_290_4.position).y, (manager.ui.mainCamera.transform.position - var_290_4.position).z)
				var_290_4.localEulerAngles.z = 0
				var_290_4.localEulerAngles.x = 0
				var_290_4.localEulerAngles = var_290_4.localEulerAngles
			end

			local var_290_6 = arg_287_1.actors_["4040ui_story"]

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= 0 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect4040ui_story == nil then
				arg_287_1.var_.characterEffect4040ui_story = var_290_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_290_7 = 0.200000002980232

			if 0 <= arg_287_1.time_ and arg_287_1.time_ < 0 + var_290_7 and not isNil(var_290_6) then
				if arg_287_1.var_.characterEffect4040ui_story and not isNil(var_290_6) then
					arg_287_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_287_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_287_1.time_ - 0) / var_290_7)
				end
			end

			if arg_287_1.time_ >= 0 + var_290_7 and arg_287_1.time_ < 0 + var_290_7 + arg_290_0 and not isNil(var_290_6) and arg_287_1.var_.characterEffect4040ui_story then
				arg_287_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_287_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_290_8 = 0
			local var_290_9 = 0.225

			if 0 < arg_287_1.time_ and arg_287_1.time_ <= var_290_8 + arg_290_0 then
				arg_287_1.talkMaxDuration = 0
				arg_287_1.dialogCg_.alpha = 1

				arg_287_1.dialog_:SetActive(true)
				SetActive(arg_287_1.leftNameGo_, true)

				arg_287_1.leftNameTxt_.text = arg_287_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_287_1.leftNameTxt_.transform)

				arg_287_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_287_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_287_1:RecordName(arg_287_1.leftNameTxt_.text)
				SetActive(arg_287_1.iconTrs_.gameObject, false)
				arg_287_1.callingController_:SetSelectedState("normal")

				local var_290_10 = arg_287_1:GetWordFromCfg(319601069)
				local var_290_11 = arg_287_1:FormatText(var_290_10.content)

				arg_287_1.text_.text = var_290_11

				LuaForUtil.ClearLinePrefixSymbol(arg_287_1.text_)

				local var_290_13 = 9 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 9)

				if (9 <= 0 and var_290_9 or var_290_9 * (utf8.len(var_290_11) / 9)) > 0 and var_290_9 < var_290_13 then
					arg_287_1.talkMaxDuration = var_290_13

					if var_290_13 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_13 + var_290_8
					end
				end

				arg_287_1.text_.text = var_290_11
				arg_287_1.typewritter.percent = 0

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601069", "story_v_out_319601.awb") ~= 0 then
					local var_290_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601069", "story_v_out_319601.awb") / 1000

					if var_290_14 + var_290_8 > arg_287_1.duration_ then
						arg_287_1.duration_ = var_290_14 + var_290_8
					end

					if var_290_10.prefab_name ~= "" and arg_287_1.actors_[var_290_10.prefab_name] ~= nil then
						local var_290_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_287_1.actors_[var_290_10.prefab_name].transform, "story_v_out_319601", "319601069", "story_v_out_319601.awb")

						arg_287_1:RecordAudio("319601069", var_290_15)
						arg_287_1:RecordAudio("319601069", var_290_15)
					else
						arg_287_1:AudioAction("play", "voice", "story_v_out_319601", "319601069", "story_v_out_319601.awb")
					end

					arg_287_1:RecordHistoryTalkVoice("story_v_out_319601", "319601069", "story_v_out_319601.awb")
				end

				arg_287_1:RecordContent(arg_287_1.text_.text)
			end

			local var_290_16 = math.max(var_290_9, arg_287_1.talkMaxDuration)

			if var_290_8 <= arg_287_1.time_ and arg_287_1.time_ < var_290_8 + var_290_16 then
				arg_287_1.typewritter.percent = (arg_287_1.time_ - var_290_8) / var_290_16

				arg_287_1.typewritter:SetDirty()
			end

			if arg_287_1.time_ >= var_290_8 + var_290_16 and arg_287_1.time_ < var_290_8 + var_290_16 + arg_290_0 then
				arg_287_1.typewritter.percent = 1

				arg_287_1.typewritter:SetDirty()
				arg_287_1:ShowNextGo(true)
			end
		end

		arg_287_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_287_1:InitPlayNodeList()
	end,
	Play319601070 = function(arg_291_0, arg_291_1)
		arg_291_1.time_ = 0
		arg_291_1.frameCnt_ = 0
		arg_291_1.state_ = "playing"
		arg_291_1.curTalkId_ = 319601070
		arg_291_1.duration_ = 5

		SetActive(arg_291_1.tipsGo_, false)

		function arg_291_1.onSingleLineFinish_()
			arg_291_1.onSingleLineUpdate_ = nil
			arg_291_1.onSingleLineFinish_ = nil
			arg_291_1.state_ = "waiting"
		end

		function arg_291_1.playNext_(arg_293_0)
			if arg_293_0 == 1 then
				arg_291_0:Play319601071(arg_291_1)
			end
		end

		function arg_291_1.onSingleLineUpdate_(arg_294_0)
			if 0 < arg_291_1.time_ and arg_291_1.time_ <= 0 + arg_294_0 and not isNil(arg_291_1.actors_["10079ui_story"]) and arg_291_1.var_.characterEffect10079ui_story == nil then
				arg_291_1.var_.characterEffect10079ui_story = arg_291_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_294_0 = 0.200000002980232

			if 0 <= arg_291_1.time_ and arg_291_1.time_ < 0 + var_294_0 and not isNil(arg_291_1.actors_["10079ui_story"]) then
				if arg_291_1.var_.characterEffect10079ui_story and not isNil(arg_291_1.actors_["10079ui_story"]) then
					arg_291_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_291_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_291_1.time_ - 0) / var_294_0)
				end
			end

			if arg_291_1.time_ >= 0 + var_294_0 and arg_291_1.time_ < 0 + var_294_0 + arg_294_0 and not isNil(arg_291_1.actors_["10079ui_story"]) and arg_291_1.var_.characterEffect10079ui_story then
				arg_291_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_291_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_294_1 = 0
			local var_294_2 = 1.175

			if 0 < arg_291_1.time_ and arg_291_1.time_ <= var_294_1 + arg_294_0 then
				arg_291_1.talkMaxDuration = 0
				arg_291_1.dialogCg_.alpha = 1

				arg_291_1.dialog_:SetActive(true)
				SetActive(arg_291_1.leftNameGo_, false)

				arg_291_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_291_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_291_1:RecordName(arg_291_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_291_1.iconTrs_.gameObject, false)
				arg_291_1.callingController_:SetSelectedState("normal")

				local var_294_3 = arg_291_1:FormatText(arg_291_1:GetWordFromCfg(319601070).content)

				arg_291_1.text_.text = var_294_3

				LuaForUtil.ClearLinePrefixSymbol(arg_291_1.text_)

				local var_294_5 = 47 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 47)

				if (47 <= 0 and var_294_2 or var_294_2 * (utf8.len(var_294_3) / 47)) > 0 and var_294_2 < var_294_5 then
					arg_291_1.talkMaxDuration = var_294_5

					if var_294_5 + var_294_1 > arg_291_1.duration_ then
						arg_291_1.duration_ = var_294_5 + var_294_1
					end
				end

				arg_291_1.text_.text = var_294_3
				arg_291_1.typewritter.percent = 0

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(false)
				arg_291_1:RecordContent(arg_291_1.text_.text)
			end

			local var_294_6 = math.max(var_294_2, arg_291_1.talkMaxDuration)

			if var_294_1 <= arg_291_1.time_ and arg_291_1.time_ < var_294_1 + var_294_6 then
				arg_291_1.typewritter.percent = (arg_291_1.time_ - var_294_1) / var_294_6

				arg_291_1.typewritter:SetDirty()
			end

			if arg_291_1.time_ >= var_294_1 + var_294_6 and arg_291_1.time_ < var_294_1 + var_294_6 + arg_294_0 then
				arg_291_1.typewritter.percent = 1

				arg_291_1.typewritter:SetDirty()
				arg_291_1:ShowNextGo(true)
			end
		end

		arg_291_1.nodeConfigList_ = {}

		arg_291_1:InitPlayNodeList()
	end,
	Play319601071 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 319601071
		arg_295_1.duration_ = 2.57

		local var_295_0 = {
			zh = 2.566,
			ja = 1.366
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
				arg_295_0:Play319601072(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos4037ui_story = arg_295_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_298_0 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_0 then
				arg_295_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_295_1.time_ - 0) / var_298_0)
				arg_295_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["4037ui_story"].transform.position).z)
				arg_295_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["4037ui_story"].transform.localEulerAngles = arg_295_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_0 and arg_295_1.time_ < 0 + var_298_0 + arg_298_0 then
				arg_295_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_295_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_295_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_295_1.actors_["4037ui_story"].transform.position).z)
				arg_295_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_295_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_295_1.actors_["4037ui_story"].transform.localEulerAngles = arg_295_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_298_1 = arg_295_1.actors_["4037ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect4037ui_story == nil then
				arg_295_1.var_.characterEffect4037ui_story = var_298_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_2 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_2 and not isNil(var_298_1) then
				if arg_295_1.var_.characterEffect4037ui_story and not isNil(var_298_1) then
					arg_295_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_295_1.time_ >= 0 + var_298_2 and arg_295_1.time_ < 0 + var_298_2 + arg_298_0 and not isNil(var_298_1) and arg_295_1.var_.characterEffect4037ui_story then
				arg_295_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_298_4 = arg_295_1.actors_["4040ui_story"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos4040ui_story = var_298_4.localPosition
			end

			local var_298_5 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_5 then
				var_298_4.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_5)
				var_298_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_4.position).x, (manager.ui.mainCamera.transform.position - var_298_4.position).y, (manager.ui.mainCamera.transform.position - var_298_4.position).z)
				var_298_4.localEulerAngles.z = 0
				var_298_4.localEulerAngles.x = 0
				var_298_4.localEulerAngles = var_298_4.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_5 and arg_295_1.time_ < 0 + var_298_5 + arg_298_0 then
				var_298_4.localPosition = Vector3.New(0, 100, 0)
				var_298_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_4.position).x, (manager.ui.mainCamera.transform.position - var_298_4.position).y, (manager.ui.mainCamera.transform.position - var_298_4.position).z)
				var_298_4.localEulerAngles.z = 0
				var_298_4.localEulerAngles.x = 0
				var_298_4.localEulerAngles = var_298_4.localEulerAngles
			end

			local var_298_6 = arg_295_1.actors_["4040ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect4040ui_story == nil then
				arg_295_1.var_.characterEffect4040ui_story = var_298_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_7 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_7 and not isNil(var_298_6) then
				if arg_295_1.var_.characterEffect4040ui_story and not isNil(var_298_6) then
					arg_295_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_295_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_7)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_7 and arg_295_1.time_ < 0 + var_298_7 + arg_298_0 and not isNil(var_298_6) and arg_295_1.var_.characterEffect4040ui_story then
				arg_295_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_295_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_298_8 = arg_295_1.actors_["10079ui_story"].transform

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 then
				arg_295_1.var_.moveOldPos10079ui_story = var_298_8.localPosition
			end

			local var_298_9 = 0.001

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_9 then
				var_298_8.localPosition = Vector3.Lerp(arg_295_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_295_1.time_ - 0) / var_298_9)
				var_298_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_8.position).x, (manager.ui.mainCamera.transform.position - var_298_8.position).y, (manager.ui.mainCamera.transform.position - var_298_8.position).z)
				var_298_8.localEulerAngles.z = 0
				var_298_8.localEulerAngles.x = 0
				var_298_8.localEulerAngles = var_298_8.localEulerAngles
			end

			if arg_295_1.time_ >= 0 + var_298_9 and arg_295_1.time_ < 0 + var_298_9 + arg_298_0 then
				var_298_8.localPosition = Vector3.New(0, 100, 0)
				var_298_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_298_8.position).x, (manager.ui.mainCamera.transform.position - var_298_8.position).y, (manager.ui.mainCamera.transform.position - var_298_8.position).z)
				var_298_8.localEulerAngles.z = 0
				var_298_8.localEulerAngles.x = 0
				var_298_8.localEulerAngles = var_298_8.localEulerAngles
			end

			local var_298_10 = arg_295_1.actors_["10079ui_story"]

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= 0 + arg_298_0 and not isNil(var_298_10) and arg_295_1.var_.characterEffect10079ui_story == nil then
				arg_295_1.var_.characterEffect10079ui_story = var_298_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_298_11 = 0.200000002980232

			if 0 <= arg_295_1.time_ and arg_295_1.time_ < 0 + var_298_11 and not isNil(var_298_10) then
				if arg_295_1.var_.characterEffect10079ui_story and not isNil(var_298_10) then
					arg_295_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_295_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_295_1.time_ - 0) / var_298_11)
				end
			end

			if arg_295_1.time_ >= 0 + var_298_11 and arg_295_1.time_ < 0 + var_298_11 + arg_298_0 and not isNil(var_298_10) and arg_295_1.var_.characterEffect10079ui_story then
				arg_295_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_295_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_298_12 = 0
			local var_298_13 = 0.15

			if 0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_12 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, true)

				arg_295_1.leftNameTxt_.text = arg_295_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_295_1.leftNameTxt_.transform)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1.leftNameTxt_.text)
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_14 = arg_295_1:GetWordFromCfg(319601071)
				local var_298_15 = arg_295_1:FormatText(var_298_14.content)

				arg_295_1.text_.text = var_298_15

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_17 = 6 <= 0 and var_298_13 or var_298_13 * (utf8.len(var_298_15) / 6)

				if (6 <= 0 and var_298_13 or var_298_13 * (utf8.len(var_298_15) / 6)) > 0 and var_298_13 < var_298_17 then
					arg_295_1.talkMaxDuration = var_298_17

					if var_298_17 + var_298_12 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_17 + var_298_12
					end
				end

				arg_295_1.text_.text = var_298_15
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601071", "story_v_out_319601.awb") ~= 0 then
					local var_298_18 = manager.audio:GetVoiceLength("story_v_out_319601", "319601071", "story_v_out_319601.awb") / 1000

					if var_298_18 + var_298_12 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_18 + var_298_12
					end

					if var_298_14.prefab_name ~= "" and arg_295_1.actors_[var_298_14.prefab_name] ~= nil then
						local var_298_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_295_1.actors_[var_298_14.prefab_name].transform, "story_v_out_319601", "319601071", "story_v_out_319601.awb")

						arg_295_1:RecordAudio("319601071", var_298_19)
						arg_295_1:RecordAudio("319601071", var_298_19)
					else
						arg_295_1:AudioAction("play", "voice", "story_v_out_319601", "319601071", "story_v_out_319601.awb")
					end

					arg_295_1:RecordHistoryTalkVoice("story_v_out_319601", "319601071", "story_v_out_319601.awb")
				end

				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_20 = math.max(var_298_13, arg_295_1.talkMaxDuration)

			if var_298_12 <= arg_295_1.time_ and arg_295_1.time_ < var_298_12 + var_298_20 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_12) / var_298_20

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_12 + var_298_20 and arg_295_1.time_ < var_298_12 + var_298_20 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end

		arg_295_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_295_1:InitPlayNodeList()
	end,
	Play319601072 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 319601072
		arg_299_1.duration_ = 5

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play319601073(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 then
				arg_299_1.var_.moveOldPos4037ui_story = arg_299_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_302_0 = 0.001

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_0 then
				arg_299_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_299_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_299_1.time_ - 0) / var_302_0)
				arg_299_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["4037ui_story"].transform.position).z)
				arg_299_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["4037ui_story"].transform.localEulerAngles = arg_299_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_299_1.time_ >= 0 + var_302_0 and arg_299_1.time_ < 0 + var_302_0 + arg_302_0 then
				arg_299_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_299_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_299_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_299_1.actors_["4037ui_story"].transform.position).z)
				arg_299_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_299_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_299_1.actors_["4037ui_story"].transform.localEulerAngles = arg_299_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_302_1 = arg_299_1.actors_["4037ui_story"]

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= 0 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect4037ui_story == nil then
				arg_299_1.var_.characterEffect4037ui_story = var_302_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_302_2 = 0.200000002980232

			if 0 <= arg_299_1.time_ and arg_299_1.time_ < 0 + var_302_2 and not isNil(var_302_1) then
				if arg_299_1.var_.characterEffect4037ui_story and not isNil(var_302_1) then
					arg_299_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_299_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_299_1.time_ - 0) / var_302_2)
				end
			end

			if arg_299_1.time_ >= 0 + var_302_2 and arg_299_1.time_ < 0 + var_302_2 + arg_302_0 and not isNil(var_302_1) and arg_299_1.var_.characterEffect4037ui_story then
				arg_299_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_299_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_302_3 = 0
			local var_302_4 = 0.7

			if 0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_3 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, false)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_299_1.iconTrs_.gameObject, false)
				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_5 = arg_299_1:FormatText(arg_299_1:GetWordFromCfg(319601072).content)

				arg_299_1.text_.text = var_302_5

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_7 = 28 <= 0 and var_302_4 or var_302_4 * (utf8.len(var_302_5) / 28)

				if (28 <= 0 and var_302_4 or var_302_4 * (utf8.len(var_302_5) / 28)) > 0 and var_302_4 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_3 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_3
					end
				end

				arg_299_1.text_.text = var_302_5
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)
				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_8 = math.max(var_302_4, arg_299_1.talkMaxDuration)

			if var_302_3 <= arg_299_1.time_ and arg_299_1.time_ < var_302_3 + var_302_8 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_3) / var_302_8

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_3 + var_302_8 and arg_299_1.time_ < var_302_3 + var_302_8 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end

		arg_299_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_299_1:InitPlayNodeList()
	end,
	Play319601073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 319601073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play319601074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 1.3

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= 0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_1 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(319601073).content)

				arg_303_1.text_.text = var_306_1

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_3 = 52 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 52)

				if (52 <= 0 and var_306_0 or var_306_0 * (utf8.len(var_306_1) / 52)) > 0 and var_306_0 < var_306_3 then
					arg_303_1.talkMaxDuration = var_306_3

					if var_306_3 + 0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_3 + 0
					end
				end

				arg_303_1.text_.text = var_306_1
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_4 = math.max(var_306_0, arg_303_1.talkMaxDuration)

			if 0 <= arg_303_1.time_ and arg_303_1.time_ < 0 + var_306_4 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - 0) / var_306_4

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= 0 + var_306_4 and arg_303_1.time_ < 0 + var_306_4 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play319601074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 319601074
		arg_307_1.duration_ = 3.7

		local var_307_0 = {
			zh = 1.999999999999,
			ja = 3.7
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play319601075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1.var_.moveOldPos4040ui_story = arg_307_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_310_0 = 0.001

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_0 then
				arg_307_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_307_1.var_.moveOldPos4040ui_story, Vector3.New(0, -1.55, -5.5), (arg_307_1.time_ - 0) / var_310_0)
				arg_307_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).z)
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles = arg_307_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_307_1.time_ >= 0 + var_310_0 and arg_307_1.time_ < 0 + var_310_0 + arg_310_0 then
				arg_307_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(0, -1.55, -5.5)
				arg_307_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_307_1.actors_["4040ui_story"].transform.position).z)
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_307_1.actors_["4040ui_story"].transform.localEulerAngles = arg_307_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_310_1 = arg_307_1.actors_["4040ui_story"]

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect4040ui_story == nil then
				arg_307_1.var_.characterEffect4040ui_story = var_310_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_310_2 = 0.200000002980232

			if 0 <= arg_307_1.time_ and arg_307_1.time_ < 0 + var_310_2 and not isNil(var_310_1) then
				if arg_307_1.var_.characterEffect4040ui_story and not isNil(var_310_1) then
					arg_307_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_307_1.time_ >= 0 + var_310_2 and arg_307_1.time_ < 0 + var_310_2 + arg_310_0 and not isNil(var_310_1) and arg_307_1.var_.characterEffect4040ui_story then
				arg_307_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= 0 + arg_310_0 then
				arg_307_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_310_4 = 0
			local var_310_5 = 0.1

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_4 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_6 = arg_307_1:GetWordFromCfg(319601074)
				local var_310_7 = arg_307_1:FormatText(var_310_6.content)

				arg_307_1.text_.text = var_310_7

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_9 = 4 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 4)

				if (4 <= 0 and var_310_5 or var_310_5 * (utf8.len(var_310_7) / 4)) > 0 and var_310_5 < var_310_9 then
					arg_307_1.talkMaxDuration = var_310_9

					if var_310_9 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_4
					end
				end

				arg_307_1.text_.text = var_310_7
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601074", "story_v_out_319601.awb") ~= 0 then
					local var_310_10 = manager.audio:GetVoiceLength("story_v_out_319601", "319601074", "story_v_out_319601.awb") / 1000

					if var_310_10 + var_310_4 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_10 + var_310_4
					end

					if var_310_6.prefab_name ~= "" and arg_307_1.actors_[var_310_6.prefab_name] ~= nil then
						local var_310_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_6.prefab_name].transform, "story_v_out_319601", "319601074", "story_v_out_319601.awb")

						arg_307_1:RecordAudio("319601074", var_310_11)
						arg_307_1:RecordAudio("319601074", var_310_11)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_319601", "319601074", "story_v_out_319601.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_319601", "319601074", "story_v_out_319601.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_12 = math.max(var_310_5, arg_307_1.talkMaxDuration)

			if var_310_4 <= arg_307_1.time_ and arg_307_1.time_ < var_310_4 + var_310_12 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_4) / var_310_12

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_4 + var_310_12 and arg_307_1.time_ < var_310_4 + var_310_12 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_307_1:InitPlayNodeList()
	end,
	Play319601075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 319601075
		arg_311_1.duration_ = 7.7

		local var_311_0 = {
			zh = 2.266,
			ja = 7.7
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
				arg_311_0:Play319601076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos10079ui_story = arg_311_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_314_0 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_0 then
				arg_311_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_311_1.time_ - 0) / var_314_0)
				arg_311_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10079ui_story"].transform.position).z)
				arg_311_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["10079ui_story"].transform.localEulerAngles = arg_311_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_0 and arg_311_1.time_ < 0 + var_314_0 + arg_314_0 then
				arg_311_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_311_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_311_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_311_1.actors_["10079ui_story"].transform.position).z)
				arg_311_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_311_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_311_1.actors_["10079ui_story"].transform.localEulerAngles = arg_311_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_314_1 = arg_311_1.actors_["10079ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect10079ui_story == nil then
				arg_311_1.var_.characterEffect10079ui_story = var_314_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_2 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_2 and not isNil(var_314_1) then
				if arg_311_1.var_.characterEffect10079ui_story and not isNil(var_314_1) then
					arg_311_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_311_1.time_ >= 0 + var_314_2 and arg_311_1.time_ < 0 + var_314_2 + arg_314_0 and not isNil(var_314_1) and arg_311_1.var_.characterEffect10079ui_story then
				arg_311_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action1_1")
			end

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_314_4 = arg_311_1.actors_["4040ui_story"].transform

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 then
				arg_311_1.var_.moveOldPos4040ui_story = var_314_4.localPosition
			end

			local var_314_5 = 0.001

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_5 then
				var_314_4.localPosition = Vector3.Lerp(arg_311_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_311_1.time_ - 0) / var_314_5)
				var_314_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_4.position).x, (manager.ui.mainCamera.transform.position - var_314_4.position).y, (manager.ui.mainCamera.transform.position - var_314_4.position).z)
				var_314_4.localEulerAngles.z = 0
				var_314_4.localEulerAngles.x = 0
				var_314_4.localEulerAngles = var_314_4.localEulerAngles
			end

			if arg_311_1.time_ >= 0 + var_314_5 and arg_311_1.time_ < 0 + var_314_5 + arg_314_0 then
				var_314_4.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				var_314_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_314_4.position).x, (manager.ui.mainCamera.transform.position - var_314_4.position).y, (manager.ui.mainCamera.transform.position - var_314_4.position).z)
				var_314_4.localEulerAngles.z = 0
				var_314_4.localEulerAngles.x = 0
				var_314_4.localEulerAngles = var_314_4.localEulerAngles
			end

			local var_314_6 = arg_311_1.actors_["4040ui_story"]

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= 0 + arg_314_0 and not isNil(var_314_6) and arg_311_1.var_.characterEffect4040ui_story == nil then
				arg_311_1.var_.characterEffect4040ui_story = var_314_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_314_7 = 0.200000002980232

			if 0 <= arg_311_1.time_ and arg_311_1.time_ < 0 + var_314_7 and not isNil(var_314_6) then
				if arg_311_1.var_.characterEffect4040ui_story and not isNil(var_314_6) then
					arg_311_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_311_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_311_1.time_ - 0) / var_314_7)
				end
			end

			if arg_311_1.time_ >= 0 + var_314_7 and arg_311_1.time_ < 0 + var_314_7 + arg_314_0 and not isNil(var_314_6) and arg_311_1.var_.characterEffect4040ui_story then
				arg_311_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_311_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_314_8 = 0
			local var_314_9 = 0.175

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_8 + arg_314_0 then
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

				local var_314_10 = arg_311_1:GetWordFromCfg(319601075)
				local var_314_11 = arg_311_1:FormatText(var_314_10.content)

				arg_311_1.text_.text = var_314_11

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_13 = 7 <= 0 and var_314_9 or var_314_9 * (utf8.len(var_314_11) / 7)

				if (7 <= 0 and var_314_9 or var_314_9 * (utf8.len(var_314_11) / 7)) > 0 and var_314_9 < var_314_13 then
					arg_311_1.talkMaxDuration = var_314_13

					if var_314_13 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_13 + var_314_8
					end
				end

				arg_311_1.text_.text = var_314_11
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601075", "story_v_out_319601.awb") ~= 0 then
					local var_314_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601075", "story_v_out_319601.awb") / 1000

					if var_314_14 + var_314_8 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_14 + var_314_8
					end

					if var_314_10.prefab_name ~= "" and arg_311_1.actors_[var_314_10.prefab_name] ~= nil then
						local var_314_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_311_1.actors_[var_314_10.prefab_name].transform, "story_v_out_319601", "319601075", "story_v_out_319601.awb")

						arg_311_1:RecordAudio("319601075", var_314_15)
						arg_311_1:RecordAudio("319601075", var_314_15)
					else
						arg_311_1:AudioAction("play", "voice", "story_v_out_319601", "319601075", "story_v_out_319601.awb")
					end

					arg_311_1:RecordHistoryTalkVoice("story_v_out_319601", "319601075", "story_v_out_319601.awb")
				end

				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_16 = math.max(var_314_9, arg_311_1.talkMaxDuration)

			if var_314_8 <= arg_311_1.time_ and arg_311_1.time_ < var_314_8 + var_314_16 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_8) / var_314_16

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_8 + var_314_16 and arg_311_1.time_ < var_314_8 + var_314_16 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {
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
				actorName = "4040ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_311_1:InitPlayNodeList()
	end,
	Play319601076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 319601076
		arg_315_1.duration_ = 5

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play319601077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 and not isNil(arg_315_1.actors_["10079ui_story"]) and arg_315_1.var_.characterEffect10079ui_story == nil then
				arg_315_1.var_.characterEffect10079ui_story = arg_315_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_318_0 = 0.200000002980232

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_0 and not isNil(arg_315_1.actors_["10079ui_story"]) then
				if arg_315_1.var_.characterEffect10079ui_story and not isNil(arg_315_1.actors_["10079ui_story"]) then
					arg_315_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_315_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_315_1.time_ - 0) / var_318_0)
				end
			end

			if arg_315_1.time_ >= 0 + var_318_0 and arg_315_1.time_ < 0 + var_318_0 + arg_318_0 and not isNil(arg_315_1.actors_["10079ui_story"]) and arg_315_1.var_.characterEffect10079ui_story then
				arg_315_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_315_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1:AudioAction("play", "effect", "se_story_130", "se_story_130_impact", "")
			end

			local var_318_2 = arg_315_1.actors_["4040ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos4040ui_story = var_318_2.localPosition
			end

			local var_318_3 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_3 then
				var_318_2.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_3)
				var_318_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_2.position).x, (manager.ui.mainCamera.transform.position - var_318_2.position).y, (manager.ui.mainCamera.transform.position - var_318_2.position).z)
				var_318_2.localEulerAngles.z = 0
				var_318_2.localEulerAngles.x = 0
				var_318_2.localEulerAngles = var_318_2.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_3 and arg_315_1.time_ < 0 + var_318_3 + arg_318_0 then
				var_318_2.localPosition = Vector3.New(0, 100, 0)
				var_318_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_2.position).x, (manager.ui.mainCamera.transform.position - var_318_2.position).y, (manager.ui.mainCamera.transform.position - var_318_2.position).z)
				var_318_2.localEulerAngles.z = 0
				var_318_2.localEulerAngles.x = 0
				var_318_2.localEulerAngles = var_318_2.localEulerAngles
			end

			local var_318_4 = arg_315_1.actors_["10079ui_story"].transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.moveOldPos10079ui_story = var_318_4.localPosition
			end

			local var_318_5 = 0.001

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_5 then
				var_318_4.localPosition = Vector3.Lerp(arg_315_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_315_1.time_ - 0) / var_318_5)
				var_318_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_4.position).x, (manager.ui.mainCamera.transform.position - var_318_4.position).y, (manager.ui.mainCamera.transform.position - var_318_4.position).z)
				var_318_4.localEulerAngles.z = 0
				var_318_4.localEulerAngles.x = 0
				var_318_4.localEulerAngles = var_318_4.localEulerAngles
			end

			if arg_315_1.time_ >= 0 + var_318_5 and arg_315_1.time_ < 0 + var_318_5 + arg_318_0 then
				var_318_4.localPosition = Vector3.New(0, 100, 0)
				var_318_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_318_4.position).x, (manager.ui.mainCamera.transform.position - var_318_4.position).y, (manager.ui.mainCamera.transform.position - var_318_4.position).z)
				var_318_4.localEulerAngles.z = 0
				var_318_4.localEulerAngles.x = 0
				var_318_4.localEulerAngles = var_318_4.localEulerAngles
			end

			local var_318_6 = manager.ui.mainCamera.transform

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				arg_315_1.var_.shakeOldPos = var_318_6.localPosition
			end

			local var_318_7 = 1

			if 0 <= arg_315_1.time_ and arg_315_1.time_ < 0 + var_318_7 then
				local var_318_8, var_318_9 = math.modf((arg_315_1.time_ - 0) / 0.066)

				var_318_6.localPosition = Vector3.New(var_318_9 * 0.13, var_318_9 * 0.13, var_318_9 * 0.13) + arg_315_1.var_.shakeOldPos
			end

			if arg_315_1.time_ >= 0 + var_318_7 and arg_315_1.time_ < 0 + var_318_7 + arg_318_0 then
				var_318_6.localPosition = arg_315_1.var_.shakeOldPos
			end

			local var_318_10 = 0

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_10 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			if arg_315_1.time_ >= var_318_10 + 1 and arg_315_1.time_ < var_318_10 + 1 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			local var_318_11 = 0
			local var_318_12 = 1.3

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_11 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, false)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_315_1.iconTrs_.gameObject, false)
				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_13 = arg_315_1:FormatText(arg_315_1:GetWordFromCfg(319601076).content)

				arg_315_1.text_.text = var_318_13

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_15 = 52 <= 0 and var_318_12 or var_318_12 * (utf8.len(var_318_13) / 52)

				if (52 <= 0 and var_318_12 or var_318_12 * (utf8.len(var_318_13) / 52)) > 0 and var_318_12 < var_318_15 then
					arg_315_1.talkMaxDuration = var_318_15

					if var_318_15 + var_318_11 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_15 + var_318_11
					end
				end

				arg_315_1.text_.text = var_318_13
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)
				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_16 = math.max(var_318_12, arg_315_1.talkMaxDuration)

			if var_318_11 <= arg_315_1.time_ and arg_315_1.time_ < var_318_11 + var_318_16 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_11) / var_318_16

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_11 + var_318_16 and arg_315_1.time_ < var_318_11 + var_318_16 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_315_1:InitPlayNodeList()
	end,
	Play319601077 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 319601077
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play319601078(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 1.275

			if 0 < arg_319_1.time_ and arg_319_1.time_ <= 0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_1 = arg_319_1:FormatText(arg_319_1:GetWordFromCfg(319601077).content)

				arg_319_1.text_.text = var_322_1

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_3 = 51 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 51)

				if (51 <= 0 and var_322_0 or var_322_0 * (utf8.len(var_322_1) / 51)) > 0 and var_322_0 < var_322_3 then
					arg_319_1.talkMaxDuration = var_322_3

					if var_322_3 + 0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_3 + 0
					end
				end

				arg_319_1.text_.text = var_322_1
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_4 = math.max(var_322_0, arg_319_1.talkMaxDuration)

			if 0 <= arg_319_1.time_ and arg_319_1.time_ < 0 + var_322_4 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - 0) / var_322_4

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= 0 + var_322_4 and arg_319_1.time_ < 0 + var_322_4 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end

		arg_319_1.nodeConfigList_ = {}

		arg_319_1:InitPlayNodeList()
	end,
	Play319601078 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 319601078
		arg_323_1.duration_ = 2.47

		local var_323_0 = {
			zh = 1.999999999999,
			ja = 2.466
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
				arg_323_0:Play319601079(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos4037ui_story = arg_323_1.actors_["4037ui_story"].transform.localPosition
			end

			local var_326_0 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_0 then
				arg_323_1.actors_["4037ui_story"].transform.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos4037ui_story, Vector3.New(0, -1.12, -6.2), (arg_323_1.time_ - 0) / var_326_0)
				arg_323_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).z)
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles = arg_323_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_0 and arg_323_1.time_ < 0 + var_326_0 + arg_326_0 then
				arg_323_1.actors_["4037ui_story"].transform.localPosition = Vector3.New(0, -1.12, -6.2)
				arg_323_1.actors_["4037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_323_1.actors_["4037ui_story"].transform.position).z)
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.z = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles.x = 0
				arg_323_1.actors_["4037ui_story"].transform.localEulerAngles = arg_323_1.actors_["4037ui_story"].transform.localEulerAngles
			end

			local var_326_1 = arg_323_1.actors_["4037ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect4037ui_story == nil then
				arg_323_1.var_.characterEffect4037ui_story = var_326_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_2 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_2 and not isNil(var_326_1) then
				if arg_323_1.var_.characterEffect4037ui_story and not isNil(var_326_1) then
					arg_323_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= 0 + var_326_2 and arg_323_1.time_ < 0 + var_326_2 + arg_326_0 and not isNil(var_326_1) and arg_323_1.var_.characterEffect4037ui_story then
				arg_323_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_326_4 = arg_323_1.actors_["4040ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos4040ui_story = var_326_4.localPosition
			end

			local var_326_5 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_5 then
				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos4040ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_5)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_5 and arg_323_1.time_ < 0 + var_326_5 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, 100, 0)
				var_326_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_4.position).x, (manager.ui.mainCamera.transform.position - var_326_4.position).y, (manager.ui.mainCamera.transform.position - var_326_4.position).z)
				var_326_4.localEulerAngles.z = 0
				var_326_4.localEulerAngles.x = 0
				var_326_4.localEulerAngles = var_326_4.localEulerAngles
			end

			local var_326_6 = arg_323_1.actors_["4040ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect4040ui_story == nil then
				arg_323_1.var_.characterEffect4040ui_story = var_326_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_7 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_7 and not isNil(var_326_6) then
				if arg_323_1.var_.characterEffect4040ui_story and not isNil(var_326_6) then
					arg_323_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_323_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_7)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_7 and arg_323_1.time_ < 0 + var_326_7 + arg_326_0 and not isNil(var_326_6) and arg_323_1.var_.characterEffect4040ui_story then
				arg_323_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_323_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_326_8 = arg_323_1.actors_["10079ui_story"].transform

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 then
				arg_323_1.var_.moveOldPos10079ui_story = var_326_8.localPosition
			end

			local var_326_9 = 0.001

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_9 then
				var_326_8.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos10079ui_story, Vector3.New(0, 100, 0), (arg_323_1.time_ - 0) / var_326_9)
				var_326_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_8.position).x, (manager.ui.mainCamera.transform.position - var_326_8.position).y, (manager.ui.mainCamera.transform.position - var_326_8.position).z)
				var_326_8.localEulerAngles.z = 0
				var_326_8.localEulerAngles.x = 0
				var_326_8.localEulerAngles = var_326_8.localEulerAngles
			end

			if arg_323_1.time_ >= 0 + var_326_9 and arg_323_1.time_ < 0 + var_326_9 + arg_326_0 then
				var_326_8.localPosition = Vector3.New(0, 100, 0)
				var_326_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_326_8.position).x, (manager.ui.mainCamera.transform.position - var_326_8.position).y, (manager.ui.mainCamera.transform.position - var_326_8.position).z)
				var_326_8.localEulerAngles.z = 0
				var_326_8.localEulerAngles.x = 0
				var_326_8.localEulerAngles = var_326_8.localEulerAngles
			end

			local var_326_10 = arg_323_1.actors_["10079ui_story"]

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= 0 + arg_326_0 and not isNil(var_326_10) and arg_323_1.var_.characterEffect10079ui_story == nil then
				arg_323_1.var_.characterEffect10079ui_story = var_326_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_11 = 0.200000002980232

			if 0 <= arg_323_1.time_ and arg_323_1.time_ < 0 + var_326_11 and not isNil(var_326_10) then
				if arg_323_1.var_.characterEffect10079ui_story and not isNil(var_326_10) then
					arg_323_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_323_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_323_1.time_ - 0) / var_326_11)
				end
			end

			if arg_323_1.time_ >= 0 + var_326_11 and arg_323_1.time_ < 0 + var_326_11 + arg_326_0 and not isNil(var_326_10) and arg_323_1.var_.characterEffect10079ui_story then
				arg_323_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_323_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_326_12 = 0
			local var_326_13 = 0.15

			if 0 < arg_323_1.time_ and arg_323_1.time_ <= var_326_12 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				arg_323_1.leftNameTxt_.text = arg_323_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_14 = arg_323_1:GetWordFromCfg(319601078)
				local var_326_15 = arg_323_1:FormatText(var_326_14.content)

				arg_323_1.text_.text = var_326_15

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_17 = 6 <= 0 and var_326_13 or var_326_13 * (utf8.len(var_326_15) / 6)

				if (6 <= 0 and var_326_13 or var_326_13 * (utf8.len(var_326_15) / 6)) > 0 and var_326_13 < var_326_17 then
					arg_323_1.talkMaxDuration = var_326_17

					if var_326_17 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_17 + var_326_12
					end
				end

				arg_323_1.text_.text = var_326_15
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601078", "story_v_out_319601.awb") ~= 0 then
					local var_326_18 = manager.audio:GetVoiceLength("story_v_out_319601", "319601078", "story_v_out_319601.awb") / 1000

					if var_326_18 + var_326_12 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_18 + var_326_12
					end

					if var_326_14.prefab_name ~= "" and arg_323_1.actors_[var_326_14.prefab_name] ~= nil then
						local var_326_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_14.prefab_name].transform, "story_v_out_319601", "319601078", "story_v_out_319601.awb")

						arg_323_1:RecordAudio("319601078", var_326_19)
						arg_323_1:RecordAudio("319601078", var_326_19)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_319601", "319601078", "story_v_out_319601.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_319601", "319601078", "story_v_out_319601.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_20 = math.max(var_326_13, arg_323_1.talkMaxDuration)

			if var_326_12 <= arg_323_1.time_ and arg_323_1.time_ < var_326_12 + var_326_20 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_12) / var_326_20

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_12 + var_326_20 and arg_323_1.time_ < var_326_12 + var_326_20 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end

		arg_323_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_323_1:InitPlayNodeList()
	end,
	Play319601079 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 319601079
		arg_327_1.duration_ = 2.03

		local var_327_0 = {
			zh = 2.033,
			ja = 1.999999999999
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
				arg_327_0:Play319601080(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			if arg_327_1.actors_["10037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10037ui_story"))) then
				local var_330_0 = Object.Instantiate(Asset.Load("Char/" .. "10037ui_story"), arg_327_1.stage_.transform)

				var_330_0.name = "10037ui_story"
				var_330_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_327_1.actors_["10037ui_story"] = var_330_0

				local var_330_1 = var_330_0:GetComponentInChildren(typeof(CharacterEffect))

				var_330_1.enabled = true

				local var_330_2 = GameObjectTools.GetOrAddComponent(var_330_0, typeof(DynamicBoneHelper))

				if var_330_2 then
					var_330_2:EnableDynamicBone(false)
				end

				arg_327_1:ShowWeapon(var_330_1.transform, false)

				arg_327_1.var_["10037ui_story" .. "Animator"] = var_330_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_327_1.var_["10037ui_story" .. "Animator"].applyRootMotion = true
				arg_327_1.var_["10037ui_story" .. "LipSync"] = var_330_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_330_3 = arg_327_1.actors_["10037ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos10037ui_story = var_330_3.localPosition
			end

			local var_330_4 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_4 then
				var_330_3.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos10037ui_story, Vector3.New(0.7, -1.13, -6.2), (arg_327_1.time_ - 0) / var_330_4)
				var_330_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_3.position).x, (manager.ui.mainCamera.transform.position - var_330_3.position).y, (manager.ui.mainCamera.transform.position - var_330_3.position).z)
				var_330_3.localEulerAngles.z = 0
				var_330_3.localEulerAngles.x = 0
				var_330_3.localEulerAngles = var_330_3.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_4 and arg_327_1.time_ < 0 + var_330_4 + arg_330_0 then
				var_330_3.localPosition = Vector3.New(0.7, -1.13, -6.2)
				var_330_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_3.position).x, (manager.ui.mainCamera.transform.position - var_330_3.position).y, (manager.ui.mainCamera.transform.position - var_330_3.position).z)
				var_330_3.localEulerAngles.z = 0
				var_330_3.localEulerAngles.x = 0
				var_330_3.localEulerAngles = var_330_3.localEulerAngles
			end

			local var_330_5 = arg_327_1.actors_["10037ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.characterEffect10037ui_story == nil then
				arg_327_1.var_.characterEffect10037ui_story = var_330_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_6 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_6 and not isNil(var_330_5) then
				if arg_327_1.var_.characterEffect10037ui_story and not isNil(var_330_5) then
					arg_327_1.var_.characterEffect10037ui_story.fillFlat = false
				end
			end

			if arg_327_1.time_ >= 0 + var_330_6 and arg_327_1.time_ < 0 + var_330_6 + arg_330_0 and not isNil(var_330_5) and arg_327_1.var_.characterEffect10037ui_story then
				arg_327_1.var_.characterEffect10037ui_story.fillFlat = false
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/story10037/story10037action/10037action1_1")
			end

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1:PlayTimeline("10037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_330_8 = arg_327_1.actors_["4037ui_story"].transform

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 then
				arg_327_1.var_.moveOldPos4037ui_story = var_330_8.localPosition
			end

			local var_330_9 = 0.001

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_9 then
				var_330_8.localPosition = Vector3.Lerp(arg_327_1.var_.moveOldPos4037ui_story, Vector3.New(-0.7, -1.12, -6.2), (arg_327_1.time_ - 0) / var_330_9)
				var_330_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_8.position).x, (manager.ui.mainCamera.transform.position - var_330_8.position).y, (manager.ui.mainCamera.transform.position - var_330_8.position).z)
				var_330_8.localEulerAngles.z = 0
				var_330_8.localEulerAngles.x = 0
				var_330_8.localEulerAngles = var_330_8.localEulerAngles
			end

			if arg_327_1.time_ >= 0 + var_330_9 and arg_327_1.time_ < 0 + var_330_9 + arg_330_0 then
				var_330_8.localPosition = Vector3.New(-0.7, -1.12, -6.2)
				var_330_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_330_8.position).x, (manager.ui.mainCamera.transform.position - var_330_8.position).y, (manager.ui.mainCamera.transform.position - var_330_8.position).z)
				var_330_8.localEulerAngles.z = 0
				var_330_8.localEulerAngles.x = 0
				var_330_8.localEulerAngles = var_330_8.localEulerAngles
			end

			local var_330_10 = arg_327_1.actors_["4037ui_story"]

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= 0 + arg_330_0 and not isNil(var_330_10) and arg_327_1.var_.characterEffect4037ui_story == nil then
				arg_327_1.var_.characterEffect4037ui_story = var_330_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_11 = 0.200000002980232

			if 0 <= arg_327_1.time_ and arg_327_1.time_ < 0 + var_330_11 and not isNil(var_330_10) then
				if arg_327_1.var_.characterEffect4037ui_story and not isNil(var_330_10) then
					arg_327_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_327_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_327_1.time_ - 0) / var_330_11)
				end
			end

			if arg_327_1.time_ >= 0 + var_330_11 and arg_327_1.time_ < 0 + var_330_11 + arg_330_0 and not isNil(var_330_10) and arg_327_1.var_.characterEffect4037ui_story then
				arg_327_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_327_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			local var_330_12 = 0
			local var_330_13 = 0.2

			if 0 < arg_327_1.time_ and arg_327_1.time_ <= var_330_12 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				arg_327_1.leftNameTxt_.text = arg_327_1:FormatText(StoryNameCfg[383].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, false)
				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_14 = arg_327_1:GetWordFromCfg(319601079)
				local var_330_15 = arg_327_1:FormatText(var_330_14.content)

				arg_327_1.text_.text = var_330_15

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_17 = 8 <= 0 and var_330_13 or var_330_13 * (utf8.len(var_330_15) / 8)

				if (8 <= 0 and var_330_13 or var_330_13 * (utf8.len(var_330_15) / 8)) > 0 and var_330_13 < var_330_17 then
					arg_327_1.talkMaxDuration = var_330_17

					if var_330_17 + var_330_12 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_17 + var_330_12
					end
				end

				arg_327_1.text_.text = var_330_15
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601079", "story_v_out_319601.awb") ~= 0 then
					local var_330_18 = manager.audio:GetVoiceLength("story_v_out_319601", "319601079", "story_v_out_319601.awb") / 1000

					if var_330_18 + var_330_12 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_18 + var_330_12
					end

					if var_330_14.prefab_name ~= "" and arg_327_1.actors_[var_330_14.prefab_name] ~= nil then
						local var_330_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_14.prefab_name].transform, "story_v_out_319601", "319601079", "story_v_out_319601.awb")

						arg_327_1:RecordAudio("319601079", var_330_19)
						arg_327_1:RecordAudio("319601079", var_330_19)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_319601", "319601079", "story_v_out_319601.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_319601", "319601079", "story_v_out_319601.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_20 = math.max(var_330_13, arg_327_1.talkMaxDuration)

			if var_330_12 <= arg_327_1.time_ and arg_327_1.time_ < var_330_12 + var_330_20 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_12) / var_330_20

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_12 + var_330_20 and arg_327_1.time_ < var_330_12 + var_330_20 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end

		arg_327_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_327_1:InitPlayNodeList()
	end,
	Play319601080 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 319601080
		arg_331_1.duration_ = 5

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play319601081(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			if 0 < arg_331_1.time_ and arg_331_1.time_ <= 0 + arg_334_0 and not isNil(arg_331_1.actors_["10037ui_story"]) and arg_331_1.var_.characterEffect10037ui_story == nil then
				arg_331_1.var_.characterEffect10037ui_story = arg_331_1.actors_["10037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_0 = 0.200000002980232

			if 0 <= arg_331_1.time_ and arg_331_1.time_ < 0 + var_334_0 and not isNil(arg_331_1.actors_["10037ui_story"]) then
				if arg_331_1.var_.characterEffect10037ui_story and not isNil(arg_331_1.actors_["10037ui_story"]) then
					arg_331_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_331_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_331_1.time_ - 0) / var_334_0)
				end
			end

			if arg_331_1.time_ >= 0 + var_334_0 and arg_331_1.time_ < 0 + var_334_0 + arg_334_0 and not isNil(arg_331_1.actors_["10037ui_story"]) and arg_331_1.var_.characterEffect10037ui_story then
				arg_331_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_331_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_334_1 = 0
			local var_334_2 = 0.8

			if 0 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, false)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_3 = arg_331_1:FormatText(arg_331_1:GetWordFromCfg(319601080).content)

				arg_331_1.text_.text = var_334_3

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_5 = 32 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 32)

				if (32 <= 0 and var_334_2 or var_334_2 * (utf8.len(var_334_3) / 32)) > 0 and var_334_2 < var_334_5 then
					arg_331_1.talkMaxDuration = var_334_5

					if var_334_5 + var_334_1 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_5 + var_334_1
					end
				end

				arg_331_1.text_.text = var_334_3
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)
				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_6 = math.max(var_334_2, arg_331_1.talkMaxDuration)

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_6 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_1) / var_334_6

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_1 + var_334_6 and arg_331_1.time_ < var_334_1 + var_334_6 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end

		arg_331_1.nodeConfigList_ = {}

		arg_331_1:InitPlayNodeList()
	end,
	Play319601081 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 319601081
		arg_335_1.duration_ = 7.97

		local var_335_0 = {
			zh = 4.966,
			ja = 7.966
		}
		local var_335_1 = manager.audio:GetLocalizationFlag()

		if var_335_0[var_335_1] ~= nil then
			arg_335_1.duration_ = var_335_0[var_335_1]
		end

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play319601082(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 and not isNil(arg_335_1.actors_["4037ui_story"]) and arg_335_1.var_.characterEffect4037ui_story == nil then
				arg_335_1.var_.characterEffect4037ui_story = arg_335_1.actors_["4037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_0 = 0.200000002980232

			if 0 <= arg_335_1.time_ and arg_335_1.time_ < 0 + var_338_0 and not isNil(arg_335_1.actors_["4037ui_story"]) then
				if arg_335_1.var_.characterEffect4037ui_story and not isNil(arg_335_1.actors_["4037ui_story"]) then
					arg_335_1.var_.characterEffect4037ui_story.fillFlat = false
				end
			end

			if arg_335_1.time_ >= 0 + var_338_0 and arg_335_1.time_ < 0 + var_338_0 + arg_338_0 and not isNil(arg_335_1.actors_["4037ui_story"]) and arg_335_1.var_.characterEffect4037ui_story then
				arg_335_1.var_.characterEffect4037ui_story.fillFlat = false
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/story4037/story4037action/4037action1_1")
			end

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= 0 + arg_338_0 then
				arg_335_1:PlayTimeline("4037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_338_2 = 0
			local var_338_3 = 0.5

			if 0 < arg_335_1.time_ and arg_335_1.time_ <= var_338_2 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, true)

				arg_335_1.leftNameTxt_.text = arg_335_1:FormatText(StoryNameCfg[453].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_335_1.leftNameTxt_.transform)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1.leftNameTxt_.text)
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_4 = arg_335_1:GetWordFromCfg(319601081)
				local var_338_5 = arg_335_1:FormatText(var_338_4.content)

				arg_335_1.text_.text = var_338_5

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_7 = 20 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 20)

				if (20 <= 0 and var_338_3 or var_338_3 * (utf8.len(var_338_5) / 20)) > 0 and var_338_3 < var_338_7 then
					arg_335_1.talkMaxDuration = var_338_7

					if var_338_7 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_7 + var_338_2
					end
				end

				arg_335_1.text_.text = var_338_5
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601081", "story_v_out_319601.awb") ~= 0 then
					local var_338_8 = manager.audio:GetVoiceLength("story_v_out_319601", "319601081", "story_v_out_319601.awb") / 1000

					if var_338_8 + var_338_2 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_8 + var_338_2
					end

					if var_338_4.prefab_name ~= "" and arg_335_1.actors_[var_338_4.prefab_name] ~= nil then
						local var_338_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_335_1.actors_[var_338_4.prefab_name].transform, "story_v_out_319601", "319601081", "story_v_out_319601.awb")

						arg_335_1:RecordAudio("319601081", var_338_9)
						arg_335_1:RecordAudio("319601081", var_338_9)
					else
						arg_335_1:AudioAction("play", "voice", "story_v_out_319601", "319601081", "story_v_out_319601.awb")
					end

					arg_335_1:RecordHistoryTalkVoice("story_v_out_319601", "319601081", "story_v_out_319601.awb")
				end

				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_10 = math.max(var_338_3, arg_335_1.talkMaxDuration)

			if var_338_2 <= arg_335_1.time_ and arg_335_1.time_ < var_338_2 + var_338_10 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_2) / var_338_10

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_2 + var_338_10 and arg_335_1.time_ < var_338_2 + var_338_10 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end

		arg_335_1.nodeConfigList_ = {}

		arg_335_1:InitPlayNodeList()
	end,
	Play319601082 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 319601082
		arg_339_1.duration_ = 5

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play319601083(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos10037ui_story = arg_339_1.actors_["10037ui_story"].transform.localPosition
			end

			local var_342_0 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_0 then
				arg_339_1.actors_["10037ui_story"].transform.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos10037ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_0)
				arg_339_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10037ui_story"].transform.position).z)
				arg_339_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["10037ui_story"].transform.localEulerAngles = arg_339_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_0 and arg_339_1.time_ < 0 + var_342_0 + arg_342_0 then
				arg_339_1.actors_["10037ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_339_1.actors_["10037ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_339_1.actors_["10037ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10037ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_339_1.actors_["10037ui_story"].transform.position).z)
				arg_339_1.actors_["10037ui_story"].transform.localEulerAngles.z = 0
				arg_339_1.actors_["10037ui_story"].transform.localEulerAngles.x = 0
				arg_339_1.actors_["10037ui_story"].transform.localEulerAngles = arg_339_1.actors_["10037ui_story"].transform.localEulerAngles
			end

			local var_342_1 = arg_339_1.actors_["10037ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect10037ui_story == nil then
				arg_339_1.var_.characterEffect10037ui_story = var_342_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_2 and not isNil(var_342_1) then
				if arg_339_1.var_.characterEffect10037ui_story and not isNil(var_342_1) then
					arg_339_1.var_.characterEffect10037ui_story.fillFlat = true
					arg_339_1.var_.characterEffect10037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_2)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_2 and arg_339_1.time_ < 0 + var_342_2 + arg_342_0 and not isNil(var_342_1) and arg_339_1.var_.characterEffect10037ui_story then
				arg_339_1.var_.characterEffect10037ui_story.fillFlat = true
				arg_339_1.var_.characterEffect10037ui_story.fillRatio = 0.5
			end

			local var_342_3 = arg_339_1.actors_["4037ui_story"].transform

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1.var_.moveOldPos4037ui_story = var_342_3.localPosition
			end

			local var_342_4 = 0.001

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_4 then
				var_342_3.localPosition = Vector3.Lerp(arg_339_1.var_.moveOldPos4037ui_story, Vector3.New(0, 100, 0), (arg_339_1.time_ - 0) / var_342_4)
				var_342_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_3.position).x, (manager.ui.mainCamera.transform.position - var_342_3.position).y, (manager.ui.mainCamera.transform.position - var_342_3.position).z)
				var_342_3.localEulerAngles.z = 0
				var_342_3.localEulerAngles.x = 0
				var_342_3.localEulerAngles = var_342_3.localEulerAngles
			end

			if arg_339_1.time_ >= 0 + var_342_4 and arg_339_1.time_ < 0 + var_342_4 + arg_342_0 then
				var_342_3.localPosition = Vector3.New(0, 100, 0)
				var_342_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_342_3.position).x, (manager.ui.mainCamera.transform.position - var_342_3.position).y, (manager.ui.mainCamera.transform.position - var_342_3.position).z)
				var_342_3.localEulerAngles.z = 0
				var_342_3.localEulerAngles.x = 0
				var_342_3.localEulerAngles = var_342_3.localEulerAngles
			end

			local var_342_5 = arg_339_1.actors_["4037ui_story"]

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.characterEffect4037ui_story == nil then
				arg_339_1.var_.characterEffect4037ui_story = var_342_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_6 = 0.200000002980232

			if 0 <= arg_339_1.time_ and arg_339_1.time_ < 0 + var_342_6 and not isNil(var_342_5) then
				if arg_339_1.var_.characterEffect4037ui_story and not isNil(var_342_5) then
					arg_339_1.var_.characterEffect4037ui_story.fillFlat = true
					arg_339_1.var_.characterEffect4037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_339_1.time_ - 0) / var_342_6)
				end
			end

			if arg_339_1.time_ >= 0 + var_342_6 and arg_339_1.time_ < 0 + var_342_6 + arg_342_0 and not isNil(var_342_5) and arg_339_1.var_.characterEffect4037ui_story then
				arg_339_1.var_.characterEffect4037ui_story.fillFlat = true
				arg_339_1.var_.characterEffect4037ui_story.fillRatio = 0.5
			end

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= 0 + arg_342_0 then
				arg_339_1:AudioAction("play", "effect", "se_story_1211", "se_story_1211_explosionfar", "")
			end

			local var_342_8 = 0
			local var_342_9 = 1.675

			if 0 < arg_339_1.time_ and arg_339_1.time_ <= var_342_8 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, false)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_10 = arg_339_1:FormatText(arg_339_1:GetWordFromCfg(319601082).content)

				arg_339_1.text_.text = var_342_10

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_12 = 67 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_10) / 67)

				if (67 <= 0 and var_342_9 or var_342_9 * (utf8.len(var_342_10) / 67)) > 0 and var_342_9 < var_342_12 then
					arg_339_1.talkMaxDuration = var_342_12

					if var_342_12 + var_342_8 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_8
					end
				end

				arg_339_1.text_.text = var_342_10
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)
				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_13 = math.max(var_342_9, arg_339_1.talkMaxDuration)

			if var_342_8 <= arg_339_1.time_ and arg_339_1.time_ < var_342_8 + var_342_13 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_8) / var_342_13

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_8 + var_342_13 and arg_339_1.time_ < var_342_8 + var_342_13 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end

		arg_339_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_339_1:InitPlayNodeList()
	end,
	Play319601083 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 319601083
		arg_343_1.duration_ = 5

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play319601084(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 1.3

			if 0 < arg_343_1.time_ and arg_343_1.time_ <= 0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, false)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_343_1.iconTrs_.gameObject, false)
				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_1 = arg_343_1:FormatText(arg_343_1:GetWordFromCfg(319601083).content)

				arg_343_1.text_.text = var_346_1

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_3 = 52 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 52)

				if (52 <= 0 and var_346_0 or var_346_0 * (utf8.len(var_346_1) / 52)) > 0 and var_346_0 < var_346_3 then
					arg_343_1.talkMaxDuration = var_346_3

					if var_346_3 + 0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_3 + 0
					end
				end

				arg_343_1.text_.text = var_346_1
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)
				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_4 = math.max(var_346_0, arg_343_1.talkMaxDuration)

			if 0 <= arg_343_1.time_ and arg_343_1.time_ < 0 + var_346_4 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - 0) / var_346_4

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= 0 + var_346_4 and arg_343_1.time_ < 0 + var_346_4 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end

		arg_343_1.nodeConfigList_ = {}

		arg_343_1:InitPlayNodeList()
	end,
	Play319601084 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 319601084
		arg_347_1.duration_ = 3.67

		local var_347_0 = {
			zh = 1.999999999999,
			ja = 3.666
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play319601085(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos4040ui_story = arg_347_1.actors_["4040ui_story"].transform.localPosition
			end

			local var_350_0 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_0 then
				arg_347_1.actors_["4040ui_story"].transform.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos4040ui_story, Vector3.New(-0.7, -1.55, -5.5), (arg_347_1.time_ - 0) / var_350_0)
				arg_347_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["4040ui_story"].transform.position).z)
				arg_347_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["4040ui_story"].transform.localEulerAngles = arg_347_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_0 and arg_347_1.time_ < 0 + var_350_0 + arg_350_0 then
				arg_347_1.actors_["4040ui_story"].transform.localPosition = Vector3.New(-0.7, -1.55, -5.5)
				arg_347_1.actors_["4040ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_347_1.actors_["4040ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["4040ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_347_1.actors_["4040ui_story"].transform.position).z)
				arg_347_1.actors_["4040ui_story"].transform.localEulerAngles.z = 0
				arg_347_1.actors_["4040ui_story"].transform.localEulerAngles.x = 0
				arg_347_1.actors_["4040ui_story"].transform.localEulerAngles = arg_347_1.actors_["4040ui_story"].transform.localEulerAngles
			end

			local var_350_1 = arg_347_1.actors_["4040ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect4040ui_story == nil then
				arg_347_1.var_.characterEffect4040ui_story = var_350_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_2 and not isNil(var_350_1) then
				if arg_347_1.var_.characterEffect4040ui_story and not isNil(var_350_1) then
					arg_347_1.var_.characterEffect4040ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= 0 + var_350_2 and arg_347_1.time_ < 0 + var_350_2 + arg_350_0 and not isNil(var_350_1) and arg_347_1.var_.characterEffect4040ui_story then
				arg_347_1.var_.characterEffect4040ui_story.fillFlat = false
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/story4040/story4040action/4040action1_1")
			end

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1:PlayTimeline("4040ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_350_4 = arg_347_1.actors_["10079ui_story"].transform

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 then
				arg_347_1.var_.moveOldPos10079ui_story = var_350_4.localPosition
			end

			local var_350_5 = 0.001

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_5 then
				var_350_4.localPosition = Vector3.Lerp(arg_347_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_347_1.time_ - 0) / var_350_5)
				var_350_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_4.position).x, (manager.ui.mainCamera.transform.position - var_350_4.position).y, (manager.ui.mainCamera.transform.position - var_350_4.position).z)
				var_350_4.localEulerAngles.z = 0
				var_350_4.localEulerAngles.x = 0
				var_350_4.localEulerAngles = var_350_4.localEulerAngles
			end

			if arg_347_1.time_ >= 0 + var_350_5 and arg_347_1.time_ < 0 + var_350_5 + arg_350_0 then
				var_350_4.localPosition = Vector3.New(0.7, -0.95, -6.05)
				var_350_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_350_4.position).x, (manager.ui.mainCamera.transform.position - var_350_4.position).y, (manager.ui.mainCamera.transform.position - var_350_4.position).z)
				var_350_4.localEulerAngles.z = 0
				var_350_4.localEulerAngles.x = 0
				var_350_4.localEulerAngles = var_350_4.localEulerAngles
			end

			local var_350_6 = arg_347_1.actors_["10079ui_story"]

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= 0 + arg_350_0 and not isNil(var_350_6) and arg_347_1.var_.characterEffect10079ui_story == nil then
				arg_347_1.var_.characterEffect10079ui_story = var_350_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_7 = 0.200000002980232

			if 0 <= arg_347_1.time_ and arg_347_1.time_ < 0 + var_350_7 and not isNil(var_350_6) then
				if arg_347_1.var_.characterEffect10079ui_story and not isNil(var_350_6) then
					arg_347_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_347_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_347_1.time_ - 0) / var_350_7)
				end
			end

			if arg_347_1.time_ >= 0 + var_350_7 and arg_347_1.time_ < 0 + var_350_7 + arg_350_0 and not isNil(var_350_6) and arg_347_1.var_.characterEffect10079ui_story then
				arg_347_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_347_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_350_8 = 0
			local var_350_9 = 0.225

			if 0 < arg_347_1.time_ and arg_347_1.time_ <= var_350_8 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				arg_347_1.leftNameTxt_.text = arg_347_1:FormatText(StoryNameCfg[668].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_10 = arg_347_1:GetWordFromCfg(319601084)
				local var_350_11 = arg_347_1:FormatText(var_350_10.content)

				arg_347_1.text_.text = var_350_11

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_13 = 9 <= 0 and var_350_9 or var_350_9 * (utf8.len(var_350_11) / 9)

				if (9 <= 0 and var_350_9 or var_350_9 * (utf8.len(var_350_11) / 9)) > 0 and var_350_9 < var_350_13 then
					arg_347_1.talkMaxDuration = var_350_13

					if var_350_13 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_13 + var_350_8
					end
				end

				arg_347_1.text_.text = var_350_11
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601084", "story_v_out_319601.awb") ~= 0 then
					local var_350_14 = manager.audio:GetVoiceLength("story_v_out_319601", "319601084", "story_v_out_319601.awb") / 1000

					if var_350_14 + var_350_8 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_14 + var_350_8
					end

					if var_350_10.prefab_name ~= "" and arg_347_1.actors_[var_350_10.prefab_name] ~= nil then
						local var_350_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_10.prefab_name].transform, "story_v_out_319601", "319601084", "story_v_out_319601.awb")

						arg_347_1:RecordAudio("319601084", var_350_15)
						arg_347_1:RecordAudio("319601084", var_350_15)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_319601", "319601084", "story_v_out_319601.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_319601", "319601084", "story_v_out_319601.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_16 = math.max(var_350_9, arg_347_1.talkMaxDuration)

			if var_350_8 <= arg_347_1.time_ and arg_347_1.time_ < var_350_8 + var_350_16 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_8) / var_350_16

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_8 + var_350_16 and arg_347_1.time_ < var_350_8 + var_350_16 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end

		arg_347_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4040ui_story",
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

		arg_347_1:InitPlayNodeList()
	end,
	Play319601085 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 319601085
		arg_351_1.duration_ = 8.27

		local var_351_0 = {
			zh = 2.133,
			ja = 8.266
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
				arg_351_0:Play319601086(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1.var_.moveOldPos10079ui_story = arg_351_1.actors_["10079ui_story"].transform.localPosition
			end

			local var_354_0 = 0.001

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_0 then
				arg_351_1.actors_["10079ui_story"].transform.localPosition = Vector3.Lerp(arg_351_1.var_.moveOldPos10079ui_story, Vector3.New(0.7, -0.95, -6.05), (arg_351_1.time_ - 0) / var_354_0)
				arg_351_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["10079ui_story"].transform.position).z)
				arg_351_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["10079ui_story"].transform.localEulerAngles = arg_351_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			if arg_351_1.time_ >= 0 + var_354_0 and arg_351_1.time_ < 0 + var_354_0 + arg_354_0 then
				arg_351_1.actors_["10079ui_story"].transform.localPosition = Vector3.New(0.7, -0.95, -6.05)
				arg_351_1.actors_["10079ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_351_1.actors_["10079ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["10079ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_351_1.actors_["10079ui_story"].transform.position).z)
				arg_351_1.actors_["10079ui_story"].transform.localEulerAngles.z = 0
				arg_351_1.actors_["10079ui_story"].transform.localEulerAngles.x = 0
				arg_351_1.actors_["10079ui_story"].transform.localEulerAngles = arg_351_1.actors_["10079ui_story"].transform.localEulerAngles
			end

			local var_354_1 = arg_351_1.actors_["10079ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect10079ui_story == nil then
				arg_351_1.var_.characterEffect10079ui_story = var_354_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_2 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_2 and not isNil(var_354_1) then
				if arg_351_1.var_.characterEffect10079ui_story and not isNil(var_354_1) then
					arg_351_1.var_.characterEffect10079ui_story.fillFlat = false
				end
			end

			if arg_351_1.time_ >= 0 + var_354_2 and arg_351_1.time_ < 0 + var_354_2 + arg_354_0 and not isNil(var_354_1) and arg_351_1.var_.characterEffect10079ui_story then
				arg_351_1.var_.characterEffect10079ui_story.fillFlat = false
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 then
				arg_351_1:PlayTimeline("10079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_354_4 = arg_351_1.actors_["4040ui_story"]

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= 0 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.characterEffect4040ui_story == nil then
				arg_351_1.var_.characterEffect4040ui_story = var_354_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_354_5 = 0.200000002980232

			if 0 <= arg_351_1.time_ and arg_351_1.time_ < 0 + var_354_5 and not isNil(var_354_4) then
				if arg_351_1.var_.characterEffect4040ui_story and not isNil(var_354_4) then
					arg_351_1.var_.characterEffect4040ui_story.fillFlat = true
					arg_351_1.var_.characterEffect4040ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_351_1.time_ - 0) / var_354_5)
				end
			end

			if arg_351_1.time_ >= 0 + var_354_5 and arg_351_1.time_ < 0 + var_354_5 + arg_354_0 and not isNil(var_354_4) and arg_351_1.var_.characterEffect4040ui_story then
				arg_351_1.var_.characterEffect4040ui_story.fillFlat = true
				arg_351_1.var_.characterEffect4040ui_story.fillRatio = 0.5
			end

			local var_354_6 = 0
			local var_354_7 = 0.2

			if 0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_6 + arg_354_0 then
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

				local var_354_8 = arg_351_1:GetWordFromCfg(319601085)
				local var_354_9 = arg_351_1:FormatText(var_354_8.content)

				arg_351_1.text_.text = var_354_9

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_11 = 8 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_9) / 8)

				if (8 <= 0 and var_354_7 or var_354_7 * (utf8.len(var_354_9) / 8)) > 0 and var_354_7 < var_354_11 then
					arg_351_1.talkMaxDuration = var_354_11

					if var_354_11 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_11 + var_354_6
					end
				end

				arg_351_1.text_.text = var_354_9
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_319601", "319601085", "story_v_out_319601.awb") ~= 0 then
					local var_354_12 = manager.audio:GetVoiceLength("story_v_out_319601", "319601085", "story_v_out_319601.awb") / 1000

					if var_354_12 + var_354_6 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_12 + var_354_6
					end

					if var_354_8.prefab_name ~= "" and arg_351_1.actors_[var_354_8.prefab_name] ~= nil then
						local var_354_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_8.prefab_name].transform, "story_v_out_319601", "319601085", "story_v_out_319601.awb")

						arg_351_1:RecordAudio("319601085", var_354_13)
						arg_351_1:RecordAudio("319601085", var_354_13)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_319601", "319601085", "story_v_out_319601.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_319601", "319601085", "story_v_out_319601.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_14 = math.max(var_354_7, arg_351_1.talkMaxDuration)

			if var_354_6 <= arg_351_1.time_ and arg_351_1.time_ < var_354_6 + var_354_14 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_6) / var_354_14

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_6 + var_354_14 and arg_351_1.time_ < var_354_6 + var_354_14 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end

		arg_351_1.nodeConfigList_ = {
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

		arg_351_1:InitPlayNodeList()
	end,
	Play319601086 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 319601086
		arg_355_1.duration_ = 5

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play319601087(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			if 0 < arg_355_1.time_ and arg_355_1.time_ <= 0 + arg_358_0 and not isNil(arg_355_1.actors_["10079ui_story"]) and arg_355_1.var_.characterEffect10079ui_story == nil then
				arg_355_1.var_.characterEffect10079ui_story = arg_355_1.actors_["10079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_0 = 0.200000002980232

			if 0 <= arg_355_1.time_ and arg_355_1.time_ < 0 + var_358_0 and not isNil(arg_355_1.actors_["10079ui_story"]) then
				if arg_355_1.var_.characterEffect10079ui_story and not isNil(arg_355_1.actors_["10079ui_story"]) then
					arg_355_1.var_.characterEffect10079ui_story.fillFlat = true
					arg_355_1.var_.characterEffect10079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_355_1.time_ - 0) / var_358_0)
				end
			end

			if arg_355_1.time_ >= 0 + var_358_0 and arg_355_1.time_ < 0 + var_358_0 + arg_358_0 and not isNil(arg_355_1.actors_["10079ui_story"]) and arg_355_1.var_.characterEffect10079ui_story then
				arg_355_1.var_.characterEffect10079ui_story.fillFlat = true
				arg_355_1.var_.characterEffect10079ui_story.fillRatio = 0.5
			end

			local var_358_1 = 0
			local var_358_2 = 0.675

			if 0 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, false)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_355_1.iconTrs_.gameObject, false)
				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_3 = arg_355_1:FormatText(arg_355_1:GetWordFromCfg(319601086).content)

				arg_355_1.text_.text = var_358_3

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_5 = 27 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 27)

				if (27 <= 0 and var_358_2 or var_358_2 * (utf8.len(var_358_3) / 27)) > 0 and var_358_2 < var_358_5 then
					arg_355_1.talkMaxDuration = var_358_5

					if var_358_5 + var_358_1 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_5 + var_358_1
					end
				end

				arg_355_1.text_.text = var_358_3
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)
				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_6 = math.max(var_358_2, arg_355_1.talkMaxDuration)

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_6 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_1) / var_358_6

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_1 + var_358_6 and arg_355_1.time_ < var_358_1 + var_358_6 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end

		arg_355_1.nodeConfigList_ = {}

		arg_355_1:InitPlayNodeList()
	end,
	Play319601087 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 319601087
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
			arg_359_1.auto_ = false
		end

		function arg_359_1.playNext_(arg_361_0)
			arg_359_1.onStoryFinished_()
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = 0.75

			if 0 < arg_359_1.time_ and arg_359_1.time_ <= 0 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_1 = arg_359_1:FormatText(arg_359_1:GetWordFromCfg(319601087).content)

				arg_359_1.text_.text = var_362_1

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_3 = 30 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 30)

				if (30 <= 0 and var_362_0 or var_362_0 * (utf8.len(var_362_1) / 30)) > 0 and var_362_0 < var_362_3 then
					arg_359_1.talkMaxDuration = var_362_3

					if var_362_3 + 0 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_3 + 0
					end
				end

				arg_359_1.text_.text = var_362_1
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_4 = math.max(var_362_0, arg_359_1.talkMaxDuration)

			if 0 <= arg_359_1.time_ and arg_359_1.time_ < 0 + var_362_4 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - 0) / var_362_4

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= 0 + var_362_4 and arg_359_1.time_ < 0 + var_362_4 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end

		arg_359_1.nodeConfigList_ = {}

		arg_359_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A08f",
		"TextureConfig/Background/I10f",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/XH0407a"
	},
	voices = {
		"story_v_out_319601.awb"
	}
}
