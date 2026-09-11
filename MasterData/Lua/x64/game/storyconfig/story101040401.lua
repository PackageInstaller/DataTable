return {
	Play104041001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104041001
		arg_1_1.duration_ = 5.07

		local var_1_0 = {
			ja = 4.6,
			ko = 4.566,
			zh = 5.066,
			en = 3.8
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
				arg_1_0:Play104041002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

				local var_4_2 = manager.audio:GetAudioName("bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")

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

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_v1_environment_factory", "se_story_v1_environment_factory", "se_story_v1_environment_factory")
			end

			local var_4_4 = "1084ui_story"

			if arg_1_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_1_1.stage_.transform)

				var_4_5.name = var_4_4
				var_4_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.actors_[var_4_4] = var_4_5

				local var_4_6 = var_4_5:GetComponentInChildren(typeof(CharacterEffect))

				var_4_6.enabled = true

				local var_4_7 = GameObjectTools.GetOrAddComponent(var_4_5, typeof(DynamicBoneHelper))

				if var_4_7 then
					var_4_7:EnableDynamicBone(false)
				end

				arg_1_1:ShowWeapon(var_4_6.transform, false)

				arg_1_1.var_[var_4_4 .. "Animator"] = var_4_6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_1_1.var_[var_4_4 .. "Animator"].applyRootMotion = true
				arg_1_1.var_[var_4_4 .. "LipSync"] = var_4_6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_4_8 = arg_1_1.actors_["1084ui_story"]

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.5 + var_4_9 and arg_1_1.time_ < 1.5 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_11 = "B04b"

			if arg_1_1.bgs_.B04b == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.B04b:GetComponent("SpriteRenderer")

				if var_4_13 then
					arg_1_1.var_.alphaOldValueB04b = var_4_13.color.a
					arg_1_1.var_.alphaMatValueB04b = var_4_13
				end

				arg_1_1.var_.alphaOldValueB04b = 0
			end

			local var_4_14 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				if arg_1_1.var_.alphaMatValueB04b then
					arg_1_1.var_.alphaMatValueB04b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB04b, 1, (arg_1_1.time_ - 0) / var_4_14)
					arg_1_1.var_.alphaMatValueB04b.color = arg_1_1.var_.alphaMatValueB04b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and arg_1_1.var_.alphaMatValueB04b then
				arg_1_1.var_.alphaMatValueB04b.color.a = 1
				arg_1_1.var_.alphaMatValueB04b.color = arg_1_1.var_.alphaMatValueB04b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.bgs_.B04b

				arg_1_1.bgs_.B04b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_16 = var_4_15:GetComponent("SpriteRenderer")

				if var_4_16 and var_4_16.sprite then
					local var_4_17 = 2 * (var_4_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_15.transform.localScale = Vector3.New(var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B04b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = arg_1_1.actors_["1084ui_story"].transform

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_18.localPosition
			end

			local var_4_19 = 0.001

			if 1.5 <= arg_1_1.time_ and arg_1_1.time_ < 1.5 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_1_1.time_ - 1.5) / var_4_19)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 1.5 + var_4_19 and arg_1_1.time_ < 1.5 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= 1.5 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_20 + 1.5 and arg_1_1.time_ < var_4_20 + 1.5 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 1.5
			local var_4_22 = 0.375

			if 1.5 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_23 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_23:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_23:setOnUpdate(nil):setOnComplete(nil)
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

				local var_4_24 = arg_1_1:GetWordFromCfg(104041001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 14 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 14)

				if (14 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 14)) > 0 and var_4_22 < var_4_27 then
					arg_1_1.talkMaxDuration = var_4_27
					var_4_21 = var_4_21 + 0.3

					if var_4_27 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_27 + var_4_21
					end
				end

				arg_1_1.text_.text = var_4_25
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041001", "story_v_out_104041.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_104041", "104041001", "story_v_out_104041.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_104041", "104041001", "story_v_out_104041.awb")

						arg_1_1:RecordAudio("104041001", var_4_29)
						arg_1_1:RecordAudio("104041001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104041", "104041001", "story_v_out_104041.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104041", "104041001", "story_v_out_104041.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_30 = var_4_21 + 0.3
			local var_4_31 = math.max(var_4_22, arg_1_1.talkMaxDuration)

			if var_4_21 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_30 + var_4_31 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_30) / var_4_31

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_30 + var_4_31 and arg_1_1.time_ < var_4_30 + var_4_31 + arg_4_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play104041002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104041002
		arg_8_1.duration_ = 14.63

		local var_8_0 = {
			ja = 13.4,
			ko = 14.633,
			zh = 10.933,
			en = 13.5
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
				arg_8_0:Play104041003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1036ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1036ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1036ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1036ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1036ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1036ui_story == nil then
				arg_8_1.var_.characterEffect1036ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1036ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1036ui_story then
				arg_8_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_11_8 = arg_8_1.actors_["1036ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1036ui_story = var_11_8.localPosition
			end

			local var_11_9 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1036ui_story, Vector3.New(0.7, -1.09, -5.78), (arg_8_1.time_ - 0) / var_11_9)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0.7, -1.09, -5.78)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action2_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_11_10 = 0
			local var_11_11 = 1.45

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(104041002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 57 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 57)

				if (57 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 57)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041002", "story_v_out_104041.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_104041", "104041002", "story_v_out_104041.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_104041", "104041002", "story_v_out_104041.awb")

						arg_8_1:RecordAudio("104041002", var_11_17)
						arg_8_1:RecordAudio("104041002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104041", "104041002", "story_v_out_104041.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104041", "104041002", "story_v_out_104041.awb")
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
				actorName = "1036ui_story",
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
	Play104041003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104041003
		arg_12_1.duration_ = 9.43

		local var_12_0 = {
			ja = 9.433,
			ko = 5.2,
			zh = 1.4,
			en = 4.033
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
				arg_12_0:Play104041004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1036ui_story"]) and arg_12_1.var_.characterEffect1036ui_story == nil then
				arg_12_1.var_.characterEffect1036ui_story = arg_12_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1036ui_story"]) then
				if arg_12_1.var_.characterEffect1036ui_story and not isNil(arg_12_1.actors_["1036ui_story"]) then
					arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1036ui_story"]) and arg_12_1.var_.characterEffect1036ui_story then
				arg_12_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_15_1 = arg_12_1.actors_["1036ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1036ui_story = var_15_1.localPosition
			end

			local var_15_2 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_2 then
				var_15_1.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_2)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_2 and arg_12_1.time_ < 0 + var_15_2 + arg_15_0 then
				var_15_1.localPosition = Vector3.New(0, 100, 0)
				var_15_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_1.position).x, (manager.ui.mainCamera.transform.position - var_15_1.position).y, (manager.ui.mainCamera.transform.position - var_15_1.position).z)
				var_15_1.localEulerAngles.z = 0
				var_15_1.localEulerAngles.x = 0
				var_15_1.localEulerAngles = var_15_1.localEulerAngles
			end

			local var_15_3 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_3.localPosition
			end

			local var_15_4 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 then
				var_15_3.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_4)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 then
				var_15_3.localPosition = Vector3.New(0, 100, 0)
				var_15_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_3.position).x, (manager.ui.mainCamera.transform.position - var_15_3.position).y, (manager.ui.mainCamera.transform.position - var_15_3.position).z)
				var_15_3.localEulerAngles.z = 0
				var_15_3.localEulerAngles.x = 0
				var_15_3.localEulerAngles = var_15_3.localEulerAngles
			end

			local var_15_5 = 0
			local var_15_6 = 0.45

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_5 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[57].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2026")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_7 = arg_12_1:GetWordFromCfg(104041003)
				local var_15_8 = arg_12_1:FormatText(var_15_7.content)

				arg_12_1.text_.text = var_15_8

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_10 = 18 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_8) / 18)

				if (18 <= 0 and var_15_6 or var_15_6 * (utf8.len(var_15_8) / 18)) > 0 and var_15_6 < var_15_10 then
					arg_12_1.talkMaxDuration = var_15_10

					if var_15_10 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_10 + var_15_5
					end
				end

				arg_12_1.text_.text = var_15_8
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041003", "story_v_out_104041.awb") ~= 0 then
					local var_15_11 = manager.audio:GetVoiceLength("story_v_out_104041", "104041003", "story_v_out_104041.awb") / 1000

					if var_15_11 + var_15_5 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_11 + var_15_5
					end

					if var_15_7.prefab_name ~= "" and arg_12_1.actors_[var_15_7.prefab_name] ~= nil then
						local var_15_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_7.prefab_name].transform, "story_v_out_104041", "104041003", "story_v_out_104041.awb")

						arg_12_1:RecordAudio("104041003", var_15_12)
						arg_12_1:RecordAudio("104041003", var_15_12)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104041", "104041003", "story_v_out_104041.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104041", "104041003", "story_v_out_104041.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_13 = math.max(var_15_6, arg_12_1.talkMaxDuration)

			if var_15_5 <= arg_12_1.time_ and arg_12_1.time_ < var_15_5 + var_15_13 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_5) / var_15_13

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_5 + var_15_13 and arg_12_1.time_ < var_15_5 + var_15_13 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_12_1:InitPlayNodeList()
	end,
	Play104041004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104041004
		arg_16_1.duration_ = 2

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play104041005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1011ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1011ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1011ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1011ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1011ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1011ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["1011ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1011ui_story = var_19_6.localPosition
			end

			local var_19_7 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 then
				var_19_6.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_16_1.time_ - 0) / var_19_7)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 then
				var_19_6.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_19_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_6.position).x, (manager.ui.mainCamera.transform.position - var_19_6.position).y, (manager.ui.mainCamera.transform.position - var_19_6.position).z)
				var_19_6.localEulerAngles.z = 0
				var_19_6.localEulerAngles.x = 0
				var_19_6.localEulerAngles = var_19_6.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_19_8 = 0
			local var_19_9 = 0.075

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_8 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_10 = arg_16_1:GetWordFromCfg(104041004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 3 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 3)

				if (3 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 3)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041004", "story_v_out_104041.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_104041", "104041004", "story_v_out_104041.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_104041", "104041004", "story_v_out_104041.awb")

						arg_16_1:RecordAudio("104041004", var_19_15)
						arg_16_1:RecordAudio("104041004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104041", "104041004", "story_v_out_104041.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104041", "104041004", "story_v_out_104041.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_16 = math.max(var_19_9, arg_16_1.talkMaxDuration)

			if var_19_8 <= arg_16_1.time_ and arg_16_1.time_ < var_19_8 + var_19_16 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_8) / var_19_16

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_8 + var_19_16 and arg_16_1.time_ < var_19_8 + var_19_16 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play104041005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104041005
		arg_20_1.duration_ = 3.57

		local var_20_0 = {
			ja = 3.566,
			ko = 2.066,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_20_0:Play104041006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = arg_20_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(arg_20_1.actors_["1084ui_story"]) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1084ui_story"]) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1011ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1011ui_story == nil then
				arg_20_1.var_.characterEffect1011ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1011ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1011ui_story then
				arg_20_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_23_4 = arg_20_1.actors_["1084ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_4.localPosition
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_20_1.time_ - 0) / var_23_5)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.175

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_8 = arg_20_1:GetWordFromCfg(104041005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 7 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 7)

				if (7 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 7)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041005", "story_v_out_104041.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_104041", "104041005", "story_v_out_104041.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_104041", "104041005", "story_v_out_104041.awb")

						arg_20_1:RecordAudio("104041005", var_23_13)
						arg_20_1:RecordAudio("104041005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104041", "104041005", "story_v_out_104041.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104041", "104041005", "story_v_out_104041.awb")
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
				actorName = "1084ui_story",
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
	Play104041006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104041006
		arg_24_1.duration_ = 17.97

		local var_24_0 = {
			ja = 17.966,
			ko = 7.733,
			zh = 7.833,
			en = 9.4
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
				arg_24_0:Play104041007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if arg_24_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_27_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_24_1.stage_.transform)

				var_27_0.name = "1019ui_story"
				var_27_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_24_1.actors_["1019ui_story"] = var_27_0

				local var_27_1 = var_27_0:GetComponentInChildren(typeof(CharacterEffect))

				var_27_1.enabled = true

				local var_27_2 = GameObjectTools.GetOrAddComponent(var_27_0, typeof(DynamicBoneHelper))

				if var_27_2 then
					var_27_2:EnableDynamicBone(false)
				end

				arg_24_1:ShowWeapon(var_27_1.transform, false)

				arg_24_1.var_["1019ui_story" .. "Animator"] = var_27_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_24_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_24_1.var_["1019ui_story" .. "LipSync"] = var_27_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_27_3 = arg_24_1.actors_["1019ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_4 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_4 and not isNil(var_27_3) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_3) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_4 and arg_24_1.time_ < 0 + var_27_4 + arg_27_0 and not isNil(var_27_3) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_27_6 = arg_24_1.actors_["1084ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_7 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 and not isNil(var_27_6) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_6) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_7)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 and not isNil(var_27_6) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_27_8 = arg_24_1.actors_["1084ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, 100, 0)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			local var_27_10 = arg_24_1.actors_["1011ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_10.localPosition
			end

			local var_27_11 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_11 then
				var_27_10.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_11)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_11 and arg_24_1.time_ < 0 + var_27_11 + arg_27_0 then
				var_27_10.localPosition = Vector3.New(0, 100, 0)
				var_27_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_10.position).x, (manager.ui.mainCamera.transform.position - var_27_10.position).y, (manager.ui.mainCamera.transform.position - var_27_10.position).z)
				var_27_10.localEulerAngles.z = 0
				var_27_10.localEulerAngles.x = 0
				var_27_10.localEulerAngles = var_27_10.localEulerAngles
			end

			local var_27_12 = arg_24_1.actors_["1019ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_12.localPosition
			end

			local var_27_13 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_13 then
				var_27_12.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_24_1.time_ - 0) / var_27_13)
				var_27_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_12.position).x, (manager.ui.mainCamera.transform.position - var_27_12.position).y, (manager.ui.mainCamera.transform.position - var_27_12.position).z)
				var_27_12.localEulerAngles.z = 0
				var_27_12.localEulerAngles.x = 0
				var_27_12.localEulerAngles = var_27_12.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_13 and arg_24_1.time_ < 0 + var_27_13 + arg_27_0 then
				var_27_12.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_27_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_12.position).x, (manager.ui.mainCamera.transform.position - var_27_12.position).y, (manager.ui.mainCamera.transform.position - var_27_12.position).z)
				var_27_12.localEulerAngles.z = 0
				var_27_12.localEulerAngles.x = 0
				var_27_12.localEulerAngles = var_27_12.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_27_14 = 0
			local var_27_15 = 0.925

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_14 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_16 = arg_24_1:GetWordFromCfg(104041006)
				local var_27_17 = arg_24_1:FormatText(var_27_16.content)

				arg_24_1.text_.text = var_27_17

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_19 = 37 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 37)

				if (37 <= 0 and var_27_15 or var_27_15 * (utf8.len(var_27_17) / 37)) > 0 and var_27_15 < var_27_19 then
					arg_24_1.talkMaxDuration = var_27_19

					if var_27_19 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_19 + var_27_14
					end
				end

				arg_24_1.text_.text = var_27_17
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041006", "story_v_out_104041.awb") ~= 0 then
					local var_27_20 = manager.audio:GetVoiceLength("story_v_out_104041", "104041006", "story_v_out_104041.awb") / 1000

					if var_27_20 + var_27_14 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_20 + var_27_14
					end

					if var_27_16.prefab_name ~= "" and arg_24_1.actors_[var_27_16.prefab_name] ~= nil then
						local var_27_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_16.prefab_name].transform, "story_v_out_104041", "104041006", "story_v_out_104041.awb")

						arg_24_1:RecordAudio("104041006", var_27_21)
						arg_24_1:RecordAudio("104041006", var_27_21)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_104041", "104041006", "story_v_out_104041.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_104041", "104041006", "story_v_out_104041.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_22 = math.max(var_27_15, arg_24_1.talkMaxDuration)

			if var_27_14 <= arg_24_1.time_ and arg_24_1.time_ < var_27_14 + var_27_22 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_14) / var_27_22

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_14 + var_27_22 and arg_24_1.time_ < var_27_14 + var_27_22 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
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
	Play104041007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104041007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play104041008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story == nil then
				arg_28_1.var_.characterEffect1019ui_story = arg_28_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) then
				if arg_28_1.var_.characterEffect1019ui_story and not isNil(arg_28_1.actors_["1019ui_story"]) then
					arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_28_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_0)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1019ui_story"]) and arg_28_1.var_.characterEffect1019ui_story then
				arg_28_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_28_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_31_1 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_1.localPosition
			end

			local var_31_2 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_2 then
				var_31_1.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_2)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_2 and arg_28_1.time_ < 0 + var_31_2 + arg_31_0 then
				var_31_1.localPosition = Vector3.New(0, 100, 0)
				var_31_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_1.position).x, (manager.ui.mainCamera.transform.position - var_31_1.position).y, (manager.ui.mainCamera.transform.position - var_31_1.position).z)
				var_31_1.localEulerAngles.z = 0
				var_31_1.localEulerAngles.x = 0
				var_31_1.localEulerAngles = var_31_1.localEulerAngles
			end

			local var_31_3 = 0
			local var_31_4 = 1.3

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_3 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, false)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_5 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(104041007).content)

				arg_28_1.text_.text = var_31_5

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_7 = 52 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 52)

				if (52 <= 0 and var_31_4 or var_31_4 * (utf8.len(var_31_5) / 52)) > 0 and var_31_4 < var_31_7 then
					arg_28_1.talkMaxDuration = var_31_7

					if var_31_7 + var_31_3 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_7 + var_31_3
					end
				end

				arg_28_1.text_.text = var_31_5
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_8 = math.max(var_31_4, arg_28_1.talkMaxDuration)

			if var_31_3 <= arg_28_1.time_ and arg_28_1.time_ < var_31_3 + var_31_8 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_3) / var_31_8

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_3 + var_31_8 and arg_28_1.time_ < var_31_3 + var_31_8 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play104041008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104041008
		arg_32_1.duration_ = 2.87

		local var_32_0 = {
			ja = 2.266,
			ko = 2.2,
			zh = 2.5,
			en = 2.866
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
				arg_32_0:Play104041009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1036ui_story"]) and arg_32_1.var_.characterEffect1036ui_story == nil then
				arg_32_1.var_.characterEffect1036ui_story = arg_32_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1036ui_story"]) then
				if arg_32_1.var_.characterEffect1036ui_story and not isNil(arg_32_1.actors_["1036ui_story"]) then
					arg_32_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1036ui_story"]) and arg_32_1.var_.characterEffect1036ui_story then
				arg_32_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["1036ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1036ui_story = var_35_2.localPosition
			end

			local var_35_3 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 then
				var_35_2.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_32_1.time_ - 0) / var_35_3)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 then
				var_35_2.localPosition = Vector3.New(0, -1.09, -5.78)
				var_35_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_2.position).x, (manager.ui.mainCamera.transform.position - var_35_2.position).y, (manager.ui.mainCamera.transform.position - var_35_2.position).z)
				var_35_2.localEulerAngles.z = 0
				var_35_2.localEulerAngles.x = 0
				var_35_2.localEulerAngles = var_35_2.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action7_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.275

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(104041008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 11 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 11)

				if (11 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 11)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041008", "story_v_out_104041.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_104041", "104041008", "story_v_out_104041.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_104041", "104041008", "story_v_out_104041.awb")

						arg_32_1:RecordAudio("104041008", var_35_11)
						arg_32_1:RecordAudio("104041008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104041", "104041008", "story_v_out_104041.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104041", "104041008", "story_v_out_104041.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_12 = math.max(var_35_5, arg_32_1.talkMaxDuration)

			if var_35_4 <= arg_32_1.time_ and arg_32_1.time_ < var_35_4 + var_35_12 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_4) / var_35_12

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_4 + var_35_12 and arg_32_1.time_ < var_35_4 + var_35_12 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
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
	Play104041009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104041009
		arg_36_1.duration_ = 5.47

		local var_36_0 = {
			ja = 4.766,
			ko = 4.266,
			zh = 5.466,
			en = 4.733
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
				arg_36_0:Play104041010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1011ui_story"]) and arg_36_1.var_.characterEffect1011ui_story == nil then
				arg_36_1.var_.characterEffect1011ui_story = arg_36_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1011ui_story"]) then
				if arg_36_1.var_.characterEffect1011ui_story and not isNil(arg_36_1.actors_["1011ui_story"]) then
					arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1011ui_story"]) and arg_36_1.var_.characterEffect1011ui_story then
				arg_36_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1036ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1036ui_story == nil then
				arg_36_1.var_.characterEffect1036ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1036ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1036ui_story then
				arg_36_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_39_4 = arg_36_1.actors_["1036ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1036ui_story = var_39_4.localPosition
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_5 and arg_36_1.time_ < 0 + var_39_5 + arg_39_0 then
				var_39_4.localPosition = Vector3.New(0, 100, 0)
				var_39_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_4.position).x, (manager.ui.mainCamera.transform.position - var_39_4.position).y, (manager.ui.mainCamera.transform.position - var_39_4.position).z)
				var_39_4.localEulerAngles.z = 0
				var_39_4.localEulerAngles.x = 0
				var_39_4.localEulerAngles = var_39_4.localEulerAngles
			end

			local var_39_6 = arg_36_1.actors_["1011ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1011ui_story = var_39_6.localPosition
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_36_1.time_ - 0) / var_39_7)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, -0.71, -6)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_39_8 = 0
			local var_39_9 = 0.425

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_8 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_10 = arg_36_1:GetWordFromCfg(104041009)
				local var_39_11 = arg_36_1:FormatText(var_39_10.content)

				arg_36_1.text_.text = var_39_11

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_13 = 17 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 17)

				if (17 <= 0 and var_39_9 or var_39_9 * (utf8.len(var_39_11) / 17)) > 0 and var_39_9 < var_39_13 then
					arg_36_1.talkMaxDuration = var_39_13

					if var_39_13 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_13 + var_39_8
					end
				end

				arg_36_1.text_.text = var_39_11
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041009", "story_v_out_104041.awb") ~= 0 then
					local var_39_14 = manager.audio:GetVoiceLength("story_v_out_104041", "104041009", "story_v_out_104041.awb") / 1000

					if var_39_14 + var_39_8 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_8
					end

					if var_39_10.prefab_name ~= "" and arg_36_1.actors_[var_39_10.prefab_name] ~= nil then
						local var_39_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_10.prefab_name].transform, "story_v_out_104041", "104041009", "story_v_out_104041.awb")

						arg_36_1:RecordAudio("104041009", var_39_15)
						arg_36_1:RecordAudio("104041009", var_39_15)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104041", "104041009", "story_v_out_104041.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104041", "104041009", "story_v_out_104041.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_16 = math.max(var_39_9, arg_36_1.talkMaxDuration)

			if var_39_8 <= arg_36_1.time_ and arg_36_1.time_ < var_39_8 + var_39_16 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_8) / var_39_16

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_8 + var_39_16 and arg_36_1.time_ < var_39_8 + var_39_16 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1011ui_story",
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
	Play104041010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104041010
		arg_40_1.duration_ = 11.57

		local var_40_0 = {
			ja = 11.566,
			ko = 8.166,
			zh = 10.166,
			en = 10.166
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
				arg_40_0:Play104041011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			local var_43_0 = 0
			local var_43_1 = 0.975

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_2 = arg_40_1:GetWordFromCfg(104041010)
				local var_43_3 = arg_40_1:FormatText(var_43_2.content)

				arg_40_1.text_.text = var_43_3

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_5 = 39 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 39)

				if (39 <= 0 and var_43_1 or var_43_1 * (utf8.len(var_43_3) / 39)) > 0 and var_43_1 < var_43_5 then
					arg_40_1.talkMaxDuration = var_43_5

					if var_43_5 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_5 + var_43_0
					end
				end

				arg_40_1.text_.text = var_43_3
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041010", "story_v_out_104041.awb") ~= 0 then
					local var_43_6 = manager.audio:GetVoiceLength("story_v_out_104041", "104041010", "story_v_out_104041.awb") / 1000

					if var_43_6 + var_43_0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_0
					end

					if var_43_2.prefab_name ~= "" and arg_40_1.actors_[var_43_2.prefab_name] ~= nil then
						local var_43_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_2.prefab_name].transform, "story_v_out_104041", "104041010", "story_v_out_104041.awb")

						arg_40_1:RecordAudio("104041010", var_43_7)
						arg_40_1:RecordAudio("104041010", var_43_7)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104041", "104041010", "story_v_out_104041.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104041", "104041010", "story_v_out_104041.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_8 = math.max(var_43_1, arg_40_1.talkMaxDuration)

			if var_43_0 <= arg_40_1.time_ and arg_40_1.time_ < var_43_0 + var_43_8 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_0) / var_43_8

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_0 + var_43_8 and arg_40_1.time_ < var_43_0 + var_43_8 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104041011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104041011
		arg_44_1.duration_ = 2.87

		local var_44_0 = {
			ja = 1.3,
			ko = 1.066,
			zh = 2.866,
			en = 1.4
		}
		local var_44_1 = manager.audio:GetLocalizationFlag()

		if var_44_0[var_44_1] ~= nil then
			arg_44_1.duration_ = var_44_0[var_44_1]
		end

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
			arg_44_1.auto_ = false
		end

		function arg_44_1.playNext_(arg_46_0)
			arg_44_1.onStoryFinished_()
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story == nil then
				arg_44_1.var_.characterEffect1019ui_story = arg_44_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) then
				if arg_44_1.var_.characterEffect1019ui_story and not isNil(arg_44_1.actors_["1019ui_story"]) then
					arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1019ui_story"]) and arg_44_1.var_.characterEffect1019ui_story then
				arg_44_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_47_2 = arg_44_1.actors_["1011ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1011ui_story == nil then
				arg_44_1.var_.characterEffect1011ui_story = var_47_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_3 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_3 and not isNil(var_47_2) then
				if arg_44_1.var_.characterEffect1011ui_story and not isNil(var_47_2) then
					arg_44_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_3)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_3 and arg_44_1.time_ < 0 + var_47_3 + arg_47_0 and not isNil(var_47_2) and arg_44_1.var_.characterEffect1011ui_story then
				arg_44_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_47_4 = arg_44_1.actors_["1011ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1011ui_story = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_5)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0, 100, 0)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			local var_47_6 = arg_44_1.actors_["1019ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_6.localPosition
			end

			local var_47_7 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				var_47_6.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_44_1.time_ - 0) / var_47_7)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				var_47_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_47_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_6.position).x, (manager.ui.mainCamera.transform.position - var_47_6.position).y, (manager.ui.mainCamera.transform.position - var_47_6.position).z)
				var_47_6.localEulerAngles.z = 0
				var_47_6.localEulerAngles.x = 0
				var_47_6.localEulerAngles = var_47_6.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_47_8 = 0
			local var_47_9 = 0.05

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_8 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_10 = arg_44_1:GetWordFromCfg(104041011)
				local var_47_11 = arg_44_1:FormatText(var_47_10.content)

				arg_44_1.text_.text = var_47_11

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_13 = 2 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 2)

				if (2 <= 0 and var_47_9 or var_47_9 * (utf8.len(var_47_11) / 2)) > 0 and var_47_9 < var_47_13 then
					arg_44_1.talkMaxDuration = var_47_13

					if var_47_13 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_13 + var_47_8
					end
				end

				arg_44_1.text_.text = var_47_11
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104041", "104041011", "story_v_out_104041.awb") ~= 0 then
					local var_47_14 = manager.audio:GetVoiceLength("story_v_out_104041", "104041011", "story_v_out_104041.awb") / 1000

					if var_47_14 + var_47_8 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_14 + var_47_8
					end

					if var_47_10.prefab_name ~= "" and arg_44_1.actors_[var_47_10.prefab_name] ~= nil then
						local var_47_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_10.prefab_name].transform, "story_v_out_104041", "104041011", "story_v_out_104041.awb")

						arg_44_1:RecordAudio("104041011", var_47_15)
						arg_44_1:RecordAudio("104041011", var_47_15)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104041", "104041011", "story_v_out_104041.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104041", "104041011", "story_v_out_104041.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_16 = math.max(var_47_9, arg_44_1.talkMaxDuration)

			if var_47_8 <= arg_44_1.time_ and arg_44_1.time_ < var_47_8 + var_47_16 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_8) / var_47_16

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_8 + var_47_16 and arg_44_1.time_ < var_47_8 + var_47_16 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B04b"
	},
	voices = {
		"story_v_out_104041.awb"
	}
}
