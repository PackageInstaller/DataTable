return {
	Play103031001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103031001
		arg_1_1.duration_ = 11.33

		local var_1_0 = {
			ja = 11.333,
			ko = 6.766,
			zh = 8.933,
			en = 10.6
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
				arg_1_0:Play103031002(arg_1_1)
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

			local var_4_4 = "4010ui_story"

			if arg_1_1.actors_["4010ui_story"] == nil and not isNil((Asset.Load("Char/" .. "4010ui_story"))) then
				local var_4_5 = Object.Instantiate(Asset.Load("Char/" .. "4010ui_story"), arg_1_1.stage_.transform)

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

			local var_4_8 = arg_1_1.actors_["4010ui_story"]

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect4010ui_story == nil then
				arg_1_1.var_.characterEffect4010ui_story = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 1.8 <= arg_1_1.time_ and arg_1_1.time_ < 1.8 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect4010ui_story and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 1.8 + var_4_9 and arg_1_1.time_ < 1.8 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect4010ui_story then
				arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_4_11 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_11 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_12 = 2

			if var_4_11 <= arg_1_1.time_ and arg_1_1.time_ < var_4_11 + var_4_12 then
				local var_4_13 = Color.New(0, 0, 0)

				var_4_13.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_11) / var_4_12)
				arg_1_1.mask_.color = var_4_13
			end

			if arg_1_1.time_ >= var_4_11 + var_4_12 and arg_1_1.time_ < var_4_11 + var_4_12 + arg_4_0 then
				local var_4_14 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_14.a = 0
				arg_1_1.mask_.color = var_4_14
			end

			local var_4_15 = "B08b"

			if arg_1_1.bgs_.B08b == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_17 = arg_1_1.bgs_.B08b

				arg_1_1.bgs_.B08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_18 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_18 and var_4_18.sprite then
					local var_4_19 = 2 * (var_4_17.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_17.transform.localScale = Vector3.New(var_4_19 / var_4_18.sprite.bounds.size.y < var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x and var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x or var_4_19 / var_4_18.sprite.bounds.size.y, var_4_19 / var_4_18.sprite.bounds.size.y < var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x and var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x or var_4_19 / var_4_18.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_20 = arg_1_1.actors_["4010ui_story"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos4010ui_story = var_4_20.localPosition
			end

			local var_4_21 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_21 then
				var_4_20.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_1_1.time_ - 1.79999995231628) / var_4_21)
				var_4_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_20.position).x, (manager.ui.mainCamera.transform.position - var_4_20.position).y, (manager.ui.mainCamera.transform.position - var_4_20.position).z)
				var_4_20.localEulerAngles.z = 0
				var_4_20.localEulerAngles.x = 0
				var_4_20.localEulerAngles = var_4_20.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_21 and arg_1_1.time_ < 1.79999995231628 + var_4_21 + arg_4_0 then
				var_4_20.localPosition = Vector3.New(0, -1.59, -5.2)
				var_4_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_20.position).x, (manager.ui.mainCamera.transform.position - var_4_20.position).y, (manager.ui.mainCamera.transform.position - var_4_20.position).z)
				var_4_20.localEulerAngles.z = 0
				var_4_20.localEulerAngles.x = 0
				var_4_20.localEulerAngles = var_4_20.localEulerAngles
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 1.8 < arg_1_1.time_ and arg_1_1.time_ <= 1.8 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.7

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_24 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_24:setOnUpdate(LuaHelper.FloatAction(function(arg_6_0)
					arg_1_1.dialogCg_.alpha = arg_6_0
				end))
				var_4_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, true)

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_25 = arg_1_1:GetWordFromCfg(103031001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 28 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 28)

				if (28 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 28)) > 0 and var_4_23 < var_4_28 then
					arg_1_1.talkMaxDuration = var_4_28
					var_4_22 = var_4_22 + 0.3

					if var_4_28 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_22
					end
				end

				arg_1_1.text_.text = var_4_26
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031001", "story_v_out_103031.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_103031", "103031001", "story_v_out_103031.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_103031", "103031001", "story_v_out_103031.awb")

						arg_1_1:RecordAudio("103031001", var_4_30)
						arg_1_1:RecordAudio("103031001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103031", "103031001", "story_v_out_103031.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103031", "103031001", "story_v_out_103031.awb")
				end

				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_31 = var_4_22 + 0.3
			local var_4_32 = math.max(var_4_23, arg_1_1.talkMaxDuration)

			if var_4_22 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_31 + var_4_32 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_31) / var_4_32

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_31 + var_4_32 and arg_1_1.time_ < var_4_31 + var_4_32 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
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
	Play103031002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103031002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103031003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1011ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1011ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1011ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1011ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1011ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1011ui_story == nil then
				arg_8_1.var_.characterEffect1011ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1011ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1011ui_story then
				arg_8_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_11_6 = "1019ui_story"

			if arg_8_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_11_7 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_8_1.stage_.transform)

				var_11_7.name = var_11_6
				var_11_7.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_6] = var_11_7

				local var_11_8 = var_11_7:GetComponentInChildren(typeof(CharacterEffect))

				var_11_8.enabled = true

				local var_11_9 = GameObjectTools.GetOrAddComponent(var_11_7, typeof(DynamicBoneHelper))

				if var_11_9 then
					var_11_9:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_8.transform, false)

				arg_8_1.var_[var_11_6 .. "Animator"] = var_11_8.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_6 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_6 .. "LipSync"] = var_11_8.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_10 = arg_8_1.actors_["1019ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1019ui_story == nil then
				arg_8_1.var_.characterEffect1019ui_story = var_11_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_11 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_11 and not isNil(var_11_10) then
				if arg_8_1.var_.characterEffect1019ui_story and not isNil(var_11_10) then
					arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_11 and arg_8_1.time_ < 0 + var_11_11 + arg_11_0 and not isNil(var_11_10) and arg_8_1.var_.characterEffect1019ui_story then
				arg_8_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_11_13 = "1084ui_story"

			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_14 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_14.name = var_11_13
				var_11_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_[var_11_13] = var_11_14

				local var_11_15 = var_11_14:GetComponentInChildren(typeof(CharacterEffect))

				var_11_15.enabled = true

				local var_11_16 = GameObjectTools.GetOrAddComponent(var_11_14, typeof(DynamicBoneHelper))

				if var_11_16 then
					var_11_16:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_15.transform, false)

				arg_8_1.var_[var_11_13 .. "Animator"] = var_11_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_[var_11_13 .. "Animator"].applyRootMotion = true
				arg_8_1.var_[var_11_13 .. "LipSync"] = var_11_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_17 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_17) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_18 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_18 and not isNil(var_11_17) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_17) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_18 and arg_8_1.time_ < 0 + var_11_18 + arg_11_0 and not isNil(var_11_17) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_20 = arg_8_1.actors_["4010ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_20) and arg_8_1.var_.characterEffect4010ui_story == nil then
				arg_8_1.var_.characterEffect4010ui_story = var_11_20:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_21 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_21 and not isNil(var_11_20) then
				if arg_8_1.var_.characterEffect4010ui_story and not isNil(var_11_20) then
					arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_8_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_8_1.time_ - 0) / var_11_21)
				end
			end

			if arg_8_1.time_ >= 0 + var_11_21 and arg_8_1.time_ < 0 + var_11_21 + arg_11_0 and not isNil(var_11_20) and arg_8_1.var_.characterEffect4010ui_story then
				arg_8_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_8_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_11_22 = arg_8_1.actors_["4010ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos4010ui_story = var_11_22.localPosition
			end

			local var_11_23 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_23 then
				var_11_22.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_23)
				var_11_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_22.position).x, (manager.ui.mainCamera.transform.position - var_11_22.position).y, (manager.ui.mainCamera.transform.position - var_11_22.position).z)
				var_11_22.localEulerAngles.z = 0
				var_11_22.localEulerAngles.x = 0
				var_11_22.localEulerAngles = var_11_22.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_23 and arg_8_1.time_ < 0 + var_11_23 + arg_11_0 then
				var_11_22.localPosition = Vector3.New(0, 100, 0)
				var_11_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_22.position).x, (manager.ui.mainCamera.transform.position - var_11_22.position).y, (manager.ui.mainCamera.transform.position - var_11_22.position).z)
				var_11_22.localEulerAngles.z = 0
				var_11_22.localEulerAngles.x = 0
				var_11_22.localEulerAngles = var_11_22.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_11_24 = arg_8_1.actors_["1011ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1011ui_story = var_11_24.localPosition
			end

			local var_11_25 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_25 then
				var_11_24.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_8_1.time_ - 0) / var_11_25)
				var_11_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_24.position).x, (manager.ui.mainCamera.transform.position - var_11_24.position).y, (manager.ui.mainCamera.transform.position - var_11_24.position).z)
				var_11_24.localEulerAngles.z = 0
				var_11_24.localEulerAngles.x = 0
				var_11_24.localEulerAngles = var_11_24.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_25 and arg_8_1.time_ < 0 + var_11_25 + arg_11_0 then
				var_11_24.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_11_24.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_24.position).x, (manager.ui.mainCamera.transform.position - var_11_24.position).y, (manager.ui.mainCamera.transform.position - var_11_24.position).z)
				var_11_24.localEulerAngles.z = 0
				var_11_24.localEulerAngles.x = 0
				var_11_24.localEulerAngles = var_11_24.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			local var_11_26 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_26.localPosition
			end

			local var_11_27 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_27 then
				var_11_26.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_8_1.time_ - 0) / var_11_27)
				var_11_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_26.position).x, (manager.ui.mainCamera.transform.position - var_11_26.position).y, (manager.ui.mainCamera.transform.position - var_11_26.position).z)
				var_11_26.localEulerAngles.z = 0
				var_11_26.localEulerAngles.x = 0
				var_11_26.localEulerAngles = var_11_26.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_27 and arg_8_1.time_ < 0 + var_11_27 + arg_11_0 then
				var_11_26.localPosition = Vector3.New(0, -0.97, -6)
				var_11_26.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_26.position).x, (manager.ui.mainCamera.transform.position - var_11_26.position).y, (manager.ui.mainCamera.transform.position - var_11_26.position).z)
				var_11_26.localEulerAngles.z = 0
				var_11_26.localEulerAngles.x = 0
				var_11_26.localEulerAngles = var_11_26.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_11_28 = arg_8_1.actors_["1019ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1019ui_story = var_11_28.localPosition
			end

			local var_11_29 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_29 then
				var_11_28.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_8_1.time_ - 0) / var_11_29)
				var_11_28.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_28.position).x, (manager.ui.mainCamera.transform.position - var_11_28.position).y, (manager.ui.mainCamera.transform.position - var_11_28.position).z)
				var_11_28.localEulerAngles.z = 0
				var_11_28.localEulerAngles.x = 0
				var_11_28.localEulerAngles = var_11_28.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_29 and arg_8_1.time_ < 0 + var_11_29 + arg_11_0 then
				var_11_28.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_11_28.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_28.position).x, (manager.ui.mainCamera.transform.position - var_11_28.position).y, (manager.ui.mainCamera.transform.position - var_11_28.position).z)
				var_11_28.localEulerAngles.z = 0
				var_11_28.localEulerAngles.x = 0
				var_11_28.localEulerAngles = var_11_28.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_11_30 = 0
			local var_11_31 = 0.05

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_30 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[50].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_32 = arg_8_1:GetWordFromCfg(103031002)
				local var_11_33 = arg_8_1:FormatText(var_11_32.content)

				arg_8_1.text_.text = var_11_33

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_35 = 2 <= 0 and var_11_31 or var_11_31 * (utf8.len(var_11_33) / 2)

				if (2 <= 0 and var_11_31 or var_11_31 * (utf8.len(var_11_33) / 2)) > 0 and var_11_31 < var_11_35 then
					arg_8_1.talkMaxDuration = var_11_35

					if var_11_35 + var_11_30 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_35 + var_11_30
					end
				end

				arg_8_1.text_.text = var_11_33
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031002", "story_v_out_103031.awb") ~= 0 then
					local var_11_36 = manager.audio:GetVoiceLength("story_v_out_103031", "103031002", "story_v_out_103031.awb") / 1000

					if var_11_36 + var_11_30 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_36 + var_11_30
					end

					if var_11_32.prefab_name ~= "" and arg_8_1.actors_[var_11_32.prefab_name] ~= nil then
						local var_11_37 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_32.prefab_name].transform, "story_v_out_103031", "103031002", "story_v_out_103031.awb")

						arg_8_1:RecordAudio("103031002", var_11_37)
						arg_8_1:RecordAudio("103031002", var_11_37)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103031", "103031002", "story_v_out_103031.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103031", "103031002", "story_v_out_103031.awb")
				end

				arg_8_1:RecordContent(arg_8_1.text_.text)
			end

			local var_11_38 = math.max(var_11_31, arg_8_1.talkMaxDuration)

			if var_11_30 <= arg_8_1.time_ and arg_8_1.time_ < var_11_30 + var_11_38 then
				arg_8_1.typewritter.percent = (arg_8_1.time_ - var_11_30) / var_11_38

				arg_8_1.typewritter:SetDirty()
			end

			if arg_8_1.time_ >= var_11_30 + var_11_38 and arg_8_1.time_ < var_11_30 + var_11_38 + arg_11_0 then
				arg_8_1.typewritter.percent = 1

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(true)
			end
		end

		arg_8_1.nodeConfigList_ = {
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

		arg_8_1:InitPlayNodeList()
	end,
	Play103031003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103031003
		arg_12_1.duration_ = 5.7

		local var_12_0 = {
			ja = 5.1,
			ko = 3.8,
			zh = 5.7,
			en = 5.3
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
				arg_12_0:Play103031004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["4010ui_story"]) and arg_12_1.var_.characterEffect4010ui_story == nil then
				arg_12_1.var_.characterEffect4010ui_story = arg_12_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["4010ui_story"]) then
				if arg_12_1.var_.characterEffect4010ui_story and not isNil(arg_12_1.actors_["4010ui_story"]) then
					arg_12_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["4010ui_story"]) and arg_12_1.var_.characterEffect4010ui_story then
				arg_12_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_15_2 = arg_12_1.actors_["1011ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_2.localPosition
			end

			local var_15_3 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_3 then
				var_15_2.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_3)
				var_15_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_2.position).x, (manager.ui.mainCamera.transform.position - var_15_2.position).y, (manager.ui.mainCamera.transform.position - var_15_2.position).z)
				var_15_2.localEulerAngles.z = 0
				var_15_2.localEulerAngles.x = 0
				var_15_2.localEulerAngles = var_15_2.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_3 and arg_12_1.time_ < 0 + var_15_3 + arg_15_0 then
				var_15_2.localPosition = Vector3.New(0, 100, 0)
				var_15_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_2.position).x, (manager.ui.mainCamera.transform.position - var_15_2.position).y, (manager.ui.mainCamera.transform.position - var_15_2.position).z)
				var_15_2.localEulerAngles.z = 0
				var_15_2.localEulerAngles.x = 0
				var_15_2.localEulerAngles = var_15_2.localEulerAngles
			end

			local var_15_4 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_4.localPosition
			end

			local var_15_5 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_5 then
				var_15_4.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_5)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_5 and arg_12_1.time_ < 0 + var_15_5 + arg_15_0 then
				var_15_4.localPosition = Vector3.New(0, 100, 0)
				var_15_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_4.position).x, (manager.ui.mainCamera.transform.position - var_15_4.position).y, (manager.ui.mainCamera.transform.position - var_15_4.position).z)
				var_15_4.localEulerAngles.z = 0
				var_15_4.localEulerAngles.x = 0
				var_15_4.localEulerAngles = var_15_4.localEulerAngles
			end

			local var_15_6 = arg_12_1.actors_["1019ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1019ui_story = var_15_6.localPosition
			end

			local var_15_7 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 then
				var_15_6.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_7)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 then
				var_15_6.localPosition = Vector3.New(0, 100, 0)
				var_15_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_6.position).x, (manager.ui.mainCamera.transform.position - var_15_6.position).y, (manager.ui.mainCamera.transform.position - var_15_6.position).z)
				var_15_6.localEulerAngles.z = 0
				var_15_6.localEulerAngles.x = 0
				var_15_6.localEulerAngles = var_15_6.localEulerAngles
			end

			local var_15_8 = arg_12_1.actors_["4010ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos4010ui_story = var_15_8.localPosition
			end

			local var_15_9 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_12_1.time_ - 0) / var_15_9)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0, -1.59, -5.2)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_15_10 = 0
			local var_15_11 = 0.65

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_10 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_12 = arg_12_1:GetWordFromCfg(103031003)
				local var_15_13 = arg_12_1:FormatText(var_15_12.content)

				arg_12_1.text_.text = var_15_13

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_15 = 25 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 25)

				if (25 <= 0 and var_15_11 or var_15_11 * (utf8.len(var_15_13) / 25)) > 0 and var_15_11 < var_15_15 then
					arg_12_1.talkMaxDuration = var_15_15

					if var_15_15 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_15 + var_15_10
					end
				end

				arg_12_1.text_.text = var_15_13
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031003", "story_v_out_103031.awb") ~= 0 then
					local var_15_16 = manager.audio:GetVoiceLength("story_v_out_103031", "103031003", "story_v_out_103031.awb") / 1000

					if var_15_16 + var_15_10 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_16 + var_15_10
					end

					if var_15_12.prefab_name ~= "" and arg_12_1.actors_[var_15_12.prefab_name] ~= nil then
						local var_15_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_12.prefab_name].transform, "story_v_out_103031", "103031003", "story_v_out_103031.awb")

						arg_12_1:RecordAudio("103031003", var_15_17)
						arg_12_1:RecordAudio("103031003", var_15_17)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_103031", "103031003", "story_v_out_103031.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_103031", "103031003", "story_v_out_103031.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_18 = math.max(var_15_11, arg_12_1.talkMaxDuration)

			if var_15_10 <= arg_12_1.time_ and arg_12_1.time_ < var_15_10 + var_15_18 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_10) / var_15_18

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_10 + var_15_18 and arg_12_1.time_ < var_15_10 + var_15_18 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {
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

		arg_12_1:InitPlayNodeList()
	end,
	Play103031004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103031004
		arg_16_1.duration_ = 4.6

		local var_16_0 = {
			ja = 4.266,
			ko = 4.033,
			zh = 4.6,
			en = 3.533
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
				arg_16_0:Play103031005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1011ui_story"]) and arg_16_1.var_.characterEffect1011ui_story == nil then
				arg_16_1.var_.characterEffect1011ui_story = arg_16_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1011ui_story"]) then
				if arg_16_1.var_.characterEffect1011ui_story and not isNil(arg_16_1.actors_["1011ui_story"]) then
					arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1011ui_story"]) and arg_16_1.var_.characterEffect1011ui_story then
				arg_16_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["4010ui_story"]

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect4010ui_story == nil then
				arg_16_1.var_.characterEffect4010ui_story = var_19_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_3 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 and not isNil(var_19_2) then
				if arg_16_1.var_.characterEffect4010ui_story and not isNil(var_19_2) then
					arg_16_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_16_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_16_1.time_ - 0) / var_19_3)
				end
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 and not isNil(var_19_2) and arg_16_1.var_.characterEffect4010ui_story then
				arg_16_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_16_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_19_4 = arg_16_1.actors_["4010ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos4010ui_story = var_19_4.localPosition
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_4.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_5)
				var_19_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_4.position).x, (manager.ui.mainCamera.transform.position - var_19_4.position).y, (manager.ui.mainCamera.transform.position - var_19_4.position).z)
				var_19_4.localEulerAngles.z = 0
				var_19_4.localEulerAngles.x = 0
				var_19_4.localEulerAngles = var_19_4.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_4.localPosition = Vector3.New(0, 100, 0)
				var_19_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_4.position).x, (manager.ui.mainCamera.transform.position - var_19_4.position).y, (manager.ui.mainCamera.transform.position - var_19_4.position).z)
				var_19_4.localEulerAngles.z = 0
				var_19_4.localEulerAngles.x = 0
				var_19_4.localEulerAngles = var_19_4.localEulerAngles
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
				arg_16_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			local var_19_8 = 0
			local var_19_9 = 0.375

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

				local var_19_10 = arg_16_1:GetWordFromCfg(103031004)
				local var_19_11 = arg_16_1:FormatText(var_19_10.content)

				arg_16_1.text_.text = var_19_11

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_13 = 15 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 15)

				if (15 <= 0 and var_19_9 or var_19_9 * (utf8.len(var_19_11) / 15)) > 0 and var_19_9 < var_19_13 then
					arg_16_1.talkMaxDuration = var_19_13

					if var_19_13 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_13 + var_19_8
					end
				end

				arg_16_1.text_.text = var_19_11
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031004", "story_v_out_103031.awb") ~= 0 then
					local var_19_14 = manager.audio:GetVoiceLength("story_v_out_103031", "103031004", "story_v_out_103031.awb") / 1000

					if var_19_14 + var_19_8 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_14 + var_19_8
					end

					if var_19_10.prefab_name ~= "" and arg_16_1.actors_[var_19_10.prefab_name] ~= nil then
						local var_19_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_10.prefab_name].transform, "story_v_out_103031", "103031004", "story_v_out_103031.awb")

						arg_16_1:RecordAudio("103031004", var_19_15)
						arg_16_1:RecordAudio("103031004", var_19_15)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103031", "103031004", "story_v_out_103031.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103031", "103031004", "story_v_out_103031.awb")
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
	Play103031005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103031005
		arg_20_1.duration_ = 5.17

		local var_20_0 = {
			ja = 5.166,
			ko = 4.266,
			zh = 4.4,
			en = 4.233
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
				arg_20_0:Play103031006(arg_20_1)
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

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_23_4 = arg_20_1.actors_["1019ui_story"].transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.moveOldPos1019ui_story = var_23_4.localPosition
			end

			local var_23_5 = 0.001

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_5 then
				var_23_4.localPosition = Vector3.Lerp(arg_20_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_20_1.time_ - 0) / var_23_5)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if arg_20_1.time_ >= 0 + var_23_5 and arg_20_1.time_ < 0 + var_23_5 + arg_23_0 then
				var_23_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_23_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_23_4.position).x, (manager.ui.mainCamera.transform.position - var_23_4.position).y, (manager.ui.mainCamera.transform.position - var_23_4.position).z)
				var_23_4.localEulerAngles.z = 0
				var_23_4.localEulerAngles.x = 0
				var_23_4.localEulerAngles = var_23_4.localEulerAngles
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_23_6 = 0
			local var_23_7 = 0.45

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_6 + arg_23_0 then
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

				local var_23_8 = arg_20_1:GetWordFromCfg(103031005)
				local var_23_9 = arg_20_1:FormatText(var_23_8.content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 18 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 18)

				if (18 <= 0 and var_23_7 or var_23_7 * (utf8.len(var_23_9) / 18)) > 0 and var_23_7 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_6
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031005", "story_v_out_103031.awb") ~= 0 then
					local var_23_12 = manager.audio:GetVoiceLength("story_v_out_103031", "103031005", "story_v_out_103031.awb") / 1000

					if var_23_12 + var_23_6 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_12 + var_23_6
					end

					if var_23_8.prefab_name ~= "" and arg_20_1.actors_[var_23_8.prefab_name] ~= nil then
						local var_23_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_8.prefab_name].transform, "story_v_out_103031", "103031005", "story_v_out_103031.awb")

						arg_20_1:RecordAudio("103031005", var_23_13)
						arg_20_1:RecordAudio("103031005", var_23_13)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_103031", "103031005", "story_v_out_103031.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_103031", "103031005", "story_v_out_103031.awb")
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
	Play103031006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103031006
		arg_24_1.duration_ = 2

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play103031007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) and arg_24_1.var_.characterEffect4010ui_story == nil then
				arg_24_1.var_.characterEffect4010ui_story = arg_24_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) then
				if arg_24_1.var_.characterEffect4010ui_story and not isNil(arg_24_1.actors_["4010ui_story"]) then
					arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["4010ui_story"]) and arg_24_1.var_.characterEffect4010ui_story then
				arg_24_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1019ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1019ui_story == nil then
				arg_24_1.var_.characterEffect1019ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1019ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1019ui_story then
				arg_24_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_27_4 = arg_24_1.actors_["1019ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1019ui_story = var_27_4.localPosition
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_4.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
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

			local var_27_6 = arg_24_1.actors_["1011ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1011ui_story = var_27_6.localPosition
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_6.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_7)
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

			local var_27_8 = arg_24_1.actors_["4010ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos4010ui_story = var_27_8.localPosition
			end

			local var_27_9 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_9 then
				var_27_8.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_24_1.time_ - 0) / var_27_9)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_9 and arg_24_1.time_ < 0 + var_27_9 + arg_27_0 then
				var_27_8.localPosition = Vector3.New(0, -1.59, -5.2)
				var_27_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_8.position).x, (manager.ui.mainCamera.transform.position - var_27_8.position).y, (manager.ui.mainCamera.transform.position - var_27_8.position).z)
				var_27_8.localEulerAngles.z = 0
				var_27_8.localEulerAngles.x = 0
				var_27_8.localEulerAngles = var_27_8.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_27_10 = 0
			local var_27_11 = 0.05

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_10 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_12 = arg_24_1:GetWordFromCfg(103031006)
				local var_27_13 = arg_24_1:FormatText(var_27_12.content)

				arg_24_1.text_.text = var_27_13

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_15 = 2 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 2)

				if (2 <= 0 and var_27_11 or var_27_11 * (utf8.len(var_27_13) / 2)) > 0 and var_27_11 < var_27_15 then
					arg_24_1.talkMaxDuration = var_27_15

					if var_27_15 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_15 + var_27_10
					end
				end

				arg_24_1.text_.text = var_27_13
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031006", "story_v_out_103031.awb") ~= 0 then
					local var_27_16 = manager.audio:GetVoiceLength("story_v_out_103031", "103031006", "story_v_out_103031.awb") / 1000

					if var_27_16 + var_27_10 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_16 + var_27_10
					end

					if var_27_12.prefab_name ~= "" and arg_24_1.actors_[var_27_12.prefab_name] ~= nil then
						local var_27_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_12.prefab_name].transform, "story_v_out_103031", "103031006", "story_v_out_103031.awb")

						arg_24_1:RecordAudio("103031006", var_27_17)
						arg_24_1:RecordAudio("103031006", var_27_17)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103031", "103031006", "story_v_out_103031.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103031", "103031006", "story_v_out_103031.awb")
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

		arg_24_1:InitPlayNodeList()
	end,
	Play103031007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103031007
		arg_28_1.duration_ = 3.07

		local var_28_0 = {
			ja = 3.066,
			ko = 2.266,
			zh = 2.466,
			en = 2.133
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
				arg_28_0:Play103031008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if arg_28_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_31_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_28_1.stage_.transform)

				var_31_0.name = "3009ui_story"
				var_31_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_28_1.actors_["3009ui_story"] = var_31_0

				local var_31_1 = var_31_0:GetComponentInChildren(typeof(CharacterEffect))

				var_31_1.enabled = true

				local var_31_2 = GameObjectTools.GetOrAddComponent(var_31_0, typeof(DynamicBoneHelper))

				if var_31_2 then
					var_31_2:EnableDynamicBone(false)
				end

				arg_28_1:ShowWeapon(var_31_1.transform, false)

				arg_28_1.var_["3009ui_story" .. "Animator"] = var_31_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_28_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_28_1.var_["3009ui_story" .. "LipSync"] = var_31_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_31_3 = arg_28_1.actors_["3009ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect3009ui_story == nil then
				arg_28_1.var_.characterEffect3009ui_story = var_31_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_4 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_4 and not isNil(var_31_3) then
				if arg_28_1.var_.characterEffect3009ui_story and not isNil(var_31_3) then
					arg_28_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_4 and arg_28_1.time_ < 0 + var_31_4 + arg_31_0 and not isNil(var_31_3) and arg_28_1.var_.characterEffect3009ui_story then
				arg_28_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_31_6 = arg_28_1.actors_["4010ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = var_31_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_7 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 and not isNil(var_31_6) then
				if arg_28_1.var_.characterEffect4010ui_story and not isNil(var_31_6) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_28_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_7)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 and not isNil(var_31_6) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_28_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_31_8 = arg_28_1.actors_["4010ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_8.localPosition
			end

			local var_31_9 = 0.5

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_9 then
				var_31_8.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_28_1.time_ - 0) / var_31_9)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_9 and arg_28_1.time_ < 0 + var_31_9 + arg_31_0 then
				var_31_8.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_31_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_8.position).x, (manager.ui.mainCamera.transform.position - var_31_8.position).y, (manager.ui.mainCamera.transform.position - var_31_8.position).z)
				var_31_8.localEulerAngles.z = 0
				var_31_8.localEulerAngles.x = 0
				var_31_8.localEulerAngles = var_31_8.localEulerAngles
			end

			local var_31_10 = arg_28_1.actors_["3009ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos3009ui_story = var_31_10.localPosition

				arg_28_1:ShowWeapon(arg_28_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_31_11 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_11 then
				var_31_10.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_28_1.time_ - 0) / var_31_11)
				var_31_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_10.position).x, (manager.ui.mainCamera.transform.position - var_31_10.position).y, (manager.ui.mainCamera.transform.position - var_31_10.position).z)
				var_31_10.localEulerAngles.z = 0
				var_31_10.localEulerAngles.x = 0
				var_31_10.localEulerAngles = var_31_10.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_11 and arg_28_1.time_ < 0 + var_31_11 + arg_31_0 then
				var_31_10.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_31_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_10.position).x, (manager.ui.mainCamera.transform.position - var_31_10.position).y, (manager.ui.mainCamera.transform.position - var_31_10.position).z)
				var_31_10.localEulerAngles.z = 0
				var_31_10.localEulerAngles.x = 0
				var_31_10.localEulerAngles = var_31_10.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_31_12 = 0
			local var_31_13 = 0.25

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_12 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_14 = arg_28_1:GetWordFromCfg(103031007)
				local var_31_15 = arg_28_1:FormatText(var_31_14.content)

				arg_28_1.text_.text = var_31_15

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_17 = 10 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 10)

				if (10 <= 0 and var_31_13 or var_31_13 * (utf8.len(var_31_15) / 10)) > 0 and var_31_13 < var_31_17 then
					arg_28_1.talkMaxDuration = var_31_17

					if var_31_17 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_17 + var_31_12
					end
				end

				arg_28_1.text_.text = var_31_15
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031007", "story_v_out_103031.awb") ~= 0 then
					local var_31_18 = manager.audio:GetVoiceLength("story_v_out_103031", "103031007", "story_v_out_103031.awb") / 1000

					if var_31_18 + var_31_12 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_18 + var_31_12
					end

					if var_31_14.prefab_name ~= "" and arg_28_1.actors_[var_31_14.prefab_name] ~= nil then
						local var_31_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_14.prefab_name].transform, "story_v_out_103031", "103031007", "story_v_out_103031.awb")

						arg_28_1:RecordAudio("103031007", var_31_19)
						arg_28_1:RecordAudio("103031007", var_31_19)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103031", "103031007", "story_v_out_103031.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103031", "103031007", "story_v_out_103031.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_20 = math.max(var_31_13, arg_28_1.talkMaxDuration)

			if var_31_12 <= arg_28_1.time_ and arg_28_1.time_ < var_31_12 + var_31_20 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_12) / var_31_20

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_12 + var_31_20 and arg_28_1.time_ < var_31_12 + var_31_20 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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

		arg_28_1:InitPlayNodeList()
	end,
	Play103031008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103031008
		arg_32_1.duration_ = 6.27

		local var_32_0 = {
			ja = 6.266,
			ko = 4.633,
			zh = 3.633,
			en = 5.6
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
				arg_32_0:Play103031009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(arg_32_1.actors_["4010ui_story"]) and arg_32_1.var_.characterEffect4010ui_story == nil then
				arg_32_1.var_.characterEffect4010ui_story = arg_32_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_0 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 and not isNil(arg_32_1.actors_["4010ui_story"]) then
				if arg_32_1.var_.characterEffect4010ui_story and not isNil(arg_32_1.actors_["4010ui_story"]) then
					arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 and not isNil(arg_32_1.actors_["4010ui_story"]) and arg_32_1.var_.characterEffect4010ui_story then
				arg_32_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_35_2 = arg_32_1.actors_["3009ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect3009ui_story == nil then
				arg_32_1.var_.characterEffect3009ui_story = var_35_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_3 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_3 and not isNil(var_35_2) then
				if arg_32_1.var_.characterEffect3009ui_story and not isNil(var_35_2) then
					arg_32_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_32_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_3)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_3 and arg_32_1.time_ < 0 + var_35_3 + arg_35_0 and not isNil(var_35_2) and arg_32_1.var_.characterEffect3009ui_story then
				arg_32_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_32_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_35_4 = 0
			local var_35_5 = 0.375

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_4 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_6 = arg_32_1:GetWordFromCfg(103031008)
				local var_35_7 = arg_32_1:FormatText(var_35_6.content)

				arg_32_1.text_.text = var_35_7

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_9 = 15 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 15)

				if (15 <= 0 and var_35_5 or var_35_5 * (utf8.len(var_35_7) / 15)) > 0 and var_35_5 < var_35_9 then
					arg_32_1.talkMaxDuration = var_35_9

					if var_35_9 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_9 + var_35_4
					end
				end

				arg_32_1.text_.text = var_35_7
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031008", "story_v_out_103031.awb") ~= 0 then
					local var_35_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031008", "story_v_out_103031.awb") / 1000

					if var_35_10 + var_35_4 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_10 + var_35_4
					end

					if var_35_6.prefab_name ~= "" and arg_32_1.actors_[var_35_6.prefab_name] ~= nil then
						local var_35_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_6.prefab_name].transform, "story_v_out_103031", "103031008", "story_v_out_103031.awb")

						arg_32_1:RecordAudio("103031008", var_35_11)
						arg_32_1:RecordAudio("103031008", var_35_11)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_103031", "103031008", "story_v_out_103031.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_103031", "103031008", "story_v_out_103031.awb")
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

		arg_32_1.nodeConfigList_ = {}

		arg_32_1:InitPlayNodeList()
	end,
	Play103031009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103031009
		arg_36_1.duration_ = 8.4

		local var_36_0 = {
			ja = 3.166,
			ko = 8.4,
			zh = 5.533,
			en = 6.7
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
				arg_36_0:Play103031010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if arg_36_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_39_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_36_1.stage_.transform)

				var_39_0.name = "3008ui_story"
				var_39_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_36_1.actors_["3008ui_story"] = var_39_0

				local var_39_1 = var_39_0:GetComponentInChildren(typeof(CharacterEffect))

				var_39_1.enabled = true

				local var_39_2 = GameObjectTools.GetOrAddComponent(var_39_0, typeof(DynamicBoneHelper))

				if var_39_2 then
					var_39_2:EnableDynamicBone(false)
				end

				arg_36_1:ShowWeapon(var_39_1.transform, false)

				arg_36_1.var_["3008ui_story" .. "Animator"] = var_39_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_36_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_36_1.var_["3008ui_story" .. "LipSync"] = var_39_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_39_3 = arg_36_1.actors_["3008ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect3008ui_story == nil then
				arg_36_1.var_.characterEffect3008ui_story = var_39_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_4 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_4 and not isNil(var_39_3) then
				if arg_36_1.var_.characterEffect3008ui_story and not isNil(var_39_3) then
					arg_36_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_4 and arg_36_1.time_ < 0 + var_39_4 + arg_39_0 and not isNil(var_39_3) and arg_36_1.var_.characterEffect3008ui_story then
				arg_36_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_39_6 = arg_36_1.actors_["3009ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos3009ui_story = var_39_6.localPosition
			end

			local var_39_7 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_7 then
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_7)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_7 and arg_36_1.time_ < 0 + var_39_7 + arg_39_0 then
				var_39_6.localPosition = Vector3.New(0, 100, 0)
				var_39_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_6.position).x, (manager.ui.mainCamera.transform.position - var_39_6.position).y, (manager.ui.mainCamera.transform.position - var_39_6.position).z)
				var_39_6.localEulerAngles.z = 0
				var_39_6.localEulerAngles.x = 0
				var_39_6.localEulerAngles = var_39_6.localEulerAngles
			end

			local var_39_8 = arg_36_1.actors_["4010ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos4010ui_story = var_39_8.localPosition
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_9)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, 100, 0)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			local var_39_10 = arg_36_1.actors_["3008ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos3008ui_story = var_39_10.localPosition
			end

			local var_39_11 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_11 then
				var_39_10.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_36_1.time_ - 0) / var_39_11)
				var_39_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_10.position).x, (manager.ui.mainCamera.transform.position - var_39_10.position).y, (manager.ui.mainCamera.transform.position - var_39_10.position).z)
				var_39_10.localEulerAngles.z = 0
				var_39_10.localEulerAngles.x = 0
				var_39_10.localEulerAngles = var_39_10.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_11 and arg_36_1.time_ < 0 + var_39_11 + arg_39_0 then
				var_39_10.localPosition = Vector3.New(0, -1.51, -4.3)
				var_39_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_10.position).x, (manager.ui.mainCamera.transform.position - var_39_10.position).y, (manager.ui.mainCamera.transform.position - var_39_10.position).z)
				var_39_10.localEulerAngles.z = 0
				var_39_10.localEulerAngles.x = 0
				var_39_10.localEulerAngles = var_39_10.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_39_12 = 0
			local var_39_13 = 0.775

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_12 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_14 = arg_36_1:GetWordFromCfg(103031009)
				local var_39_15 = arg_36_1:FormatText(var_39_14.content)

				arg_36_1.text_.text = var_39_15

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_17 = 30 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 30)

				if (30 <= 0 and var_39_13 or var_39_13 * (utf8.len(var_39_15) / 30)) > 0 and var_39_13 < var_39_17 then
					arg_36_1.talkMaxDuration = var_39_17

					if var_39_17 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_17 + var_39_12
					end
				end

				arg_36_1.text_.text = var_39_15
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031009", "story_v_out_103031.awb") ~= 0 then
					local var_39_18 = manager.audio:GetVoiceLength("story_v_out_103031", "103031009", "story_v_out_103031.awb") / 1000

					if var_39_18 + var_39_12 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_18 + var_39_12
					end

					if var_39_14.prefab_name ~= "" and arg_36_1.actors_[var_39_14.prefab_name] ~= nil then
						local var_39_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_14.prefab_name].transform, "story_v_out_103031", "103031009", "story_v_out_103031.awb")

						arg_36_1:RecordAudio("103031009", var_39_19)
						arg_36_1:RecordAudio("103031009", var_39_19)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103031", "103031009", "story_v_out_103031.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103031", "103031009", "story_v_out_103031.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_20 = math.max(var_39_13, arg_36_1.talkMaxDuration)

			if var_39_12 <= arg_36_1.time_ and arg_36_1.time_ < var_39_12 + var_39_20 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_12) / var_39_20

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_12 + var_39_20 and arg_36_1.time_ < var_39_12 + var_39_20 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "3009ui_story",
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
			},
			{
				assetPath = "",
				actorName = "3008ui_story",
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
	Play103031010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103031010
		arg_40_1.duration_ = 14.2

		local var_40_0 = {
			ja = 14.2,
			ko = 11.733,
			zh = 11.433,
			en = 10.8
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
				arg_40_0:Play103031011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) and arg_40_1.var_.characterEffect4010ui_story == nil then
				arg_40_1.var_.characterEffect4010ui_story = arg_40_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) then
				if arg_40_1.var_.characterEffect4010ui_story and not isNil(arg_40_1.actors_["4010ui_story"]) then
					arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["4010ui_story"]) and arg_40_1.var_.characterEffect4010ui_story then
				arg_40_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["3008ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect3008ui_story == nil then
				arg_40_1.var_.characterEffect3008ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect3008ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_40_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect3008ui_story then
				arg_40_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_40_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_43_4 = arg_40_1.actors_["3008ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos3008ui_story = var_43_4.localPosition
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_5)
				var_43_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_4.position).x, (manager.ui.mainCamera.transform.position - var_43_4.position).y, (manager.ui.mainCamera.transform.position - var_43_4.position).z)
				var_43_4.localEulerAngles.z = 0
				var_43_4.localEulerAngles.x = 0
				var_43_4.localEulerAngles = var_43_4.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_5 and arg_40_1.time_ < 0 + var_43_5 + arg_43_0 then
				var_43_4.localPosition = Vector3.New(0, 100, 0)
				var_43_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_4.position).x, (manager.ui.mainCamera.transform.position - var_43_4.position).y, (manager.ui.mainCamera.transform.position - var_43_4.position).z)
				var_43_4.localEulerAngles.z = 0
				var_43_4.localEulerAngles.x = 0
				var_43_4.localEulerAngles = var_43_4.localEulerAngles
			end

			local var_43_6 = arg_40_1.actors_["4010ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos4010ui_story = var_43_6.localPosition
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_40_1.time_ - 0) / var_43_7)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(0, -1.59, -5.2)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_43_8 = 0
			local var_43_9 = 1.325

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_10 = arg_40_1:GetWordFromCfg(103031010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 52 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 52)

				if (52 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 52)) > 0 and var_43_9 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031010", "story_v_out_103031.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_103031", "103031010", "story_v_out_103031.awb") / 1000

					if var_43_14 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_8
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_out_103031", "103031010", "story_v_out_103031.awb")

						arg_40_1:RecordAudio("103031010", var_43_15)
						arg_40_1:RecordAudio("103031010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_103031", "103031010", "story_v_out_103031.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_103031", "103031010", "story_v_out_103031.awb")
				end

				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_16 = math.max(var_43_9, arg_40_1.talkMaxDuration)

			if var_43_8 <= arg_40_1.time_ and arg_40_1.time_ < var_43_8 + var_43_16 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_8) / var_43_16

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_8 + var_43_16 and arg_40_1.time_ < var_43_8 + var_43_16 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
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
	Play103031011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103031011
		arg_44_1.duration_ = 13.23

		local var_44_0 = {
			ja = 13.233,
			ko = 8.966,
			zh = 10,
			en = 8.833
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
				arg_44_0:Play103031012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_2")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_47_0 = 0
			local var_47_1 = 1.075

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_2 = arg_44_1:GetWordFromCfg(103031011)
				local var_47_3 = arg_44_1:FormatText(var_47_2.content)

				arg_44_1.text_.text = var_47_3

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_5 = 43 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 43)

				if (43 <= 0 and var_47_1 or var_47_1 * (utf8.len(var_47_3) / 43)) > 0 and var_47_1 < var_47_5 then
					arg_44_1.talkMaxDuration = var_47_5

					if var_47_5 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + var_47_0
					end
				end

				arg_44_1.text_.text = var_47_3
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031011", "story_v_out_103031.awb") ~= 0 then
					local var_47_6 = manager.audio:GetVoiceLength("story_v_out_103031", "103031011", "story_v_out_103031.awb") / 1000

					if var_47_6 + var_47_0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_6 + var_47_0
					end

					if var_47_2.prefab_name ~= "" and arg_44_1.actors_[var_47_2.prefab_name] ~= nil then
						local var_47_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_2.prefab_name].transform, "story_v_out_103031", "103031011", "story_v_out_103031.awb")

						arg_44_1:RecordAudio("103031011", var_47_7)
						arg_44_1:RecordAudio("103031011", var_47_7)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103031", "103031011", "story_v_out_103031.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103031", "103031011", "story_v_out_103031.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_8 = math.max(var_47_1, arg_44_1.talkMaxDuration)

			if var_47_0 <= arg_44_1.time_ and arg_44_1.time_ < var_47_0 + var_47_8 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_0) / var_47_8

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_0 + var_47_8 and arg_44_1.time_ < var_47_0 + var_47_8 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play103031012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103031012
		arg_48_1.duration_ = 3.2

		local var_48_0 = {
			ja = 3.2,
			ko = 2.5,
			zh = 1.666,
			en = 1.633
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
				arg_48_0:Play103031013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story == nil then
				arg_48_1.var_.characterEffect1084ui_story = arg_48_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) then
				if arg_48_1.var_.characterEffect1084ui_story and not isNil(arg_48_1.actors_["1084ui_story"]) then
					arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["1084ui_story"]) and arg_48_1.var_.characterEffect1084ui_story then
				arg_48_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["4010ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect4010ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_48_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_48_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.125

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, true)
				arg_48_1.iconController_:SetSelectedState("hero")

				arg_48_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				arg_48_1.callingController_:SetSelectedState("normal")

				arg_48_1.keyicon_.color = Color.New(1, 1, 1)
				arg_48_1.icon_.color = Color.New(1, 1, 1)

				local var_51_6 = arg_48_1:GetWordFromCfg(103031012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 5 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 5)

				if (5 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 5)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031012", "story_v_out_103031.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031012", "story_v_out_103031.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_103031", "103031012", "story_v_out_103031.awb")

						arg_48_1:RecordAudio("103031012", var_51_11)
						arg_48_1:RecordAudio("103031012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103031", "103031012", "story_v_out_103031.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103031", "103031012", "story_v_out_103031.awb")
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

		arg_48_1.nodeConfigList_ = {}

		arg_48_1:InitPlayNodeList()
	end,
	Play103031013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103031013
		arg_52_1.duration_ = 11.57

		local var_52_0 = {
			ja = 11.566,
			ko = 7.4,
			zh = 7.633,
			en = 6.966
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
				arg_52_0:Play103031014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["4010ui_story"]) and arg_52_1.var_.characterEffect4010ui_story == nil then
				arg_52_1.var_.characterEffect4010ui_story = arg_52_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["4010ui_story"]) then
				if arg_52_1.var_.characterEffect4010ui_story and not isNil(arg_52_1.actors_["4010ui_story"]) then
					arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["4010ui_story"]) and arg_52_1.var_.characterEffect4010ui_story then
				arg_52_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_55_2 = arg_52_1.actors_["1084ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1084ui_story == nil then
				arg_52_1.var_.characterEffect1084ui_story = var_55_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_3 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_3 and not isNil(var_55_2) then
				if arg_52_1.var_.characterEffect1084ui_story and not isNil(var_55_2) then
					arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_52_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_3)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_3 and arg_52_1.time_ < 0 + var_55_3 + arg_55_0 and not isNil(var_55_2) and arg_52_1.var_.characterEffect1084ui_story then
				arg_52_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_52_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_55_4 = 0
			local var_55_5 = 0.925

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_4 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_6 = arg_52_1:GetWordFromCfg(103031013)
				local var_55_7 = arg_52_1:FormatText(var_55_6.content)

				arg_52_1.text_.text = var_55_7

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_9 = 37 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 37)

				if (37 <= 0 and var_55_5 or var_55_5 * (utf8.len(var_55_7) / 37)) > 0 and var_55_5 < var_55_9 then
					arg_52_1.talkMaxDuration = var_55_9

					if var_55_9 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_4
					end
				end

				arg_52_1.text_.text = var_55_7
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031013", "story_v_out_103031.awb") ~= 0 then
					local var_55_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031013", "story_v_out_103031.awb") / 1000

					if var_55_10 + var_55_4 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_10 + var_55_4
					end

					if var_55_6.prefab_name ~= "" and arg_52_1.actors_[var_55_6.prefab_name] ~= nil then
						local var_55_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_6.prefab_name].transform, "story_v_out_103031", "103031013", "story_v_out_103031.awb")

						arg_52_1:RecordAudio("103031013", var_55_11)
						arg_52_1:RecordAudio("103031013", var_55_11)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103031", "103031013", "story_v_out_103031.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103031", "103031013", "story_v_out_103031.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_12 = math.max(var_55_5, arg_52_1.talkMaxDuration)

			if var_55_4 <= arg_52_1.time_ and arg_52_1.time_ < var_55_4 + var_55_12 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_4) / var_55_12

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_4 + var_55_12 and arg_52_1.time_ < var_55_4 + var_55_12 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play103031014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103031014
		arg_56_1.duration_ = 5.63

		local var_56_0 = {
			ja = 5.633,
			ko = 4.9,
			zh = 5.433,
			en = 3.966
		}
		local var_56_1 = manager.audio:GetLocalizationFlag()

		if var_56_0[var_56_1] ~= nil then
			arg_56_1.duration_ = var_56_0[var_56_1]
		end

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play103031015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["4010ui_story"]) and arg_56_1.var_.characterEffect4010ui_story == nil then
				arg_56_1.var_.characterEffect4010ui_story = arg_56_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["4010ui_story"]) then
				if arg_56_1.var_.characterEffect4010ui_story and not isNil(arg_56_1.actors_["4010ui_story"]) then
					arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["4010ui_story"]) and arg_56_1.var_.characterEffect4010ui_story then
				arg_56_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["1011ui_story"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1011ui_story == nil then
				arg_56_1.var_.characterEffect1011ui_story = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect1011ui_story and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_56_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect1011ui_story then
				arg_56_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_56_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_59_4 = 0
			local var_59_5 = 0.625

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(103031014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 25 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 25)

				if (25 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 25)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031014", "story_v_out_103031.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031014", "story_v_out_103031.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_103031", "103031014", "story_v_out_103031.awb")

						arg_56_1:RecordAudio("103031014", var_59_11)
						arg_56_1:RecordAudio("103031014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_103031", "103031014", "story_v_out_103031.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_103031", "103031014", "story_v_out_103031.awb")
				end

				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_12 = math.max(var_59_5, arg_56_1.talkMaxDuration)

			if var_59_4 <= arg_56_1.time_ and arg_56_1.time_ < var_59_4 + var_59_12 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - var_59_4) / var_59_12

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= var_59_4 + var_59_12 and arg_56_1.time_ < var_59_4 + var_59_12 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103031015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103031015
		arg_60_1.duration_ = 16.23

		local var_60_0 = {
			ja = 16.233,
			ko = 12.566,
			zh = 13,
			en = 13.666
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
				arg_60_0:Play103031016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_63_0 = 0
			local var_63_1 = 1.6

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_0 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_2 = arg_60_1:GetWordFromCfg(103031015)
				local var_63_3 = arg_60_1:FormatText(var_63_2.content)

				arg_60_1.text_.text = var_63_3

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_5 = 64 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 64)

				if (64 <= 0 and var_63_1 or var_63_1 * (utf8.len(var_63_3) / 64)) > 0 and var_63_1 < var_63_5 then
					arg_60_1.talkMaxDuration = var_63_5

					if var_63_5 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_5 + var_63_0
					end
				end

				arg_60_1.text_.text = var_63_3
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031015", "story_v_out_103031.awb") ~= 0 then
					local var_63_6 = manager.audio:GetVoiceLength("story_v_out_103031", "103031015", "story_v_out_103031.awb") / 1000

					if var_63_6 + var_63_0 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_6 + var_63_0
					end

					if var_63_2.prefab_name ~= "" and arg_60_1.actors_[var_63_2.prefab_name] ~= nil then
						local var_63_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_2.prefab_name].transform, "story_v_out_103031", "103031015", "story_v_out_103031.awb")

						arg_60_1:RecordAudio("103031015", var_63_7)
						arg_60_1:RecordAudio("103031015", var_63_7)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103031", "103031015", "story_v_out_103031.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103031", "103031015", "story_v_out_103031.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_8 = math.max(var_63_1, arg_60_1.talkMaxDuration)

			if var_63_0 <= arg_60_1.time_ and arg_60_1.time_ < var_63_0 + var_63_8 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_0) / var_63_8

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_0 + var_63_8 and arg_60_1.time_ < var_63_0 + var_63_8 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play103031016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 103031016
		arg_64_1.duration_ = 3.7

		local var_64_0 = {
			ja = 3.566,
			ko = 3,
			zh = 3.7,
			en = 3.066
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
				arg_64_0:Play103031017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1011ui_story"]) and arg_64_1.var_.characterEffect1011ui_story == nil then
				arg_64_1.var_.characterEffect1011ui_story = arg_64_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1011ui_story"]) then
				if arg_64_1.var_.characterEffect1011ui_story and not isNil(arg_64_1.actors_["1011ui_story"]) then
					arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1011ui_story"]) and arg_64_1.var_.characterEffect1011ui_story then
				arg_64_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["4010ui_story"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect4010ui_story == nil then
				arg_64_1.var_.characterEffect4010ui_story = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect4010ui_story and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_64_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect4010ui_story then
				arg_64_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_64_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_67_4 = arg_64_1.actors_["4010ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos4010ui_story = var_67_4.localPosition
			end

			local var_67_5 = 0.5

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_5 then
				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_64_1.time_ - 0) / var_67_5)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_5 and arg_64_1.time_ < 0 + var_67_5 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			local var_67_6 = arg_64_1.actors_["1011ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1011ui_story = var_67_6.localPosition
			end

			local var_67_7 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_7 then
				var_67_6.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_64_1.time_ - 0) / var_67_7)
				var_67_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_6.position).x, (manager.ui.mainCamera.transform.position - var_67_6.position).y, (manager.ui.mainCamera.transform.position - var_67_6.position).z)
				var_67_6.localEulerAngles.z = 0
				var_67_6.localEulerAngles.x = 0
				var_67_6.localEulerAngles = var_67_6.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_7 and arg_64_1.time_ < 0 + var_67_7 + arg_67_0 then
				var_67_6.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_67_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_6.position).x, (manager.ui.mainCamera.transform.position - var_67_6.position).y, (manager.ui.mainCamera.transform.position - var_67_6.position).z)
				var_67_6.localEulerAngles.z = 0
				var_67_6.localEulerAngles.x = 0
				var_67_6.localEulerAngles = var_67_6.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_67_8 = 0
			local var_67_9 = 0.275

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_8 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_10 = arg_64_1:GetWordFromCfg(103031016)
				local var_67_11 = arg_64_1:FormatText(var_67_10.content)

				arg_64_1.text_.text = var_67_11

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_13 = 11 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_11) / 11)

				if (11 <= 0 and var_67_9 or var_67_9 * (utf8.len(var_67_11) / 11)) > 0 and var_67_9 < var_67_13 then
					arg_64_1.talkMaxDuration = var_67_13

					if var_67_13 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_13 + var_67_8
					end
				end

				arg_64_1.text_.text = var_67_11
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031016", "story_v_out_103031.awb") ~= 0 then
					local var_67_14 = manager.audio:GetVoiceLength("story_v_out_103031", "103031016", "story_v_out_103031.awb") / 1000

					if var_67_14 + var_67_8 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_14 + var_67_8
					end

					if var_67_10.prefab_name ~= "" and arg_64_1.actors_[var_67_10.prefab_name] ~= nil then
						local var_67_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_10.prefab_name].transform, "story_v_out_103031", "103031016", "story_v_out_103031.awb")

						arg_64_1:RecordAudio("103031016", var_67_15)
						arg_64_1:RecordAudio("103031016", var_67_15)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_103031", "103031016", "story_v_out_103031.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_103031", "103031016", "story_v_out_103031.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_16 = math.max(var_67_9, arg_64_1.talkMaxDuration)

			if var_67_8 <= arg_64_1.time_ and arg_64_1.time_ < var_67_8 + var_67_16 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_8) / var_67_16

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_8 + var_67_16 and arg_64_1.time_ < var_67_8 + var_67_16 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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

		arg_64_1:InitPlayNodeList()
	end,
	Play103031017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 103031017
		arg_68_1.duration_ = 11.7

		local var_68_0 = {
			ja = 11.7,
			ko = 9.633,
			zh = 9.933,
			en = 7.6
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
				arg_68_0:Play103031018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) and arg_68_1.var_.characterEffect4010ui_story == nil then
				arg_68_1.var_.characterEffect4010ui_story = arg_68_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) then
				if arg_68_1.var_.characterEffect4010ui_story and not isNil(arg_68_1.actors_["4010ui_story"]) then
					arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["4010ui_story"]) and arg_68_1.var_.characterEffect4010ui_story then
				arg_68_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_71_2 = arg_68_1.actors_["1011ui_story"]

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1011ui_story == nil then
				arg_68_1.var_.characterEffect1011ui_story = var_71_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_3 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_3 and not isNil(var_71_2) then
				if arg_68_1.var_.characterEffect1011ui_story and not isNil(var_71_2) then
					arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_3)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_3 and arg_68_1.time_ < 0 + var_71_3 + arg_71_0 and not isNil(var_71_2) and arg_68_1.var_.characterEffect1011ui_story then
				arg_68_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_71_4 = 0
			local var_71_5 = 1.075

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_4 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, false)
				arg_68_1.callingController_:SetSelectedState("normal")

				local var_71_6 = arg_68_1:GetWordFromCfg(103031017)
				local var_71_7 = arg_68_1:FormatText(var_71_6.content)

				arg_68_1.text_.text = var_71_7

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_9 = 42 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 42)

				if (42 <= 0 and var_71_5 or var_71_5 * (utf8.len(var_71_7) / 42)) > 0 and var_71_5 < var_71_9 then
					arg_68_1.talkMaxDuration = var_71_9

					if var_71_9 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_9 + var_71_4
					end
				end

				arg_68_1.text_.text = var_71_7
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031017", "story_v_out_103031.awb") ~= 0 then
					local var_71_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031017", "story_v_out_103031.awb") / 1000

					if var_71_10 + var_71_4 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_10 + var_71_4
					end

					if var_71_6.prefab_name ~= "" and arg_68_1.actors_[var_71_6.prefab_name] ~= nil then
						local var_71_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_6.prefab_name].transform, "story_v_out_103031", "103031017", "story_v_out_103031.awb")

						arg_68_1:RecordAudio("103031017", var_71_11)
						arg_68_1:RecordAudio("103031017", var_71_11)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_103031", "103031017", "story_v_out_103031.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_103031", "103031017", "story_v_out_103031.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_12 = math.max(var_71_5, arg_68_1.talkMaxDuration)

			if var_71_4 <= arg_68_1.time_ and arg_68_1.time_ < var_71_4 + var_71_12 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_4) / var_71_12

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_4 + var_71_12 and arg_68_1.time_ < var_71_4 + var_71_12 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play103031018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 103031018
		arg_72_1.duration_ = 12.7

		local var_72_0 = {
			ja = 12.7,
			ko = 9.5,
			zh = 10.666,
			en = 11.8
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
				arg_72_0:Play103031019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_75_0 = 0
			local var_75_1 = 1.15

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_0 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_2 = arg_72_1:GetWordFromCfg(103031018)
				local var_75_3 = arg_72_1:FormatText(var_75_2.content)

				arg_72_1.text_.text = var_75_3

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_5 = 47 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 47)

				if (47 <= 0 and var_75_1 or var_75_1 * (utf8.len(var_75_3) / 47)) > 0 and var_75_1 < var_75_5 then
					arg_72_1.talkMaxDuration = var_75_5

					if var_75_5 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_5 + var_75_0
					end
				end

				arg_72_1.text_.text = var_75_3
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031018", "story_v_out_103031.awb") ~= 0 then
					local var_75_6 = manager.audio:GetVoiceLength("story_v_out_103031", "103031018", "story_v_out_103031.awb") / 1000

					if var_75_6 + var_75_0 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_0
					end

					if var_75_2.prefab_name ~= "" and arg_72_1.actors_[var_75_2.prefab_name] ~= nil then
						local var_75_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_2.prefab_name].transform, "story_v_out_103031", "103031018", "story_v_out_103031.awb")

						arg_72_1:RecordAudio("103031018", var_75_7)
						arg_72_1:RecordAudio("103031018", var_75_7)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_103031", "103031018", "story_v_out_103031.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_103031", "103031018", "story_v_out_103031.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_8 = math.max(var_75_1, arg_72_1.talkMaxDuration)

			if var_75_0 <= arg_72_1.time_ and arg_72_1.time_ < var_75_0 + var_75_8 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_0) / var_75_8

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_0 + var_75_8 and arg_72_1.time_ < var_75_0 + var_75_8 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {}

		arg_72_1:InitPlayNodeList()
	end,
	Play103031019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 103031019
		arg_76_1.duration_ = 6.2

		local var_76_0 = {
			ja = 4.433,
			ko = 5.533,
			zh = 4.8,
			en = 6.2
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
				arg_76_0:Play103031020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_79_0 = 0
			local var_79_1 = 0.375

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_2 = arg_76_1:GetWordFromCfg(103031019)
				local var_79_3 = arg_76_1:FormatText(var_79_2.content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 15 <= 0 and var_79_1 or var_79_1 * (utf8.len(var_79_3) / 15)

				if (15 <= 0 and var_79_1 or var_79_1 * (utf8.len(var_79_3) / 15)) > 0 and var_79_1 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_0
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031019", "story_v_out_103031.awb") ~= 0 then
					local var_79_6 = manager.audio:GetVoiceLength("story_v_out_103031", "103031019", "story_v_out_103031.awb") / 1000

					if var_79_6 + var_79_0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_6 + var_79_0
					end

					if var_79_2.prefab_name ~= "" and arg_76_1.actors_[var_79_2.prefab_name] ~= nil then
						local var_79_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_76_1.actors_[var_79_2.prefab_name].transform, "story_v_out_103031", "103031019", "story_v_out_103031.awb")

						arg_76_1:RecordAudio("103031019", var_79_7)
						arg_76_1:RecordAudio("103031019", var_79_7)
					else
						arg_76_1:AudioAction("play", "voice", "story_v_out_103031", "103031019", "story_v_out_103031.awb")
					end

					arg_76_1:RecordHistoryTalkVoice("story_v_out_103031", "103031019", "story_v_out_103031.awb")
				end

				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_8 = math.max(var_79_1, arg_76_1.talkMaxDuration)

			if var_79_0 <= arg_76_1.time_ and arg_76_1.time_ < var_79_0 + var_79_8 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_0) / var_79_8

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_0 + var_79_8 and arg_76_1.time_ < var_79_0 + var_79_8 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play103031020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 103031020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play103031021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1019ui_story"]) and arg_80_1.var_.characterEffect1019ui_story == nil then
				arg_80_1.var_.characterEffect1019ui_story = arg_80_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1019ui_story"]) then
				if arg_80_1.var_.characterEffect1019ui_story and not isNil(arg_80_1.actors_["1019ui_story"]) then
					arg_80_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1019ui_story"]) and arg_80_1.var_.characterEffect1019ui_story then
				arg_80_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["4010ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect4010ui_story == nil then
				arg_80_1.var_.characterEffect4010ui_story = var_83_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_3 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 and not isNil(var_83_2) then
				if arg_80_1.var_.characterEffect4010ui_story and not isNil(var_83_2) then
					arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_80_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_3)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 and not isNil(var_83_2) and arg_80_1.var_.characterEffect4010ui_story then
				arg_80_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_80_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_83_4 = 0
			local var_83_5 = 0.875

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_6 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(103031020).content)

				arg_80_1.text_.text = var_83_6

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_8 = 35 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_6) / 35)

				if (35 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_6) / 35)) > 0 and var_83_5 < var_83_8 then
					arg_80_1.talkMaxDuration = var_83_8

					if var_83_8 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_8 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_6
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_9 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_9 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_9

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_9 and arg_80_1.time_ < var_83_4 + var_83_9 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play103031021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 103031021
		arg_84_1.duration_ = 9.17

		local var_84_0 = {
			ja = 9.166,
			ko = 6.7,
			zh = 7.533,
			en = 7.5
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
				arg_84_0:Play103031022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_87_0 = 0
			local var_87_1 = 0.925

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_2 = arg_84_1:GetWordFromCfg(103031021)
				local var_87_3 = arg_84_1:FormatText(var_87_2.content)

				arg_84_1.text_.text = var_87_3

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_5 = 37 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 37)

				if (37 <= 0 and var_87_1 or var_87_1 * (utf8.len(var_87_3) / 37)) > 0 and var_87_1 < var_87_5 then
					arg_84_1.talkMaxDuration = var_87_5

					if var_87_5 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_5 + var_87_0
					end
				end

				arg_84_1.text_.text = var_87_3
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031021", "story_v_out_103031.awb") ~= 0 then
					local var_87_6 = manager.audio:GetVoiceLength("story_v_out_103031", "103031021", "story_v_out_103031.awb") / 1000

					if var_87_6 + var_87_0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_6 + var_87_0
					end

					if var_87_2.prefab_name ~= "" and arg_84_1.actors_[var_87_2.prefab_name] ~= nil then
						local var_87_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_84_1.actors_[var_87_2.prefab_name].transform, "story_v_out_103031", "103031021", "story_v_out_103031.awb")

						arg_84_1:RecordAudio("103031021", var_87_7)
						arg_84_1:RecordAudio("103031021", var_87_7)
					else
						arg_84_1:AudioAction("play", "voice", "story_v_out_103031", "103031021", "story_v_out_103031.awb")
					end

					arg_84_1:RecordHistoryTalkVoice("story_v_out_103031", "103031021", "story_v_out_103031.awb")
				end

				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_1, arg_84_1.talkMaxDuration)

			if var_87_0 <= arg_84_1.time_ and arg_84_1.time_ < var_87_0 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_0) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_0 + var_87_8 and arg_84_1.time_ < var_87_0 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play103031022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 103031022
		arg_88_1.duration_ = 5.8

		local var_88_0 = {
			ja = 5.8,
			ko = 3.6,
			zh = 3,
			en = 2.8
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
				arg_88_0:Play103031023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos4010ui_story = arg_88_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_91_0 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_0 then
				arg_88_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_0)
				arg_88_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4010ui_story"].transform.position).z)
				arg_88_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["4010ui_story"].transform.localEulerAngles = arg_88_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_0 and arg_88_1.time_ < 0 + var_91_0 + arg_91_0 then
				arg_88_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_88_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["4010ui_story"].transform.position).z)
				arg_88_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["4010ui_story"].transform.localEulerAngles = arg_88_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_91_1 = arg_88_1.actors_["1011ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1011ui_story = var_91_1.localPosition
			end

			local var_91_2 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_2 then
				var_91_1.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_2)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_2 and arg_88_1.time_ < 0 + var_91_2 + arg_91_0 then
				var_91_1.localPosition = Vector3.New(0, 100, 0)
				var_91_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_1.position).x, (manager.ui.mainCamera.transform.position - var_91_1.position).y, (manager.ui.mainCamera.transform.position - var_91_1.position).z)
				var_91_1.localEulerAngles.z = 0
				var_91_1.localEulerAngles.x = 0
				var_91_1.localEulerAngles = var_91_1.localEulerAngles
			end

			local var_91_3 = arg_88_1.actors_["1019ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_3.localPosition
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_88_1.time_ - 0) / var_91_4)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action4_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_91_5 = 0
			local var_91_6 = 0.325

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_5 + arg_91_0 then
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

				local var_91_7 = arg_88_1:GetWordFromCfg(103031022)
				local var_91_8 = arg_88_1:FormatText(var_91_7.content)

				arg_88_1.text_.text = var_91_8

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_10 = 13 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 13)

				if (13 <= 0 and var_91_6 or var_91_6 * (utf8.len(var_91_8) / 13)) > 0 and var_91_6 < var_91_10 then
					arg_88_1.talkMaxDuration = var_91_10

					if var_91_10 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_5
					end
				end

				arg_88_1.text_.text = var_91_8
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031022", "story_v_out_103031.awb") ~= 0 then
					local var_91_11 = manager.audio:GetVoiceLength("story_v_out_103031", "103031022", "story_v_out_103031.awb") / 1000

					if var_91_11 + var_91_5 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_11 + var_91_5
					end

					if var_91_7.prefab_name ~= "" and arg_88_1.actors_[var_91_7.prefab_name] ~= nil then
						local var_91_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_7.prefab_name].transform, "story_v_out_103031", "103031022", "story_v_out_103031.awb")

						arg_88_1:RecordAudio("103031022", var_91_12)
						arg_88_1:RecordAudio("103031022", var_91_12)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_103031", "103031022", "story_v_out_103031.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_103031", "103031022", "story_v_out_103031.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_13 = math.max(var_91_6, arg_88_1.talkMaxDuration)

			if var_91_5 <= arg_88_1.time_ and arg_88_1.time_ < var_91_5 + var_91_13 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_5) / var_91_13

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_5 + var_91_13 and arg_88_1.time_ < var_91_5 + var_91_13 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
	Play103031023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 103031023
		arg_92_1.duration_ = 5.13

		local var_92_0 = {
			ja = 5.133,
			ko = 3.466,
			zh = 3.6,
			en = 3.066
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
				arg_92_0:Play103031024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["4010ui_story"]) and arg_92_1.var_.characterEffect4010ui_story == nil then
				arg_92_1.var_.characterEffect4010ui_story = arg_92_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["4010ui_story"]) then
				if arg_92_1.var_.characterEffect4010ui_story and not isNil(arg_92_1.actors_["4010ui_story"]) then
					arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["4010ui_story"]) and arg_92_1.var_.characterEffect4010ui_story then
				arg_92_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_95_2 = arg_92_1.actors_["1019ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1019ui_story == nil then
				arg_92_1.var_.characterEffect1019ui_story = var_95_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_3 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_3 and not isNil(var_95_2) then
				if arg_92_1.var_.characterEffect1019ui_story and not isNil(var_95_2) then
					arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_3)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_3 and arg_92_1.time_ < 0 + var_95_3 + arg_95_0 and not isNil(var_95_2) and arg_92_1.var_.characterEffect1019ui_story then
				arg_92_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_95_4 = arg_92_1.actors_["1019ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1019ui_story = var_95_4.localPosition
			end

			local var_95_5 = 0.5

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_5 then
				var_95_4.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_92_1.time_ - 0) / var_95_5)
				var_95_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_4.position).x, (manager.ui.mainCamera.transform.position - var_95_4.position).y, (manager.ui.mainCamera.transform.position - var_95_4.position).z)
				var_95_4.localEulerAngles.z = 0
				var_95_4.localEulerAngles.x = 0
				var_95_4.localEulerAngles = var_95_4.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_5 and arg_92_1.time_ < 0 + var_95_5 + arg_95_0 then
				var_95_4.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_95_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_4.position).x, (manager.ui.mainCamera.transform.position - var_95_4.position).y, (manager.ui.mainCamera.transform.position - var_95_4.position).z)
				var_95_4.localEulerAngles.z = 0
				var_95_4.localEulerAngles.x = 0
				var_95_4.localEulerAngles = var_95_4.localEulerAngles
			end

			local var_95_6 = arg_92_1.actors_["4010ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos4010ui_story = var_95_6.localPosition
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_6.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos4010ui_story, Vector3.New(0.7, -1.59, -5.2), (arg_92_1.time_ - 0) / var_95_7)
				var_95_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_6.position).x, (manager.ui.mainCamera.transform.position - var_95_6.position).y, (manager.ui.mainCamera.transform.position - var_95_6.position).z)
				var_95_6.localEulerAngles.z = 0
				var_95_6.localEulerAngles.x = 0
				var_95_6.localEulerAngles = var_95_6.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_6.localPosition = Vector3.New(0.7, -1.59, -5.2)
				var_95_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_6.position).x, (manager.ui.mainCamera.transform.position - var_95_6.position).y, (manager.ui.mainCamera.transform.position - var_95_6.position).z)
				var_95_6.localEulerAngles.z = 0
				var_95_6.localEulerAngles.x = 0
				var_95_6.localEulerAngles = var_95_6.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_95_8 = 0
			local var_95_9 = 0.275

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(103031023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 11 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 11)

				if (11 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 11)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031023", "story_v_out_103031.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_103031", "103031023", "story_v_out_103031.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_103031", "103031023", "story_v_out_103031.awb")

						arg_92_1:RecordAudio("103031023", var_95_15)
						arg_92_1:RecordAudio("103031023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_103031", "103031023", "story_v_out_103031.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_103031", "103031023", "story_v_out_103031.awb")
				end

				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_16 = math.max(var_95_9, arg_92_1.talkMaxDuration)

			if var_95_8 <= arg_92_1.time_ and arg_92_1.time_ < var_95_8 + var_95_16 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_8) / var_95_16

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_8 + var_95_16 and arg_92_1.time_ < var_95_8 + var_95_16 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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

		arg_92_1:InitPlayNodeList()
	end,
	Play103031024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 103031024
		arg_96_1.duration_ = 7.7

		local var_96_0 = {
			ja = 7.7,
			ko = 5.4,
			zh = 5.633,
			en = 7.233
		}
		local var_96_1 = manager.audio:GetLocalizationFlag()

		if var_96_0[var_96_1] ~= nil then
			arg_96_1.duration_ = var_96_0[var_96_1]
		end

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play103031025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(arg_96_1.actors_["3008ui_story"]) and arg_96_1.var_.characterEffect3008ui_story == nil then
				arg_96_1.var_.characterEffect3008ui_story = arg_96_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_0 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_0 and not isNil(arg_96_1.actors_["3008ui_story"]) then
				if arg_96_1.var_.characterEffect3008ui_story and not isNil(arg_96_1.actors_["3008ui_story"]) then
					arg_96_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_0 and arg_96_1.time_ < 0 + var_99_0 + arg_99_0 and not isNil(arg_96_1.actors_["3008ui_story"]) and arg_96_1.var_.characterEffect3008ui_story then
				arg_96_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_99_2 = arg_96_1.actors_["4010ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect4010ui_story == nil then
				arg_96_1.var_.characterEffect4010ui_story = var_99_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_3 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_3 and not isNil(var_99_2) then
				if arg_96_1.var_.characterEffect4010ui_story and not isNil(var_99_2) then
					arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_96_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_3)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_3 and arg_96_1.time_ < 0 + var_99_3 + arg_99_0 and not isNil(var_99_2) and arg_96_1.var_.characterEffect4010ui_story then
				arg_96_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_96_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_99_4 = 0
			local var_99_5 = 0.575

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_4 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, true)
				arg_96_1.iconController_:SetSelectedState("hero")

				arg_96_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3008")

				arg_96_1.callingController_:SetSelectedState("normal")

				arg_96_1.keyicon_.color = Color.New(1, 1, 1)
				arg_96_1.icon_.color = Color.New(1, 1, 1)

				local var_99_6 = arg_96_1:GetWordFromCfg(103031024)
				local var_99_7 = arg_96_1:FormatText(var_99_6.content)

				arg_96_1.text_.text = var_99_7

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_9 = 23 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 23)

				if (23 <= 0 and var_99_5 or var_99_5 * (utf8.len(var_99_7) / 23)) > 0 and var_99_5 < var_99_9 then
					arg_96_1.talkMaxDuration = var_99_9

					if var_99_9 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_9 + var_99_4
					end
				end

				arg_96_1.text_.text = var_99_7
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031024", "story_v_out_103031.awb") ~= 0 then
					local var_99_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031024", "story_v_out_103031.awb") / 1000

					if var_99_10 + var_99_4 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_10 + var_99_4
					end

					if var_99_6.prefab_name ~= "" and arg_96_1.actors_[var_99_6.prefab_name] ~= nil then
						local var_99_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_6.prefab_name].transform, "story_v_out_103031", "103031024", "story_v_out_103031.awb")

						arg_96_1:RecordAudio("103031024", var_99_11)
						arg_96_1:RecordAudio("103031024", var_99_11)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_103031", "103031024", "story_v_out_103031.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_103031", "103031024", "story_v_out_103031.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_12 = math.max(var_99_5, arg_96_1.talkMaxDuration)

			if var_99_4 <= arg_96_1.time_ and arg_96_1.time_ < var_99_4 + var_99_12 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_4) / var_99_12

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_4 + var_99_12 and arg_96_1.time_ < var_99_4 + var_99_12 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {}

		arg_96_1:InitPlayNodeList()
	end,
	Play103031025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 103031025
		arg_100_1.duration_ = 6.07

		local var_100_0 = {
			ja = 6.066,
			ko = 3.633,
			zh = 2.833,
			en = 2.7
		}
		local var_100_1 = manager.audio:GetLocalizationFlag()

		if var_100_0[var_100_1] ~= nil then
			arg_100_1.duration_ = var_100_0[var_100_1]
		end

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play103031026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story == nil then
				arg_100_1.var_.characterEffect1019ui_story = arg_100_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) then
				if arg_100_1.var_.characterEffect1019ui_story and not isNil(arg_100_1.actors_["1019ui_story"]) then
					arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["1019ui_story"]) and arg_100_1.var_.characterEffect1019ui_story then
				arg_100_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["3008ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect3008ui_story == nil then
				arg_100_1.var_.characterEffect3008ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect3008ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_100_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect3008ui_story then
				arg_100_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_100_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action445")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_103_4 = 0
			local var_103_5 = 0.375

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(103031025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 15 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 15)

				if (15 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 15)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031025", "story_v_out_103031.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031025", "story_v_out_103031.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_103031", "103031025", "story_v_out_103031.awb")

						arg_100_1:RecordAudio("103031025", var_103_11)
						arg_100_1:RecordAudio("103031025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_103031", "103031025", "story_v_out_103031.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_103031", "103031025", "story_v_out_103031.awb")
				end

				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_12 = math.max(var_103_5, arg_100_1.talkMaxDuration)

			if var_103_4 <= arg_100_1.time_ and arg_100_1.time_ < var_103_4 + var_103_12 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_4) / var_103_12

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_4 + var_103_12 and arg_100_1.time_ < var_103_4 + var_103_12 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play103031026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 103031026
		arg_104_1.duration_ = 5.1

		local var_104_0 = {
			ja = 4.7,
			ko = 3.966,
			zh = 3.6,
			en = 5.1
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
				arg_104_0:Play103031027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["4010ui_story"]) and arg_104_1.var_.characterEffect4010ui_story == nil then
				arg_104_1.var_.characterEffect4010ui_story = arg_104_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["4010ui_story"]) then
				if arg_104_1.var_.characterEffect4010ui_story and not isNil(arg_104_1.actors_["4010ui_story"]) then
					arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["4010ui_story"]) and arg_104_1.var_.characterEffect4010ui_story then
				arg_104_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["1019ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1019ui_story == nil then
				arg_104_1.var_.characterEffect1019ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect1019ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_104_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect1019ui_story then
				arg_104_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_104_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_107_4 = 0
			local var_107_5 = 0.35

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(103031026)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 14 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 14)

				if (14 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 14)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031026", "story_v_out_103031.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031026", "story_v_out_103031.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_103031", "103031026", "story_v_out_103031.awb")

						arg_104_1:RecordAudio("103031026", var_107_11)
						arg_104_1:RecordAudio("103031026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_103031", "103031026", "story_v_out_103031.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_103031", "103031026", "story_v_out_103031.awb")
				end

				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_12 = math.max(var_107_5, arg_104_1.talkMaxDuration)

			if var_107_4 <= arg_104_1.time_ and arg_104_1.time_ < var_107_4 + var_107_12 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - var_107_4) / var_107_12

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= var_107_4 + var_107_12 and arg_104_1.time_ < var_107_4 + var_107_12 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play103031027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 103031027
		arg_108_1.duration_ = 1.07

		local var_108_0 = {
			ja = 1.066,
			ko = 1,
			zh = 0.999999999999,
			en = 0.999999999999
		}
		local var_108_1 = manager.audio:GetLocalizationFlag()

		if var_108_0[var_108_1] ~= nil then
			arg_108_1.duration_ = var_108_0[var_108_1]
		end

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play103031028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["1019ui_story"]) and arg_108_1.var_.characterEffect1019ui_story == nil then
				arg_108_1.var_.characterEffect1019ui_story = arg_108_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["1019ui_story"]) then
				if arg_108_1.var_.characterEffect1019ui_story and not isNil(arg_108_1.actors_["1019ui_story"]) then
					arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["1019ui_story"]) and arg_108_1.var_.characterEffect1019ui_story then
				arg_108_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["4010ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect4010ui_story == nil then
				arg_108_1.var_.characterEffect4010ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect4010ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_108_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect4010ui_story then
				arg_108_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_108_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_111_4 = 0
			local var_111_5 = 0.05

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(103031027)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 2 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 2)

				if (2 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 2)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031027", "story_v_out_103031.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_103031", "103031027", "story_v_out_103031.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_103031", "103031027", "story_v_out_103031.awb")

						arg_108_1:RecordAudio("103031027", var_111_11)
						arg_108_1:RecordAudio("103031027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_103031", "103031027", "story_v_out_103031.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_103031", "103031027", "story_v_out_103031.awb")
				end

				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_12 = math.max(var_111_5, arg_108_1.talkMaxDuration)

			if var_111_4 <= arg_108_1.time_ and arg_108_1.time_ < var_111_4 + var_111_12 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_4) / var_111_12

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_4 + var_111_12 and arg_108_1.time_ < var_111_4 + var_111_12 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {}

		arg_108_1:InitPlayNodeList()
	end,
	Play103031028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 103031028
		arg_112_1.duration_ = 4.87

		local var_112_0 = {
			ja = 4.7,
			ko = 4,
			zh = 4.2,
			en = 4.866
		}
		local var_112_1 = manager.audio:GetLocalizationFlag()

		if var_112_0[var_112_1] ~= nil then
			arg_112_1.duration_ = var_112_0[var_112_1]
		end

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play103031029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if arg_112_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_115_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_112_1.stage_.transform)

				var_115_0.name = "2020_tpose"
				var_115_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_112_1.actors_["2020_tpose"] = var_115_0

				local var_115_1 = var_115_0:GetComponentInChildren(typeof(CharacterEffect))

				var_115_1.enabled = true

				local var_115_2 = GameObjectTools.GetOrAddComponent(var_115_0, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(false)
				end

				arg_112_1:ShowWeapon(var_115_1.transform, false)

				arg_112_1.var_["2020_tpose" .. "Animator"] = var_115_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_112_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_112_1.var_["2020_tpose" .. "LipSync"] = var_115_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_115_3 = arg_112_1.actors_["2020_tpose"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect2020_tpose == nil then
				arg_112_1.var_.characterEffect2020_tpose = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect2020_tpose and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect2020_tpose then
				arg_112_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_115_6 = arg_112_1.actors_["1019ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1019ui_story == nil then
				arg_112_1.var_.characterEffect1019ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 and not isNil(var_115_6) then
				if arg_112_1.var_.characterEffect1019ui_story and not isNil(var_115_6) then
					arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_7)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1019ui_story then
				arg_112_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_115_8 = arg_112_1.actors_["1019ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos1019ui_story = var_115_8.localPosition
			end

			local var_115_9 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_9 then
				var_115_8.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_9)
				var_115_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_8.position).x, (manager.ui.mainCamera.transform.position - var_115_8.position).y, (manager.ui.mainCamera.transform.position - var_115_8.position).z)
				var_115_8.localEulerAngles.z = 0
				var_115_8.localEulerAngles.x = 0
				var_115_8.localEulerAngles = var_115_8.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_9 and arg_112_1.time_ < 0 + var_115_9 + arg_115_0 then
				var_115_8.localPosition = Vector3.New(0, 100, 0)
				var_115_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_8.position).x, (manager.ui.mainCamera.transform.position - var_115_8.position).y, (manager.ui.mainCamera.transform.position - var_115_8.position).z)
				var_115_8.localEulerAngles.z = 0
				var_115_8.localEulerAngles.x = 0
				var_115_8.localEulerAngles = var_115_8.localEulerAngles
			end

			local var_115_10 = arg_112_1.actors_["4010ui_story"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos4010ui_story = var_115_10.localPosition
			end

			local var_115_11 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_11 then
				var_115_10.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_112_1.time_ - 0) / var_115_11)
				var_115_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_10.position).x, (manager.ui.mainCamera.transform.position - var_115_10.position).y, (manager.ui.mainCamera.transform.position - var_115_10.position).z)
				var_115_10.localEulerAngles.z = 0
				var_115_10.localEulerAngles.x = 0
				var_115_10.localEulerAngles = var_115_10.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_11 and arg_112_1.time_ < 0 + var_115_11 + arg_115_0 then
				var_115_10.localPosition = Vector3.New(0, 100, 0)
				var_115_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_10.position).x, (manager.ui.mainCamera.transform.position - var_115_10.position).y, (manager.ui.mainCamera.transform.position - var_115_10.position).z)
				var_115_10.localEulerAngles.z = 0
				var_115_10.localEulerAngles.x = 0
				var_115_10.localEulerAngles = var_115_10.localEulerAngles
			end

			local var_115_12 = arg_112_1.actors_["2020_tpose"].transform

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos2020_tpose = var_115_12.localPosition

				local var_115_13 = GameObjectTools.GetOrAddComponent(var_115_12.gameObject, typeof(DynamicBoneHelper))

				if var_115_13 then
					var_115_13:EnableDynamicBone(false)
				end
			end

			local var_115_14 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_14 then
				var_115_12.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (arg_112_1.time_ - 0) / var_115_14)
				var_115_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_12.position).x, (manager.ui.mainCamera.transform.position - var_115_12.position).y, (manager.ui.mainCamera.transform.position - var_115_12.position).z)
				var_115_12.localEulerAngles.z = 0
				var_115_12.localEulerAngles.x = 0
				var_115_12.localEulerAngles = var_115_12.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_14 and arg_112_1.time_ < 0 + var_115_14 + arg_115_0 then
				var_115_12.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				var_115_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_115_12.position).x, (manager.ui.mainCamera.transform.position - var_115_12.position).y, (manager.ui.mainCamera.transform.position - var_115_12.position).z)
				var_115_12.localEulerAngles.z = 0
				var_115_12.localEulerAngles.x = 0
				var_115_12.localEulerAngles = var_115_12.localEulerAngles

				local var_115_15 = GameObjectTools.GetOrAddComponent(var_115_12.gameObject, typeof(DynamicBoneHelper))

				if var_115_15 then
					var_115_15:EnableDynamicBone(true)
				end
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_115_16 = 0
			local var_115_17 = 0.45

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_16 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_18 = arg_112_1:GetWordFromCfg(103031028)
				local var_115_19 = arg_112_1:FormatText(var_115_18.content)

				arg_112_1.text_.text = var_115_19

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_21 = 18 <= 0 and var_115_17 or var_115_17 * (utf8.len(var_115_19) / 18)

				if (18 <= 0 and var_115_17 or var_115_17 * (utf8.len(var_115_19) / 18)) > 0 and var_115_17 < var_115_21 then
					arg_112_1.talkMaxDuration = var_115_21

					if var_115_21 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_21 + var_115_16
					end
				end

				arg_112_1.text_.text = var_115_19
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031028", "story_v_out_103031.awb") ~= 0 then
					local var_115_22 = manager.audio:GetVoiceLength("story_v_out_103031", "103031028", "story_v_out_103031.awb") / 1000

					if var_115_22 + var_115_16 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_22 + var_115_16
					end

					if var_115_18.prefab_name ~= "" and arg_112_1.actors_[var_115_18.prefab_name] ~= nil then
						local var_115_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_18.prefab_name].transform, "story_v_out_103031", "103031028", "story_v_out_103031.awb")

						arg_112_1:RecordAudio("103031028", var_115_23)
						arg_112_1:RecordAudio("103031028", var_115_23)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_103031", "103031028", "story_v_out_103031.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_103031", "103031028", "story_v_out_103031.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_24 = math.max(var_115_17, arg_112_1.talkMaxDuration)

			if var_115_16 <= arg_112_1.time_ and arg_112_1.time_ < var_115_16 + var_115_24 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_16) / var_115_24

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_16 + var_115_24 and arg_112_1.time_ < var_115_16 + var_115_24 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play103031029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 103031029
		arg_116_1.duration_ = 4.27

		local var_116_0 = {
			ja = 3.166,
			ko = 4,
			zh = 4.133,
			en = 4.266
		}
		local var_116_1 = manager.audio:GetLocalizationFlag()

		if var_116_0[var_116_1] ~= nil then
			arg_116_1.duration_ = var_116_0[var_116_1]
		end

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play103031030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if arg_116_1.actors_["2030_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2030_tpose"))) then
				local var_119_0 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_116_1.stage_.transform)

				var_119_0.name = "2030_tpose"
				var_119_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["2030_tpose"] = var_119_0

				local var_119_1 = var_119_0:GetComponentInChildren(typeof(CharacterEffect))

				var_119_1.enabled = true

				local var_119_2 = GameObjectTools.GetOrAddComponent(var_119_0, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(false)
				end

				arg_116_1:ShowWeapon(var_119_1.transform, false)

				arg_116_1.var_["2030_tpose" .. "Animator"] = var_119_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_116_1.var_["2030_tpose" .. "Animator"].applyRootMotion = true
				arg_116_1.var_["2030_tpose" .. "LipSync"] = var_119_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_119_3 = arg_116_1.actors_["2030_tpose"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect2030_tpose == nil then
				arg_116_1.var_.characterEffect2030_tpose = var_119_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_4 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_4 and not isNil(var_119_3) then
				if arg_116_1.var_.characterEffect2030_tpose and not isNil(var_119_3) then
					arg_116_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_4 and arg_116_1.time_ < 0 + var_119_4 + arg_119_0 and not isNil(var_119_3) and arg_116_1.var_.characterEffect2030_tpose then
				arg_116_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_119_6 = arg_116_1.actors_["2020_tpose"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect2020_tpose == nil then
				arg_116_1.var_.characterEffect2020_tpose = var_119_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_7 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 and not isNil(var_119_6) then
				if arg_116_1.var_.characterEffect2020_tpose and not isNil(var_119_6) then
					arg_116_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_116_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_7)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 and not isNil(var_119_6) and arg_116_1.var_.characterEffect2020_tpose then
				arg_116_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_116_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_119_8 = arg_116_1.actors_["2030_tpose"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos2030_tpose = var_119_8.localPosition

				local var_119_9 = GameObjectTools.GetOrAddComponent(var_119_8.gameObject, typeof(DynamicBoneHelper))

				if var_119_9 then
					var_119_9:EnableDynamicBone(false)
				end
			end

			local var_119_10 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_10 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos2030_tpose, Vector3.New(0.7, -1.2, -4.2), (arg_116_1.time_ - 0) / var_119_10)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_10 and arg_116_1.time_ < 0 + var_119_10 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0.7, -1.2, -4.2)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles

				local var_119_11 = GameObjectTools.GetOrAddComponent(var_119_8.gameObject, typeof(DynamicBoneHelper))

				if var_119_11 then
					var_119_11:EnableDynamicBone(true)
				end
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_119_12 = 0
			local var_119_13 = 0.5

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_12 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[34].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_14 = arg_116_1:GetWordFromCfg(103031029)
				local var_119_15 = arg_116_1:FormatText(var_119_14.content)

				arg_116_1.text_.text = var_119_15

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_17 = 20 <= 0 and var_119_13 or var_119_13 * (utf8.len(var_119_15) / 20)

				if (20 <= 0 and var_119_13 or var_119_13 * (utf8.len(var_119_15) / 20)) > 0 and var_119_13 < var_119_17 then
					arg_116_1.talkMaxDuration = var_119_17

					if var_119_17 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_17 + var_119_12
					end
				end

				arg_116_1.text_.text = var_119_15
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031029", "story_v_out_103031.awb") ~= 0 then
					local var_119_18 = manager.audio:GetVoiceLength("story_v_out_103031", "103031029", "story_v_out_103031.awb") / 1000

					if var_119_18 + var_119_12 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_18 + var_119_12
					end

					if var_119_14.prefab_name ~= "" and arg_116_1.actors_[var_119_14.prefab_name] ~= nil then
						local var_119_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_14.prefab_name].transform, "story_v_out_103031", "103031029", "story_v_out_103031.awb")

						arg_116_1:RecordAudio("103031029", var_119_19)
						arg_116_1:RecordAudio("103031029", var_119_19)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_103031", "103031029", "story_v_out_103031.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_103031", "103031029", "story_v_out_103031.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_20 = math.max(var_119_13, arg_116_1.talkMaxDuration)

			if var_119_12 <= arg_116_1.time_ and arg_116_1.time_ < var_119_12 + var_119_20 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_12) / var_119_20

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_12 + var_119_20 and arg_116_1.time_ < var_119_12 + var_119_20 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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

		arg_116_1:InitPlayNodeList()
	end,
	Play103031030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 103031030
		arg_120_1.duration_ = 7.83

		local var_120_0 = {
			ja = 7.833,
			ko = 5.666,
			zh = 6.3,
			en = 5.366
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
				arg_120_0:Play103031031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["4010ui_story"]) and arg_120_1.var_.characterEffect4010ui_story == nil then
				arg_120_1.var_.characterEffect4010ui_story = arg_120_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["4010ui_story"]) then
				if arg_120_1.var_.characterEffect4010ui_story and not isNil(arg_120_1.actors_["4010ui_story"]) then
					arg_120_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["4010ui_story"]) and arg_120_1.var_.characterEffect4010ui_story then
				arg_120_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_123_2 = arg_120_1.actors_["2030_tpose"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect2030_tpose == nil then
				arg_120_1.var_.characterEffect2030_tpose = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_3 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.characterEffect2030_tpose and not isNil(var_123_2) then
					arg_120_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_120_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_3)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect2030_tpose then
				arg_120_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_120_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_123_4 = arg_120_1.actors_["2030_tpose"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos2030_tpose = var_123_4.localPosition

				local var_123_5 = GameObjectTools.GetOrAddComponent(var_123_4.gameObject, typeof(DynamicBoneHelper))

				if var_123_5 then
					var_123_5:EnableDynamicBone(false)
				end
			end

			local var_123_6 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_6 then
				var_123_4.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_6)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_6 and arg_120_1.time_ < 0 + var_123_6 + arg_123_0 then
				var_123_4.localPosition = Vector3.New(0, 100, 0)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles

				local var_123_7 = GameObjectTools.GetOrAddComponent(var_123_4.gameObject, typeof(DynamicBoneHelper))

				if var_123_7 then
					var_123_7:EnableDynamicBone(true)
				end
			end

			local var_123_8 = arg_120_1.actors_["2020_tpose"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos2020_tpose = var_123_8.localPosition

				local var_123_9 = GameObjectTools.GetOrAddComponent(var_123_8.gameObject, typeof(DynamicBoneHelper))

				if var_123_9 then
					var_123_9:EnableDynamicBone(false)
				end
			end

			local var_123_10 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_10 then
				var_123_8.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_10)
				var_123_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_8.position).x, (manager.ui.mainCamera.transform.position - var_123_8.position).y, (manager.ui.mainCamera.transform.position - var_123_8.position).z)
				var_123_8.localEulerAngles.z = 0
				var_123_8.localEulerAngles.x = 0
				var_123_8.localEulerAngles = var_123_8.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_10 and arg_120_1.time_ < 0 + var_123_10 + arg_123_0 then
				var_123_8.localPosition = Vector3.New(0, 100, 0)
				var_123_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_8.position).x, (manager.ui.mainCamera.transform.position - var_123_8.position).y, (manager.ui.mainCamera.transform.position - var_123_8.position).z)
				var_123_8.localEulerAngles.z = 0
				var_123_8.localEulerAngles.x = 0
				var_123_8.localEulerAngles = var_123_8.localEulerAngles

				local var_123_11 = GameObjectTools.GetOrAddComponent(var_123_8.gameObject, typeof(DynamicBoneHelper))

				if var_123_11 then
					var_123_11:EnableDynamicBone(true)
				end
			end

			local var_123_12 = arg_120_1.actors_["4010ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos4010ui_story = var_123_12.localPosition
			end

			local var_123_13 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_13 then
				var_123_12.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_120_1.time_ - 0) / var_123_13)
				var_123_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_12.position).x, (manager.ui.mainCamera.transform.position - var_123_12.position).y, (manager.ui.mainCamera.transform.position - var_123_12.position).z)
				var_123_12.localEulerAngles.z = 0
				var_123_12.localEulerAngles.x = 0
				var_123_12.localEulerAngles = var_123_12.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_13 and arg_120_1.time_ < 0 + var_123_13 + arg_123_0 then
				var_123_12.localPosition = Vector3.New(0, -1.59, -5.2)
				var_123_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_12.position).x, (manager.ui.mainCamera.transform.position - var_123_12.position).y, (manager.ui.mainCamera.transform.position - var_123_12.position).z)
				var_123_12.localEulerAngles.z = 0
				var_123_12.localEulerAngles.x = 0
				var_123_12.localEulerAngles = var_123_12.localEulerAngles
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_123_14 = 0
			local var_123_15 = 0.575

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_14 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_16 = arg_120_1:GetWordFromCfg(103031030)
				local var_123_17 = arg_120_1:FormatText(var_123_16.content)

				arg_120_1.text_.text = var_123_17

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_19 = 23 <= 0 and var_123_15 or var_123_15 * (utf8.len(var_123_17) / 23)

				if (23 <= 0 and var_123_15 or var_123_15 * (utf8.len(var_123_17) / 23)) > 0 and var_123_15 < var_123_19 then
					arg_120_1.talkMaxDuration = var_123_19

					if var_123_19 + var_123_14 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_19 + var_123_14
					end
				end

				arg_120_1.text_.text = var_123_17
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031030", "story_v_out_103031.awb") ~= 0 then
					local var_123_20 = manager.audio:GetVoiceLength("story_v_out_103031", "103031030", "story_v_out_103031.awb") / 1000

					if var_123_20 + var_123_14 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_20 + var_123_14
					end

					if var_123_16.prefab_name ~= "" and arg_120_1.actors_[var_123_16.prefab_name] ~= nil then
						local var_123_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_16.prefab_name].transform, "story_v_out_103031", "103031030", "story_v_out_103031.awb")

						arg_120_1:RecordAudio("103031030", var_123_21)
						arg_120_1:RecordAudio("103031030", var_123_21)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_103031", "103031030", "story_v_out_103031.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_103031", "103031030", "story_v_out_103031.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_22 = math.max(var_123_15, arg_120_1.talkMaxDuration)

			if var_123_14 <= arg_120_1.time_ and arg_120_1.time_ < var_123_14 + var_123_22 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_14) / var_123_22

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_14 + var_123_22 and arg_120_1.time_ < var_123_14 + var_123_22 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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

		arg_120_1:InitPlayNodeList()
	end,
	Play103031031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 103031031
		arg_124_1.duration_ = 6.73

		local var_124_0 = {
			ja = 6.733,
			ko = 5.066,
			zh = 6.066,
			en = 6.433
		}
		local var_124_1 = manager.audio:GetLocalizationFlag()

		if var_124_0[var_124_1] ~= nil then
			arg_124_1.duration_ = var_124_0[var_124_1]
		end

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
			arg_124_1.auto_ = false
		end

		function arg_124_1.playNext_(arg_126_0)
			arg_124_1.onStoryFinished_()
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["1011ui_story"]) and arg_124_1.var_.characterEffect1011ui_story == nil then
				arg_124_1.var_.characterEffect1011ui_story = arg_124_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["1011ui_story"]) then
				if arg_124_1.var_.characterEffect1011ui_story and not isNil(arg_124_1.actors_["1011ui_story"]) then
					arg_124_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["1011ui_story"]) and arg_124_1.var_.characterEffect1011ui_story then
				arg_124_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_127_2 = arg_124_1.actors_["4010ui_story"]

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect4010ui_story == nil then
				arg_124_1.var_.characterEffect4010ui_story = var_127_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_3 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_3 and not isNil(var_127_2) then
				if arg_124_1.var_.characterEffect4010ui_story and not isNil(var_127_2) then
					arg_124_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_124_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_3)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_3 and arg_124_1.time_ < 0 + var_127_3 + arg_127_0 and not isNil(var_127_2) and arg_124_1.var_.characterEffect4010ui_story then
				arg_124_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_124_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_127_4 = arg_124_1.actors_["4010ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos4010ui_story = var_127_4.localPosition
			end

			local var_127_5 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_5 then
				var_127_4.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_5)
				var_127_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_4.position).x, (manager.ui.mainCamera.transform.position - var_127_4.position).y, (manager.ui.mainCamera.transform.position - var_127_4.position).z)
				var_127_4.localEulerAngles.z = 0
				var_127_4.localEulerAngles.x = 0
				var_127_4.localEulerAngles = var_127_4.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_5 and arg_124_1.time_ < 0 + var_127_5 + arg_127_0 then
				var_127_4.localPosition = Vector3.New(0, 100, 0)
				var_127_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_4.position).x, (manager.ui.mainCamera.transform.position - var_127_4.position).y, (manager.ui.mainCamera.transform.position - var_127_4.position).z)
				var_127_4.localEulerAngles.z = 0
				var_127_4.localEulerAngles.x = 0
				var_127_4.localEulerAngles = var_127_4.localEulerAngles
			end

			local var_127_6 = arg_124_1.actors_["1011ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos1011ui_story = var_127_6.localPosition
			end

			local var_127_7 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_7 then
				var_127_6.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_124_1.time_ - 0) / var_127_7)
				var_127_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_6.position).x, (manager.ui.mainCamera.transform.position - var_127_6.position).y, (manager.ui.mainCamera.transform.position - var_127_6.position).z)
				var_127_6.localEulerAngles.z = 0
				var_127_6.localEulerAngles.x = 0
				var_127_6.localEulerAngles = var_127_6.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_7 and arg_124_1.time_ < 0 + var_127_7 + arg_127_0 then
				var_127_6.localPosition = Vector3.New(0, -0.71, -6)
				var_127_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_6.position).x, (manager.ui.mainCamera.transform.position - var_127_6.position).y, (manager.ui.mainCamera.transform.position - var_127_6.position).z)
				var_127_6.localEulerAngles.z = 0
				var_127_6.localEulerAngles.x = 0
				var_127_6.localEulerAngles = var_127_6.localEulerAngles
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_127_8 = 0
			local var_127_9 = 0.55

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_8 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, true)

				arg_124_1.leftNameTxt_.text = arg_124_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_124_1.leftNameTxt_.transform)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1.leftNameTxt_.text)
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_10 = arg_124_1:GetWordFromCfg(103031031)
				local var_127_11 = arg_124_1:FormatText(var_127_10.content)

				arg_124_1.text_.text = var_127_11

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_13 = 22 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 22)

				if (22 <= 0 and var_127_9 or var_127_9 * (utf8.len(var_127_11) / 22)) > 0 and var_127_9 < var_127_13 then
					arg_124_1.talkMaxDuration = var_127_13

					if var_127_13 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_13 + var_127_8
					end
				end

				arg_124_1.text_.text = var_127_11
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103031", "103031031", "story_v_out_103031.awb") ~= 0 then
					local var_127_14 = manager.audio:GetVoiceLength("story_v_out_103031", "103031031", "story_v_out_103031.awb") / 1000

					if var_127_14 + var_127_8 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_14 + var_127_8
					end

					if var_127_10.prefab_name ~= "" and arg_124_1.actors_[var_127_10.prefab_name] ~= nil then
						local var_127_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_124_1.actors_[var_127_10.prefab_name].transform, "story_v_out_103031", "103031031", "story_v_out_103031.awb")

						arg_124_1:RecordAudio("103031031", var_127_15)
						arg_124_1:RecordAudio("103031031", var_127_15)
					else
						arg_124_1:AudioAction("play", "voice", "story_v_out_103031", "103031031", "story_v_out_103031.awb")
					end

					arg_124_1:RecordHistoryTalkVoice("story_v_out_103031", "103031031", "story_v_out_103031.awb")
				end

				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_16 = math.max(var_127_9, arg_124_1.talkMaxDuration)

			if var_127_8 <= arg_124_1.time_ and arg_124_1.time_ < var_127_8 + var_127_16 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_8) / var_127_16

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_8 + var_127_16 and arg_124_1.time_ < var_127_8 + var_127_16 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_124_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_103031.awb"
	}
}
