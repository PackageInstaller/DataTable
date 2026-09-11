return {
	Play104112001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104112001
		arg_1_1.duration_ = 11.97

		local var_1_0 = {
			ja = 11.966,
			ko = 9.7,
			zh = 8.433,
			en = 8.633
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
				arg_1_0:Play104112002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_2 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_2

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_2
						arg_1_1.bgmTxt2_.text = var_4_2
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

			local var_4_3 = "1148ui_story"

			if arg_1_1.actors_["1148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1148ui_story"))) then
				local var_4_4 = Object.Instantiate(Asset.Load("Char/" .. "1148ui_story"), arg_1_1.stage_.transform)

				var_4_4.name = var_4_3
				var_4_4.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_3] = var_4_4

				local var_4_5 = var_4_4:GetComponentInChildren(typeof(CharacterEffect))

				var_4_5.enabled = true

				local var_4_6 = GameObjectTools.GetOrAddComponent(var_4_4, typeof(DynamicBoneHelper))

				if var_4_6 then
					var_4_6:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_5.transform, false)

				arg_1_1.var_[var_4_3 .. "Animator"] = var_4_5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_3 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_3 .. "LipSync"] = var_4_5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_7 = arg_1_1.actors_["1148ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1148ui_story == nil then
				arg_1_1.var_.characterEffect1148ui_story = var_4_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_8 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_8 and not isNil(var_4_7) then
				if arg_1_1.var_.characterEffect1148ui_story and not isNil(var_4_7) then
					arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_8 and arg_1_1.time_ < 2 + var_4_8 + arg_4_0 and not isNil(var_4_7) and arg_1_1.var_.characterEffect1148ui_story then
				arg_1_1.var_.characterEffect1148ui_story.fillFlat = false
			end

			local var_4_10 = "B14"

			if arg_1_1.bgs_.B14 == nil then
				local var_4_11 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_11:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_10)
				var_4_11.name = var_4_10
				var_4_11.transform.parent = arg_1_1.stage_.transform
				var_4_11.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_10] = var_4_11
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_12 = arg_1_1.bgs_.B14:GetComponent("SpriteRenderer")

				if var_4_12 then
					arg_1_1.var_.alphaOldValueB14 = var_4_12.color.a
					arg_1_1.var_.alphaMatValueB14 = var_4_12
				end

				arg_1_1.var_.alphaOldValueB14 = 0
			end

			local var_4_13 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_13 then
				if arg_1_1.var_.alphaMatValueB14 then
					arg_1_1.var_.alphaMatValueB14.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB14, 1, (arg_1_1.time_ - 0) / var_4_13)
					arg_1_1.var_.alphaMatValueB14.color = arg_1_1.var_.alphaMatValueB14.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_13 and arg_1_1.time_ < 0 + var_4_13 + arg_4_0 and arg_1_1.var_.alphaMatValueB14 then
				arg_1_1.var_.alphaMatValueB14.color.a = 1
				arg_1_1.var_.alphaMatValueB14.color = arg_1_1.var_.alphaMatValueB14.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_14 = arg_1_1.bgs_.B14

				arg_1_1.bgs_.B14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_14.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_15 = var_4_14:GetComponent("SpriteRenderer")

				if var_4_15 and var_4_15.sprite then
					local var_4_16 = 2 * (var_4_14.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_14.transform.localScale = Vector3.New(var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, var_4_16 / var_4_15.sprite.bounds.size.y < var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x and var_4_16 * manager.ui.mainCameraCom_.aspect / var_4_15.sprite.bounds.size.x or var_4_16 / var_4_15.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B14" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_17 = arg_1_1.actors_["1148ui_story"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos1148ui_story = var_4_17.localPosition
			end

			local var_4_18 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_18 then
				var_4_17.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (arg_1_1.time_ - 1.79999995231628) / var_4_18)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_18 and arg_1_1.time_ < 1.79999995231628 + var_4_18 + arg_4_0 then
				var_4_17.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				var_4_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_17.position).x, (manager.ui.mainCamera.transform.position - var_4_17.position).y, (manager.ui.mainCamera.transform.position - var_4_17.position).z)
				var_4_17.localEulerAngles.z = 0
				var_4_17.localEulerAngles.x = 0
				var_4_17.localEulerAngles = var_4_17.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/story1148/story1148action/1148action5_1")
			end

			local var_4_19 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_19 + 2 and arg_1_1.time_ < var_4_19 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_20 = 2
			local var_4_21 = 0.875

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:GetWordFromCfg(104112001)
				local var_4_24 = arg_1_1:FormatText(var_4_23.content)

				arg_1_1.text_.text = var_4_24

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_26 = 35 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 35)

				if (35 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_24) / 35)) > 0 and var_4_21 < var_4_26 then
					arg_1_1.talkMaxDuration = var_4_26
					var_4_20 = var_4_20 + 0.3

					if var_4_26 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_26 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_24
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112001", "story_v_out_104112.awb") ~= 0 then
					local var_4_27 = manager.audio:GetVoiceLength("story_v_out_104112", "104112001", "story_v_out_104112.awb") / 1000

					if var_4_27 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_20
					end

					if var_4_23.prefab_name ~= "" and arg_1_1.actors_[var_4_23.prefab_name] ~= nil then
						local var_4_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_23.prefab_name].transform, "story_v_out_104112", "104112001", "story_v_out_104112.awb")

						arg_1_1:RecordAudio("104112001", var_4_28)
						arg_1_1:RecordAudio("104112001", var_4_28)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104112", "104112001", "story_v_out_104112.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104112", "104112001", "story_v_out_104112.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_29 = var_4_20 + 0.3
			local var_4_30 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_29 + var_4_30 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_29) / var_4_30

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_29 + var_4_30 and arg_1_1.time_ < var_4_29 + var_4_30 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play104112002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104112002
		arg_8_1.duration_ = 10.4

		local var_8_0 = {
			ja = 8.533,
			ko = 7,
			zh = 10.4,
			en = 8.7
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
				arg_8_0:Play104112003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1059ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1059ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1059ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1059ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1059ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1059ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1059ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1059ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1059ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1059ui_story == nil then
				arg_8_1.var_.characterEffect1059ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1059ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1059ui_story then
				arg_8_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1148ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1148ui_story == nil then
				arg_8_1.var_.characterEffect1148ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect1148ui_story and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1148ui_story then
				arg_8_1.var_.characterEffect1148ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			local var_11_8 = arg_8_1.actors_["1059ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1059ui_story = var_11_8.localPosition
			end

			local var_11_9 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (arg_8_1.time_ - 0) / var_11_9)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0.7, -1.05, -6)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action3_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			local var_11_10 = 0
			local var_11_11 = 1

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(104112002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 42 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 42)

				if (42 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 42)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112002", "story_v_out_104112.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112002", "story_v_out_104112.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_104112", "104112002", "story_v_out_104112.awb")

						arg_8_1:RecordAudio("104112002", var_11_17)
						arg_8_1:RecordAudio("104112002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104112", "104112002", "story_v_out_104112.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104112", "104112002", "story_v_out_104112.awb")
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
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_8_1:InitPlayNodeList()
	end,
	Play104112003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104112003
		arg_12_1.duration_ = 11.57

		local var_12_0 = {
			ja = 11.566,
			ko = 9.766,
			zh = 11.1,
			en = 10.433
		}
		local var_12_1 = manager.audio:GetLocalizationFlag()

		if var_12_0[var_12_1] ~= nil then
			arg_12_1.duration_ = var_12_0[var_12_1]
		end

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play104112004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059actionlink/1059action434")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_15_0 = 0
			local var_15_1 = 1.175

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(104112003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 46 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_3) / 46)

				if (46 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_3) / 46)) > 0 and var_15_1 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112003", "story_v_out_104112.awb") ~= 0 then
					local var_15_6 = manager.audio:GetVoiceLength("story_v_out_104112", "104112003", "story_v_out_104112.awb") / 1000

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end

					if var_15_2.prefab_name ~= "" and arg_12_1.actors_[var_15_2.prefab_name] ~= nil then
						local var_15_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_2.prefab_name].transform, "story_v_out_104112", "104112003", "story_v_out_104112.awb")

						arg_12_1:RecordAudio("104112003", var_15_7)
						arg_12_1:RecordAudio("104112003", var_15_7)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104112", "104112003", "story_v_out_104112.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104112", "104112003", "story_v_out_104112.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_8 = math.max(var_15_1, arg_12_1.talkMaxDuration)

			if var_15_0 <= arg_12_1.time_ and arg_12_1.time_ < var_15_0 + var_15_8 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_0) / var_15_8

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_0 + var_15_8 and arg_12_1.time_ < var_15_0 + var_15_8 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play104112004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104112004
		arg_16_1.duration_ = 6.3

		local var_16_0 = {
			ja = 6.3,
			ko = 3.8,
			zh = 5.566,
			en = 4.4
		}
		local var_16_1 = manager.audio:GetLocalizationFlag()

		if var_16_0[var_16_1] ~= nil then
			arg_16_1.duration_ = var_16_0[var_16_1]
		end

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104112005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1027ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1027ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1027ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1027ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1027ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1027ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1027ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1027ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1027ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1027ui_story == nil then
				arg_16_1.var_.characterEffect1027ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1027ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1027ui_story then
				arg_16_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1059ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1059ui_story == nil then
				arg_16_1.var_.characterEffect1059ui_story = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect1059ui_story and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_16_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect1059ui_story then
				arg_16_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_16_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["1059ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1059ui_story = var_19_8.localPosition
			end

			local var_19_9 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_9 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_9)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_9 and arg_16_1.time_ < 0 + var_19_9 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, 100, 0)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			local var_19_10 = arg_16_1.actors_["1148ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1148ui_story = var_19_10.localPosition
			end

			local var_19_11 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_11 then
				var_19_10.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_11)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_11 and arg_16_1.time_ < 0 + var_19_11 + arg_19_0 then
				var_19_10.localPosition = Vector3.New(0, 100, 0)
				var_19_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_10.position).x, (manager.ui.mainCamera.transform.position - var_19_10.position).y, (manager.ui.mainCamera.transform.position - var_19_10.position).z)
				var_19_10.localEulerAngles.z = 0
				var_19_10.localEulerAngles.x = 0
				var_19_10.localEulerAngles = var_19_10.localEulerAngles
			end

			local var_19_12 = arg_16_1.actors_["1027ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1027ui_story = var_19_12.localPosition
			end

			local var_19_13 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_13 then
				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_16_1.time_ - 0) / var_19_13)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_13 and arg_16_1.time_ < 0 + var_19_13 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action3_1")
			end

			local var_19_14 = "1080ui_story"

			if arg_16_1.actors_["1080ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1080ui_story"))) then
				local var_19_15 = Object.Instantiate(Asset.Load("Char/" .. "1080ui_story"), arg_16_1.stage_.transform)

				var_19_15.name = var_19_14
				var_19_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_[var_19_14] = var_19_15

				local var_19_16 = var_19_15:GetComponentInChildren(typeof(CharacterEffect))

				var_19_16.enabled = true

				local var_19_17 = GameObjectTools.GetOrAddComponent(var_19_15, typeof(DynamicBoneHelper))

				if var_19_17 then
					var_19_17:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_16.transform, false)

				arg_16_1.var_[var_19_14 .. "Animator"] = var_19_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_[var_19_14 .. "Animator"].applyRootMotion = true
				arg_16_1.var_[var_19_14 .. "LipSync"] = var_19_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/story1080/story1080action/1080action7_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_18 = 0
			local var_19_19 = 0.5

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_18 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_20 = arg_16_1:GetWordFromCfg(104112004)
				local var_19_21 = arg_16_1:FormatText(var_19_20.content)

				arg_16_1.text_.text = var_19_21

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_23 = 20 <= 0 and var_19_19 or var_19_19 * (utf8.len(var_19_21) / 20)

				if (20 <= 0 and var_19_19 or var_19_19 * (utf8.len(var_19_21) / 20)) > 0 and var_19_19 < var_19_23 then
					arg_16_1.talkMaxDuration = var_19_23

					if var_19_23 + var_19_18 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_23 + var_19_18
					end
				end

				arg_16_1.text_.text = var_19_21
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112004", "story_v_out_104112.awb") ~= 0 then
					local var_19_24 = manager.audio:GetVoiceLength("story_v_out_104112", "104112004", "story_v_out_104112.awb") / 1000

					if var_19_24 + var_19_18 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_24 + var_19_18
					end

					if var_19_20.prefab_name ~= "" and arg_16_1.actors_[var_19_20.prefab_name] ~= nil then
						local var_19_25 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_20.prefab_name].transform, "story_v_out_104112", "104112004", "story_v_out_104112.awb")

						arg_16_1:RecordAudio("104112004", var_19_25)
						arg_16_1:RecordAudio("104112004", var_19_25)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104112", "104112004", "story_v_out_104112.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104112", "104112004", "story_v_out_104112.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_26 = math.max(var_19_19, arg_16_1.talkMaxDuration)

			if var_19_18 <= arg_16_1.time_ and arg_16_1.time_ < var_19_18 + var_19_26 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_18) / var_19_26

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_18 + var_19_26 and arg_16_1.time_ < var_19_18 + var_19_26 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_16_1:InitPlayNodeList()
	end,
	Play104112005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104112005
		arg_20_1.duration_ = 8.97

		local var_20_0 = {
			ja = 8.966,
			ko = 6.5,
			zh = 5.233,
			en = 6.066
		}
		local var_20_1 = manager.audio:GetLocalizationFlag()

		if var_20_0[var_20_1] ~= nil then
			arg_20_1.duration_ = var_20_0[var_20_1]
		end

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play104112006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1080ui_story"]) and arg_20_1.var_.characterEffect1080ui_story == nil then
				arg_20_1.var_.characterEffect1080ui_story = arg_20_1.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1080ui_story"]) then
				if arg_20_1.var_.characterEffect1080ui_story and not isNil(arg_20_1.actors_["1080ui_story"]) then
					arg_20_1.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1080ui_story"]) and arg_20_1.var_.characterEffect1080ui_story then
				arg_20_1.var_.characterEffect1080ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1027ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1027ui_story == nil then
				arg_20_1.var_.characterEffect1027ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1027ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1027ui_story then
				arg_20_1.var_.characterEffect1027ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			local var_23_4 = arg_20_1.actors_["1080ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1080ui_story = var_23_4.localPosition
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (arg_20_1.time_ - 0) / var_23_5)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0.7, -1.01, -6.05)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.725

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(104112005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 29 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 29)

				if (29 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 29)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112005", "story_v_out_104112.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_104112", "104112005", "story_v_out_104112.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_104112", "104112005", "story_v_out_104112.awb")

						arg_20_1:RecordAudio("104112005", var_23_13)
						arg_20_1:RecordAudio("104112005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104112", "104112005", "story_v_out_104112.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104112", "104112005", "story_v_out_104112.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_14 = math.max(var_23_7, arg_20_1.talkMaxDuration)

			if var_23_6 <= arg_20_1.time_ and arg_20_1.time_ < var_23_6 + var_23_14 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_6) / var_23_14

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_6 + var_23_14 and arg_20_1.time_ < var_23_6 + var_23_14 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_20_1:InitPlayNodeList()
	end,
	Play104112006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104112006
		arg_24_1.duration_ = 3.8

		local var_24_0 = {
			ja = 3.133,
			ko = 2.7,
			zh = 3.8,
			en = 2.966
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
				arg_24_0:Play104112007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1059ui_story"]) and arg_24_1.var_.characterEffect1059ui_story == nil then
				arg_24_1.var_.characterEffect1059ui_story = arg_24_1.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1059ui_story"]) then
				if arg_24_1.var_.characterEffect1059ui_story and not isNil(arg_24_1.actors_["1059ui_story"]) then
					arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1059ui_story"]) and arg_24_1.var_.characterEffect1059ui_story then
				arg_24_1.var_.characterEffect1059ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1080ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1080ui_story == nil then
				arg_24_1.var_.characterEffect1080ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1080ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1080ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1080ui_story then
				arg_24_1.var_.characterEffect1080ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			local var_27_4 = arg_24_1.actors_["1080ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1080ui_story = var_27_4.localPosition
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_4.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
				var_27_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_4.position).x, (manager.ui.mainCamera.transform.position - var_27_4.position).y, (manager.ui.mainCamera.transform.position - var_27_4.position).z)
				var_27_4.localEulerAngles.z = 0
				var_27_4.localEulerAngles.x = 0
				var_27_4.localEulerAngles = var_27_4.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_5 and arg_24_1.time_ < 0 + var_27_5 + arg_27_0 then
				var_27_4.localPosition = Vector3.New(0, 100, 0)
				var_27_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_4.position).x, (manager.ui.mainCamera.transform.position - var_27_4.position).y, (manager.ui.mainCamera.transform.position - var_27_4.position).z)
				var_27_4.localEulerAngles.z = 0
				var_27_4.localEulerAngles.x = 0
				var_27_4.localEulerAngles = var_27_4.localEulerAngles
			end

			local var_27_6 = arg_24_1.actors_["1027ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1027ui_story = var_27_6.localPosition
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_6.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_7)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_6.localPosition = Vector3.New(0, 100, 0)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			local var_27_8 = arg_24_1.actors_["1059ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1059ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, -1.05, -6)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/story1059/story1059action/1059action4_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			local var_27_10 = 0
			local var_27_11 = 0.475

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(104112006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 19 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 19)

				if (19 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 19)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112006", "story_v_out_104112.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112006", "story_v_out_104112.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_104112", "104112006", "story_v_out_104112.awb")

						arg_24_1:RecordAudio("104112006", var_27_17)
						arg_24_1:RecordAudio("104112006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104112", "104112006", "story_v_out_104112.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104112", "104112006", "story_v_out_104112.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_18 = math.max(var_27_11, arg_24_1.talkMaxDuration)

			if var_27_10 <= arg_24_1.time_ and arg_24_1.time_ < var_27_10 + var_27_18 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_10) / var_27_18

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_10 + var_27_18 and arg_24_1.time_ < var_27_10 + var_27_18 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1080ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play104112007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104112007
		arg_28_1.duration_ = 9.6

		local var_28_0 = {
			ja = 9.6,
			ko = 4.5,
			zh = 4.933,
			en = 4.7
		}
		local var_28_1 = manager.audio:GetLocalizationFlag()

		if var_28_0[var_28_1] ~= nil then
			arg_28_1.duration_ = var_28_0[var_28_1]
		end

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104112008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_31_0 = 0
			local var_31_1 = 0.55

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_0 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_2 = arg_28_1:GetWordFromCfg(104112007)
				local var_31_3 = arg_28_1:FormatText(var_31_2.content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 22 <= 0 and var_31_1 or var_31_1 * (utf8.len(var_31_3) / 22)

				if (22 <= 0 and var_31_1 or var_31_1 * (utf8.len(var_31_3) / 22)) > 0 and var_31_1 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_0
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112007", "story_v_out_104112.awb") ~= 0 then
					local var_31_6 = manager.audio:GetVoiceLength("story_v_out_104112", "104112007", "story_v_out_104112.awb") / 1000

					if var_31_6 + var_31_0 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_6 + var_31_0
					end

					if var_31_2.prefab_name ~= "" and arg_28_1.actors_[var_31_2.prefab_name] ~= nil then
						local var_31_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_2.prefab_name].transform, "story_v_out_104112", "104112007", "story_v_out_104112.awb")

						arg_28_1:RecordAudio("104112007", var_31_7)
						arg_28_1:RecordAudio("104112007", var_31_7)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104112", "104112007", "story_v_out_104112.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104112", "104112007", "story_v_out_104112.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_1, arg_28_1.talkMaxDuration)

			if var_31_0 <= arg_28_1.time_ and arg_28_1.time_ < var_31_0 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_0) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_0 + var_31_8 and arg_28_1.time_ < var_31_0 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {}

		arg_28_1:InitPlayNodeList()
	end,
	Play104112008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104112008
		arg_32_1.duration_ = 3.7

		local var_32_0 = {
			ja = 3.7,
			ko = 2.3,
			zh = 2.533,
			en = 2.333
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
				arg_32_0:Play104112009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_35_1 = "3005_tpose"

			if arg_32_1.actors_["3005_tpose"] == nil and not isNil((Asset.Load("Char/" .. "3005_tpose"))) then
				local var_35_2 = Object.Instantiate(Asset.Load("Char/" .. "3005_tpose"), arg_32_1.stage_.transform)

				var_35_2.name = var_35_1
				var_35_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_[var_35_1] = var_35_2

				local var_35_3 = var_35_2:GetComponentInChildren(typeof(CharacterEffect))

				var_35_3.enabled = true

				local var_35_4 = GameObjectTools.GetOrAddComponent(var_35_2, typeof(DynamicBoneHelper))

				if var_35_4 then
					var_35_4:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_3.transform, false)

				arg_32_1.var_[var_35_1 .. "Animator"] = var_35_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_[var_35_1 .. "Animator"].applyRootMotion = true
				arg_32_1.var_[var_35_1 .. "LipSync"] = var_35_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_5 = arg_32_1.actors_["3005_tpose"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect3005_tpose == nil then
				arg_32_1.var_.characterEffect3005_tpose = var_35_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_6 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 and not isNil(var_35_5) then
				if arg_32_1.var_.characterEffect3005_tpose and not isNil(var_35_5) then
					arg_32_1.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 and not isNil(var_35_5) and arg_32_1.var_.characterEffect3005_tpose then
				arg_32_1.var_.characterEffect3005_tpose.fillFlat = false
			end

			local var_35_8 = arg_32_1.actors_["1059ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.characterEffect1059ui_story == nil then
				arg_32_1.var_.characterEffect1059ui_story = var_35_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_9 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 and not isNil(var_35_8) then
				if arg_32_1.var_.characterEffect1059ui_story and not isNil(var_35_8) then
					arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_9)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 and not isNil(var_35_8) and arg_32_1.var_.characterEffect1059ui_story then
				arg_32_1.var_.characterEffect1059ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			local var_35_10 = arg_32_1.actors_["1059ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1059ui_story = var_35_10.localPosition
			end

			local var_35_11 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 then
				var_35_10.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_11)
				var_35_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_10.position).x, (manager.ui.mainCamera.transform.position - var_35_10.position).y, (manager.ui.mainCamera.transform.position - var_35_10.position).z)
				var_35_10.localEulerAngles.z = 0
				var_35_10.localEulerAngles.x = 0
				var_35_10.localEulerAngles = var_35_10.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 then
				var_35_10.localPosition = Vector3.New(0, 100, 0)
				var_35_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_10.position).x, (manager.ui.mainCamera.transform.position - var_35_10.position).y, (manager.ui.mainCamera.transform.position - var_35_10.position).z)
				var_35_10.localEulerAngles.z = 0
				var_35_10.localEulerAngles.x = 0
				var_35_10.localEulerAngles = var_35_10.localEulerAngles
			end

			local var_35_12 = arg_32_1.actors_["3005_tpose"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos3005_tpose = var_35_12.localPosition

				local var_35_13 = GameObjectTools.GetOrAddComponent(var_35_12.gameObject, typeof(DynamicBoneHelper))

				if var_35_13 then
					var_35_13:EnableDynamicBone(false)
				end
			end

			local var_35_14 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_14 then
				var_35_12.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos3005_tpose, Vector3.New(0, -1.95, -2.63), (arg_32_1.time_ - 0) / var_35_14)
				var_35_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_12.position).x, (manager.ui.mainCamera.transform.position - var_35_12.position).y, (manager.ui.mainCamera.transform.position - var_35_12.position).z)
				var_35_12.localEulerAngles.z = 0
				var_35_12.localEulerAngles.x = 0
				var_35_12.localEulerAngles = var_35_12.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_14 and arg_32_1.time_ < 0 + var_35_14 + arg_35_0 then
				var_35_12.localPosition = Vector3.New(0, -1.95, -2.63)
				var_35_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_12.position).x, (manager.ui.mainCamera.transform.position - var_35_12.position).y, (manager.ui.mainCamera.transform.position - var_35_12.position).z)
				var_35_12.localEulerAngles.z = 0
				var_35_12.localEulerAngles.x = 0
				var_35_12.localEulerAngles = var_35_12.localEulerAngles

				local var_35_15 = GameObjectTools.GetOrAddComponent(var_35_12.gameObject, typeof(DynamicBoneHelper))

				if var_35_15 then
					var_35_15:EnableDynamicBone(true)
				end
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			local var_35_16 = 0
			local var_35_17 = 0.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_16 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[58].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_18 = arg_32_1:GetWordFromCfg(104112008)
				local var_35_19 = arg_32_1:FormatText(var_35_18.content)

				arg_32_1.text_.text = var_35_19

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_21 = 7 <= 0 and var_35_17 or var_35_17 * (utf8.len(var_35_19) / 7)

				if (7 <= 0 and var_35_17 or var_35_17 * (utf8.len(var_35_19) / 7)) > 0 and var_35_17 < var_35_21 then
					arg_32_1.talkMaxDuration = var_35_21

					if var_35_21 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_21 + var_35_16
					end
				end

				arg_32_1.text_.text = var_35_19
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112008", "story_v_out_104112.awb") ~= 0 then
					local var_35_22 = manager.audio:GetVoiceLength("story_v_out_104112", "104112008", "story_v_out_104112.awb") / 1000

					if var_35_22 + var_35_16 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_22 + var_35_16
					end

					if var_35_18.prefab_name ~= "" and arg_32_1.actors_[var_35_18.prefab_name] ~= nil then
						local var_35_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_18.prefab_name].transform, "story_v_out_104112", "104112008", "story_v_out_104112.awb")

						arg_32_1:RecordAudio("104112008", var_35_23)
						arg_32_1:RecordAudio("104112008", var_35_23)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104112", "104112008", "story_v_out_104112.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104112", "104112008", "story_v_out_104112.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_24 = math.max(var_35_17, arg_32_1.talkMaxDuration)

			if var_35_16 <= arg_32_1.time_ and arg_32_1.time_ < var_35_16 + var_35_24 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_16) / var_35_24

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_16 + var_35_24 and arg_32_1.time_ < var_35_16 + var_35_24 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1059ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play104112009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104112009
		arg_36_1.duration_ = 6.23

		local var_36_0 = {
			ja = 5.466,
			ko = 3.9,
			zh = 4.666,
			en = 6.233
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
				arg_36_0:Play104112010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1027ui_story"]) and arg_36_1.var_.characterEffect1027ui_story == nil then
				arg_36_1.var_.characterEffect1027ui_story = arg_36_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1027ui_story"]) then
				if arg_36_1.var_.characterEffect1027ui_story and not isNil(arg_36_1.actors_["1027ui_story"]) then
					arg_36_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1027ui_story"]) and arg_36_1.var_.characterEffect1027ui_story then
				arg_36_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["3005_tpose"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect3005_tpose == nil then
				arg_36_1.var_.characterEffect3005_tpose = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect3005_tpose and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect3005_tpose.fillFlat = true
					arg_36_1.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect3005_tpose then
				arg_36_1.var_.characterEffect3005_tpose.fillFlat = true
				arg_36_1.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			local var_39_4 = arg_36_1.actors_["3005_tpose"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos3005_tpose = var_39_4.localPosition

				local var_39_5 = GameObjectTools.GetOrAddComponent(var_39_4.gameObject, typeof(DynamicBoneHelper))

				if var_39_5 then
					var_39_5:EnableDynamicBone(false)
				end
			end

			local var_39_6 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_6)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, 100, 0)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles

				local var_39_7 = GameObjectTools.GetOrAddComponent(var_39_4.gameObject, typeof(DynamicBoneHelper))

				if var_39_7 then
					var_39_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action4_1")
			end

			local var_39_8 = arg_36_1.actors_["1027ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1027ui_story = var_39_8.localPosition
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (arg_36_1.time_ - 0) / var_39_9)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, -0.81, -5.8)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_39_10 = 0
			local var_39_11 = 0.55

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_12 = arg_36_1:GetWordFromCfg(104112009)
				local var_39_13 = arg_36_1:FormatText(var_39_12.content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 22 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 22)

				if (22 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 22)) > 0 and var_39_11 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112009", "story_v_out_104112.awb") ~= 0 then
					local var_39_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112009", "story_v_out_104112.awb") / 1000

					if var_39_16 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_10
					end

					if var_39_12.prefab_name ~= "" and arg_36_1.actors_[var_39_12.prefab_name] ~= nil then
						local var_39_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_12.prefab_name].transform, "story_v_out_104112", "104112009", "story_v_out_104112.awb")

						arg_36_1:RecordAudio("104112009", var_39_17)
						arg_36_1:RecordAudio("104112009", var_39_17)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104112", "104112009", "story_v_out_104112.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104112", "104112009", "story_v_out_104112.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_18 = math.max(var_39_11, arg_36_1.talkMaxDuration)

			if var_39_10 <= arg_36_1.time_ and arg_36_1.time_ < var_39_10 + var_39_18 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_10) / var_39_18

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_10 + var_39_18 and arg_36_1.time_ < var_39_10 + var_39_18 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3005_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_36_1:InitPlayNodeList()
	end,
	Play104112010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104112010
		arg_40_1.duration_ = 2.3

		local var_40_0 = {
			ja = 2.3,
			ko = 1,
			zh = 1.5,
			en = 1.033
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
				arg_40_0:Play104112011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1027ui_story = arg_40_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1027ui_story"].transform.position).z)
				arg_40_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1027ui_story"].transform.localEulerAngles = arg_40_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_40_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1027ui_story"].transform.position).z)
				arg_40_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1027ui_story"].transform.localEulerAngles = arg_40_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_43_1 = 0
			local var_43_2 = 0.075

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(104112010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 3 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 3)

				if (3 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 3)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112010", "story_v_out_104112.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_104112", "104112010", "story_v_out_104112.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_104112", "104112010", "story_v_out_104112.awb")

						arg_40_1:RecordAudio("104112010", var_43_8)
						arg_40_1:RecordAudio("104112010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104112", "104112010", "story_v_out_104112.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104112", "104112010", "story_v_out_104112.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_2, arg_40_1.talkMaxDuration)

			if var_43_1 <= arg_40_1.time_ and arg_40_1.time_ < var_43_1 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_1) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_1 + var_43_9 and arg_40_1.time_ < var_43_1 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play104112011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104112011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104112012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.7

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, false)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_1 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(104112011).content)

				arg_44_1.text_.text = var_47_1

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_3 = 28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 28)

				if (28 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_1) / 28)) > 0 and var_47_0 < var_47_3 then
					arg_44_1.talkMaxDuration = var_47_3

					if var_47_3 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_3 + 0
					end
				end

				arg_44_1.text_.text = var_47_1
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_4 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_4 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_4

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_4 and arg_44_1.time_ < 0 + var_47_4 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104112012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104112012
		arg_48_1.duration_ = 7.7

		local var_48_0 = {
			ja = 7.7,
			ko = 5.066,
			zh = 6.433,
			en = 7.166
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
				arg_48_0:Play104112013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1027ui_story"]) and arg_48_1.var_.characterEffect1027ui_story == nil then
				arg_48_1.var_.characterEffect1027ui_story = arg_48_1.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1027ui_story"]) then
				if arg_48_1.var_.characterEffect1027ui_story and not isNil(arg_48_1.actors_["1027ui_story"]) then
					arg_48_1.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1027ui_story"]) and arg_48_1.var_.characterEffect1027ui_story then
				arg_48_1.var_.characterEffect1027ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1027ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1027ui_story = var_51_2.localPosition
			end

			local var_51_3 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (arg_48_1.time_ - 0) / var_51_3)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/story1027/story1027action/1027action6_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.75

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(104112012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 30 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 30)

				if (30 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 30)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112012", "story_v_out_104112.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112012", "story_v_out_104112.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_104112", "104112012", "story_v_out_104112.awb")

						arg_48_1:RecordAudio("104112012", var_51_11)
						arg_48_1:RecordAudio("104112012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104112", "104112012", "story_v_out_104112.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104112", "104112012", "story_v_out_104112.awb")
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

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play104112013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104112013
		arg_52_1.duration_ = 1.73

		local var_52_0 = {
			ja = 1.733,
			ko = 1.1,
			zh = 1.466,
			en = 0.7
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
				arg_52_0:Play104112014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos1027ui_story = arg_52_1.actors_["1027ui_story"].transform.localPosition
			end

			local var_55_0 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 then
				arg_52_1.actors_["1027ui_story"].transform.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_0)
				arg_52_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1027ui_story"].transform.position).z)
				arg_52_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1027ui_story"].transform.localEulerAngles = arg_52_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 then
				arg_52_1.actors_["1027ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["1027ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_52_1.actors_["1027ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1027ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_52_1.actors_["1027ui_story"].transform.position).z)
				arg_52_1.actors_["1027ui_story"].transform.localEulerAngles.z = 0
				arg_52_1.actors_["1027ui_story"].transform.localEulerAngles.x = 0
				arg_52_1.actors_["1027ui_story"].transform.localEulerAngles = arg_52_1.actors_["1027ui_story"].transform.localEulerAngles
			end

			local var_55_1 = 0
			local var_55_2 = 0.05

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(104112013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 2 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 2)

				if (2 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 2)) > 0 and var_55_2 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112013", "story_v_out_104112.awb") ~= 0 then
					local var_55_7 = manager.audio:GetVoiceLength("story_v_out_104112", "104112013", "story_v_out_104112.awb") / 1000

					if var_55_7 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_1
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_104112", "104112013", "story_v_out_104112.awb")

						arg_52_1:RecordAudio("104112013", var_55_8)
						arg_52_1:RecordAudio("104112013", var_55_8)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104112", "104112013", "story_v_out_104112.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104112", "104112013", "story_v_out_104112.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_9 = math.max(var_55_2, arg_52_1.talkMaxDuration)

			if var_55_1 <= arg_52_1.time_ and arg_52_1.time_ < var_55_1 + var_55_9 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_1) / var_55_9

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_1 + var_55_9 and arg_52_1.time_ < var_55_1 + var_55_9 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1027ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play104112014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104112014
		arg_56_1.duration_ = 9

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104112015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_0 = 2

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 then
				local var_59_1 = Color.New(0, 0, 0)

				var_59_1.a = Mathf.Lerp(0, 1, (arg_56_1.time_ - 0) / var_59_0)
				arg_56_1.mask_.color = var_59_1
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 then
				local var_59_2 = Color.New(0, 0, 0)

				var_59_2.a = 1
				arg_56_1.mask_.color = var_59_2
			end

			local var_59_3 = 2

			if 2 < arg_56_1.time_ and arg_56_1.time_ <= var_59_3 + arg_59_0 then
				arg_56_1.mask_.enabled = true
				arg_56_1.mask_.raycastTarget = true

				arg_56_1:SetGaussion(false)
			end

			local var_59_4 = 2

			if var_59_3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_3 + var_59_4 then
				local var_59_5 = Color.New(0, 0, 0)

				var_59_5.a = Mathf.Lerp(1, 0, (arg_56_1.time_ - var_59_3) / var_59_4)
				arg_56_1.mask_.color = var_59_5
			end

			if arg_56_1.time_ >= var_59_3 + var_59_4 and arg_56_1.time_ < var_59_3 + var_59_4 + arg_59_0 then
				local var_59_6 = Color.New(0, 0, 0)

				arg_56_1.mask_.enabled = false
				var_59_6.a = 0
				arg_56_1.mask_.color = var_59_6
			end

			if arg_56_1.frameCnt_ <= 1 then
				arg_56_1.dialog_:SetActive(false)
			end

			local var_59_7 = 4
			local var_59_8 = 0.375

			if 4 < arg_56_1.time_ and arg_56_1.time_ <= var_59_7 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0

				arg_56_1.dialog_:SetActive(true)

				arg_56_1.dialogCg_.alpha = 0

				local var_59_9 = LeanTween.value(arg_56_1.dialog_, 0, 1, 0.3)

				var_59_9:setOnUpdate(LuaHelper.FloatAction(function(arg_60_0)
					arg_56_1.dialogCg_.alpha = arg_60_0
				end))
				var_59_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_56_1.dialog_)
					var_59_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_56_1.duration_ = arg_56_1.duration_ + 0.3

				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_10 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(104112014).content)

				arg_56_1.text_.text = var_59_10

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_12 = 15 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_10) / 15)

				if (15 <= 0 and var_59_8 or var_59_8 * (utf8.len(var_59_10) / 15)) > 0 and var_59_8 < var_59_12 then
					arg_56_1.talkMaxDuration = var_59_12
					var_59_7 = var_59_7 + 0.3

					if var_59_12 + var_59_7 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_12 + var_59_7
					end
				end

				arg_56_1.text_.text = var_59_10
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_13 = var_59_7 + 0.3
			local var_59_14 = math.max(var_59_8, arg_56_1.talkMaxDuration)

			if var_59_7 + 0.3 <= arg_56_1.time_ and arg_56_1.time_ < var_59_13 + var_59_14 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_13) / var_59_14

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_13 + var_59_14 and arg_56_1.time_ < var_59_13 + var_59_14 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104112015 = function(arg_62_0, arg_62_1)
		arg_62_1.time_ = 0
		arg_62_1.frameCnt_ = 0
		arg_62_1.state_ = "playing"
		arg_62_1.curTalkId_ = 104112015
		arg_62_1.duration_ = 8.5

		local var_62_0 = {
			ja = 8.5,
			ko = 5.9,
			zh = 6.8,
			en = 5.633
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
				arg_62_0:Play104112016(arg_62_1)
			end
		end

		function arg_62_1.onSingleLineUpdate_(arg_65_0)
			if arg_62_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_65_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_62_1.stage_.transform)

				var_65_0.name = "3008ui_story"
				var_65_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_["3008ui_story"] = var_65_0

				local var_65_1 = var_65_0:GetComponentInChildren(typeof(CharacterEffect))

				var_65_1.enabled = true

				local var_65_2 = GameObjectTools.GetOrAddComponent(var_65_0, typeof(DynamicBoneHelper))

				if var_65_2 then
					var_65_2:EnableDynamicBone(false)
				end

				arg_62_1:ShowWeapon(var_65_1.transform, false)

				arg_62_1.var_["3008ui_story" .. "Animator"] = var_65_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_62_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_62_1.var_["3008ui_story" .. "LipSync"] = var_65_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_65_3 = arg_62_1.actors_["3008ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect3008ui_story == nil then
				arg_62_1.var_.characterEffect3008ui_story = var_65_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_4 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_4 and not isNil(var_65_3) then
				if arg_62_1.var_.characterEffect3008ui_story and not isNil(var_65_3) then
					arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_62_1.time_ >= 0 + var_65_4 and arg_62_1.time_ < 0 + var_65_4 + arg_65_0 and not isNil(var_65_3) and arg_62_1.var_.characterEffect3008ui_story then
				arg_62_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_65_6 = "1035ui_story"

			if arg_62_1.actors_["1035ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1035ui_story"))) then
				local var_65_7 = Object.Instantiate(Asset.Load("Char/" .. "1035ui_story"), arg_62_1.stage_.transform)

				var_65_7.name = var_65_6
				var_65_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_62_1.actors_[var_65_6] = var_65_7

				local var_65_8 = var_65_7:GetComponentInChildren(typeof(CharacterEffect))

				var_65_8.enabled = true

				local var_65_9 = GameObjectTools.GetOrAddComponent(var_65_7, typeof(DynamicBoneHelper))

				if var_65_9 then
					var_65_9:EnableDynamicBone(false)
				end

				arg_62_1:ShowWeapon(var_65_8.transform, false)

				arg_62_1.var_[var_65_6 .. "Animator"] = var_65_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_62_1.var_[var_65_6 .. "Animator"].applyRootMotion = true
				arg_62_1.var_[var_65_6 .. "LipSync"] = var_65_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_65_10 = arg_62_1.actors_["1035ui_story"]

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 and not isNil(var_65_10) and arg_62_1.var_.characterEffect1035ui_story == nil then
				arg_62_1.var_.characterEffect1035ui_story = var_65_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_65_11 = 0.1

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_11 and not isNil(var_65_10) then
				if arg_62_1.var_.characterEffect1035ui_story and not isNil(var_65_10) then
					arg_62_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_62_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_62_1.time_ - 0) / var_65_11)
				end
			end

			if arg_62_1.time_ >= 0 + var_65_11 and arg_62_1.time_ < 0 + var_65_11 + arg_65_0 and not isNil(var_65_10) and arg_62_1.var_.characterEffect1035ui_story then
				arg_62_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_62_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			local var_65_12 = arg_62_1.actors_["3008ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos3008ui_story = var_65_12.localPosition
			end

			local var_65_13 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_13 then
				var_65_12.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (arg_62_1.time_ - 0) / var_65_13)
				var_65_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_12.position).x, (manager.ui.mainCamera.transform.position - var_65_12.position).y, (manager.ui.mainCamera.transform.position - var_65_12.position).z)
				var_65_12.localEulerAngles.z = 0
				var_65_12.localEulerAngles.x = 0
				var_65_12.localEulerAngles = var_65_12.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_13 and arg_62_1.time_ < 0 + var_65_13 + arg_65_0 then
				var_65_12.localPosition = Vector3.New(0.7, -1.51, -4.3)
				var_65_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_12.position).x, (manager.ui.mainCamera.transform.position - var_65_12.position).y, (manager.ui.mainCamera.transform.position - var_65_12.position).z)
				var_65_12.localEulerAngles.z = 0
				var_65_12.localEulerAngles.x = 0
				var_65_12.localEulerAngles = var_65_12.localEulerAngles
			end

			local var_65_14 = arg_62_1.actors_["1035ui_story"].transform

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1.var_.moveOldPos1035ui_story = var_65_14.localPosition
			end

			local var_65_15 = 0.001

			if 0 <= arg_62_1.time_ and arg_62_1.time_ < 0 + var_65_15 then
				var_65_14.localPosition = Vector3.Lerp(arg_62_1.var_.moveOldPos1035ui_story, Vector3.New(-0.7, -1.05, -5.6), (arg_62_1.time_ - 0) / var_65_15)
				var_65_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_14.position).x, (manager.ui.mainCamera.transform.position - var_65_14.position).y, (manager.ui.mainCamera.transform.position - var_65_14.position).z)
				var_65_14.localEulerAngles.z = 0
				var_65_14.localEulerAngles.x = 0
				var_65_14.localEulerAngles = var_65_14.localEulerAngles
			end

			if arg_62_1.time_ >= 0 + var_65_15 and arg_62_1.time_ < 0 + var_65_15 + arg_65_0 then
				var_65_14.localPosition = Vector3.New(-0.7, -1.05, -5.6)
				var_65_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_65_14.position).x, (manager.ui.mainCamera.transform.position - var_65_14.position).y, (manager.ui.mainCamera.transform.position - var_65_14.position).z)
				var_65_14.localEulerAngles.z = 0
				var_65_14.localEulerAngles.x = 0
				var_65_14.localEulerAngles = var_65_14.localEulerAngles
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action4_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action1_1")
			end

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= 0 + arg_65_0 then
				arg_62_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_65_16 = 0
			local var_65_17 = 0.55

			if 0 < arg_62_1.time_ and arg_62_1.time_ <= var_65_16 + arg_65_0 then
				arg_62_1.talkMaxDuration = 0
				arg_62_1.dialogCg_.alpha = 1

				arg_62_1.dialog_:SetActive(true)
				SetActive(arg_62_1.leftNameGo_, true)

				arg_62_1.leftNameTxt_.text = arg_62_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_62_1.leftNameTxt_.transform)

				arg_62_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_62_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_62_1:RecordName(arg_62_1.leftNameTxt_.text)
				SetActive(arg_62_1.iconTrs_.gameObject, false)
				arg_62_1.callingController_:SetSelectedState("normal")

				local var_65_18 = arg_62_1:GetWordFromCfg(104112015)
				local var_65_19 = arg_62_1:FormatText(var_65_18.content)

				arg_62_1.text_.text = var_65_19

				LuaForUtil.ClearLinePrefixSymbol(arg_62_1.text_)

				local var_65_21 = 21 <= 0 and var_65_17 or var_65_17 * (utf8.len(var_65_19) / 21)

				if (21 <= 0 and var_65_17 or var_65_17 * (utf8.len(var_65_19) / 21)) > 0 and var_65_17 < var_65_21 then
					arg_62_1.talkMaxDuration = var_65_21

					if var_65_21 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_21 + var_65_16
					end
				end

				arg_62_1.text_.text = var_65_19
				arg_62_1.typewritter.percent = 0

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112015", "story_v_out_104112.awb") ~= 0 then
					local var_65_22 = manager.audio:GetVoiceLength("story_v_out_104112", "104112015", "story_v_out_104112.awb") / 1000

					if var_65_22 + var_65_16 > arg_62_1.duration_ then
						arg_62_1.duration_ = var_65_22 + var_65_16
					end

					if var_65_18.prefab_name ~= "" and arg_62_1.actors_[var_65_18.prefab_name] ~= nil then
						local var_65_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_62_1.actors_[var_65_18.prefab_name].transform, "story_v_out_104112", "104112015", "story_v_out_104112.awb")

						arg_62_1:RecordAudio("104112015", var_65_23)
						arg_62_1:RecordAudio("104112015", var_65_23)
					else
						arg_62_1:AudioAction("play", "voice", "story_v_out_104112", "104112015", "story_v_out_104112.awb")
					end

					arg_62_1:RecordHistoryTalkVoice("story_v_out_104112", "104112015", "story_v_out_104112.awb")
				end

				arg_62_1:RecordContent(arg_62_1.text_.text)
			end

			local var_65_24 = math.max(var_65_17, arg_62_1.talkMaxDuration)

			if var_65_16 <= arg_62_1.time_ and arg_62_1.time_ < var_65_16 + var_65_24 then
				arg_62_1.typewritter.percent = (arg_62_1.time_ - var_65_16) / var_65_24

				arg_62_1.typewritter:SetDirty()
			end

			if arg_62_1.time_ >= var_65_16 + var_65_24 and arg_62_1.time_ < var_65_16 + var_65_24 + arg_65_0 then
				arg_62_1.typewritter.percent = 1

				arg_62_1.typewritter:SetDirty()
				arg_62_1:ShowNextGo(true)
			end
		end

		arg_62_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_62_1:InitPlayNodeList()
	end,
	Play104112016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 104112016
		arg_66_1.duration_ = 9.2

		local var_66_0 = {
			ja = 7.1,
			ko = 4.533,
			zh = 9.2,
			en = 6.733
		}
		local var_66_1 = manager.audio:GetLocalizationFlag()

		if var_66_0[var_66_1] ~= nil then
			arg_66_1.duration_ = var_66_0[var_66_1]
		end

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play104112017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story == nil then
				arg_66_1.var_.characterEffect3008ui_story = arg_66_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) then
				if arg_66_1.var_.characterEffect3008ui_story and not isNil(arg_66_1.actors_["3008ui_story"]) then
					arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_66_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["3008ui_story"]) and arg_66_1.var_.characterEffect3008ui_story then
				arg_66_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_66_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_69_1 = arg_66_1.actors_["1035ui_story"]

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1035ui_story == nil then
				arg_66_1.var_.characterEffect1035ui_story = var_69_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_2 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_2 and not isNil(var_69_1) then
				if arg_66_1.var_.characterEffect1035ui_story and not isNil(var_69_1) then
					arg_66_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_66_1.time_ >= 0 + var_69_2 and arg_66_1.time_ < 0 + var_69_2 + arg_69_0 and not isNil(var_69_1) and arg_66_1.var_.characterEffect1035ui_story then
				arg_66_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 then
				arg_66_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035action/1035action9_1")
			end

			local var_69_4 = 0
			local var_69_5 = 0.625

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_4 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, false)
				arg_66_1.callingController_:SetSelectedState("normal")

				local var_69_6 = arg_66_1:GetWordFromCfg(104112016)
				local var_69_7 = arg_66_1:FormatText(var_69_6.content)

				arg_66_1.text_.text = var_69_7

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_9 = 24 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 24)

				if (24 <= 0 and var_69_5 or var_69_5 * (utf8.len(var_69_7) / 24)) > 0 and var_69_5 < var_69_9 then
					arg_66_1.talkMaxDuration = var_69_9

					if var_69_9 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_9 + var_69_4
					end
				end

				arg_66_1.text_.text = var_69_7
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112016", "story_v_out_104112.awb") ~= 0 then
					local var_69_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112016", "story_v_out_104112.awb") / 1000

					if var_69_10 + var_69_4 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_10 + var_69_4
					end

					if var_69_6.prefab_name ~= "" and arg_66_1.actors_[var_69_6.prefab_name] ~= nil then
						local var_69_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_66_1.actors_[var_69_6.prefab_name].transform, "story_v_out_104112", "104112016", "story_v_out_104112.awb")

						arg_66_1:RecordAudio("104112016", var_69_11)
						arg_66_1:RecordAudio("104112016", var_69_11)
					else
						arg_66_1:AudioAction("play", "voice", "story_v_out_104112", "104112016", "story_v_out_104112.awb")
					end

					arg_66_1:RecordHistoryTalkVoice("story_v_out_104112", "104112016", "story_v_out_104112.awb")
				end

				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_12 = math.max(var_69_5, arg_66_1.talkMaxDuration)

			if var_69_4 <= arg_66_1.time_ and arg_66_1.time_ < var_69_4 + var_69_12 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_4) / var_69_12

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_4 + var_69_12 and arg_66_1.time_ < var_69_4 + var_69_12 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play104112017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 104112017
		arg_70_1.duration_ = 9.1

		local var_70_0 = {
			ja = 9.1,
			ko = 4.3,
			zh = 5.833,
			en = 5
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
				arg_70_0:Play104112018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["3008ui_story"]) and arg_70_1.var_.characterEffect3008ui_story == nil then
				arg_70_1.var_.characterEffect3008ui_story = arg_70_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["3008ui_story"]) then
				if arg_70_1.var_.characterEffect3008ui_story and not isNil(arg_70_1.actors_["3008ui_story"]) then
					arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["3008ui_story"]) and arg_70_1.var_.characterEffect3008ui_story then
				arg_70_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1035ui_story"]

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1035ui_story == nil then
				arg_70_1.var_.characterEffect1035ui_story = var_73_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_3 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 and not isNil(var_73_2) then
				if arg_70_1.var_.characterEffect1035ui_story and not isNil(var_73_2) then
					arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
					arg_70_1.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_70_1.time_ - 0) / var_73_3)
				end
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 and not isNil(var_73_2) and arg_70_1.var_.characterEffect1035ui_story then
				arg_70_1.var_.characterEffect1035ui_story.fillFlat = true
				arg_70_1.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008actionlink/3008action442")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_73_4 = 0
			local var_73_5 = 0.525

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_4 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_6 = arg_70_1:GetWordFromCfg(104112017)
				local var_73_7 = arg_70_1:FormatText(var_73_6.content)

				arg_70_1.text_.text = var_73_7

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_9 = 21 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 21)

				if (21 <= 0 and var_73_5 or var_73_5 * (utf8.len(var_73_7) / 21)) > 0 and var_73_5 < var_73_9 then
					arg_70_1.talkMaxDuration = var_73_9

					if var_73_9 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_9 + var_73_4
					end
				end

				arg_70_1.text_.text = var_73_7
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112017", "story_v_out_104112.awb") ~= 0 then
					local var_73_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112017", "story_v_out_104112.awb") / 1000

					if var_73_10 + var_73_4 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_10 + var_73_4
					end

					if var_73_6.prefab_name ~= "" and arg_70_1.actors_[var_73_6.prefab_name] ~= nil then
						local var_73_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_6.prefab_name].transform, "story_v_out_104112", "104112017", "story_v_out_104112.awb")

						arg_70_1:RecordAudio("104112017", var_73_11)
						arg_70_1:RecordAudio("104112017", var_73_11)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_104112", "104112017", "story_v_out_104112.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_104112", "104112017", "story_v_out_104112.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_12 = math.max(var_73_5, arg_70_1.talkMaxDuration)

			if var_73_4 <= arg_70_1.time_ and arg_70_1.time_ < var_73_4 + var_73_12 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_4) / var_73_12

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_4 + var_73_12 and arg_70_1.time_ < var_73_4 + var_73_12 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {}

		arg_70_1:InitPlayNodeList()
	end,
	Play104112018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 104112018
		arg_74_1.duration_ = 3.27

		local var_74_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3.266,
			en = 2.366
		}
		local var_74_1 = manager.audio:GetLocalizationFlag()

		if var_74_0[var_74_1] ~= nil then
			arg_74_1.duration_ = var_74_0[var_74_1]
		end

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play104112019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["3008ui_story"]) and arg_74_1.var_.characterEffect3008ui_story == nil then
				arg_74_1.var_.characterEffect3008ui_story = arg_74_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["3008ui_story"]) then
				if arg_74_1.var_.characterEffect3008ui_story and not isNil(arg_74_1.actors_["3008ui_story"]) then
					arg_74_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_74_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["3008ui_story"]) and arg_74_1.var_.characterEffect3008ui_story then
				arg_74_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_74_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_77_1 = arg_74_1.actors_["1035ui_story"]

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1035ui_story == nil then
				arg_74_1.var_.characterEffect1035ui_story = var_77_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_2 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 and not isNil(var_77_1) then
				if arg_74_1.var_.characterEffect1035ui_story and not isNil(var_77_1) then
					arg_74_1.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 and not isNil(var_77_1) and arg_74_1.var_.characterEffect1035ui_story then
				arg_74_1.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/story1035/story1035actionlink/1035action494")
			end

			local var_77_4 = 0
			local var_77_5 = 0.1

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_4 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, true)

				arg_74_1.leftNameTxt_.text = arg_74_1:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_74_1.leftNameTxt_.transform)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1.leftNameTxt_.text)
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_6 = arg_74_1:GetWordFromCfg(104112018)
				local var_77_7 = arg_74_1:FormatText(var_77_6.content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 4 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 4)

				if (4 <= 0 and var_77_5 or var_77_5 * (utf8.len(var_77_7) / 4)) > 0 and var_77_5 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_4
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112018", "story_v_out_104112.awb") ~= 0 then
					local var_77_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112018", "story_v_out_104112.awb") / 1000

					if var_77_10 + var_77_4 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_10 + var_77_4
					end

					if var_77_6.prefab_name ~= "" and arg_74_1.actors_[var_77_6.prefab_name] ~= nil then
						local var_77_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_74_1.actors_[var_77_6.prefab_name].transform, "story_v_out_104112", "104112018", "story_v_out_104112.awb")

						arg_74_1:RecordAudio("104112018", var_77_11)
						arg_74_1:RecordAudio("104112018", var_77_11)
					else
						arg_74_1:AudioAction("play", "voice", "story_v_out_104112", "104112018", "story_v_out_104112.awb")
					end

					arg_74_1:RecordHistoryTalkVoice("story_v_out_104112", "104112018", "story_v_out_104112.awb")
				end

				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_12 = math.max(var_77_5, arg_74_1.talkMaxDuration)

			if var_77_4 <= arg_74_1.time_ and arg_74_1.time_ < var_77_4 + var_77_12 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_4) / var_77_12

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_4 + var_77_12 and arg_74_1.time_ < var_77_4 + var_77_12 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {}

		arg_74_1:InitPlayNodeList()
	end,
	Play104112019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 104112019
		arg_78_1.duration_ = 5

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play104112020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos3008ui_story = arg_78_1.actors_["3008ui_story"].transform.localPosition
			end

			local var_81_0 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 then
				arg_78_1.actors_["3008ui_story"].transform.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_0)
				arg_78_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["3008ui_story"].transform.position).z)
				arg_78_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["3008ui_story"].transform.localEulerAngles = arg_78_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 then
				arg_78_1.actors_["3008ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_78_1.actors_["3008ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_78_1.actors_["3008ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["3008ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_78_1.actors_["3008ui_story"].transform.position).z)
				arg_78_1.actors_["3008ui_story"].transform.localEulerAngles.z = 0
				arg_78_1.actors_["3008ui_story"].transform.localEulerAngles.x = 0
				arg_78_1.actors_["3008ui_story"].transform.localEulerAngles = arg_78_1.actors_["3008ui_story"].transform.localEulerAngles
			end

			local var_81_1 = arg_78_1.actors_["1035ui_story"].transform

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1.var_.moveOldPos1035ui_story = var_81_1.localPosition
			end

			local var_81_2 = 0.001

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_2 then
				var_81_1.localPosition = Vector3.Lerp(arg_78_1.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (arg_78_1.time_ - 0) / var_81_2)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			if arg_78_1.time_ >= 0 + var_81_2 and arg_78_1.time_ < 0 + var_81_2 + arg_81_0 then
				var_81_1.localPosition = Vector3.New(0, 100, 0)
				var_81_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_81_1.position).x, (manager.ui.mainCamera.transform.position - var_81_1.position).y, (manager.ui.mainCamera.transform.position - var_81_1.position).z)
				var_81_1.localEulerAngles.z = 0
				var_81_1.localEulerAngles.x = 0
				var_81_1.localEulerAngles = var_81_1.localEulerAngles
			end

			local var_81_3 = 0
			local var_81_4 = 0.475

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_3 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, false)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_5 = arg_78_1:FormatText(arg_78_1:GetWordFromCfg(104112019).content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 19 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 19)

				if (19 <= 0 and var_81_4 or var_81_4 * (utf8.len(var_81_5) / 19)) > 0 and var_81_4 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_3 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_3
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)
				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_8 = math.max(var_81_4, arg_78_1.talkMaxDuration)

			if var_81_3 <= arg_78_1.time_ and arg_78_1.time_ < var_81_3 + var_81_8 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_3) / var_81_8

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_3 + var_81_8 and arg_78_1.time_ < var_81_3 + var_81_8 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3008ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1035ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_78_1:InitPlayNodeList()
	end,
	Play104112020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 104112020
		arg_82_1.duration_ = 10.13

		local var_82_0 = {
			ja = 10.133,
			ko = 6.166,
			zh = 7.366,
			en = 6.3
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
				arg_82_0:Play104112021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if arg_82_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_85_0 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_82_1.stage_.transform)

				var_85_0.name = "4010ui_story"
				var_85_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.actors_["4010ui_story"] = var_85_0

				local var_85_1 = var_85_0:GetComponentInChildren(typeof(CharacterEffect))

				var_85_1.enabled = true

				local var_85_2 = GameObjectTools.GetOrAddComponent(var_85_0, typeof(DynamicBoneHelper))

				if var_85_2 then
					var_85_2:EnableDynamicBone(false)
				end

				arg_82_1:ShowWeapon(var_85_1.transform, false)

				arg_82_1.var_["4010ui_story" .. "Animator"] = var_85_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_82_1.var_["4010ui_story" .. "Animator"].applyRootMotion = true
				arg_82_1.var_["4010ui_story" .. "LipSync"] = var_85_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_85_3 = arg_82_1.actors_["4010ui_story"]

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect4010ui_story == nil then
				arg_82_1.var_.characterEffect4010ui_story = var_85_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_85_4 = 0.1

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_4 and not isNil(var_85_3) then
				if arg_82_1.var_.characterEffect4010ui_story and not isNil(var_85_3) then
					arg_82_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_82_1.time_ >= 0 + var_85_4 and arg_82_1.time_ < 0 + var_85_4 + arg_85_0 and not isNil(var_85_3) and arg_82_1.var_.characterEffect4010ui_story then
				arg_82_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_85_6 = arg_82_1.actors_["4010ui_story"].transform

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos4010ui_story = var_85_6.localPosition
			end

			local var_85_7 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_7 then
				var_85_6.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_82_1.time_ - 0) / var_85_7)
				var_85_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_6.position).x, (manager.ui.mainCamera.transform.position - var_85_6.position).y, (manager.ui.mainCamera.transform.position - var_85_6.position).z)
				var_85_6.localEulerAngles.z = 0
				var_85_6.localEulerAngles.x = 0
				var_85_6.localEulerAngles = var_85_6.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_7 and arg_82_1.time_ < 0 + var_85_7 + arg_85_0 then
				var_85_6.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_85_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_85_6.position).x, (manager.ui.mainCamera.transform.position - var_85_6.position).y, (manager.ui.mainCamera.transform.position - var_85_6.position).z)
				var_85_6.localEulerAngles.z = 0
				var_85_6.localEulerAngles.x = 0
				var_85_6.localEulerAngles = var_85_6.localEulerAngles
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_85_8 = 0
			local var_85_9 = 0.95

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_8 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, true)

				arg_82_1.leftNameTxt_.text = arg_82_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_82_1.leftNameTxt_.transform)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1.leftNameTxt_.text)
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_10 = arg_82_1:GetWordFromCfg(104112020)
				local var_85_11 = arg_82_1:FormatText(var_85_10.content)

				arg_82_1.text_.text = var_85_11

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_13 = 38 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 38)

				if (38 <= 0 and var_85_9 or var_85_9 * (utf8.len(var_85_11) / 38)) > 0 and var_85_9 < var_85_13 then
					arg_82_1.talkMaxDuration = var_85_13

					if var_85_13 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_13 + var_85_8
					end
				end

				arg_82_1.text_.text = var_85_11
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112020", "story_v_out_104112.awb") ~= 0 then
					local var_85_14 = manager.audio:GetVoiceLength("story_v_out_104112", "104112020", "story_v_out_104112.awb") / 1000

					if var_85_14 + var_85_8 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_14 + var_85_8
					end

					if var_85_10.prefab_name ~= "" and arg_82_1.actors_[var_85_10.prefab_name] ~= nil then
						local var_85_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_82_1.actors_[var_85_10.prefab_name].transform, "story_v_out_104112", "104112020", "story_v_out_104112.awb")

						arg_82_1:RecordAudio("104112020", var_85_15)
						arg_82_1:RecordAudio("104112020", var_85_15)
					else
						arg_82_1:AudioAction("play", "voice", "story_v_out_104112", "104112020", "story_v_out_104112.awb")
					end

					arg_82_1:RecordHistoryTalkVoice("story_v_out_104112", "104112020", "story_v_out_104112.awb")
				end

				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_16 = math.max(var_85_9, arg_82_1.talkMaxDuration)

			if var_85_8 <= arg_82_1.time_ and arg_82_1.time_ < var_85_8 + var_85_16 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_8) / var_85_16

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_8 + var_85_16 and arg_82_1.time_ < var_85_8 + var_85_16 + arg_85_0 then
				arg_82_1.typewritter.percent = 1

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(true)
			end
		end

		arg_82_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play104112021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 104112021
		arg_86_1.duration_ = 5.5

		local var_86_0 = {
			ja = 5.5,
			ko = 4.6,
			zh = 4.733,
			en = 5.433
		}
		local var_86_1 = manager.audio:GetLocalizationFlag()

		if var_86_0[var_86_1] ~= nil then
			arg_86_1.duration_ = var_86_0[var_86_1]
		end

		SetActive(arg_86_1.tipsGo_, false)

		function arg_86_1.onSingleLineFinish_()
			arg_86_1.onSingleLineUpdate_ = nil
			arg_86_1.onSingleLineFinish_ = nil
			arg_86_1.state_ = "waiting"
		end

		function arg_86_1.playNext_(arg_88_0)
			if arg_88_0 == 1 then
				arg_86_0:Play104112022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if arg_86_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_89_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_86_1.stage_.transform)

				var_89_0.name = "3009ui_story"
				var_89_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_86_1.actors_["3009ui_story"] = var_89_0

				local var_89_1 = var_89_0:GetComponentInChildren(typeof(CharacterEffect))

				var_89_1.enabled = true

				local var_89_2 = GameObjectTools.GetOrAddComponent(var_89_0, typeof(DynamicBoneHelper))

				if var_89_2 then
					var_89_2:EnableDynamicBone(false)
				end

				arg_86_1:ShowWeapon(var_89_1.transform, false)

				arg_86_1.var_["3009ui_story" .. "Animator"] = var_89_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_86_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_86_1.var_["3009ui_story" .. "LipSync"] = var_89_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_89_3 = arg_86_1.actors_["3009ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect3009ui_story == nil then
				arg_86_1.var_.characterEffect3009ui_story = var_89_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_4 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_4 and not isNil(var_89_3) then
				if arg_86_1.var_.characterEffect3009ui_story and not isNil(var_89_3) then
					arg_86_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_4 and arg_86_1.time_ < 0 + var_89_4 + arg_89_0 and not isNil(var_89_3) and arg_86_1.var_.characterEffect3009ui_story then
				arg_86_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_89_6 = arg_86_1.actors_["4010ui_story"]

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect4010ui_story == nil then
				arg_86_1.var_.characterEffect4010ui_story = var_89_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_7 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_7 and not isNil(var_89_6) then
				if arg_86_1.var_.characterEffect4010ui_story and not isNil(var_89_6) then
					arg_86_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_86_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_86_1.time_ - 0) / var_89_7)
				end
			end

			if arg_86_1.time_ >= 0 + var_89_7 and arg_86_1.time_ < 0 + var_89_7 + arg_89_0 and not isNil(var_89_6) and arg_86_1.var_.characterEffect4010ui_story then
				arg_86_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_86_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_89_8 = arg_86_1.actors_["3009ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos3009ui_story = var_89_8.localPosition

				arg_86_1:ShowWeapon(arg_86_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_89_9 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_9 then
				var_89_8.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_86_1.time_ - 0) / var_89_9)
				var_89_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_8.position).x, (manager.ui.mainCamera.transform.position - var_89_8.position).y, (manager.ui.mainCamera.transform.position - var_89_8.position).z)
				var_89_8.localEulerAngles.z = 0
				var_89_8.localEulerAngles.x = 0
				var_89_8.localEulerAngles = var_89_8.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_9 and arg_86_1.time_ < 0 + var_89_9 + arg_89_0 then
				var_89_8.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_89_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_8.position).x, (manager.ui.mainCamera.transform.position - var_89_8.position).y, (manager.ui.mainCamera.transform.position - var_89_8.position).z)
				var_89_8.localEulerAngles.z = 0
				var_89_8.localEulerAngles.x = 0
				var_89_8.localEulerAngles = var_89_8.localEulerAngles
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_89_10 = 0
			local var_89_11 = 0.65

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_10 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_12 = arg_86_1:GetWordFromCfg(104112021)
				local var_89_13 = arg_86_1:FormatText(var_89_12.content)

				arg_86_1.text_.text = var_89_13

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_15 = 26 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 26)

				if (26 <= 0 and var_89_11 or var_89_11 * (utf8.len(var_89_13) / 26)) > 0 and var_89_11 < var_89_15 then
					arg_86_1.talkMaxDuration = var_89_15

					if var_89_15 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_15 + var_89_10
					end
				end

				arg_86_1.text_.text = var_89_13
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112021", "story_v_out_104112.awb") ~= 0 then
					local var_89_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112021", "story_v_out_104112.awb") / 1000

					if var_89_16 + var_89_10 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_16 + var_89_10
					end

					if var_89_12.prefab_name ~= "" and arg_86_1.actors_[var_89_12.prefab_name] ~= nil then
						local var_89_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_12.prefab_name].transform, "story_v_out_104112", "104112021", "story_v_out_104112.awb")

						arg_86_1:RecordAudio("104112021", var_89_17)
						arg_86_1:RecordAudio("104112021", var_89_17)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_104112", "104112021", "story_v_out_104112.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_104112", "104112021", "story_v_out_104112.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_18 = math.max(var_89_11, arg_86_1.talkMaxDuration)

			if var_89_10 <= arg_86_1.time_ and arg_86_1.time_ < var_89_10 + var_89_18 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_10) / var_89_18

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_10 + var_89_18 and arg_86_1.time_ < var_89_10 + var_89_18 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_86_1:InitPlayNodeList()
	end,
	Play104112022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 104112022
		arg_90_1.duration_ = 4.43

		local var_90_0 = {
			ja = 4.433,
			ko = 2.633,
			zh = 2.599999999999,
			en = 2.599999999999
		}
		local var_90_1 = manager.audio:GetLocalizationFlag()

		if var_90_0[var_90_1] ~= nil then
			arg_90_1.duration_ = var_90_0[var_90_1]
		end

		SetActive(arg_90_1.tipsGo_, false)

		function arg_90_1.onSingleLineFinish_()
			arg_90_1.onSingleLineUpdate_ = nil
			arg_90_1.onSingleLineFinish_ = nil
			arg_90_1.state_ = "waiting"
		end

		function arg_90_1.playNext_(arg_92_0)
			if arg_92_0 == 1 then
				arg_90_0:Play104112023(arg_90_1)
			end
		end

		function arg_90_1.onSingleLineUpdate_(arg_93_0)
			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(arg_90_1.actors_["4010ui_story"]) and arg_90_1.var_.characterEffect4010ui_story == nil then
				arg_90_1.var_.characterEffect4010ui_story = arg_90_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_0 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_0 and not isNil(arg_90_1.actors_["4010ui_story"]) then
				if arg_90_1.var_.characterEffect4010ui_story and not isNil(arg_90_1.actors_["4010ui_story"]) then
					arg_90_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_90_1.time_ >= 0 + var_93_0 and arg_90_1.time_ < 0 + var_93_0 + arg_93_0 and not isNil(arg_90_1.actors_["4010ui_story"]) and arg_90_1.var_.characterEffect4010ui_story then
				arg_90_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_93_2 = arg_90_1.actors_["3009ui_story"]

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect3009ui_story == nil then
				arg_90_1.var_.characterEffect3009ui_story = var_93_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_93_3 = 0.1

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 and not isNil(var_93_2) then
				if arg_90_1.var_.characterEffect3009ui_story and not isNil(var_93_2) then
					arg_90_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_90_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_90_1.time_ - 0) / var_93_3)
				end
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 and not isNil(var_93_2) and arg_90_1.var_.characterEffect3009ui_story then
				arg_90_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_90_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_93_4 = 0
			local var_93_5 = 0.275

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_4 + arg_93_0 then
				arg_90_1.talkMaxDuration = 0
				arg_90_1.dialogCg_.alpha = 1

				arg_90_1.dialog_:SetActive(true)
				SetActive(arg_90_1.leftNameGo_, true)

				arg_90_1.leftNameTxt_.text = arg_90_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_90_1.leftNameTxt_.transform)

				arg_90_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_90_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_90_1:RecordName(arg_90_1.leftNameTxt_.text)
				SetActive(arg_90_1.iconTrs_.gameObject, false)
				arg_90_1.callingController_:SetSelectedState("normal")

				local var_93_6 = arg_90_1:GetWordFromCfg(104112022)
				local var_93_7 = arg_90_1:FormatText(var_93_6.content)

				arg_90_1.text_.text = var_93_7

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_9 = 11 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 11)

				if (11 <= 0 and var_93_5 or var_93_5 * (utf8.len(var_93_7) / 11)) > 0 and var_93_5 < var_93_9 then
					arg_90_1.talkMaxDuration = var_93_9

					if var_93_9 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_9 + var_93_4
					end
				end

				arg_90_1.text_.text = var_93_7
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112022", "story_v_out_104112.awb") ~= 0 then
					local var_93_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112022", "story_v_out_104112.awb") / 1000

					if var_93_10 + var_93_4 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_10 + var_93_4
					end

					if var_93_6.prefab_name ~= "" and arg_90_1.actors_[var_93_6.prefab_name] ~= nil then
						local var_93_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_6.prefab_name].transform, "story_v_out_104112", "104112022", "story_v_out_104112.awb")

						arg_90_1:RecordAudio("104112022", var_93_11)
						arg_90_1:RecordAudio("104112022", var_93_11)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_104112", "104112022", "story_v_out_104112.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_104112", "104112022", "story_v_out_104112.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_12 = math.max(var_93_5, arg_90_1.talkMaxDuration)

			if var_93_4 <= arg_90_1.time_ and arg_90_1.time_ < var_93_4 + var_93_12 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_4) / var_93_12

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_4 + var_93_12 and arg_90_1.time_ < var_93_4 + var_93_12 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {}

		arg_90_1:InitPlayNodeList()
	end,
	Play104112023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 104112023
		arg_94_1.duration_ = 6.2

		local var_94_0 = {
			ja = 6.2,
			ko = 4.9,
			zh = 5.5,
			en = 5.2
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
				arg_94_0:Play104112024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(arg_94_1.actors_["3009ui_story"]) and arg_94_1.var_.characterEffect3009ui_story == nil then
				arg_94_1.var_.characterEffect3009ui_story = arg_94_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_0 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_0 and not isNil(arg_94_1.actors_["3009ui_story"]) then
				if arg_94_1.var_.characterEffect3009ui_story and not isNil(arg_94_1.actors_["3009ui_story"]) then
					arg_94_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_0 and arg_94_1.time_ < 0 + var_97_0 + arg_97_0 and not isNil(arg_94_1.actors_["3009ui_story"]) and arg_94_1.var_.characterEffect3009ui_story then
				arg_94_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_97_2 = arg_94_1.actors_["4010ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect4010ui_story == nil then
				arg_94_1.var_.characterEffect4010ui_story = var_97_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_3 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_3 and not isNil(var_97_2) then
				if arg_94_1.var_.characterEffect4010ui_story and not isNil(var_97_2) then
					arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_94_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_3)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_3 and arg_94_1.time_ < 0 + var_97_3 + arg_97_0 and not isNil(var_97_2) and arg_94_1.var_.characterEffect4010ui_story then
				arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_94_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_97_4 = 0
			local var_97_5 = 0.675

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_4 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_6 = arg_94_1:GetWordFromCfg(104112023)
				local var_97_7 = arg_94_1:FormatText(var_97_6.content)

				arg_94_1.text_.text = var_97_7

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_9 = 27 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 27)

				if (27 <= 0 and var_97_5 or var_97_5 * (utf8.len(var_97_7) / 27)) > 0 and var_97_5 < var_97_9 then
					arg_94_1.talkMaxDuration = var_97_9

					if var_97_9 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_9 + var_97_4
					end
				end

				arg_94_1.text_.text = var_97_7
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112023", "story_v_out_104112.awb") ~= 0 then
					local var_97_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112023", "story_v_out_104112.awb") / 1000

					if var_97_10 + var_97_4 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_10 + var_97_4
					end

					if var_97_6.prefab_name ~= "" and arg_94_1.actors_[var_97_6.prefab_name] ~= nil then
						local var_97_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_6.prefab_name].transform, "story_v_out_104112", "104112023", "story_v_out_104112.awb")

						arg_94_1:RecordAudio("104112023", var_97_11)
						arg_94_1:RecordAudio("104112023", var_97_11)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_104112", "104112023", "story_v_out_104112.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_104112", "104112023", "story_v_out_104112.awb")
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

		arg_94_1.nodeConfigList_ = {}

		arg_94_1:InitPlayNodeList()
	end,
	Play104112024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 104112024
		arg_98_1.duration_ = 3.43

		local var_98_0 = {
			ja = 3.433,
			ko = 2.733,
			zh = 3,
			en = 3.4
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
				arg_98_0:Play104112025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["4010ui_story"]) and arg_98_1.var_.characterEffect4010ui_story == nil then
				arg_98_1.var_.characterEffect4010ui_story = arg_98_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["4010ui_story"]) then
				if arg_98_1.var_.characterEffect4010ui_story and not isNil(arg_98_1.actors_["4010ui_story"]) then
					arg_98_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["4010ui_story"]) and arg_98_1.var_.characterEffect4010ui_story then
				arg_98_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_101_2 = arg_98_1.actors_["3009ui_story"]

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect3009ui_story == nil then
				arg_98_1.var_.characterEffect3009ui_story = var_101_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_3 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_3 and not isNil(var_101_2) then
				if arg_98_1.var_.characterEffect3009ui_story and not isNil(var_101_2) then
					arg_98_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_98_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_3)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_3 and arg_98_1.time_ < 0 + var_101_3 + arg_101_0 and not isNil(var_101_2) and arg_98_1.var_.characterEffect3009ui_story then
				arg_98_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_98_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 then
				arg_98_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_101_4 = 0
			local var_101_5 = 0.3

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_4 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, true)

				arg_98_1.leftNameTxt_.text = arg_98_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_98_1.leftNameTxt_.transform)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1.leftNameTxt_.text)
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_6 = arg_98_1:GetWordFromCfg(104112024)
				local var_101_7 = arg_98_1:FormatText(var_101_6.content)

				arg_98_1.text_.text = var_101_7

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_9 = 12 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 12)

				if (12 <= 0 and var_101_5 or var_101_5 * (utf8.len(var_101_7) / 12)) > 0 and var_101_5 < var_101_9 then
					arg_98_1.talkMaxDuration = var_101_9

					if var_101_9 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_9 + var_101_4
					end
				end

				arg_98_1.text_.text = var_101_7
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112024", "story_v_out_104112.awb") ~= 0 then
					local var_101_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112024", "story_v_out_104112.awb") / 1000

					if var_101_10 + var_101_4 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_10 + var_101_4
					end

					if var_101_6.prefab_name ~= "" and arg_98_1.actors_[var_101_6.prefab_name] ~= nil then
						local var_101_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_98_1.actors_[var_101_6.prefab_name].transform, "story_v_out_104112", "104112024", "story_v_out_104112.awb")

						arg_98_1:RecordAudio("104112024", var_101_11)
						arg_98_1:RecordAudio("104112024", var_101_11)
					else
						arg_98_1:AudioAction("play", "voice", "story_v_out_104112", "104112024", "story_v_out_104112.awb")
					end

					arg_98_1:RecordHistoryTalkVoice("story_v_out_104112", "104112024", "story_v_out_104112.awb")
				end

				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_12 = math.max(var_101_5, arg_98_1.talkMaxDuration)

			if var_101_4 <= arg_98_1.time_ and arg_98_1.time_ < var_101_4 + var_101_12 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_4) / var_101_12

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_4 + var_101_12 and arg_98_1.time_ < var_101_4 + var_101_12 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play104112025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 104112025
		arg_102_1.duration_ = 5

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play104112026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["4010ui_story"]) and arg_102_1.var_.characterEffect4010ui_story == nil then
				arg_102_1.var_.characterEffect4010ui_story = arg_102_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["4010ui_story"]) then
				if arg_102_1.var_.characterEffect4010ui_story and not isNil(arg_102_1.actors_["4010ui_story"]) then
					arg_102_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_102_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_102_1.time_ - 0) / var_105_0)
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["4010ui_story"]) and arg_102_1.var_.characterEffect4010ui_story then
				arg_102_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_102_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_105_1 = arg_102_1.actors_["4010ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos4010ui_story = var_105_1.localPosition
			end

			local var_105_2 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_2 then
				var_105_1.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_2)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_2 and arg_102_1.time_ < 0 + var_105_2 + arg_105_0 then
				var_105_1.localPosition = Vector3.New(0, 100, 0)
				var_105_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_1.position).x, (manager.ui.mainCamera.transform.position - var_105_1.position).y, (manager.ui.mainCamera.transform.position - var_105_1.position).z)
				var_105_1.localEulerAngles.z = 0
				var_105_1.localEulerAngles.x = 0
				var_105_1.localEulerAngles = var_105_1.localEulerAngles
			end

			local var_105_3 = arg_102_1.actors_["3009ui_story"].transform

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1.var_.moveOldPos3009ui_story = var_105_3.localPosition
			end

			local var_105_4 = 0.001

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_4 then
				var_105_3.localPosition = Vector3.Lerp(arg_102_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_102_1.time_ - 0) / var_105_4)
				var_105_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_3.position).x, (manager.ui.mainCamera.transform.position - var_105_3.position).y, (manager.ui.mainCamera.transform.position - var_105_3.position).z)
				var_105_3.localEulerAngles.z = 0
				var_105_3.localEulerAngles.x = 0
				var_105_3.localEulerAngles = var_105_3.localEulerAngles
			end

			if arg_102_1.time_ >= 0 + var_105_4 and arg_102_1.time_ < 0 + var_105_4 + arg_105_0 then
				var_105_3.localPosition = Vector3.New(0, 100, 0)
				var_105_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_105_3.position).x, (manager.ui.mainCamera.transform.position - var_105_3.position).y, (manager.ui.mainCamera.transform.position - var_105_3.position).z)
				var_105_3.localEulerAngles.z = 0
				var_105_3.localEulerAngles.x = 0
				var_105_3.localEulerAngles = var_105_3.localEulerAngles
			end

			local var_105_5 = 0
			local var_105_6 = 0.7

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_5 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, false)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_7 = arg_102_1:FormatText(arg_102_1:GetWordFromCfg(104112025).content)

				arg_102_1.text_.text = var_105_7

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_9 = 28 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 28)

				if (28 <= 0 and var_105_6 or var_105_6 * (utf8.len(var_105_7) / 28)) > 0 and var_105_6 < var_105_9 then
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

		arg_102_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_102_1:InitPlayNodeList()
	end,
	Play104112026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 104112026
		arg_106_1.duration_ = 18.73

		local var_106_0 = {
			ja = 14.833,
			ko = 12.3,
			zh = 12.833,
			en = 18.733
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
				arg_106_0:Play104112027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["4010ui_story"]) and arg_106_1.var_.characterEffect4010ui_story == nil then
				arg_106_1.var_.characterEffect4010ui_story = arg_106_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["4010ui_story"]) then
				if arg_106_1.var_.characterEffect4010ui_story and not isNil(arg_106_1.actors_["4010ui_story"]) then
					arg_106_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["4010ui_story"]) and arg_106_1.var_.characterEffect4010ui_story then
				arg_106_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["4010ui_story"].transform

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1.var_.moveOldPos4010ui_story = var_109_2.localPosition
			end

			local var_109_3 = 0.001

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 then
				var_109_2.localPosition = Vector3.Lerp(arg_106_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_106_1.time_ - 0) / var_109_3)
				var_109_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_2.position).x, (manager.ui.mainCamera.transform.position - var_109_2.position).y, (manager.ui.mainCamera.transform.position - var_109_2.position).z)
				var_109_2.localEulerAngles.z = 0
				var_109_2.localEulerAngles.x = 0
				var_109_2.localEulerAngles = var_109_2.localEulerAngles
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 then
				var_109_2.localPosition = Vector3.New(0, -1.59, -5.2)
				var_109_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_109_2.position).x, (manager.ui.mainCamera.transform.position - var_109_2.position).y, (manager.ui.mainCamera.transform.position - var_109_2.position).z)
				var_109_2.localEulerAngles.z = 0
				var_109_2.localEulerAngles.x = 0
				var_109_2.localEulerAngles = var_109_2.localEulerAngles
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_109_4 = 0
			local var_109_5 = 1.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(104112026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 52 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 52)

				if (52 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 52)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112026", "story_v_out_104112.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112026", "story_v_out_104112.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_104112", "104112026", "story_v_out_104112.awb")

						arg_106_1:RecordAudio("104112026", var_109_11)
						arg_106_1:RecordAudio("104112026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_104112", "104112026", "story_v_out_104112.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_104112", "104112026", "story_v_out_104112.awb")
				end

				arg_106_1:RecordContent(arg_106_1.text_.text)
			end

			local var_109_12 = math.max(var_109_5, arg_106_1.talkMaxDuration)

			if var_109_4 <= arg_106_1.time_ and arg_106_1.time_ < var_109_4 + var_109_12 then
				arg_106_1.typewritter.percent = (arg_106_1.time_ - var_109_4) / var_109_12

				arg_106_1.typewritter:SetDirty()
			end

			if arg_106_1.time_ >= var_109_4 + var_109_12 and arg_106_1.time_ < var_109_4 + var_109_12 + arg_109_0 then
				arg_106_1.typewritter.percent = 1

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(true)
			end
		end

		arg_106_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_106_1:InitPlayNodeList()
	end,
	Play104112027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 104112027
		arg_110_1.duration_ = 5.03

		local var_110_0 = {
			ja = 5.033,
			ko = 3.566,
			zh = 3.666,
			en = 2.866
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
				arg_110_0:Play104112028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_113_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_110_1.stage_.transform)

				var_113_0.name = "2020_tpose"
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["2020_tpose"] = var_113_0

				local var_113_1 = var_113_0:GetComponentInChildren(typeof(CharacterEffect))

				var_113_1.enabled = true

				local var_113_2 = GameObjectTools.GetOrAddComponent(var_113_0, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(false)
				end

				arg_110_1:ShowWeapon(var_113_1.transform, false)

				arg_110_1.var_["2020_tpose" .. "Animator"] = var_113_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_110_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_110_1.var_["2020_tpose" .. "LipSync"] = var_113_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_113_3 = arg_110_1.actors_["2020_tpose"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect2020_tpose == nil then
				arg_110_1.var_.characterEffect2020_tpose = var_113_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_4 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 and not isNil(var_113_3) then
				if arg_110_1.var_.characterEffect2020_tpose and not isNil(var_113_3) then
					arg_110_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect2020_tpose then
				arg_110_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_113_6 = arg_110_1.actors_["4010ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect4010ui_story == nil then
				arg_110_1.var_.characterEffect4010ui_story = var_113_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_7 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 and not isNil(var_113_6) then
				if arg_110_1.var_.characterEffect4010ui_story and not isNil(var_113_6) then
					arg_110_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_110_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_7)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect4010ui_story then
				arg_110_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_110_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_113_8 = arg_110_1.actors_["4010ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos4010ui_story = var_113_8.localPosition
			end

			local var_113_9 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_9 then
				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_9)
				var_113_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_8.position).x, (manager.ui.mainCamera.transform.position - var_113_8.position).y, (manager.ui.mainCamera.transform.position - var_113_8.position).z)
				var_113_8.localEulerAngles.z = 0
				var_113_8.localEulerAngles.x = 0
				var_113_8.localEulerAngles = var_113_8.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_9 and arg_110_1.time_ < 0 + var_113_9 + arg_113_0 then
				var_113_8.localPosition = Vector3.New(0, 100, 0)
				var_113_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_8.position).x, (manager.ui.mainCamera.transform.position - var_113_8.position).y, (manager.ui.mainCamera.transform.position - var_113_8.position).z)
				var_113_8.localEulerAngles.z = 0
				var_113_8.localEulerAngles.x = 0
				var_113_8.localEulerAngles = var_113_8.localEulerAngles
			end

			local var_113_10 = 0
			local var_113_11 = 0.4

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_10 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, true)
				arg_110_1.iconController_:SetSelectedState("hero")

				arg_110_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_110_1.callingController_:SetSelectedState("normal")

				arg_110_1.keyicon_.color = Color.New(1, 1, 1)
				arg_110_1.icon_.color = Color.New(1, 1, 1)

				local var_113_12 = arg_110_1:GetWordFromCfg(104112027)
				local var_113_13 = arg_110_1:FormatText(var_113_12.content)

				arg_110_1.text_.text = var_113_13

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_15 = 16 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 16)

				if (16 <= 0 and var_113_11 or var_113_11 * (utf8.len(var_113_13) / 16)) > 0 and var_113_11 < var_113_15 then
					arg_110_1.talkMaxDuration = var_113_15

					if var_113_15 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_15 + var_113_10
					end
				end

				arg_110_1.text_.text = var_113_13
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112027", "story_v_out_104112.awb") ~= 0 then
					local var_113_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112027", "story_v_out_104112.awb") / 1000

					if var_113_16 + var_113_10 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_16 + var_113_10
					end

					if var_113_12.prefab_name ~= "" and arg_110_1.actors_[var_113_12.prefab_name] ~= nil then
						local var_113_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_12.prefab_name].transform, "story_v_out_104112", "104112027", "story_v_out_104112.awb")

						arg_110_1:RecordAudio("104112027", var_113_17)
						arg_110_1:RecordAudio("104112027", var_113_17)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_104112", "104112027", "story_v_out_104112.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_104112", "104112027", "story_v_out_104112.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_18 = math.max(var_113_11, arg_110_1.talkMaxDuration)

			if var_113_10 <= arg_110_1.time_ and arg_110_1.time_ < var_113_10 + var_113_18 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_10) / var_113_18

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_10 + var_113_18 and arg_110_1.time_ < var_113_10 + var_113_18 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_110_1:InitPlayNodeList()
	end,
	Play104112028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 104112028
		arg_114_1.duration_ = 5

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play104112029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 and not isNil(arg_114_1.actors_["2020_tpose"]) and arg_114_1.var_.characterEffect2020_tpose == nil then
				arg_114_1.var_.characterEffect2020_tpose = arg_114_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_117_0 = 0.1

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_0 and not isNil(arg_114_1.actors_["2020_tpose"]) then
				if arg_114_1.var_.characterEffect2020_tpose and not isNil(arg_114_1.actors_["2020_tpose"]) then
					arg_114_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_114_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_114_1.time_ - 0) / var_117_0)
				end
			end

			if arg_114_1.time_ >= 0 + var_117_0 and arg_114_1.time_ < 0 + var_117_0 + arg_117_0 and not isNil(arg_114_1.actors_["2020_tpose"]) and arg_114_1.var_.characterEffect2020_tpose then
				arg_114_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_114_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_117_1 = arg_114_1.actors_["4010ui_story"].transform

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1.var_.moveOldPos4010ui_story = var_117_1.localPosition
			end

			local var_117_2 = 0.001

			if 0 <= arg_114_1.time_ and arg_114_1.time_ < 0 + var_117_2 then
				var_117_1.localPosition = Vector3.Lerp(arg_114_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_114_1.time_ - 0) / var_117_2)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			if arg_114_1.time_ >= 0 + var_117_2 and arg_114_1.time_ < 0 + var_117_2 + arg_117_0 then
				var_117_1.localPosition = Vector3.New(0, 100, 0)
				var_117_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_117_1.position).x, (manager.ui.mainCamera.transform.position - var_117_1.position).y, (manager.ui.mainCamera.transform.position - var_117_1.position).z)
				var_117_1.localEulerAngles.z = 0
				var_117_1.localEulerAngles.x = 0
				var_117_1.localEulerAngles = var_117_1.localEulerAngles
			end

			local var_117_3 = 0
			local var_117_4 = 0.225

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_3 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, false)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_5 = arg_114_1:FormatText(arg_114_1:GetWordFromCfg(104112028).content)

				arg_114_1.text_.text = var_117_5

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_7 = 9 <= 0 and var_117_4 or var_117_4 * (utf8.len(var_117_5) / 9)

				if (9 <= 0 and var_117_4 or var_117_4 * (utf8.len(var_117_5) / 9)) > 0 and var_117_4 < var_117_7 then
					arg_114_1.talkMaxDuration = var_117_7

					if var_117_7 + var_117_3 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_7 + var_117_3
					end
				end

				arg_114_1.text_.text = var_117_5
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)
				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_4, arg_114_1.talkMaxDuration)

			if var_117_3 <= arg_114_1.time_ and arg_114_1.time_ < var_117_3 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_3) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_3 + var_117_8 and arg_114_1.time_ < var_117_3 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_114_1:InitPlayNodeList()
	end,
	Play104112029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 104112029
		arg_118_1.duration_ = 3.83

		local var_118_0 = {
			ja = 3.833,
			ko = 3.433,
			zh = 2.633,
			en = 3.066
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
				arg_118_0:Play104112030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if arg_118_1.actors_["2030_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2030_tpose"))) then
				local var_121_0 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_118_1.stage_.transform)

				var_121_0.name = "2030_tpose"
				var_121_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_118_1.actors_["2030_tpose"] = var_121_0

				local var_121_1 = var_121_0:GetComponentInChildren(typeof(CharacterEffect))

				var_121_1.enabled = true

				local var_121_2 = GameObjectTools.GetOrAddComponent(var_121_0, typeof(DynamicBoneHelper))

				if var_121_2 then
					var_121_2:EnableDynamicBone(false)
				end

				arg_118_1:ShowWeapon(var_121_1.transform, false)

				arg_118_1.var_["2030_tpose" .. "Animator"] = var_121_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_118_1.var_["2030_tpose" .. "Animator"].applyRootMotion = true
				arg_118_1.var_["2030_tpose" .. "LipSync"] = var_121_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_121_3 = arg_118_1.actors_["2030_tpose"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_3) and arg_118_1.var_.characterEffect2030_tpose == nil then
				arg_118_1.var_.characterEffect2030_tpose = var_121_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_4 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_4 and not isNil(var_121_3) then
				if arg_118_1.var_.characterEffect2030_tpose and not isNil(var_121_3) then
					arg_118_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_4 and arg_118_1.time_ < 0 + var_121_4 + arg_121_0 and not isNil(var_121_3) and arg_118_1.var_.characterEffect2030_tpose then
				arg_118_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_121_6 = arg_118_1.actors_["2030_tpose"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos2030_tpose = var_121_6.localPosition

				local var_121_7 = GameObjectTools.GetOrAddComponent(var_121_6.gameObject, typeof(DynamicBoneHelper))

				if var_121_7 then
					var_121_7:EnableDynamicBone(false)
				end
			end

			local var_121_8 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_8 then
				var_121_6.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_8)
				var_121_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_6.position).x, (manager.ui.mainCamera.transform.position - var_121_6.position).y, (manager.ui.mainCamera.transform.position - var_121_6.position).z)
				var_121_6.localEulerAngles.z = 0
				var_121_6.localEulerAngles.x = 0
				var_121_6.localEulerAngles = var_121_6.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_8 and arg_118_1.time_ < 0 + var_121_8 + arg_121_0 then
				var_121_6.localPosition = Vector3.New(0, 100, 0)
				var_121_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_6.position).x, (manager.ui.mainCamera.transform.position - var_121_6.position).y, (manager.ui.mainCamera.transform.position - var_121_6.position).z)
				var_121_6.localEulerAngles.z = 0
				var_121_6.localEulerAngles.x = 0
				var_121_6.localEulerAngles = var_121_6.localEulerAngles

				local var_121_9 = GameObjectTools.GetOrAddComponent(var_121_6.gameObject, typeof(DynamicBoneHelper))

				if var_121_9 then
					var_121_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_121_10 = 0
			local var_121_11 = 0.325

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_10 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_12 = arg_118_1:GetWordFromCfg(104112029)
				local var_121_13 = arg_118_1:FormatText(var_121_12.content)

				arg_118_1.text_.text = var_121_13

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_15 = 13 <= 0 and var_121_11 or var_121_11 * (utf8.len(var_121_13) / 13)

				if (13 <= 0 and var_121_11 or var_121_11 * (utf8.len(var_121_13) / 13)) > 0 and var_121_11 < var_121_15 then
					arg_118_1.talkMaxDuration = var_121_15

					if var_121_15 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_15 + var_121_10
					end
				end

				arg_118_1.text_.text = var_121_13
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112029", "story_v_out_104112.awb") ~= 0 then
					local var_121_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112029", "story_v_out_104112.awb") / 1000

					if var_121_16 + var_121_10 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_16 + var_121_10
					end

					if var_121_12.prefab_name ~= "" and arg_118_1.actors_[var_121_12.prefab_name] ~= nil then
						local var_121_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_12.prefab_name].transform, "story_v_out_104112", "104112029", "story_v_out_104112.awb")

						arg_118_1:RecordAudio("104112029", var_121_17)
						arg_118_1:RecordAudio("104112029", var_121_17)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_104112", "104112029", "story_v_out_104112.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_104112", "104112029", "story_v_out_104112.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_18 = math.max(var_121_11, arg_118_1.talkMaxDuration)

			if var_121_10 <= arg_118_1.time_ and arg_118_1.time_ < var_121_10 + var_121_18 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_10) / var_121_18

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_10 + var_121_18 and arg_118_1.time_ < var_121_10 + var_121_18 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play104112030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 104112030
		arg_122_1.duration_ = 7.33

		local var_122_0 = {
			ja = 7.333,
			ko = 2.766,
			zh = 2.6,
			en = 3
		}
		local var_122_1 = manager.audio:GetLocalizationFlag()

		if var_122_0[var_122_1] ~= nil then
			arg_122_1.duration_ = var_122_0[var_122_1]
		end

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play104112031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["2020_tpose"]) and arg_122_1.var_.characterEffect2020_tpose == nil then
				arg_122_1.var_.characterEffect2020_tpose = arg_122_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["2020_tpose"]) then
				if arg_122_1.var_.characterEffect2020_tpose and not isNil(arg_122_1.actors_["2020_tpose"]) then
					arg_122_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["2020_tpose"]) and arg_122_1.var_.characterEffect2020_tpose then
				arg_122_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["2030_tpose"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect2030_tpose == nil then
				arg_122_1.var_.characterEffect2030_tpose = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect2030_tpose and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_122_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect2030_tpose then
				arg_122_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_122_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_125_4 = arg_122_1.actors_["2020_tpose"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos2020_tpose = var_125_4.localPosition

				local var_125_5 = GameObjectTools.GetOrAddComponent(var_125_4.gameObject, typeof(DynamicBoneHelper))

				if var_125_5 then
					var_125_5:EnableDynamicBone(false)
				end
			end

			local var_125_6 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_6 then
				var_125_4.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos2020_tpose, Vector3.New(0.7, -1.2, -4.1), (arg_122_1.time_ - 0) / var_125_6)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_6 and arg_122_1.time_ < 0 + var_125_6 + arg_125_0 then
				var_125_4.localPosition = Vector3.New(0.7, -1.2, -4.1)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles

				local var_125_7 = GameObjectTools.GetOrAddComponent(var_125_4.gameObject, typeof(DynamicBoneHelper))

				if var_125_7 then
					var_125_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_125_8 = 0
			local var_125_9 = 0.3

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[65].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(104112030)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 12 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 12)

				if (12 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 12)) > 0 and var_125_9 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112030", "story_v_out_104112.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_104112", "104112030", "story_v_out_104112.awb") / 1000

					if var_125_14 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_8
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_104112", "104112030", "story_v_out_104112.awb")

						arg_122_1:RecordAudio("104112030", var_125_15)
						arg_122_1:RecordAudio("104112030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_104112", "104112030", "story_v_out_104112.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_104112", "104112030", "story_v_out_104112.awb")
				end

				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_16 = math.max(var_125_9, arg_122_1.talkMaxDuration)

			if var_125_8 <= arg_122_1.time_ and arg_122_1.time_ < var_125_8 + var_125_16 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_8) / var_125_16

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_8 + var_125_16 and arg_122_1.time_ < var_125_8 + var_125_16 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_122_1:InitPlayNodeList()
	end,
	Play104112031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 104112031
		arg_126_1.duration_ = 6.17

		local var_126_0 = {
			ja = 4.366,
			ko = 4.9,
			zh = 6.166,
			en = 5.533
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
				arg_126_0:Play104112032(arg_126_1)
			end
		end

		function arg_126_1.onSingleLineUpdate_(arg_129_0)
			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(arg_126_1.actors_["4010ui_story"]) and arg_126_1.var_.characterEffect4010ui_story == nil then
				arg_126_1.var_.characterEffect4010ui_story = arg_126_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_0 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_0 and not isNil(arg_126_1.actors_["4010ui_story"]) then
				if arg_126_1.var_.characterEffect4010ui_story and not isNil(arg_126_1.actors_["4010ui_story"]) then
					arg_126_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_126_1.time_ >= 0 + var_129_0 and arg_126_1.time_ < 0 + var_129_0 + arg_129_0 and not isNil(arg_126_1.actors_["4010ui_story"]) and arg_126_1.var_.characterEffect4010ui_story then
				arg_126_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_129_2 = arg_126_1.actors_["2020_tpose"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect2020_tpose == nil then
				arg_126_1.var_.characterEffect2020_tpose = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.characterEffect2020_tpose and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_126_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_3)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect2020_tpose then
				arg_126_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_126_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_129_4 = arg_126_1.actors_["2020_tpose"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos2020_tpose = var_129_4.localPosition

				local var_129_5 = GameObjectTools.GetOrAddComponent(var_129_4.gameObject, typeof(DynamicBoneHelper))

				if var_129_5 then
					var_129_5:EnableDynamicBone(false)
				end
			end

			local var_129_6 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_6 then
				var_129_4.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_6)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_6 and arg_126_1.time_ < 0 + var_129_6 + arg_129_0 then
				var_129_4.localPosition = Vector3.New(0, 100, 0)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles

				local var_129_7 = GameObjectTools.GetOrAddComponent(var_129_4.gameObject, typeof(DynamicBoneHelper))

				if var_129_7 then
					var_129_7:EnableDynamicBone(true)
				end
			end

			local var_129_8 = arg_126_1.actors_["2030_tpose"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos2030_tpose = var_129_8.localPosition

				local var_129_9 = GameObjectTools.GetOrAddComponent(var_129_8.gameObject, typeof(DynamicBoneHelper))

				if var_129_9 then
					var_129_9:EnableDynamicBone(false)
				end
			end

			local var_129_10 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_10 then
				var_129_8.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_10)
				var_129_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_8.position).x, (manager.ui.mainCamera.transform.position - var_129_8.position).y, (manager.ui.mainCamera.transform.position - var_129_8.position).z)
				var_129_8.localEulerAngles.z = 0
				var_129_8.localEulerAngles.x = 0
				var_129_8.localEulerAngles = var_129_8.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_10 and arg_126_1.time_ < 0 + var_129_10 + arg_129_0 then
				var_129_8.localPosition = Vector3.New(0, 100, 0)
				var_129_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_8.position).x, (manager.ui.mainCamera.transform.position - var_129_8.position).y, (manager.ui.mainCamera.transform.position - var_129_8.position).z)
				var_129_8.localEulerAngles.z = 0
				var_129_8.localEulerAngles.x = 0
				var_129_8.localEulerAngles = var_129_8.localEulerAngles

				local var_129_11 = GameObjectTools.GetOrAddComponent(var_129_8.gameObject, typeof(DynamicBoneHelper))

				if var_129_11 then
					var_129_11:EnableDynamicBone(true)
				end
			end

			local var_129_12 = arg_126_1.actors_["4010ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos4010ui_story = var_129_12.localPosition
			end

			local var_129_13 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_13 then
				var_129_12.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_126_1.time_ - 0) / var_129_13)
				var_129_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_12.position).x, (manager.ui.mainCamera.transform.position - var_129_12.position).y, (manager.ui.mainCamera.transform.position - var_129_12.position).z)
				var_129_12.localEulerAngles.z = 0
				var_129_12.localEulerAngles.x = 0
				var_129_12.localEulerAngles = var_129_12.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_13 and arg_126_1.time_ < 0 + var_129_13 + arg_129_0 then
				var_129_12.localPosition = Vector3.New(0, -1.59, -5.2)
				var_129_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_12.position).x, (manager.ui.mainCamera.transform.position - var_129_12.position).y, (manager.ui.mainCamera.transform.position - var_129_12.position).z)
				var_129_12.localEulerAngles.z = 0
				var_129_12.localEulerAngles.x = 0
				var_129_12.localEulerAngles = var_129_12.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_129_14 = 0
			local var_129_15 = 0.475

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_14 + arg_129_0 then
				arg_126_1.talkMaxDuration = 0
				arg_126_1.dialogCg_.alpha = 1

				arg_126_1.dialog_:SetActive(true)
				SetActive(arg_126_1.leftNameGo_, true)

				arg_126_1.leftNameTxt_.text = arg_126_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_126_1.leftNameTxt_.transform)

				arg_126_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_126_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_126_1:RecordName(arg_126_1.leftNameTxt_.text)
				SetActive(arg_126_1.iconTrs_.gameObject, false)
				arg_126_1.callingController_:SetSelectedState("normal")

				local var_129_16 = arg_126_1:GetWordFromCfg(104112031)
				local var_129_17 = arg_126_1:FormatText(var_129_16.content)

				arg_126_1.text_.text = var_129_17

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_19 = 19 <= 0 and var_129_15 or var_129_15 * (utf8.len(var_129_17) / 19)

				if (19 <= 0 and var_129_15 or var_129_15 * (utf8.len(var_129_17) / 19)) > 0 and var_129_15 < var_129_19 then
					arg_126_1.talkMaxDuration = var_129_19

					if var_129_19 + var_129_14 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_19 + var_129_14
					end
				end

				arg_126_1.text_.text = var_129_17
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112031", "story_v_out_104112.awb") ~= 0 then
					local var_129_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112031", "story_v_out_104112.awb") / 1000

					if var_129_20 + var_129_14 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_20 + var_129_14
					end

					if var_129_16.prefab_name ~= "" and arg_126_1.actors_[var_129_16.prefab_name] ~= nil then
						local var_129_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_16.prefab_name].transform, "story_v_out_104112", "104112031", "story_v_out_104112.awb")

						arg_126_1:RecordAudio("104112031", var_129_21)
						arg_126_1:RecordAudio("104112031", var_129_21)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_104112", "104112031", "story_v_out_104112.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_104112", "104112031", "story_v_out_104112.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_22 = math.max(var_129_15, arg_126_1.talkMaxDuration)

			if var_129_14 <= arg_126_1.time_ and arg_126_1.time_ < var_129_14 + var_129_22 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_14) / var_129_22

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_14 + var_129_22 and arg_126_1.time_ < var_129_14 + var_129_22 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_126_1:InitPlayNodeList()
	end,
	Play104112032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 104112032
		arg_130_1.duration_ = 5

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play104112033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(arg_130_1.actors_["4010ui_story"]) and arg_130_1.var_.characterEffect4010ui_story == nil then
				arg_130_1.var_.characterEffect4010ui_story = arg_130_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_0 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_0 and not isNil(arg_130_1.actors_["4010ui_story"]) then
				if arg_130_1.var_.characterEffect4010ui_story and not isNil(arg_130_1.actors_["4010ui_story"]) then
					arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_130_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_0)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_0 and arg_130_1.time_ < 0 + var_133_0 + arg_133_0 and not isNil(arg_130_1.actors_["4010ui_story"]) and arg_130_1.var_.characterEffect4010ui_story then
				arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_130_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_133_1 = 0
			local var_133_2 = 0.4

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_1 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, false)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_3 = arg_130_1:FormatText(arg_130_1:GetWordFromCfg(104112032).content)

				arg_130_1.text_.text = var_133_3

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_5 = 16 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 16)

				if (16 <= 0 and var_133_2 or var_133_2 * (utf8.len(var_133_3) / 16)) > 0 and var_133_2 < var_133_5 then
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
	Play104112033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 104112033
		arg_134_1.duration_ = 18.97

		local var_134_0 = {
			ja = 13.033,
			ko = 12.733,
			zh = 14.5,
			en = 18.966
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
				arg_134_0:Play104112034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["4010ui_story"]) and arg_134_1.var_.characterEffect4010ui_story == nil then
				arg_134_1.var_.characterEffect4010ui_story = arg_134_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.1

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["4010ui_story"]) then
				if arg_134_1.var_.characterEffect4010ui_story and not isNil(arg_134_1.actors_["4010ui_story"]) then
					arg_134_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["4010ui_story"]) and arg_134_1.var_.characterEffect4010ui_story then
				arg_134_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_137_2 = 0
			local var_137_3 = 1.55

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_2 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_4 = arg_134_1:GetWordFromCfg(104112033)
				local var_137_5 = arg_134_1:FormatText(var_137_4.content)

				arg_134_1.text_.text = var_137_5

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_7 = 61 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 61)

				if (61 <= 0 and var_137_3 or var_137_3 * (utf8.len(var_137_5) / 61)) > 0 and var_137_3 < var_137_7 then
					arg_134_1.talkMaxDuration = var_137_7

					if var_137_7 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_7 + var_137_2
					end
				end

				arg_134_1.text_.text = var_137_5
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112033", "story_v_out_104112.awb") ~= 0 then
					local var_137_8 = manager.audio:GetVoiceLength("story_v_out_104112", "104112033", "story_v_out_104112.awb") / 1000

					if var_137_8 + var_137_2 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_8 + var_137_2
					end

					if var_137_4.prefab_name ~= "" and arg_134_1.actors_[var_137_4.prefab_name] ~= nil then
						local var_137_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_4.prefab_name].transform, "story_v_out_104112", "104112033", "story_v_out_104112.awb")

						arg_134_1:RecordAudio("104112033", var_137_9)
						arg_134_1:RecordAudio("104112033", var_137_9)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_104112", "104112033", "story_v_out_104112.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_104112", "104112033", "story_v_out_104112.awb")
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
	Play104112034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 104112034
		arg_138_1.duration_ = 10.73

		local var_138_0 = {
			ja = 10.533,
			ko = 9.066,
			zh = 10.266,
			en = 10.733
		}
		local var_138_1 = manager.audio:GetLocalizationFlag()

		if var_138_0[var_138_1] ~= nil then
			arg_138_1.duration_ = var_138_0[var_138_1]
		end

		SetActive(arg_138_1.tipsGo_, false)

		function arg_138_1.onSingleLineFinish_()
			arg_138_1.onSingleLineUpdate_ = nil
			arg_138_1.onSingleLineFinish_ = nil
			arg_138_1.state_ = "waiting"
		end

		function arg_138_1.playNext_(arg_140_0)
			if arg_140_0 == 1 then
				arg_138_0:Play104112035(arg_138_1)
			end
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_141_0 = 0
			local var_141_1 = 0.975

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_0 + arg_141_0 then
				arg_138_1.talkMaxDuration = 0
				arg_138_1.dialogCg_.alpha = 1

				arg_138_1.dialog_:SetActive(true)
				SetActive(arg_138_1.leftNameGo_, true)

				arg_138_1.leftNameTxt_.text = arg_138_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_138_1.leftNameTxt_.transform)

				arg_138_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_138_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_138_1:RecordName(arg_138_1.leftNameTxt_.text)
				SetActive(arg_138_1.iconTrs_.gameObject, false)
				arg_138_1.callingController_:SetSelectedState("normal")

				local var_141_2 = arg_138_1:GetWordFromCfg(104112034)
				local var_141_3 = arg_138_1:FormatText(var_141_2.content)

				arg_138_1.text_.text = var_141_3

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_5 = 39 <= 0 and var_141_1 or var_141_1 * (utf8.len(var_141_3) / 39)

				if (39 <= 0 and var_141_1 or var_141_1 * (utf8.len(var_141_3) / 39)) > 0 and var_141_1 < var_141_5 then
					arg_138_1.talkMaxDuration = var_141_5

					if var_141_5 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_5 + var_141_0
					end
				end

				arg_138_1.text_.text = var_141_3
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112034", "story_v_out_104112.awb") ~= 0 then
					local var_141_6 = manager.audio:GetVoiceLength("story_v_out_104112", "104112034", "story_v_out_104112.awb") / 1000

					if var_141_6 + var_141_0 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_6 + var_141_0
					end

					if var_141_2.prefab_name ~= "" and arg_138_1.actors_[var_141_2.prefab_name] ~= nil then
						local var_141_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_2.prefab_name].transform, "story_v_out_104112", "104112034", "story_v_out_104112.awb")

						arg_138_1:RecordAudio("104112034", var_141_7)
						arg_138_1:RecordAudio("104112034", var_141_7)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_104112", "104112034", "story_v_out_104112.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_104112", "104112034", "story_v_out_104112.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_8 = math.max(var_141_1, arg_138_1.talkMaxDuration)

			if var_141_0 <= arg_138_1.time_ and arg_138_1.time_ < var_141_0 + var_141_8 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_0) / var_141_8

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_0 + var_141_8 and arg_138_1.time_ < var_141_0 + var_141_8 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {}

		arg_138_1:InitPlayNodeList()
	end,
	Play104112035 = function(arg_142_0, arg_142_1)
		arg_142_1.time_ = 0
		arg_142_1.frameCnt_ = 0
		arg_142_1.state_ = "playing"
		arg_142_1.curTalkId_ = 104112035
		arg_142_1.duration_ = 12.9

		local var_142_0 = {
			ja = 11.8,
			ko = 10.933,
			zh = 12.9,
			en = 11.9
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
				arg_142_0:Play104112036(arg_142_1)
			end
		end

		function arg_142_1.onSingleLineUpdate_(arg_145_0)
			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= 0 + arg_145_0 then
				arg_142_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			local var_145_0 = 0
			local var_145_1 = 1.125

			if 0 < arg_142_1.time_ and arg_142_1.time_ <= var_145_0 + arg_145_0 then
				arg_142_1.talkMaxDuration = 0
				arg_142_1.dialogCg_.alpha = 1

				arg_142_1.dialog_:SetActive(true)
				SetActive(arg_142_1.leftNameGo_, true)

				arg_142_1.leftNameTxt_.text = arg_142_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_142_1.leftNameTxt_.transform)

				arg_142_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_142_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_142_1:RecordName(arg_142_1.leftNameTxt_.text)
				SetActive(arg_142_1.iconTrs_.gameObject, false)
				arg_142_1.callingController_:SetSelectedState("normal")

				local var_145_2 = arg_142_1:GetWordFromCfg(104112035)
				local var_145_3 = arg_142_1:FormatText(var_145_2.content)

				arg_142_1.text_.text = var_145_3

				LuaForUtil.ClearLinePrefixSymbol(arg_142_1.text_)

				local var_145_5 = 45 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 45)

				if (45 <= 0 and var_145_1 or var_145_1 * (utf8.len(var_145_3) / 45)) > 0 and var_145_1 < var_145_5 then
					arg_142_1.talkMaxDuration = var_145_5

					if var_145_5 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_5 + var_145_0
					end
				end

				arg_142_1.text_.text = var_145_3
				arg_142_1.typewritter.percent = 0

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112035", "story_v_out_104112.awb") ~= 0 then
					local var_145_6 = manager.audio:GetVoiceLength("story_v_out_104112", "104112035", "story_v_out_104112.awb") / 1000

					if var_145_6 + var_145_0 > arg_142_1.duration_ then
						arg_142_1.duration_ = var_145_6 + var_145_0
					end

					if var_145_2.prefab_name ~= "" and arg_142_1.actors_[var_145_2.prefab_name] ~= nil then
						local var_145_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_142_1.actors_[var_145_2.prefab_name].transform, "story_v_out_104112", "104112035", "story_v_out_104112.awb")

						arg_142_1:RecordAudio("104112035", var_145_7)
						arg_142_1:RecordAudio("104112035", var_145_7)
					else
						arg_142_1:AudioAction("play", "voice", "story_v_out_104112", "104112035", "story_v_out_104112.awb")
					end

					arg_142_1:RecordHistoryTalkVoice("story_v_out_104112", "104112035", "story_v_out_104112.awb")
				end

				arg_142_1:RecordContent(arg_142_1.text_.text)
			end

			local var_145_8 = math.max(var_145_1, arg_142_1.talkMaxDuration)

			if var_145_0 <= arg_142_1.time_ and arg_142_1.time_ < var_145_0 + var_145_8 then
				arg_142_1.typewritter.percent = (arg_142_1.time_ - var_145_0) / var_145_8

				arg_142_1.typewritter:SetDirty()
			end

			if arg_142_1.time_ >= var_145_0 + var_145_8 and arg_142_1.time_ < var_145_0 + var_145_8 + arg_145_0 then
				arg_142_1.typewritter.percent = 1

				arg_142_1.typewritter:SetDirty()
				arg_142_1:ShowNextGo(true)
			end
		end

		arg_142_1.nodeConfigList_ = {}

		arg_142_1:InitPlayNodeList()
	end,
	Play104112036 = function(arg_146_0, arg_146_1)
		arg_146_1.time_ = 0
		arg_146_1.frameCnt_ = 0
		arg_146_1.state_ = "playing"
		arg_146_1.curTalkId_ = 104112036
		arg_146_1.duration_ = 5.1

		local var_146_0 = {
			ja = 5.1,
			ko = 1.999999999999,
			zh = 2.166,
			en = 2.366
		}
		local var_146_1 = manager.audio:GetLocalizationFlag()

		if var_146_0[var_146_1] ~= nil then
			arg_146_1.duration_ = var_146_0[var_146_1]
		end

		SetActive(arg_146_1.tipsGo_, false)

		function arg_146_1.onSingleLineFinish_()
			arg_146_1.onSingleLineUpdate_ = nil
			arg_146_1.onSingleLineFinish_ = nil
			arg_146_1.state_ = "waiting"
		end

		function arg_146_1.playNext_(arg_148_0)
			if arg_148_0 == 1 then
				arg_146_0:Play104112037(arg_146_1)
			end
		end

		function arg_146_1.onSingleLineUpdate_(arg_149_0)
			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(arg_146_1.actors_["2020_tpose"]) and arg_146_1.var_.characterEffect2020_tpose == nil then
				arg_146_1.var_.characterEffect2020_tpose = arg_146_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_0 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_0 and not isNil(arg_146_1.actors_["2020_tpose"]) then
				if arg_146_1.var_.characterEffect2020_tpose and not isNil(arg_146_1.actors_["2020_tpose"]) then
					arg_146_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_146_1.time_ >= 0 + var_149_0 and arg_146_1.time_ < 0 + var_149_0 + arg_149_0 and not isNil(arg_146_1.actors_["2020_tpose"]) and arg_146_1.var_.characterEffect2020_tpose then
				arg_146_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_149_2 = arg_146_1.actors_["4010ui_story"]

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect4010ui_story == nil then
				arg_146_1.var_.characterEffect4010ui_story = var_149_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_149_3 = 0.1

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_3 and not isNil(var_149_2) then
				if arg_146_1.var_.characterEffect4010ui_story and not isNil(var_149_2) then
					arg_146_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_146_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_146_1.time_ - 0) / var_149_3)
				end
			end

			if arg_146_1.time_ >= 0 + var_149_3 and arg_146_1.time_ < 0 + var_149_3 + arg_149_0 and not isNil(var_149_2) and arg_146_1.var_.characterEffect4010ui_story then
				arg_146_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_146_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_149_4 = arg_146_1.actors_["4010ui_story"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos4010ui_story = var_149_4.localPosition
			end

			local var_149_5 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_5 then
				var_149_4.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_146_1.time_ - 0) / var_149_5)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_5 and arg_146_1.time_ < 0 + var_149_5 + arg_149_0 then
				var_149_4.localPosition = Vector3.New(0, 100, 0)
				var_149_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_4.position).x, (manager.ui.mainCamera.transform.position - var_149_4.position).y, (manager.ui.mainCamera.transform.position - var_149_4.position).z)
				var_149_4.localEulerAngles.z = 0
				var_149_4.localEulerAngles.x = 0
				var_149_4.localEulerAngles = var_149_4.localEulerAngles
			end

			local var_149_6 = arg_146_1.actors_["2020_tpose"].transform

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1.var_.moveOldPos2020_tpose = var_149_6.localPosition

				local var_149_7 = GameObjectTools.GetOrAddComponent(var_149_6.gameObject, typeof(DynamicBoneHelper))

				if var_149_7 then
					var_149_7:EnableDynamicBone(false)
				end
			end

			local var_149_8 = 0.001

			if 0 <= arg_146_1.time_ and arg_146_1.time_ < 0 + var_149_8 then
				var_149_6.localPosition = Vector3.Lerp(arg_146_1.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (arg_146_1.time_ - 0) / var_149_8)
				var_149_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_6.position).x, (manager.ui.mainCamera.transform.position - var_149_6.position).y, (manager.ui.mainCamera.transform.position - var_149_6.position).z)
				var_149_6.localEulerAngles.z = 0
				var_149_6.localEulerAngles.x = 0
				var_149_6.localEulerAngles = var_149_6.localEulerAngles
			end

			if arg_146_1.time_ >= 0 + var_149_8 and arg_146_1.time_ < 0 + var_149_8 + arg_149_0 then
				var_149_6.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				var_149_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_149_6.position).x, (manager.ui.mainCamera.transform.position - var_149_6.position).y, (manager.ui.mainCamera.transform.position - var_149_6.position).z)
				var_149_6.localEulerAngles.z = 0
				var_149_6.localEulerAngles.x = 0
				var_149_6.localEulerAngles = var_149_6.localEulerAngles

				local var_149_9 = GameObjectTools.GetOrAddComponent(var_149_6.gameObject, typeof(DynamicBoneHelper))

				if var_149_9 then
					var_149_9:EnableDynamicBone(true)
				end
			end

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= 0 + arg_149_0 then
				arg_146_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_149_10 = 0
			local var_149_11 = 0.125

			if 0 < arg_146_1.time_ and arg_146_1.time_ <= var_149_10 + arg_149_0 then
				arg_146_1.talkMaxDuration = 0
				arg_146_1.dialogCg_.alpha = 1

				arg_146_1.dialog_:SetActive(true)
				SetActive(arg_146_1.leftNameGo_, true)

				arg_146_1.leftNameTxt_.text = arg_146_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_146_1.leftNameTxt_.transform)

				arg_146_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_146_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_146_1:RecordName(arg_146_1.leftNameTxt_.text)
				SetActive(arg_146_1.iconTrs_.gameObject, false)
				arg_146_1.callingController_:SetSelectedState("normal")

				local var_149_12 = arg_146_1:GetWordFromCfg(104112036)
				local var_149_13 = arg_146_1:FormatText(var_149_12.content)

				arg_146_1.text_.text = var_149_13

				LuaForUtil.ClearLinePrefixSymbol(arg_146_1.text_)

				local var_149_15 = 5 <= 0 and var_149_11 or var_149_11 * (utf8.len(var_149_13) / 5)

				if (5 <= 0 and var_149_11 or var_149_11 * (utf8.len(var_149_13) / 5)) > 0 and var_149_11 < var_149_15 then
					arg_146_1.talkMaxDuration = var_149_15

					if var_149_15 + var_149_10 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_15 + var_149_10
					end
				end

				arg_146_1.text_.text = var_149_13
				arg_146_1.typewritter.percent = 0

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112036", "story_v_out_104112.awb") ~= 0 then
					local var_149_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112036", "story_v_out_104112.awb") / 1000

					if var_149_16 + var_149_10 > arg_146_1.duration_ then
						arg_146_1.duration_ = var_149_16 + var_149_10
					end

					if var_149_12.prefab_name ~= "" and arg_146_1.actors_[var_149_12.prefab_name] ~= nil then
						local var_149_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_146_1.actors_[var_149_12.prefab_name].transform, "story_v_out_104112", "104112036", "story_v_out_104112.awb")

						arg_146_1:RecordAudio("104112036", var_149_17)
						arg_146_1:RecordAudio("104112036", var_149_17)
					else
						arg_146_1:AudioAction("play", "voice", "story_v_out_104112", "104112036", "story_v_out_104112.awb")
					end

					arg_146_1:RecordHistoryTalkVoice("story_v_out_104112", "104112036", "story_v_out_104112.awb")
				end

				arg_146_1:RecordContent(arg_146_1.text_.text)
			end

			local var_149_18 = math.max(var_149_11, arg_146_1.talkMaxDuration)

			if var_149_10 <= arg_146_1.time_ and arg_146_1.time_ < var_149_10 + var_149_18 then
				arg_146_1.typewritter.percent = (arg_146_1.time_ - var_149_10) / var_149_18

				arg_146_1.typewritter:SetDirty()
			end

			if arg_146_1.time_ >= var_149_10 + var_149_18 and arg_146_1.time_ < var_149_10 + var_149_18 + arg_149_0 then
				arg_146_1.typewritter.percent = 1

				arg_146_1.typewritter:SetDirty()
				arg_146_1:ShowNextGo(true)
			end
		end

		arg_146_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_146_1:InitPlayNodeList()
	end,
	Play104112037 = function(arg_150_0, arg_150_1)
		arg_150_1.time_ = 0
		arg_150_1.frameCnt_ = 0
		arg_150_1.state_ = "playing"
		arg_150_1.curTalkId_ = 104112037
		arg_150_1.duration_ = 3.3

		local var_150_0 = {
			ja = 3.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_150_0:Play104112038(arg_150_1)
			end
		end

		function arg_150_1.onSingleLineUpdate_(arg_153_0)
			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(arg_150_1.actors_["2030_tpose"]) and arg_150_1.var_.characterEffect2030_tpose == nil then
				arg_150_1.var_.characterEffect2030_tpose = arg_150_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_0 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_0 and not isNil(arg_150_1.actors_["2030_tpose"]) then
				if arg_150_1.var_.characterEffect2030_tpose and not isNil(arg_150_1.actors_["2030_tpose"]) then
					arg_150_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_150_1.time_ >= 0 + var_153_0 and arg_150_1.time_ < 0 + var_153_0 + arg_153_0 and not isNil(arg_150_1.actors_["2030_tpose"]) and arg_150_1.var_.characterEffect2030_tpose then
				arg_150_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_153_2 = arg_150_1.actors_["2020_tpose"]

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect2020_tpose == nil then
				arg_150_1.var_.characterEffect2020_tpose = var_153_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_153_3 = 0.1

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_3 and not isNil(var_153_2) then
				if arg_150_1.var_.characterEffect2020_tpose and not isNil(var_153_2) then
					arg_150_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_150_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_150_1.time_ - 0) / var_153_3)
				end
			end

			if arg_150_1.time_ >= 0 + var_153_3 and arg_150_1.time_ < 0 + var_153_3 + arg_153_0 and not isNil(var_153_2) and arg_150_1.var_.characterEffect2020_tpose then
				arg_150_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_150_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_153_4 = arg_150_1.actors_["2030_tpose"].transform

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1.var_.moveOldPos2030_tpose = var_153_4.localPosition

				local var_153_5 = GameObjectTools.GetOrAddComponent(var_153_4.gameObject, typeof(DynamicBoneHelper))

				if var_153_5 then
					var_153_5:EnableDynamicBone(false)
				end
			end

			local var_153_6 = 0.001

			if 0 <= arg_150_1.time_ and arg_150_1.time_ < 0 + var_153_6 then
				var_153_4.localPosition = Vector3.Lerp(arg_150_1.var_.moveOldPos2030_tpose, Vector3.New(0.7, -1.2, -4.2), (arg_150_1.time_ - 0) / var_153_6)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles
			end

			if arg_150_1.time_ >= 0 + var_153_6 and arg_150_1.time_ < 0 + var_153_6 + arg_153_0 then
				var_153_4.localPosition = Vector3.New(0.7, -1.2, -4.2)
				var_153_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_153_4.position).x, (manager.ui.mainCamera.transform.position - var_153_4.position).y, (manager.ui.mainCamera.transform.position - var_153_4.position).z)
				var_153_4.localEulerAngles.z = 0
				var_153_4.localEulerAngles.x = 0
				var_153_4.localEulerAngles = var_153_4.localEulerAngles

				local var_153_7 = GameObjectTools.GetOrAddComponent(var_153_4.gameObject, typeof(DynamicBoneHelper))

				if var_153_7 then
					var_153_7:EnableDynamicBone(true)
				end
			end

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= 0 + arg_153_0 then
				arg_150_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_153_8 = 0
			local var_153_9 = 0.2

			if 0 < arg_150_1.time_ and arg_150_1.time_ <= var_153_8 + arg_153_0 then
				arg_150_1.talkMaxDuration = 0
				arg_150_1.dialogCg_.alpha = 1

				arg_150_1.dialog_:SetActive(true)
				SetActive(arg_150_1.leftNameGo_, true)

				arg_150_1.leftNameTxt_.text = arg_150_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_150_1.leftNameTxt_.transform)

				arg_150_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_150_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_150_1:RecordName(arg_150_1.leftNameTxt_.text)
				SetActive(arg_150_1.iconTrs_.gameObject, false)
				arg_150_1.callingController_:SetSelectedState("normal")

				local var_153_10 = arg_150_1:GetWordFromCfg(104112037)
				local var_153_11 = arg_150_1:FormatText(var_153_10.content)

				arg_150_1.text_.text = var_153_11

				LuaForUtil.ClearLinePrefixSymbol(arg_150_1.text_)

				local var_153_13 = 8 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 8)

				if (8 <= 0 and var_153_9 or var_153_9 * (utf8.len(var_153_11) / 8)) > 0 and var_153_9 < var_153_13 then
					arg_150_1.talkMaxDuration = var_153_13

					if var_153_13 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_13 + var_153_8
					end
				end

				arg_150_1.text_.text = var_153_11
				arg_150_1.typewritter.percent = 0

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112037", "story_v_out_104112.awb") ~= 0 then
					local var_153_14 = manager.audio:GetVoiceLength("story_v_out_104112", "104112037", "story_v_out_104112.awb") / 1000

					if var_153_14 + var_153_8 > arg_150_1.duration_ then
						arg_150_1.duration_ = var_153_14 + var_153_8
					end

					if var_153_10.prefab_name ~= "" and arg_150_1.actors_[var_153_10.prefab_name] ~= nil then
						local var_153_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_150_1.actors_[var_153_10.prefab_name].transform, "story_v_out_104112", "104112037", "story_v_out_104112.awb")

						arg_150_1:RecordAudio("104112037", var_153_15)
						arg_150_1:RecordAudio("104112037", var_153_15)
					else
						arg_150_1:AudioAction("play", "voice", "story_v_out_104112", "104112037", "story_v_out_104112.awb")
					end

					arg_150_1:RecordHistoryTalkVoice("story_v_out_104112", "104112037", "story_v_out_104112.awb")
				end

				arg_150_1:RecordContent(arg_150_1.text_.text)
			end

			local var_153_16 = math.max(var_153_9, arg_150_1.talkMaxDuration)

			if var_153_8 <= arg_150_1.time_ and arg_150_1.time_ < var_153_8 + var_153_16 then
				arg_150_1.typewritter.percent = (arg_150_1.time_ - var_153_8) / var_153_16

				arg_150_1.typewritter:SetDirty()
			end

			if arg_150_1.time_ >= var_153_8 + var_153_16 and arg_150_1.time_ < var_153_8 + var_153_16 + arg_153_0 then
				arg_150_1.typewritter.percent = 1

				arg_150_1.typewritter:SetDirty()
				arg_150_1:ShowNextGo(true)
			end
		end

		arg_150_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_150_1:InitPlayNodeList()
	end,
	Play104112038 = function(arg_154_0, arg_154_1)
		arg_154_1.time_ = 0
		arg_154_1.frameCnt_ = 0
		arg_154_1.state_ = "playing"
		arg_154_1.curTalkId_ = 104112038
		arg_154_1.duration_ = 4.1

		local var_154_0 = {
			ja = 4.1,
			ko = 2,
			zh = 2.366,
			en = 1.833
		}
		local var_154_1 = manager.audio:GetLocalizationFlag()

		if var_154_0[var_154_1] ~= nil then
			arg_154_1.duration_ = var_154_0[var_154_1]
		end

		SetActive(arg_154_1.tipsGo_, false)

		function arg_154_1.onSingleLineFinish_()
			arg_154_1.onSingleLineUpdate_ = nil
			arg_154_1.onSingleLineFinish_ = nil
			arg_154_1.state_ = "waiting"
		end

		function arg_154_1.playNext_(arg_156_0)
			if arg_156_0 == 1 then
				arg_154_0:Play104112039(arg_154_1)
			end
		end

		function arg_154_1.onSingleLineUpdate_(arg_157_0)
			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(arg_154_1.actors_["2020_tpose"]) and arg_154_1.var_.characterEffect2020_tpose == nil then
				arg_154_1.var_.characterEffect2020_tpose = arg_154_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_0 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_0 and not isNil(arg_154_1.actors_["2020_tpose"]) then
				if arg_154_1.var_.characterEffect2020_tpose and not isNil(arg_154_1.actors_["2020_tpose"]) then
					arg_154_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_154_1.time_ >= 0 + var_157_0 and arg_154_1.time_ < 0 + var_157_0 + arg_157_0 and not isNil(arg_154_1.actors_["2020_tpose"]) and arg_154_1.var_.characterEffect2020_tpose then
				arg_154_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_157_2 = arg_154_1.actors_["2030_tpose"]

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= 0 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect2030_tpose == nil then
				arg_154_1.var_.characterEffect2030_tpose = var_157_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_157_3 = 0.1

			if 0 <= arg_154_1.time_ and arg_154_1.time_ < 0 + var_157_3 and not isNil(var_157_2) then
				if arg_154_1.var_.characterEffect2030_tpose and not isNil(var_157_2) then
					arg_154_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_154_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_154_1.time_ - 0) / var_157_3)
				end
			end

			if arg_154_1.time_ >= 0 + var_157_3 and arg_154_1.time_ < 0 + var_157_3 + arg_157_0 and not isNil(var_157_2) and arg_154_1.var_.characterEffect2030_tpose then
				arg_154_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_154_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_157_4 = 0
			local var_157_5 = 0.25

			if 0 < arg_154_1.time_ and arg_154_1.time_ <= var_157_4 + arg_157_0 then
				arg_154_1.talkMaxDuration = 0
				arg_154_1.dialogCg_.alpha = 1

				arg_154_1.dialog_:SetActive(true)
				SetActive(arg_154_1.leftNameGo_, true)

				arg_154_1.leftNameTxt_.text = arg_154_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_154_1.leftNameTxt_.transform)

				arg_154_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_154_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_154_1:RecordName(arg_154_1.leftNameTxt_.text)
				SetActive(arg_154_1.iconTrs_.gameObject, false)
				arg_154_1.callingController_:SetSelectedState("normal")

				local var_157_6 = arg_154_1:GetWordFromCfg(104112038)
				local var_157_7 = arg_154_1:FormatText(var_157_6.content)

				arg_154_1.text_.text = var_157_7

				LuaForUtil.ClearLinePrefixSymbol(arg_154_1.text_)

				local var_157_9 = 10 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 10)

				if (10 <= 0 and var_157_5 or var_157_5 * (utf8.len(var_157_7) / 10)) > 0 and var_157_5 < var_157_9 then
					arg_154_1.talkMaxDuration = var_157_9

					if var_157_9 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_9 + var_157_4
					end
				end

				arg_154_1.text_.text = var_157_7
				arg_154_1.typewritter.percent = 0

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112038", "story_v_out_104112.awb") ~= 0 then
					local var_157_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112038", "story_v_out_104112.awb") / 1000

					if var_157_10 + var_157_4 > arg_154_1.duration_ then
						arg_154_1.duration_ = var_157_10 + var_157_4
					end

					if var_157_6.prefab_name ~= "" and arg_154_1.actors_[var_157_6.prefab_name] ~= nil then
						local var_157_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_154_1.actors_[var_157_6.prefab_name].transform, "story_v_out_104112", "104112038", "story_v_out_104112.awb")

						arg_154_1:RecordAudio("104112038", var_157_11)
						arg_154_1:RecordAudio("104112038", var_157_11)
					else
						arg_154_1:AudioAction("play", "voice", "story_v_out_104112", "104112038", "story_v_out_104112.awb")
					end

					arg_154_1:RecordHistoryTalkVoice("story_v_out_104112", "104112038", "story_v_out_104112.awb")
				end

				arg_154_1:RecordContent(arg_154_1.text_.text)
			end

			local var_157_12 = math.max(var_157_5, arg_154_1.talkMaxDuration)

			if var_157_4 <= arg_154_1.time_ and arg_154_1.time_ < var_157_4 + var_157_12 then
				arg_154_1.typewritter.percent = (arg_154_1.time_ - var_157_4) / var_157_12

				arg_154_1.typewritter:SetDirty()
			end

			if arg_154_1.time_ >= var_157_4 + var_157_12 and arg_154_1.time_ < var_157_4 + var_157_12 + arg_157_0 then
				arg_154_1.typewritter.percent = 1

				arg_154_1.typewritter:SetDirty()
				arg_154_1:ShowNextGo(true)
			end
		end

		arg_154_1.nodeConfigList_ = {}

		arg_154_1:InitPlayNodeList()
	end,
	Play104112039 = function(arg_158_0, arg_158_1)
		arg_158_1.time_ = 0
		arg_158_1.frameCnt_ = 0
		arg_158_1.state_ = "playing"
		arg_158_1.curTalkId_ = 104112039
		arg_158_1.duration_ = 2

		local var_158_0 = {
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
			en = 1.999999999999
		}
		local var_158_1 = manager.audio:GetLocalizationFlag()

		if var_158_0[var_158_1] ~= nil then
			arg_158_1.duration_ = var_158_0[var_158_1]
		end

		SetActive(arg_158_1.tipsGo_, false)

		function arg_158_1.onSingleLineFinish_()
			arg_158_1.onSingleLineUpdate_ = nil
			arg_158_1.onSingleLineFinish_ = nil
			arg_158_1.state_ = "waiting"
		end

		function arg_158_1.playNext_(arg_160_0)
			if arg_160_0 == 1 then
				arg_158_0:Play104112040(arg_158_1)
			end
		end

		function arg_158_1.onSingleLineUpdate_(arg_161_0)
			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(arg_158_1.actors_["4010ui_story"]) and arg_158_1.var_.characterEffect4010ui_story == nil then
				arg_158_1.var_.characterEffect4010ui_story = arg_158_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_0 = 0.1

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_0 and not isNil(arg_158_1.actors_["4010ui_story"]) then
				if arg_158_1.var_.characterEffect4010ui_story and not isNil(arg_158_1.actors_["4010ui_story"]) then
					arg_158_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_158_1.time_ >= 0 + var_161_0 and arg_158_1.time_ < 0 + var_161_0 + arg_161_0 and not isNil(arg_158_1.actors_["4010ui_story"]) and arg_158_1.var_.characterEffect4010ui_story then
				arg_158_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_161_2 = arg_158_1.actors_["2020_tpose"]

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect2020_tpose == nil then
				arg_158_1.var_.characterEffect2020_tpose = var_161_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_161_3 = 0.1

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_3 and not isNil(var_161_2) then
				if arg_158_1.var_.characterEffect2020_tpose and not isNil(var_161_2) then
					arg_158_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_158_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_158_1.time_ - 0) / var_161_3)
				end
			end

			if arg_158_1.time_ >= 0 + var_161_3 and arg_158_1.time_ < 0 + var_161_3 + arg_161_0 and not isNil(var_161_2) and arg_158_1.var_.characterEffect2020_tpose then
				arg_158_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_158_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_161_4 = arg_158_1.actors_["2030_tpose"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos2030_tpose = var_161_4.localPosition

				local var_161_5 = GameObjectTools.GetOrAddComponent(var_161_4.gameObject, typeof(DynamicBoneHelper))

				if var_161_5 then
					var_161_5:EnableDynamicBone(false)
				end
			end

			local var_161_6 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_6 then
				var_161_4.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_158_1.time_ - 0) / var_161_6)
				var_161_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_4.position).x, (manager.ui.mainCamera.transform.position - var_161_4.position).y, (manager.ui.mainCamera.transform.position - var_161_4.position).z)
				var_161_4.localEulerAngles.z = 0
				var_161_4.localEulerAngles.x = 0
				var_161_4.localEulerAngles = var_161_4.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_6 and arg_158_1.time_ < 0 + var_161_6 + arg_161_0 then
				var_161_4.localPosition = Vector3.New(0, 100, 0)
				var_161_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_4.position).x, (manager.ui.mainCamera.transform.position - var_161_4.position).y, (manager.ui.mainCamera.transform.position - var_161_4.position).z)
				var_161_4.localEulerAngles.z = 0
				var_161_4.localEulerAngles.x = 0
				var_161_4.localEulerAngles = var_161_4.localEulerAngles

				local var_161_7 = GameObjectTools.GetOrAddComponent(var_161_4.gameObject, typeof(DynamicBoneHelper))

				if var_161_7 then
					var_161_7:EnableDynamicBone(true)
				end
			end

			local var_161_8 = arg_158_1.actors_["2020_tpose"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos2020_tpose = var_161_8.localPosition

				local var_161_9 = GameObjectTools.GetOrAddComponent(var_161_8.gameObject, typeof(DynamicBoneHelper))

				if var_161_9 then
					var_161_9:EnableDynamicBone(false)
				end
			end

			local var_161_10 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_10 then
				var_161_8.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_158_1.time_ - 0) / var_161_10)
				var_161_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_8.position).x, (manager.ui.mainCamera.transform.position - var_161_8.position).y, (manager.ui.mainCamera.transform.position - var_161_8.position).z)
				var_161_8.localEulerAngles.z = 0
				var_161_8.localEulerAngles.x = 0
				var_161_8.localEulerAngles = var_161_8.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_10 and arg_158_1.time_ < 0 + var_161_10 + arg_161_0 then
				var_161_8.localPosition = Vector3.New(0, 100, 0)
				var_161_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_8.position).x, (manager.ui.mainCamera.transform.position - var_161_8.position).y, (manager.ui.mainCamera.transform.position - var_161_8.position).z)
				var_161_8.localEulerAngles.z = 0
				var_161_8.localEulerAngles.x = 0
				var_161_8.localEulerAngles = var_161_8.localEulerAngles

				local var_161_11 = GameObjectTools.GetOrAddComponent(var_161_8.gameObject, typeof(DynamicBoneHelper))

				if var_161_11 then
					var_161_11:EnableDynamicBone(true)
				end
			end

			local var_161_12 = arg_158_1.actors_["4010ui_story"].transform

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1.var_.moveOldPos4010ui_story = var_161_12.localPosition
			end

			local var_161_13 = 0.001

			if 0 <= arg_158_1.time_ and arg_158_1.time_ < 0 + var_161_13 then
				var_161_12.localPosition = Vector3.Lerp(arg_158_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_158_1.time_ - 0) / var_161_13)
				var_161_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_12.position).x, (manager.ui.mainCamera.transform.position - var_161_12.position).y, (manager.ui.mainCamera.transform.position - var_161_12.position).z)
				var_161_12.localEulerAngles.z = 0
				var_161_12.localEulerAngles.x = 0
				var_161_12.localEulerAngles = var_161_12.localEulerAngles
			end

			if arg_158_1.time_ >= 0 + var_161_13 and arg_158_1.time_ < 0 + var_161_13 + arg_161_0 then
				var_161_12.localPosition = Vector3.New(0, -1.59, -5.2)
				var_161_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_161_12.position).x, (manager.ui.mainCamera.transform.position - var_161_12.position).y, (manager.ui.mainCamera.transform.position - var_161_12.position).z)
				var_161_12.localEulerAngles.z = 0
				var_161_12.localEulerAngles.x = 0
				var_161_12.localEulerAngles = var_161_12.localEulerAngles
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= 0 + arg_161_0 then
				arg_158_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			local var_161_14 = 0
			local var_161_15 = 0.075

			if 0 < arg_158_1.time_ and arg_158_1.time_ <= var_161_14 + arg_161_0 then
				arg_158_1.talkMaxDuration = 0
				arg_158_1.dialogCg_.alpha = 1

				arg_158_1.dialog_:SetActive(true)
				SetActive(arg_158_1.leftNameGo_, true)

				arg_158_1.leftNameTxt_.text = arg_158_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_158_1.leftNameTxt_.transform)

				arg_158_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_158_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_158_1:RecordName(arg_158_1.leftNameTxt_.text)
				SetActive(arg_158_1.iconTrs_.gameObject, false)
				arg_158_1.callingController_:SetSelectedState("normal")

				local var_161_16 = arg_158_1:GetWordFromCfg(104112039)
				local var_161_17 = arg_158_1:FormatText(var_161_16.content)

				arg_158_1.text_.text = var_161_17

				LuaForUtil.ClearLinePrefixSymbol(arg_158_1.text_)

				local var_161_19 = 3 <= 0 and var_161_15 or var_161_15 * (utf8.len(var_161_17) / 3)

				if (3 <= 0 and var_161_15 or var_161_15 * (utf8.len(var_161_17) / 3)) > 0 and var_161_15 < var_161_19 then
					arg_158_1.talkMaxDuration = var_161_19

					if var_161_19 + var_161_14 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_19 + var_161_14
					end
				end

				arg_158_1.text_.text = var_161_17
				arg_158_1.typewritter.percent = 0

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112039", "story_v_out_104112.awb") ~= 0 then
					local var_161_20 = manager.audio:GetVoiceLength("story_v_out_104112", "104112039", "story_v_out_104112.awb") / 1000

					if var_161_20 + var_161_14 > arg_158_1.duration_ then
						arg_158_1.duration_ = var_161_20 + var_161_14
					end

					if var_161_16.prefab_name ~= "" and arg_158_1.actors_[var_161_16.prefab_name] ~= nil then
						local var_161_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_158_1.actors_[var_161_16.prefab_name].transform, "story_v_out_104112", "104112039", "story_v_out_104112.awb")

						arg_158_1:RecordAudio("104112039", var_161_21)
						arg_158_1:RecordAudio("104112039", var_161_21)
					else
						arg_158_1:AudioAction("play", "voice", "story_v_out_104112", "104112039", "story_v_out_104112.awb")
					end

					arg_158_1:RecordHistoryTalkVoice("story_v_out_104112", "104112039", "story_v_out_104112.awb")
				end

				arg_158_1:RecordContent(arg_158_1.text_.text)
			end

			local var_161_22 = math.max(var_161_15, arg_158_1.talkMaxDuration)

			if var_161_14 <= arg_158_1.time_ and arg_158_1.time_ < var_161_14 + var_161_22 then
				arg_158_1.typewritter.percent = (arg_158_1.time_ - var_161_14) / var_161_22

				arg_158_1.typewritter:SetDirty()
			end

			if arg_158_1.time_ >= var_161_14 + var_161_22 and arg_158_1.time_ < var_161_14 + var_161_22 + arg_161_0 then
				arg_158_1.typewritter.percent = 1

				arg_158_1.typewritter:SetDirty()
				arg_158_1:ShowNextGo(true)
			end
		end

		arg_158_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2030_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "2020_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_158_1:InitPlayNodeList()
	end,
	Play104112040 = function(arg_162_0, arg_162_1)
		arg_162_1.time_ = 0
		arg_162_1.frameCnt_ = 0
		arg_162_1.state_ = "playing"
		arg_162_1.curTalkId_ = 104112040
		arg_162_1.duration_ = 5

		SetActive(arg_162_1.tipsGo_, false)

		function arg_162_1.onSingleLineFinish_()
			arg_162_1.onSingleLineUpdate_ = nil
			arg_162_1.onSingleLineFinish_ = nil
			arg_162_1.state_ = "waiting"
		end

		function arg_162_1.playNext_(arg_164_0)
			if arg_164_0 == 1 then
				arg_162_0:Play104112041(arg_162_1)
			end
		end

		function arg_162_1.onSingleLineUpdate_(arg_165_0)
			if 0 < arg_162_1.time_ and arg_162_1.time_ <= 0 + arg_165_0 and not isNil(arg_162_1.actors_["4010ui_story"]) and arg_162_1.var_.characterEffect4010ui_story == nil then
				arg_162_1.var_.characterEffect4010ui_story = arg_162_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_165_0 = 0.1

			if 0 <= arg_162_1.time_ and arg_162_1.time_ < 0 + var_165_0 and not isNil(arg_162_1.actors_["4010ui_story"]) then
				if arg_162_1.var_.characterEffect4010ui_story and not isNil(arg_162_1.actors_["4010ui_story"]) then
					arg_162_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_162_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_162_1.time_ - 0) / var_165_0)
				end
			end

			if arg_162_1.time_ >= 0 + var_165_0 and arg_162_1.time_ < 0 + var_165_0 + arg_165_0 and not isNil(arg_162_1.actors_["4010ui_story"]) and arg_162_1.var_.characterEffect4010ui_story then
				arg_162_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_162_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_165_1 = 0
			local var_165_2 = 0.675

			if 0 < arg_162_1.time_ and arg_162_1.time_ <= var_165_1 + arg_165_0 then
				arg_162_1.talkMaxDuration = 0
				arg_162_1.dialogCg_.alpha = 1

				arg_162_1.dialog_:SetActive(true)
				SetActive(arg_162_1.leftNameGo_, false)

				arg_162_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_162_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_162_1:RecordName(arg_162_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_162_1.iconTrs_.gameObject, false)
				arg_162_1.callingController_:SetSelectedState("normal")

				local var_165_3 = arg_162_1:FormatText(arg_162_1:GetWordFromCfg(104112040).content)

				arg_162_1.text_.text = var_165_3

				LuaForUtil.ClearLinePrefixSymbol(arg_162_1.text_)

				local var_165_5 = 27 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 27)

				if (27 <= 0 and var_165_2 or var_165_2 * (utf8.len(var_165_3) / 27)) > 0 and var_165_2 < var_165_5 then
					arg_162_1.talkMaxDuration = var_165_5

					if var_165_5 + var_165_1 > arg_162_1.duration_ then
						arg_162_1.duration_ = var_165_5 + var_165_1
					end
				end

				arg_162_1.text_.text = var_165_3
				arg_162_1.typewritter.percent = 0

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(false)
				arg_162_1:RecordContent(arg_162_1.text_.text)
			end

			local var_165_6 = math.max(var_165_2, arg_162_1.talkMaxDuration)

			if var_165_1 <= arg_162_1.time_ and arg_162_1.time_ < var_165_1 + var_165_6 then
				arg_162_1.typewritter.percent = (arg_162_1.time_ - var_165_1) / var_165_6

				arg_162_1.typewritter:SetDirty()
			end

			if arg_162_1.time_ >= var_165_1 + var_165_6 and arg_162_1.time_ < var_165_1 + var_165_6 + arg_165_0 then
				arg_162_1.typewritter.percent = 1

				arg_162_1.typewritter:SetDirty()
				arg_162_1:ShowNextGo(true)
			end
		end

		arg_162_1.nodeConfigList_ = {}

		arg_162_1:InitPlayNodeList()
	end,
	Play104112041 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 104112041
		arg_166_1.duration_ = 8.1

		local var_166_0 = {
			ja = 8.1,
			ko = 6.9,
			zh = 6.566,
			en = 7.766
		}
		local var_166_1 = manager.audio:GetLocalizationFlag()

		if var_166_0[var_166_1] ~= nil then
			arg_166_1.duration_ = var_166_0[var_166_1]
		end

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play104112042(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(arg_166_1.actors_["4010ui_story"]) and arg_166_1.var_.characterEffect4010ui_story == nil then
				arg_166_1.var_.characterEffect4010ui_story = arg_166_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_0 = 0.1

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_0 and not isNil(arg_166_1.actors_["4010ui_story"]) then
				if arg_166_1.var_.characterEffect4010ui_story and not isNil(arg_166_1.actors_["4010ui_story"]) then
					arg_166_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_0 and arg_166_1.time_ < 0 + var_169_0 + arg_169_0 and not isNil(arg_166_1.actors_["4010ui_story"]) and arg_166_1.var_.characterEffect4010ui_story then
				arg_166_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_169_2 = 0
			local var_169_3 = 0.65

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_2 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_4 = arg_166_1:GetWordFromCfg(104112041)
				local var_169_5 = arg_166_1:FormatText(var_169_4.content)

				arg_166_1.text_.text = var_169_5

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_7 = 26 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 26)

				if (26 <= 0 and var_169_3 or var_169_3 * (utf8.len(var_169_5) / 26)) > 0 and var_169_3 < var_169_7 then
					arg_166_1.talkMaxDuration = var_169_7

					if var_169_7 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_7 + var_169_2
					end
				end

				arg_166_1.text_.text = var_169_5
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112041", "story_v_out_104112.awb") ~= 0 then
					local var_169_8 = manager.audio:GetVoiceLength("story_v_out_104112", "104112041", "story_v_out_104112.awb") / 1000

					if var_169_8 + var_169_2 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_8 + var_169_2
					end

					if var_169_4.prefab_name ~= "" and arg_166_1.actors_[var_169_4.prefab_name] ~= nil then
						local var_169_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_166_1.actors_[var_169_4.prefab_name].transform, "story_v_out_104112", "104112041", "story_v_out_104112.awb")

						arg_166_1:RecordAudio("104112041", var_169_9)
						arg_166_1:RecordAudio("104112041", var_169_9)
					else
						arg_166_1:AudioAction("play", "voice", "story_v_out_104112", "104112041", "story_v_out_104112.awb")
					end

					arg_166_1:RecordHistoryTalkVoice("story_v_out_104112", "104112041", "story_v_out_104112.awb")
				end

				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_10 = math.max(var_169_3, arg_166_1.talkMaxDuration)

			if var_169_2 <= arg_166_1.time_ and arg_166_1.time_ < var_169_2 + var_169_10 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_2) / var_169_10

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_2 + var_169_10 and arg_166_1.time_ < var_169_2 + var_169_10 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {}

		arg_166_1:InitPlayNodeList()
	end,
	Play104112042 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 104112042
		arg_170_1.duration_ = 9.77

		local var_170_0 = {
			ja = 8.933,
			ko = 9.333,
			zh = 8.833,
			en = 9.766
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
				arg_170_0:Play104112043(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_173_0 = 0
			local var_173_1 = 1

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_0 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, true)

				arg_170_1.leftNameTxt_.text = arg_170_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_170_1.leftNameTxt_.transform)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1.leftNameTxt_.text)
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_2 = arg_170_1:GetWordFromCfg(104112042)
				local var_173_3 = arg_170_1:FormatText(var_173_2.content)

				arg_170_1.text_.text = var_173_3

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_5 = 40 <= 0 and var_173_1 or var_173_1 * (utf8.len(var_173_3) / 40)

				if (40 <= 0 and var_173_1 or var_173_1 * (utf8.len(var_173_3) / 40)) > 0 and var_173_1 < var_173_5 then
					arg_170_1.talkMaxDuration = var_173_5

					if var_173_5 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_5 + var_173_0
					end
				end

				arg_170_1.text_.text = var_173_3
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112042", "story_v_out_104112.awb") ~= 0 then
					local var_173_6 = manager.audio:GetVoiceLength("story_v_out_104112", "104112042", "story_v_out_104112.awb") / 1000

					if var_173_6 + var_173_0 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_6 + var_173_0
					end

					if var_173_2.prefab_name ~= "" and arg_170_1.actors_[var_173_2.prefab_name] ~= nil then
						local var_173_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_170_1.actors_[var_173_2.prefab_name].transform, "story_v_out_104112", "104112042", "story_v_out_104112.awb")

						arg_170_1:RecordAudio("104112042", var_173_7)
						arg_170_1:RecordAudio("104112042", var_173_7)
					else
						arg_170_1:AudioAction("play", "voice", "story_v_out_104112", "104112042", "story_v_out_104112.awb")
					end

					arg_170_1:RecordHistoryTalkVoice("story_v_out_104112", "104112042", "story_v_out_104112.awb")
				end

				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_1, arg_170_1.talkMaxDuration)

			if var_173_0 <= arg_170_1.time_ and arg_170_1.time_ < var_173_0 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_0) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_0 + var_173_8 and arg_170_1.time_ < var_173_0 + var_173_8 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {}

		arg_170_1:InitPlayNodeList()
	end,
	Play104112043 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 104112043
		arg_174_1.duration_ = 4.9

		local var_174_0 = {
			ja = 4.9,
			ko = 2.6,
			zh = 3.333,
			en = 2.6
		}
		local var_174_1 = manager.audio:GetLocalizationFlag()

		if var_174_0[var_174_1] ~= nil then
			arg_174_1.duration_ = var_174_0[var_174_1]
		end

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play104112044(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 and not isNil(arg_174_1.actors_["4010ui_story"]) and arg_174_1.var_.characterEffect4010ui_story == nil then
				arg_174_1.var_.characterEffect4010ui_story = arg_174_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_177_0 = 0.1

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_0 and not isNil(arg_174_1.actors_["4010ui_story"]) then
				if arg_174_1.var_.characterEffect4010ui_story and not isNil(arg_174_1.actors_["4010ui_story"]) then
					arg_174_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_174_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_174_1.time_ - 0) / var_177_0)
				end
			end

			if arg_174_1.time_ >= 0 + var_177_0 and arg_174_1.time_ < 0 + var_177_0 + arg_177_0 and not isNil(arg_174_1.actors_["4010ui_story"]) and arg_174_1.var_.characterEffect4010ui_story then
				arg_174_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_174_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_177_1 = arg_174_1.actors_["4010ui_story"].transform

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.var_.moveOldPos4010ui_story = var_177_1.localPosition
			end

			local var_177_2 = 0.001

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_2 then
				var_177_1.localPosition = Vector3.Lerp(arg_174_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_174_1.time_ - 0) / var_177_2)
				var_177_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_1.position).x, (manager.ui.mainCamera.transform.position - var_177_1.position).y, (manager.ui.mainCamera.transform.position - var_177_1.position).z)
				var_177_1.localEulerAngles.z = 0
				var_177_1.localEulerAngles.x = 0
				var_177_1.localEulerAngles = var_177_1.localEulerAngles
			end

			if arg_174_1.time_ >= 0 + var_177_2 and arg_174_1.time_ < 0 + var_177_2 + arg_177_0 then
				var_177_1.localPosition = Vector3.New(0, 100, 0)
				var_177_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_177_1.position).x, (manager.ui.mainCamera.transform.position - var_177_1.position).y, (manager.ui.mainCamera.transform.position - var_177_1.position).z)
				var_177_1.localEulerAngles.z = 0
				var_177_1.localEulerAngles.x = 0
				var_177_1.localEulerAngles = var_177_1.localEulerAngles
			end

			local var_177_3 = 0
			local var_177_4 = 0.3

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= var_177_3 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_5 = arg_174_1:GetWordFromCfg(104112043)
				local var_177_6 = arg_174_1:FormatText(var_177_5.content)

				arg_174_1.text_.text = var_177_6

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_8 = 12 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_6) / 12)

				if (12 <= 0 and var_177_4 or var_177_4 * (utf8.len(var_177_6) / 12)) > 0 and var_177_4 < var_177_8 then
					arg_174_1.talkMaxDuration = var_177_8

					if var_177_8 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_8 + var_177_3
					end
				end

				arg_174_1.text_.text = var_177_6
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112043", "story_v_out_104112.awb") ~= 0 then
					local var_177_9 = manager.audio:GetVoiceLength("story_v_out_104112", "104112043", "story_v_out_104112.awb") / 1000

					if var_177_9 + var_177_3 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_9 + var_177_3
					end

					if var_177_5.prefab_name ~= "" and arg_174_1.actors_[var_177_5.prefab_name] ~= nil then
						local var_177_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_174_1.actors_[var_177_5.prefab_name].transform, "story_v_out_104112", "104112043", "story_v_out_104112.awb")

						arg_174_1:RecordAudio("104112043", var_177_10)
						arg_174_1:RecordAudio("104112043", var_177_10)
					else
						arg_174_1:AudioAction("play", "voice", "story_v_out_104112", "104112043", "story_v_out_104112.awb")
					end

					arg_174_1:RecordHistoryTalkVoice("story_v_out_104112", "104112043", "story_v_out_104112.awb")
				end

				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_11 = math.max(var_177_4, arg_174_1.talkMaxDuration)

			if var_177_3 <= arg_174_1.time_ and arg_174_1.time_ < var_177_3 + var_177_11 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - var_177_3) / var_177_11

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= var_177_3 + var_177_11 and arg_174_1.time_ < var_177_3 + var_177_11 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_174_1:InitPlayNodeList()
	end,
	Play104112044 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 104112044
		arg_178_1.duration_ = 8.1

		local var_178_0 = {
			ja = 6.2,
			ko = 8.1,
			zh = 7.166,
			en = 6.333
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
				arg_178_0:Play104112045(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			local var_181_0 = 0.95

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, true)
				arg_178_1.iconController_:SetSelectedState("hero")

				arg_178_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				arg_178_1.callingController_:SetSelectedState("normal")

				arg_178_1.keyicon_.color = Color.New(1, 1, 1)
				arg_178_1.icon_.color = Color.New(1, 1, 1)

				local var_181_1 = arg_178_1:GetWordFromCfg(104112044)
				local var_181_2 = arg_178_1:FormatText(var_181_1.content)

				arg_178_1.text_.text = var_181_2

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_4 = 39 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 39)

				if (39 <= 0 and var_181_0 or var_181_0 * (utf8.len(var_181_2) / 39)) > 0 and var_181_0 < var_181_4 then
					arg_178_1.talkMaxDuration = var_181_4

					if var_181_4 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_4 + 0
					end
				end

				arg_178_1.text_.text = var_181_2
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112044", "story_v_out_104112.awb") ~= 0 then
					local var_181_5 = manager.audio:GetVoiceLength("story_v_out_104112", "104112044", "story_v_out_104112.awb") / 1000

					if var_181_5 + 0 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_5 + 0
					end

					if var_181_1.prefab_name ~= "" and arg_178_1.actors_[var_181_1.prefab_name] ~= nil then
						local var_181_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_178_1.actors_[var_181_1.prefab_name].transform, "story_v_out_104112", "104112044", "story_v_out_104112.awb")

						arg_178_1:RecordAudio("104112044", var_181_6)
						arg_178_1:RecordAudio("104112044", var_181_6)
					else
						arg_178_1:AudioAction("play", "voice", "story_v_out_104112", "104112044", "story_v_out_104112.awb")
					end

					arg_178_1:RecordHistoryTalkVoice("story_v_out_104112", "104112044", "story_v_out_104112.awb")
				end

				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_7 = math.max(var_181_0, arg_178_1.talkMaxDuration)

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_7 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - 0) / var_181_7

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= 0 + var_181_7 and arg_178_1.time_ < 0 + var_181_7 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {}

		arg_178_1:InitPlayNodeList()
	end,
	Play104112045 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 104112045
		arg_182_1.duration_ = 5.1

		local var_182_0 = {
			ja = 3.1,
			ko = 3.066,
			zh = 3.733,
			en = 5.1
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
				arg_182_0:Play104112046(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			local var_185_0 = 0.425

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, true)

				arg_182_1.leftNameTxt_.text = arg_182_1:FormatText(StoryNameCfg[65].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_182_1.leftNameTxt_.transform)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1.leftNameTxt_.text)
				SetActive(arg_182_1.iconTrs_.gameObject, true)
				arg_182_1.iconController_:SetSelectedState("hero")

				arg_182_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_182_1.callingController_:SetSelectedState("normal")

				arg_182_1.keyicon_.color = Color.New(1, 1, 1)
				arg_182_1.icon_.color = Color.New(1, 1, 1)

				local var_185_1 = arg_182_1:GetWordFromCfg(104112045)
				local var_185_2 = arg_182_1:FormatText(var_185_1.content)

				arg_182_1.text_.text = var_185_2

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_4 = 17 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 17)

				if (17 <= 0 and var_185_0 or var_185_0 * (utf8.len(var_185_2) / 17)) > 0 and var_185_0 < var_185_4 then
					arg_182_1.talkMaxDuration = var_185_4

					if var_185_4 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_4 + 0
					end
				end

				arg_182_1.text_.text = var_185_2
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112045", "story_v_out_104112.awb") ~= 0 then
					local var_185_5 = manager.audio:GetVoiceLength("story_v_out_104112", "104112045", "story_v_out_104112.awb") / 1000

					if var_185_5 + 0 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_5 + 0
					end

					if var_185_1.prefab_name ~= "" and arg_182_1.actors_[var_185_1.prefab_name] ~= nil then
						local var_185_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_182_1.actors_[var_185_1.prefab_name].transform, "story_v_out_104112", "104112045", "story_v_out_104112.awb")

						arg_182_1:RecordAudio("104112045", var_185_6)
						arg_182_1:RecordAudio("104112045", var_185_6)
					else
						arg_182_1:AudioAction("play", "voice", "story_v_out_104112", "104112045", "story_v_out_104112.awb")
					end

					arg_182_1:RecordHistoryTalkVoice("story_v_out_104112", "104112045", "story_v_out_104112.awb")
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
	Play104112046 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 104112046
		arg_186_1.duration_ = 7.83

		local var_186_0 = {
			ja = 4.166,
			ko = 2.833,
			zh = 1.999999999999,
			en = 7.833
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
				arg_186_0:Play104112047(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			local var_189_1 = "2043_tpose"

			if arg_186_1.actors_["2043_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2043_tpose"))) then
				local var_189_2 = Object.Instantiate(Asset.Load("Char/" .. "2043_tpose"), arg_186_1.stage_.transform)

				var_189_2.name = var_189_1
				var_189_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_[var_189_1] = var_189_2

				local var_189_3 = var_189_2:GetComponentInChildren(typeof(CharacterEffect))

				var_189_3.enabled = true

				local var_189_4 = GameObjectTools.GetOrAddComponent(var_189_2, typeof(DynamicBoneHelper))

				if var_189_4 then
					var_189_4:EnableDynamicBone(false)
				end

				arg_186_1:ShowWeapon(var_189_3.transform, false)

				arg_186_1.var_[var_189_1 .. "Animator"] = var_189_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_186_1.var_[var_189_1 .. "Animator"].applyRootMotion = true
				arg_186_1.var_[var_189_1 .. "LipSync"] = var_189_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_189_5 = arg_186_1.actors_["2043_tpose"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect2043_tpose == nil then
				arg_186_1.var_.characterEffect2043_tpose = var_189_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.1

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_6 and not isNil(var_189_5) then
				if arg_186_1.var_.characterEffect2043_tpose and not isNil(var_189_5) then
					arg_186_1.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_6 and arg_186_1.time_ < 0 + var_189_6 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect2043_tpose then
				arg_186_1.var_.characterEffect2043_tpose.fillFlat = false
			end

			local var_189_8 = arg_186_1.actors_["2043_tpose"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos2043_tpose = var_189_8.localPosition

				local var_189_9 = GameObjectTools.GetOrAddComponent(var_189_8.gameObject, typeof(DynamicBoneHelper))

				if var_189_9 then
					var_189_9:EnableDynamicBone(false)
				end
			end

			local var_189_10 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_10 then
				var_189_8.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos2043_tpose, Vector3.New(0, -0.95, -3.2), (arg_186_1.time_ - 0) / var_189_10)
				var_189_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_8.position).x, (manager.ui.mainCamera.transform.position - var_189_8.position).y, (manager.ui.mainCamera.transform.position - var_189_8.position).z)
				var_189_8.localEulerAngles.z = 0
				var_189_8.localEulerAngles.x = 0
				var_189_8.localEulerAngles = var_189_8.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_10 and arg_186_1.time_ < 0 + var_189_10 + arg_189_0 then
				var_189_8.localPosition = Vector3.New(0, -0.95, -3.2)
				var_189_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_8.position).x, (manager.ui.mainCamera.transform.position - var_189_8.position).y, (manager.ui.mainCamera.transform.position - var_189_8.position).z)
				var_189_8.localEulerAngles.z = 0
				var_189_8.localEulerAngles.x = 0
				var_189_8.localEulerAngles = var_189_8.localEulerAngles

				local var_189_11 = GameObjectTools.GetOrAddComponent(var_189_8.gameObject, typeof(DynamicBoneHelper))

				if var_189_11 then
					var_189_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			local var_189_12 = 0
			local var_189_13 = 0.225

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_12 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_14 = arg_186_1:GetWordFromCfg(104112046)
				local var_189_15 = arg_186_1:FormatText(var_189_14.content)

				arg_186_1.text_.text = var_189_15

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_17 = 9 <= 0 and var_189_13 or var_189_13 * (utf8.len(var_189_15) / 9)

				if (9 <= 0 and var_189_13 or var_189_13 * (utf8.len(var_189_15) / 9)) > 0 and var_189_13 < var_189_17 then
					arg_186_1.talkMaxDuration = var_189_17

					if var_189_17 + var_189_12 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_17 + var_189_12
					end
				end

				arg_186_1.text_.text = var_189_15
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112046", "story_v_out_104112.awb") ~= 0 then
					local var_189_18 = manager.audio:GetVoiceLength("story_v_out_104112", "104112046", "story_v_out_104112.awb") / 1000

					if var_189_18 + var_189_12 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_18 + var_189_12
					end

					if var_189_14.prefab_name ~= "" and arg_186_1.actors_[var_189_14.prefab_name] ~= nil then
						local var_189_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_186_1.actors_[var_189_14.prefab_name].transform, "story_v_out_104112", "104112046", "story_v_out_104112.awb")

						arg_186_1:RecordAudio("104112046", var_189_19)
						arg_186_1:RecordAudio("104112046", var_189_19)
					else
						arg_186_1:AudioAction("play", "voice", "story_v_out_104112", "104112046", "story_v_out_104112.awb")
					end

					arg_186_1:RecordHistoryTalkVoice("story_v_out_104112", "104112046", "story_v_out_104112.awb")
				end

				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_20 = math.max(var_189_13, arg_186_1.talkMaxDuration)

			if var_189_12 <= arg_186_1.time_ and arg_186_1.time_ < var_189_12 + var_189_20 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_12) / var_189_20

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_12 + var_189_20 and arg_186_1.time_ < var_189_12 + var_189_20 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play104112047 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 104112047
		arg_190_1.duration_ = 3.4

		local var_190_0 = {
			ja = 3.4,
			ko = 3.1,
			zh = 3.333,
			en = 2.833
		}
		local var_190_1 = manager.audio:GetLocalizationFlag()

		if var_190_0[var_190_1] ~= nil then
			arg_190_1.duration_ = var_190_0[var_190_1]
		end

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play104112048(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(arg_190_1.actors_["3009ui_story"]) and arg_190_1.var_.characterEffect3009ui_story == nil then
				arg_190_1.var_.characterEffect3009ui_story = arg_190_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_0 = 0.1

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_0 and not isNil(arg_190_1.actors_["3009ui_story"]) then
				if arg_190_1.var_.characterEffect3009ui_story and not isNil(arg_190_1.actors_["3009ui_story"]) then
					arg_190_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_0 and arg_190_1.time_ < 0 + var_193_0 + arg_193_0 and not isNil(arg_190_1.actors_["3009ui_story"]) and arg_190_1.var_.characterEffect3009ui_story then
				arg_190_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_193_2 = arg_190_1.actors_["2043_tpose"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect2043_tpose == nil then
				arg_190_1.var_.characterEffect2043_tpose = var_193_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_3 = 0.1

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_3 and not isNil(var_193_2) then
				if arg_190_1.var_.characterEffect2043_tpose and not isNil(var_193_2) then
					arg_190_1.var_.characterEffect2043_tpose.fillFlat = true
					arg_190_1.var_.characterEffect2043_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_3)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_3 and arg_190_1.time_ < 0 + var_193_3 + arg_193_0 and not isNil(var_193_2) and arg_190_1.var_.characterEffect2043_tpose then
				arg_190_1.var_.characterEffect2043_tpose.fillFlat = true
				arg_190_1.var_.characterEffect2043_tpose.fillRatio = 0.5
			end

			local var_193_4 = arg_190_1.actors_["2043_tpose"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos2043_tpose = var_193_4.localPosition

				local var_193_5 = GameObjectTools.GetOrAddComponent(var_193_4.gameObject, typeof(DynamicBoneHelper))

				if var_193_5 then
					var_193_5:EnableDynamicBone(false)
				end
			end

			local var_193_6 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_6 then
				var_193_4.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos2043_tpose, Vector3.New(0, 100, 0), (arg_190_1.time_ - 0) / var_193_6)
				var_193_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_4.position).x, (manager.ui.mainCamera.transform.position - var_193_4.position).y, (manager.ui.mainCamera.transform.position - var_193_4.position).z)
				var_193_4.localEulerAngles.z = 0
				var_193_4.localEulerAngles.x = 0
				var_193_4.localEulerAngles = var_193_4.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_6 and arg_190_1.time_ < 0 + var_193_6 + arg_193_0 then
				var_193_4.localPosition = Vector3.New(0, 100, 0)
				var_193_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_4.position).x, (manager.ui.mainCamera.transform.position - var_193_4.position).y, (manager.ui.mainCamera.transform.position - var_193_4.position).z)
				var_193_4.localEulerAngles.z = 0
				var_193_4.localEulerAngles.x = 0
				var_193_4.localEulerAngles = var_193_4.localEulerAngles

				local var_193_7 = GameObjectTools.GetOrAddComponent(var_193_4.gameObject, typeof(DynamicBoneHelper))

				if var_193_7 then
					var_193_7:EnableDynamicBone(true)
				end
			end

			local var_193_8 = arg_190_1.actors_["3009ui_story"].transform

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos3009ui_story = var_193_8.localPosition

				arg_190_1:ShowWeapon(arg_190_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_193_9 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_9 then
				var_193_8.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_190_1.time_ - 0) / var_193_9)
				var_193_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_8.position).x, (manager.ui.mainCamera.transform.position - var_193_8.position).y, (manager.ui.mainCamera.transform.position - var_193_8.position).z)
				var_193_8.localEulerAngles.z = 0
				var_193_8.localEulerAngles.x = 0
				var_193_8.localEulerAngles = var_193_8.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_9 and arg_190_1.time_ < 0 + var_193_9 + arg_193_0 then
				var_193_8.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_193_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_193_8.position).x, (manager.ui.mainCamera.transform.position - var_193_8.position).y, (manager.ui.mainCamera.transform.position - var_193_8.position).z)
				var_193_8.localEulerAngles.z = 0
				var_193_8.localEulerAngles.x = 0
				var_193_8.localEulerAngles = var_193_8.localEulerAngles
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action1_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_193_10 = 0
			local var_193_11 = 0.35

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_10 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_12 = arg_190_1:GetWordFromCfg(104112047)
				local var_193_13 = arg_190_1:FormatText(var_193_12.content)

				arg_190_1.text_.text = var_193_13

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_15 = 14 <= 0 and var_193_11 or var_193_11 * (utf8.len(var_193_13) / 14)

				if (14 <= 0 and var_193_11 or var_193_11 * (utf8.len(var_193_13) / 14)) > 0 and var_193_11 < var_193_15 then
					arg_190_1.talkMaxDuration = var_193_15

					if var_193_15 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_15 + var_193_10
					end
				end

				arg_190_1.text_.text = var_193_13
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112047", "story_v_out_104112.awb") ~= 0 then
					local var_193_16 = manager.audio:GetVoiceLength("story_v_out_104112", "104112047", "story_v_out_104112.awb") / 1000

					if var_193_16 + var_193_10 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_16 + var_193_10
					end

					if var_193_12.prefab_name ~= "" and arg_190_1.actors_[var_193_12.prefab_name] ~= nil then
						local var_193_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_190_1.actors_[var_193_12.prefab_name].transform, "story_v_out_104112", "104112047", "story_v_out_104112.awb")

						arg_190_1:RecordAudio("104112047", var_193_17)
						arg_190_1:RecordAudio("104112047", var_193_17)
					else
						arg_190_1:AudioAction("play", "voice", "story_v_out_104112", "104112047", "story_v_out_104112.awb")
					end

					arg_190_1:RecordHistoryTalkVoice("story_v_out_104112", "104112047", "story_v_out_104112.awb")
				end

				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_18 = math.max(var_193_11, arg_190_1.talkMaxDuration)

			if var_193_10 <= arg_190_1.time_ and arg_190_1.time_ < var_193_10 + var_193_18 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_10) / var_193_18

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_10 + var_193_18 and arg_190_1.time_ < var_193_10 + var_193_18 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "2043_tpose",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "3009ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_190_1:InitPlayNodeList()
	end,
	Play104112048 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 104112048
		arg_194_1.duration_ = 9.93

		local var_194_0 = {
			ja = 9.933,
			ko = 4.366,
			zh = 6.5,
			en = 3.966
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
				arg_194_0:Play104112049(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(arg_194_1.actors_["4010ui_story"]) and arg_194_1.var_.characterEffect4010ui_story == nil then
				arg_194_1.var_.characterEffect4010ui_story = arg_194_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_0 = 0.1

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 and not isNil(arg_194_1.actors_["4010ui_story"]) then
				if arg_194_1.var_.characterEffect4010ui_story and not isNil(arg_194_1.actors_["4010ui_story"]) then
					arg_194_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 and not isNil(arg_194_1.actors_["4010ui_story"]) and arg_194_1.var_.characterEffect4010ui_story then
				arg_194_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_197_2 = arg_194_1.actors_["3009ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect3009ui_story == nil then
				arg_194_1.var_.characterEffect3009ui_story = var_197_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_3 = 0.1

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_3 and not isNil(var_197_2) then
				if arg_194_1.var_.characterEffect3009ui_story and not isNil(var_197_2) then
					arg_194_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_194_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_3)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_3 and arg_194_1.time_ < 0 + var_197_3 + arg_197_0 and not isNil(var_197_2) and arg_194_1.var_.characterEffect3009ui_story then
				arg_194_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_194_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_197_4 = arg_194_1.actors_["4010ui_story"].transform

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos4010ui_story = var_197_4.localPosition
			end

			local var_197_5 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_5 then
				var_197_4.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_194_1.time_ - 0) / var_197_5)
				var_197_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_4.position).x, (manager.ui.mainCamera.transform.position - var_197_4.position).y, (manager.ui.mainCamera.transform.position - var_197_4.position).z)
				var_197_4.localEulerAngles.z = 0
				var_197_4.localEulerAngles.x = 0
				var_197_4.localEulerAngles = var_197_4.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_5 and arg_194_1.time_ < 0 + var_197_5 + arg_197_0 then
				var_197_4.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_197_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_197_4.position).x, (manager.ui.mainCamera.transform.position - var_197_4.position).y, (manager.ui.mainCamera.transform.position - var_197_4.position).z)
				var_197_4.localEulerAngles.z = 0
				var_197_4.localEulerAngles.x = 0
				var_197_4.localEulerAngles = var_197_4.localEulerAngles
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_197_6 = 0
			local var_197_7 = 0.525

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_8 = arg_194_1:GetWordFromCfg(104112048)
				local var_197_9 = arg_194_1:FormatText(var_197_8.content)

				arg_194_1.text_.text = var_197_9

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_11 = 21 <= 0 and var_197_7 or var_197_7 * (utf8.len(var_197_9) / 21)

				if (21 <= 0 and var_197_7 or var_197_7 * (utf8.len(var_197_9) / 21)) > 0 and var_197_7 < var_197_11 then
					arg_194_1.talkMaxDuration = var_197_11

					if var_197_11 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_11 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_9
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112048", "story_v_out_104112.awb") ~= 0 then
					local var_197_12 = manager.audio:GetVoiceLength("story_v_out_104112", "104112048", "story_v_out_104112.awb") / 1000

					if var_197_12 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_12 + var_197_6
					end

					if var_197_8.prefab_name ~= "" and arg_194_1.actors_[var_197_8.prefab_name] ~= nil then
						local var_197_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_194_1.actors_[var_197_8.prefab_name].transform, "story_v_out_104112", "104112048", "story_v_out_104112.awb")

						arg_194_1:RecordAudio("104112048", var_197_13)
						arg_194_1:RecordAudio("104112048", var_197_13)
					else
						arg_194_1:AudioAction("play", "voice", "story_v_out_104112", "104112048", "story_v_out_104112.awb")
					end

					arg_194_1:RecordHistoryTalkVoice("story_v_out_104112", "104112048", "story_v_out_104112.awb")
				end

				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_14 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_14 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_14

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_14 and arg_194_1.time_ < var_197_6 + var_197_14 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play104112049 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 104112049
		arg_198_1.duration_ = 5.6

		local var_198_0 = {
			ja = 5.6,
			ko = 3.133,
			zh = 5.033,
			en = 5
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
				arg_198_0:Play104112050(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(arg_198_1.actors_["3009ui_story"]) and arg_198_1.var_.characterEffect3009ui_story == nil then
				arg_198_1.var_.characterEffect3009ui_story = arg_198_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_0 = 0.1

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_0 and not isNil(arg_198_1.actors_["3009ui_story"]) then
				if arg_198_1.var_.characterEffect3009ui_story and not isNil(arg_198_1.actors_["3009ui_story"]) then
					arg_198_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_0 and arg_198_1.time_ < 0 + var_201_0 + arg_201_0 and not isNil(arg_198_1.actors_["3009ui_story"]) and arg_198_1.var_.characterEffect3009ui_story then
				arg_198_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_201_2 = arg_198_1.actors_["4010ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect4010ui_story == nil then
				arg_198_1.var_.characterEffect4010ui_story = var_201_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_3 = 0.1

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_3 and not isNil(var_201_2) then
				if arg_198_1.var_.characterEffect4010ui_story and not isNil(var_201_2) then
					arg_198_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_198_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_3)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_3 and arg_198_1.time_ < 0 + var_201_3 + arg_201_0 and not isNil(var_201_2) and arg_198_1.var_.characterEffect4010ui_story then
				arg_198_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_198_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			local var_201_4 = 0
			local var_201_5 = 0.525

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_4 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_6 = arg_198_1:GetWordFromCfg(104112049)
				local var_201_7 = arg_198_1:FormatText(var_201_6.content)

				arg_198_1.text_.text = var_201_7

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_9 = 28 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 28)

				if (28 <= 0 and var_201_5 or var_201_5 * (utf8.len(var_201_7) / 28)) > 0 and var_201_5 < var_201_9 then
					arg_198_1.talkMaxDuration = var_201_9

					if var_201_9 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_9 + var_201_4
					end
				end

				arg_198_1.text_.text = var_201_7
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112049", "story_v_out_104112.awb") ~= 0 then
					local var_201_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112049", "story_v_out_104112.awb") / 1000

					if var_201_10 + var_201_4 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_10 + var_201_4
					end

					if var_201_6.prefab_name ~= "" and arg_198_1.actors_[var_201_6.prefab_name] ~= nil then
						local var_201_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_198_1.actors_[var_201_6.prefab_name].transform, "story_v_out_104112", "104112049", "story_v_out_104112.awb")

						arg_198_1:RecordAudio("104112049", var_201_11)
						arg_198_1:RecordAudio("104112049", var_201_11)
					else
						arg_198_1:AudioAction("play", "voice", "story_v_out_104112", "104112049", "story_v_out_104112.awb")
					end

					arg_198_1:RecordHistoryTalkVoice("story_v_out_104112", "104112049", "story_v_out_104112.awb")
				end

				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_12 = math.max(var_201_5, arg_198_1.talkMaxDuration)

			if var_201_4 <= arg_198_1.time_ and arg_198_1.time_ < var_201_4 + var_201_12 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_4) / var_201_12

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_4 + var_201_12 and arg_198_1.time_ < var_201_4 + var_201_12 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {}

		arg_198_1:InitPlayNodeList()
	end,
	Play104112050 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 104112050
		arg_202_1.duration_ = 7.47

		local var_202_0 = {
			ja = 5.833,
			ko = 5.9,
			zh = 7.466,
			en = 5.066
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
			arg_202_1.auto_ = false
		end

		function arg_202_1.playNext_(arg_204_0)
			arg_202_1.onStoryFinished_()
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(arg_202_1.actors_["4010ui_story"]) and arg_202_1.var_.characterEffect4010ui_story == nil then
				arg_202_1.var_.characterEffect4010ui_story = arg_202_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_0 = 0.1

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_0 and not isNil(arg_202_1.actors_["4010ui_story"]) then
				if arg_202_1.var_.characterEffect4010ui_story and not isNil(arg_202_1.actors_["4010ui_story"]) then
					arg_202_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_202_1.time_ >= 0 + var_205_0 and arg_202_1.time_ < 0 + var_205_0 + arg_205_0 and not isNil(arg_202_1.actors_["4010ui_story"]) and arg_202_1.var_.characterEffect4010ui_story then
				arg_202_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_205_2 = arg_202_1.actors_["3009ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect3009ui_story == nil then
				arg_202_1.var_.characterEffect3009ui_story = var_205_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_3 = 0.1

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_3 and not isNil(var_205_2) then
				if arg_202_1.var_.characterEffect3009ui_story and not isNil(var_205_2) then
					arg_202_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_202_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_3)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_3 and arg_202_1.time_ < 0 + var_205_3 + arg_205_0 and not isNil(var_205_2) and arg_202_1.var_.characterEffect3009ui_story then
				arg_202_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_202_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			local var_205_4 = 0
			local var_205_5 = 0.55

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_4 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, true)

				arg_202_1.leftNameTxt_.text = arg_202_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_202_1.leftNameTxt_.transform)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1.leftNameTxt_.text)
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_6 = arg_202_1:GetWordFromCfg(104112050)
				local var_205_7 = arg_202_1:FormatText(var_205_6.content)

				arg_202_1.text_.text = var_205_7

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_9 = 22 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 22)

				if (22 <= 0 and var_205_5 or var_205_5 * (utf8.len(var_205_7) / 22)) > 0 and var_205_5 < var_205_9 then
					arg_202_1.talkMaxDuration = var_205_9

					if var_205_9 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_9 + var_205_4
					end
				end

				arg_202_1.text_.text = var_205_7
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112050", "story_v_out_104112.awb") ~= 0 then
					local var_205_10 = manager.audio:GetVoiceLength("story_v_out_104112", "104112050", "story_v_out_104112.awb") / 1000

					if var_205_10 + var_205_4 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_10 + var_205_4
					end

					if var_205_6.prefab_name ~= "" and arg_202_1.actors_[var_205_6.prefab_name] ~= nil then
						local var_205_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_202_1.actors_[var_205_6.prefab_name].transform, "story_v_out_104112", "104112050", "story_v_out_104112.awb")

						arg_202_1:RecordAudio("104112050", var_205_11)
						arg_202_1:RecordAudio("104112050", var_205_11)
					else
						arg_202_1:AudioAction("play", "voice", "story_v_out_104112", "104112050", "story_v_out_104112.awb")
					end

					arg_202_1:RecordHistoryTalkVoice("story_v_out_104112", "104112050", "story_v_out_104112.awb")
				end

				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_5, arg_202_1.talkMaxDuration)

			if var_205_4 <= arg_202_1.time_ and arg_202_1.time_ < var_205_4 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_4) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_4 + var_205_12 and arg_202_1.time_ < var_205_4 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {}

		arg_202_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B14"
	},
	voices = {
		"story_v_out_104112.awb"
	}
}
