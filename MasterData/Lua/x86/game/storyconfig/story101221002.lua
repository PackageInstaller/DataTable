return {
	Play122102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 122102001
		arg_1_1.duration_ = 9.43

		local var_1_0 = {
			ja = 9.433,
			ko = 8.066,
			zh = 8.066
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
				arg_1_0:Play122102002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.A03 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "A03")
				var_4_0.name = "A03"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.A03 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.A03

				arg_1_1.bgs_.A03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "A03" then
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_12.localPosition
			end

			local var_4_13 = 0.001

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_13 then
				var_4_12.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_1_1.time_ - 2) / var_4_13)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			if arg_1_1.time_ >= 2 + var_4_13 and arg_1_1.time_ < 2 + var_4_13 + arg_4_0 then
				var_4_12.localPosition = Vector3.New(0, -0.97, -6)
				var_4_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_12.position).x, (manager.ui.mainCamera.transform.position - var_4_12.position).y, (manager.ui.mainCamera.transform.position - var_4_12.position).z)
				var_4_12.localEulerAngles.z = 0
				var_4_12.localEulerAngles.x = 0
				var_4_12.localEulerAngles = var_4_12.localEulerAngles
			end

			local var_4_14 = arg_1_1.actors_["1084ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_15 = 0.200000002980232

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_15 and not isNil(var_4_14) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_14) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_15 and arg_1_1.time_ < 2 + var_4_15 + arg_4_0 and not isNil(var_4_14) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
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

			if 1.46666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 1.46666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short.awb")

				local var_4_22 = manager.audio:GetAudioName("bgm_activity_2_2_story_ver_1_short", "bgm_activity_2_2_story_ver_1_short")

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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_23 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_23 + 0.5 and arg_1_1.time_ < var_4_23 + 0.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_24 = 2
			local var_4_25 = 0.675

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_24 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_27 = arg_1_1:GetWordFromCfg(122102001)
				local var_4_28 = arg_1_1:FormatText(var_4_27.content)

				arg_1_1.text_.text = var_4_28

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_30 = 27 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 27)

				if (27 <= 0 and var_4_25 or var_4_25 * (utf8.len(var_4_28) / 27)) > 0 and var_4_25 < var_4_30 then
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

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102001", "story_v_out_122102.awb") ~= 0 then
					local var_4_31 = manager.audio:GetVoiceLength("story_v_out_122102", "122102001", "story_v_out_122102.awb") / 1000

					if var_4_31 + var_4_24 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_31 + var_4_24
					end

					if var_4_27.prefab_name ~= "" and arg_1_1.actors_[var_4_27.prefab_name] ~= nil then
						local var_4_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_27.prefab_name].transform, "story_v_out_122102", "122102001", "story_v_out_122102.awb")

						arg_1_1:RecordAudio("122102001", var_4_32)
						arg_1_1:RecordAudio("122102001", var_4_32)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_122102", "122102001", "story_v_out_122102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_122102", "122102001", "story_v_out_122102.awb")
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
	Play122102002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 122102002
		arg_9_1.duration_ = 3.23

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play122102003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = arg_9_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_12_0 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_0 then
				arg_9_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_9_1.time_ - 0) / var_12_0)
				arg_9_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1084ui_story"].transform.position).z)
				arg_9_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1084ui_story"].transform.localEulerAngles = arg_9_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_0 and arg_9_1.time_ < 0 + var_12_0 + arg_12_0 then
				arg_9_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_9_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_9_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_9_1.actors_["1084ui_story"].transform.position).z)
				arg_9_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_9_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_9_1.actors_["1084ui_story"].transform.localEulerAngles = arg_9_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_12_1 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_2 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_2 and not isNil(var_12_1) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_1) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_2 and arg_9_1.time_ < 0 + var_12_2 + arg_12_0 and not isNil(var_12_1) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 1 < arg_9_1.time_ and arg_9_1.time_ <= 1 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4124")
			end

			if 1 < arg_9_1.time_ and arg_9_1.time_ <= 1 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			local var_12_4 = 0

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_4 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_5 = 1

			if var_12_4 <= arg_9_1.time_ and arg_9_1.time_ < var_12_4 + var_12_5 then
				local var_12_6 = Color.New(0, 0, 0)

				var_12_6.a = Mathf.Lerp(0, 1, (arg_9_1.time_ - var_12_4) / var_12_5)
				arg_9_1.mask_.color = var_12_6
			end

			if arg_9_1.time_ >= var_12_4 + var_12_5 and arg_9_1.time_ < var_12_4 + var_12_5 + arg_12_0 then
				local var_12_7 = Color.New(0, 0, 0)

				var_12_7.a = 1
				arg_9_1.mask_.color = var_12_7
			end

			local var_12_8 = 1

			if 1 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.mask_.enabled = true
				arg_9_1.mask_.raycastTarget = true

				arg_9_1:SetGaussion(false)
			end

			local var_12_9 = 1

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_9 then
				local var_12_10 = Color.New(0, 0, 0)

				var_12_10.a = Mathf.Lerp(1, 0, (arg_9_1.time_ - var_12_8) / var_12_9)
				arg_9_1.mask_.color = var_12_10
			end

			if arg_9_1.time_ >= var_12_8 + var_12_9 and arg_9_1.time_ < var_12_8 + var_12_9 + arg_12_0 then
				local var_12_11 = Color.New(0, 0, 0)

				arg_9_1.mask_.enabled = false
				var_12_11.a = 0
				arg_9_1.mask_.color = var_12_11
			end

			local var_12_12 = 0
			local var_12_13 = 0.2

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_12 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0

				arg_9_1.dialog_:SetActive(true)

				arg_9_1.dialogCg_.alpha = 0

				local var_12_14 = LeanTween.value(arg_9_1.dialog_, 0, 1, 0.3)

				var_12_14:setOnUpdate(LuaHelper.FloatAction(function(arg_13_0)
					arg_9_1.dialogCg_.alpha = arg_13_0
				end))
				var_12_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_9_1.dialog_)
					var_12_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_9_1.duration_ = arg_9_1.duration_ + 0.3

				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_15 = arg_9_1:GetWordFromCfg(122102002)
				local var_12_16 = arg_9_1:FormatText(var_12_15.content)

				arg_9_1.text_.text = var_12_16

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_18 = 8 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_16) / 8)

				if (8 <= 0 and var_12_13 or var_12_13 * (utf8.len(var_12_16) / 8)) > 0 and var_12_13 < var_12_18 then
					arg_9_1.talkMaxDuration = var_12_18
					var_12_12 = var_12_12 + 0.3

					if var_12_18 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_18 + var_12_12
					end
				end

				arg_9_1.text_.text = var_12_16
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102002", "story_v_out_122102.awb") ~= 0 then
					local var_12_19 = manager.audio:GetVoiceLength("story_v_out_122102", "122102002", "story_v_out_122102.awb") / 1000

					if var_12_19 + var_12_12 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_19 + var_12_12
					end

					if var_12_15.prefab_name ~= "" and arg_9_1.actors_[var_12_15.prefab_name] ~= nil then
						local var_12_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_15.prefab_name].transform, "story_v_out_122102", "122102002", "story_v_out_122102.awb")

						arg_9_1:RecordAudio("122102002", var_12_20)
						arg_9_1:RecordAudio("122102002", var_12_20)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_122102", "122102002", "story_v_out_122102.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_122102", "122102002", "story_v_out_122102.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_21 = var_12_12 + 0.3
			local var_12_22 = math.max(var_12_13, arg_9_1.talkMaxDuration)

			if var_12_12 + 0.3 <= arg_9_1.time_ and arg_9_1.time_ < var_12_21 + var_12_22 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_21) / var_12_22

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_21 + var_12_22 and arg_9_1.time_ < var_12_21 + var_12_22 + arg_12_0 then
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
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play122102003 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 122102003
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play122102004(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			if 0 < arg_15_1.time_ and arg_15_1.time_ <= 0 + arg_18_0 and not isNil(arg_15_1.actors_["1084ui_story"]) and arg_15_1.var_.characterEffect1084ui_story == nil then
				arg_15_1.var_.characterEffect1084ui_story = arg_15_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_18_0 = 0.200000002980232

			if 0 <= arg_15_1.time_ and arg_15_1.time_ < 0 + var_18_0 and not isNil(arg_15_1.actors_["1084ui_story"]) then
				if arg_15_1.var_.characterEffect1084ui_story and not isNil(arg_15_1.actors_["1084ui_story"]) then
					arg_15_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_15_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_15_1.time_ - 0) / var_18_0)
				end
			end

			if arg_15_1.time_ >= 0 + var_18_0 and arg_15_1.time_ < 0 + var_18_0 + arg_18_0 and not isNil(arg_15_1.actors_["1084ui_story"]) and arg_15_1.var_.characterEffect1084ui_story then
				arg_15_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_15_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_18_1 = 0
			local var_18_2 = 0.325

			if 0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_1 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, true)

				arg_15_1.leftNameTxt_.text = arg_15_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_15_1.leftNameTxt_.transform)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1.leftNameTxt_.text)
				SetActive(arg_15_1.iconTrs_.gameObject, true)
				arg_15_1.iconController_:SetSelectedState("hero")

				arg_15_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_15_1.callingController_:SetSelectedState("normal")

				arg_15_1.keyicon_.color = Color.New(1, 1, 1)
				arg_15_1.icon_.color = Color.New(1, 1, 1)

				local var_18_3 = arg_15_1:FormatText(arg_15_1:GetWordFromCfg(122102003).content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_5 = 13 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 13)

				if (13 <= 0 and var_18_2 or var_18_2 * (utf8.len(var_18_3) / 13)) > 0 and var_18_2 < var_18_5 then
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

		arg_15_1.nodeConfigList_ = {}

		arg_15_1:InitPlayNodeList()
	end,
	Play122102004 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 122102004
		arg_19_1.duration_ = 6.2

		local var_19_0 = {
			ja = 6.2,
			ko = 3.366,
			zh = 3.366
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
				arg_19_0:Play122102005(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 and not isNil(arg_19_1.actors_["1084ui_story"]) and arg_19_1.var_.characterEffect1084ui_story == nil then
				arg_19_1.var_.characterEffect1084ui_story = arg_19_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_22_0 = 0.200000002980232

			if 0 <= arg_19_1.time_ and arg_19_1.time_ < 0 + var_22_0 and not isNil(arg_19_1.actors_["1084ui_story"]) then
				if arg_19_1.var_.characterEffect1084ui_story and not isNil(arg_19_1.actors_["1084ui_story"]) then
					arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_19_1.time_ >= 0 + var_22_0 and arg_19_1.time_ < 0 + var_22_0 + arg_22_0 and not isNil(arg_19_1.actors_["1084ui_story"]) and arg_19_1.var_.characterEffect1084ui_story then
				arg_19_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= 0 + arg_22_0 then
				arg_19_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action443")
			end

			local var_22_2 = 0
			local var_22_3 = 0.35

			if 0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_2 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0
				arg_19_1.dialogCg_.alpha = 1

				arg_19_1.dialog_:SetActive(true)
				SetActive(arg_19_1.leftNameGo_, true)

				arg_19_1.leftNameTxt_.text = arg_19_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_19_1.leftNameTxt_.transform)

				arg_19_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_19_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_19_1:RecordName(arg_19_1.leftNameTxt_.text)
				SetActive(arg_19_1.iconTrs_.gameObject, false)
				arg_19_1.callingController_:SetSelectedState("normal")

				local var_22_4 = arg_19_1:GetWordFromCfg(122102004)
				local var_22_5 = arg_19_1:FormatText(var_22_4.content)

				arg_19_1.text_.text = var_22_5

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.text_)

				local var_22_7 = 14 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 14)

				if (14 <= 0 and var_22_3 or var_22_3 * (utf8.len(var_22_5) / 14)) > 0 and var_22_3 < var_22_7 then
					arg_19_1.talkMaxDuration = var_22_7

					if var_22_7 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_7 + var_22_2
					end
				end

				arg_19_1.text_.text = var_22_5
				arg_19_1.typewritter.percent = 0

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102004", "story_v_out_122102.awb") ~= 0 then
					local var_22_8 = manager.audio:GetVoiceLength("story_v_out_122102", "122102004", "story_v_out_122102.awb") / 1000

					if var_22_8 + var_22_2 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_8 + var_22_2
					end

					if var_22_4.prefab_name ~= "" and arg_19_1.actors_[var_22_4.prefab_name] ~= nil then
						local var_22_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_19_1.actors_[var_22_4.prefab_name].transform, "story_v_out_122102", "122102004", "story_v_out_122102.awb")

						arg_19_1:RecordAudio("122102004", var_22_9)
						arg_19_1:RecordAudio("122102004", var_22_9)
					else
						arg_19_1:AudioAction("play", "voice", "story_v_out_122102", "122102004", "story_v_out_122102.awb")
					end

					arg_19_1:RecordHistoryTalkVoice("story_v_out_122102", "122102004", "story_v_out_122102.awb")
				end

				arg_19_1:RecordContent(arg_19_1.text_.text)
			end

			local var_22_10 = math.max(var_22_3, arg_19_1.talkMaxDuration)

			if var_22_2 <= arg_19_1.time_ and arg_19_1.time_ < var_22_2 + var_22_10 then
				arg_19_1.typewritter.percent = (arg_19_1.time_ - var_22_2) / var_22_10

				arg_19_1.typewritter:SetDirty()
			end

			if arg_19_1.time_ >= var_22_2 + var_22_10 and arg_19_1.time_ < var_22_2 + var_22_10 + arg_22_0 then
				arg_19_1.typewritter.percent = 1

				arg_19_1.typewritter:SetDirty()
				arg_19_1:ShowNextGo(true)
			end
		end

		arg_19_1.nodeConfigList_ = {}

		arg_19_1:InitPlayNodeList()
	end,
	Play122102005 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 122102005
		arg_23_1.duration_ = 5

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play122102006(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 and not isNil(arg_23_1.actors_["1084ui_story"]) and arg_23_1.var_.characterEffect1084ui_story == nil then
				arg_23_1.var_.characterEffect1084ui_story = arg_23_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_26_0 = 0.0166666666666667

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

			local var_26_1 = arg_23_1.actors_["1084ui_story"].transform

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= 0 + arg_26_0 then
				arg_23_1.var_.moveOldPos1084ui_story = var_26_1.localPosition
			end

			local var_26_2 = 0.001

			if 0 <= arg_23_1.time_ and arg_23_1.time_ < 0 + var_26_2 then
				var_26_1.localPosition = Vector3.Lerp(arg_23_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_23_1.time_ - 0) / var_26_2)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			if arg_23_1.time_ >= 0 + var_26_2 and arg_23_1.time_ < 0 + var_26_2 + arg_26_0 then
				var_26_1.localPosition = Vector3.New(0, 100, 0)
				var_26_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_26_1.position).x, (manager.ui.mainCamera.transform.position - var_26_1.position).y, (manager.ui.mainCamera.transform.position - var_26_1.position).z)
				var_26_1.localEulerAngles.z = 0
				var_26_1.localEulerAngles.x = 0
				var_26_1.localEulerAngles = var_26_1.localEulerAngles
			end

			local var_26_3 = 0
			local var_26_4 = 0.975

			if 0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_3 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0
				arg_23_1.dialogCg_.alpha = 1

				arg_23_1.dialog_:SetActive(true)
				SetActive(arg_23_1.leftNameGo_, false)

				arg_23_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_23_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_23_1:RecordName(arg_23_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_23_1.iconTrs_.gameObject, false)
				arg_23_1.callingController_:SetSelectedState("normal")

				local var_26_5 = arg_23_1:FormatText(arg_23_1:GetWordFromCfg(122102005).content)

				arg_23_1.text_.text = var_26_5

				LuaForUtil.ClearLinePrefixSymbol(arg_23_1.text_)

				local var_26_7 = 38 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 38)

				if (38 <= 0 and var_26_4 or var_26_4 * (utf8.len(var_26_5) / 38)) > 0 and var_26_4 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_3 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_3
					end
				end

				arg_23_1.text_.text = var_26_5
				arg_23_1.typewritter.percent = 0

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(false)
				arg_23_1:RecordContent(arg_23_1.text_.text)
			end

			local var_26_8 = math.max(var_26_4, arg_23_1.talkMaxDuration)

			if var_26_3 <= arg_23_1.time_ and arg_23_1.time_ < var_26_3 + var_26_8 then
				arg_23_1.typewritter.percent = (arg_23_1.time_ - var_26_3) / var_26_8

				arg_23_1.typewritter:SetDirty()
			end

			if arg_23_1.time_ >= var_26_3 + var_26_8 and arg_23_1.time_ < var_26_3 + var_26_8 + arg_26_0 then
				arg_23_1.typewritter.percent = 1

				arg_23_1.typewritter:SetDirty()
				arg_23_1:ShowNextGo(true)
			end
		end

		arg_23_1.nodeConfigList_ = {
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

		arg_23_1:InitPlayNodeList()
	end,
	Play122102006 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 122102006
		arg_27_1.duration_ = 3.57

		local var_27_0 = {
			ja = 3.566,
			ko = 2.866,
			zh = 2.866
		}
		local var_27_1 = manager.audio:GetLocalizationFlag()

		if var_27_0[var_27_1] ~= nil then
			arg_27_1.duration_ = var_27_0[var_27_1]
		end

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play122102007(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1.var_.moveOldPos1084ui_story = arg_27_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_30_0 = 0.001

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_0 then
				arg_27_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_27_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_27_1.time_ - 0) / var_30_0)
				arg_27_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).z)
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles = arg_27_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_27_1.time_ >= 0 + var_30_0 and arg_27_1.time_ < 0 + var_30_0 + arg_30_0 then
				arg_27_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_27_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_27_1.actors_["1084ui_story"].transform.position).z)
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_27_1.actors_["1084ui_story"].transform.localEulerAngles = arg_27_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_30_1 = arg_27_1.actors_["1084ui_story"]

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1084ui_story == nil then
				arg_27_1.var_.characterEffect1084ui_story = var_30_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_30_2 = 0.200000002980232

			if 0 <= arg_27_1.time_ and arg_27_1.time_ < 0 + var_30_2 and not isNil(var_30_1) then
				if arg_27_1.var_.characterEffect1084ui_story and not isNil(var_30_1) then
					arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_27_1.time_ >= 0 + var_30_2 and arg_27_1.time_ < 0 + var_30_2 + arg_30_0 and not isNil(var_30_1) and arg_27_1.var_.characterEffect1084ui_story then
				arg_27_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= 0 + arg_30_0 then
				arg_27_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_30_4 = 0
			local var_30_5 = 0.25

			if 0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_4 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0
				arg_27_1.dialogCg_.alpha = 1

				arg_27_1.dialog_:SetActive(true)
				SetActive(arg_27_1.leftNameGo_, true)

				arg_27_1.leftNameTxt_.text = arg_27_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_27_1.leftNameTxt_.transform)

				arg_27_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_27_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_27_1:RecordName(arg_27_1.leftNameTxt_.text)
				SetActive(arg_27_1.iconTrs_.gameObject, false)
				arg_27_1.callingController_:SetSelectedState("normal")

				local var_30_6 = arg_27_1:GetWordFromCfg(122102006)
				local var_30_7 = arg_27_1:FormatText(var_30_6.content)

				arg_27_1.text_.text = var_30_7

				LuaForUtil.ClearLinePrefixSymbol(arg_27_1.text_)

				local var_30_9 = 10 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 10)

				if (10 <= 0 and var_30_5 or var_30_5 * (utf8.len(var_30_7) / 10)) > 0 and var_30_5 < var_30_9 then
					arg_27_1.talkMaxDuration = var_30_9

					if var_30_9 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_9 + var_30_4
					end
				end

				arg_27_1.text_.text = var_30_7
				arg_27_1.typewritter.percent = 0

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102006", "story_v_out_122102.awb") ~= 0 then
					local var_30_10 = manager.audio:GetVoiceLength("story_v_out_122102", "122102006", "story_v_out_122102.awb") / 1000

					if var_30_10 + var_30_4 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_10 + var_30_4
					end

					if var_30_6.prefab_name ~= "" and arg_27_1.actors_[var_30_6.prefab_name] ~= nil then
						local var_30_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_27_1.actors_[var_30_6.prefab_name].transform, "story_v_out_122102", "122102006", "story_v_out_122102.awb")

						arg_27_1:RecordAudio("122102006", var_30_11)
						arg_27_1:RecordAudio("122102006", var_30_11)
					else
						arg_27_1:AudioAction("play", "voice", "story_v_out_122102", "122102006", "story_v_out_122102.awb")
					end

					arg_27_1:RecordHistoryTalkVoice("story_v_out_122102", "122102006", "story_v_out_122102.awb")
				end

				arg_27_1:RecordContent(arg_27_1.text_.text)
			end

			local var_30_12 = math.max(var_30_5, arg_27_1.talkMaxDuration)

			if var_30_4 <= arg_27_1.time_ and arg_27_1.time_ < var_30_4 + var_30_12 then
				arg_27_1.typewritter.percent = (arg_27_1.time_ - var_30_4) / var_30_12

				arg_27_1.typewritter:SetDirty()
			end

			if arg_27_1.time_ >= var_30_4 + var_30_12 and arg_27_1.time_ < var_30_4 + var_30_12 + arg_30_0 then
				arg_27_1.typewritter.percent = 1

				arg_27_1.typewritter:SetDirty()
				arg_27_1:ShowNextGo(true)
			end
		end

		arg_27_1.nodeConfigList_ = {
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

		arg_27_1:InitPlayNodeList()
	end,
	Play122102007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 122102007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play122102008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) and arg_31_1.var_.characterEffect1084ui_story == nil then
				arg_31_1.var_.characterEffect1084ui_story = arg_31_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_0 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) then
				if arg_31_1.var_.characterEffect1084ui_story and not isNil(arg_31_1.actors_["1084ui_story"]) then
					arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_31_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_31_1.time_ - 0) / var_34_0)
				end
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 and not isNil(arg_31_1.actors_["1084ui_story"]) and arg_31_1.var_.characterEffect1084ui_story then
				arg_31_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_31_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_34_1 = 0
			local var_34_2 = 1.175

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_1 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, false)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_3 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(122102007).content)

				arg_31_1.text_.text = var_34_3

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_5 = 47 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 47)

				if (47 <= 0 and var_34_2 or var_34_2 * (utf8.len(var_34_3) / 47)) > 0 and var_34_2 < var_34_5 then
					arg_31_1.talkMaxDuration = var_34_5

					if var_34_5 + var_34_1 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_5 + var_34_1
					end
				end

				arg_31_1.text_.text = var_34_3
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_6 = math.max(var_34_2, arg_31_1.talkMaxDuration)

			if var_34_1 <= arg_31_1.time_ and arg_31_1.time_ < var_34_1 + var_34_6 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_1) / var_34_6

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_1 + var_34_6 and arg_31_1.time_ < var_34_1 + var_34_6 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {}

		arg_31_1:InitPlayNodeList()
	end,
	Play122102008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 122102008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play122102009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 1.45

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_1 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(122102008).content)

				arg_35_1.text_.text = var_38_1

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_3 = 58 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 58)

				if (58 <= 0 and var_38_0 or var_38_0 * (utf8.len(var_38_1) / 58)) > 0 and var_38_0 < var_38_3 then
					arg_35_1.talkMaxDuration = var_38_3

					if var_38_3 + 0 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_3 + 0
					end
				end

				arg_35_1.text_.text = var_38_1
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_4 = math.max(var_38_0, arg_35_1.talkMaxDuration)

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_4 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - 0) / var_38_4

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= 0 + var_38_4 and arg_35_1.time_ < 0 + var_38_4 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {}

		arg_35_1:InitPlayNodeList()
	end,
	Play122102009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 122102009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play122102010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.175

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(122102009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 7 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 7)

				if (7 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 7)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play122102010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 122102010
		arg_43_1.duration_ = 8.67

		local var_43_0 = {
			ja = 8.666,
			ko = 3.366,
			zh = 3.366
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
				arg_43_0:Play122102011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1084ui_story"]) and arg_43_1.var_.characterEffect1084ui_story == nil then
				arg_43_1.var_.characterEffect1084ui_story = arg_43_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1084ui_story"]) then
				if arg_43_1.var_.characterEffect1084ui_story and not isNil(arg_43_1.actors_["1084ui_story"]) then
					arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1084ui_story"]) and arg_43_1.var_.characterEffect1084ui_story then
				arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4128")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_46_2 = 0
			local var_46_3 = 0.4

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_2 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_4 = arg_43_1:GetWordFromCfg(122102010)
				local var_46_5 = arg_43_1:FormatText(var_46_4.content)

				arg_43_1.text_.text = var_46_5

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_7 = 16 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 16)

				if (16 <= 0 and var_46_3 or var_46_3 * (utf8.len(var_46_5) / 16)) > 0 and var_46_3 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_2
					end
				end

				arg_43_1.text_.text = var_46_5
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102010", "story_v_out_122102.awb") ~= 0 then
					local var_46_8 = manager.audio:GetVoiceLength("story_v_out_122102", "122102010", "story_v_out_122102.awb") / 1000

					if var_46_8 + var_46_2 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_8 + var_46_2
					end

					if var_46_4.prefab_name ~= "" and arg_43_1.actors_[var_46_4.prefab_name] ~= nil then
						local var_46_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_4.prefab_name].transform, "story_v_out_122102", "122102010", "story_v_out_122102.awb")

						arg_43_1:RecordAudio("122102010", var_46_9)
						arg_43_1:RecordAudio("122102010", var_46_9)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_122102", "122102010", "story_v_out_122102.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_122102", "122102010", "story_v_out_122102.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_10 = math.max(var_46_3, arg_43_1.talkMaxDuration)

			if var_46_2 <= arg_43_1.time_ and arg_43_1.time_ < var_46_2 + var_46_10 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_2) / var_46_10

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_2 + var_46_10 and arg_43_1.time_ < var_46_2 + var_46_10 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {}

		arg_43_1:InitPlayNodeList()
	end,
	Play122102011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 122102011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play122102012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["1084ui_story"]) and arg_47_1.var_.characterEffect1084ui_story == nil then
				arg_47_1.var_.characterEffect1084ui_story = arg_47_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["1084ui_story"]) then
				if arg_47_1.var_.characterEffect1084ui_story and not isNil(arg_47_1.actors_["1084ui_story"]) then
					arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["1084ui_story"]) and arg_47_1.var_.characterEffect1084ui_story then
				arg_47_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 0.15

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(122102011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 6 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 6)

				if (6 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 6)) > 0 and var_50_2 < var_50_5 then
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
	Play122102012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 122102012
		arg_51_1.duration_ = 5.6

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play122102013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if arg_51_1.bgs_.STblack == nil then
				local var_54_0 = Object.Instantiate(arg_51_1.paintGo_)

				var_54_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_54_0.name = "STblack"
				var_54_0.transform.parent = arg_51_1.stage_.transform
				var_54_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.bgs_.STblack = var_54_0
			end

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				local var_54_1 = arg_51_1.bgs_.STblack

				arg_51_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_54_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_54_2 = var_54_1:GetComponent("SpriteRenderer")

				if var_54_2 and var_54_2.sprite then
					local var_54_3 = 2 * (var_54_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_54_1.transform.localScale = Vector3.New(var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, var_54_3 / var_54_2.sprite.bounds.size.y < var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x and var_54_3 * manager.ui.mainCameraCom_.aspect / var_54_2.sprite.bounds.size.x or var_54_3 / var_54_2.sprite.bounds.size.y, 0)
				end

				for iter_54_0, iter_54_1 in pairs(arg_51_1.bgs_) do
					if iter_54_0 ~= "STblack" then
						iter_54_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_54_4 = 0

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_4 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_5 = 2

			if var_54_4 <= arg_51_1.time_ and arg_51_1.time_ < var_54_4 + var_54_5 then
				local var_54_6 = Color.New(0, 0, 0)

				var_54_6.a = Mathf.Lerp(0, 1, (arg_51_1.time_ - var_54_4) / var_54_5)
				arg_51_1.mask_.color = var_54_6
			end

			if arg_51_1.time_ >= var_54_4 + var_54_5 and arg_51_1.time_ < var_54_4 + var_54_5 + arg_54_0 then
				local var_54_7 = Color.New(0, 0, 0)

				var_54_7.a = 1
				arg_51_1.mask_.color = var_54_7
			end

			local var_54_8 = 2

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= var_54_8 + arg_54_0 then
				arg_51_1.mask_.enabled = true
				arg_51_1.mask_.raycastTarget = true

				arg_51_1:SetGaussion(false)
			end

			local var_54_9 = 2

			if var_54_8 <= arg_51_1.time_ and arg_51_1.time_ < var_54_8 + var_54_9 then
				local var_54_10 = Color.New(0, 0, 0)

				var_54_10.a = Mathf.Lerp(1, 0, (arg_51_1.time_ - var_54_8) / var_54_9)
				arg_51_1.mask_.color = var_54_10
			end

			if arg_51_1.time_ >= var_54_8 + var_54_9 and arg_51_1.time_ < var_54_8 + var_54_9 + arg_54_0 then
				local var_54_11 = Color.New(0, 0, 0)

				arg_51_1.mask_.enabled = false
				var_54_11.a = 0
				arg_51_1.mask_.color = var_54_11
			end

			local var_54_12 = arg_51_1.actors_["1084ui_story"].transform

			if 1.96599999815226 < arg_51_1.time_ and arg_51_1.time_ <= 1.96599999815226 + arg_54_0 then
				arg_51_1.var_.moveOldPos1084ui_story = var_54_12.localPosition
			end

			local var_54_13 = 0.001

			if 1.96599999815226 <= arg_51_1.time_ and arg_51_1.time_ < 1.96599999815226 + var_54_13 then
				var_54_12.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_51_1.time_ - 1.96599999815226) / var_54_13)
				var_54_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_12.position).x, (manager.ui.mainCamera.transform.position - var_54_12.position).y, (manager.ui.mainCamera.transform.position - var_54_12.position).z)
				var_54_12.localEulerAngles.z = 0
				var_54_12.localEulerAngles.x = 0
				var_54_12.localEulerAngles = var_54_12.localEulerAngles
			end

			if arg_51_1.time_ >= 1.96599999815226 + var_54_13 and arg_51_1.time_ < 1.96599999815226 + var_54_13 + arg_54_0 then
				var_54_12.localPosition = Vector3.New(0, 100, 0)
				var_54_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_54_12.position).x, (manager.ui.mainCamera.transform.position - var_54_12.position).y, (manager.ui.mainCamera.transform.position - var_54_12.position).z)
				var_54_12.localEulerAngles.z = 0
				var_54_12.localEulerAngles.x = 0
				var_54_12.localEulerAngles = var_54_12.localEulerAngles
			end

			local var_54_14 = arg_51_1.actors_["1084ui_story"]

			if 1.96599999815226 < arg_51_1.time_ and arg_51_1.time_ <= 1.96599999815226 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.characterEffect1084ui_story == nil then
				arg_51_1.var_.characterEffect1084ui_story = var_54_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_15 = 0.034000001847744

			if 1.96599999815226 <= arg_51_1.time_ and arg_51_1.time_ < 1.96599999815226 + var_54_15 and not isNil(var_54_14) then
				if arg_51_1.var_.characterEffect1084ui_story and not isNil(var_54_14) then
					arg_51_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 1.96599999815226) / var_54_15)
				end
			end

			if arg_51_1.time_ >= 1.96599999815226 + var_54_15 and arg_51_1.time_ < 1.96599999815226 + var_54_15 + arg_54_0 and not isNil(var_54_14) and arg_51_1.var_.characterEffect1084ui_story then
				arg_51_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				arg_51_1.fswbg_:SetActive(true)
				arg_51_1.dialog_:SetActive(false)

				arg_51_1.fswtw_.percent = 0
				arg_51_1.fswt_.text = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(122102012).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.fswt_)

				arg_51_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_51_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_51_1.fswtw_:SetDirty()

				arg_51_1.typewritterCharCountI18N = 0

				SetActive(arg_51_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_16 = 4

			if 4 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.var_.oldValueTypewriter = arg_51_1.fswtw_.percent

				SetActive(arg_51_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_17 = 40
			local var_54_18 = 1.6
			local var_54_19, var_54_20 = arg_51_1:GetPercentByPara(arg_51_1:FormatText(arg_51_1:GetWordFromCfg(122102012).content), 1)

			if var_54_16 < arg_51_1.time_ and arg_51_1.time_ <= var_54_16 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0

				local var_54_21 = var_54_17 <= 0 and var_54_18 or var_54_18 * ((var_54_20 - arg_51_1.typewritterCharCountI18N) / var_54_17)

				if (var_54_17 <= 0 and var_54_18 or var_54_18 * ((var_54_20 - arg_51_1.typewritterCharCountI18N) / var_54_17)) > 0 and var_54_18 < var_54_21 then
					arg_51_1.talkMaxDuration = var_54_21

					if var_54_21 + var_54_16 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_21 + var_54_16
					end
				end
			end

			local var_54_22 = math.max(1.6, arg_51_1.talkMaxDuration)

			if var_54_16 <= arg_51_1.time_ and arg_51_1.time_ < var_54_16 + var_54_22 then
				arg_51_1.fswtw_.percent = Mathf.Lerp(arg_51_1.var_.oldValueTypewriter, var_54_19, (arg_51_1.time_ - var_54_16) / var_54_22)
				arg_51_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_51_1.fswtw_:SetDirty()
			end

			if arg_51_1.time_ >= var_54_16 + var_54_22 and arg_51_1.time_ < var_54_16 + var_54_22 + arg_54_0 then
				arg_51_1.fswtw_.percent = var_54_19

				arg_51_1.fswtw_:SetDirty()
				arg_51_1:ShowNextGo(true)

				arg_51_1.typewritterCharCountI18N = var_54_20
			end

			if 2 < arg_51_1.time_ and arg_51_1.time_ <= 2 + arg_54_0 then
				local var_54_23 = arg_51_1.fswbg_.transform:Find("textbox/adapt/content") or arg_51_1.fswbg_.transform:Find("textbox/content")
				local var_54_24 = arg_51_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_54_25 = var_54_23:GetComponent("RectTransform")

				var_54_23:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_54_25.offsetMin = Vector2.New(0, 0)
				var_54_25.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_51_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_51_1:InitPlayNodeList()
	end,
	Play122102013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 122102013
		arg_55_1.duration_ = 2.6

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play122102014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.fswbg_:SetActive(true)
				arg_55_1.dialog_:SetActive(false)

				arg_55_1.fswtw_.percent = 0
				arg_55_1.fswt_.text = arg_55_1:FormatText(arg_55_1:GetWordFromCfg(122102013).content)

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.fswt_)

				arg_55_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)
				arg_55_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image").enabled = false

				arg_55_1.fswtw_:SetDirty()

				arg_55_1.typewritterCharCountI18N = 0

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_0 = 0.0166666666666667

			if 0.0166666666666667 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.var_.oldValueTypewriter = arg_55_1.fswtw_.percent

				SetActive(arg_55_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_55_1:ShowNextGo(false)
			end

			local var_58_1 = 24
			local var_58_2 = 1.6
			local var_58_3, var_58_4 = arg_55_1:GetPercentByPara(arg_55_1:FormatText(arg_55_1:GetWordFromCfg(122102013).content), 1)

			if var_58_0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_0 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0

				local var_58_5 = var_58_1 <= 0 and var_58_2 or var_58_2 * ((var_58_4 - arg_55_1.typewritterCharCountI18N) / var_58_1)

				if (var_58_1 <= 0 and var_58_2 or var_58_2 * ((var_58_4 - arg_55_1.typewritterCharCountI18N) / var_58_1)) > 0 and var_58_2 < var_58_5 then
					arg_55_1.talkMaxDuration = var_58_5

					if var_58_5 + var_58_0 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_5 + var_58_0
					end
				end
			end

			local var_58_6 = math.max(1.6, arg_55_1.talkMaxDuration)

			if var_58_0 <= arg_55_1.time_ and arg_55_1.time_ < var_58_0 + var_58_6 then
				arg_55_1.fswtw_.percent = Mathf.Lerp(arg_55_1.var_.oldValueTypewriter, var_58_3, (arg_55_1.time_ - var_58_0) / var_58_6)
				arg_55_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_55_1.fswtw_:SetDirty()
			end

			if arg_55_1.time_ >= var_58_0 + var_58_6 and arg_55_1.time_ < var_58_0 + var_58_6 + arg_58_0 then
				arg_55_1.fswtw_.percent = var_58_3

				arg_55_1.fswtw_:SetDirty()
				arg_55_1:ShowNextGo(true)

				arg_55_1.typewritterCharCountI18N = var_58_4
			end

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				local var_58_7 = arg_55_1.fswbg_.transform:Find("textbox/adapt/content") or arg_55_1.fswbg_.transform:Find("textbox/content")
				local var_58_8 = arg_55_1.fswbg_.transform:Find("textbox/bg"):GetComponent("Image")
				local var_58_9 = var_58_7:GetComponent("RectTransform")

				var_58_7:GetComponent("Text").alignment = UnityEngine.TextAnchor.MiddleCenter
				var_58_9.offsetMin = Vector2.New(0, 0)
				var_58_9.offsetMax = Vector2.New(0, 0)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play122102014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 122102014
		arg_59_1.duration_ = 5.93

		local var_59_0 = {
			ja = 5.933,
			ko = 4.133,
			zh = 4.133
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
				arg_59_0:Play122102015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				local var_62_0 = arg_59_1.bgs_.A03

				arg_59_1.bgs_.A03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_62_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_62_1 = var_62_0:GetComponent("SpriteRenderer")

				if var_62_1 and var_62_1.sprite then
					local var_62_2 = 2 * (var_62_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_62_0.transform.localScale = Vector3.New(var_62_2 / var_62_1.sprite.bounds.size.y < var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x and var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x or var_62_2 / var_62_1.sprite.bounds.size.y, var_62_2 / var_62_1.sprite.bounds.size.y < var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x and var_62_2 * manager.ui.mainCameraCom_.aspect / var_62_1.sprite.bounds.size.x or var_62_2 / var_62_1.sprite.bounds.size.y, 0)
				end

				for iter_62_0, iter_62_1 in pairs(arg_59_1.bgs_) do
					if iter_62_0 ~= "A03" then
						iter_62_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_62_3 = 0

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.mask_.enabled = true
				arg_59_1.mask_.raycastTarget = true

				arg_59_1:SetGaussion(false)
			end

			local var_62_4 = 2

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_4 then
				local var_62_5 = Color.New(0, 0, 0)

				var_62_5.a = Mathf.Lerp(1, 0, (arg_59_1.time_ - var_62_3) / var_62_4)
				arg_59_1.mask_.color = var_62_5
			end

			if arg_59_1.time_ >= var_62_3 + var_62_4 and arg_59_1.time_ < var_62_3 + var_62_4 + arg_62_0 then
				local var_62_6 = Color.New(0, 0, 0)

				arg_59_1.mask_.enabled = false
				var_62_6.a = 0
				arg_59_1.mask_.color = var_62_6
			end

			local var_62_7 = arg_59_1.actors_["1084ui_story"].transform

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 then
				arg_59_1.var_.moveOldPos1084ui_story = var_62_7.localPosition
			end

			local var_62_8 = 0.001

			if 2 <= arg_59_1.time_ and arg_59_1.time_ < 2 + var_62_8 then
				var_62_7.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_59_1.time_ - 2) / var_62_8)
				var_62_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_7.position).x, (manager.ui.mainCamera.transform.position - var_62_7.position).y, (manager.ui.mainCamera.transform.position - var_62_7.position).z)
				var_62_7.localEulerAngles.z = 0
				var_62_7.localEulerAngles.x = 0
				var_62_7.localEulerAngles = var_62_7.localEulerAngles
			end

			if arg_59_1.time_ >= 2 + var_62_8 and arg_59_1.time_ < 2 + var_62_8 + arg_62_0 then
				var_62_7.localPosition = Vector3.New(0, -0.97, -6)
				var_62_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_7.position).x, (manager.ui.mainCamera.transform.position - var_62_7.position).y, (manager.ui.mainCamera.transform.position - var_62_7.position).z)
				var_62_7.localEulerAngles.z = 0
				var_62_7.localEulerAngles.x = 0
				var_62_7.localEulerAngles = var_62_7.localEulerAngles
			end

			local var_62_9 = arg_59_1.actors_["1084ui_story"]

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1084ui_story == nil then
				arg_59_1.var_.characterEffect1084ui_story = var_62_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_10 = 0.200000002980232

			if 2 <= arg_59_1.time_ and arg_59_1.time_ < 2 + var_62_10 and not isNil(var_62_9) then
				if arg_59_1.var_.characterEffect1084ui_story and not isNil(var_62_9) then
					arg_59_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 2 + var_62_10 and arg_59_1.time_ < 2 + var_62_10 + arg_62_0 and not isNil(var_62_9) and arg_59_1.var_.characterEffect1084ui_story then
				arg_59_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 then
				arg_59_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= 2 + arg_62_0 then
				arg_59_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.fswbg_:SetActive(false)
				arg_59_1.dialog_:SetActive(false)
				SetActive(arg_59_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, true)
				arg_59_1:ShowNextGo(false)
			end

			if arg_59_1.frameCnt_ <= 1 then
				arg_59_1.dialog_:SetActive(false)
			end

			local var_62_12 = 2
			local var_62_13 = 0.275

			if 2 < arg_59_1.time_ and arg_59_1.time_ <= var_62_12 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0

				arg_59_1.dialog_:SetActive(true)

				arg_59_1.dialogCg_.alpha = 0

				local var_62_14 = LeanTween.value(arg_59_1.dialog_, 0, 1, 0.3)

				var_62_14:setOnUpdate(LuaHelper.FloatAction(function(arg_63_0)
					arg_59_1.dialogCg_.alpha = arg_63_0
				end))
				var_62_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_59_1.dialog_)
					var_62_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_59_1.duration_ = arg_59_1.duration_ + 0.3

				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_15 = arg_59_1:GetWordFromCfg(122102014)
				local var_62_16 = arg_59_1:FormatText(var_62_15.content)

				arg_59_1.text_.text = var_62_16

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_18 = 11 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_16) / 11)

				if (11 <= 0 and var_62_13 or var_62_13 * (utf8.len(var_62_16) / 11)) > 0 and var_62_13 < var_62_18 then
					arg_59_1.talkMaxDuration = var_62_18
					var_62_12 = var_62_12 + 0.3

					if var_62_18 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_18 + var_62_12
					end
				end

				arg_59_1.text_.text = var_62_16
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102014", "story_v_out_122102.awb") ~= 0 then
					local var_62_19 = manager.audio:GetVoiceLength("story_v_out_122102", "122102014", "story_v_out_122102.awb") / 1000

					if var_62_19 + var_62_12 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_19 + var_62_12
					end

					if var_62_15.prefab_name ~= "" and arg_59_1.actors_[var_62_15.prefab_name] ~= nil then
						local var_62_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_15.prefab_name].transform, "story_v_out_122102", "122102014", "story_v_out_122102.awb")

						arg_59_1:RecordAudio("122102014", var_62_20)
						arg_59_1:RecordAudio("122102014", var_62_20)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_122102", "122102014", "story_v_out_122102.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_122102", "122102014", "story_v_out_122102.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_21 = var_62_12 + 0.3
			local var_62_22 = math.max(var_62_13, arg_59_1.talkMaxDuration)

			if var_62_12 + 0.3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_21 + var_62_22 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_21) / var_62_22

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_21 + var_62_22 and arg_59_1.time_ < var_62_21 + var_62_22 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
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

		arg_59_1:InitPlayNodeList()
	end,
	Play122102015 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 122102015
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play122102016(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story == nil then
				arg_65_1.var_.characterEffect1084ui_story = arg_65_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) then
				if arg_65_1.var_.characterEffect1084ui_story and not isNil(arg_65_1.actors_["1084ui_story"]) then
					arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_0)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["1084ui_story"]) and arg_65_1.var_.characterEffect1084ui_story then
				arg_65_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_68_1 = 0
			local var_68_2 = 0.35

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_1 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, true)
				arg_65_1.iconController_:SetSelectedState("hero")

				arg_65_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_65_1.callingController_:SetSelectedState("normal")

				arg_65_1.keyicon_.color = Color.New(1, 1, 1)
				arg_65_1.icon_.color = Color.New(1, 1, 1)

				local var_68_3 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(122102015).content)

				arg_65_1.text_.text = var_68_3

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_5 = 14 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 14)

				if (14 <= 0 and var_68_2 or var_68_2 * (utf8.len(var_68_3) / 14)) > 0 and var_68_2 < var_68_5 then
					arg_65_1.talkMaxDuration = var_68_5

					if var_68_5 + var_68_1 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_5 + var_68_1
					end
				end

				arg_65_1.text_.text = var_68_3
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_6 = math.max(var_68_2, arg_65_1.talkMaxDuration)

			if var_68_1 <= arg_65_1.time_ and arg_65_1.time_ < var_68_1 + var_68_6 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_1) / var_68_6

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_1 + var_68_6 and arg_65_1.time_ < var_68_1 + var_68_6 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play122102016 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 122102016
		arg_69_1.duration_ = 7.73

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play122102017(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_0 = 1.5

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 then
				local var_72_1 = Color.New(0, 0, 0)

				var_72_1.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - 0) / var_72_0)
				arg_69_1.mask_.color = var_72_1
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 then
				local var_72_2 = Color.New(0, 0, 0)

				var_72_2.a = 1
				arg_69_1.mask_.color = var_72_2
			end

			local var_72_3 = 1.5

			if 1.5 < arg_69_1.time_ and arg_69_1.time_ <= var_72_3 + arg_72_0 then
				arg_69_1.mask_.enabled = true
				arg_69_1.mask_.raycastTarget = true

				arg_69_1:SetGaussion(false)
			end

			local var_72_4 = 1.533333

			if var_72_3 <= arg_69_1.time_ and arg_69_1.time_ < var_72_3 + var_72_4 then
				local var_72_5 = Color.New(0, 0, 0)

				var_72_5.a = Mathf.Lerp(1, 0, (arg_69_1.time_ - var_72_3) / var_72_4)
				arg_69_1.mask_.color = var_72_5
			end

			if arg_69_1.time_ >= var_72_3 + var_72_4 and arg_69_1.time_ < var_72_3 + var_72_4 + arg_72_0 then
				local var_72_6 = Color.New(0, 0, 0)

				arg_69_1.mask_.enabled = false
				var_72_6.a = 0
				arg_69_1.mask_.color = var_72_6
			end

			local var_72_7 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_7 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_7 + 2.36666666666667 and arg_69_1.time_ < var_72_7 + 2.36666666666667 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_8 = arg_69_1.actors_["1084ui_story"].transform

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1.var_.moveOldPos1084ui_story = var_72_8.localPosition
			end

			local var_72_9 = 0.001

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_9 then
				var_72_8.localPosition = Vector3.Lerp(arg_69_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_69_1.time_ - 0) / var_72_9)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			if arg_69_1.time_ >= 0 + var_72_9 and arg_69_1.time_ < 0 + var_72_9 + arg_72_0 then
				var_72_8.localPosition = Vector3.New(0, 100, 0)
				var_72_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_72_8.position).x, (manager.ui.mainCamera.transform.position - var_72_8.position).y, (manager.ui.mainCamera.transform.position - var_72_8.position).z)
				var_72_8.localEulerAngles.z = 0
				var_72_8.localEulerAngles.x = 0
				var_72_8.localEulerAngles = var_72_8.localEulerAngles
			end

			local var_72_10 = "A03_blur"

			if arg_69_1.bgs_.A03_blur == nil then
				local var_72_11 = Object.Instantiate(arg_69_1.blurPaintGo_)

				var_72_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_72_10)
				var_72_11.name = var_72_10
				var_72_11.transform.parent = arg_69_1.stage_.transform
				var_72_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_69_1.bgs_[var_72_10] = var_72_11
			end

			local var_72_12 = 0
			local var_72_13 = arg_69_1.bgs_[var_72_10]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_12 + arg_72_0 then
				var_72_13.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_72_13.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_72_14 = var_72_13:GetComponent("SpriteRenderer")

				if var_72_14 and var_72_14.sprite then
					local var_72_15 = 2 * (var_72_13.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_72_13.transform.localScale = Vector3.New(var_72_15 / var_72_14.sprite.bounds.size.y < var_72_15 * manager.ui.mainCameraCom_.aspect / var_72_14.sprite.bounds.size.x and var_72_15 * manager.ui.mainCameraCom_.aspect / var_72_14.sprite.bounds.size.x or var_72_15 / var_72_14.sprite.bounds.size.y, var_72_15 / var_72_14.sprite.bounds.size.y < var_72_15 * manager.ui.mainCameraCom_.aspect / var_72_14.sprite.bounds.size.x and var_72_15 * manager.ui.mainCameraCom_.aspect / var_72_14.sprite.bounds.size.x or var_72_15 / var_72_14.sprite.bounds.size.y, 0)
				end
			end

			local var_72_16 = 3.36666666666667

			if var_72_12 <= arg_69_1.time_ and arg_69_1.time_ < var_72_12 + var_72_16 then
				local var_72_17 = Color.New(1, 1, 1)

				var_72_17.a = Mathf.Lerp(0, 1, (arg_69_1.time_ - var_72_12) / var_72_16)

				var_72_13:GetComponent("SpriteRenderer").material:SetColor("_Color", var_72_17)
			end

			local var_72_18 = 0

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_18 + arg_72_0 then
				arg_69_1.allBtn_.enabled = false
			end

			if arg_69_1.time_ >= var_72_18 + 3.36666666666667 and arg_69_1.time_ < var_72_18 + 3.36666666666667 + arg_72_0 then
				arg_69_1.allBtn_.enabled = true
			end

			local var_72_19 = 2.733333
			local var_72_20 = 0.3

			if 2.733333 < arg_69_1.time_ and arg_69_1.time_ <= var_72_19 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, true)
				arg_69_1.iconController_:SetSelectedState("hero")

				arg_69_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_69_1.callingController_:SetSelectedState("normal")

				arg_69_1.keyicon_.color = Color.New(1, 1, 1)
				arg_69_1.icon_.color = Color.New(1, 1, 1)

				local var_72_21 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(122102016).content)

				arg_69_1.text_.text = var_72_21

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_23 = 12 <= 0 and var_72_20 or var_72_20 * (utf8.len(var_72_21) / 12)

				if (12 <= 0 and var_72_20 or var_72_20 * (utf8.len(var_72_21) / 12)) > 0 and var_72_20 < var_72_23 then
					arg_69_1.talkMaxDuration = var_72_23

					if var_72_23 + var_72_19 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_23 + var_72_19
					end
				end

				arg_69_1.text_.text = var_72_21
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_24 = math.max(var_72_20, arg_69_1.talkMaxDuration)

			if var_72_19 <= arg_69_1.time_ and arg_69_1.time_ < var_72_19 + var_72_24 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_19) / var_72_24

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_19 + var_72_24 and arg_69_1.time_ < var_72_19 + var_72_24 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {
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

		arg_69_1:InitPlayNodeList()
	end,
	Play122102017 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 122102017
		arg_73_1.duration_ = 5.43

		local var_73_0 = {
			ja = 5.433,
			ko = 4.8,
			zh = 4.8
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
				arg_73_0:Play122102018(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			local var_76_0 = 0.575

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, true)

				arg_73_1.leftNameTxt_.text = arg_73_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_73_1.leftNameTxt_.transform)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1.leftNameTxt_.text)
				SetActive(arg_73_1.iconTrs_.gameObject, true)
				arg_73_1.iconController_:SetSelectedState("hero")

				arg_73_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_73_1.callingController_:SetSelectedState("normal")

				arg_73_1.keyicon_.color = Color.New(1, 1, 1)
				arg_73_1.icon_.color = Color.New(1, 1, 1)

				local var_76_1 = arg_73_1:GetWordFromCfg(122102017)
				local var_76_2 = arg_73_1:FormatText(var_76_1.content)

				arg_73_1.text_.text = var_76_2

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_4 = 23 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 23)

				if (23 <= 0 and var_76_0 or var_76_0 * (utf8.len(var_76_2) / 23)) > 0 and var_76_0 < var_76_4 then
					arg_73_1.talkMaxDuration = var_76_4

					if var_76_4 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_4 + 0
					end
				end

				arg_73_1.text_.text = var_76_2
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102017", "story_v_out_122102.awb") ~= 0 then
					local var_76_5 = manager.audio:GetVoiceLength("story_v_out_122102", "122102017", "story_v_out_122102.awb") / 1000

					if var_76_5 + 0 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + 0
					end

					if var_76_1.prefab_name ~= "" and arg_73_1.actors_[var_76_1.prefab_name] ~= nil then
						local var_76_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_73_1.actors_[var_76_1.prefab_name].transform, "story_v_out_122102", "122102017", "story_v_out_122102.awb")

						arg_73_1:RecordAudio("122102017", var_76_6)
						arg_73_1:RecordAudio("122102017", var_76_6)
					else
						arg_73_1:AudioAction("play", "voice", "story_v_out_122102", "122102017", "story_v_out_122102.awb")
					end

					arg_73_1:RecordHistoryTalkVoice("story_v_out_122102", "122102017", "story_v_out_122102.awb")
				end

				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_7 = math.max(var_76_0, arg_73_1.talkMaxDuration)

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_7 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - 0) / var_76_7

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= 0 + var_76_7 and arg_73_1.time_ < 0 + var_76_7 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play122102018 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 122102018
		arg_77_1.duration_ = 5.03

		local var_77_0 = {
			ja = 5.033,
			ko = 4.333,
			zh = 4.333
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
				arg_77_0:Play122102019(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			local var_80_0 = 0.55

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[445].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, true)
				arg_77_1.iconController_:SetSelectedState("hero")

				arg_77_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_77_1.callingController_:SetSelectedState("normal")

				arg_77_1.keyicon_.color = Color.New(1, 1, 1)
				arg_77_1.icon_.color = Color.New(1, 1, 1)

				local var_80_1 = arg_77_1:GetWordFromCfg(122102018)
				local var_80_2 = arg_77_1:FormatText(var_80_1.content)

				arg_77_1.text_.text = var_80_2

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_4 = 22 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 22)

				if (22 <= 0 and var_80_0 or var_80_0 * (utf8.len(var_80_2) / 22)) > 0 and var_80_0 < var_80_4 then
					arg_77_1.talkMaxDuration = var_80_4

					if var_80_4 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_4 + 0
					end
				end

				arg_77_1.text_.text = var_80_2
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_122102", "122102018", "story_v_out_122102.awb") ~= 0 then
					local var_80_5 = manager.audio:GetVoiceLength("story_v_out_122102", "122102018", "story_v_out_122102.awb") / 1000

					if var_80_5 + 0 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_5 + 0
					end

					if var_80_1.prefab_name ~= "" and arg_77_1.actors_[var_80_1.prefab_name] ~= nil then
						local var_80_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_77_1.actors_[var_80_1.prefab_name].transform, "story_v_out_122102", "122102018", "story_v_out_122102.awb")

						arg_77_1:RecordAudio("122102018", var_80_6)
						arg_77_1:RecordAudio("122102018", var_80_6)
					else
						arg_77_1:AudioAction("play", "voice", "story_v_out_122102", "122102018", "story_v_out_122102.awb")
					end

					arg_77_1:RecordHistoryTalkVoice("story_v_out_122102", "122102018", "story_v_out_122102.awb")
				end

				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_0, arg_77_1.talkMaxDuration)

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - 0) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= 0 + var_80_7 and arg_77_1.time_ < 0 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play122102019 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 122102019
		arg_81_1.duration_ = 9

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
			arg_81_1.auto_ = false
		end

		function arg_81_1.playNext_(arg_83_0)
			arg_81_1.onStoryFinished_()
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 2 < arg_81_1.time_ and arg_81_1.time_ <= 2 + arg_84_0 then
				local var_84_0 = arg_81_1.bgs_.STblack

				arg_81_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_84_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_84_1 = var_84_0:GetComponent("SpriteRenderer")

				if var_84_1 and var_84_1.sprite then
					local var_84_2 = 2 * (var_84_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_84_0.transform.localScale = Vector3.New(var_84_2 / var_84_1.sprite.bounds.size.y < var_84_2 * manager.ui.mainCameraCom_.aspect / var_84_1.sprite.bounds.size.x and var_84_2 * manager.ui.mainCameraCom_.aspect / var_84_1.sprite.bounds.size.x or var_84_2 / var_84_1.sprite.bounds.size.y, var_84_2 / var_84_1.sprite.bounds.size.y < var_84_2 * manager.ui.mainCameraCom_.aspect / var_84_1.sprite.bounds.size.x and var_84_2 * manager.ui.mainCameraCom_.aspect / var_84_1.sprite.bounds.size.x or var_84_2 / var_84_1.sprite.bounds.size.y, 0)
				end

				for iter_84_0, iter_84_1 in pairs(arg_81_1.bgs_) do
					if iter_84_0 ~= "STblack" then
						iter_84_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_84_3 = 0

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_3 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_4 = 2

			if var_84_3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_3 + var_84_4 then
				local var_84_5 = Color.New(0, 0, 0)

				var_84_5.a = Mathf.Lerp(0, 1, (arg_81_1.time_ - var_84_3) / var_84_4)
				arg_81_1.mask_.color = var_84_5
			end

			if arg_81_1.time_ >= var_84_3 + var_84_4 and arg_81_1.time_ < var_84_3 + var_84_4 + arg_84_0 then
				local var_84_6 = Color.New(0, 0, 0)

				var_84_6.a = 1
				arg_81_1.mask_.color = var_84_6
			end

			local var_84_7 = 2

			if 2 < arg_81_1.time_ and arg_81_1.time_ <= var_84_7 + arg_84_0 then
				arg_81_1.mask_.enabled = true
				arg_81_1.mask_.raycastTarget = true

				arg_81_1:SetGaussion(false)
			end

			local var_84_8 = 2

			if var_84_7 <= arg_81_1.time_ and arg_81_1.time_ < var_84_7 + var_84_8 then
				local var_84_9 = Color.New(0, 0, 0)

				var_84_9.a = Mathf.Lerp(1, 0, (arg_81_1.time_ - var_84_7) / var_84_8)
				arg_81_1.mask_.color = var_84_9
			end

			if arg_81_1.time_ >= var_84_7 + var_84_8 and arg_81_1.time_ < var_84_7 + var_84_8 + arg_84_0 then
				local var_84_10 = Color.New(0, 0, 0)

				arg_81_1.mask_.enabled = false
				var_84_10.a = 0
				arg_81_1.mask_.color = var_84_10
			end

			if arg_81_1.frameCnt_ <= 1 then
				arg_81_1.dialog_:SetActive(false)
			end

			local var_84_11 = 4
			local var_84_12 = 1.175

			if 4 < arg_81_1.time_ and arg_81_1.time_ <= var_84_11 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0

				arg_81_1.dialog_:SetActive(true)

				arg_81_1.dialogCg_.alpha = 0

				local var_84_13 = LeanTween.value(arg_81_1.dialog_, 0, 1, 0.3)

				var_84_13:setOnUpdate(LuaHelper.FloatAction(function(arg_85_0)
					arg_81_1.dialogCg_.alpha = arg_85_0
				end))
				var_84_13:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_81_1.dialog_)
					var_84_13:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_81_1.duration_ = arg_81_1.duration_ + 0.3

				SetActive(arg_81_1.leftNameGo_, false)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_14 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(122102019).content)

				arg_81_1.text_.text = var_84_14

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_16 = 47 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 47)

				if (47 <= 0 and var_84_12 or var_84_12 * (utf8.len(var_84_14) / 47)) > 0 and var_84_12 < var_84_16 then
					arg_81_1.talkMaxDuration = var_84_16
					var_84_11 = var_84_11 + 0.3

					if var_84_16 + var_84_11 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_16 + var_84_11
					end
				end

				arg_81_1.text_.text = var_84_14
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_17 = var_84_11 + 0.3
			local var_84_18 = math.max(var_84_12, arg_81_1.talkMaxDuration)

			if var_84_11 + 0.3 <= arg_81_1.time_ and arg_81_1.time_ < var_84_17 + var_84_18 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_17) / var_84_18

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_17 + var_84_18 and arg_81_1.time_ < var_84_17 + var_84_18 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/A03",
		"TextureConfig/Background/STblack"
	},
	voices = {
		"story_v_out_122102.awb"
	}
}
