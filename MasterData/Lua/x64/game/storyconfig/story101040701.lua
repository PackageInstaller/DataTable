return {
	Play104071001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 104071001
		arg_1_1.duration_ = 7.03

		local var_1_0 = {
			ja = 7.033,
			ko = 5.7,
			zh = 5.833,
			en = 7.033
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
				arg_1_0:Play104071002(arg_1_1)
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

			local var_4_4 = "1019ui_story"

			if arg_1_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_1_1.stage_.transform)

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

			local var_4_8 = arg_1_1.actors_["1019ui_story"]

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect1019ui_story == nil then
				arg_1_1.var_.characterEffect1019ui_story = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect1019ui_story and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect1019ui_story then
				arg_1_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_4_11 = "B06a"

			if arg_1_1.bgs_.B06a == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.B06a:GetComponent("SpriteRenderer")

				if var_4_13 then
					arg_1_1.var_.alphaOldValueB06a = var_4_13.color.a
					arg_1_1.var_.alphaMatValueB06a = var_4_13
				end

				arg_1_1.var_.alphaOldValueB06a = 0
			end

			local var_4_14 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				if arg_1_1.var_.alphaMatValueB06a then
					arg_1_1.var_.alphaMatValueB06a.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB06a, 1, (arg_1_1.time_ - 0) / var_4_14)
					arg_1_1.var_.alphaMatValueB06a.color = arg_1_1.var_.alphaMatValueB06a.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and arg_1_1.var_.alphaMatValueB06a then
				arg_1_1.var_.alphaMatValueB06a.color.a = 1
				arg_1_1.var_.alphaMatValueB06a.color = arg_1_1.var_.alphaMatValueB06a.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.bgs_.B06a

				arg_1_1.bgs_.B06a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_16 = var_4_15:GetComponent("SpriteRenderer")

				if var_4_16 and var_4_16.sprite then
					local var_4_17 = 2 * (var_4_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_15.transform.localScale = Vector3.New(var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B06a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = arg_1_1.actors_["1019ui_story"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos1019ui_story = var_4_18.localPosition
			end

			local var_4_19 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_1_1.time_ - 1.79999995231628) / var_4_19)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_19 and arg_1_1.time_ < 1.79999995231628 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_20 + 2 and arg_1_1.time_ < var_4_20 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 2
			local var_4_22 = 0.475

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_21 + arg_4_0 then
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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(104071001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 19 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 19)

				if (19 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 19)) > 0 and var_4_22 < var_4_27 then
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

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071001", "story_v_out_104071.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_104071", "104071001", "story_v_out_104071.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_104071", "104071001", "story_v_out_104071.awb")

						arg_1_1:RecordAudio("104071001", var_4_29)
						arg_1_1:RecordAudio("104071001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_104071", "104071001", "story_v_out_104071.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_104071", "104071001", "story_v_out_104071.awb")
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
				actorName = "1019ui_story",
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
	Play104071002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 104071002
		arg_8_1.duration_ = 16.67

		local var_8_0 = {
			ja = 16.666,
			ko = 15,
			zh = 13.966,
			en = 13.866
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
				arg_8_0:Play104071003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["10001_tpose"] == nil and not isNil((Asset.Load("Char/" .. "10001_tpose"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "10001_tpose"), arg_8_1.stage_.transform)

				var_11_0.name = "10001_tpose"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["10001_tpose"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["10001_tpose" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["10001_tpose" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["10001_tpose" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["10001_tpose"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect10001_tpose == nil then
				arg_8_1.var_.characterEffect10001_tpose = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect10001_tpose and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect10001_tpose.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect10001_tpose then
				arg_8_1.var_.characterEffect10001_tpose.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_7 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 and not isNil(var_11_6) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_6) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_8_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_7)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 and not isNil(var_11_6) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_8_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_11_8 = arg_8_1.actors_["10001_tpose"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos10001_tpose = var_11_8.localPosition

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_8.gameObject, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(false)
				end
			end

			local var_11_10 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_10 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos10001_tpose, Vector3.New(0.7, -1.23, -5.8), (arg_8_1.time_ - 0) / var_11_10)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_10 and arg_8_1.time_ < 0 + var_11_10 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0.7, -1.23, -5.8)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles

				local var_11_11 = GameObjectTools.GetOrAddComponent(var_11_8.gameObject, typeof(DynamicBoneHelper))

				if var_11_11 then
					var_11_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001action/10001action2_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_11_12 = 0
			local var_11_13 = 1.7

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_12 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_14 = arg_8_1:GetWordFromCfg(104071002)
				local var_11_15 = arg_8_1:FormatText(var_11_14.content)

				arg_8_1.text_.text = var_11_15

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_17 = 68 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 68)

				if (68 <= 0 and var_11_13 or var_11_13 * (utf8.len(var_11_15) / 68)) > 0 and var_11_13 < var_11_17 then
					arg_8_1.talkMaxDuration = var_11_17

					if var_11_17 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_17 + var_11_12
					end
				end

				arg_8_1.text_.text = var_11_15
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071002", "story_v_out_104071.awb") ~= 0 then
					local var_11_18 = manager.audio:GetVoiceLength("story_v_out_104071", "104071002", "story_v_out_104071.awb") / 1000

					if var_11_18 + var_11_12 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_18 + var_11_12
					end

					if var_11_14.prefab_name ~= "" and arg_8_1.actors_[var_11_14.prefab_name] ~= nil then
						local var_11_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_14.prefab_name].transform, "story_v_out_104071", "104071002", "story_v_out_104071.awb")

						arg_8_1:RecordAudio("104071002", var_11_19)
						arg_8_1:RecordAudio("104071002", var_11_19)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_104071", "104071002", "story_v_out_104071.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_104071", "104071002", "story_v_out_104071.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_20 = math.max(var_11_13, arg_8_1.talkMaxDuration)

			if var_11_12 <= arg_8_1.time_ and arg_8_1.time_ < var_11_12 + var_11_20 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_12) / var_11_20

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_12 + var_11_20 and arg_8_1.time_ < var_11_12 + var_11_20 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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
	Play104071003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 104071003
		arg_12_1.duration_ = 8.47

		local var_12_0 = {
			ja = 8.366,
			ko = 8.466,
			zh = 8.066,
			en = 8.033
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
				arg_12_0:Play104071004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/story10001/story10001actionlink/10001action425")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("10001_tpose", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_15_0 = 0
			local var_15_1 = 1

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_0 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[31].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_2 = arg_12_1:GetWordFromCfg(104071003)
				local var_15_3 = arg_12_1:FormatText(var_15_2.content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 40 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_3) / 40)

				if (40 <= 0 and var_15_1 or var_15_1 * (utf8.len(var_15_3) / 40)) > 0 and var_15_1 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_0
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071003", "story_v_out_104071.awb") ~= 0 then
					local var_15_6 = manager.audio:GetVoiceLength("story_v_out_104071", "104071003", "story_v_out_104071.awb") / 1000

					if var_15_6 + var_15_0 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_6 + var_15_0
					end

					if var_15_2.prefab_name ~= "" and arg_12_1.actors_[var_15_2.prefab_name] ~= nil then
						local var_15_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_2.prefab_name].transform, "story_v_out_104071", "104071003", "story_v_out_104071.awb")

						arg_12_1:RecordAudio("104071003", var_15_7)
						arg_12_1:RecordAudio("104071003", var_15_7)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_104071", "104071003", "story_v_out_104071.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_104071", "104071003", "story_v_out_104071.awb")
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
	Play104071004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 104071004
		arg_16_1.duration_ = 7.6

		local var_16_0 = {
			ja = 7.6,
			ko = 6.6,
			zh = 4.933,
			en = 4.533
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
				arg_16_0:Play104071005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if arg_16_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_19_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_16_1.stage_.transform)

				var_19_0.name = "1084ui_story"
				var_19_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_16_1.actors_["1084ui_story"] = var_19_0

				local var_19_1 = var_19_0:GetComponentInChildren(typeof(CharacterEffect))

				var_19_1.enabled = true

				local var_19_2 = GameObjectTools.GetOrAddComponent(var_19_0, typeof(DynamicBoneHelper))

				if var_19_2 then
					var_19_2:EnableDynamicBone(false)
				end

				arg_16_1:ShowWeapon(var_19_1.transform, false)

				arg_16_1.var_["1084ui_story" .. "Animator"] = var_19_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_16_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_16_1.var_["1084ui_story" .. "LipSync"] = var_19_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_19_3 = arg_16_1.actors_["1084ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = var_19_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_4 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_4 and not isNil(var_19_3) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(var_19_3) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_4 and arg_16_1.time_ < 0 + var_19_4 + arg_19_0 and not isNil(var_19_3) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_6 = arg_16_1.actors_["10001_tpose"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect10001_tpose == nil then
				arg_16_1.var_.characterEffect10001_tpose = var_19_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_7 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_7 and not isNil(var_19_6) then
				if arg_16_1.var_.characterEffect10001_tpose and not isNil(var_19_6) then
					arg_16_1.var_.characterEffect10001_tpose.fillFlat = true
					arg_16_1.var_.characterEffect10001_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_7)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_7 and arg_16_1.time_ < 0 + var_19_7 + arg_19_0 and not isNil(var_19_6) and arg_16_1.var_.characterEffect10001_tpose then
				arg_16_1.var_.characterEffect10001_tpose.fillFlat = true
				arg_16_1.var_.characterEffect10001_tpose.fillRatio = 0.5
			end

			local var_19_8 = arg_16_1.actors_["10001_tpose"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos10001_tpose = var_19_8.localPosition

				local var_19_9 = GameObjectTools.GetOrAddComponent(var_19_8.gameObject, typeof(DynamicBoneHelper))

				if var_19_9 then
					var_19_9:EnableDynamicBone(false)
				end
			end

			local var_19_10 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_10 then
				var_19_8.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos10001_tpose, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_10)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_10 and arg_16_1.time_ < 0 + var_19_10 + arg_19_0 then
				var_19_8.localPosition = Vector3.New(0, 100, 0)
				var_19_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_8.position).x, (manager.ui.mainCamera.transform.position - var_19_8.position).y, (manager.ui.mainCamera.transform.position - var_19_8.position).z)
				var_19_8.localEulerAngles.z = 0
				var_19_8.localEulerAngles.x = 0
				var_19_8.localEulerAngles = var_19_8.localEulerAngles

				local var_19_11 = GameObjectTools.GetOrAddComponent(var_19_8.gameObject, typeof(DynamicBoneHelper))

				if var_19_11 then
					var_19_11:EnableDynamicBone(true)
				end
			end

			local var_19_12 = arg_16_1.actors_["1019ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1019ui_story = var_19_12.localPosition
			end

			local var_19_13 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_13 then
				var_19_12.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_13)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_13 and arg_16_1.time_ < 0 + var_19_13 + arg_19_0 then
				var_19_12.localPosition = Vector3.New(0, 100, 0)
				var_19_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_12.position).x, (manager.ui.mainCamera.transform.position - var_19_12.position).y, (manager.ui.mainCamera.transform.position - var_19_12.position).z)
				var_19_12.localEulerAngles.z = 0
				var_19_12.localEulerAngles.x = 0
				var_19_12.localEulerAngles = var_19_12.localEulerAngles
			end

			local var_19_14 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_14.localPosition
			end

			local var_19_15 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_15 then
				var_19_14.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_16_1.time_ - 0) / var_19_15)
				var_19_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_14.position).x, (manager.ui.mainCamera.transform.position - var_19_14.position).y, (manager.ui.mainCamera.transform.position - var_19_14.position).z)
				var_19_14.localEulerAngles.z = 0
				var_19_14.localEulerAngles.x = 0
				var_19_14.localEulerAngles = var_19_14.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_15 and arg_16_1.time_ < 0 + var_19_15 + arg_19_0 then
				var_19_14.localPosition = Vector3.New(0, -0.97, -6)
				var_19_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_14.position).x, (manager.ui.mainCamera.transform.position - var_19_14.position).y, (manager.ui.mainCamera.transform.position - var_19_14.position).z)
				var_19_14.localEulerAngles.z = 0
				var_19_14.localEulerAngles.x = 0
				var_19_14.localEulerAngles = var_19_14.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action9_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_19_16 = 0
			local var_19_17 = 0.65

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_16 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_18 = arg_16_1:GetWordFromCfg(104071004)
				local var_19_19 = arg_16_1:FormatText(var_19_18.content)

				arg_16_1.text_.text = var_19_19

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_21 = 26 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_19) / 26)

				if (26 <= 0 and var_19_17 or var_19_17 * (utf8.len(var_19_19) / 26)) > 0 and var_19_17 < var_19_21 then
					arg_16_1.talkMaxDuration = var_19_21

					if var_19_21 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_21 + var_19_16
					end
				end

				arg_16_1.text_.text = var_19_19
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071004", "story_v_out_104071.awb") ~= 0 then
					local var_19_22 = manager.audio:GetVoiceLength("story_v_out_104071", "104071004", "story_v_out_104071.awb") / 1000

					if var_19_22 + var_19_16 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_22 + var_19_16
					end

					if var_19_18.prefab_name ~= "" and arg_16_1.actors_[var_19_18.prefab_name] ~= nil then
						local var_19_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_18.prefab_name].transform, "story_v_out_104071", "104071004", "story_v_out_104071.awb")

						arg_16_1:RecordAudio("104071004", var_19_23)
						arg_16_1:RecordAudio("104071004", var_19_23)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_104071", "104071004", "story_v_out_104071.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_104071", "104071004", "story_v_out_104071.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_24 = math.max(var_19_17, arg_16_1.talkMaxDuration)

			if var_19_16 <= arg_16_1.time_ and arg_16_1.time_ < var_19_16 + var_19_24 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_16) / var_19_24

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_16 + var_19_24 and arg_16_1.time_ < var_19_16 + var_19_24 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10001_tpose",
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

		arg_16_1:InitPlayNodeList()
	end,
	Play104071005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 104071005
		arg_20_1.duration_ = 3.57

		local var_20_0 = {
			ja = 3.2,
			ko = 3.1,
			zh = 3.566,
			en = 3.433
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
				arg_20_0:Play104071006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story == nil then
				arg_20_1.var_.characterEffect1019ui_story = arg_20_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) then
				if arg_20_1.var_.characterEffect1019ui_story and not isNil(arg_20_1.actors_["1019ui_story"]) then
					arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1019ui_story"]) and arg_20_1.var_.characterEffect1019ui_story then
				arg_20_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_23_2 = arg_20_1.actors_["1084ui_story"]

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1084ui_story == nil then
				arg_20_1.var_.characterEffect1084ui_story = var_23_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_3 = 0.1

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_3 and not isNil(var_23_2) then
				if arg_20_1.var_.characterEffect1084ui_story and not isNil(var_23_2) then
					arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_3)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_3 and arg_20_1.time_ < 0 + var_23_3 + arg_23_0 and not isNil(var_23_2) and arg_20_1.var_.characterEffect1084ui_story then
				arg_20_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_23_4 = arg_20_1.actors_["1084ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1084ui_story = var_23_4.localPosition
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_20_1.time_ - 0) / var_23_5)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0, 100, 0)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			local var_23_6 = arg_20_1.actors_["1019ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_6.localPosition
			end

			local var_23_7 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_7 then
				var_23_6.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_20_1.time_ - 0) / var_23_7)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_7 and arg_20_1.time_ < 0 + var_23_7 + arg_23_0 then
				var_23_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_23_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_6.position).x, (manager.ui.mainCamera.transform.position - var_23_6.position).y, (manager.ui.mainCamera.transform.position - var_23_6.position).z)
				var_23_6.localEulerAngles.z = 0
				var_23_6.localEulerAngles.x = 0
				var_23_6.localEulerAngles = var_23_6.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_23_8 = 0
			local var_23_9 = 0.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_8 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, true)

				arg_20_1.leftNameTxt_.text = arg_20_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_20_1.leftNameTxt_.transform)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1.leftNameTxt_.text)
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_10 = arg_20_1:GetWordFromCfg(104071005)
				local var_23_11 = arg_20_1:FormatText(var_23_10.content)

				arg_20_1.text_.text = var_23_11

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_13 = 17 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 17)

				if (17 <= 0 and var_23_9 or var_23_9 * (utf8.len(var_23_11) / 17)) > 0 and var_23_9 < var_23_13 then
					arg_20_1.talkMaxDuration = var_23_13

					if var_23_13 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_13 + var_23_8
					end
				end

				arg_20_1.text_.text = var_23_11
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071005", "story_v_out_104071.awb") ~= 0 then
					local var_23_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071005", "story_v_out_104071.awb") / 1000

					if var_23_14 + var_23_8 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_14 + var_23_8
					end

					if var_23_10.prefab_name ~= "" and arg_20_1.actors_[var_23_10.prefab_name] ~= nil then
						local var_23_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_10.prefab_name].transform, "story_v_out_104071", "104071005", "story_v_out_104071.awb")

						arg_20_1:RecordAudio("104071005", var_23_15)
						arg_20_1:RecordAudio("104071005", var_23_15)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_104071", "104071005", "story_v_out_104071.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_104071", "104071005", "story_v_out_104071.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_16 = math.max(var_23_9, arg_20_1.talkMaxDuration)

			if var_23_8 <= arg_20_1.time_ and arg_20_1.time_ < var_23_8 + var_23_16 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_8) / var_23_16

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_8 + var_23_16 and arg_20_1.time_ < var_23_8 + var_23_16 + arg_23_0 then
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

		arg_20_1:InitPlayNodeList()
	end,
	Play104071006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 104071006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play104071007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = arg_24_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(arg_24_1.actors_["1019ui_story"]) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_0)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["1019ui_story"]) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_27_1 = 0
			local var_27_2 = 1.3

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_1 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_3 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(104071006).content)

				arg_24_1.text_.text = var_27_3

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_5 = 52 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 52)

				if (52 <= 0 and var_27_2 or var_27_2 * (utf8.len(var_27_3) / 52)) > 0 and var_27_2 < var_27_5 then
					arg_24_1.talkMaxDuration = var_27_5

					if var_27_5 + var_27_1 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + var_27_1
					end
				end

				arg_24_1.text_.text = var_27_3
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_6 = math.max(var_27_2, arg_24_1.talkMaxDuration)

			if var_27_1 <= arg_24_1.time_ and arg_24_1.time_ < var_27_1 + var_27_6 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_1) / var_27_6

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_1 + var_27_6 and arg_24_1.time_ < var_27_1 + var_27_6 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play104071007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 104071007
		arg_28_1.duration_ = 4.63

		local var_28_0 = {
			ja = 4.633,
			ko = 2.4,
			zh = 2.2,
			en = 2.3
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
				arg_28_0:Play104071008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "1036ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["1036ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["1036ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["1036ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["1036ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1036ui_story == nil then
				arg_28_1.var_.characterEffect1036ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect1036ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect1036ui_story then
				arg_28_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_31_6 = arg_28_1.actors_["1019ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1019ui_story = var_31_6.localPosition
			end

			local var_31_7 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_7)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(0, 100, 0)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			local var_31_8 = arg_28_1.actors_["1036ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1036ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(0, -1.09, -5.78)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_31_10 = 0
			local var_31_11 = 0.4

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_10 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_12 = arg_28_1:GetWordFromCfg(104071007)
				local var_31_13 = arg_28_1:FormatText(var_31_12.content)

				arg_28_1.text_.text = var_31_13

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_15 = 16 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 16)

				if (16 <= 0 and var_31_11 or var_31_11 * (utf8.len(var_31_13) / 16)) > 0 and var_31_11 < var_31_15 then
					arg_28_1.talkMaxDuration = var_31_15

					if var_31_15 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_15 + var_31_10
					end
				end

				arg_28_1.text_.text = var_31_13
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071007", "story_v_out_104071.awb") ~= 0 then
					local var_31_16 = manager.audio:GetVoiceLength("story_v_out_104071", "104071007", "story_v_out_104071.awb") / 1000

					if var_31_16 + var_31_10 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_16 + var_31_10
					end

					if var_31_12.prefab_name ~= "" and arg_28_1.actors_[var_31_12.prefab_name] ~= nil then
						local var_31_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_12.prefab_name].transform, "story_v_out_104071", "104071007", "story_v_out_104071.awb")

						arg_28_1:RecordAudio("104071007", var_31_17)
						arg_28_1:RecordAudio("104071007", var_31_17)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_104071", "104071007", "story_v_out_104071.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_104071", "104071007", "story_v_out_104071.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_18 = math.max(var_31_11, arg_28_1.talkMaxDuration)

			if var_31_10 <= arg_28_1.time_ and arg_28_1.time_ < var_31_10 + var_31_18 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_10) / var_31_18

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_10 + var_31_18 and arg_28_1.time_ < var_31_10 + var_31_18 + arg_31_0 then
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
			},
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

		arg_28_1:InitPlayNodeList()
	end,
	Play104071008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 104071008
		arg_32_1.duration_ = 3.87

		local var_32_0 = {
			ja = 2.133,
			ko = 2.766,
			zh = 3.866,
			en = 2.7
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
				arg_32_0:Play104071009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["1036ui_story"]) and arg_32_1.var_.characterEffect1036ui_story == nil then
				arg_32_1.var_.characterEffect1036ui_story = arg_32_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["1036ui_story"]) then
				if arg_32_1.var_.characterEffect1036ui_story and not isNil(arg_32_1.actors_["1036ui_story"]) then
					arg_32_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_0)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["1036ui_story"]) and arg_32_1.var_.characterEffect1036ui_story then
				arg_32_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_35_1 = 0
			local var_35_2 = 0.3

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, true)
				arg_32_1.iconController_:SetSelectedState("hero")

				arg_32_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_32_1.callingController_:SetSelectedState("normal")

				arg_32_1.keyicon_.color = Color.New(1, 1, 1)
				arg_32_1.icon_.color = Color.New(1, 1, 1)

				local var_35_3 = arg_32_1:GetWordFromCfg(104071008)
				local var_35_4 = arg_32_1:FormatText(var_35_3.content)

				arg_32_1.text_.text = var_35_4

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_6 = 12 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 12)

				if (12 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_4) / 12)) > 0 and var_35_2 < var_35_6 then
					arg_32_1.talkMaxDuration = var_35_6

					if var_35_6 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_6 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_4
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071008", "story_v_out_104071.awb") ~= 0 then
					local var_35_7 = manager.audio:GetVoiceLength("story_v_out_104071", "104071008", "story_v_out_104071.awb") / 1000

					if var_35_7 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_7 + var_35_1
					end

					if var_35_3.prefab_name ~= "" and arg_32_1.actors_[var_35_3.prefab_name] ~= nil then
						local var_35_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_3.prefab_name].transform, "story_v_out_104071", "104071008", "story_v_out_104071.awb")

						arg_32_1:RecordAudio("104071008", var_35_8)
						arg_32_1:RecordAudio("104071008", var_35_8)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_104071", "104071008", "story_v_out_104071.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_104071", "104071008", "story_v_out_104071.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_9 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_9 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_9

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_9 and arg_32_1.time_ < var_35_1 + var_35_9 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play104071009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 104071009
		arg_36_1.duration_ = 2

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play104071010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1036ui_story"]) and arg_36_1.var_.characterEffect1036ui_story == nil then
				arg_36_1.var_.characterEffect1036ui_story = arg_36_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1036ui_story"]) then
				if arg_36_1.var_.characterEffect1036ui_story and not isNil(arg_36_1.actors_["1036ui_story"]) then
					arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1036ui_story"]) and arg_36_1.var_.characterEffect1036ui_story then
				arg_36_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_2")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_2 = 0
			local var_39_3 = 0.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_2 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_4 = arg_36_1:GetWordFromCfg(104071009)
				local var_39_5 = arg_36_1:FormatText(var_39_4.content)

				arg_36_1.text_.text = var_39_5

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_7 = 6 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 6)

				if (6 <= 0 and var_39_3 or var_39_3 * (utf8.len(var_39_5) / 6)) > 0 and var_39_3 < var_39_7 then
					arg_36_1.talkMaxDuration = var_39_7

					if var_39_7 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_7 + var_39_2
					end
				end

				arg_36_1.text_.text = var_39_5
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071009", "story_v_out_104071.awb") ~= 0 then
					local var_39_8 = manager.audio:GetVoiceLength("story_v_out_104071", "104071009", "story_v_out_104071.awb") / 1000

					if var_39_8 + var_39_2 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_8 + var_39_2
					end

					if var_39_4.prefab_name ~= "" and arg_36_1.actors_[var_39_4.prefab_name] ~= nil then
						local var_39_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_4.prefab_name].transform, "story_v_out_104071", "104071009", "story_v_out_104071.awb")

						arg_36_1:RecordAudio("104071009", var_39_9)
						arg_36_1:RecordAudio("104071009", var_39_9)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_104071", "104071009", "story_v_out_104071.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_104071", "104071009", "story_v_out_104071.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_10 = math.max(var_39_3, arg_36_1.talkMaxDuration)

			if var_39_2 <= arg_36_1.time_ and arg_36_1.time_ < var_39_2 + var_39_10 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_2) / var_39_10

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_2 + var_39_10 and arg_36_1.time_ < var_39_2 + var_39_10 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play104071010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 104071010
		arg_40_1.duration_ = 5.8

		local var_40_0 = {
			ja = 4.466,
			ko = 4.4,
			zh = 5.8,
			en = 4.6
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
				arg_40_0:Play104071011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1036ui_story"]) and arg_40_1.var_.characterEffect1036ui_story == nil then
				arg_40_1.var_.characterEffect1036ui_story = arg_40_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1036ui_story"]) then
				if arg_40_1.var_.characterEffect1036ui_story and not isNil(arg_40_1.actors_["1036ui_story"]) then
					arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_0)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1036ui_story"]) and arg_40_1.var_.characterEffect1036ui_story then
				arg_40_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_43_1 = 0
			local var_43_2 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_1 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, true)
				arg_40_1.iconController_:SetSelectedState("hero")

				arg_40_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_40_1.callingController_:SetSelectedState("normal")

				arg_40_1.keyicon_.color = Color.New(1, 1, 1)
				arg_40_1.icon_.color = Color.New(1, 1, 1)

				local var_43_3 = arg_40_1:GetWordFromCfg(104071010)
				local var_43_4 = arg_40_1:FormatText(var_43_3.content)

				arg_40_1.text_.text = var_43_4

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_6 = 22 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 22)

				if (22 <= 0 and var_43_2 or var_43_2 * (utf8.len(var_43_4) / 22)) > 0 and var_43_2 < var_43_6 then
					arg_40_1.talkMaxDuration = var_43_6

					if var_43_6 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_6 + var_43_1
					end
				end

				arg_40_1.text_.text = var_43_4
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071010", "story_v_out_104071.awb") ~= 0 then
					local var_43_7 = manager.audio:GetVoiceLength("story_v_out_104071", "104071010", "story_v_out_104071.awb") / 1000

					if var_43_7 + var_43_1 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_7 + var_43_1
					end

					if var_43_3.prefab_name ~= "" and arg_40_1.actors_[var_43_3.prefab_name] ~= nil then
						local var_43_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_3.prefab_name].transform, "story_v_out_104071", "104071010", "story_v_out_104071.awb")

						arg_40_1:RecordAudio("104071010", var_43_8)
						arg_40_1:RecordAudio("104071010", var_43_8)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_104071", "104071010", "story_v_out_104071.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_104071", "104071010", "story_v_out_104071.awb")
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

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play104071011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 104071011
		arg_44_1.duration_ = 3.43

		local var_44_0 = {
			ja = 3.433,
			ko = 3.4,
			zh = 3.166,
			en = 3.233
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
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play104071012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(arg_44_1.actors_["1036ui_story"]) and arg_44_1.var_.characterEffect1036ui_story == nil then
				arg_44_1.var_.characterEffect1036ui_story = arg_44_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_0 = 0.1

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_0 and not isNil(arg_44_1.actors_["1036ui_story"]) then
				if arg_44_1.var_.characterEffect1036ui_story and not isNil(arg_44_1.actors_["1036ui_story"]) then
					arg_44_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_0 and arg_44_1.time_ < 0 + var_47_0 + arg_47_0 and not isNil(arg_44_1.actors_["1036ui_story"]) and arg_44_1.var_.characterEffect1036ui_story then
				arg_44_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action4_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_47_2 = 0
			local var_47_3 = 0.35

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_2 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_4 = arg_44_1:GetWordFromCfg(104071011)
				local var_47_5 = arg_44_1:FormatText(var_47_4.content)

				arg_44_1.text_.text = var_47_5

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_7 = 14 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 14)

				if (14 <= 0 and var_47_3 or var_47_3 * (utf8.len(var_47_5) / 14)) > 0 and var_47_3 < var_47_7 then
					arg_44_1.talkMaxDuration = var_47_7

					if var_47_7 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_7 + var_47_2
					end
				end

				arg_44_1.text_.text = var_47_5
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071011", "story_v_out_104071.awb") ~= 0 then
					local var_47_8 = manager.audio:GetVoiceLength("story_v_out_104071", "104071011", "story_v_out_104071.awb") / 1000

					if var_47_8 + var_47_2 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_8 + var_47_2
					end

					if var_47_4.prefab_name ~= "" and arg_44_1.actors_[var_47_4.prefab_name] ~= nil then
						local var_47_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_4.prefab_name].transform, "story_v_out_104071", "104071011", "story_v_out_104071.awb")

						arg_44_1:RecordAudio("104071011", var_47_9)
						arg_44_1:RecordAudio("104071011", var_47_9)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_104071", "104071011", "story_v_out_104071.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_104071", "104071011", "story_v_out_104071.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_10 = math.max(var_47_3, arg_44_1.talkMaxDuration)

			if var_47_2 <= arg_44_1.time_ and arg_44_1.time_ < var_47_2 + var_47_10 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_2) / var_47_10

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_2 + var_47_10 and arg_44_1.time_ < var_47_2 + var_47_10 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play104071012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 104071012
		arg_48_1.duration_ = 3.53

		local var_48_0 = {
			ja = 3.066,
			ko = 2.4,
			zh = 3.533,
			en = 2.8
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
				arg_48_0:Play104071013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			local var_51_0 = 0
			local var_51_1 = 0.375

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_0 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_2 = arg_48_1:GetWordFromCfg(104071012)
				local var_51_3 = arg_48_1:FormatText(var_51_2.content)

				arg_48_1.text_.text = var_51_3

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_5 = 15 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 15)

				if (15 <= 0 and var_51_1 or var_51_1 * (utf8.len(var_51_3) / 15)) > 0 and var_51_1 < var_51_5 then
					arg_48_1.talkMaxDuration = var_51_5

					if var_51_5 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_5 + var_51_0
					end
				end

				arg_48_1.text_.text = var_51_3
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071012", "story_v_out_104071.awb") ~= 0 then
					local var_51_6 = manager.audio:GetVoiceLength("story_v_out_104071", "104071012", "story_v_out_104071.awb") / 1000

					if var_51_6 + var_51_0 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_6 + var_51_0
					end

					if var_51_2.prefab_name ~= "" and arg_48_1.actors_[var_51_2.prefab_name] ~= nil then
						local var_51_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_2.prefab_name].transform, "story_v_out_104071", "104071012", "story_v_out_104071.awb")

						arg_48_1:RecordAudio("104071012", var_51_7)
						arg_48_1:RecordAudio("104071012", var_51_7)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_104071", "104071012", "story_v_out_104071.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_104071", "104071012", "story_v_out_104071.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_8 = math.max(var_51_1, arg_48_1.talkMaxDuration)

			if var_51_0 <= arg_48_1.time_ and arg_48_1.time_ < var_51_0 + var_51_8 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_0) / var_51_8

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_0 + var_51_8 and arg_48_1.time_ < var_51_0 + var_51_8 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play104071013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 104071013
		arg_52_1.duration_ = 7.3

		local var_52_0 = {
			ja = 7.266,
			ko = 6.933,
			zh = 7.3,
			en = 6.3
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
				arg_52_0:Play104071014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["1036ui_story"]) and arg_52_1.var_.characterEffect1036ui_story == nil then
				arg_52_1.var_.characterEffect1036ui_story = arg_52_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["1036ui_story"]) then
				if arg_52_1.var_.characterEffect1036ui_story and not isNil(arg_52_1.actors_["1036ui_story"]) then
					arg_52_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["1036ui_story"]) and arg_52_1.var_.characterEffect1036ui_story then
				arg_52_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0
			local var_55_2 = 0.9

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1037")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_3 = arg_52_1:GetWordFromCfg(104071013)
				local var_55_4 = arg_52_1:FormatText(var_55_3.content)

				arg_52_1.text_.text = var_55_4

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_6 = 35 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 35)

				if (35 <= 0 and var_55_2 or var_55_2 * (utf8.len(var_55_4) / 35)) > 0 and var_55_2 < var_55_6 then
					arg_52_1.talkMaxDuration = var_55_6

					if var_55_6 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_6 + var_55_1
					end
				end

				arg_52_1.text_.text = var_55_4
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071013", "story_v_out_104071.awb") ~= 0 then
					local var_55_7 = manager.audio:GetVoiceLength("story_v_out_104071", "104071013", "story_v_out_104071.awb") / 1000

					if var_55_7 + var_55_1 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_7 + var_55_1
					end

					if var_55_3.prefab_name ~= "" and arg_52_1.actors_[var_55_3.prefab_name] ~= nil then
						local var_55_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_3.prefab_name].transform, "story_v_out_104071", "104071013", "story_v_out_104071.awb")

						arg_52_1:RecordAudio("104071013", var_55_8)
						arg_52_1:RecordAudio("104071013", var_55_8)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_104071", "104071013", "story_v_out_104071.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_104071", "104071013", "story_v_out_104071.awb")
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

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play104071014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 104071014
		arg_56_1.duration_ = 2

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play104071015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["1036ui_story"]) and arg_56_1.var_.characterEffect1036ui_story == nil then
				arg_56_1.var_.characterEffect1036ui_story = arg_56_1.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["1036ui_story"]) then
				if arg_56_1.var_.characterEffect1036ui_story and not isNil(arg_56_1.actors_["1036ui_story"]) then
					arg_56_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["1036ui_story"]) and arg_56_1.var_.characterEffect1036ui_story then
				arg_56_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036actionlink/1036action447")
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_59_2 = 0
			local var_59_3 = 0.05

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_2 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_4 = arg_56_1:GetWordFromCfg(104071014)
				local var_59_5 = arg_56_1:FormatText(var_59_4.content)

				arg_56_1.text_.text = var_59_5

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_7 = 2 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 2)

				if (2 <= 0 and var_59_3 or var_59_3 * (utf8.len(var_59_5) / 2)) > 0 and var_59_3 < var_59_7 then
					arg_56_1.talkMaxDuration = var_59_7

					if var_59_7 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_7 + var_59_2
					end
				end

				arg_56_1.text_.text = var_59_5
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071014", "story_v_out_104071.awb") ~= 0 then
					local var_59_8 = manager.audio:GetVoiceLength("story_v_out_104071", "104071014", "story_v_out_104071.awb") / 1000

					if var_59_8 + var_59_2 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_8 + var_59_2
					end

					if var_59_4.prefab_name ~= "" and arg_56_1.actors_[var_59_4.prefab_name] ~= nil then
						local var_59_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_4.prefab_name].transform, "story_v_out_104071", "104071014", "story_v_out_104071.awb")

						arg_56_1:RecordAudio("104071014", var_59_9)
						arg_56_1:RecordAudio("104071014", var_59_9)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_104071", "104071014", "story_v_out_104071.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_104071", "104071014", "story_v_out_104071.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_10 = math.max(var_59_3, arg_56_1.talkMaxDuration)

			if var_59_2 <= arg_56_1.time_ and arg_56_1.time_ < var_59_2 + var_59_10 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_2) / var_59_10

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_2 + var_59_10 and arg_56_1.time_ < var_59_2 + var_59_10 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play104071015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 104071015
		arg_60_1.duration_ = 2.93

		local var_60_0 = {
			ja = 2.3,
			ko = 2.033,
			zh = 2.933,
			en = 2.866
		}
		local var_60_1 = manager.audio:GetLocalizationFlag()

		if var_60_0[var_60_1] ~= nil then
			arg_60_1.duration_ = var_60_0[var_60_1]
		end

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play104071016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) and arg_60_1.var_.characterEffect1019ui_story == nil then
				arg_60_1.var_.characterEffect1019ui_story = arg_60_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) then
				if arg_60_1.var_.characterEffect1019ui_story and not isNil(arg_60_1.actors_["1019ui_story"]) then
					arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["1019ui_story"]) and arg_60_1.var_.characterEffect1019ui_story then
				arg_60_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["1036ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1036ui_story == nil then
				arg_60_1.var_.characterEffect1036ui_story = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect1036ui_story and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_60_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect1036ui_story then
				arg_60_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_60_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_63_4 = arg_60_1.actors_["1036ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1036ui_story = var_63_4.localPosition
			end

			local var_63_5 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_5 then
				var_63_4.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_5)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_5 and arg_60_1.time_ < 0 + var_63_5 + arg_63_0 then
				var_63_4.localPosition = Vector3.New(0, 100, 0)
				var_63_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_4.position).x, (manager.ui.mainCamera.transform.position - var_63_4.position).y, (manager.ui.mainCamera.transform.position - var_63_4.position).z)
				var_63_4.localEulerAngles.z = 0
				var_63_4.localEulerAngles.x = 0
				var_63_4.localEulerAngles = var_63_4.localEulerAngles
			end

			local var_63_6 = arg_60_1.actors_["1019ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1019ui_story = var_63_6.localPosition
			end

			local var_63_7 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_7 then
				var_63_6.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_60_1.time_ - 0) / var_63_7)
				var_63_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_6.position).x, (manager.ui.mainCamera.transform.position - var_63_6.position).y, (manager.ui.mainCamera.transform.position - var_63_6.position).z)
				var_63_6.localEulerAngles.z = 0
				var_63_6.localEulerAngles.x = 0
				var_63_6.localEulerAngles = var_63_6.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_7 and arg_60_1.time_ < 0 + var_63_7 + arg_63_0 then
				var_63_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_63_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_6.position).x, (manager.ui.mainCamera.transform.position - var_63_6.position).y, (manager.ui.mainCamera.transform.position - var_63_6.position).z)
				var_63_6.localEulerAngles.z = 0
				var_63_6.localEulerAngles.x = 0
				var_63_6.localEulerAngles = var_63_6.localEulerAngles
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_63_8 = 0
			local var_63_9 = 0.35

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_8 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_10 = arg_60_1:GetWordFromCfg(104071015)
				local var_63_11 = arg_60_1:FormatText(var_63_10.content)

				arg_60_1.text_.text = var_63_11

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_13 = 14 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 14)

				if (14 <= 0 and var_63_9 or var_63_9 * (utf8.len(var_63_11) / 14)) > 0 and var_63_9 < var_63_13 then
					arg_60_1.talkMaxDuration = var_63_13

					if var_63_13 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_13 + var_63_8
					end
				end

				arg_60_1.text_.text = var_63_11
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071015", "story_v_out_104071.awb") ~= 0 then
					local var_63_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071015", "story_v_out_104071.awb") / 1000

					if var_63_14 + var_63_8 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_14 + var_63_8
					end

					if var_63_10.prefab_name ~= "" and arg_60_1.actors_[var_63_10.prefab_name] ~= nil then
						local var_63_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_10.prefab_name].transform, "story_v_out_104071", "104071015", "story_v_out_104071.awb")

						arg_60_1:RecordAudio("104071015", var_63_15)
						arg_60_1:RecordAudio("104071015", var_63_15)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_104071", "104071015", "story_v_out_104071.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_104071", "104071015", "story_v_out_104071.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_16 = math.max(var_63_9, arg_60_1.talkMaxDuration)

			if var_63_8 <= arg_60_1.time_ and arg_60_1.time_ < var_63_8 + var_63_16 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_8) / var_63_16

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_8 + var_63_16 and arg_60_1.time_ < var_63_8 + var_63_16 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play104071016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 104071016
		arg_64_1.duration_ = 10.13

		local var_64_0 = {
			ja = 9.4,
			ko = 9.366,
			zh = 10.133,
			en = 8.266
		}
		local var_64_1 = manager.audio:GetLocalizationFlag()

		if var_64_0[var_64_1] ~= nil then
			arg_64_1.duration_ = var_64_0[var_64_1]
		end

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play104071017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1019ui_story"]) and arg_64_1.var_.characterEffect1019ui_story == nil then
				arg_64_1.var_.characterEffect1019ui_story = arg_64_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1019ui_story"]) then
				if arg_64_1.var_.characterEffect1019ui_story and not isNil(arg_64_1.actors_["1019ui_story"]) then
					arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1019ui_story"]) and arg_64_1.var_.characterEffect1019ui_story then
				arg_64_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 0.95

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[44].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:GetWordFromCfg(104071016)
				local var_67_4 = arg_64_1:FormatText(var_67_3.content)

				arg_64_1.text_.text = var_67_4

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_6 = 37 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 37)

				if (37 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_4) / 37)) > 0 and var_67_2 < var_67_6 then
					arg_64_1.talkMaxDuration = var_67_6

					if var_67_6 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_6 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_4
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071016", "story_v_out_104071.awb") ~= 0 then
					local var_67_7 = manager.audio:GetVoiceLength("story_v_out_104071", "104071016", "story_v_out_104071.awb") / 1000

					if var_67_7 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_7 + var_67_1
					end

					if var_67_3.prefab_name ~= "" and arg_64_1.actors_[var_67_3.prefab_name] ~= nil then
						local var_67_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_3.prefab_name].transform, "story_v_out_104071", "104071016", "story_v_out_104071.awb")

						arg_64_1:RecordAudio("104071016", var_67_8)
						arg_64_1:RecordAudio("104071016", var_67_8)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_104071", "104071016", "story_v_out_104071.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_104071", "104071016", "story_v_out_104071.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_9 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_9 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_9

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_9 and arg_64_1.time_ < var_67_1 + var_67_9 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play104071017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 104071017
		arg_68_1.duration_ = 2.23

		local var_68_0 = {
			ja = 2.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		}
		local var_68_1 = manager.audio:GetLocalizationFlag()

		if var_68_0[var_68_1] ~= nil then
			arg_68_1.duration_ = var_68_0[var_68_1]
		end

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play104071018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if arg_68_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_71_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_68_1.stage_.transform)

				var_71_0.name = "1011ui_story"
				var_71_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_68_1.actors_["1011ui_story"] = var_71_0

				local var_71_1 = var_71_0:GetComponentInChildren(typeof(CharacterEffect))

				var_71_1.enabled = true

				local var_71_2 = GameObjectTools.GetOrAddComponent(var_71_0, typeof(DynamicBoneHelper))

				if var_71_2 then
					var_71_2:EnableDynamicBone(false)
				end

				arg_68_1:ShowWeapon(var_71_1.transform, false)

				arg_68_1.var_["1011ui_story" .. "Animator"] = var_71_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_68_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_68_1.var_["1011ui_story" .. "LipSync"] = var_71_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_71_3 = arg_68_1.actors_["1011ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_4 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 and not isNil(var_71_3) then
				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_3) then
					arg_68_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 and not isNil(var_71_3) and arg_68_1.var_.characterEffect1011ui_story then
				arg_68_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_71_6 = arg_68_1.actors_["1019ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1019ui_story = var_71_6.localPosition
			end

			local var_71_7 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_7 then
				var_71_6.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_68_1.time_ - 0) / var_71_7)
				var_71_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_6.position).x, (manager.ui.mainCamera.transform.position - var_71_6.position).y, (manager.ui.mainCamera.transform.position - var_71_6.position).z)
				var_71_6.localEulerAngles.z = 0
				var_71_6.localEulerAngles.x = 0
				var_71_6.localEulerAngles = var_71_6.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_7 and arg_68_1.time_ < 0 + var_71_7 + arg_71_0 then
				var_71_6.localPosition = Vector3.New(0, 100, 0)
				var_71_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_6.position).x, (manager.ui.mainCamera.transform.position - var_71_6.position).y, (manager.ui.mainCamera.transform.position - var_71_6.position).z)
				var_71_6.localEulerAngles.z = 0
				var_71_6.localEulerAngles.x = 0
				var_71_6.localEulerAngles = var_71_6.localEulerAngles
			end

			local var_71_8 = arg_68_1.actors_["1011ui_story"].transform

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.var_.moveOldPos1011ui_story = var_71_8.localPosition
			end

			local var_71_9 = 0.001

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_9 then
				var_71_8.localPosition = Vector3.Lerp(arg_68_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_68_1.time_ - 0) / var_71_9)
				var_71_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_8.position).x, (manager.ui.mainCamera.transform.position - var_71_8.position).y, (manager.ui.mainCamera.transform.position - var_71_8.position).z)
				var_71_8.localEulerAngles.z = 0
				var_71_8.localEulerAngles.x = 0
				var_71_8.localEulerAngles = var_71_8.localEulerAngles
			end

			if arg_68_1.time_ >= 0 + var_71_9 and arg_68_1.time_ < 0 + var_71_9 + arg_71_0 then
				var_71_8.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_71_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_71_8.position).x, (manager.ui.mainCamera.transform.position - var_71_8.position).y, (manager.ui.mainCamera.transform.position - var_71_8.position).z)
				var_71_8.localEulerAngles.z = 0
				var_71_8.localEulerAngles.x = 0
				var_71_8.localEulerAngles = var_71_8.localEulerAngles
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_71_10 = 0
			local var_71_11 = 0.15

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_10 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_12 = arg_68_1:GetWordFromCfg(104071017)
				local var_71_13 = arg_68_1:FormatText(var_71_12.content)

				arg_68_1.text_.text = var_71_13

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_15 = 6 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 6)

				if (6 <= 0 and var_71_11 or var_71_11 * (utf8.len(var_71_13) / 6)) > 0 and var_71_11 < var_71_15 then
					arg_68_1.talkMaxDuration = var_71_15

					if var_71_15 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_15 + var_71_10
					end
				end

				arg_68_1.text_.text = var_71_13
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071017", "story_v_out_104071.awb") ~= 0 then
					local var_71_16 = manager.audio:GetVoiceLength("story_v_out_104071", "104071017", "story_v_out_104071.awb") / 1000

					if var_71_16 + var_71_10 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_16 + var_71_10
					end

					if var_71_12.prefab_name ~= "" and arg_68_1.actors_[var_71_12.prefab_name] ~= nil then
						local var_71_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_12.prefab_name].transform, "story_v_out_104071", "104071017", "story_v_out_104071.awb")

						arg_68_1:RecordAudio("104071017", var_71_17)
						arg_68_1:RecordAudio("104071017", var_71_17)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_104071", "104071017", "story_v_out_104071.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_104071", "104071017", "story_v_out_104071.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_18 = math.max(var_71_11, arg_68_1.talkMaxDuration)

			if var_71_10 <= arg_68_1.time_ and arg_68_1.time_ < var_71_10 + var_71_18 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_10) / var_71_18

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_10 + var_71_18 and arg_68_1.time_ < var_71_10 + var_71_18 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_68_1:InitPlayNodeList()
	end,
	Play104071018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 104071018
		arg_72_1.duration_ = 3.57

		local var_72_0 = {
			ja = 3.533,
			ko = 3.566,
			zh = 2.9,
			en = 3.2
		}
		local var_72_1 = manager.audio:GetLocalizationFlag()

		if var_72_0[var_72_1] ~= nil then
			arg_72_1.duration_ = var_72_0[var_72_1]
		end

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play104071019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story == nil then
				arg_72_1.var_.characterEffect1084ui_story = arg_72_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_0 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) then
				if arg_72_1.var_.characterEffect1084ui_story and not isNil(arg_72_1.actors_["1084ui_story"]) then
					arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 and not isNil(arg_72_1.actors_["1084ui_story"]) and arg_72_1.var_.characterEffect1084ui_story then
				arg_72_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_75_2 = arg_72_1.actors_["1011ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1011ui_story == nil then
				arg_72_1.var_.characterEffect1011ui_story = var_75_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_3 = 0.1

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 and not isNil(var_75_2) then
				if arg_72_1.var_.characterEffect1011ui_story and not isNil(var_75_2) then
					arg_72_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_72_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_72_1.time_ - 0) / var_75_3)
				end
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 and not isNil(var_75_2) and arg_72_1.var_.characterEffect1011ui_story then
				arg_72_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_72_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_75_4 = arg_72_1.actors_["1084ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = var_75_4.localPosition
			end

			local var_75_5 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_5 then
				var_75_4.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_72_1.time_ - 0) / var_75_5)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_5 and arg_72_1.time_ < 0 + var_75_5 + arg_75_0 then
				var_75_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_75_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_4.position).x, (manager.ui.mainCamera.transform.position - var_75_4.position).y, (manager.ui.mainCamera.transform.position - var_75_4.position).z)
				var_75_4.localEulerAngles.z = 0
				var_75_4.localEulerAngles.x = 0
				var_75_4.localEulerAngles = var_75_4.localEulerAngles
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_75_6 = 0
			local var_75_7 = 0.3

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_6 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_8 = arg_72_1:GetWordFromCfg(104071018)
				local var_75_9 = arg_72_1:FormatText(var_75_8.content)

				arg_72_1.text_.text = var_75_9

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_11 = 12 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 12)

				if (12 <= 0 and var_75_7 or var_75_7 * (utf8.len(var_75_9) / 12)) > 0 and var_75_7 < var_75_11 then
					arg_72_1.talkMaxDuration = var_75_11

					if var_75_11 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_11 + var_75_6
					end
				end

				arg_72_1.text_.text = var_75_9
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071018", "story_v_out_104071.awb") ~= 0 then
					local var_75_12 = manager.audio:GetVoiceLength("story_v_out_104071", "104071018", "story_v_out_104071.awb") / 1000

					if var_75_12 + var_75_6 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_6
					end

					if var_75_8.prefab_name ~= "" and arg_72_1.actors_[var_75_8.prefab_name] ~= nil then
						local var_75_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_8.prefab_name].transform, "story_v_out_104071", "104071018", "story_v_out_104071.awb")

						arg_72_1:RecordAudio("104071018", var_75_13)
						arg_72_1:RecordAudio("104071018", var_75_13)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_104071", "104071018", "story_v_out_104071.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_104071", "104071018", "story_v_out_104071.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_14 = math.max(var_75_7, arg_72_1.talkMaxDuration)

			if var_75_6 <= arg_72_1.time_ and arg_72_1.time_ < var_75_6 + var_75_14 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_6) / var_75_14

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_6 + var_75_14 and arg_72_1.time_ < var_75_6 + var_75_14 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
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

		arg_72_1:InitPlayNodeList()
	end,
	Play104071019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 104071019
		arg_76_1.duration_ = 5.07

		local var_76_0 = {
			ja = 5.033,
			ko = 3.666,
			zh = 5,
			en = 5.066
		}
		local var_76_1 = manager.audio:GetLocalizationFlag()

		if var_76_0[var_76_1] ~= nil then
			arg_76_1.duration_ = var_76_0[var_76_1]
		end

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play104071020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(arg_76_1.actors_["1019ui_story"]) and arg_76_1.var_.characterEffect1019ui_story == nil then
				arg_76_1.var_.characterEffect1019ui_story = arg_76_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_0 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_0 and not isNil(arg_76_1.actors_["1019ui_story"]) then
				if arg_76_1.var_.characterEffect1019ui_story and not isNil(arg_76_1.actors_["1019ui_story"]) then
					arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_0 and arg_76_1.time_ < 0 + var_79_0 + arg_79_0 and not isNil(arg_76_1.actors_["1019ui_story"]) and arg_76_1.var_.characterEffect1019ui_story then
				arg_76_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_79_2 = arg_76_1.actors_["1084ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1084ui_story == nil then
				arg_76_1.var_.characterEffect1084ui_story = var_79_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_3 = 0.1

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_3 and not isNil(var_79_2) then
				if arg_76_1.var_.characterEffect1084ui_story and not isNil(var_79_2) then
					arg_76_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_3)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_3 and arg_76_1.time_ < 0 + var_79_3 + arg_79_0 and not isNil(var_79_2) and arg_76_1.var_.characterEffect1084ui_story then
				arg_76_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_79_4 = arg_76_1.actors_["1084ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1084ui_story = var_79_4.localPosition
			end

			local var_79_5 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_5 then
				var_79_4.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_5)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_5 and arg_76_1.time_ < 0 + var_79_5 + arg_79_0 then
				var_79_4.localPosition = Vector3.New(0, 100, 0)
				var_79_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_4.position).x, (manager.ui.mainCamera.transform.position - var_79_4.position).y, (manager.ui.mainCamera.transform.position - var_79_4.position).z)
				var_79_4.localEulerAngles.z = 0
				var_79_4.localEulerAngles.x = 0
				var_79_4.localEulerAngles = var_79_4.localEulerAngles
			end

			local var_79_6 = arg_76_1.actors_["1011ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1011ui_story = var_79_6.localPosition
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_6.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_7)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_6.localPosition = Vector3.New(0, 100, 0)
				var_79_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_6.position).x, (manager.ui.mainCamera.transform.position - var_79_6.position).y, (manager.ui.mainCamera.transform.position - var_79_6.position).z)
				var_79_6.localEulerAngles.z = 0
				var_79_6.localEulerAngles.x = 0
				var_79_6.localEulerAngles = var_79_6.localEulerAngles
			end

			local var_79_8 = arg_76_1.actors_["1019ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1019ui_story = var_79_8.localPosition
			end

			local var_79_9 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_9 then
				var_79_8.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_76_1.time_ - 0) / var_79_9)
				var_79_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_8.position).x, (manager.ui.mainCamera.transform.position - var_79_8.position).y, (manager.ui.mainCamera.transform.position - var_79_8.position).z)
				var_79_8.localEulerAngles.z = 0
				var_79_8.localEulerAngles.x = 0
				var_79_8.localEulerAngles = var_79_8.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_9 and arg_76_1.time_ < 0 + var_79_9 + arg_79_0 then
				var_79_8.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_79_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_8.position).x, (manager.ui.mainCamera.transform.position - var_79_8.position).y, (manager.ui.mainCamera.transform.position - var_79_8.position).z)
				var_79_8.localEulerAngles.z = 0
				var_79_8.localEulerAngles.x = 0
				var_79_8.localEulerAngles = var_79_8.localEulerAngles
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_79_10 = 0
			local var_79_11 = 0.65

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_10 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_12 = arg_76_1:GetWordFromCfg(104071019)
				local var_79_13 = arg_76_1:FormatText(var_79_12.content)

				arg_76_1.text_.text = var_79_13

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_15 = 26 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_13) / 26)

				if (26 <= 0 and var_79_11 or var_79_11 * (utf8.len(var_79_13) / 26)) > 0 and var_79_11 < var_79_15 then
					arg_76_1.talkMaxDuration = var_79_15

					if var_79_15 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_15 + var_79_10
					end
				end

				arg_76_1.text_.text = var_79_13
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071019", "story_v_out_104071.awb") ~= 0 then
					local var_79_16 = manager.audio:GetVoiceLength("story_v_out_104071", "104071019", "story_v_out_104071.awb") / 1000

					if var_79_16 + var_79_10 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_16 + var_79_10
					end

					if var_79_12.prefab_name ~= "" and arg_76_1.actors_[var_79_12.prefab_name] ~= nil then
						local var_79_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_12.prefab_name].transform, "story_v_out_104071", "104071019", "story_v_out_104071.awb")

						arg_76_1:RecordAudio("104071019", var_79_17)
						arg_76_1:RecordAudio("104071019", var_79_17)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_104071", "104071019", "story_v_out_104071.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_104071", "104071019", "story_v_out_104071.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_18 = math.max(var_79_11, arg_76_1.talkMaxDuration)

			if var_79_10 <= arg_76_1.time_ and arg_76_1.time_ < var_79_10 + var_79_18 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_10) / var_79_18

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_10 + var_79_18 and arg_76_1.time_ < var_79_10 + var_79_18 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
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

		arg_76_1:InitPlayNodeList()
	end,
	Play104071020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 104071020
		arg_80_1.duration_ = 1.77

		local var_80_0 = {
			ja = 1.633,
			ko = 1.766,
			zh = 1.266,
			en = 1.3
		}
		local var_80_1 = manager.audio:GetLocalizationFlag()

		if var_80_0[var_80_1] ~= nil then
			arg_80_1.duration_ = var_80_0[var_80_1]
		end

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play104071021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1019ui_story"]) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = arg_80_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1019ui_story"]) then
				if arg_80_1.var_.characterEffect1019ui_story and not isNil(arg_80_1.actors_["1019ui_story"]) then
					arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_0)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1019ui_story"]) and arg_80_1.var_.characterEffect1019ui_story then
				arg_80_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_83_1 = 0
			local var_83_2 = 0.075

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_1 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[44].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_soundonly")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_3 = arg_80_1:GetWordFromCfg(104071020)
				local var_83_4 = arg_80_1:FormatText(var_83_3.content)

				arg_80_1.text_.text = var_83_4

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_6 = 3 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 3)

				if (3 <= 0 and var_83_2 or var_83_2 * (utf8.len(var_83_4) / 3)) > 0 and var_83_2 < var_83_6 then
					arg_80_1.talkMaxDuration = var_83_6

					if var_83_6 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_6 + var_83_1
					end
				end

				arg_80_1.text_.text = var_83_4
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071020", "story_v_out_104071.awb") ~= 0 then
					local var_83_7 = manager.audio:GetVoiceLength("story_v_out_104071", "104071020", "story_v_out_104071.awb") / 1000

					if var_83_7 + var_83_1 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_7 + var_83_1
					end

					if var_83_3.prefab_name ~= "" and arg_80_1.actors_[var_83_3.prefab_name] ~= nil then
						local var_83_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_3.prefab_name].transform, "story_v_out_104071", "104071020", "story_v_out_104071.awb")

						arg_80_1:RecordAudio("104071020", var_83_8)
						arg_80_1:RecordAudio("104071020", var_83_8)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_104071", "104071020", "story_v_out_104071.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_104071", "104071020", "story_v_out_104071.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_2, arg_80_1.talkMaxDuration)

			if var_83_1 <= arg_80_1.time_ and arg_80_1.time_ < var_83_1 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_1) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_1 + var_83_9 and arg_80_1.time_ < var_83_1 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play104071021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 104071021
		arg_84_1.duration_ = 4.2

		local var_84_0 = {
			ja = 4.2,
			ko = 3.333,
			zh = 3.333,
			en = 3.266
		}
		local var_84_1 = manager.audio:GetLocalizationFlag()

		if var_84_0[var_84_1] ~= nil then
			arg_84_1.duration_ = var_84_0[var_84_1]
		end

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play104071022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1011ui_story"]) and arg_84_1.var_.characterEffect1011ui_story == nil then
				arg_84_1.var_.characterEffect1011ui_story = arg_84_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1011ui_story"]) then
				if arg_84_1.var_.characterEffect1011ui_story and not isNil(arg_84_1.actors_["1011ui_story"]) then
					arg_84_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1011ui_story"]) and arg_84_1.var_.characterEffect1011ui_story then
				arg_84_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_87_2 = arg_84_1.actors_["1019ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1019ui_story = var_87_2.localPosition
			end

			local var_87_3 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_3 then
				var_87_2.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_3)
				var_87_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_2.position).x, (manager.ui.mainCamera.transform.position - var_87_2.position).y, (manager.ui.mainCamera.transform.position - var_87_2.position).z)
				var_87_2.localEulerAngles.z = 0
				var_87_2.localEulerAngles.x = 0
				var_87_2.localEulerAngles = var_87_2.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_3 and arg_84_1.time_ < 0 + var_87_3 + arg_87_0 then
				var_87_2.localPosition = Vector3.New(0, 100, 0)
				var_87_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_2.position).x, (manager.ui.mainCamera.transform.position - var_87_2.position).y, (manager.ui.mainCamera.transform.position - var_87_2.position).z)
				var_87_2.localEulerAngles.z = 0
				var_87_2.localEulerAngles.x = 0
				var_87_2.localEulerAngles = var_87_2.localEulerAngles
			end

			local var_87_4 = arg_84_1.actors_["1011ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1011ui_story = var_87_4.localPosition
			end

			local var_87_5 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_5 then
				var_87_4.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_84_1.time_ - 0) / var_87_5)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_5 and arg_84_1.time_ < 0 + var_87_5 + arg_87_0 then
				var_87_4.localPosition = Vector3.New(0, -0.71, -6)
				var_87_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_4.position).x, (manager.ui.mainCamera.transform.position - var_87_4.position).y, (manager.ui.mainCamera.transform.position - var_87_4.position).z)
				var_87_4.localEulerAngles.z = 0
				var_87_4.localEulerAngles.x = 0
				var_87_4.localEulerAngles = var_87_4.localEulerAngles
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action3_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_87_6 = 0
			local var_87_7 = 0.375

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_6 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_8 = arg_84_1:GetWordFromCfg(104071021)
				local var_87_9 = arg_84_1:FormatText(var_87_8.content)

				arg_84_1.text_.text = var_87_9

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_11 = 15 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 15)

				if (15 <= 0 and var_87_7 or var_87_7 * (utf8.len(var_87_9) / 15)) > 0 and var_87_7 < var_87_11 then
					arg_84_1.talkMaxDuration = var_87_11

					if var_87_11 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_11 + var_87_6
					end
				end

				arg_84_1.text_.text = var_87_9
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071021", "story_v_out_104071.awb") ~= 0 then
					local var_87_12 = manager.audio:GetVoiceLength("story_v_out_104071", "104071021", "story_v_out_104071.awb") / 1000

					if var_87_12 + var_87_6 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_12 + var_87_6
					end

					if var_87_8.prefab_name ~= "" and arg_84_1.actors_[var_87_8.prefab_name] ~= nil then
						local var_87_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_8.prefab_name].transform, "story_v_out_104071", "104071021", "story_v_out_104071.awb")

						arg_84_1:RecordAudio("104071021", var_87_13)
						arg_84_1:RecordAudio("104071021", var_87_13)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_104071", "104071021", "story_v_out_104071.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_104071", "104071021", "story_v_out_104071.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_14 = math.max(var_87_7, arg_84_1.talkMaxDuration)

			if var_87_6 <= arg_84_1.time_ and arg_84_1.time_ < var_87_6 + var_87_14 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_6) / var_87_14

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_6 + var_87_14 and arg_84_1.time_ < var_87_6 + var_87_14 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
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

		arg_84_1:InitPlayNodeList()
	end,
	Play104071022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 104071022
		arg_88_1.duration_ = 4.33

		local var_88_0 = {
			ja = 4.333,
			ko = 4.066,
			zh = 3.533,
			en = 4.133
		}
		local var_88_1 = manager.audio:GetLocalizationFlag()

		if var_88_0[var_88_1] ~= nil then
			arg_88_1.duration_ = var_88_0[var_88_1]
		end

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play104071023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(arg_88_1.actors_["1019ui_story"]) and arg_88_1.var_.characterEffect1019ui_story == nil then
				arg_88_1.var_.characterEffect1019ui_story = arg_88_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_0 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 and not isNil(arg_88_1.actors_["1019ui_story"]) then
				if arg_88_1.var_.characterEffect1019ui_story and not isNil(arg_88_1.actors_["1019ui_story"]) then
					arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 and not isNil(arg_88_1.actors_["1019ui_story"]) and arg_88_1.var_.characterEffect1019ui_story then
				arg_88_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_91_2 = arg_88_1.actors_["1011ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1011ui_story == nil then
				arg_88_1.var_.characterEffect1011ui_story = var_91_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_3 = 0.1

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 and not isNil(var_91_2) then
				if arg_88_1.var_.characterEffect1011ui_story and not isNil(var_91_2) then
					arg_88_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_88_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_3)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 and not isNil(var_91_2) and arg_88_1.var_.characterEffect1011ui_story then
				arg_88_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_88_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_91_4 = arg_88_1.actors_["1011ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1011ui_story = var_91_4.localPosition
			end

			local var_91_5 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_5 then
				var_91_4.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_5)
				var_91_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_4.position).x, (manager.ui.mainCamera.transform.position - var_91_4.position).y, (manager.ui.mainCamera.transform.position - var_91_4.position).z)
				var_91_4.localEulerAngles.z = 0
				var_91_4.localEulerAngles.x = 0
				var_91_4.localEulerAngles = var_91_4.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_5 and arg_88_1.time_ < 0 + var_91_5 + arg_91_0 then
				var_91_4.localPosition = Vector3.New(0, 100, 0)
				var_91_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_4.position).x, (manager.ui.mainCamera.transform.position - var_91_4.position).y, (manager.ui.mainCamera.transform.position - var_91_4.position).z)
				var_91_4.localEulerAngles.z = 0
				var_91_4.localEulerAngles.x = 0
				var_91_4.localEulerAngles = var_91_4.localEulerAngles
			end

			local var_91_6 = arg_88_1.actors_["1019ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_6.localPosition
			end

			local var_91_7 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_7 then
				var_91_6.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_88_1.time_ - 0) / var_91_7)
				var_91_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_6.position).x, (manager.ui.mainCamera.transform.position - var_91_6.position).y, (manager.ui.mainCamera.transform.position - var_91_6.position).z)
				var_91_6.localEulerAngles.z = 0
				var_91_6.localEulerAngles.x = 0
				var_91_6.localEulerAngles = var_91_6.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_7 and arg_88_1.time_ < 0 + var_91_7 + arg_91_0 then
				var_91_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_91_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_6.position).x, (manager.ui.mainCamera.transform.position - var_91_6.position).y, (manager.ui.mainCamera.transform.position - var_91_6.position).z)
				var_91_6.localEulerAngles.z = 0
				var_91_6.localEulerAngles.x = 0
				var_91_6.localEulerAngles = var_91_6.localEulerAngles
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_91_8 = 0
			local var_91_9 = 0.45

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_8 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_10 = arg_88_1:GetWordFromCfg(104071022)
				local var_91_11 = arg_88_1:FormatText(var_91_10.content)

				arg_88_1.text_.text = var_91_11

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_13 = 18 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 18)

				if (18 <= 0 and var_91_9 or var_91_9 * (utf8.len(var_91_11) / 18)) > 0 and var_91_9 < var_91_13 then
					arg_88_1.talkMaxDuration = var_91_13

					if var_91_13 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_13 + var_91_8
					end
				end

				arg_88_1.text_.text = var_91_11
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071022", "story_v_out_104071.awb") ~= 0 then
					local var_91_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071022", "story_v_out_104071.awb") / 1000

					if var_91_14 + var_91_8 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_8
					end

					if var_91_10.prefab_name ~= "" and arg_88_1.actors_[var_91_10.prefab_name] ~= nil then
						local var_91_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_10.prefab_name].transform, "story_v_out_104071", "104071022", "story_v_out_104071.awb")

						arg_88_1:RecordAudio("104071022", var_91_15)
						arg_88_1:RecordAudio("104071022", var_91_15)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_104071", "104071022", "story_v_out_104071.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_104071", "104071022", "story_v_out_104071.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_16 = math.max(var_91_9, arg_88_1.talkMaxDuration)

			if var_91_8 <= arg_88_1.time_ and arg_88_1.time_ < var_91_8 + var_91_16 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_8) / var_91_16

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_8 + var_91_16 and arg_88_1.time_ < var_91_8 + var_91_16 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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

		arg_88_1:InitPlayNodeList()
	end,
	Play104071023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 104071023
		arg_92_1.duration_ = 8.97

		local var_92_0 = {
			ja = 8.133,
			ko = 6.666,
			zh = 7.066,
			en = 8.966
		}
		local var_92_1 = manager.audio:GetLocalizationFlag()

		if var_92_0[var_92_1] ~= nil then
			arg_92_1.duration_ = var_92_0[var_92_1]
		end

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play104071024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action425")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_95_0 = 0
			local var_95_1 = 1

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_0 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_2 = arg_92_1:GetWordFromCfg(104071023)
				local var_95_3 = arg_92_1:FormatText(var_95_2.content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 40 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 40)

				if (40 <= 0 and var_95_1 or var_95_1 * (utf8.len(var_95_3) / 40)) > 0 and var_95_1 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_0
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071023", "story_v_out_104071.awb") ~= 0 then
					local var_95_6 = manager.audio:GetVoiceLength("story_v_out_104071", "104071023", "story_v_out_104071.awb") / 1000

					if var_95_6 + var_95_0 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_6 + var_95_0
					end

					if var_95_2.prefab_name ~= "" and arg_92_1.actors_[var_95_2.prefab_name] ~= nil then
						local var_95_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_2.prefab_name].transform, "story_v_out_104071", "104071023", "story_v_out_104071.awb")

						arg_92_1:RecordAudio("104071023", var_95_7)
						arg_92_1:RecordAudio("104071023", var_95_7)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_104071", "104071023", "story_v_out_104071.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_104071", "104071023", "story_v_out_104071.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_8 = math.max(var_95_1, arg_92_1.talkMaxDuration)

			if var_95_0 <= arg_92_1.time_ and arg_92_1.time_ < var_95_0 + var_95_8 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_0) / var_95_8

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_0 + var_95_8 and arg_92_1.time_ < var_95_0 + var_95_8 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	Play104071024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 104071024
		arg_96_1.duration_ = 6.5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play104071025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				local var_99_0 = arg_96_1.bgs_.B06a:GetComponent("SpriteRenderer")

				if var_99_0 then
					arg_96_1.var_.alphaOldValueB06a = var_99_0.color.a
					arg_96_1.var_.alphaMatValueB06a = var_99_0
				end

				arg_96_1.var_.alphaOldValueB06a = 1
			end

			local var_99_1 = 1.5

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				if arg_96_1.var_.alphaMatValueB06a then
					arg_96_1.var_.alphaMatValueB06a.color.a = Mathf.Lerp(arg_96_1.var_.alphaOldValueB06a, 0, (arg_96_1.time_ - 0) / var_99_1)
					arg_96_1.var_.alphaMatValueB06a.color = arg_96_1.var_.alphaMatValueB06a.color
				end
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 and arg_96_1.var_.alphaMatValueB06a then
				arg_96_1.var_.alphaMatValueB06a.color.a = 0
				arg_96_1.var_.alphaMatValueB06a.color = arg_96_1.var_.alphaMatValueB06a.color
			end

			local var_99_2 = arg_96_1.bgs_.B06a.transform

			if 1.5 < arg_96_1.time_ and arg_96_1.time_ <= 1.5 + arg_99_0 then
				arg_96_1.var_.moveOldPosB06a = var_99_2.localPosition
			end

			local var_99_3 = 0.001

			if 1.5 <= arg_96_1.time_ and arg_96_1.time_ < 1.5 + var_99_3 then
				var_99_2.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPosB06a, Vector3.New(0, -100, 10), (arg_96_1.time_ - 1.5) / var_99_3)
			end

			if arg_96_1.time_ >= 1.5 + var_99_3 and arg_96_1.time_ < 1.5 + var_99_3 + arg_99_0 then
				var_99_2.localPosition = Vector3.New(0, -100, 10)
			end

			local var_99_4 = "A00"

			if arg_96_1.bgs_.A00 == nil then
				local var_99_5 = Object.Instantiate(arg_96_1.paintGo_)

				var_99_5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_99_4)
				var_99_5.name = var_99_4
				var_99_5.transform.parent = arg_96_1.stage_.transform
				var_99_5.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.bgs_[var_99_4] = var_99_5
			end

			if 1.5 < arg_96_1.time_ and arg_96_1.time_ <= 1.5 + arg_99_0 then
				local var_99_6 = arg_96_1.bgs_.A00:GetComponent("SpriteRenderer")

				if var_99_6 then
					arg_96_1.var_.alphaOldValueA00 = var_99_6.color.a
					arg_96_1.var_.alphaMatValueA00 = var_99_6
				end

				arg_96_1.var_.alphaOldValueA00 = 0
			end

			local var_99_7 = 1.5

			if 1.5 <= arg_96_1.time_ and arg_96_1.time_ < 1.5 + var_99_7 then
				if arg_96_1.var_.alphaMatValueA00 then
					arg_96_1.var_.alphaMatValueA00.color.a = Mathf.Lerp(arg_96_1.var_.alphaOldValueA00, 1, (arg_96_1.time_ - 1.5) / var_99_7)
					arg_96_1.var_.alphaMatValueA00.color = arg_96_1.var_.alphaMatValueA00.color
				end
			end

			if arg_96_1.time_ >= 1.5 + var_99_7 and arg_96_1.time_ < 1.5 + var_99_7 + arg_99_0 and arg_96_1.var_.alphaMatValueA00 then
				arg_96_1.var_.alphaMatValueA00.color.a = 1
				arg_96_1.var_.alphaMatValueA00.color = arg_96_1.var_.alphaMatValueA00.color
			end

			if 1.5 < arg_96_1.time_ and arg_96_1.time_ <= 1.5 + arg_99_0 then
				local var_99_8 = arg_96_1.bgs_.A00

				arg_96_1.bgs_.A00.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_99_8.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_99_9 = var_99_8:GetComponent("SpriteRenderer")

				if var_99_9 and var_99_9.sprite then
					local var_99_10 = 2 * (var_99_8.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_99_8.transform.localScale = Vector3.New(var_99_10 / var_99_9.sprite.bounds.size.y < var_99_10 * manager.ui.mainCameraCom_.aspect / var_99_9.sprite.bounds.size.x and var_99_10 * manager.ui.mainCameraCom_.aspect / var_99_9.sprite.bounds.size.x or var_99_10 / var_99_9.sprite.bounds.size.y, var_99_10 / var_99_9.sprite.bounds.size.y < var_99_10 * manager.ui.mainCameraCom_.aspect / var_99_9.sprite.bounds.size.x and var_99_10 * manager.ui.mainCameraCom_.aspect / var_99_9.sprite.bounds.size.x or var_99_10 / var_99_9.sprite.bounds.size.y, 0)
				end

				for iter_99_0, iter_99_1 in pairs(arg_96_1.bgs_) do
					if iter_99_0 ~= "A00" then
						iter_99_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_99_11 = arg_96_1.actors_["1019ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos1019ui_story = var_99_11.localPosition
			end

			local var_99_12 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_12 then
				var_99_11.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_96_1.time_ - 0) / var_99_12)
				var_99_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_11.position).x, (manager.ui.mainCamera.transform.position - var_99_11.position).y, (manager.ui.mainCamera.transform.position - var_99_11.position).z)
				var_99_11.localEulerAngles.z = 0
				var_99_11.localEulerAngles.x = 0
				var_99_11.localEulerAngles = var_99_11.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_12 and arg_96_1.time_ < 0 + var_99_12 + arg_99_0 then
				var_99_11.localPosition = Vector3.New(0, 100, 0)
				var_99_11.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_11.position).x, (manager.ui.mainCamera.transform.position - var_99_11.position).y, (manager.ui.mainCamera.transform.position - var_99_11.position).z)
				var_99_11.localEulerAngles.z = 0
				var_99_11.localEulerAngles.x = 0
				var_99_11.localEulerAngles = var_99_11.localEulerAngles
			end

			local var_99_13 = 0

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_13 + arg_99_0 then
				arg_96_1.allBtn_.enabled = false
			end

			if arg_96_1.time_ >= var_99_13 + 1.5 and arg_96_1.time_ < var_99_13 + 1.5 + arg_99_0 then
				arg_96_1.allBtn_.enabled = true
			end

			local var_99_14 = 1.5
			local var_99_15 = 0.275

			if 1.5 < arg_96_1.time_ and arg_96_1.time_ <= var_99_14 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, false)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_16 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(104071024).content)

				arg_96_1.text_.text = var_99_16

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_18 = 11 <= 0 and var_99_15 or var_99_15 * (utf8.len(var_99_16) / 11)

				if (11 <= 0 and var_99_15 or var_99_15 * (utf8.len(var_99_16) / 11)) > 0 and var_99_15 < var_99_18 then
					arg_96_1.talkMaxDuration = var_99_18

					if var_99_18 + var_99_14 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_18 + var_99_14
					end
				end

				arg_96_1.text_.text = var_99_16
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_19 = math.max(var_99_15, arg_96_1.talkMaxDuration)

			if var_99_14 <= arg_96_1.time_ and arg_96_1.time_ < var_99_14 + var_99_19 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_14) / var_99_19

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_14 + var_99_19 and arg_96_1.time_ < var_99_14 + var_99_19 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "B06a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 1.5,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
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

		arg_96_1:InitPlayNodeList()
	end,
	Play104071025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 104071025
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play104071026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			local var_103_0 = 0.45

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_1 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(104071025).content)

				arg_100_1.text_.text = var_103_1

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_3 = 18 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 18)

				if (18 <= 0 and var_103_0 or var_103_0 * (utf8.len(var_103_1) / 18)) > 0 and var_103_0 < var_103_3 then
					arg_100_1.talkMaxDuration = var_103_3

					if var_103_3 + 0 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_3 + 0
					end
				end

				arg_100_1.text_.text = var_103_1
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_4 = math.max(var_103_0, arg_100_1.talkMaxDuration)

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_4 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - 0) / var_103_4

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= 0 + var_103_4 and arg_100_1.time_ < 0 + var_103_4 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play104071026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 104071026
		arg_104_1.duration_ = 9.37

		local var_104_0 = {
			ja = 9.366,
			ko = 6.966,
			zh = 5.7,
			en = 9.333
		}
		local var_104_1 = manager.audio:GetLocalizationFlag()

		if var_104_0[var_104_1] ~= nil then
			arg_104_1.duration_ = var_104_0[var_104_1]
		end

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play104071027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.725

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:GetWordFromCfg(104071026)
				local var_107_2 = arg_104_1:FormatText(var_107_1.content)

				arg_104_1.text_.text = var_107_2

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_4 = 29 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 29)

				if (29 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_2) / 29)) > 0 and var_107_0 < var_107_4 then
					arg_104_1.talkMaxDuration = var_107_4

					if var_107_4 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_4 + 0
					end
				end

				arg_104_1.text_.text = var_107_2
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071026", "story_v_out_104071.awb") ~= 0 then
					local var_107_5 = manager.audio:GetVoiceLength("story_v_out_104071", "104071026", "story_v_out_104071.awb") / 1000

					if var_107_5 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_5 + 0
					end

					if var_107_1.prefab_name ~= "" and arg_104_1.actors_[var_107_1.prefab_name] ~= nil then
						local var_107_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_1.prefab_name].transform, "story_v_out_104071", "104071026", "story_v_out_104071.awb")

						arg_104_1:RecordAudio("104071026", var_107_6)
						arg_104_1:RecordAudio("104071026", var_107_6)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_104071", "104071026", "story_v_out_104071.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_104071", "104071026", "story_v_out_104071.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_7 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_7 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_7

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_7 and arg_104_1.time_ < 0 + var_107_7 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play104071027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 104071027
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play104071028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			local var_111_0 = 0.125

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, true)
				arg_108_1.iconController_:SetSelectedState("hero")

				arg_108_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_108_1.callingController_:SetSelectedState("normal")

				arg_108_1.keyicon_.color = Color.New(1, 1, 1)
				arg_108_1.icon_.color = Color.New(1, 1, 1)

				local var_111_1 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(104071027).content)

				arg_108_1.text_.text = var_111_1

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_3 = 5 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 5)

				if (5 <= 0 and var_111_0 or var_111_0 * (utf8.len(var_111_1) / 5)) > 0 and var_111_0 < var_111_3 then
					arg_108_1.talkMaxDuration = var_111_3

					if var_111_3 + 0 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_3 + 0
					end
				end

				arg_108_1.text_.text = var_111_1
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_4 = math.max(var_111_0, arg_108_1.talkMaxDuration)

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - 0) / var_111_4

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play104071028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 104071028
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play104071029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.shakeOldPosMainCamera = manager.ui.mainCamera.transform.localPosition
			end

			local var_115_0 = 0.600000023841858

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 then
				local var_115_1, var_115_2 = math.modf((arg_112_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_115_2 * 0.13, var_115_2 * 0.13, var_115_2 * 0.13) + arg_112_1.var_.shakeOldPosMainCamera
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 then
				manager.ui.mainCamera.transform.localPosition = arg_112_1.var_.shakeOldPosMainCamera
			end

			local var_115_3 = 0
			local var_115_4 = 1.225

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_3 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, false)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_5 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(104071028).content)

				arg_112_1.text_.text = var_115_5

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_7 = 49 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 49)

				if (49 <= 0 and var_115_4 or var_115_4 * (utf8.len(var_115_5) / 49)) > 0 and var_115_4 < var_115_7 then
					arg_112_1.talkMaxDuration = var_115_7

					if var_115_7 + var_115_3 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_7 + var_115_3
					end
				end

				arg_112_1.text_.text = var_115_5
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_8 = math.max(var_115_4, arg_112_1.talkMaxDuration)

			if var_115_3 <= arg_112_1.time_ and arg_112_1.time_ < var_115_3 + var_115_8 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_3) / var_115_8

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_3 + var_115_8 and arg_112_1.time_ < var_115_3 + var_115_8 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play104071029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 104071029
		arg_116_1.duration_ = 5

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play104071030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_0 = 1

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, false)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_1 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(104071029).content)

				arg_116_1.text_.text = var_119_1

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_3 = 40 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 40)

				if (40 <= 0 and var_119_0 or var_119_0 * (utf8.len(var_119_1) / 40)) > 0 and var_119_0 < var_119_3 then
					arg_116_1.talkMaxDuration = var_119_3

					if var_119_3 + 0 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_3 + 0
					end
				end

				arg_116_1.text_.text = var_119_1
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_4 = math.max(var_119_0, arg_116_1.talkMaxDuration)

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - 0) / var_119_4

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {}

		arg_116_1:InitPlayNodeList()
	end,
	Play104071030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 104071030
		arg_120_1.duration_ = 8.6

		local var_120_0 = {
			ja = 8.3,
			ko = 8.6,
			zh = 8.066,
			en = 8.6
		}
		local var_120_1 = manager.audio:GetLocalizationFlag()

		if var_120_0[var_120_1] ~= nil then
			arg_120_1.duration_ = var_120_0[var_120_1]
		end

		SetActive(arg_120_1.tipsGo_, false)

		function arg_120_1.onSingleLineFinish_()
			arg_120_1.onSingleLineUpdate_ = nil
			arg_120_1.onSingleLineFinish_ = nil
			arg_120_1.state_ = "waiting"
		end

		function arg_120_1.playNext_(arg_122_0)
			if arg_122_0 == 1 then
				arg_120_0:Play104071031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			local var_123_0 = 0.9

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, true)
				arg_120_1.iconController_:SetSelectedState("hero")

				arg_120_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_120_1.callingController_:SetSelectedState("normal")

				arg_120_1.keyicon_.color = Color.New(1, 1, 1)
				arg_120_1.icon_.color = Color.New(1, 1, 1)

				local var_123_1 = arg_120_1:GetWordFromCfg(104071030)
				local var_123_2 = arg_120_1:FormatText(var_123_1.content)

				arg_120_1.text_.text = var_123_2

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_4 = 36 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 36)

				if (36 <= 0 and var_123_0 or var_123_0 * (utf8.len(var_123_2) / 36)) > 0 and var_123_0 < var_123_4 then
					arg_120_1.talkMaxDuration = var_123_4

					if var_123_4 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_4 + 0
					end
				end

				arg_120_1.text_.text = var_123_2
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071030", "story_v_out_104071.awb") ~= 0 then
					local var_123_5 = manager.audio:GetVoiceLength("story_v_out_104071", "104071030", "story_v_out_104071.awb") / 1000

					if var_123_5 + 0 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_5 + 0
					end

					if var_123_1.prefab_name ~= "" and arg_120_1.actors_[var_123_1.prefab_name] ~= nil then
						local var_123_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_1.prefab_name].transform, "story_v_out_104071", "104071030", "story_v_out_104071.awb")

						arg_120_1:RecordAudio("104071030", var_123_6)
						arg_120_1:RecordAudio("104071030", var_123_6)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_104071", "104071030", "story_v_out_104071.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_104071", "104071030", "story_v_out_104071.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_7 = math.max(var_123_0, arg_120_1.talkMaxDuration)

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - 0) / var_123_7

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {}

		arg_120_1:InitPlayNodeList()
	end,
	Play104071031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 104071031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play104071032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			local var_127_0 = 0.475

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, true)
				arg_124_1.iconController_:SetSelectedState("hero")

				arg_124_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_124_1.callingController_:SetSelectedState("normal")

				arg_124_1.keyicon_.color = Color.New(1, 1, 1)
				arg_124_1.icon_.color = Color.New(1, 1, 1)

				local var_127_1 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(104071031).content)

				arg_124_1.text_.text = var_127_1

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_3 = 19 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 19)

				if (19 <= 0 and var_127_0 or var_127_0 * (utf8.len(var_127_1) / 19)) > 0 and var_127_0 < var_127_3 then
					arg_124_1.talkMaxDuration = var_127_3

					if var_127_3 + 0 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_3 + 0
					end
				end

				arg_124_1.text_.text = var_127_1
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_4 = math.max(var_127_0, arg_124_1.talkMaxDuration)

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_4 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - 0) / var_127_4

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= 0 + var_127_4 and arg_124_1.time_ < 0 + var_127_4 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {}

		arg_124_1:InitPlayNodeList()
	end,
	Play104071032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 104071032
		arg_128_1.duration_ = 14.03

		local var_128_0 = {
			ja = 14.033,
			ko = 11.266,
			zh = 9,
			en = 11.166
		}
		local var_128_1 = manager.audio:GetLocalizationFlag()

		if var_128_0[var_128_1] ~= nil then
			arg_128_1.duration_ = var_128_0[var_128_1]
		end

		SetActive(arg_128_1.tipsGo_, false)

		function arg_128_1.onSingleLineFinish_()
			arg_128_1.onSingleLineUpdate_ = nil
			arg_128_1.onSingleLineFinish_ = nil
			arg_128_1.state_ = "waiting"
		end

		function arg_128_1.playNext_(arg_130_0)
			if arg_130_0 == 1 then
				arg_128_0:Play104071033(arg_128_1)
			end
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if arg_128_1.actors_["1037ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1037ui_story"))) then
				local var_131_0 = Object.Instantiate(Asset.Load("Char/" .. "1037ui_story"), arg_128_1.stage_.transform)

				var_131_0.name = "1037ui_story"
				var_131_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_128_1.actors_["1037ui_story"] = var_131_0

				local var_131_1 = var_131_0:GetComponentInChildren(typeof(CharacterEffect))

				var_131_1.enabled = true

				local var_131_2 = GameObjectTools.GetOrAddComponent(var_131_0, typeof(DynamicBoneHelper))

				if var_131_2 then
					var_131_2:EnableDynamicBone(false)
				end

				arg_128_1:ShowWeapon(var_131_1.transform, false)

				arg_128_1.var_["1037ui_story" .. "Animator"] = var_131_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_128_1.var_["1037ui_story" .. "Animator"].applyRootMotion = true
				arg_128_1.var_["1037ui_story" .. "LipSync"] = var_131_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_131_3 = arg_128_1.actors_["1037ui_story"]

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1037ui_story == nil then
				arg_128_1.var_.characterEffect1037ui_story = var_131_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_4 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_4 and not isNil(var_131_3) then
				if arg_128_1.var_.characterEffect1037ui_story and not isNil(var_131_3) then
					arg_128_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_4 and arg_128_1.time_ < 0 + var_131_4 + arg_131_0 and not isNil(var_131_3) and arg_128_1.var_.characterEffect1037ui_story then
				arg_128_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			local var_131_6 = arg_128_1.actors_["1037ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1037ui_story = var_131_6.localPosition
			end

			local var_131_7 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_7 then
				var_131_6.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1037ui_story, Vector3.New(0, -1.09, -5.81), (arg_128_1.time_ - 0) / var_131_7)
				var_131_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_6.position).x, (manager.ui.mainCamera.transform.position - var_131_6.position).y, (manager.ui.mainCamera.transform.position - var_131_6.position).z)
				var_131_6.localEulerAngles.z = 0
				var_131_6.localEulerAngles.x = 0
				var_131_6.localEulerAngles = var_131_6.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_7 and arg_128_1.time_ < 0 + var_131_7 + arg_131_0 then
				var_131_6.localPosition = Vector3.New(0, -1.09, -5.81)
				var_131_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_6.position).x, (manager.ui.mainCamera.transform.position - var_131_6.position).y, (manager.ui.mainCamera.transform.position - var_131_6.position).z)
				var_131_6.localEulerAngles.z = 0
				var_131_6.localEulerAngles.x = 0
				var_131_6.localEulerAngles = var_131_6.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037action/1037action5_1")
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface9903cva")
			end

			local var_131_8 = 0
			local var_131_9 = 1.125

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_8 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_10 = arg_128_1:GetWordFromCfg(104071032)
				local var_131_11 = arg_128_1:FormatText(var_131_10.content)

				arg_128_1.text_.text = var_131_11

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_13 = 45 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 45)

				if (45 <= 0 and var_131_9 or var_131_9 * (utf8.len(var_131_11) / 45)) > 0 and var_131_9 < var_131_13 then
					arg_128_1.talkMaxDuration = var_131_13

					if var_131_13 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_13 + var_131_8
					end
				end

				arg_128_1.text_.text = var_131_11
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071032", "story_v_out_104071.awb") ~= 0 then
					local var_131_14 = manager.audio:GetVoiceLength("story_v_out_104071", "104071032", "story_v_out_104071.awb") / 1000

					if var_131_14 + var_131_8 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_14 + var_131_8
					end

					if var_131_10.prefab_name ~= "" and arg_128_1.actors_[var_131_10.prefab_name] ~= nil then
						local var_131_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_10.prefab_name].transform, "story_v_out_104071", "104071032", "story_v_out_104071.awb")

						arg_128_1:RecordAudio("104071032", var_131_15)
						arg_128_1:RecordAudio("104071032", var_131_15)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_104071", "104071032", "story_v_out_104071.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_104071", "104071032", "story_v_out_104071.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_16 = math.max(var_131_9, arg_128_1.talkMaxDuration)

			if var_131_8 <= arg_128_1.time_ and arg_128_1.time_ < var_131_8 + var_131_16 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_8) / var_131_16

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_8 + var_131_16 and arg_128_1.time_ < var_131_8 + var_131_16 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_128_1:InitPlayNodeList()
	end,
	Play104071033 = function(arg_132_0, arg_132_1)
		arg_132_1.time_ = 0
		arg_132_1.frameCnt_ = 0
		arg_132_1.state_ = "playing"
		arg_132_1.curTalkId_ = 104071033
		arg_132_1.duration_ = 10.3

		local var_132_0 = {
			ja = 10.3,
			ko = 5.533,
			zh = 4.8,
			en = 7.2
		}
		local var_132_1 = manager.audio:GetLocalizationFlag()

		if var_132_0[var_132_1] ~= nil then
			arg_132_1.duration_ = var_132_0[var_132_1]
		end

		SetActive(arg_132_1.tipsGo_, false)

		function arg_132_1.onSingleLineFinish_()
			arg_132_1.onSingleLineUpdate_ = nil
			arg_132_1.onSingleLineFinish_ = nil
			arg_132_1.state_ = "waiting"
		end

		function arg_132_1.playNext_(arg_134_0)
			if arg_134_0 == 1 then
				arg_132_0:Play104071034(arg_132_1)
			end
		end

		function arg_132_1.onSingleLineUpdate_(arg_135_0)
			if 0 < arg_132_1.time_ and arg_132_1.time_ <= 0 + arg_135_0 and not isNil(arg_132_1.actors_["1037ui_story"]) and arg_132_1.var_.characterEffect1037ui_story == nil then
				arg_132_1.var_.characterEffect1037ui_story = arg_132_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_135_0 = 0.1

			if 0 <= arg_132_1.time_ and arg_132_1.time_ < 0 + var_135_0 and not isNil(arg_132_1.actors_["1037ui_story"]) then
				if arg_132_1.var_.characterEffect1037ui_story and not isNil(arg_132_1.actors_["1037ui_story"]) then
					arg_132_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_132_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_132_1.time_ - 0) / var_135_0)
				end
			end

			if arg_132_1.time_ >= 0 + var_135_0 and arg_132_1.time_ < 0 + var_135_0 + arg_135_0 and not isNil(arg_132_1.actors_["1037ui_story"]) and arg_132_1.var_.characterEffect1037ui_story then
				arg_132_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_132_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_135_1 = 0
			local var_135_2 = 0.625

			if 0 < arg_132_1.time_ and arg_132_1.time_ <= var_135_1 + arg_135_0 then
				arg_132_1.talkMaxDuration = 0
				arg_132_1.dialogCg_.alpha = 1

				arg_132_1.dialog_:SetActive(true)
				SetActive(arg_132_1.leftNameGo_, true)

				arg_132_1.leftNameTxt_.text = arg_132_1:FormatText(StoryNameCfg[10].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_132_1.leftNameTxt_.transform)

				arg_132_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_132_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_132_1:RecordName(arg_132_1.leftNameTxt_.text)
				SetActive(arg_132_1.iconTrs_.gameObject, true)
				arg_132_1.iconController_:SetSelectedState("hero")

				arg_132_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_mmr")

				arg_132_1.callingController_:SetSelectedState("normal")

				arg_132_1.keyicon_.color = Color.New(1, 1, 1)
				arg_132_1.icon_.color = Color.New(1, 1, 1)

				local var_135_3 = arg_132_1:GetWordFromCfg(104071033)
				local var_135_4 = arg_132_1:FormatText(var_135_3.content)

				arg_132_1.text_.text = var_135_4

				LuaForUtil.ClearLinePrefixSymbol(arg_132_1.text_)

				local var_135_6 = 25 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 25)

				if (25 <= 0 and var_135_2 or var_135_2 * (utf8.len(var_135_4) / 25)) > 0 and var_135_2 < var_135_6 then
					arg_132_1.talkMaxDuration = var_135_6

					if var_135_6 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_6 + var_135_1
					end
				end

				arg_132_1.text_.text = var_135_4
				arg_132_1.typewritter.percent = 0

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071033", "story_v_out_104071.awb") ~= 0 then
					local var_135_7 = manager.audio:GetVoiceLength("story_v_out_104071", "104071033", "story_v_out_104071.awb") / 1000

					if var_135_7 + var_135_1 > arg_132_1.duration_ then
						arg_132_1.duration_ = var_135_7 + var_135_1
					end

					if var_135_3.prefab_name ~= "" and arg_132_1.actors_[var_135_3.prefab_name] ~= nil then
						local var_135_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_132_1.actors_[var_135_3.prefab_name].transform, "story_v_out_104071", "104071033", "story_v_out_104071.awb")

						arg_132_1:RecordAudio("104071033", var_135_8)
						arg_132_1:RecordAudio("104071033", var_135_8)
					else
						arg_132_1:AudioAction("play", "voice", "story_v_out_104071", "104071033", "story_v_out_104071.awb")
					end

					arg_132_1:RecordHistoryTalkVoice("story_v_out_104071", "104071033", "story_v_out_104071.awb")
				end

				arg_132_1:RecordContent(arg_132_1.text_.text)
			end

			local var_135_9 = math.max(var_135_2, arg_132_1.talkMaxDuration)

			if var_135_1 <= arg_132_1.time_ and arg_132_1.time_ < var_135_1 + var_135_9 then
				arg_132_1.typewritter.percent = (arg_132_1.time_ - var_135_1) / var_135_9

				arg_132_1.typewritter:SetDirty()
			end

			if arg_132_1.time_ >= var_135_1 + var_135_9 and arg_132_1.time_ < var_135_1 + var_135_9 + arg_135_0 then
				arg_132_1.typewritter.percent = 1

				arg_132_1.typewritter:SetDirty()
				arg_132_1:ShowNextGo(true)
			end
		end

		arg_132_1.nodeConfigList_ = {}

		arg_132_1:InitPlayNodeList()
	end,
	Play104071034 = function(arg_136_0, arg_136_1)
		arg_136_1.time_ = 0
		arg_136_1.frameCnt_ = 0
		arg_136_1.state_ = "playing"
		arg_136_1.curTalkId_ = 104071034
		arg_136_1.duration_ = 6.4

		local var_136_0 = {
			ja = 6.4,
			ko = 2.6,
			zh = 2.333,
			en = 3.033
		}
		local var_136_1 = manager.audio:GetLocalizationFlag()

		if var_136_0[var_136_1] ~= nil then
			arg_136_1.duration_ = var_136_0[var_136_1]
		end

		SetActive(arg_136_1.tipsGo_, false)

		function arg_136_1.onSingleLineFinish_()
			arg_136_1.onSingleLineUpdate_ = nil
			arg_136_1.onSingleLineFinish_ = nil
			arg_136_1.state_ = "waiting"
		end

		function arg_136_1.playNext_(arg_138_0)
			if arg_138_0 == 1 then
				arg_136_0:Play104071035(arg_136_1)
			end
		end

		function arg_136_1.onSingleLineUpdate_(arg_139_0)
			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 and not isNil(arg_136_1.actors_["1037ui_story"]) and arg_136_1.var_.characterEffect1037ui_story == nil then
				arg_136_1.var_.characterEffect1037ui_story = arg_136_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_139_0 = 0.1

			if 0 <= arg_136_1.time_ and arg_136_1.time_ < 0 + var_139_0 and not isNil(arg_136_1.actors_["1037ui_story"]) then
				if arg_136_1.var_.characterEffect1037ui_story and not isNil(arg_136_1.actors_["1037ui_story"]) then
					arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
				end
			end

			if arg_136_1.time_ >= 0 + var_139_0 and arg_136_1.time_ < 0 + var_139_0 + arg_139_0 and not isNil(arg_136_1.actors_["1037ui_story"]) and arg_136_1.var_.characterEffect1037ui_story then
				arg_136_1.var_.characterEffect1037ui_story.fillFlat = false
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/story1037/story1037actionlink/1037action456")
			end

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= 0 + arg_139_0 then
				arg_136_1:PlayTimeline("1037ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_139_2 = 0
			local var_139_3 = 0.275

			if 0 < arg_136_1.time_ and arg_136_1.time_ <= var_139_2 + arg_139_0 then
				arg_136_1.talkMaxDuration = 0
				arg_136_1.dialogCg_.alpha = 1

				arg_136_1.dialog_:SetActive(true)
				SetActive(arg_136_1.leftNameGo_, true)

				arg_136_1.leftNameTxt_.text = arg_136_1:FormatText(StoryNameCfg[15].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_136_1.leftNameTxt_.transform)

				arg_136_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_136_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_136_1:RecordName(arg_136_1.leftNameTxt_.text)
				SetActive(arg_136_1.iconTrs_.gameObject, false)
				arg_136_1.callingController_:SetSelectedState("normal")

				local var_139_4 = arg_136_1:GetWordFromCfg(104071034)
				local var_139_5 = arg_136_1:FormatText(var_139_4.content)

				arg_136_1.text_.text = var_139_5

				LuaForUtil.ClearLinePrefixSymbol(arg_136_1.text_)

				local var_139_7 = 11 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 11)

				if (11 <= 0 and var_139_3 or var_139_3 * (utf8.len(var_139_5) / 11)) > 0 and var_139_3 < var_139_7 then
					arg_136_1.talkMaxDuration = var_139_7

					if var_139_7 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_7 + var_139_2
					end
				end

				arg_136_1.text_.text = var_139_5
				arg_136_1.typewritter.percent = 0

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104071", "104071034", "story_v_out_104071.awb") ~= 0 then
					local var_139_8 = manager.audio:GetVoiceLength("story_v_out_104071", "104071034", "story_v_out_104071.awb") / 1000

					if var_139_8 + var_139_2 > arg_136_1.duration_ then
						arg_136_1.duration_ = var_139_8 + var_139_2
					end

					if var_139_4.prefab_name ~= "" and arg_136_1.actors_[var_139_4.prefab_name] ~= nil then
						local var_139_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_136_1.actors_[var_139_4.prefab_name].transform, "story_v_out_104071", "104071034", "story_v_out_104071.awb")

						arg_136_1:RecordAudio("104071034", var_139_9)
						arg_136_1:RecordAudio("104071034", var_139_9)
					else
						arg_136_1:AudioAction("play", "voice", "story_v_out_104071", "104071034", "story_v_out_104071.awb")
					end

					arg_136_1:RecordHistoryTalkVoice("story_v_out_104071", "104071034", "story_v_out_104071.awb")
				end

				arg_136_1:RecordContent(arg_136_1.text_.text)
			end

			local var_139_10 = math.max(var_139_3, arg_136_1.talkMaxDuration)

			if var_139_2 <= arg_136_1.time_ and arg_136_1.time_ < var_139_2 + var_139_10 then
				arg_136_1.typewritter.percent = (arg_136_1.time_ - var_139_2) / var_139_10

				arg_136_1.typewritter:SetDirty()
			end

			if arg_136_1.time_ >= var_139_2 + var_139_10 and arg_136_1.time_ < var_139_2 + var_139_10 + arg_139_0 then
				arg_136_1.typewritter.percent = 1

				arg_136_1.typewritter:SetDirty()
				arg_136_1:ShowNextGo(true)
			end
		end

		arg_136_1.nodeConfigList_ = {}

		arg_136_1:InitPlayNodeList()
	end,
	Play104071035 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 104071035
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play104071036(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 and not isNil(arg_140_1.actors_["1037ui_story"]) and arg_140_1.var_.characterEffect1037ui_story == nil then
				arg_140_1.var_.characterEffect1037ui_story = arg_140_1.actors_["1037ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_143_0 = 0.1

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 and not isNil(arg_140_1.actors_["1037ui_story"]) then
				if arg_140_1.var_.characterEffect1037ui_story and not isNil(arg_140_1.actors_["1037ui_story"]) then
					arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
					arg_140_1.var_.characterEffect1037ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_140_1.time_ - 0) / var_143_0)
				end
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 and not isNil(arg_140_1.actors_["1037ui_story"]) and arg_140_1.var_.characterEffect1037ui_story then
				arg_140_1.var_.characterEffect1037ui_story.fillFlat = true
				arg_140_1.var_.characterEffect1037ui_story.fillRatio = 0.5
			end

			local var_143_1 = arg_140_1.actors_["1037ui_story"].transform

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1037ui_story = var_143_1.localPosition
			end

			local var_143_2 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_2 then
				var_143_1.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1037ui_story, Vector3.New(0, 100, 0), (arg_140_1.time_ - 0) / var_143_2)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_2 and arg_140_1.time_ < 0 + var_143_2 + arg_143_0 then
				var_143_1.localPosition = Vector3.New(0, 100, 0)
				var_143_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_143_1.position).x, (manager.ui.mainCamera.transform.position - var_143_1.position).y, (manager.ui.mainCamera.transform.position - var_143_1.position).z)
				var_143_1.localEulerAngles.z = 0
				var_143_1.localEulerAngles.x = 0
				var_143_1.localEulerAngles = var_143_1.localEulerAngles
			end

			local var_143_3 = 0
			local var_143_4 = 0.075

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_3 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, true)
				arg_140_1.iconController_:SetSelectedState("hero")

				arg_140_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_140_1.callingController_:SetSelectedState("normal")

				arg_140_1.keyicon_.color = Color.New(1, 1, 1)
				arg_140_1.icon_.color = Color.New(1, 1, 1)

				local var_143_5 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(104071035).content)

				arg_140_1.text_.text = var_143_5

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_7 = 3 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_5) / 3)

				if (3 <= 0 and var_143_4 or var_143_4 * (utf8.len(var_143_5) / 3)) > 0 and var_143_4 < var_143_7 then
					arg_140_1.talkMaxDuration = var_143_7

					if var_143_7 + var_143_3 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_7 + var_143_3
					end
				end

				arg_140_1.text_.text = var_143_5
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_8 = math.max(var_143_4, arg_140_1.talkMaxDuration)

			if var_143_3 <= arg_140_1.time_ and arg_140_1.time_ < var_143_3 + var_143_8 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_3) / var_143_8

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_3 + var_143_8 and arg_140_1.time_ < var_143_3 + var_143_8 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1037ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play104071036 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 104071036
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
			arg_144_1.auto_ = false
		end

		function arg_144_1.playNext_(arg_146_0)
			arg_144_1.onStoryFinished_()
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			local var_147_0 = 0.425

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_1 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(104071036).content)

				arg_144_1.text_.text = var_147_1

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_3 = 17 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 17)

				if (17 <= 0 and var_147_0 or var_147_0 * (utf8.len(var_147_1) / 17)) > 0 and var_147_0 < var_147_3 then
					arg_144_1.talkMaxDuration = var_147_3

					if var_147_3 + 0 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_3 + 0
					end
				end

				arg_144_1.text_.text = var_147_1
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_4 = math.max(var_147_0, arg_144_1.talkMaxDuration)

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_4 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - 0) / var_147_4

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= 0 + var_147_4 and arg_144_1.time_ < 0 + var_147_4 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B06a",
		"TextureConfig/Background/A00"
	},
	voices = {
		"story_v_out_104071.awb"
	}
}
