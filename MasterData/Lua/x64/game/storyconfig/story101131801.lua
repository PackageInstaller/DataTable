return {
	Play113181001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113181001
		arg_1_1.duration_ = 8.67

		local var_1_0 = {
			ja = 8.566,
			ko = 8.666,
			zh = 7.8,
			en = 8.3
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
				arg_1_0:Play113181002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F04 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F04")
				var_4_0.name = "F04"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F04 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F04

				arg_1_1.bgs_.F04.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F04" then
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
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
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
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_1_3_story_outdoor", "bgm_activity_1_3_story_outdoor")

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
			local var_4_24 = 0.575

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

				local var_4_26 = arg_1_1:GetWordFromCfg(113181001)
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

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181001", "story_v_out_113181.awb") ~= 0 then
					local var_4_30 = manager.audio:GetVoiceLength("story_v_out_113181", "113181001", "story_v_out_113181.awb") / 1000

					if var_4_30 + var_4_23 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_30 + var_4_23
					end

					if var_4_26.prefab_name ~= "" and arg_1_1.actors_[var_4_26.prefab_name] ~= nil then
						local var_4_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_26.prefab_name].transform, "story_v_out_113181", "113181001", "story_v_out_113181.awb")

						arg_1_1:RecordAudio("113181001", var_4_31)
						arg_1_1:RecordAudio("113181001", var_4_31)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_113181", "113181001", "story_v_out_113181.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_113181", "113181001", "story_v_out_113181.awb")
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play113181002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113181002
		arg_9_1.duration_ = 13.3

		local var_9_0 = {
			ja = 9.133,
			ko = 9.833,
			zh = 9.066,
			en = 13.3
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
				arg_9_0:Play113181003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1038ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1038ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1038ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1038ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1038ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_12_3 = arg_9_1.actors_["1038ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect1038ui_story == nil then
				arg_9_1.var_.characterEffect1038ui_story = var_12_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_4 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 and not isNil(var_12_3) then
				if arg_9_1.var_.characterEffect1038ui_story and not isNil(var_12_3) then
					arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 and not isNil(var_12_3) and arg_9_1.var_.characterEffect1038ui_story then
				arg_9_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_12_6 = arg_9_1.actors_["1038ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1038ui_story = var_12_6.localPosition
			end

			local var_12_7 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_7 then
				var_12_6.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_9_1.time_ - 0) / var_12_7)
				var_12_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_6.position).x, (manager.ui.mainCamera.transform.position - var_12_6.position).y, (manager.ui.mainCamera.transform.position - var_12_6.position).z)
				var_12_6.localEulerAngles.z = 0
				var_12_6.localEulerAngles.x = 0
				var_12_6.localEulerAngles = var_12_6.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_7 and arg_9_1.time_ < 0 + var_12_7 + arg_12_0 then
				var_12_6.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_12_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_6.position).x, (manager.ui.mainCamera.transform.position - var_12_6.position).y, (manager.ui.mainCamera.transform.position - var_12_6.position).z)
				var_12_6.localEulerAngles.z = 0
				var_12_6.localEulerAngles.x = 0
				var_12_6.localEulerAngles = var_12_6.localEulerAngles
			end

			local var_12_8 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_9 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_9 and not isNil(var_12_8) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_8) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_9_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_9_1.time_ - 0) / var_12_9)
				end
			end

			if arg_9_1.time_ >= 0 + var_12_9 and arg_9_1.time_ < 0 + var_12_9 + arg_12_0 and not isNil(var_12_8) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_9_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_12_10 = 0
			local var_12_11 = 1.075

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_10 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_12 = arg_9_1:GetWordFromCfg(113181002)
				local var_12_13 = arg_9_1:FormatText(var_12_12.content)

				arg_9_1.text_.text = var_12_13

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_15 = 43 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 43)

				if (43 <= 0 and var_12_11 or var_12_11 * (utf8.len(var_12_13) / 43)) > 0 and var_12_11 < var_12_15 then
					arg_9_1.talkMaxDuration = var_12_15

					if var_12_15 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_15 + var_12_10
					end
				end

				arg_9_1.text_.text = var_12_13
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181002", "story_v_out_113181.awb") ~= 0 then
					local var_12_16 = manager.audio:GetVoiceLength("story_v_out_113181", "113181002", "story_v_out_113181.awb") / 1000

					if var_12_16 + var_12_10 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_16 + var_12_10
					end

					if var_12_12.prefab_name ~= "" and arg_9_1.actors_[var_12_12.prefab_name] ~= nil then
						local var_12_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_12.prefab_name].transform, "story_v_out_113181", "113181002", "story_v_out_113181.awb")

						arg_9_1:RecordAudio("113181002", var_12_17)
						arg_9_1:RecordAudio("113181002", var_12_17)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113181", "113181002", "story_v_out_113181.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113181", "113181002", "story_v_out_113181.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_18 = math.max(var_12_11, arg_9_1.talkMaxDuration)

			if var_12_10 <= arg_9_1.time_ and arg_9_1.time_ < var_12_10 + var_12_18 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_10) / var_12_18

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_10 + var_12_18 and arg_9_1.time_ < var_12_10 + var_12_18 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
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
	Play113181003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113181003
		arg_13_1.duration_ = 9.87

		local var_13_0 = {
			ja = 9.866,
			ko = 7.2,
			zh = 8.033,
			en = 9.766
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
				arg_13_0:Play113181004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_16_0 = 0
			local var_16_1 = 0.875

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_0 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_2 = arg_13_1:GetWordFromCfg(113181003)
				local var_16_3 = arg_13_1:FormatText(var_16_2.content)

				arg_13_1.text_.text = var_16_3

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_5 = 35 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 35)

				if (35 <= 0 and var_16_1 or var_16_1 * (utf8.len(var_16_3) / 35)) > 0 and var_16_1 < var_16_5 then
					arg_13_1.talkMaxDuration = var_16_5

					if var_16_5 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_5 + var_16_0
					end
				end

				arg_13_1.text_.text = var_16_3
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181003", "story_v_out_113181.awb") ~= 0 then
					local var_16_6 = manager.audio:GetVoiceLength("story_v_out_113181", "113181003", "story_v_out_113181.awb") / 1000

					if var_16_6 + var_16_0 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_6 + var_16_0
					end

					if var_16_2.prefab_name ~= "" and arg_13_1.actors_[var_16_2.prefab_name] ~= nil then
						local var_16_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_2.prefab_name].transform, "story_v_out_113181", "113181003", "story_v_out_113181.awb")

						arg_13_1:RecordAudio("113181003", var_16_7)
						arg_13_1:RecordAudio("113181003", var_16_7)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113181", "113181003", "story_v_out_113181.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113181", "113181003", "story_v_out_113181.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_8 = math.max(var_16_1, arg_13_1.talkMaxDuration)

			if var_16_0 <= arg_13_1.time_ and arg_13_1.time_ < var_16_0 + var_16_8 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_0) / var_16_8

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_0 + var_16_8 and arg_13_1.time_ < var_16_0 + var_16_8 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {}

		arg_13_1:InitPlayNodeList()
	end,
	Play113181004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113181004
		arg_17_1.duration_ = 8.07

		local var_17_0 = {
			ja = 4.5,
			ko = 5.8,
			zh = 7.066,
			en = 8.066
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
				arg_17_0:Play113181005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1038ui_story = arg_17_1.actors_["1038ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1038ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1038ui_story"].transform.position).z)
				arg_17_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1038ui_story"].transform.localEulerAngles = arg_17_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1038ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1038ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1038ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1038ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1038ui_story"].transform.position).z)
				arg_17_1.actors_["1038ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1038ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1038ui_story"].transform.localEulerAngles = arg_17_1.actors_["1038ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1084ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = var_20_1.localPosition
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 then
				var_20_1.localPosition = Vector3.New(0, 100, 0)
				var_20_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_1.position).x, (manager.ui.mainCamera.transform.position - var_20_1.position).y, (manager.ui.mainCamera.transform.position - var_20_1.position).z)
				var_20_1.localEulerAngles.z = 0
				var_20_1.localEulerAngles.x = 0
				var_20_1.localEulerAngles = var_20_1.localEulerAngles
			end

			local var_20_3 = "1097ui_story"

			if arg_17_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_20_4 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_17_1.stage_.transform)

				var_20_4.name = var_20_3
				var_20_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_[var_20_3] = var_20_4

				local var_20_5 = var_20_4:GetComponentInChildren(typeof(CharacterEffect))

				var_20_5.enabled = true

				local var_20_6 = GameObjectTools.GetOrAddComponent(var_20_4, typeof(DynamicBoneHelper))

				if var_20_6 then
					var_20_6:EnableDynamicBone(false)
				end

				arg_17_1:ShowWeapon(var_20_5.transform, false)

				arg_17_1.var_[var_20_3 .. "Animator"] = var_20_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_17_1.var_[var_20_3 .. "Animator"].applyRootMotion = true
				arg_17_1.var_[var_20_3 .. "LipSync"] = var_20_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_20_7 = arg_17_1.actors_["1097ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_7.localPosition
			end

			local var_20_8 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 then
				var_20_7.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_17_1.time_ - 0) / var_20_8)
				var_20_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_7.position).x, (manager.ui.mainCamera.transform.position - var_20_7.position).y, (manager.ui.mainCamera.transform.position - var_20_7.position).z)
				var_20_7.localEulerAngles.z = 0
				var_20_7.localEulerAngles.x = 0
				var_20_7.localEulerAngles = var_20_7.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 then
				var_20_7.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				var_20_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_7.position).x, (manager.ui.mainCamera.transform.position - var_20_7.position).y, (manager.ui.mainCamera.transform.position - var_20_7.position).z)
				var_20_7.localEulerAngles.z = 0
				var_20_7.localEulerAngles.x = 0
				var_20_7.localEulerAngles = var_20_7.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_20_9 = arg_17_1.actors_["1097ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1097ui_story == nil then
				arg_17_1.var_.characterEffect1097ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_10 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 and not isNil(var_20_9) then
				if arg_17_1.var_.characterEffect1097ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1097ui_story then
				arg_17_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_20_12 = 0
			local var_20_13 = 0.35

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(113181004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 14 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 14)

				if (14 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 14)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181004", "story_v_out_113181.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_113181", "113181004", "story_v_out_113181.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_113181", "113181004", "story_v_out_113181.awb")

						arg_17_1:RecordAudio("113181004", var_20_19)
						arg_17_1:RecordAudio("113181004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113181", "113181004", "story_v_out_113181.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113181", "113181004", "story_v_out_113181.awb")
				end

				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_20 = math.max(var_20_13, arg_17_1.talkMaxDuration)

			if var_20_12 <= arg_17_1.time_ and arg_17_1.time_ < var_20_12 + var_20_20 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_12) / var_20_20

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_12 + var_20_20 and arg_17_1.time_ < var_20_12 + var_20_20 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
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
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play113181005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113181005
		arg_21_1.duration_ = 3.4

		local var_21_0 = {
			ja = 3.4,
			ko = 1.999999999999,
			zh = 2.933,
			en = 2.033
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
				arg_21_0:Play113181006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["6046_story"] == nil and not isNil((Asset.Load("Char/" .. "6046_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "6046_story"), arg_21_1.stage_.transform)

				var_24_0.name = "6046_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["6046_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["6046_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["6046_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["6046_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_24_3 = arg_21_1.actors_["6046_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect6046_story == nil then
				arg_21_1.var_.characterEffect6046_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect6046_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect6046_story then
				arg_21_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_24_6 = arg_21_1.actors_["6046_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos6046_story = var_24_6.localPosition

				local var_24_7 = GameObjectTools.GetOrAddComponent(var_24_6.gameObject, typeof(DynamicBoneHelper))

				if var_24_7 then
					var_24_7:EnableDynamicBone(false)
				end
			end

			local var_24_8 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_8 then
				var_24_6.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos6046_story, Vector3.New(0.7, -0.5, -6.3), (arg_21_1.time_ - 0) / var_24_8)
				var_24_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_6.position).x, (manager.ui.mainCamera.transform.position - var_24_6.position).y, (manager.ui.mainCamera.transform.position - var_24_6.position).z)
				var_24_6.localEulerAngles.z = 0
				var_24_6.localEulerAngles.x = 0
				var_24_6.localEulerAngles = var_24_6.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_8 and arg_21_1.time_ < 0 + var_24_8 + arg_24_0 then
				var_24_6.localPosition = Vector3.New(0.7, -0.5, -6.3)
				var_24_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_6.position).x, (manager.ui.mainCamera.transform.position - var_24_6.position).y, (manager.ui.mainCamera.transform.position - var_24_6.position).z)
				var_24_6.localEulerAngles.z = 0
				var_24_6.localEulerAngles.x = 0
				var_24_6.localEulerAngles = var_24_6.localEulerAngles

				local var_24_9 = GameObjectTools.GetOrAddComponent(var_24_6.gameObject, typeof(DynamicBoneHelper))

				if var_24_9 then
					var_24_9:EnableDynamicBone(true)
				end
			end

			local var_24_10 = arg_21_1.actors_["1097ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect1097ui_story == nil then
				arg_21_1.var_.characterEffect1097ui_story = var_24_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_11 = 0.2

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_11 and not isNil(var_24_10) then
				if arg_21_1.var_.characterEffect1097ui_story and not isNil(var_24_10) then
					arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_11)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_11 and arg_21_1.time_ < 0 + var_24_11 + arg_24_0 and not isNil(var_24_10) and arg_21_1.var_.characterEffect1097ui_story then
				arg_21_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_2")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_24_12 = 0
			local var_24_13 = 0.2

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_12 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_14 = arg_21_1:GetWordFromCfg(113181005)
				local var_24_15 = arg_21_1:FormatText(var_24_14.content)

				arg_21_1.text_.text = var_24_15

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_17 = 8 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 8)

				if (8 <= 0 and var_24_13 or var_24_13 * (utf8.len(var_24_15) / 8)) > 0 and var_24_13 < var_24_17 then
					arg_21_1.talkMaxDuration = var_24_17

					if var_24_17 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_17 + var_24_12
					end
				end

				arg_21_1.text_.text = var_24_15
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181005", "story_v_out_113181.awb") ~= 0 then
					local var_24_18 = manager.audio:GetVoiceLength("story_v_out_113181", "113181005", "story_v_out_113181.awb") / 1000

					if var_24_18 + var_24_12 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_18 + var_24_12
					end

					if var_24_14.prefab_name ~= "" and arg_21_1.actors_[var_24_14.prefab_name] ~= nil then
						local var_24_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_14.prefab_name].transform, "story_v_out_113181", "113181005", "story_v_out_113181.awb")

						arg_21_1:RecordAudio("113181005", var_24_19)
						arg_21_1:RecordAudio("113181005", var_24_19)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_113181", "113181005", "story_v_out_113181.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_113181", "113181005", "story_v_out_113181.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_20 = math.max(var_24_13, arg_21_1.talkMaxDuration)

			if var_24_12 <= arg_21_1.time_ and arg_21_1.time_ < var_24_12 + var_24_20 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_12) / var_24_20

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_12 + var_24_20 and arg_21_1.time_ < var_24_12 + var_24_20 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play113181006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113181006
		arg_25_1.duration_ = 8.3

		local var_25_0 = {
			ja = 6.966,
			ko = 8.3,
			zh = 6.233,
			en = 4.5
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
				arg_25_0:Play113181007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(arg_25_1.actors_["6046_story"]) and arg_25_1.var_.characterEffect6046_story == nil then
				arg_25_1.var_.characterEffect6046_story = arg_25_1.actors_["6046_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_0 = 0.2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 and not isNil(arg_25_1.actors_["6046_story"]) then
				if arg_25_1.var_.characterEffect6046_story and not isNil(arg_25_1.actors_["6046_story"]) then
					arg_25_1.var_.characterEffect6046_story.fillFlat = true
					arg_25_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_0)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 and not isNil(arg_25_1.actors_["6046_story"]) and arg_25_1.var_.characterEffect6046_story then
				arg_25_1.var_.characterEffect6046_story.fillFlat = true
				arg_25_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			local var_28_1 = 0
			local var_28_2 = 0.55

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_1 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[215].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, true)
				arg_25_1.iconController_:SetSelectedState("hero")

				arg_25_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_6045")

				arg_25_1.callingController_:SetSelectedState("normal")

				arg_25_1.keyicon_.color = Color.New(1, 1, 1)
				arg_25_1.icon_.color = Color.New(1, 1, 1)

				local var_28_3 = arg_25_1:GetWordFromCfg(113181006)
				local var_28_4 = arg_25_1:FormatText(var_28_3.content)

				arg_25_1.text_.text = var_28_4

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_6 = 22 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 22)

				if (22 <= 0 and var_28_2 or var_28_2 * (utf8.len(var_28_4) / 22)) > 0 and var_28_2 < var_28_6 then
					arg_25_1.talkMaxDuration = var_28_6

					if var_28_6 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_6 + var_28_1
					end
				end

				arg_25_1.text_.text = var_28_4
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181006", "story_v_out_113181.awb") ~= 0 then
					local var_28_7 = manager.audio:GetVoiceLength("story_v_out_113181", "113181006", "story_v_out_113181.awb") / 1000

					if var_28_7 + var_28_1 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_7 + var_28_1
					end

					if var_28_3.prefab_name ~= "" and arg_25_1.actors_[var_28_3.prefab_name] ~= nil then
						local var_28_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_3.prefab_name].transform, "story_v_out_113181", "113181006", "story_v_out_113181.awb")

						arg_25_1:RecordAudio("113181006", var_28_8)
						arg_25_1:RecordAudio("113181006", var_28_8)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_113181", "113181006", "story_v_out_113181.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_113181", "113181006", "story_v_out_113181.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_9 = math.max(var_28_2, arg_25_1.talkMaxDuration)

			if var_28_1 <= arg_25_1.time_ and arg_25_1.time_ < var_28_1 + var_28_9 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_1) / var_28_9

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_1 + var_28_9 and arg_25_1.time_ < var_28_1 + var_28_9 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113181007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 113181007
		arg_29_1.duration_ = 7.33

		local var_29_0 = {
			ja = 4.9,
			ko = 7.333,
			zh = 7.266,
			en = 6.8
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
				arg_29_0:Play113181008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1097ui_story = arg_29_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).z)
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles = arg_29_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_29_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1097ui_story"].transform.position).z)
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1097ui_story"].transform.localEulerAngles = arg_29_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_1")
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_32_1 = arg_29_1.actors_["1097ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1097ui_story == nil then
				arg_29_1.var_.characterEffect1097ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.2

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1097ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1097ui_story then
				arg_29_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_32_4 = 0
			local var_32_5 = 0.5

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:GetWordFromCfg(113181007)
				local var_32_7 = arg_29_1:FormatText(var_32_6.content)

				arg_29_1.text_.text = var_32_7

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_9 = 20 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 20)

				if (20 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_7) / 20)) > 0 and var_32_5 < var_32_9 then
					arg_29_1.talkMaxDuration = var_32_9

					if var_32_9 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_9 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_7
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181007", "story_v_out_113181.awb") ~= 0 then
					local var_32_10 = manager.audio:GetVoiceLength("story_v_out_113181", "113181007", "story_v_out_113181.awb") / 1000

					if var_32_10 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_10 + var_32_4
					end

					if var_32_6.prefab_name ~= "" and arg_29_1.actors_[var_32_6.prefab_name] ~= nil then
						local var_32_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_6.prefab_name].transform, "story_v_out_113181", "113181007", "story_v_out_113181.awb")

						arg_29_1:RecordAudio("113181007", var_32_11)
						arg_29_1:RecordAudio("113181007", var_32_11)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_113181", "113181007", "story_v_out_113181.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_113181", "113181007", "story_v_out_113181.awb")
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

		arg_29_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_29_1:InitPlayNodeList()
	end,
	Play113181008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 113181008
		arg_33_1.duration_ = 2

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play113181009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_36_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_33_1.bgmTxt_.text ~= var_36_2 and arg_33_1.bgmTxt_.text ~= "" then
						if arg_33_1.bgmTxt2_.text ~= "" then
							arg_33_1.bgmTxt_.text = arg_33_1.bgmTxt2_.text
						end

						arg_33_1.bgmTxt2_.text = var_36_2

						arg_33_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_33_1.bgmTxt_.text = var_36_2
						arg_33_1.bgmTxt2_.text = var_36_2
					end

					if arg_33_1.bgmTimer then
						arg_33_1.bgmTimer:Stop()

						arg_33_1.bgmTimer = nil
					end

					if arg_33_1.settingData.show_music_name == 1 then
						arg_33_1.musicController:SetSelectedState("show")
						arg_33_1.musicAnimator_:Play("open", 0, 0)

						if arg_33_1.settingData.music_time ~= 0 then
							arg_33_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_33_1.settingData.music_time), function()
								if arg_33_1 == nil or isNil(arg_33_1.bgmTxt_) then
									return
								end

								arg_33_1.musicController:SetSelectedState("hide")
								arg_33_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_36_3 = 0
			local var_36_4 = 0.1

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_3 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_5 = arg_33_1:GetWordFromCfg(113181008)
				local var_36_6 = arg_33_1:FormatText(var_36_5.content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 4 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 4)

				if (4 <= 0 and var_36_4 or var_36_4 * (utf8.len(var_36_6) / 4)) > 0 and var_36_4 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_3
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181008", "story_v_out_113181.awb") ~= 0 then
					local var_36_9 = manager.audio:GetVoiceLength("story_v_out_113181", "113181008", "story_v_out_113181.awb") / 1000

					if var_36_9 + var_36_3 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_9 + var_36_3
					end

					if var_36_5.prefab_name ~= "" and arg_33_1.actors_[var_36_5.prefab_name] ~= nil then
						local var_36_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_5.prefab_name].transform, "story_v_out_113181", "113181008", "story_v_out_113181.awb")

						arg_33_1:RecordAudio("113181008", var_36_10)
						arg_33_1:RecordAudio("113181008", var_36_10)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_113181", "113181008", "story_v_out_113181.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_113181", "113181008", "story_v_out_113181.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_11 = math.max(var_36_4, arg_33_1.talkMaxDuration)

			if var_36_3 <= arg_33_1.time_ and arg_33_1.time_ < var_36_3 + var_36_11 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_3) / var_36_11

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_3 + var_36_11 and arg_33_1.time_ < var_36_3 + var_36_11 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play113181009 = function(arg_38_0, arg_38_1)
		arg_38_1.time_ = 0
		arg_38_1.frameCnt_ = 0
		arg_38_1.state_ = "playing"
		arg_38_1.curTalkId_ = 113181009
		arg_38_1.duration_ = 2

		SetActive(arg_38_1.tipsGo_, false)

		function arg_38_1.onSingleLineFinish_()
			arg_38_1.onSingleLineUpdate_ = nil
			arg_38_1.onSingleLineFinish_ = nil
			arg_38_1.state_ = "waiting"
		end

		function arg_38_1.playNext_(arg_40_0)
			if arg_40_0 == 1 then
				arg_38_0:Play113181010(arg_38_1)
			end
		end

		function arg_38_1.onSingleLineUpdate_(arg_41_0)
			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/story6046/story6046action/6046action4_1")
			end

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 then
				arg_38_1:PlayTimeline("6046_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_41_0 = arg_38_1.actors_["6046_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect6046_story == nil then
				arg_38_1.var_.characterEffect6046_story = var_41_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_1 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_1 and not isNil(var_41_0) then
				if arg_38_1.var_.characterEffect6046_story and not isNil(var_41_0) then
					arg_38_1.var_.characterEffect6046_story.fillFlat = false
				end
			end

			if arg_38_1.time_ >= 0 + var_41_1 and arg_38_1.time_ < 0 + var_41_1 + arg_41_0 and not isNil(var_41_0) and arg_38_1.var_.characterEffect6046_story then
				arg_38_1.var_.characterEffect6046_story.fillFlat = false
			end

			local var_41_3 = arg_38_1.actors_["1097ui_story"]

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= 0 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect1097ui_story == nil then
				arg_38_1.var_.characterEffect1097ui_story = var_41_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_41_4 = 0.2

			if 0 <= arg_38_1.time_ and arg_38_1.time_ < 0 + var_41_4 and not isNil(var_41_3) then
				if arg_38_1.var_.characterEffect1097ui_story and not isNil(var_41_3) then
					arg_38_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_38_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_38_1.time_ - 0) / var_41_4)
				end
			end

			if arg_38_1.time_ >= 0 + var_41_4 and arg_38_1.time_ < 0 + var_41_4 + arg_41_0 and not isNil(var_41_3) and arg_38_1.var_.characterEffect1097ui_story then
				arg_38_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_38_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_41_5 = 0
			local var_41_6 = 0.175

			if 0 < arg_38_1.time_ and arg_38_1.time_ <= var_41_5 + arg_41_0 then
				arg_38_1.talkMaxDuration = 0
				arg_38_1.dialogCg_.alpha = 1

				arg_38_1.dialog_:SetActive(true)
				SetActive(arg_38_1.leftNameGo_, true)

				arg_38_1.leftNameTxt_.text = arg_38_1:FormatText(StoryNameCfg[214].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_38_1.leftNameTxt_.transform)

				arg_38_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_38_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_38_1:RecordName(arg_38_1.leftNameTxt_.text)
				SetActive(arg_38_1.iconTrs_.gameObject, false)
				arg_38_1.callingController_:SetSelectedState("normal")

				local var_41_7 = arg_38_1:GetWordFromCfg(113181009)
				local var_41_8 = arg_38_1:FormatText(var_41_7.content)

				arg_38_1.text_.text = var_41_8

				LuaForUtil.ClearLinePrefixSymbol(arg_38_1.text_)

				local var_41_10 = 7 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_8) / 7)

				if (7 <= 0 and var_41_6 or var_41_6 * (utf8.len(var_41_8) / 7)) > 0 and var_41_6 < var_41_10 then
					arg_38_1.talkMaxDuration = var_41_10

					if var_41_10 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_10 + var_41_5
					end
				end

				arg_38_1.text_.text = var_41_8
				arg_38_1.typewritter.percent = 0

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181009", "story_v_out_113181.awb") ~= 0 then
					local var_41_11 = manager.audio:GetVoiceLength("story_v_out_113181", "113181009", "story_v_out_113181.awb") / 1000

					if var_41_11 + var_41_5 > arg_38_1.duration_ then
						arg_38_1.duration_ = var_41_11 + var_41_5
					end

					if var_41_7.prefab_name ~= "" and arg_38_1.actors_[var_41_7.prefab_name] ~= nil then
						local var_41_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_38_1.actors_[var_41_7.prefab_name].transform, "story_v_out_113181", "113181009", "story_v_out_113181.awb")

						arg_38_1:RecordAudio("113181009", var_41_12)
						arg_38_1:RecordAudio("113181009", var_41_12)
					else
						arg_38_1:AudioAction("play", "voice", "story_v_out_113181", "113181009", "story_v_out_113181.awb")
					end

					arg_38_1:RecordHistoryTalkVoice("story_v_out_113181", "113181009", "story_v_out_113181.awb")
				end

				arg_38_1:RecordContent(arg_38_1.text_.text)
			end

			local var_41_13 = math.max(var_41_6, arg_38_1.talkMaxDuration)

			if var_41_5 <= arg_38_1.time_ and arg_38_1.time_ < var_41_5 + var_41_13 then
				arg_38_1.typewritter.percent = (arg_38_1.time_ - var_41_5) / var_41_13

				arg_38_1.typewritter:SetDirty()
			end

			if arg_38_1.time_ >= var_41_5 + var_41_13 and arg_38_1.time_ < var_41_5 + var_41_13 + arg_41_0 then
				arg_38_1.typewritter.percent = 1

				arg_38_1.typewritter:SetDirty()
				arg_38_1:ShowNextGo(true)
			end
		end

		arg_38_1.nodeConfigList_ = {}

		arg_38_1:InitPlayNodeList()
	end,
	Play113181010 = function(arg_42_0, arg_42_1)
		arg_42_1.time_ = 0
		arg_42_1.frameCnt_ = 0
		arg_42_1.state_ = "playing"
		arg_42_1.curTalkId_ = 113181010
		arg_42_1.duration_ = 2.57

		local var_42_0 = {
			ja = 2.566,
			ko = 2.2,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_42_0:Play113181011(arg_42_1)
			end
		end

		function arg_42_1.onSingleLineUpdate_(arg_45_0)
			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_45_0 = arg_42_1.actors_["1097ui_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1097ui_story == nil then
				arg_42_1.var_.characterEffect1097ui_story = var_45_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_1 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_1 and not isNil(var_45_0) then
				if arg_42_1.var_.characterEffect1097ui_story and not isNil(var_45_0) then
					arg_42_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_42_1.time_ >= 0 + var_45_1 and arg_42_1.time_ < 0 + var_45_1 + arg_45_0 and not isNil(var_45_0) and arg_42_1.var_.characterEffect1097ui_story then
				arg_42_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_45_3 = arg_42_1.actors_["6046_story"]

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect6046_story == nil then
				arg_42_1.var_.characterEffect6046_story = var_45_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_45_4 = 0.2

			if 0 <= arg_42_1.time_ and arg_42_1.time_ < 0 + var_45_4 and not isNil(var_45_3) then
				if arg_42_1.var_.characterEffect6046_story and not isNil(var_45_3) then
					arg_42_1.var_.characterEffect6046_story.fillFlat = true
					arg_42_1.var_.characterEffect6046_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_42_1.time_ - 0) / var_45_4)
				end
			end

			if arg_42_1.time_ >= 0 + var_45_4 and arg_42_1.time_ < 0 + var_45_4 + arg_45_0 and not isNil(var_45_3) and arg_42_1.var_.characterEffect6046_story then
				arg_42_1.var_.characterEffect6046_story.fillFlat = true
				arg_42_1.var_.characterEffect6046_story.fillRatio = 0.5
			end

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= 0 + arg_45_0 then
				arg_42_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action7_2")
			end

			local var_45_5 = 0
			local var_45_6 = 0.125

			if 0 < arg_42_1.time_ and arg_42_1.time_ <= var_45_5 + arg_45_0 then
				arg_42_1.talkMaxDuration = 0
				arg_42_1.dialogCg_.alpha = 1

				arg_42_1.dialog_:SetActive(true)
				SetActive(arg_42_1.leftNameGo_, true)

				arg_42_1.leftNameTxt_.text = arg_42_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_42_1.leftNameTxt_.transform)

				arg_42_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_42_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_42_1:RecordName(arg_42_1.leftNameTxt_.text)
				SetActive(arg_42_1.iconTrs_.gameObject, false)
				arg_42_1.callingController_:SetSelectedState("normal")

				local var_45_7 = arg_42_1:GetWordFromCfg(113181010)
				local var_45_8 = arg_42_1:FormatText(var_45_7.content)

				arg_42_1.text_.text = var_45_8

				LuaForUtil.ClearLinePrefixSymbol(arg_42_1.text_)

				local var_45_10 = 5 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 5)

				if (5 <= 0 and var_45_6 or var_45_6 * (utf8.len(var_45_8) / 5)) > 0 and var_45_6 < var_45_10 then
					arg_42_1.talkMaxDuration = var_45_10

					if var_45_10 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_10 + var_45_5
					end
				end

				arg_42_1.text_.text = var_45_8
				arg_42_1.typewritter.percent = 0

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181010", "story_v_out_113181.awb") ~= 0 then
					local var_45_11 = manager.audio:GetVoiceLength("story_v_out_113181", "113181010", "story_v_out_113181.awb") / 1000

					if var_45_11 + var_45_5 > arg_42_1.duration_ then
						arg_42_1.duration_ = var_45_11 + var_45_5
					end

					if var_45_7.prefab_name ~= "" and arg_42_1.actors_[var_45_7.prefab_name] ~= nil then
						local var_45_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_42_1.actors_[var_45_7.prefab_name].transform, "story_v_out_113181", "113181010", "story_v_out_113181.awb")

						arg_42_1:RecordAudio("113181010", var_45_12)
						arg_42_1:RecordAudio("113181010", var_45_12)
					else
						arg_42_1:AudioAction("play", "voice", "story_v_out_113181", "113181010", "story_v_out_113181.awb")
					end

					arg_42_1:RecordHistoryTalkVoice("story_v_out_113181", "113181010", "story_v_out_113181.awb")
				end

				arg_42_1:RecordContent(arg_42_1.text_.text)
			end

			local var_45_13 = math.max(var_45_6, arg_42_1.talkMaxDuration)

			if var_45_5 <= arg_42_1.time_ and arg_42_1.time_ < var_45_5 + var_45_13 then
				arg_42_1.typewritter.percent = (arg_42_1.time_ - var_45_5) / var_45_13

				arg_42_1.typewritter:SetDirty()
			end

			if arg_42_1.time_ >= var_45_5 + var_45_13 and arg_42_1.time_ < var_45_5 + var_45_13 + arg_45_0 then
				arg_42_1.typewritter.percent = 1

				arg_42_1.typewritter:SetDirty()
				arg_42_1:ShowNextGo(true)
			end
		end

		arg_42_1.nodeConfigList_ = {}

		arg_42_1:InitPlayNodeList()
	end,
	Play113181011 = function(arg_46_0, arg_46_1)
		arg_46_1.time_ = 0
		arg_46_1.frameCnt_ = 0
		arg_46_1.state_ = "playing"
		arg_46_1.curTalkId_ = 113181011
		arg_46_1.duration_ = 2.13

		local var_46_0 = {
			ja = 1.999999999999,
			ko = 2.1,
			zh = 2.1,
			en = 2.133
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
				arg_46_0:Play113181012(arg_46_1)
			end
		end

		function arg_46_1.onSingleLineUpdate_(arg_49_0)
			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos6046_story = arg_46_1.actors_["6046_story"].transform.localPosition

				local var_49_0 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_0 then
					var_49_0:EnableDynamicBone(false)
				end
			end

			local var_49_1 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_1 then
				arg_46_1.actors_["6046_story"].transform.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos6046_story, Vector3.New(0, 100, 0), (arg_46_1.time_ - 0) / var_49_1)
				arg_46_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["6046_story"].transform.position).z)
				arg_46_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["6046_story"].transform.localEulerAngles = arg_46_1.actors_["6046_story"].transform.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_1 and arg_46_1.time_ < 0 + var_49_1 + arg_49_0 then
				arg_46_1.actors_["6046_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_46_1.actors_["6046_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_46_1.actors_["6046_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["6046_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_46_1.actors_["6046_story"].transform.position).z)
				arg_46_1.actors_["6046_story"].transform.localEulerAngles.z = 0
				arg_46_1.actors_["6046_story"].transform.localEulerAngles.x = 0
				arg_46_1.actors_["6046_story"].transform.localEulerAngles = arg_46_1.actors_["6046_story"].transform.localEulerAngles

				local var_49_2 = GameObjectTools.GetOrAddComponent(arg_46_1.actors_["6046_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_49_2 then
					var_49_2:EnableDynamicBone(true)
				end
			end

			local var_49_3 = arg_46_1.actors_["1038ui_story"].transform

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1.var_.moveOldPos1038ui_story = var_49_3.localPosition
			end

			local var_49_4 = 0.001

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_4 then
				var_49_3.localPosition = Vector3.Lerp(arg_46_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_46_1.time_ - 0) / var_49_4)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles
			end

			if arg_46_1.time_ >= 0 + var_49_4 and arg_46_1.time_ < 0 + var_49_4 + arg_49_0 then
				var_49_3.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_49_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_49_3.position).x, (manager.ui.mainCamera.transform.position - var_49_3.position).y, (manager.ui.mainCamera.transform.position - var_49_3.position).z)
				var_49_3.localEulerAngles.z = 0
				var_49_3.localEulerAngles.x = 0
				var_49_3.localEulerAngles = var_49_3.localEulerAngles
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 then
				arg_46_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_49_5 = arg_46_1.actors_["1038ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1038ui_story == nil then
				arg_46_1.var_.characterEffect1038ui_story = var_49_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_6 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_6 and not isNil(var_49_5) then
				if arg_46_1.var_.characterEffect1038ui_story and not isNil(var_49_5) then
					arg_46_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_46_1.time_ >= 0 + var_49_6 and arg_46_1.time_ < 0 + var_49_6 + arg_49_0 and not isNil(var_49_5) and arg_46_1.var_.characterEffect1038ui_story then
				arg_46_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_49_8 = arg_46_1.actors_["1097ui_story"]

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= 0 + arg_49_0 and not isNil(var_49_8) and arg_46_1.var_.characterEffect1097ui_story == nil then
				arg_46_1.var_.characterEffect1097ui_story = var_49_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_49_9 = 0.2

			if 0 <= arg_46_1.time_ and arg_46_1.time_ < 0 + var_49_9 and not isNil(var_49_8) then
				if arg_46_1.var_.characterEffect1097ui_story and not isNil(var_49_8) then
					arg_46_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_46_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_46_1.time_ - 0) / var_49_9)
				end
			end

			if arg_46_1.time_ >= 0 + var_49_9 and arg_46_1.time_ < 0 + var_49_9 + arg_49_0 and not isNil(var_49_8) and arg_46_1.var_.characterEffect1097ui_story then
				arg_46_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_46_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_49_10 = 0
			local var_49_11 = 0.275

			if 0 < arg_46_1.time_ and arg_46_1.time_ <= var_49_10 + arg_49_0 then
				arg_46_1.talkMaxDuration = 0
				arg_46_1.dialogCg_.alpha = 1

				arg_46_1.dialog_:SetActive(true)
				SetActive(arg_46_1.leftNameGo_, true)

				arg_46_1.leftNameTxt_.text = arg_46_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_46_1.leftNameTxt_.transform)

				arg_46_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_46_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_46_1:RecordName(arg_46_1.leftNameTxt_.text)
				SetActive(arg_46_1.iconTrs_.gameObject, false)
				arg_46_1.callingController_:SetSelectedState("normal")

				local var_49_12 = arg_46_1:GetWordFromCfg(113181011)
				local var_49_13 = arg_46_1:FormatText(var_49_12.content)

				arg_46_1.text_.text = var_49_13

				LuaForUtil.ClearLinePrefixSymbol(arg_46_1.text_)

				local var_49_15 = 11 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_13) / 11)

				if (11 <= 0 and var_49_11 or var_49_11 * (utf8.len(var_49_13) / 11)) > 0 and var_49_11 < var_49_15 then
					arg_46_1.talkMaxDuration = var_49_15

					if var_49_15 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_15 + var_49_10
					end
				end

				arg_46_1.text_.text = var_49_13
				arg_46_1.typewritter.percent = 0

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181011", "story_v_out_113181.awb") ~= 0 then
					local var_49_16 = manager.audio:GetVoiceLength("story_v_out_113181", "113181011", "story_v_out_113181.awb") / 1000

					if var_49_16 + var_49_10 > arg_46_1.duration_ then
						arg_46_1.duration_ = var_49_16 + var_49_10
					end

					if var_49_12.prefab_name ~= "" and arg_46_1.actors_[var_49_12.prefab_name] ~= nil then
						local var_49_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_46_1.actors_[var_49_12.prefab_name].transform, "story_v_out_113181", "113181011", "story_v_out_113181.awb")

						arg_46_1:RecordAudio("113181011", var_49_17)
						arg_46_1:RecordAudio("113181011", var_49_17)
					else
						arg_46_1:AudioAction("play", "voice", "story_v_out_113181", "113181011", "story_v_out_113181.awb")
					end

					arg_46_1:RecordHistoryTalkVoice("story_v_out_113181", "113181011", "story_v_out_113181.awb")
				end

				arg_46_1:RecordContent(arg_46_1.text_.text)
			end

			local var_49_18 = math.max(var_49_11, arg_46_1.talkMaxDuration)

			if var_49_10 <= arg_46_1.time_ and arg_46_1.time_ < var_49_10 + var_49_18 then
				arg_46_1.typewritter.percent = (arg_46_1.time_ - var_49_10) / var_49_18

				arg_46_1.typewritter:SetDirty()
			end

			if arg_46_1.time_ >= var_49_10 + var_49_18 and arg_46_1.time_ < var_49_10 + var_49_18 + arg_49_0 then
				arg_46_1.typewritter.percent = 1

				arg_46_1.typewritter:SetDirty()
				arg_46_1:ShowNextGo(true)
			end
		end

		arg_46_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6046_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_46_1:InitPlayNodeList()
	end,
	Play113181012 = function(arg_50_0, arg_50_1)
		arg_50_1.time_ = 0
		arg_50_1.frameCnt_ = 0
		arg_50_1.state_ = "playing"
		arg_50_1.curTalkId_ = 113181012
		arg_50_1.duration_ = 7.87

		local var_50_0 = {
			ja = 7.866,
			ko = 5.366,
			zh = 5.033,
			en = 6.433
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
				arg_50_0:Play113181013(arg_50_1)
			end
		end

		function arg_50_1.onSingleLineUpdate_(arg_53_0)
			local var_53_9000

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(arg_50_1.actors_["1097ui_story"]) and arg_50_1.var_.characterEffect1097ui_story == nil then
				arg_50_1.var_.characterEffect1097ui_story = arg_50_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_0 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_0 and not isNil(arg_50_1.actors_["1097ui_story"]) then
				if arg_50_1.var_.characterEffect1097ui_story and not isNil(arg_50_1.actors_["1097ui_story"]) then
					arg_50_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_50_1.time_ >= 0 + var_53_0 and arg_50_1.time_ < 0 + var_53_0 + arg_53_0 and not isNil(arg_50_1.actors_["1097ui_story"]) and arg_50_1.var_.characterEffect1097ui_story then
				arg_50_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action5_1")
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_53_2 = arg_50_1.actors_["1038ui_story"]

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1038ui_story == nil then
				arg_50_1.var_.characterEffect1038ui_story = var_53_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_53_3 = 0.2

			if 0 <= arg_50_1.time_ and arg_50_1.time_ < 0 + var_53_3 and not isNil(var_53_2) then
				if arg_50_1.var_.characterEffect1038ui_story and not isNil(var_53_2) then
					arg_50_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_50_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_50_1.time_ - 0) / var_53_3)
				end
			end

			if arg_50_1.time_ >= 0 + var_53_3 and arg_50_1.time_ < 0 + var_53_3 + arg_53_0 and not isNil(var_53_2) and arg_50_1.var_.characterEffect1038ui_story then
				arg_50_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_50_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				local var_53_4 = arg_50_1.var_.effect1097ui_storyyanwu1

				if not arg_50_1.var_.effect1097ui_storyyanwu1 then
					var_53_4 = Object.Instantiate(Asset.Load("Effect/Hero/1097/fx_1097_story_smoke"), arg_50_1.actors_["1097ui_story"].transform)
					var_53_4.name = "yanwu1"
					arg_50_1.var_.effect1097ui_storyyanwu1 = var_53_4
				else
					var_53_4.transform:SetParent(var_53_9000)
				end

				var_53_4.transform.localPosition = Vector3.New(0, 1.28, 0.3)
				var_53_4.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2 < arg_50_1.time_ and arg_50_1.time_ <= 2 + arg_53_0 then
				if arg_50_1.var_.effect1097ui_storyyanwu1 then
					Object.Destroy(arg_50_1.var_.effect1097ui_storyyanwu1)

					arg_50_1.var_.effect1097ui_storyyanwu1 = nil
				end
			end

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= 0 + arg_53_0 then
				arg_50_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_53_9 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if "" ~= "" then
					if arg_50_1.bgmTxt_.text ~= var_53_9 and arg_50_1.bgmTxt_.text ~= "" then
						if arg_50_1.bgmTxt2_.text ~= "" then
							arg_50_1.bgmTxt_.text = arg_50_1.bgmTxt2_.text
						end

						arg_50_1.bgmTxt2_.text = var_53_9

						arg_50_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_50_1.bgmTxt_.text = var_53_9
						arg_50_1.bgmTxt2_.text = var_53_9
					end

					if arg_50_1.bgmTimer then
						arg_50_1.bgmTimer:Stop()

						arg_50_1.bgmTimer = nil
					end

					if arg_50_1.settingData.show_music_name == 1 then
						arg_50_1.musicController:SetSelectedState("show")
						arg_50_1.musicAnimator_:Play("open", 0, 0)

						if arg_50_1.settingData.music_time ~= 0 then
							arg_50_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_50_1.settingData.music_time), function()
								if arg_50_1 == nil or isNil(arg_50_1.bgmTxt_) then
									return
								end

								arg_50_1.musicController:SetSelectedState("hide")
								arg_50_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_53_10 = 0
			local var_53_11 = 0.4

			if 0 < arg_50_1.time_ and arg_50_1.time_ <= var_53_10 + arg_53_0 then
				arg_50_1.talkMaxDuration = 0
				arg_50_1.dialogCg_.alpha = 1

				arg_50_1.dialog_:SetActive(true)
				SetActive(arg_50_1.leftNameGo_, true)

				arg_50_1.leftNameTxt_.text = arg_50_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_50_1.leftNameTxt_.transform)

				arg_50_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_50_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_50_1:RecordName(arg_50_1.leftNameTxt_.text)
				SetActive(arg_50_1.iconTrs_.gameObject, false)
				arg_50_1.callingController_:SetSelectedState("normal")

				local var_53_12 = arg_50_1:GetWordFromCfg(113181012)
				local var_53_13 = arg_50_1:FormatText(var_53_12.content)

				arg_50_1.text_.text = var_53_13

				LuaForUtil.ClearLinePrefixSymbol(arg_50_1.text_)

				local var_53_15 = 16 <= 0 and var_53_11 or var_53_11 * (utf8.len(var_53_13) / 16)

				if (16 <= 0 and var_53_11 or var_53_11 * (utf8.len(var_53_13) / 16)) > 0 and var_53_11 < var_53_15 then
					arg_50_1.talkMaxDuration = var_53_15

					if var_53_15 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_15 + var_53_10
					end
				end

				arg_50_1.text_.text = var_53_13
				arg_50_1.typewritter.percent = 0

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181012", "story_v_out_113181.awb") ~= 0 then
					local var_53_16 = manager.audio:GetVoiceLength("story_v_out_113181", "113181012", "story_v_out_113181.awb") / 1000

					if var_53_16 + var_53_10 > arg_50_1.duration_ then
						arg_50_1.duration_ = var_53_16 + var_53_10
					end

					if var_53_12.prefab_name ~= "" and arg_50_1.actors_[var_53_12.prefab_name] ~= nil then
						local var_53_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_50_1.actors_[var_53_12.prefab_name].transform, "story_v_out_113181", "113181012", "story_v_out_113181.awb")

						arg_50_1:RecordAudio("113181012", var_53_17)
						arg_50_1:RecordAudio("113181012", var_53_17)
					else
						arg_50_1:AudioAction("play", "voice", "story_v_out_113181", "113181012", "story_v_out_113181.awb")
					end

					arg_50_1:RecordHistoryTalkVoice("story_v_out_113181", "113181012", "story_v_out_113181.awb")
				end

				arg_50_1:RecordContent(arg_50_1.text_.text)
			end

			local var_53_18 = math.max(var_53_11, arg_50_1.talkMaxDuration)

			if var_53_10 <= arg_50_1.time_ and arg_50_1.time_ < var_53_10 + var_53_18 then
				arg_50_1.typewritter.percent = (arg_50_1.time_ - var_53_10) / var_53_18

				arg_50_1.typewritter:SetDirty()
			end

			if arg_50_1.time_ >= var_53_10 + var_53_18 and arg_50_1.time_ < var_53_10 + var_53_18 + arg_53_0 then
				arg_50_1.typewritter.percent = 1

				arg_50_1.typewritter:SetDirty()
				arg_50_1:ShowNextGo(true)
			end
		end

		arg_50_1.nodeConfigList_ = {}

		arg_50_1:InitPlayNodeList()
	end,
	Play113181013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113181013
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play113181014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(arg_55_1.actors_["1097ui_story"]) and arg_55_1.var_.characterEffect1097ui_story == nil then
				arg_55_1.var_.characterEffect1097ui_story = arg_55_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_0 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_0 and not isNil(arg_55_1.actors_["1097ui_story"]) then
				if arg_55_1.var_.characterEffect1097ui_story and not isNil(arg_55_1.actors_["1097ui_story"]) then
					arg_55_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_0)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_0 and arg_55_1.time_ < 0 + var_58_0 + arg_58_0 and not isNil(arg_55_1.actors_["1097ui_story"]) and arg_55_1.var_.characterEffect1097ui_story then
				arg_55_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_58_1 = 0
			local var_58_2 = 0.6

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_3 = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(113181013).content)

				arg_55_1.text_.text = var_58_3

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_5 = 24 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 24)

				if (24 <= 0 and var_58_2 or var_58_2 * (utf8.len(var_58_3) / 24)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_1 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_1
					end
				end

				arg_55_1.text_.text = var_58_3
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_6 = math.max(var_58_2, arg_55_1.talkMaxDuration)

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_6 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_1) / var_58_6

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_1 + var_58_6 and arg_55_1.time_ < var_58_1 + var_58_6 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play113181014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113181014
		arg_59_1.duration_ = 7.47

		local var_59_0 = {
			ja = 7.466,
			ko = 5.4,
			zh = 4.533,
			en = 6.633
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
				arg_59_0:Play113181015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_62_0 = arg_59_1.actors_["1038ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1038ui_story == nil then
				arg_59_1.var_.characterEffect1038ui_story = var_62_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_1 = 0.2

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_1 and not isNil(var_62_0) then
				if arg_59_1.var_.characterEffect1038ui_story and not isNil(var_62_0) then
					arg_59_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_1 and arg_59_1.time_ < 0 + var_62_1 + arg_62_0 and not isNil(var_62_0) and arg_59_1.var_.characterEffect1038ui_story then
				arg_59_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_62_3 = 0
			local var_62_4 = 0.65

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_5 = arg_59_1:GetWordFromCfg(113181014)
				local var_62_6 = arg_59_1:FormatText(var_62_5.content)

				arg_59_1.text_.text = var_62_6

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_8 = 26 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_6) / 26)

				if (26 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_6) / 26)) > 0 and var_62_4 < var_62_8 then
					arg_59_1.talkMaxDuration = var_62_8

					if var_62_8 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_8 + var_62_3
					end
				end

				arg_59_1.text_.text = var_62_6
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181014", "story_v_out_113181.awb") ~= 0 then
					local var_62_9 = manager.audio:GetVoiceLength("story_v_out_113181", "113181014", "story_v_out_113181.awb") / 1000

					if var_62_9 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_9 + var_62_3
					end

					if var_62_5.prefab_name ~= "" and arg_59_1.actors_[var_62_5.prefab_name] ~= nil then
						local var_62_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_5.prefab_name].transform, "story_v_out_113181", "113181014", "story_v_out_113181.awb")

						arg_59_1:RecordAudio("113181014", var_62_10)
						arg_59_1:RecordAudio("113181014", var_62_10)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_113181", "113181014", "story_v_out_113181.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_113181", "113181014", "story_v_out_113181.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_11 = math.max(var_62_4, arg_59_1.talkMaxDuration)

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_11 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_3) / var_62_11

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_3 + var_62_11 and arg_59_1.time_ < var_62_3 + var_62_11 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play113181015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113181015
		arg_63_1.duration_ = 14.2

		local var_63_0 = {
			ja = 14.2,
			ko = 10.433,
			zh = 8.666,
			en = 11
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
				arg_63_0:Play113181016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(arg_63_1.actors_["1038ui_story"]) and arg_63_1.var_.characterEffect1038ui_story == nil then
				arg_63_1.var_.characterEffect1038ui_story = arg_63_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_0 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 and not isNil(arg_63_1.actors_["1038ui_story"]) then
				if arg_63_1.var_.characterEffect1038ui_story and not isNil(arg_63_1.actors_["1038ui_story"]) then
					arg_63_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_0)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 and not isNil(arg_63_1.actors_["1038ui_story"]) and arg_63_1.var_.characterEffect1038ui_story then
				arg_63_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_66_1 = arg_63_1.actors_["1097ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1097ui_story == nil then
				arg_63_1.var_.characterEffect1097ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.2

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect1097ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect1097ui_story then
				arg_63_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_66_4 = 0
			local var_66_5 = 0.925

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_4 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_6 = arg_63_1:GetWordFromCfg(113181015)
				local var_66_7 = arg_63_1:FormatText(var_66_6.content)

				arg_63_1.text_.text = var_66_7

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_9 = 37 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 37)

				if (37 <= 0 and var_66_5 or var_66_5 * (utf8.len(var_66_7) / 37)) > 0 and var_66_5 < var_66_9 then
					arg_63_1.talkMaxDuration = var_66_9

					if var_66_9 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_9 + var_66_4
					end
				end

				arg_63_1.text_.text = var_66_7
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181015", "story_v_out_113181.awb") ~= 0 then
					local var_66_10 = manager.audio:GetVoiceLength("story_v_out_113181", "113181015", "story_v_out_113181.awb") / 1000

					if var_66_10 + var_66_4 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_10 + var_66_4
					end

					if var_66_6.prefab_name ~= "" and arg_63_1.actors_[var_66_6.prefab_name] ~= nil then
						local var_66_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_6.prefab_name].transform, "story_v_out_113181", "113181015", "story_v_out_113181.awb")

						arg_63_1:RecordAudio("113181015", var_66_11)
						arg_63_1:RecordAudio("113181015", var_66_11)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_113181", "113181015", "story_v_out_113181.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_113181", "113181015", "story_v_out_113181.awb")
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
	Play113181016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113181016
		arg_67_1.duration_ = 3.57

		local var_67_0 = {
			ja = 3.566,
			ko = 2.4,
			zh = 2.066,
			en = 3.366
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
				arg_67_0:Play113181017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1097ui_story = arg_67_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1097ui_story"].transform.position).z)
				arg_67_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1097ui_story"].transform.localEulerAngles = arg_67_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1097ui_story"].transform.position).z)
				arg_67_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1097ui_story"].transform.localEulerAngles = arg_67_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1084ui_story"].transform

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084ui_story = var_70_1.localPosition
			end

			local var_70_2 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 then
				var_70_1.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_67_1.time_ - 0) / var_70_2)
				var_70_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_1.position).x, (manager.ui.mainCamera.transform.position - var_70_1.position).y, (manager.ui.mainCamera.transform.position - var_70_1.position).z)
				var_70_1.localEulerAngles.z = 0
				var_70_1.localEulerAngles.x = 0
				var_70_1.localEulerAngles = var_70_1.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 then
				var_70_1.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_70_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_70_1.position).x, (manager.ui.mainCamera.transform.position - var_70_1.position).y, (manager.ui.mainCamera.transform.position - var_70_1.position).z)
				var_70_1.localEulerAngles.z = 0
				var_70_1.localEulerAngles.x = 0
				var_70_1.localEulerAngles = var_70_1.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_70_3 = arg_67_1.actors_["1084ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_4 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_4 and not isNil(var_70_3) then
				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_3) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_4 and arg_67_1.time_ < 0 + var_70_4 + arg_70_0 and not isNil(var_70_3) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_70_6 = 0
			local var_70_7 = 0.2

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:GetWordFromCfg(113181016)
				local var_70_9 = arg_67_1:FormatText(var_70_8.content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 8 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 8)

				if (8 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 8)) > 0 and var_70_7 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181016", "story_v_out_113181.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_113181", "113181016", "story_v_out_113181.awb") / 1000

					if var_70_12 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_6
					end

					if var_70_8.prefab_name ~= "" and arg_67_1.actors_[var_70_8.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_8.prefab_name].transform, "story_v_out_113181", "113181016", "story_v_out_113181.awb")

						arg_67_1:RecordAudio("113181016", var_70_13)
						arg_67_1:RecordAudio("113181016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113181", "113181016", "story_v_out_113181.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113181", "113181016", "story_v_out_113181.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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

		arg_67_1:InitPlayNodeList()
	end,
	Play113181017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113181017
		arg_71_1.duration_ = 16.47

		local var_71_0 = {
			ja = 16.466,
			ko = 12.833,
			zh = 9.566,
			en = 10.933
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
				arg_71_0:Play113181018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(arg_71_1.actors_["1084ui_story"]) and arg_71_1.var_.characterEffect1084ui_story == nil then
				arg_71_1.var_.characterEffect1084ui_story = arg_71_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_0 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 and not isNil(arg_71_1.actors_["1084ui_story"]) then
				if arg_71_1.var_.characterEffect1084ui_story and not isNil(arg_71_1.actors_["1084ui_story"]) then
					arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_0)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 and not isNil(arg_71_1.actors_["1084ui_story"]) and arg_71_1.var_.characterEffect1084ui_story then
				arg_71_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_74_1 = arg_71_1.actors_["1038ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1038ui_story == nil then
				arg_71_1.var_.characterEffect1038ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.2

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect1038ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect1038ui_story then
				arg_71_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1038ui_story"].transform

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos1038ui_story = var_74_4.localPosition
			end

			local var_74_5 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 then
				var_74_4.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_71_1.time_ - 0) / var_74_5)
				var_74_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_4.position).x, (manager.ui.mainCamera.transform.position - var_74_4.position).y, (manager.ui.mainCamera.transform.position - var_74_4.position).z)
				var_74_4.localEulerAngles.z = 0
				var_74_4.localEulerAngles.x = 0
				var_74_4.localEulerAngles = var_74_4.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 then
				var_74_4.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_74_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_74_4.position).x, (manager.ui.mainCamera.transform.position - var_74_4.position).y, (manager.ui.mainCamera.transform.position - var_74_4.position).z)
				var_74_4.localEulerAngles.z = 0
				var_74_4.localEulerAngles.x = 0
				var_74_4.localEulerAngles = var_74_4.localEulerAngles
			end

			local var_74_6 = 0
			local var_74_7 = 1.275

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(113181017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 51 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 51)

				if (51 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 51)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181017", "story_v_out_113181.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_113181", "113181017", "story_v_out_113181.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_113181", "113181017", "story_v_out_113181.awb")

						arg_71_1:RecordAudio("113181017", var_74_13)
						arg_71_1:RecordAudio("113181017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_113181", "113181017", "story_v_out_113181.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_113181", "113181017", "story_v_out_113181.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play113181018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113181018
		arg_75_1.duration_ = 14.5

		local var_75_0 = {
			ja = 14.5,
			ko = 10.3,
			zh = 6.866,
			en = 13.566
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
				arg_75_0:Play113181019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_1")
			end

			local var_78_0 = 0
			local var_78_1 = 0.925

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_2 = arg_75_1:GetWordFromCfg(113181018)
				local var_78_3 = arg_75_1:FormatText(var_78_2.content)

				arg_75_1.text_.text = var_78_3

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 37 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_3) / 37)

				if (37 <= 0 and var_78_1 or var_78_1 * (utf8.len(var_78_3) / 37)) > 0 and var_78_1 < var_78_5 then
					arg_75_1.talkMaxDuration = var_78_5

					if var_78_5 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_5 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_3
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181018", "story_v_out_113181.awb") ~= 0 then
					local var_78_6 = manager.audio:GetVoiceLength("story_v_out_113181", "113181018", "story_v_out_113181.awb") / 1000

					if var_78_6 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_6 + var_78_0
					end

					if var_78_2.prefab_name ~= "" and arg_75_1.actors_[var_78_2.prefab_name] ~= nil then
						local var_78_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_2.prefab_name].transform, "story_v_out_113181", "113181018", "story_v_out_113181.awb")

						arg_75_1:RecordAudio("113181018", var_78_7)
						arg_75_1:RecordAudio("113181018", var_78_7)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113181", "113181018", "story_v_out_113181.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113181", "113181018", "story_v_out_113181.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_8 and arg_75_1.time_ < var_78_0 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113181019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113181019
		arg_79_1.duration_ = 2.67

		local var_79_0 = {
			ja = 1.999999999999,
			ko = 2.666,
			zh = 2.4,
			en = 1.999999999999
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
				arg_79_0:Play113181020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4134")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_82_0 = arg_79_1.actors_["1084ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1084ui_story == nil then
				arg_79_1.var_.characterEffect1084ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_1 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_1 and not isNil(var_82_0) then
				if arg_79_1.var_.characterEffect1084ui_story and not isNil(var_82_0) then
					arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_1 and arg_79_1.time_ < 0 + var_82_1 + arg_82_0 and not isNil(var_82_0) and arg_79_1.var_.characterEffect1084ui_story then
				arg_79_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_82_3 = arg_79_1.actors_["1038ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1038ui_story == nil then
				arg_79_1.var_.characterEffect1038ui_story = var_82_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_4 = 0.2

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_4 and not isNil(var_82_3) then
				if arg_79_1.var_.characterEffect1038ui_story and not isNil(var_82_3) then
					arg_79_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_79_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_79_1.time_ - 0) / var_82_4)
				end
			end

			if arg_79_1.time_ >= 0 + var_82_4 and arg_79_1.time_ < 0 + var_82_4 + arg_82_0 and not isNil(var_82_3) and arg_79_1.var_.characterEffect1038ui_story then
				arg_79_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_79_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_82_5 = 0
			local var_82_6 = 0.2

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_5 + arg_82_0 then
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

				local var_82_7 = arg_79_1:GetWordFromCfg(113181019)
				local var_82_8 = arg_79_1:FormatText(var_82_7.content)

				arg_79_1.text_.text = var_82_8

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 8 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 8)

				if (8 <= 0 and var_82_6 or var_82_6 * (utf8.len(var_82_8) / 8)) > 0 and var_82_6 < var_82_10 then
					arg_79_1.talkMaxDuration = var_82_10

					if var_82_10 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_5
					end
				end

				arg_79_1.text_.text = var_82_8
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181019", "story_v_out_113181.awb") ~= 0 then
					local var_82_11 = manager.audio:GetVoiceLength("story_v_out_113181", "113181019", "story_v_out_113181.awb") / 1000

					if var_82_11 + var_82_5 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_11 + var_82_5
					end

					if var_82_7.prefab_name ~= "" and arg_79_1.actors_[var_82_7.prefab_name] ~= nil then
						local var_82_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_7.prefab_name].transform, "story_v_out_113181", "113181019", "story_v_out_113181.awb")

						arg_79_1:RecordAudio("113181019", var_82_12)
						arg_79_1:RecordAudio("113181019", var_82_12)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113181", "113181019", "story_v_out_113181.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113181", "113181019", "story_v_out_113181.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_6, arg_79_1.talkMaxDuration)

			if var_82_5 <= arg_79_1.time_ and arg_79_1.time_ < var_82_5 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_5) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_5 + var_82_13 and arg_79_1.time_ < var_82_5 + var_82_13 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113181020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113181020
		arg_83_1.duration_ = 4.97

		local var_83_0 = {
			ja = 3.7,
			ko = 3.766,
			zh = 3.133,
			en = 4.966
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
				arg_83_0:Play113181021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action3_2")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_86_0 = arg_83_1.actors_["1038ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1038ui_story == nil then
				arg_83_1.var_.characterEffect1038ui_story = var_86_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_1 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_1 and not isNil(var_86_0) then
				if arg_83_1.var_.characterEffect1038ui_story and not isNil(var_86_0) then
					arg_83_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_1 and arg_83_1.time_ < 0 + var_86_1 + arg_86_0 and not isNil(var_86_0) and arg_83_1.var_.characterEffect1038ui_story then
				arg_83_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_86_3 = arg_83_1.actors_["1084ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_4 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_4 and not isNil(var_86_3) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_3) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_4)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_4 and arg_83_1.time_ < 0 + var_86_4 + arg_86_0 and not isNil(var_86_3) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_86_5 = 0
			local var_86_6 = 0.425

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_5 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_7 = arg_83_1:GetWordFromCfg(113181020)
				local var_86_8 = arg_83_1:FormatText(var_86_7.content)

				arg_83_1.text_.text = var_86_8

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_10 = 17 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 17)

				if (17 <= 0 and var_86_6 or var_86_6 * (utf8.len(var_86_8) / 17)) > 0 and var_86_6 < var_86_10 then
					arg_83_1.talkMaxDuration = var_86_10

					if var_86_10 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_10 + var_86_5
					end
				end

				arg_83_1.text_.text = var_86_8
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181020", "story_v_out_113181.awb") ~= 0 then
					local var_86_11 = manager.audio:GetVoiceLength("story_v_out_113181", "113181020", "story_v_out_113181.awb") / 1000

					if var_86_11 + var_86_5 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_11 + var_86_5
					end

					if var_86_7.prefab_name ~= "" and arg_83_1.actors_[var_86_7.prefab_name] ~= nil then
						local var_86_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_7.prefab_name].transform, "story_v_out_113181", "113181020", "story_v_out_113181.awb")

						arg_83_1:RecordAudio("113181020", var_86_12)
						arg_83_1:RecordAudio("113181020", var_86_12)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113181", "113181020", "story_v_out_113181.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113181", "113181020", "story_v_out_113181.awb")
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
	Play113181021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113181021
		arg_87_1.duration_ = 11.6

		local var_87_0 = {
			ja = 6.4,
			ko = 4.633,
			zh = 4.633,
			en = 11.6
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
				arg_87_0:Play113181022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1097ui_story = arg_87_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_90_0 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 then
				arg_87_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_87_1.time_ - 0) / var_90_0)
				arg_87_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).z)
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles = arg_87_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 then
				arg_87_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_87_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_87_1.actors_["1097ui_story"].transform.position).z)
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_87_1.actors_["1097ui_story"].transform.localEulerAngles = arg_87_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_90_1 = arg_87_1.actors_["1097ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1097ui_story == nil then
				arg_87_1.var_.characterEffect1097ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1097ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1097ui_story then
				arg_87_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_90_4 = arg_87_1.actors_["1038ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect1038ui_story == nil then
				arg_87_1.var_.characterEffect1038ui_story = var_90_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_5 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_5 and not isNil(var_90_4) then
				if arg_87_1.var_.characterEffect1038ui_story and not isNil(var_90_4) then
					arg_87_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_5)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_5 and arg_87_1.time_ < 0 + var_90_5 + arg_90_0 and not isNil(var_90_4) and arg_87_1.var_.characterEffect1038ui_story then
				arg_87_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_90_6 = arg_87_1.actors_["1084ui_story"].transform

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1.var_.moveOldPos1084ui_story = var_90_6.localPosition
			end

			local var_90_7 = 0.001

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_7 then
				var_90_6.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_87_1.time_ - 0) / var_90_7)
				var_90_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_6.position).x, (manager.ui.mainCamera.transform.position - var_90_6.position).y, (manager.ui.mainCamera.transform.position - var_90_6.position).z)
				var_90_6.localEulerAngles.z = 0
				var_90_6.localEulerAngles.x = 0
				var_90_6.localEulerAngles = var_90_6.localEulerAngles
			end

			if arg_87_1.time_ >= 0 + var_90_7 and arg_87_1.time_ < 0 + var_90_7 + arg_90_0 then
				var_90_6.localPosition = Vector3.New(0, 100, 0)
				var_90_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_90_6.position).x, (manager.ui.mainCamera.transform.position - var_90_6.position).y, (manager.ui.mainCamera.transform.position - var_90_6.position).z)
				var_90_6.localEulerAngles.z = 0
				var_90_6.localEulerAngles.x = 0
				var_90_6.localEulerAngles = var_90_6.localEulerAngles
			end

			local var_90_8 = 0
			local var_90_9 = 0.375

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_8 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_10 = arg_87_1:GetWordFromCfg(113181021)
				local var_90_11 = arg_87_1:FormatText(var_90_10.content)

				arg_87_1.text_.text = var_90_11

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_13 = 15 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 15)

				if (15 <= 0 and var_90_9 or var_90_9 * (utf8.len(var_90_11) / 15)) > 0 and var_90_9 < var_90_13 then
					arg_87_1.talkMaxDuration = var_90_13

					if var_90_13 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_13 + var_90_8
					end
				end

				arg_87_1.text_.text = var_90_11
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181021", "story_v_out_113181.awb") ~= 0 then
					local var_90_14 = manager.audio:GetVoiceLength("story_v_out_113181", "113181021", "story_v_out_113181.awb") / 1000

					if var_90_14 + var_90_8 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_14 + var_90_8
					end

					if var_90_10.prefab_name ~= "" and arg_87_1.actors_[var_90_10.prefab_name] ~= nil then
						local var_90_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_10.prefab_name].transform, "story_v_out_113181", "113181021", "story_v_out_113181.awb")

						arg_87_1:RecordAudio("113181021", var_90_15)
						arg_87_1:RecordAudio("113181021", var_90_15)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113181", "113181021", "story_v_out_113181.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113181", "113181021", "story_v_out_113181.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_16 = math.max(var_90_9, arg_87_1.talkMaxDuration)

			if var_90_8 <= arg_87_1.time_ and arg_87_1.time_ < var_90_8 + var_90_16 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_8) / var_90_16

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_8 + var_90_16 and arg_87_1.time_ < var_90_8 + var_90_16 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1097ui_story",
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

		arg_87_1:InitPlayNodeList()
	end,
	Play113181022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113181022
		arg_91_1.duration_ = 5

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play113181023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1097ui_story"]) and arg_91_1.var_.characterEffect1097ui_story == nil then
				arg_91_1.var_.characterEffect1097ui_story = arg_91_1.actors_["1097ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1097ui_story"]) then
				if arg_91_1.var_.characterEffect1097ui_story and not isNil(arg_91_1.actors_["1097ui_story"]) then
					arg_91_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_0)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1097ui_story"]) and arg_91_1.var_.characterEffect1097ui_story then
				arg_91_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_94_1 = 0
			local var_94_2 = 0.375

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_1 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, false)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_3 = arg_91_1:FormatText(arg_91_1:GetWordFromCfg(113181022).content)

				arg_91_1.text_.text = var_94_3

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_5 = 15 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 15)

				if (15 <= 0 and var_94_2 or var_94_2 * (utf8.len(var_94_3) / 15)) > 0 and var_94_2 < var_94_5 then
					arg_91_1.talkMaxDuration = var_94_5

					if var_94_5 + var_94_1 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_5 + var_94_1
					end
				end

				arg_91_1.text_.text = var_94_3
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)
				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_6 = math.max(var_94_2, arg_91_1.talkMaxDuration)

			if var_94_1 <= arg_91_1.time_ and arg_91_1.time_ < var_94_1 + var_94_6 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_1) / var_94_6

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_1 + var_94_6 and arg_91_1.time_ < var_94_1 + var_94_6 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play113181023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 113181023
		arg_95_1.duration_ = 2.9

		local var_95_0 = {
			ja = 2.9,
			ko = 2.866,
			zh = 1.999999999999,
			en = 2.266
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
			arg_95_1.auto_ = false
		end

		function arg_95_1.playNext_(arg_97_0)
			arg_95_1.onStoryFinished_()
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 and not isNil(arg_95_1.actors_["1038ui_story"]) and arg_95_1.var_.characterEffect1038ui_story == nil then
				arg_95_1.var_.characterEffect1038ui_story = arg_95_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_98_0 = 0.2

			if 0 <= arg_95_1.time_ and arg_95_1.time_ < 0 + var_98_0 and not isNil(arg_95_1.actors_["1038ui_story"]) then
				if arg_95_1.var_.characterEffect1038ui_story and not isNil(arg_95_1.actors_["1038ui_story"]) then
					arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_95_1.time_ >= 0 + var_98_0 and arg_95_1.time_ < 0 + var_98_0 + arg_98_0 and not isNil(arg_95_1.actors_["1038ui_story"]) and arg_95_1.var_.characterEffect1038ui_story then
				arg_95_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action7_1")
			end

			local var_98_2 = 0
			local var_98_3 = 0.15

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_2 + arg_98_0 then
				arg_95_1.talkMaxDuration = 0
				arg_95_1.dialogCg_.alpha = 1

				arg_95_1.dialog_:SetActive(true)
				SetActive(arg_95_1.leftNameGo_, true)

				arg_95_1.leftNameTxt_.text = arg_95_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_95_1.leftNameTxt_.transform)

				arg_95_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_95_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_95_1:RecordName(arg_95_1.leftNameTxt_.text)
				SetActive(arg_95_1.iconTrs_.gameObject, false)
				arg_95_1.callingController_:SetSelectedState("normal")

				local var_98_4 = arg_95_1:GetWordFromCfg(113181023)
				local var_98_5 = arg_95_1:FormatText(var_98_4.content)

				arg_95_1.text_.text = var_98_5

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_7 = 6 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 6)

				if (6 <= 0 and var_98_3 or var_98_3 * (utf8.len(var_98_5) / 6)) > 0 and var_98_3 < var_98_7 then
					arg_95_1.talkMaxDuration = var_98_7

					if var_98_7 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_7 + var_98_2
					end
				end

				arg_95_1.text_.text = var_98_5
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113181", "113181023", "story_v_out_113181.awb") ~= 0 then
					local var_98_8 = manager.audio:GetVoiceLength("story_v_out_113181", "113181023", "story_v_out_113181.awb") / 1000

					if var_98_8 + var_98_2 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_8 + var_98_2
					end

					if var_98_4.prefab_name ~= "" and arg_95_1.actors_[var_98_4.prefab_name] ~= nil then
						local var_98_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_4.prefab_name].transform, "story_v_out_113181", "113181023", "story_v_out_113181.awb")

						arg_95_1:RecordAudio("113181023", var_98_9)
						arg_95_1:RecordAudio("113181023", var_98_9)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_113181", "113181023", "story_v_out_113181.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_113181", "113181023", "story_v_out_113181.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_10 = math.max(var_98_3, arg_95_1.talkMaxDuration)

			if var_98_2 <= arg_95_1.time_ and arg_95_1.time_ < var_98_2 + var_98_10 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_2) / var_98_10

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_2 + var_98_10 and arg_95_1.time_ < var_98_2 + var_98_10 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F04"
	},
	voices = {
		"story_v_out_113181.awb"
	}
}
