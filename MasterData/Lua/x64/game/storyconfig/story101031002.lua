return {
	Play103102001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 103102001
		arg_1_1.duration_ = 9.2

		local var_1_0 = {
			ja = 9.2,
			ko = 6.7,
			zh = 6.6,
			en = 6.033
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
				arg_1_0:Play103102002(arg_1_1)
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect4010ui_story == nil then
				arg_1_1.var_.characterEffect4010ui_story = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect4010ui_story and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect4010ui_story then
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

			local var_4_15 = "B03d"

			if arg_1_1.bgs_.B03d == nil then
				local var_4_16 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_16:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_15)
				var_4_16.name = var_4_15
				var_4_16.transform.parent = arg_1_1.stage_.transform
				var_4_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_15] = var_4_16
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_17 = arg_1_1.bgs_.B03d

				arg_1_1.bgs_.B03d.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_18 = var_4_17:GetComponent("SpriteRenderer")

				if var_4_18 and var_4_18.sprite then
					local var_4_19 = 2 * (var_4_17.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_17.transform.localScale = Vector3.New(var_4_19 / var_4_18.sprite.bounds.size.y < var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x and var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x or var_4_19 / var_4_18.sprite.bounds.size.y, var_4_19 / var_4_18.sprite.bounds.size.y < var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x and var_4_19 * manager.ui.mainCameraCom_.aspect / var_4_18.sprite.bounds.size.x or var_4_19 / var_4_18.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B03d" then
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

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_22 = 2
			local var_4_23 = 0.475

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

				local var_4_25 = arg_1_1:GetWordFromCfg(103102001)
				local var_4_26 = arg_1_1:FormatText(var_4_25.content)

				arg_1_1.text_.text = var_4_26

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_28 = 19 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 19)

				if (19 <= 0 and var_4_23 or var_4_23 * (utf8.len(var_4_26) / 19)) > 0 and var_4_23 < var_4_28 then
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

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102001", "story_v_out_103102.awb") ~= 0 then
					local var_4_29 = manager.audio:GetVoiceLength("story_v_out_103102", "103102001", "story_v_out_103102.awb") / 1000

					if var_4_29 + var_4_22 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_29 + var_4_22
					end

					if var_4_25.prefab_name ~= "" and arg_1_1.actors_[var_4_25.prefab_name] ~= nil then
						local var_4_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_25.prefab_name].transform, "story_v_out_103102", "103102001", "story_v_out_103102.awb")

						arg_1_1:RecordAudio("103102001", var_4_30)
						arg_1_1:RecordAudio("103102001", var_4_30)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_103102", "103102001", "story_v_out_103102.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_103102", "103102001", "story_v_out_103102.awb")
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
	Play103102002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 103102002
		arg_8_1.duration_ = 2

		SetActive(arg_8_1.tipsGo_, false)

		function arg_8_1.onSingleLineFinish_()
			arg_8_1.onSingleLineUpdate_ = nil
			arg_8_1.onSingleLineFinish_ = nil
			arg_8_1.state_ = "waiting"
		end

		function arg_8_1.playNext_(arg_10_0)
			if arg_10_0 == 1 then
				arg_8_0:Play103102003(arg_8_1)
			end
		end

		function arg_8_1.onSingleLineUpdate_(arg_11_0)
			if arg_8_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_11_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_8_1.stage_.transform)

				var_11_0.name = "1084ui_story"
				var_11_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_8_1.actors_["1084ui_story"] = var_11_0

				local var_11_1 = var_11_0:GetComponentInChildren(typeof(CharacterEffect))

				var_11_1.enabled = true

				local var_11_2 = GameObjectTools.GetOrAddComponent(var_11_0, typeof(DynamicBoneHelper))

				if var_11_2 then
					var_11_2:EnableDynamicBone(false)
				end

				arg_8_1:ShowWeapon(var_11_1.transform, false)

				arg_8_1.var_["1084ui_story" .. "Animator"] = var_11_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_8_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_8_1.var_["1084ui_story" .. "LipSync"] = var_11_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_11_3 = arg_8_1.actors_["1084ui_story"]

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story == nil then
				arg_8_1.var_.characterEffect1084ui_story = var_11_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_11_4 = 0.1

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_4 and not isNil(var_11_3) then
				if arg_8_1.var_.characterEffect1084ui_story and not isNil(var_11_3) then
					arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_8_1.time_ >= 0 + var_11_4 and arg_8_1.time_ < 0 + var_11_4 + arg_11_0 and not isNil(var_11_3) and arg_8_1.var_.characterEffect1084ui_story then
				arg_8_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_11_6 = arg_8_1.actors_["4010ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos4010ui_story = var_11_6.localPosition
			end

			local var_11_7 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_7 then
				var_11_6.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_8_1.time_ - 0) / var_11_7)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_7 and arg_8_1.time_ < 0 + var_11_7 + arg_11_0 then
				var_11_6.localPosition = Vector3.New(0, 100, 0)
				var_11_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_6.position).x, (manager.ui.mainCamera.transform.position - var_11_6.position).y, (manager.ui.mainCamera.transform.position - var_11_6.position).z)
				var_11_6.localEulerAngles.z = 0
				var_11_6.localEulerAngles.x = 0
				var_11_6.localEulerAngles = var_11_6.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_11_8 = arg_8_1.actors_["1084ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1084ui_story = var_11_8.localPosition

				arg_8_1:ShowWeapon(arg_8_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_11_9 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_8_1.time_ - 0) / var_11_9)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0, -0.97, -6)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			local var_11_10 = 0
			local var_11_11 = 0.075

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(103102002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 3 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 3)

				if (3 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 3)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102002", "story_v_out_103102.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_103102", "103102002", "story_v_out_103102.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_103102", "103102002", "story_v_out_103102.awb")

						arg_8_1:RecordAudio("103102002", var_11_17)
						arg_8_1:RecordAudio("103102002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_103102", "103102002", "story_v_out_103102.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_103102", "103102002", "story_v_out_103102.awb")
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
				actorName = "1084ui_story",
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
	Play103102003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 103102003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play103102004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1084ui_story"]) and arg_12_1.var_.characterEffect1084ui_story == nil then
				arg_12_1.var_.characterEffect1084ui_story = arg_12_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1084ui_story"]) then
				if arg_12_1.var_.characterEffect1084ui_story and not isNil(arg_12_1.actors_["1084ui_story"]) then
					arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1084ui_story"]) and arg_12_1.var_.characterEffect1084ui_story then
				arg_12_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.5

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(103102003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 20 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 20)

				if (20 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 20)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play103102004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 103102004
		arg_16_1.duration_ = 6

		local var_16_0 = {
			ja = 6,
			ko = 4.266,
			zh = 3.966,
			en = 5.1
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
				arg_16_0:Play103102005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:AudioAction("play", "effect", "se_story_3", "se_story_3_destroy_1", "")
			end

			local var_19_1 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_1.localPosition
			end

			local var_19_2 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_2 then
				var_19_1.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_2)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_2 and arg_16_1.time_ < 0 + var_19_2 + arg_19_0 then
				var_19_1.localPosition = Vector3.New(0, 100, 0)
				var_19_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_1.position).x, (manager.ui.mainCamera.transform.position - var_19_1.position).y, (manager.ui.mainCamera.transform.position - var_19_1.position).z)
				var_19_1.localEulerAngles.z = 0
				var_19_1.localEulerAngles.x = 0
				var_19_1.localEulerAngles = var_19_1.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_2")
			end

			local var_19_3 = 0
			local var_19_4 = 0.325

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_3 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[53].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_5 = arg_16_1:GetWordFromCfg(103102004)
				local var_19_6 = arg_16_1:FormatText(var_19_5.content)

				arg_16_1.text_.text = var_19_6

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_8 = 13 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 13)

				if (13 <= 0 and var_19_4 or var_19_4 * (utf8.len(var_19_6) / 13)) > 0 and var_19_4 < var_19_8 then
					arg_16_1.talkMaxDuration = var_19_8

					if var_19_8 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_8 + var_19_3
					end
				end

				arg_16_1.text_.text = var_19_6
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102004", "story_v_out_103102.awb") ~= 0 then
					local var_19_9 = manager.audio:GetVoiceLength("story_v_out_103102", "103102004", "story_v_out_103102.awb") / 1000

					if var_19_9 + var_19_3 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_9 + var_19_3
					end

					if var_19_5.prefab_name ~= "" and arg_16_1.actors_[var_19_5.prefab_name] ~= nil then
						local var_19_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_5.prefab_name].transform, "story_v_out_103102", "103102004", "story_v_out_103102.awb")

						arg_16_1:RecordAudio("103102004", var_19_10)
						arg_16_1:RecordAudio("103102004", var_19_10)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_103102", "103102004", "story_v_out_103102.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_103102", "103102004", "story_v_out_103102.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_11 = math.max(var_19_4, arg_16_1.talkMaxDuration)

			if var_19_3 <= arg_16_1.time_ and arg_16_1.time_ < var_19_3 + var_19_11 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_3) / var_19_11

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_3 + var_19_11 and arg_16_1.time_ < var_19_3 + var_19_11 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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
	Play103102005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 103102005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play103102006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.mask_.enabled = true
				arg_20_1.mask_.raycastTarget = true

				arg_20_1:SetGaussion(false)
			end

			local var_23_0 = 0.5

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 then
				local var_23_1 = Color.New(1, 1, 1)

				var_23_1.a = Mathf.Lerp(1, 0, (arg_20_1.time_ - 0) / var_23_0)
				arg_20_1.mask_.color = var_23_1
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 then
				local var_23_2 = Color.New(1, 1, 1)

				arg_20_1.mask_.enabled = false
				var_23_2.a = 0
				arg_20_1.mask_.color = var_23_2
			end

			local var_23_3 = manager.ui.mainCamera.transform

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1.var_.shakeOldPosMainCamera = var_23_3.localPosition
			end

			local var_23_4 = 0.600000023841858

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_4 then
				local var_23_5, var_23_6 = math.modf((arg_20_1.time_ - 0) / 0.066)

				var_23_3.localPosition = Vector3.New(var_23_6 * 0.13, var_23_6 * 0.13, var_23_6 * 0.13) + arg_20_1.var_.shakeOldPosMainCamera
			end

			if arg_20_1.time_ >= 0 + var_23_4 and arg_20_1.time_ < 0 + var_23_4 + arg_23_0 then
				var_23_3.localPosition = arg_20_1.var_.shakeOldPosMainCamera
			end

			local var_23_7 = 0
			local var_23_8 = 1.425

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_7 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_9 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(103102005).content)

				arg_20_1.text_.text = var_23_9

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_11 = 57 <= 0 and var_23_8 or var_23_8 * (utf8.len(var_23_9) / 57)

				if (57 <= 0 and var_23_8 or var_23_8 * (utf8.len(var_23_9) / 57)) > 0 and var_23_8 < var_23_11 then
					arg_20_1.talkMaxDuration = var_23_11

					if var_23_11 + var_23_7 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_11 + var_23_7
					end
				end

				arg_20_1.text_.text = var_23_9
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_12 = math.max(var_23_8, arg_20_1.talkMaxDuration)

			if var_23_7 <= arg_20_1.time_ and arg_20_1.time_ < var_23_7 + var_23_12 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_7) / var_23_12

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_7 + var_23_12 and arg_20_1.time_ < var_23_7 + var_23_12 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play103102006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 103102006
		arg_24_1.duration_ = 3.07

		local var_24_0 = {
			ja = 2.866,
			ko = 2.566,
			zh = 3.066,
			en = 3.033
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
				arg_24_0:Play103102007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			local var_27_0 = 0.225

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, true)
				arg_24_1.iconController_:SetSelectedState("hero")

				arg_24_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_24_1.callingController_:SetSelectedState("normal")

				arg_24_1.keyicon_.color = Color.New(1, 1, 1)
				arg_24_1.icon_.color = Color.New(1, 1, 1)

				local var_27_1 = arg_24_1:GetWordFromCfg(103102006)
				local var_27_2 = arg_24_1:FormatText(var_27_1.content)

				arg_24_1.text_.text = var_27_2

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_4 = 9 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 9)

				if (9 <= 0 and var_27_0 or var_27_0 * (utf8.len(var_27_2) / 9)) > 0 and var_27_0 < var_27_4 then
					arg_24_1.talkMaxDuration = var_27_4

					if var_27_4 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_4 + 0
					end
				end

				arg_24_1.text_.text = var_27_2
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102006", "story_v_out_103102.awb") ~= 0 then
					local var_27_5 = manager.audio:GetVoiceLength("story_v_out_103102", "103102006", "story_v_out_103102.awb") / 1000

					if var_27_5 + 0 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_5 + 0
					end

					if var_27_1.prefab_name ~= "" and arg_24_1.actors_[var_27_1.prefab_name] ~= nil then
						local var_27_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_1.prefab_name].transform, "story_v_out_103102", "103102006", "story_v_out_103102.awb")

						arg_24_1:RecordAudio("103102006", var_27_6)
						arg_24_1:RecordAudio("103102006", var_27_6)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_103102", "103102006", "story_v_out_103102.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_103102", "103102006", "story_v_out_103102.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_7 = math.max(var_27_0, arg_24_1.talkMaxDuration)

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - 0) / var_27_7

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {}

		arg_24_1:InitPlayNodeList()
	end,
	Play103102007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 103102007
		arg_28_1.duration_ = 5.13

		local var_28_0 = {
			ja = 5.133,
			ko = 4.3,
			zh = 3.433,
			en = 2.566
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
				arg_28_0:Play103102008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) and arg_28_1.var_.characterEffect4010ui_story == nil then
				arg_28_1.var_.characterEffect4010ui_story = arg_28_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) then
				if arg_28_1.var_.characterEffect4010ui_story and not isNil(arg_28_1.actors_["4010ui_story"]) then
					arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["4010ui_story"]) and arg_28_1.var_.characterEffect4010ui_story then
				arg_28_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["4010ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos4010ui_story = var_31_2.localPosition
			end

			local var_31_3 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 then
				var_31_2.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_28_1.time_ - 0) / var_31_3)
				var_31_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_2.position).x, (manager.ui.mainCamera.transform.position - var_31_2.position).y, (manager.ui.mainCamera.transform.position - var_31_2.position).z)
				var_31_2.localEulerAngles.z = 0
				var_31_2.localEulerAngles.x = 0
				var_31_2.localEulerAngles = var_31_2.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 then
				var_31_2.localPosition = Vector3.New(0, -1.59, -5.2)
				var_31_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_2.position).x, (manager.ui.mainCamera.transform.position - var_31_2.position).y, (manager.ui.mainCamera.transform.position - var_31_2.position).z)
				var_31_2.localEulerAngles.z = 0
				var_31_2.localEulerAngles.x = 0
				var_31_2.localEulerAngles = var_31_2.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_31_4 = 0
			local var_31_5 = 0.375

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_4 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_6 = arg_28_1:GetWordFromCfg(103102007)
				local var_31_7 = arg_28_1:FormatText(var_31_6.content)

				arg_28_1.text_.text = var_31_7

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_9 = 15 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 15)

				if (15 <= 0 and var_31_5 or var_31_5 * (utf8.len(var_31_7) / 15)) > 0 and var_31_5 < var_31_9 then
					arg_28_1.talkMaxDuration = var_31_9

					if var_31_9 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_9 + var_31_4
					end
				end

				arg_28_1.text_.text = var_31_7
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102007", "story_v_out_103102.awb") ~= 0 then
					local var_31_10 = manager.audio:GetVoiceLength("story_v_out_103102", "103102007", "story_v_out_103102.awb") / 1000

					if var_31_10 + var_31_4 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_10 + var_31_4
					end

					if var_31_6.prefab_name ~= "" and arg_28_1.actors_[var_31_6.prefab_name] ~= nil then
						local var_31_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_6.prefab_name].transform, "story_v_out_103102", "103102007", "story_v_out_103102.awb")

						arg_28_1:RecordAudio("103102007", var_31_11)
						arg_28_1:RecordAudio("103102007", var_31_11)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_103102", "103102007", "story_v_out_103102.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_103102", "103102007", "story_v_out_103102.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_12 = math.max(var_31_5, arg_28_1.talkMaxDuration)

			if var_31_4 <= arg_28_1.time_ and arg_28_1.time_ < var_31_4 + var_31_12 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_4) / var_31_12

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_4 + var_31_12 and arg_28_1.time_ < var_31_4 + var_31_12 + arg_31_0 then
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
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play103102008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 103102008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play103102009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos4010ui_story = arg_32_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_35_0 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_0 then
				arg_32_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_32_1.time_ - 0) / var_35_0)
				arg_32_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4010ui_story"].transform.position).z)
				arg_32_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["4010ui_story"].transform.localEulerAngles = arg_32_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_0 and arg_32_1.time_ < 0 + var_35_0 + arg_35_0 then
				arg_32_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_32_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_32_1.actors_["4010ui_story"].transform.position).z)
				arg_32_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_32_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_32_1.actors_["4010ui_story"].transform.localEulerAngles = arg_32_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_35_1 = 0
			local var_35_2 = 0.375

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_1 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, false)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_3 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(103102008).content)

				arg_32_1.text_.text = var_35_3

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_5 = 15 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 15)

				if (15 <= 0 and var_35_2 or var_35_2 * (utf8.len(var_35_3) / 15)) > 0 and var_35_2 < var_35_5 then
					arg_32_1.talkMaxDuration = var_35_5

					if var_35_5 + var_35_1 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_5 + var_35_1
					end
				end

				arg_32_1.text_.text = var_35_3
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_6 = math.max(var_35_2, arg_32_1.talkMaxDuration)

			if var_35_1 <= arg_32_1.time_ and arg_32_1.time_ < var_35_1 + var_35_6 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_1) / var_35_6

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_1 + var_35_6 and arg_32_1.time_ < var_35_1 + var_35_6 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play103102009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 103102009
		arg_36_1.duration_ = 2.5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play103102010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:AudioAction("play", "effect", "se_story_3", "se_story_3_destroy_2", "")
			end

			local var_39_1 = 0

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.mask_.enabled = true
				arg_36_1.mask_.raycastTarget = true

				arg_36_1:SetGaussion(false)
			end

			local var_39_2 = 0.5

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_2 then
				local var_39_3 = Color.New(1, 1, 1)

				var_39_3.a = Mathf.Lerp(1, 0, (arg_36_1.time_ - var_39_1) / var_39_2)
				arg_36_1.mask_.color = var_39_3
			end

			if arg_36_1.time_ >= var_39_1 + var_39_2 and arg_36_1.time_ < var_39_1 + var_39_2 + arg_39_0 then
				local var_39_4 = Color.New(1, 1, 1)

				arg_36_1.mask_.enabled = false
				var_39_4.a = 0
				arg_36_1.mask_.color = var_39_4
			end

			local var_39_5 = manager.ui.mainCamera.transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.shakeOldPosMainCamera = var_39_5.localPosition
			end

			local var_39_6 = 0.600000023841858

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_6 then
				local var_39_7, var_39_8 = math.modf((arg_36_1.time_ - 0) / 0.066)

				var_39_5.localPosition = Vector3.New(var_39_8 * 0.13, var_39_8 * 0.13, var_39_8 * 0.13) + arg_36_1.var_.shakeOldPosMainCamera
			end

			if arg_36_1.time_ >= 0 + var_39_6 and arg_36_1.time_ < 0 + var_39_6 + arg_39_0 then
				var_39_5.localPosition = arg_36_1.var_.shakeOldPosMainCamera
			end

			local var_39_9 = 0
			local var_39_10 = 0.15

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_9 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[53].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_11 = arg_36_1:GetWordFromCfg(103102009)
				local var_39_12 = arg_36_1:FormatText(var_39_11.content)

				arg_36_1.text_.text = var_39_12

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_14 = 6 <= 0 and var_39_10 or var_39_10 * (utf8.len(var_39_12) / 6)

				if (6 <= 0 and var_39_10 or var_39_10 * (utf8.len(var_39_12) / 6)) > 0 and var_39_10 < var_39_14 then
					arg_36_1.talkMaxDuration = var_39_14

					if var_39_14 + var_39_9 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_14 + var_39_9
					end
				end

				arg_36_1.text_.text = var_39_12
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102009", "story_v_out_103102.awb") ~= 0 then
					local var_39_15 = manager.audio:GetVoiceLength("story_v_out_103102", "103102009", "story_v_out_103102.awb") / 1000

					if var_39_15 + var_39_9 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_9
					end

					if var_39_11.prefab_name ~= "" and arg_36_1.actors_[var_39_11.prefab_name] ~= nil then
						local var_39_16 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_11.prefab_name].transform, "story_v_out_103102", "103102009", "story_v_out_103102.awb")

						arg_36_1:RecordAudio("103102009", var_39_16)
						arg_36_1:RecordAudio("103102009", var_39_16)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_103102", "103102009", "story_v_out_103102.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_103102", "103102009", "story_v_out_103102.awb")
				end

				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_17 = math.max(var_39_10, arg_36_1.talkMaxDuration)

			if var_39_9 <= arg_36_1.time_ and arg_36_1.time_ < var_39_9 + var_39_17 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_9) / var_39_17

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_9 + var_39_17 and arg_36_1.time_ < var_39_9 + var_39_17 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play103102010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 103102010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play103102011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			local var_43_0 = 0.225

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, false)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_1 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(103102010).content)

				arg_40_1.text_.text = var_43_1

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_3 = 9 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 9)

				if (9 <= 0 and var_43_0 or var_43_0 * (utf8.len(var_43_1) / 9)) > 0 and var_43_0 < var_43_3 then
					arg_40_1.talkMaxDuration = var_43_3

					if var_43_3 + 0 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_3 + 0
					end
				end

				arg_40_1.text_.text = var_43_1
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_4 = math.max(var_43_0, arg_40_1.talkMaxDuration)

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_4 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - 0) / var_43_4

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= 0 + var_43_4 and arg_40_1.time_ < 0 + var_43_4 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {}

		arg_40_1:InitPlayNodeList()
	end,
	Play103102011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 103102011
		arg_44_1.duration_ = 2

		local var_44_0 = {
			ja = 1.333,
			ko = 0.933,
			zh = 2,
			en = 1.8
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
				arg_44_0:Play103102012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			local var_47_0 = 0.125

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, true)
				arg_44_1.iconController_:SetSelectedState("hero")

				arg_44_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_44_1.callingController_:SetSelectedState("normal")

				arg_44_1.keyicon_.color = Color.New(1, 1, 1)
				arg_44_1.icon_.color = Color.New(1, 1, 1)

				local var_47_1 = arg_44_1:GetWordFromCfg(103102011)
				local var_47_2 = arg_44_1:FormatText(var_47_1.content)

				arg_44_1.text_.text = var_47_2

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_4 = 5 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 5)

				if (5 <= 0 and var_47_0 or var_47_0 * (utf8.len(var_47_2) / 5)) > 0 and var_47_0 < var_47_4 then
					arg_44_1.talkMaxDuration = var_47_4

					if var_47_4 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_4 + 0
					end
				end

				arg_44_1.text_.text = var_47_2
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102011", "story_v_out_103102.awb") ~= 0 then
					local var_47_5 = manager.audio:GetVoiceLength("story_v_out_103102", "103102011", "story_v_out_103102.awb") / 1000

					if var_47_5 + 0 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_5 + 0
					end

					if var_47_1.prefab_name ~= "" and arg_44_1.actors_[var_47_1.prefab_name] ~= nil then
						local var_47_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_1.prefab_name].transform, "story_v_out_103102", "103102011", "story_v_out_103102.awb")

						arg_44_1:RecordAudio("103102011", var_47_6)
						arg_44_1:RecordAudio("103102011", var_47_6)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_103102", "103102011", "story_v_out_103102.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_103102", "103102011", "story_v_out_103102.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_7 = math.max(var_47_0, arg_44_1.talkMaxDuration)

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_7 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - 0) / var_47_7

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= 0 + var_47_7 and arg_44_1.time_ < 0 + var_47_7 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {}

		arg_44_1:InitPlayNodeList()
	end,
	Play103102012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 103102012
		arg_48_1.duration_ = 6.93

		local var_48_0 = {
			ja = 6.933,
			ko = 5.7,
			zh = 5.6,
			en = 6.2
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
				arg_48_0:Play103102013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) and arg_48_1.var_.characterEffect4010ui_story == nil then
				arg_48_1.var_.characterEffect4010ui_story = arg_48_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) then
				if arg_48_1.var_.characterEffect4010ui_story and not isNil(arg_48_1.actors_["4010ui_story"]) then
					arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["4010ui_story"]) and arg_48_1.var_.characterEffect4010ui_story then
				arg_48_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["4010ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos4010ui_story = var_51_2.localPosition
			end

			local var_51_3 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 then
				var_51_2.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_48_1.time_ - 0) / var_51_3)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 then
				var_51_2.localPosition = Vector3.New(0, -1.59, -5.2)
				var_51_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_2.position).x, (manager.ui.mainCamera.transform.position - var_51_2.position).y, (manager.ui.mainCamera.transform.position - var_51_2.position).z)
				var_51_2.localEulerAngles.z = 0
				var_51_2.localEulerAngles.x = 0
				var_51_2.localEulerAngles = var_51_2.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action5_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_51_4 = 0
			local var_51_5 = 0.5

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_4 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_6 = arg_48_1:GetWordFromCfg(103102012)
				local var_51_7 = arg_48_1:FormatText(var_51_6.content)

				arg_48_1.text_.text = var_51_7

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_9 = 20 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 20)

				if (20 <= 0 and var_51_5 or var_51_5 * (utf8.len(var_51_7) / 20)) > 0 and var_51_5 < var_51_9 then
					arg_48_1.talkMaxDuration = var_51_9

					if var_51_9 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_9 + var_51_4
					end
				end

				arg_48_1.text_.text = var_51_7
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102012", "story_v_out_103102.awb") ~= 0 then
					local var_51_10 = manager.audio:GetVoiceLength("story_v_out_103102", "103102012", "story_v_out_103102.awb") / 1000

					if var_51_10 + var_51_4 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_10 + var_51_4
					end

					if var_51_6.prefab_name ~= "" and arg_48_1.actors_[var_51_6.prefab_name] ~= nil then
						local var_51_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_6.prefab_name].transform, "story_v_out_103102", "103102012", "story_v_out_103102.awb")

						arg_48_1:RecordAudio("103102012", var_51_11)
						arg_48_1:RecordAudio("103102012", var_51_11)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_103102", "103102012", "story_v_out_103102.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_103102", "103102012", "story_v_out_103102.awb")
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play103102013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 103102013
		arg_52_1.duration_ = 7.1

		local var_52_0 = {
			ja = 4.3,
			ko = 7.1,
			zh = 3.533,
			en = 3.433
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
				arg_52_0:Play103102014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 1.63333333333333 < arg_52_1.time_ and arg_52_1.time_ <= 1.63333333333333 + arg_55_0 then
				arg_52_1:AudioAction("play", "effect", "se_story_3", "se_story_3_destroy_3", "")
			end

			local var_55_1 = arg_52_1.actors_["4010ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos4010ui_story = var_55_1.localPosition
			end

			local var_55_2 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_2 then
				var_55_1.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_2)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_2 and arg_52_1.time_ < 0 + var_55_2 + arg_55_0 then
				var_55_1.localPosition = Vector3.New(0, 100, 0)
				var_55_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_1.position).x, (manager.ui.mainCamera.transform.position - var_55_1.position).y, (manager.ui.mainCamera.transform.position - var_55_1.position).z)
				var_55_1.localEulerAngles.z = 0
				var_55_1.localEulerAngles.x = 0
				var_55_1.localEulerAngles = var_55_1.localEulerAngles
			end

			local var_55_3 = 0
			local var_55_4 = 0.7

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_3 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[49].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, true)
				arg_52_1.iconController_:SetSelectedState("hero")

				arg_52_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_40131")

				arg_52_1.callingController_:SetSelectedState("normal")

				arg_52_1.keyicon_.color = Color.New(1, 1, 1)
				arg_52_1.icon_.color = Color.New(1, 1, 1)

				local var_55_5 = arg_52_1:GetWordFromCfg(103102013)
				local var_55_6 = arg_52_1:FormatText(var_55_5.content)

				arg_52_1.text_.text = var_55_6

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_8 = 28 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 28)

				if (28 <= 0 and var_55_4 or var_55_4 * (utf8.len(var_55_6) / 28)) > 0 and var_55_4 < var_55_8 then
					arg_52_1.talkMaxDuration = var_55_8

					if var_55_8 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_8 + var_55_3
					end
				end

				arg_52_1.text_.text = var_55_6
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102013", "story_v_out_103102.awb") ~= 0 then
					local var_55_9 = manager.audio:GetVoiceLength("story_v_out_103102", "103102013", "story_v_out_103102.awb") / 1000

					if var_55_9 + var_55_3 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_9 + var_55_3
					end

					if var_55_5.prefab_name ~= "" and arg_52_1.actors_[var_55_5.prefab_name] ~= nil then
						local var_55_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_5.prefab_name].transform, "story_v_out_103102", "103102013", "story_v_out_103102.awb")

						arg_52_1:RecordAudio("103102013", var_55_10)
						arg_52_1:RecordAudio("103102013", var_55_10)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_103102", "103102013", "story_v_out_103102.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_103102", "103102013", "story_v_out_103102.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_11 = math.max(var_55_4, arg_52_1.talkMaxDuration)

			if var_55_3 <= arg_52_1.time_ and arg_52_1.time_ < var_55_3 + var_55_11 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_3) / var_55_11

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_3 + var_55_11 and arg_52_1.time_ < var_55_3 + var_55_11 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play103102014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 103102014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play103102015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.725

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, false)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(103102014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 29 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 29)

				if (29 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 29)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play103102015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 103102015
		arg_60_1.duration_ = 5.3

		local var_60_0 = {
			ja = 5.3,
			ko = 4.233,
			zh = 4.566,
			en = 4.866
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
				arg_60_0:Play103102016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if arg_60_1.actors_["1011ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1011ui_story"))) then
				local var_63_0 = Object.Instantiate(Asset.Load("Char/" .. "1011ui_story"), arg_60_1.stage_.transform)

				var_63_0.name = "1011ui_story"
				var_63_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.actors_["1011ui_story"] = var_63_0

				local var_63_1 = var_63_0:GetComponentInChildren(typeof(CharacterEffect))

				var_63_1.enabled = true

				local var_63_2 = GameObjectTools.GetOrAddComponent(var_63_0, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(false)
				end

				arg_60_1:ShowWeapon(var_63_1.transform, false)

				arg_60_1.var_["1011ui_story" .. "Animator"] = var_63_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_60_1.var_["1011ui_story" .. "Animator"].applyRootMotion = true
				arg_60_1.var_["1011ui_story" .. "LipSync"] = var_63_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_63_3 = arg_60_1.actors_["1011ui_story"]

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= 2 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1011ui_story == nil then
				arg_60_1.var_.characterEffect1011ui_story = var_63_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.1

			if 2 <= arg_60_1.time_ and arg_60_1.time_ < 2 + var_63_4 and not isNil(var_63_3) then
				if arg_60_1.var_.characterEffect1011ui_story and not isNil(var_63_3) then
					arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 2 + var_63_4 and arg_60_1.time_ < 2 + var_63_4 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1011ui_story then
				arg_60_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_63_6 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_7 = 1.5

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_7 then
				local var_63_8 = Color.New(0, 0, 0)

				var_63_8.a = Mathf.Lerp(0, 1, (arg_60_1.time_ - var_63_6) / var_63_7)
				arg_60_1.mask_.color = var_63_8
			end

			if arg_60_1.time_ >= var_63_6 + var_63_7 and arg_60_1.time_ < var_63_6 + var_63_7 + arg_63_0 then
				local var_63_9 = Color.New(0, 0, 0)

				var_63_9.a = 1
				arg_60_1.mask_.color = var_63_9
			end

			local var_63_10 = 1.5

			if 1.5 < arg_60_1.time_ and arg_60_1.time_ <= var_63_10 + arg_63_0 then
				arg_60_1.mask_.enabled = true
				arg_60_1.mask_.raycastTarget = true

				arg_60_1:SetGaussion(false)
			end

			local var_63_11 = 1.5

			if var_63_10 <= arg_60_1.time_ and arg_60_1.time_ < var_63_10 + var_63_11 then
				local var_63_12 = Color.New(0, 0, 0)

				var_63_12.a = Mathf.Lerp(1, 0, (arg_60_1.time_ - var_63_10) / var_63_11)
				arg_60_1.mask_.color = var_63_12
			end

			if arg_60_1.time_ >= var_63_10 + var_63_11 and arg_60_1.time_ < var_63_10 + var_63_11 + arg_63_0 then
				local var_63_13 = Color.New(0, 0, 0)

				arg_60_1.mask_.enabled = false
				var_63_13.a = 0
				arg_60_1.mask_.color = var_63_13
			end

			local var_63_14 = "B03f"

			if arg_60_1.bgs_.B03f == nil then
				local var_63_15 = Object.Instantiate(arg_60_1.paintGo_)

				var_63_15:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_63_14)
				var_63_15.name = var_63_14
				var_63_15.transform.parent = arg_60_1.stage_.transform
				var_63_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_60_1.bgs_[var_63_14] = var_63_15
			end

			if 1.5 < arg_60_1.time_ and arg_60_1.time_ <= 1.5 + arg_63_0 then
				local var_63_16 = arg_60_1.bgs_.B03f

				arg_60_1.bgs_.B03f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_63_16.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_63_17 = var_63_16:GetComponent("SpriteRenderer")

				if var_63_17 and var_63_17.sprite then
					local var_63_18 = 2 * (var_63_16.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_63_16.transform.localScale = Vector3.New(var_63_18 / var_63_17.sprite.bounds.size.y < var_63_18 * manager.ui.mainCameraCom_.aspect / var_63_17.sprite.bounds.size.x and var_63_18 * manager.ui.mainCameraCom_.aspect / var_63_17.sprite.bounds.size.x or var_63_18 / var_63_17.sprite.bounds.size.y, var_63_18 / var_63_17.sprite.bounds.size.y < var_63_18 * manager.ui.mainCameraCom_.aspect / var_63_17.sprite.bounds.size.x and var_63_18 * manager.ui.mainCameraCom_.aspect / var_63_17.sprite.bounds.size.x or var_63_18 / var_63_17.sprite.bounds.size.y, 0)
				end

				for iter_63_0, iter_63_1 in pairs(arg_60_1.bgs_) do
					if iter_63_0 ~= "B03f" then
						iter_63_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_63_19 = arg_60_1.actors_["4010ui_story"].transform

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos4010ui_story = var_63_19.localPosition
			end

			local var_63_20 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_20 then
				var_63_19.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_60_1.time_ - 0) / var_63_20)
				var_63_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_19.position).x, (manager.ui.mainCamera.transform.position - var_63_19.position).y, (manager.ui.mainCamera.transform.position - var_63_19.position).z)
				var_63_19.localEulerAngles.z = 0
				var_63_19.localEulerAngles.x = 0
				var_63_19.localEulerAngles = var_63_19.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_20 and arg_60_1.time_ < 0 + var_63_20 + arg_63_0 then
				var_63_19.localPosition = Vector3.New(0, 100, 0)
				var_63_19.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_19.position).x, (manager.ui.mainCamera.transform.position - var_63_19.position).y, (manager.ui.mainCamera.transform.position - var_63_19.position).z)
				var_63_19.localEulerAngles.z = 0
				var_63_19.localEulerAngles.x = 0
				var_63_19.localEulerAngles = var_63_19.localEulerAngles
			end

			local var_63_21 = arg_60_1.actors_["1011ui_story"].transform

			if 1.79999995231628 < arg_60_1.time_ and arg_60_1.time_ <= 1.79999995231628 + arg_63_0 then
				arg_60_1.var_.moveOldPos1011ui_story = var_63_21.localPosition
			end

			local var_63_22 = 0.001

			if 1.79999995231628 <= arg_60_1.time_ and arg_60_1.time_ < 1.79999995231628 + var_63_22 then
				var_63_21.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1011ui_story, Vector3.New(0, -0.71, -6), (arg_60_1.time_ - 1.79999995231628) / var_63_22)
				var_63_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_21.position).x, (manager.ui.mainCamera.transform.position - var_63_21.position).y, (manager.ui.mainCamera.transform.position - var_63_21.position).z)
				var_63_21.localEulerAngles.z = 0
				var_63_21.localEulerAngles.x = 0
				var_63_21.localEulerAngles = var_63_21.localEulerAngles
			end

			if arg_60_1.time_ >= 1.79999995231628 + var_63_22 and arg_60_1.time_ < 1.79999995231628 + var_63_22 + arg_63_0 then
				var_63_21.localPosition = Vector3.New(0, -0.71, -6)
				var_63_21.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_63_21.position).x, (manager.ui.mainCamera.transform.position - var_63_21.position).y, (manager.ui.mainCamera.transform.position - var_63_21.position).z)
				var_63_21.localEulerAngles.z = 0
				var_63_21.localEulerAngles.x = 0
				var_63_21.localEulerAngles = var_63_21.localEulerAngles
			end

			if 1.79999995231628 < arg_60_1.time_ and arg_60_1.time_ <= 1.79999995231628 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			local var_63_23 = 0

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_23 + arg_63_0 then
				arg_60_1.allBtn_.enabled = false
			end

			if arg_60_1.time_ >= var_63_23 + 2 and arg_60_1.time_ < var_63_23 + 2 + arg_63_0 then
				arg_60_1.allBtn_.enabled = true
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if arg_60_1.frameCnt_ <= 1 then
				arg_60_1.dialog_:SetActive(false)
			end

			local var_63_24 = 2
			local var_63_25 = 0.225

			if 2 < arg_60_1.time_ and arg_60_1.time_ <= var_63_24 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0

				arg_60_1.dialog_:SetActive(true)

				arg_60_1.dialogCg_.alpha = 0

				local var_63_26 = LeanTween.value(arg_60_1.dialog_, 0, 1, 0.3)

				var_63_26:setOnUpdate(LuaHelper.FloatAction(function(arg_64_0)
					arg_60_1.dialogCg_.alpha = arg_64_0
				end))
				var_63_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_60_1.dialog_)
					var_63_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_60_1.duration_ = arg_60_1.duration_ + 0.3

				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_27 = arg_60_1:GetWordFromCfg(103102015)
				local var_63_28 = arg_60_1:FormatText(var_63_27.content)

				arg_60_1.text_.text = var_63_28

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_30 = 9 <= 0 and var_63_25 or var_63_25 * (utf8.len(var_63_28) / 9)

				if (9 <= 0 and var_63_25 or var_63_25 * (utf8.len(var_63_28) / 9)) > 0 and var_63_25 < var_63_30 then
					arg_60_1.talkMaxDuration = var_63_30
					var_63_24 = var_63_24 + 0.3

					if var_63_30 + var_63_24 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_30 + var_63_24
					end
				end

				arg_60_1.text_.text = var_63_28
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102015", "story_v_out_103102.awb") ~= 0 then
					local var_63_31 = manager.audio:GetVoiceLength("story_v_out_103102", "103102015", "story_v_out_103102.awb") / 1000

					if var_63_31 + var_63_24 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_31 + var_63_24
					end

					if var_63_27.prefab_name ~= "" and arg_60_1.actors_[var_63_27.prefab_name] ~= nil then
						local var_63_32 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_27.prefab_name].transform, "story_v_out_103102", "103102015", "story_v_out_103102.awb")

						arg_60_1:RecordAudio("103102015", var_63_32)
						arg_60_1:RecordAudio("103102015", var_63_32)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_103102", "103102015", "story_v_out_103102.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_103102", "103102015", "story_v_out_103102.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_33 = var_63_24 + 0.3
			local var_63_34 = math.max(var_63_25, arg_60_1.talkMaxDuration)

			if var_63_24 + 0.3 <= arg_60_1.time_ and arg_60_1.time_ < var_63_33 + var_63_34 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_33) / var_63_34

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_33 + var_63_34 and arg_60_1.time_ < var_63_33 + var_63_34 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
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
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play103102016 = function(arg_66_0, arg_66_1)
		arg_66_1.time_ = 0
		arg_66_1.frameCnt_ = 0
		arg_66_1.state_ = "playing"
		arg_66_1.curTalkId_ = 103102016
		arg_66_1.duration_ = 5

		SetActive(arg_66_1.tipsGo_, false)

		function arg_66_1.onSingleLineFinish_()
			arg_66_1.onSingleLineUpdate_ = nil
			arg_66_1.onSingleLineFinish_ = nil
			arg_66_1.state_ = "waiting"
		end

		function arg_66_1.playNext_(arg_68_0)
			if arg_68_0 == 1 then
				arg_66_0:Play103102017(arg_66_1)
			end
		end

		function arg_66_1.onSingleLineUpdate_(arg_69_0)
			if 0 < arg_66_1.time_ and arg_66_1.time_ <= 0 + arg_69_0 and not isNil(arg_66_1.actors_["1011ui_story"]) and arg_66_1.var_.characterEffect1011ui_story == nil then
				arg_66_1.var_.characterEffect1011ui_story = arg_66_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_69_0 = 0.1

			if 0 <= arg_66_1.time_ and arg_66_1.time_ < 0 + var_69_0 and not isNil(arg_66_1.actors_["1011ui_story"]) then
				if arg_66_1.var_.characterEffect1011ui_story and not isNil(arg_66_1.actors_["1011ui_story"]) then
					arg_66_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_66_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_66_1.time_ - 0) / var_69_0)
				end
			end

			if arg_66_1.time_ >= 0 + var_69_0 and arg_66_1.time_ < 0 + var_69_0 + arg_69_0 and not isNil(arg_66_1.actors_["1011ui_story"]) and arg_66_1.var_.characterEffect1011ui_story then
				arg_66_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_66_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_69_1 = 0
			local var_69_2 = 0.75

			if 0 < arg_66_1.time_ and arg_66_1.time_ <= var_69_1 + arg_69_0 then
				arg_66_1.talkMaxDuration = 0
				arg_66_1.dialogCg_.alpha = 1

				arg_66_1.dialog_:SetActive(true)
				SetActive(arg_66_1.leftNameGo_, true)

				arg_66_1.leftNameTxt_.text = arg_66_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_66_1.leftNameTxt_.transform)

				arg_66_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_66_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_66_1:RecordName(arg_66_1.leftNameTxt_.text)
				SetActive(arg_66_1.iconTrs_.gameObject, true)
				arg_66_1.iconController_:SetSelectedState("hero")

				arg_66_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_66_1.callingController_:SetSelectedState("normal")

				arg_66_1.keyicon_.color = Color.New(1, 1, 1)
				arg_66_1.icon_.color = Color.New(1, 1, 1)

				local var_69_3 = arg_66_1:FormatText(arg_66_1:GetWordFromCfg(103102016).content)

				arg_66_1.text_.text = var_69_3

				LuaForUtil.ClearLinePrefixSymbol(arg_66_1.text_)

				local var_69_5 = 30 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 30)

				if (30 <= 0 and var_69_2 or var_69_2 * (utf8.len(var_69_3) / 30)) > 0 and var_69_2 < var_69_5 then
					arg_66_1.talkMaxDuration = var_69_5

					if var_69_5 + var_69_1 > arg_66_1.duration_ then
						arg_66_1.duration_ = var_69_5 + var_69_1
					end
				end

				arg_66_1.text_.text = var_69_3
				arg_66_1.typewritter.percent = 0

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(false)
				arg_66_1:RecordContent(arg_66_1.text_.text)
			end

			local var_69_6 = math.max(var_69_2, arg_66_1.talkMaxDuration)

			if var_69_1 <= arg_66_1.time_ and arg_66_1.time_ < var_69_1 + var_69_6 then
				arg_66_1.typewritter.percent = (arg_66_1.time_ - var_69_1) / var_69_6

				arg_66_1.typewritter:SetDirty()
			end

			if arg_66_1.time_ >= var_69_1 + var_69_6 and arg_66_1.time_ < var_69_1 + var_69_6 + arg_69_0 then
				arg_66_1.typewritter.percent = 1

				arg_66_1.typewritter:SetDirty()
				arg_66_1:ShowNextGo(true)
			end
		end

		arg_66_1.nodeConfigList_ = {}

		arg_66_1:InitPlayNodeList()
	end,
	Play103102017 = function(arg_70_0, arg_70_1)
		arg_70_1.time_ = 0
		arg_70_1.frameCnt_ = 0
		arg_70_1.state_ = "playing"
		arg_70_1.curTalkId_ = 103102017
		arg_70_1.duration_ = 2

		SetActive(arg_70_1.tipsGo_, false)

		function arg_70_1.onSingleLineFinish_()
			arg_70_1.onSingleLineUpdate_ = nil
			arg_70_1.onSingleLineFinish_ = nil
			arg_70_1.state_ = "waiting"
		end

		function arg_70_1.playNext_(arg_72_0)
			if arg_72_0 == 1 then
				arg_70_0:Play103102018(arg_70_1)
			end
		end

		function arg_70_1.onSingleLineUpdate_(arg_73_0)
			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story == nil then
				arg_70_1.var_.characterEffect1084ui_story = arg_70_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_73_0 = 0.1

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) then
				if arg_70_1.var_.characterEffect1084ui_story and not isNil(arg_70_1.actors_["1084ui_story"]) then
					arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_70_1.time_ >= 0 + var_73_0 and arg_70_1.time_ < 0 + var_73_0 + arg_73_0 and not isNil(arg_70_1.actors_["1084ui_story"]) and arg_70_1.var_.characterEffect1084ui_story then
				arg_70_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_73_2 = arg_70_1.actors_["1084ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1084ui_story = var_73_2.localPosition

				arg_70_1:ShowWeapon(arg_70_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_73_3 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_3 then
				var_73_2.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_70_1.time_ - 0) / var_73_3)
				var_73_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_2.position).x, (manager.ui.mainCamera.transform.position - var_73_2.position).y, (manager.ui.mainCamera.transform.position - var_73_2.position).z)
				var_73_2.localEulerAngles.z = 0
				var_73_2.localEulerAngles.x = 0
				var_73_2.localEulerAngles = var_73_2.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_3 and arg_70_1.time_ < 0 + var_73_3 + arg_73_0 then
				var_73_2.localPosition = Vector3.New(0, -0.97, -6)
				var_73_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_2.position).x, (manager.ui.mainCamera.transform.position - var_73_2.position).y, (manager.ui.mainCamera.transform.position - var_73_2.position).z)
				var_73_2.localEulerAngles.z = 0
				var_73_2.localEulerAngles.x = 0
				var_73_2.localEulerAngles = var_73_2.localEulerAngles
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_73_4 = arg_70_1.actors_["1011ui_story"].transform

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= 0 + arg_73_0 then
				arg_70_1.var_.moveOldPos1011ui_story = var_73_4.localPosition

				arg_70_1:ShowWeapon(arg_70_1.var_["1011ui_story" .. "Animator"].transform, false)
			end

			local var_73_5 = 0.001

			if 0 <= arg_70_1.time_ and arg_70_1.time_ < 0 + var_73_5 then
				var_73_4.localPosition = Vector3.Lerp(arg_70_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_70_1.time_ - 0) / var_73_5)
				var_73_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_4.position).x, (manager.ui.mainCamera.transform.position - var_73_4.position).y, (manager.ui.mainCamera.transform.position - var_73_4.position).z)
				var_73_4.localEulerAngles.z = 0
				var_73_4.localEulerAngles.x = 0
				var_73_4.localEulerAngles = var_73_4.localEulerAngles
			end

			if arg_70_1.time_ >= 0 + var_73_5 and arg_70_1.time_ < 0 + var_73_5 + arg_73_0 then
				var_73_4.localPosition = Vector3.New(0, 100, 0)
				var_73_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_73_4.position).x, (manager.ui.mainCamera.transform.position - var_73_4.position).y, (manager.ui.mainCamera.transform.position - var_73_4.position).z)
				var_73_4.localEulerAngles.z = 0
				var_73_4.localEulerAngles.x = 0
				var_73_4.localEulerAngles = var_73_4.localEulerAngles
			end

			local var_73_6 = 0
			local var_73_7 = 0.2

			if 0 < arg_70_1.time_ and arg_70_1.time_ <= var_73_6 + arg_73_0 then
				arg_70_1.talkMaxDuration = 0
				arg_70_1.dialogCg_.alpha = 1

				arg_70_1.dialog_:SetActive(true)
				SetActive(arg_70_1.leftNameGo_, true)

				arg_70_1.leftNameTxt_.text = arg_70_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_70_1.leftNameTxt_.transform)

				arg_70_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_70_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_70_1:RecordName(arg_70_1.leftNameTxt_.text)
				SetActive(arg_70_1.iconTrs_.gameObject, false)
				arg_70_1.callingController_:SetSelectedState("normal")

				local var_73_8 = arg_70_1:GetWordFromCfg(103102017)
				local var_73_9 = arg_70_1:FormatText(var_73_8.content)

				arg_70_1.text_.text = var_73_9

				LuaForUtil.ClearLinePrefixSymbol(arg_70_1.text_)

				local var_73_11 = 8 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 8)

				if (8 <= 0 and var_73_7 or var_73_7 * (utf8.len(var_73_9) / 8)) > 0 and var_73_7 < var_73_11 then
					arg_70_1.talkMaxDuration = var_73_11

					if var_73_11 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_11 + var_73_6
					end
				end

				arg_70_1.text_.text = var_73_9
				arg_70_1.typewritter.percent = 0

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102017", "story_v_out_103102.awb") ~= 0 then
					local var_73_12 = manager.audio:GetVoiceLength("story_v_out_103102", "103102017", "story_v_out_103102.awb") / 1000

					if var_73_12 + var_73_6 > arg_70_1.duration_ then
						arg_70_1.duration_ = var_73_12 + var_73_6
					end

					if var_73_8.prefab_name ~= "" and arg_70_1.actors_[var_73_8.prefab_name] ~= nil then
						local var_73_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_70_1.actors_[var_73_8.prefab_name].transform, "story_v_out_103102", "103102017", "story_v_out_103102.awb")

						arg_70_1:RecordAudio("103102017", var_73_13)
						arg_70_1:RecordAudio("103102017", var_73_13)
					else
						arg_70_1:AudioAction("play", "voice", "story_v_out_103102", "103102017", "story_v_out_103102.awb")
					end

					arg_70_1:RecordHistoryTalkVoice("story_v_out_103102", "103102017", "story_v_out_103102.awb")
				end

				arg_70_1:RecordContent(arg_70_1.text_.text)
			end

			local var_73_14 = math.max(var_73_7, arg_70_1.talkMaxDuration)

			if var_73_6 <= arg_70_1.time_ and arg_70_1.time_ < var_73_6 + var_73_14 then
				arg_70_1.typewritter.percent = (arg_70_1.time_ - var_73_6) / var_73_14

				arg_70_1.typewritter:SetDirty()
			end

			if arg_70_1.time_ >= var_73_6 + var_73_14 and arg_70_1.time_ < var_73_6 + var_73_14 + arg_73_0 then
				arg_70_1.typewritter.percent = 1

				arg_70_1.typewritter:SetDirty()
				arg_70_1:ShowNextGo(true)
			end
		end

		arg_70_1.nodeConfigList_ = {
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
			}
		}

		arg_70_1:InitPlayNodeList()
	end,
	Play103102018 = function(arg_74_0, arg_74_1)
		arg_74_1.time_ = 0
		arg_74_1.frameCnt_ = 0
		arg_74_1.state_ = "playing"
		arg_74_1.curTalkId_ = 103102018
		arg_74_1.duration_ = 5

		SetActive(arg_74_1.tipsGo_, false)

		function arg_74_1.onSingleLineFinish_()
			arg_74_1.onSingleLineUpdate_ = nil
			arg_74_1.onSingleLineFinish_ = nil
			arg_74_1.state_ = "waiting"
		end

		function arg_74_1.playNext_(arg_76_0)
			if arg_76_0 == 1 then
				arg_74_0:Play103102019(arg_74_1)
			end
		end

		function arg_74_1.onSingleLineUpdate_(arg_77_0)
			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 and not isNil(arg_74_1.actors_["4010ui_story"]) and arg_74_1.var_.characterEffect4010ui_story == nil then
				arg_74_1.var_.characterEffect4010ui_story = arg_74_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_77_0 = 0.1

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_0 and not isNil(arg_74_1.actors_["4010ui_story"]) then
				if arg_74_1.var_.characterEffect4010ui_story and not isNil(arg_74_1.actors_["4010ui_story"]) then
					arg_74_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_74_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_74_1.time_ - 0) / var_77_0)
				end
			end

			if arg_74_1.time_ >= 0 + var_77_0 and arg_74_1.time_ < 0 + var_77_0 + arg_77_0 and not isNil(arg_74_1.actors_["4010ui_story"]) and arg_74_1.var_.characterEffect4010ui_story then
				arg_74_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_74_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_77_1 = arg_74_1.actors_["1084ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos1084ui_story = var_77_1.localPosition
			end

			local var_77_2 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_2 then
				var_77_1.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_74_1.time_ - 0) / var_77_2)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_2 and arg_74_1.time_ < 0 + var_77_2 + arg_77_0 then
				var_77_1.localPosition = Vector3.New(0, 100, 0)
				var_77_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_1.position).x, (manager.ui.mainCamera.transform.position - var_77_1.position).y, (manager.ui.mainCamera.transform.position - var_77_1.position).z)
				var_77_1.localEulerAngles.z = 0
				var_77_1.localEulerAngles.x = 0
				var_77_1.localEulerAngles = var_77_1.localEulerAngles
			end

			local var_77_3 = arg_74_1.actors_["4010ui_story"].transform

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1.var_.moveOldPos4010ui_story = var_77_3.localPosition
			end

			local var_77_4 = 0.001

			if 0 <= arg_74_1.time_ and arg_74_1.time_ < 0 + var_77_4 then
				var_77_3.localPosition = Vector3.Lerp(arg_74_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_74_1.time_ - 0) / var_77_4)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			if arg_74_1.time_ >= 0 + var_77_4 and arg_74_1.time_ < 0 + var_77_4 + arg_77_0 then
				var_77_3.localPosition = Vector3.New(0, -1.59, -5.2)
				var_77_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_77_3.position).x, (manager.ui.mainCamera.transform.position - var_77_3.position).y, (manager.ui.mainCamera.transform.position - var_77_3.position).z)
				var_77_3.localEulerAngles.z = 0
				var_77_3.localEulerAngles.x = 0
				var_77_3.localEulerAngles = var_77_3.localEulerAngles
			end

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= 0 + arg_77_0 then
				arg_74_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			local var_77_5 = 0
			local var_77_6 = 0.525

			if 0 < arg_74_1.time_ and arg_74_1.time_ <= var_77_5 + arg_77_0 then
				arg_74_1.talkMaxDuration = 0
				arg_74_1.dialogCg_.alpha = 1

				arg_74_1.dialog_:SetActive(true)
				SetActive(arg_74_1.leftNameGo_, false)

				arg_74_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_74_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_74_1:RecordName(arg_74_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_74_1.iconTrs_.gameObject, false)
				arg_74_1.callingController_:SetSelectedState("normal")

				local var_77_7 = arg_74_1:FormatText(arg_74_1:GetWordFromCfg(103102018).content)

				arg_74_1.text_.text = var_77_7

				LuaForUtil.ClearLinePrefixSymbol(arg_74_1.text_)

				local var_77_9 = 21 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_7) / 21)

				if (21 <= 0 and var_77_6 or var_77_6 * (utf8.len(var_77_7) / 21)) > 0 and var_77_6 < var_77_9 then
					arg_74_1.talkMaxDuration = var_77_9

					if var_77_9 + var_77_5 > arg_74_1.duration_ then
						arg_74_1.duration_ = var_77_9 + var_77_5
					end
				end

				arg_74_1.text_.text = var_77_7
				arg_74_1.typewritter.percent = 0

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(false)
				arg_74_1:RecordContent(arg_74_1.text_.text)
			end

			local var_77_10 = math.max(var_77_6, arg_74_1.talkMaxDuration)

			if var_77_5 <= arg_74_1.time_ and arg_74_1.time_ < var_77_5 + var_77_10 then
				arg_74_1.typewritter.percent = (arg_74_1.time_ - var_77_5) / var_77_10

				arg_74_1.typewritter:SetDirty()
			end

			if arg_74_1.time_ >= var_77_5 + var_77_10 and arg_74_1.time_ < var_77_5 + var_77_10 + arg_77_0 then
				arg_74_1.typewritter.percent = 1

				arg_74_1.typewritter:SetDirty()
				arg_74_1:ShowNextGo(true)
			end
		end

		arg_74_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_74_1:InitPlayNodeList()
	end,
	Play103102019 = function(arg_78_0, arg_78_1)
		arg_78_1.time_ = 0
		arg_78_1.frameCnt_ = 0
		arg_78_1.state_ = "playing"
		arg_78_1.curTalkId_ = 103102019
		arg_78_1.duration_ = 5.97

		local var_78_0 = {
			ja = 4.633,
			ko = 5.3,
			zh = 5.966,
			en = 5.033
		}
		local var_78_1 = manager.audio:GetLocalizationFlag()

		if var_78_0[var_78_1] ~= nil then
			arg_78_1.duration_ = var_78_0[var_78_1]
		end

		SetActive(arg_78_1.tipsGo_, false)

		function arg_78_1.onSingleLineFinish_()
			arg_78_1.onSingleLineUpdate_ = nil
			arg_78_1.onSingleLineFinish_ = nil
			arg_78_1.state_ = "waiting"
		end

		function arg_78_1.playNext_(arg_80_0)
			if arg_80_0 == 1 then
				arg_78_0:Play103102020(arg_78_1)
			end
		end

		function arg_78_1.onSingleLineUpdate_(arg_81_0)
			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 and not isNil(arg_78_1.actors_["4010ui_story"]) and arg_78_1.var_.characterEffect4010ui_story == nil then
				arg_78_1.var_.characterEffect4010ui_story = arg_78_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_81_0 = 0.1

			if 0 <= arg_78_1.time_ and arg_78_1.time_ < 0 + var_81_0 and not isNil(arg_78_1.actors_["4010ui_story"]) then
				if arg_78_1.var_.characterEffect4010ui_story and not isNil(arg_78_1.actors_["4010ui_story"]) then
					arg_78_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_78_1.time_ >= 0 + var_81_0 and arg_78_1.time_ < 0 + var_81_0 + arg_81_0 and not isNil(arg_78_1.actors_["4010ui_story"]) and arg_78_1.var_.characterEffect4010ui_story then
				arg_78_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= 0 + arg_81_0 then
				arg_78_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_81_2 = 0
			local var_81_3 = 0.5

			if 0 < arg_78_1.time_ and arg_78_1.time_ <= var_81_2 + arg_81_0 then
				arg_78_1.talkMaxDuration = 0
				arg_78_1.dialogCg_.alpha = 1

				arg_78_1.dialog_:SetActive(true)
				SetActive(arg_78_1.leftNameGo_, true)

				arg_78_1.leftNameTxt_.text = arg_78_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_78_1.leftNameTxt_.transform)

				arg_78_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_78_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_78_1:RecordName(arg_78_1.leftNameTxt_.text)
				SetActive(arg_78_1.iconTrs_.gameObject, false)
				arg_78_1.callingController_:SetSelectedState("normal")

				local var_81_4 = arg_78_1:GetWordFromCfg(103102019)
				local var_81_5 = arg_78_1:FormatText(var_81_4.content)

				arg_78_1.text_.text = var_81_5

				LuaForUtil.ClearLinePrefixSymbol(arg_78_1.text_)

				local var_81_7 = 20 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 20)

				if (20 <= 0 and var_81_3 or var_81_3 * (utf8.len(var_81_5) / 20)) > 0 and var_81_3 < var_81_7 then
					arg_78_1.talkMaxDuration = var_81_7

					if var_81_7 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_7 + var_81_2
					end
				end

				arg_78_1.text_.text = var_81_5
				arg_78_1.typewritter.percent = 0

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102019", "story_v_out_103102.awb") ~= 0 then
					local var_81_8 = manager.audio:GetVoiceLength("story_v_out_103102", "103102019", "story_v_out_103102.awb") / 1000

					if var_81_8 + var_81_2 > arg_78_1.duration_ then
						arg_78_1.duration_ = var_81_8 + var_81_2
					end

					if var_81_4.prefab_name ~= "" and arg_78_1.actors_[var_81_4.prefab_name] ~= nil then
						local var_81_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_78_1.actors_[var_81_4.prefab_name].transform, "story_v_out_103102", "103102019", "story_v_out_103102.awb")

						arg_78_1:RecordAudio("103102019", var_81_9)
						arg_78_1:RecordAudio("103102019", var_81_9)
					else
						arg_78_1:AudioAction("play", "voice", "story_v_out_103102", "103102019", "story_v_out_103102.awb")
					end

					arg_78_1:RecordHistoryTalkVoice("story_v_out_103102", "103102019", "story_v_out_103102.awb")
				end

				arg_78_1:RecordContent(arg_78_1.text_.text)
			end

			local var_81_10 = math.max(var_81_3, arg_78_1.talkMaxDuration)

			if var_81_2 <= arg_78_1.time_ and arg_78_1.time_ < var_81_2 + var_81_10 then
				arg_78_1.typewritter.percent = (arg_78_1.time_ - var_81_2) / var_81_10

				arg_78_1.typewritter:SetDirty()
			end

			if arg_78_1.time_ >= var_81_2 + var_81_10 and arg_78_1.time_ < var_81_2 + var_81_10 + arg_81_0 then
				arg_78_1.typewritter.percent = 1

				arg_78_1.typewritter:SetDirty()
				arg_78_1:ShowNextGo(true)
			end
		end

		arg_78_1.nodeConfigList_ = {}

		arg_78_1:InitPlayNodeList()
	end,
	Play103102020 = function(arg_82_0, arg_82_1)
		arg_82_1.time_ = 0
		arg_82_1.frameCnt_ = 0
		arg_82_1.state_ = "playing"
		arg_82_1.curTalkId_ = 103102020
		arg_82_1.duration_ = 5

		SetActive(arg_82_1.tipsGo_, false)

		function arg_82_1.onSingleLineFinish_()
			arg_82_1.onSingleLineUpdate_ = nil
			arg_82_1.onSingleLineFinish_ = nil
			arg_82_1.state_ = "waiting"
		end

		function arg_82_1.playNext_(arg_84_0)
			if arg_84_0 == 1 then
				arg_82_0:Play103102021(arg_82_1)
			end
		end

		function arg_82_1.onSingleLineUpdate_(arg_85_0)
			if 0 < arg_82_1.time_ and arg_82_1.time_ <= 0 + arg_85_0 then
				arg_82_1.var_.moveOldPos4010ui_story = arg_82_1.actors_["4010ui_story"].transform.localPosition
			end

			local var_85_0 = 0.001

			if 0 <= arg_82_1.time_ and arg_82_1.time_ < 0 + var_85_0 then
				arg_82_1.actors_["4010ui_story"].transform.localPosition = Vector3.Lerp(arg_82_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_82_1.time_ - 0) / var_85_0)
				arg_82_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4010ui_story"].transform.position).z)
				arg_82_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["4010ui_story"].transform.localEulerAngles = arg_82_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			if arg_82_1.time_ >= 0 + var_85_0 and arg_82_1.time_ < 0 + var_85_0 + arg_85_0 then
				arg_82_1.actors_["4010ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_82_1.actors_["4010ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_82_1.actors_["4010ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4010ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_82_1.actors_["4010ui_story"].transform.position).z)
				arg_82_1.actors_["4010ui_story"].transform.localEulerAngles.z = 0
				arg_82_1.actors_["4010ui_story"].transform.localEulerAngles.x = 0
				arg_82_1.actors_["4010ui_story"].transform.localEulerAngles = arg_82_1.actors_["4010ui_story"].transform.localEulerAngles
			end

			local var_85_1 = 0
			local var_85_2 = 0.65

			if 0 < arg_82_1.time_ and arg_82_1.time_ <= var_85_1 + arg_85_0 then
				arg_82_1.talkMaxDuration = 0
				arg_82_1.dialogCg_.alpha = 1

				arg_82_1.dialog_:SetActive(true)
				SetActive(arg_82_1.leftNameGo_, false)

				arg_82_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_82_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_82_1:RecordName(arg_82_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_82_1.iconTrs_.gameObject, false)
				arg_82_1.callingController_:SetSelectedState("normal")

				local var_85_3 = arg_82_1:FormatText(arg_82_1:GetWordFromCfg(103102020).content)

				arg_82_1.text_.text = var_85_3

				LuaForUtil.ClearLinePrefixSymbol(arg_82_1.text_)

				local var_85_5 = 26 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 26)

				if (26 <= 0 and var_85_2 or var_85_2 * (utf8.len(var_85_3) / 26)) > 0 and var_85_2 < var_85_5 then
					arg_82_1.talkMaxDuration = var_85_5

					if var_85_5 + var_85_1 > arg_82_1.duration_ then
						arg_82_1.duration_ = var_85_5 + var_85_1
					end
				end

				arg_82_1.text_.text = var_85_3
				arg_82_1.typewritter.percent = 0

				arg_82_1.typewritter:SetDirty()
				arg_82_1:ShowNextGo(false)
				arg_82_1:RecordContent(arg_82_1.text_.text)
			end

			local var_85_6 = math.max(var_85_2, arg_82_1.talkMaxDuration)

			if var_85_1 <= arg_82_1.time_ and arg_82_1.time_ < var_85_1 + var_85_6 then
				arg_82_1.typewritter.percent = (arg_82_1.time_ - var_85_1) / var_85_6

				arg_82_1.typewritter:SetDirty()
			end

			if arg_82_1.time_ >= var_85_1 + var_85_6 and arg_82_1.time_ < var_85_1 + var_85_6 + arg_85_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_82_1:InitPlayNodeList()
	end,
	Play103102021 = function(arg_86_0, arg_86_1)
		arg_86_1.time_ = 0
		arg_86_1.frameCnt_ = 0
		arg_86_1.state_ = "playing"
		arg_86_1.curTalkId_ = 103102021
		arg_86_1.duration_ = 2.73

		local var_86_0 = {
			ja = 2.733,
			ko = 2.166,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_86_0:Play103102022(arg_86_1)
			end
		end

		function arg_86_1.onSingleLineUpdate_(arg_89_0)
			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story == nil then
				arg_86_1.var_.characterEffect1084ui_story = arg_86_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_89_0 = 0.1

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) then
				if arg_86_1.var_.characterEffect1084ui_story and not isNil(arg_86_1.actors_["1084ui_story"]) then
					arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_86_1.time_ >= 0 + var_89_0 and arg_86_1.time_ < 0 + var_89_0 + arg_89_0 and not isNil(arg_86_1.actors_["1084ui_story"]) and arg_86_1.var_.characterEffect1084ui_story then
				arg_86_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_89_2 = arg_86_1.actors_["1084ui_story"].transform

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1.var_.moveOldPos1084ui_story = var_89_2.localPosition
			end

			local var_89_3 = 0.001

			if 0 <= arg_86_1.time_ and arg_86_1.time_ < 0 + var_89_3 then
				var_89_2.localPosition = Vector3.Lerp(arg_86_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_86_1.time_ - 0) / var_89_3)
				var_89_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_2.position).x, (manager.ui.mainCamera.transform.position - var_89_2.position).y, (manager.ui.mainCamera.transform.position - var_89_2.position).z)
				var_89_2.localEulerAngles.z = 0
				var_89_2.localEulerAngles.x = 0
				var_89_2.localEulerAngles = var_89_2.localEulerAngles
			end

			if arg_86_1.time_ >= 0 + var_89_3 and arg_86_1.time_ < 0 + var_89_3 + arg_89_0 then
				var_89_2.localPosition = Vector3.New(0, -0.97, -6)
				var_89_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_89_2.position).x, (manager.ui.mainCamera.transform.position - var_89_2.position).y, (manager.ui.mainCamera.transform.position - var_89_2.position).z)
				var_89_2.localEulerAngles.z = 0
				var_89_2.localEulerAngles.x = 0
				var_89_2.localEulerAngles = var_89_2.localEulerAngles
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= 0 + arg_89_0 then
				arg_86_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_89_4 = 0
			local var_89_5 = 0.1

			if 0 < arg_86_1.time_ and arg_86_1.time_ <= var_89_4 + arg_89_0 then
				arg_86_1.talkMaxDuration = 0
				arg_86_1.dialogCg_.alpha = 1

				arg_86_1.dialog_:SetActive(true)
				SetActive(arg_86_1.leftNameGo_, true)

				arg_86_1.leftNameTxt_.text = arg_86_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_86_1.leftNameTxt_.transform)

				arg_86_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_86_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_86_1:RecordName(arg_86_1.leftNameTxt_.text)
				SetActive(arg_86_1.iconTrs_.gameObject, false)
				arg_86_1.callingController_:SetSelectedState("normal")

				local var_89_6 = arg_86_1:GetWordFromCfg(103102021)
				local var_89_7 = arg_86_1:FormatText(var_89_6.content)

				arg_86_1.text_.text = var_89_7

				LuaForUtil.ClearLinePrefixSymbol(arg_86_1.text_)

				local var_89_9 = 4 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 4)

				if (4 <= 0 and var_89_5 or var_89_5 * (utf8.len(var_89_7) / 4)) > 0 and var_89_5 < var_89_9 then
					arg_86_1.talkMaxDuration = var_89_9

					if var_89_9 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_9 + var_89_4
					end
				end

				arg_86_1.text_.text = var_89_7
				arg_86_1.typewritter.percent = 0

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102021", "story_v_out_103102.awb") ~= 0 then
					local var_89_10 = manager.audio:GetVoiceLength("story_v_out_103102", "103102021", "story_v_out_103102.awb") / 1000

					if var_89_10 + var_89_4 > arg_86_1.duration_ then
						arg_86_1.duration_ = var_89_10 + var_89_4
					end

					if var_89_6.prefab_name ~= "" and arg_86_1.actors_[var_89_6.prefab_name] ~= nil then
						local var_89_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_86_1.actors_[var_89_6.prefab_name].transform, "story_v_out_103102", "103102021", "story_v_out_103102.awb")

						arg_86_1:RecordAudio("103102021", var_89_11)
						arg_86_1:RecordAudio("103102021", var_89_11)
					else
						arg_86_1:AudioAction("play", "voice", "story_v_out_103102", "103102021", "story_v_out_103102.awb")
					end

					arg_86_1:RecordHistoryTalkVoice("story_v_out_103102", "103102021", "story_v_out_103102.awb")
				end

				arg_86_1:RecordContent(arg_86_1.text_.text)
			end

			local var_89_12 = math.max(var_89_5, arg_86_1.talkMaxDuration)

			if var_89_4 <= arg_86_1.time_ and arg_86_1.time_ < var_89_4 + var_89_12 then
				arg_86_1.typewritter.percent = (arg_86_1.time_ - var_89_4) / var_89_12

				arg_86_1.typewritter:SetDirty()
			end

			if arg_86_1.time_ >= var_89_4 + var_89_12 and arg_86_1.time_ < var_89_4 + var_89_12 + arg_89_0 then
				arg_86_1.typewritter.percent = 1

				arg_86_1.typewritter:SetDirty()
				arg_86_1:ShowNextGo(true)
			end
		end

		arg_86_1.nodeConfigList_ = {
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

		arg_86_1:InitPlayNodeList()
	end,
	Play103102022 = function(arg_90_0, arg_90_1)
		arg_90_1.time_ = 0
		arg_90_1.frameCnt_ = 0
		arg_90_1.state_ = "playing"
		arg_90_1.curTalkId_ = 103102022
		arg_90_1.duration_ = 5.27

		local var_90_0 = {
			ja = 5.266,
			ko = 3.4,
			zh = 4.233,
			en = 3.1
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
				arg_90_0:Play103102023(arg_90_1)
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

			local var_93_2 = arg_90_1.actors_["1084ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos1084ui_story = var_93_2.localPosition
			end

			local var_93_3 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_3 then
				var_93_2.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_90_1.time_ - 0) / var_93_3)
				var_93_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_2.position).x, (manager.ui.mainCamera.transform.position - var_93_2.position).y, (manager.ui.mainCamera.transform.position - var_93_2.position).z)
				var_93_2.localEulerAngles.z = 0
				var_93_2.localEulerAngles.x = 0
				var_93_2.localEulerAngles = var_93_2.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_3 and arg_90_1.time_ < 0 + var_93_3 + arg_93_0 then
				var_93_2.localPosition = Vector3.New(0, 100, 0)
				var_93_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_2.position).x, (manager.ui.mainCamera.transform.position - var_93_2.position).y, (manager.ui.mainCamera.transform.position - var_93_2.position).z)
				var_93_2.localEulerAngles.z = 0
				var_93_2.localEulerAngles.x = 0
				var_93_2.localEulerAngles = var_93_2.localEulerAngles
			end

			local var_93_4 = arg_90_1.actors_["4010ui_story"].transform

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1.var_.moveOldPos4010ui_story = var_93_4.localPosition
			end

			local var_93_5 = 0.001

			if 0 <= arg_90_1.time_ and arg_90_1.time_ < 0 + var_93_5 then
				var_93_4.localPosition = Vector3.Lerp(arg_90_1.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (arg_90_1.time_ - 0) / var_93_5)
				var_93_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_4.position).x, (manager.ui.mainCamera.transform.position - var_93_4.position).y, (manager.ui.mainCamera.transform.position - var_93_4.position).z)
				var_93_4.localEulerAngles.z = 0
				var_93_4.localEulerAngles.x = 0
				var_93_4.localEulerAngles = var_93_4.localEulerAngles
			end

			if arg_90_1.time_ >= 0 + var_93_5 and arg_90_1.time_ < 0 + var_93_5 + arg_93_0 then
				var_93_4.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				var_93_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_93_4.position).x, (manager.ui.mainCamera.transform.position - var_93_4.position).y, (manager.ui.mainCamera.transform.position - var_93_4.position).z)
				var_93_4.localEulerAngles.z = 0
				var_93_4.localEulerAngles.x = 0
				var_93_4.localEulerAngles = var_93_4.localEulerAngles
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= 0 + arg_93_0 then
				arg_90_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_93_6 = 0
			local var_93_7 = 0.425

			if 0 < arg_90_1.time_ and arg_90_1.time_ <= var_93_6 + arg_93_0 then
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

				local var_93_8 = arg_90_1:GetWordFromCfg(103102022)
				local var_93_9 = arg_90_1:FormatText(var_93_8.content)

				arg_90_1.text_.text = var_93_9

				LuaForUtil.ClearLinePrefixSymbol(arg_90_1.text_)

				local var_93_11 = 17 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 17)

				if (17 <= 0 and var_93_7 or var_93_7 * (utf8.len(var_93_9) / 17)) > 0 and var_93_7 < var_93_11 then
					arg_90_1.talkMaxDuration = var_93_11

					if var_93_11 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_11 + var_93_6
					end
				end

				arg_90_1.text_.text = var_93_9
				arg_90_1.typewritter.percent = 0

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102022", "story_v_out_103102.awb") ~= 0 then
					local var_93_12 = manager.audio:GetVoiceLength("story_v_out_103102", "103102022", "story_v_out_103102.awb") / 1000

					if var_93_12 + var_93_6 > arg_90_1.duration_ then
						arg_90_1.duration_ = var_93_12 + var_93_6
					end

					if var_93_8.prefab_name ~= "" and arg_90_1.actors_[var_93_8.prefab_name] ~= nil then
						local var_93_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_90_1.actors_[var_93_8.prefab_name].transform, "story_v_out_103102", "103102022", "story_v_out_103102.awb")

						arg_90_1:RecordAudio("103102022", var_93_13)
						arg_90_1:RecordAudio("103102022", var_93_13)
					else
						arg_90_1:AudioAction("play", "voice", "story_v_out_103102", "103102022", "story_v_out_103102.awb")
					end

					arg_90_1:RecordHistoryTalkVoice("story_v_out_103102", "103102022", "story_v_out_103102.awb")
				end

				arg_90_1:RecordContent(arg_90_1.text_.text)
			end

			local var_93_14 = math.max(var_93_7, arg_90_1.talkMaxDuration)

			if var_93_6 <= arg_90_1.time_ and arg_90_1.time_ < var_93_6 + var_93_14 then
				arg_90_1.typewritter.percent = (arg_90_1.time_ - var_93_6) / var_93_14

				arg_90_1.typewritter:SetDirty()
			end

			if arg_90_1.time_ >= var_93_6 + var_93_14 and arg_90_1.time_ < var_93_6 + var_93_14 + arg_93_0 then
				arg_90_1.typewritter.percent = 1

				arg_90_1.typewritter:SetDirty()
				arg_90_1:ShowNextGo(true)
			end
		end

		arg_90_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_90_1:InitPlayNodeList()
	end,
	Play103102023 = function(arg_94_0, arg_94_1)
		arg_94_1.time_ = 0
		arg_94_1.frameCnt_ = 0
		arg_94_1.state_ = "playing"
		arg_94_1.curTalkId_ = 103102023
		arg_94_1.duration_ = 2.27

		local var_94_0 = {
			ja = 2.266,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_94_0:Play103102024(arg_94_1)
			end
		end

		function arg_94_1.onSingleLineUpdate_(arg_97_0)
			if arg_94_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_97_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_94_1.stage_.transform)

				var_97_0.name = "1019ui_story"
				var_97_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_94_1.actors_["1019ui_story"] = var_97_0

				local var_97_1 = var_97_0:GetComponentInChildren(typeof(CharacterEffect))

				var_97_1.enabled = true

				local var_97_2 = GameObjectTools.GetOrAddComponent(var_97_0, typeof(DynamicBoneHelper))

				if var_97_2 then
					var_97_2:EnableDynamicBone(false)
				end

				arg_94_1:ShowWeapon(var_97_1.transform, false)

				arg_94_1.var_["1019ui_story" .. "Animator"] = var_97_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_94_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_94_1.var_["1019ui_story" .. "LipSync"] = var_97_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_97_3 = arg_94_1.actors_["1019ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1019ui_story == nil then
				arg_94_1.var_.characterEffect1019ui_story = var_97_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_4 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_4 and not isNil(var_97_3) then
				if arg_94_1.var_.characterEffect1019ui_story and not isNil(var_97_3) then
					arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_94_1.time_ >= 0 + var_97_4 and arg_94_1.time_ < 0 + var_97_4 + arg_97_0 and not isNil(var_97_3) and arg_94_1.var_.characterEffect1019ui_story then
				arg_94_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_97_6 = arg_94_1.actors_["4010ui_story"]

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect4010ui_story == nil then
				arg_94_1.var_.characterEffect4010ui_story = var_97_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_97_7 = 0.1

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_7 and not isNil(var_97_6) then
				if arg_94_1.var_.characterEffect4010ui_story and not isNil(var_97_6) then
					arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_94_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_94_1.time_ - 0) / var_97_7)
				end
			end

			if arg_94_1.time_ >= 0 + var_97_7 and arg_94_1.time_ < 0 + var_97_7 + arg_97_0 and not isNil(var_97_6) and arg_94_1.var_.characterEffect4010ui_story then
				arg_94_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_94_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_97_8 = arg_94_1.actors_["1019ui_story"].transform

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1.var_.moveOldPos1019ui_story = var_97_8.localPosition
			end

			local var_97_9 = 0.001

			if 0 <= arg_94_1.time_ and arg_94_1.time_ < 0 + var_97_9 then
				var_97_8.localPosition = Vector3.Lerp(arg_94_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_94_1.time_ - 0) / var_97_9)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if arg_94_1.time_ >= 0 + var_97_9 and arg_94_1.time_ < 0 + var_97_9 + arg_97_0 then
				var_97_8.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_97_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_97_8.position).x, (manager.ui.mainCamera.transform.position - var_97_8.position).y, (manager.ui.mainCamera.transform.position - var_97_8.position).z)
				var_97_8.localEulerAngles.z = 0
				var_97_8.localEulerAngles.x = 0
				var_97_8.localEulerAngles = var_97_8.localEulerAngles
			end

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= 0 + arg_97_0 then
				arg_94_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_97_10 = 0
			local var_97_11 = 0.15

			if 0 < arg_94_1.time_ and arg_94_1.time_ <= var_97_10 + arg_97_0 then
				arg_94_1.talkMaxDuration = 0
				arg_94_1.dialogCg_.alpha = 1

				arg_94_1.dialog_:SetActive(true)
				SetActive(arg_94_1.leftNameGo_, true)

				arg_94_1.leftNameTxt_.text = arg_94_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_94_1.leftNameTxt_.transform)

				arg_94_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_94_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_94_1:RecordName(arg_94_1.leftNameTxt_.text)
				SetActive(arg_94_1.iconTrs_.gameObject, false)
				arg_94_1.callingController_:SetSelectedState("normal")

				local var_97_12 = arg_94_1:GetWordFromCfg(103102023)
				local var_97_13 = arg_94_1:FormatText(var_97_12.content)

				arg_94_1.text_.text = var_97_13

				LuaForUtil.ClearLinePrefixSymbol(arg_94_1.text_)

				local var_97_15 = 6 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 6)

				if (6 <= 0 and var_97_11 or var_97_11 * (utf8.len(var_97_13) / 6)) > 0 and var_97_11 < var_97_15 then
					arg_94_1.talkMaxDuration = var_97_15

					if var_97_15 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_15 + var_97_10
					end
				end

				arg_94_1.text_.text = var_97_13
				arg_94_1.typewritter.percent = 0

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102023", "story_v_out_103102.awb") ~= 0 then
					local var_97_16 = manager.audio:GetVoiceLength("story_v_out_103102", "103102023", "story_v_out_103102.awb") / 1000

					if var_97_16 + var_97_10 > arg_94_1.duration_ then
						arg_94_1.duration_ = var_97_16 + var_97_10
					end

					if var_97_12.prefab_name ~= "" and arg_94_1.actors_[var_97_12.prefab_name] ~= nil then
						local var_97_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_94_1.actors_[var_97_12.prefab_name].transform, "story_v_out_103102", "103102023", "story_v_out_103102.awb")

						arg_94_1:RecordAudio("103102023", var_97_17)
						arg_94_1:RecordAudio("103102023", var_97_17)
					else
						arg_94_1:AudioAction("play", "voice", "story_v_out_103102", "103102023", "story_v_out_103102.awb")
					end

					arg_94_1:RecordHistoryTalkVoice("story_v_out_103102", "103102023", "story_v_out_103102.awb")
				end

				arg_94_1:RecordContent(arg_94_1.text_.text)
			end

			local var_97_18 = math.max(var_97_11, arg_94_1.talkMaxDuration)

			if var_97_10 <= arg_94_1.time_ and arg_94_1.time_ < var_97_10 + var_97_18 then
				arg_94_1.typewritter.percent = (arg_94_1.time_ - var_97_10) / var_97_18

				arg_94_1.typewritter:SetDirty()
			end

			if arg_94_1.time_ >= var_97_10 + var_97_18 and arg_94_1.time_ < var_97_10 + var_97_18 + arg_97_0 then
				arg_94_1.typewritter.percent = 1

				arg_94_1.typewritter:SetDirty()
				arg_94_1:ShowNextGo(true)
			end
		end

		arg_94_1.nodeConfigList_ = {
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

		arg_94_1:InitPlayNodeList()
	end,
	Play103102024 = function(arg_98_0, arg_98_1)
		arg_98_1.time_ = 0
		arg_98_1.frameCnt_ = 0
		arg_98_1.state_ = "playing"
		arg_98_1.curTalkId_ = 103102024
		arg_98_1.duration_ = 5

		SetActive(arg_98_1.tipsGo_, false)

		function arg_98_1.onSingleLineFinish_()
			arg_98_1.onSingleLineUpdate_ = nil
			arg_98_1.onSingleLineFinish_ = nil
			arg_98_1.state_ = "waiting"
		end

		function arg_98_1.playNext_(arg_100_0)
			if arg_100_0 == 1 then
				arg_98_0:Play103102025(arg_98_1)
			end
		end

		function arg_98_1.onSingleLineUpdate_(arg_101_0)
			if 0 < arg_98_1.time_ and arg_98_1.time_ <= 0 + arg_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) and arg_98_1.var_.characterEffect1019ui_story == nil then
				arg_98_1.var_.characterEffect1019ui_story = arg_98_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_101_0 = 0.1

			if 0 <= arg_98_1.time_ and arg_98_1.time_ < 0 + var_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) then
				if arg_98_1.var_.characterEffect1019ui_story and not isNil(arg_98_1.actors_["1019ui_story"]) then
					arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_98_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_98_1.time_ - 0) / var_101_0)
				end
			end

			if arg_98_1.time_ >= 0 + var_101_0 and arg_98_1.time_ < 0 + var_101_0 + arg_101_0 and not isNil(arg_98_1.actors_["1019ui_story"]) and arg_98_1.var_.characterEffect1019ui_story then
				arg_98_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_98_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_101_1 = 0
			local var_101_2 = 0.55

			if 0 < arg_98_1.time_ and arg_98_1.time_ <= var_101_1 + arg_101_0 then
				arg_98_1.talkMaxDuration = 0
				arg_98_1.dialogCg_.alpha = 1

				arg_98_1.dialog_:SetActive(true)
				SetActive(arg_98_1.leftNameGo_, false)

				arg_98_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_98_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_98_1:RecordName(arg_98_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_98_1.iconTrs_.gameObject, false)
				arg_98_1.callingController_:SetSelectedState("normal")

				local var_101_3 = arg_98_1:FormatText(arg_98_1:GetWordFromCfg(103102024).content)

				arg_98_1.text_.text = var_101_3

				LuaForUtil.ClearLinePrefixSymbol(arg_98_1.text_)

				local var_101_5 = 22 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 22)

				if (22 <= 0 and var_101_2 or var_101_2 * (utf8.len(var_101_3) / 22)) > 0 and var_101_2 < var_101_5 then
					arg_98_1.talkMaxDuration = var_101_5

					if var_101_5 + var_101_1 > arg_98_1.duration_ then
						arg_98_1.duration_ = var_101_5 + var_101_1
					end
				end

				arg_98_1.text_.text = var_101_3
				arg_98_1.typewritter.percent = 0

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(false)
				arg_98_1:RecordContent(arg_98_1.text_.text)
			end

			local var_101_6 = math.max(var_101_2, arg_98_1.talkMaxDuration)

			if var_101_1 <= arg_98_1.time_ and arg_98_1.time_ < var_101_1 + var_101_6 then
				arg_98_1.typewritter.percent = (arg_98_1.time_ - var_101_1) / var_101_6

				arg_98_1.typewritter:SetDirty()
			end

			if arg_98_1.time_ >= var_101_1 + var_101_6 and arg_98_1.time_ < var_101_1 + var_101_6 + arg_101_0 then
				arg_98_1.typewritter.percent = 1

				arg_98_1.typewritter:SetDirty()
				arg_98_1:ShowNextGo(true)
			end
		end

		arg_98_1.nodeConfigList_ = {}

		arg_98_1:InitPlayNodeList()
	end,
	Play103102025 = function(arg_102_0, arg_102_1)
		arg_102_1.time_ = 0
		arg_102_1.frameCnt_ = 0
		arg_102_1.state_ = "playing"
		arg_102_1.curTalkId_ = 103102025
		arg_102_1.duration_ = 8.5

		local var_102_0 = {
			ja = 8.5,
			ko = 6.766,
			zh = 7.933,
			en = 8.366
		}
		local var_102_1 = manager.audio:GetLocalizationFlag()

		if var_102_0[var_102_1] ~= nil then
			arg_102_1.duration_ = var_102_0[var_102_1]
		end

		SetActive(arg_102_1.tipsGo_, false)

		function arg_102_1.onSingleLineFinish_()
			arg_102_1.onSingleLineUpdate_ = nil
			arg_102_1.onSingleLineFinish_ = nil
			arg_102_1.state_ = "waiting"
		end

		function arg_102_1.playNext_(arg_104_0)
			if arg_104_0 == 1 then
				arg_102_0:Play103102026(arg_102_1)
			end
		end

		function arg_102_1.onSingleLineUpdate_(arg_105_0)
			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 and not isNil(arg_102_1.actors_["4010ui_story"]) and arg_102_1.var_.characterEffect4010ui_story == nil then
				arg_102_1.var_.characterEffect4010ui_story = arg_102_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_105_0 = 0.1

			if 0 <= arg_102_1.time_ and arg_102_1.time_ < 0 + var_105_0 and not isNil(arg_102_1.actors_["4010ui_story"]) then
				if arg_102_1.var_.characterEffect4010ui_story and not isNil(arg_102_1.actors_["4010ui_story"]) then
					arg_102_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_102_1.time_ >= 0 + var_105_0 and arg_102_1.time_ < 0 + var_105_0 + arg_105_0 and not isNil(arg_102_1.actors_["4010ui_story"]) and arg_102_1.var_.characterEffect4010ui_story then
				arg_102_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= 0 + arg_105_0 then
				arg_102_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010actionlink/4010action426")
			end

			local var_105_2 = 0
			local var_105_3 = 0.9

			if 0 < arg_102_1.time_ and arg_102_1.time_ <= var_105_2 + arg_105_0 then
				arg_102_1.talkMaxDuration = 0
				arg_102_1.dialogCg_.alpha = 1

				arg_102_1.dialog_:SetActive(true)
				SetActive(arg_102_1.leftNameGo_, true)

				arg_102_1.leftNameTxt_.text = arg_102_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_102_1.leftNameTxt_.transform)

				arg_102_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_102_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_102_1:RecordName(arg_102_1.leftNameTxt_.text)
				SetActive(arg_102_1.iconTrs_.gameObject, false)
				arg_102_1.callingController_:SetSelectedState("normal")

				local var_105_4 = arg_102_1:GetWordFromCfg(103102025)
				local var_105_5 = arg_102_1:FormatText(var_105_4.content)

				arg_102_1.text_.text = var_105_5

				LuaForUtil.ClearLinePrefixSymbol(arg_102_1.text_)

				local var_105_7 = 36 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 36)

				if (36 <= 0 and var_105_3 or var_105_3 * (utf8.len(var_105_5) / 36)) > 0 and var_105_3 < var_105_7 then
					arg_102_1.talkMaxDuration = var_105_7

					if var_105_7 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_7 + var_105_2
					end
				end

				arg_102_1.text_.text = var_105_5
				arg_102_1.typewritter.percent = 0

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102025", "story_v_out_103102.awb") ~= 0 then
					local var_105_8 = manager.audio:GetVoiceLength("story_v_out_103102", "103102025", "story_v_out_103102.awb") / 1000

					if var_105_8 + var_105_2 > arg_102_1.duration_ then
						arg_102_1.duration_ = var_105_8 + var_105_2
					end

					if var_105_4.prefab_name ~= "" and arg_102_1.actors_[var_105_4.prefab_name] ~= nil then
						local var_105_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_102_1.actors_[var_105_4.prefab_name].transform, "story_v_out_103102", "103102025", "story_v_out_103102.awb")

						arg_102_1:RecordAudio("103102025", var_105_9)
						arg_102_1:RecordAudio("103102025", var_105_9)
					else
						arg_102_1:AudioAction("play", "voice", "story_v_out_103102", "103102025", "story_v_out_103102.awb")
					end

					arg_102_1:RecordHistoryTalkVoice("story_v_out_103102", "103102025", "story_v_out_103102.awb")
				end

				arg_102_1:RecordContent(arg_102_1.text_.text)
			end

			local var_105_10 = math.max(var_105_3, arg_102_1.talkMaxDuration)

			if var_105_2 <= arg_102_1.time_ and arg_102_1.time_ < var_105_2 + var_105_10 then
				arg_102_1.typewritter.percent = (arg_102_1.time_ - var_105_2) / var_105_10

				arg_102_1.typewritter:SetDirty()
			end

			if arg_102_1.time_ >= var_105_2 + var_105_10 and arg_102_1.time_ < var_105_2 + var_105_10 + arg_105_0 then
				arg_102_1.typewritter.percent = 1

				arg_102_1.typewritter:SetDirty()
				arg_102_1:ShowNextGo(true)
			end
		end

		arg_102_1.nodeConfigList_ = {}

		arg_102_1:InitPlayNodeList()
	end,
	Play103102026 = function(arg_106_0, arg_106_1)
		arg_106_1.time_ = 0
		arg_106_1.frameCnt_ = 0
		arg_106_1.state_ = "playing"
		arg_106_1.curTalkId_ = 103102026
		arg_106_1.duration_ = 3.13

		local var_106_0 = {
			ja = 3.133,
			ko = 1.999999999999,
			zh = 2.1,
			en = 2.933
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
				arg_106_0:Play103102027(arg_106_1)
			end
		end

		function arg_106_1.onSingleLineUpdate_(arg_109_0)
			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) and arg_106_1.var_.characterEffect1019ui_story == nil then
				arg_106_1.var_.characterEffect1019ui_story = arg_106_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_0 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) then
				if arg_106_1.var_.characterEffect1019ui_story and not isNil(arg_106_1.actors_["1019ui_story"]) then
					arg_106_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_106_1.time_ >= 0 + var_109_0 and arg_106_1.time_ < 0 + var_109_0 + arg_109_0 and not isNil(arg_106_1.actors_["1019ui_story"]) and arg_106_1.var_.characterEffect1019ui_story then
				arg_106_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_109_2 = arg_106_1.actors_["4010ui_story"]

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect4010ui_story == nil then
				arg_106_1.var_.characterEffect4010ui_story = var_109_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_109_3 = 0.1

			if 0 <= arg_106_1.time_ and arg_106_1.time_ < 0 + var_109_3 and not isNil(var_109_2) then
				if arg_106_1.var_.characterEffect4010ui_story and not isNil(var_109_2) then
					arg_106_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_106_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_106_1.time_ - 0) / var_109_3)
				end
			end

			if arg_106_1.time_ >= 0 + var_109_3 and arg_106_1.time_ < 0 + var_109_3 + arg_109_0 and not isNil(var_109_2) and arg_106_1.var_.characterEffect4010ui_story then
				arg_106_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_106_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019actionlink/1019action456")
			end

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= 0 + arg_109_0 then
				arg_106_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_109_4 = 0
			local var_109_5 = 0.3

			if 0 < arg_106_1.time_ and arg_106_1.time_ <= var_109_4 + arg_109_0 then
				arg_106_1.talkMaxDuration = 0
				arg_106_1.dialogCg_.alpha = 1

				arg_106_1.dialog_:SetActive(true)
				SetActive(arg_106_1.leftNameGo_, true)

				arg_106_1.leftNameTxt_.text = arg_106_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_106_1.leftNameTxt_.transform)

				arg_106_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_106_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_106_1:RecordName(arg_106_1.leftNameTxt_.text)
				SetActive(arg_106_1.iconTrs_.gameObject, false)
				arg_106_1.callingController_:SetSelectedState("normal")

				local var_109_6 = arg_106_1:GetWordFromCfg(103102026)
				local var_109_7 = arg_106_1:FormatText(var_109_6.content)

				arg_106_1.text_.text = var_109_7

				LuaForUtil.ClearLinePrefixSymbol(arg_106_1.text_)

				local var_109_9 = 12 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 12)

				if (12 <= 0 and var_109_5 or var_109_5 * (utf8.len(var_109_7) / 12)) > 0 and var_109_5 < var_109_9 then
					arg_106_1.talkMaxDuration = var_109_9

					if var_109_9 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_9 + var_109_4
					end
				end

				arg_106_1.text_.text = var_109_7
				arg_106_1.typewritter.percent = 0

				arg_106_1.typewritter:SetDirty()
				arg_106_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102026", "story_v_out_103102.awb") ~= 0 then
					local var_109_10 = manager.audio:GetVoiceLength("story_v_out_103102", "103102026", "story_v_out_103102.awb") / 1000

					if var_109_10 + var_109_4 > arg_106_1.duration_ then
						arg_106_1.duration_ = var_109_10 + var_109_4
					end

					if var_109_6.prefab_name ~= "" and arg_106_1.actors_[var_109_6.prefab_name] ~= nil then
						local var_109_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_106_1.actors_[var_109_6.prefab_name].transform, "story_v_out_103102", "103102026", "story_v_out_103102.awb")

						arg_106_1:RecordAudio("103102026", var_109_11)
						arg_106_1:RecordAudio("103102026", var_109_11)
					else
						arg_106_1:AudioAction("play", "voice", "story_v_out_103102", "103102026", "story_v_out_103102.awb")
					end

					arg_106_1:RecordHistoryTalkVoice("story_v_out_103102", "103102026", "story_v_out_103102.awb")
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

		arg_106_1.nodeConfigList_ = {}

		arg_106_1:InitPlayNodeList()
	end,
	Play103102027 = function(arg_110_0, arg_110_1)
		arg_110_1.time_ = 0
		arg_110_1.frameCnt_ = 0
		arg_110_1.state_ = "playing"
		arg_110_1.curTalkId_ = 103102027
		arg_110_1.duration_ = 4.4

		local var_110_0 = {
			ja = 4.4,
			ko = 3.566,
			zh = 3.366,
			en = 3.866
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
				arg_110_0:Play103102028(arg_110_1)
			end
		end

		function arg_110_1.onSingleLineUpdate_(arg_113_0)
			if arg_110_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_113_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_110_1.stage_.transform)

				var_113_0.name = "3009ui_story"
				var_113_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_110_1.actors_["3009ui_story"] = var_113_0

				local var_113_1 = var_113_0:GetComponentInChildren(typeof(CharacterEffect))

				var_113_1.enabled = true

				local var_113_2 = GameObjectTools.GetOrAddComponent(var_113_0, typeof(DynamicBoneHelper))

				if var_113_2 then
					var_113_2:EnableDynamicBone(false)
				end

				arg_110_1:ShowWeapon(var_113_1.transform, false)

				arg_110_1.var_["3009ui_story" .. "Animator"] = var_113_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_110_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_110_1.var_["3009ui_story" .. "LipSync"] = var_113_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_113_3 = arg_110_1.actors_["3009ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect3009ui_story == nil then
				arg_110_1.var_.characterEffect3009ui_story = var_113_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_4 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_4 and not isNil(var_113_3) then
				if arg_110_1.var_.characterEffect3009ui_story and not isNil(var_113_3) then
					arg_110_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_110_1.time_ >= 0 + var_113_4 and arg_110_1.time_ < 0 + var_113_4 + arg_113_0 and not isNil(var_113_3) and arg_110_1.var_.characterEffect3009ui_story then
				arg_110_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_113_6 = arg_110_1.actors_["1019ui_story"]

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1019ui_story == nil then
				arg_110_1.var_.characterEffect1019ui_story = var_113_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_113_7 = 0.1

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_7 and not isNil(var_113_6) then
				if arg_110_1.var_.characterEffect1019ui_story and not isNil(var_113_6) then
					arg_110_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_110_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_110_1.time_ - 0) / var_113_7)
				end
			end

			if arg_110_1.time_ >= 0 + var_113_7 and arg_110_1.time_ < 0 + var_113_7 + arg_113_0 and not isNil(var_113_6) and arg_110_1.var_.characterEffect1019ui_story then
				arg_110_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_110_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_113_8 = arg_110_1.actors_["1019ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos1019ui_story = var_113_8.localPosition
			end

			local var_113_9 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_9 then
				var_113_8.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_9)
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

			local var_113_10 = arg_110_1.actors_["4010ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos4010ui_story = var_113_10.localPosition
			end

			local var_113_11 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_11 then
				var_113_10.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_110_1.time_ - 0) / var_113_11)
				var_113_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_10.position).x, (manager.ui.mainCamera.transform.position - var_113_10.position).y, (manager.ui.mainCamera.transform.position - var_113_10.position).z)
				var_113_10.localEulerAngles.z = 0
				var_113_10.localEulerAngles.x = 0
				var_113_10.localEulerAngles = var_113_10.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_11 and arg_110_1.time_ < 0 + var_113_11 + arg_113_0 then
				var_113_10.localPosition = Vector3.New(0, 100, 0)
				var_113_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_10.position).x, (manager.ui.mainCamera.transform.position - var_113_10.position).y, (manager.ui.mainCamera.transform.position - var_113_10.position).z)
				var_113_10.localEulerAngles.z = 0
				var_113_10.localEulerAngles.x = 0
				var_113_10.localEulerAngles = var_113_10.localEulerAngles
			end

			local var_113_12 = arg_110_1.actors_["3009ui_story"].transform

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1.var_.moveOldPos3009ui_story = var_113_12.localPosition

				arg_110_1:ShowWeapon(arg_110_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_113_13 = 0.001

			if 0 <= arg_110_1.time_ and arg_110_1.time_ < 0 + var_113_13 then
				var_113_12.localPosition = Vector3.Lerp(arg_110_1.var_.moveOldPos3009ui_story, Vector3.New(0, -1.75, -4.8), (arg_110_1.time_ - 0) / var_113_13)
				var_113_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_12.position).x, (manager.ui.mainCamera.transform.position - var_113_12.position).y, (manager.ui.mainCamera.transform.position - var_113_12.position).z)
				var_113_12.localEulerAngles.z = 0
				var_113_12.localEulerAngles.x = 0
				var_113_12.localEulerAngles = var_113_12.localEulerAngles
			end

			if arg_110_1.time_ >= 0 + var_113_13 and arg_110_1.time_ < 0 + var_113_13 + arg_113_0 then
				var_113_12.localPosition = Vector3.New(0, -1.75, -4.8)
				var_113_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_113_12.position).x, (manager.ui.mainCamera.transform.position - var_113_12.position).y, (manager.ui.mainCamera.transform.position - var_113_12.position).z)
				var_113_12.localEulerAngles.z = 0
				var_113_12.localEulerAngles.x = 0
				var_113_12.localEulerAngles = var_113_12.localEulerAngles
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= 0 + arg_113_0 then
				arg_110_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_113_14 = 0
			local var_113_15 = 0.425

			if 0 < arg_110_1.time_ and arg_110_1.time_ <= var_113_14 + arg_113_0 then
				arg_110_1.talkMaxDuration = 0
				arg_110_1.dialogCg_.alpha = 1

				arg_110_1.dialog_:SetActive(true)
				SetActive(arg_110_1.leftNameGo_, true)

				arg_110_1.leftNameTxt_.text = arg_110_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_110_1.leftNameTxt_.transform)

				arg_110_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_110_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_110_1:RecordName(arg_110_1.leftNameTxt_.text)
				SetActive(arg_110_1.iconTrs_.gameObject, false)
				arg_110_1.callingController_:SetSelectedState("normal")

				local var_113_16 = arg_110_1:GetWordFromCfg(103102027)
				local var_113_17 = arg_110_1:FormatText(var_113_16.content)

				arg_110_1.text_.text = var_113_17

				LuaForUtil.ClearLinePrefixSymbol(arg_110_1.text_)

				local var_113_19 = 17 <= 0 and var_113_15 or var_113_15 * (utf8.len(var_113_17) / 17)

				if (17 <= 0 and var_113_15 or var_113_15 * (utf8.len(var_113_17) / 17)) > 0 and var_113_15 < var_113_19 then
					arg_110_1.talkMaxDuration = var_113_19

					if var_113_19 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_19 + var_113_14
					end
				end

				arg_110_1.text_.text = var_113_17
				arg_110_1.typewritter.percent = 0

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102027", "story_v_out_103102.awb") ~= 0 then
					local var_113_20 = manager.audio:GetVoiceLength("story_v_out_103102", "103102027", "story_v_out_103102.awb") / 1000

					if var_113_20 + var_113_14 > arg_110_1.duration_ then
						arg_110_1.duration_ = var_113_20 + var_113_14
					end

					if var_113_16.prefab_name ~= "" and arg_110_1.actors_[var_113_16.prefab_name] ~= nil then
						local var_113_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_110_1.actors_[var_113_16.prefab_name].transform, "story_v_out_103102", "103102027", "story_v_out_103102.awb")

						arg_110_1:RecordAudio("103102027", var_113_21)
						arg_110_1:RecordAudio("103102027", var_113_21)
					else
						arg_110_1:AudioAction("play", "voice", "story_v_out_103102", "103102027", "story_v_out_103102.awb")
					end

					arg_110_1:RecordHistoryTalkVoice("story_v_out_103102", "103102027", "story_v_out_103102.awb")
				end

				arg_110_1:RecordContent(arg_110_1.text_.text)
			end

			local var_113_22 = math.max(var_113_15, arg_110_1.talkMaxDuration)

			if var_113_14 <= arg_110_1.time_ and arg_110_1.time_ < var_113_14 + var_113_22 then
				arg_110_1.typewritter.percent = (arg_110_1.time_ - var_113_14) / var_113_22

				arg_110_1.typewritter:SetDirty()
			end

			if arg_110_1.time_ >= var_113_14 + var_113_22 and arg_110_1.time_ < var_113_14 + var_113_22 + arg_113_0 then
				arg_110_1.typewritter.percent = 1

				arg_110_1.typewritter:SetDirty()
				arg_110_1:ShowNextGo(true)
			end
		end

		arg_110_1.nodeConfigList_ = {
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
				actorName = "3009ui_story",
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
	Play103102028 = function(arg_114_0, arg_114_1)
		arg_114_1.time_ = 0
		arg_114_1.frameCnt_ = 0
		arg_114_1.state_ = "playing"
		arg_114_1.curTalkId_ = 103102028
		arg_114_1.duration_ = 8.93

		local var_114_0 = {
			ja = 8.933,
			ko = 4.6,
			zh = 4,
			en = 5.033
		}
		local var_114_1 = manager.audio:GetLocalizationFlag()

		if var_114_0[var_114_1] ~= nil then
			arg_114_1.duration_ = var_114_0[var_114_1]
		end

		SetActive(arg_114_1.tipsGo_, false)

		function arg_114_1.onSingleLineFinish_()
			arg_114_1.onSingleLineUpdate_ = nil
			arg_114_1.onSingleLineFinish_ = nil
			arg_114_1.state_ = "waiting"
		end

		function arg_114_1.playNext_(arg_116_0)
			if arg_116_0 == 1 then
				arg_114_0:Play103102029(arg_114_1)
			end
		end

		function arg_114_1.onSingleLineUpdate_(arg_117_0)
			if 0 < arg_114_1.time_ and arg_114_1.time_ <= 0 + arg_117_0 then
				arg_114_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_117_0 = 0
			local var_117_1 = 0.6

			if 0 < arg_114_1.time_ and arg_114_1.time_ <= var_117_0 + arg_117_0 then
				arg_114_1.talkMaxDuration = 0
				arg_114_1.dialogCg_.alpha = 1

				arg_114_1.dialog_:SetActive(true)
				SetActive(arg_114_1.leftNameGo_, true)

				arg_114_1.leftNameTxt_.text = arg_114_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_114_1.leftNameTxt_.transform)

				arg_114_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_114_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_114_1:RecordName(arg_114_1.leftNameTxt_.text)
				SetActive(arg_114_1.iconTrs_.gameObject, false)
				arg_114_1.callingController_:SetSelectedState("normal")

				local var_117_2 = arg_114_1:GetWordFromCfg(103102028)
				local var_117_3 = arg_114_1:FormatText(var_117_2.content)

				arg_114_1.text_.text = var_117_3

				LuaForUtil.ClearLinePrefixSymbol(arg_114_1.text_)

				local var_117_5 = 24 <= 0 and var_117_1 or var_117_1 * (utf8.len(var_117_3) / 24)

				if (24 <= 0 and var_117_1 or var_117_1 * (utf8.len(var_117_3) / 24)) > 0 and var_117_1 < var_117_5 then
					arg_114_1.talkMaxDuration = var_117_5

					if var_117_5 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_5 + var_117_0
					end
				end

				arg_114_1.text_.text = var_117_3
				arg_114_1.typewritter.percent = 0

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102028", "story_v_out_103102.awb") ~= 0 then
					local var_117_6 = manager.audio:GetVoiceLength("story_v_out_103102", "103102028", "story_v_out_103102.awb") / 1000

					if var_117_6 + var_117_0 > arg_114_1.duration_ then
						arg_114_1.duration_ = var_117_6 + var_117_0
					end

					if var_117_2.prefab_name ~= "" and arg_114_1.actors_[var_117_2.prefab_name] ~= nil then
						local var_117_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_114_1.actors_[var_117_2.prefab_name].transform, "story_v_out_103102", "103102028", "story_v_out_103102.awb")

						arg_114_1:RecordAudio("103102028", var_117_7)
						arg_114_1:RecordAudio("103102028", var_117_7)
					else
						arg_114_1:AudioAction("play", "voice", "story_v_out_103102", "103102028", "story_v_out_103102.awb")
					end

					arg_114_1:RecordHistoryTalkVoice("story_v_out_103102", "103102028", "story_v_out_103102.awb")
				end

				arg_114_1:RecordContent(arg_114_1.text_.text)
			end

			local var_117_8 = math.max(var_117_1, arg_114_1.talkMaxDuration)

			if var_117_0 <= arg_114_1.time_ and arg_114_1.time_ < var_117_0 + var_117_8 then
				arg_114_1.typewritter.percent = (arg_114_1.time_ - var_117_0) / var_117_8

				arg_114_1.typewritter:SetDirty()
			end

			if arg_114_1.time_ >= var_117_0 + var_117_8 and arg_114_1.time_ < var_117_0 + var_117_8 + arg_117_0 then
				arg_114_1.typewritter.percent = 1

				arg_114_1.typewritter:SetDirty()
				arg_114_1:ShowNextGo(true)
			end
		end

		arg_114_1.nodeConfigList_ = {}

		arg_114_1:InitPlayNodeList()
	end,
	Play103102029 = function(arg_118_0, arg_118_1)
		arg_118_1.time_ = 0
		arg_118_1.frameCnt_ = 0
		arg_118_1.state_ = "playing"
		arg_118_1.curTalkId_ = 103102029
		arg_118_1.duration_ = 9.2

		local var_118_0 = {
			ja = 9.2,
			ko = 6.533,
			zh = 7.6,
			en = 7.933
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
				arg_118_0:Play103102030(arg_118_1)
			end
		end

		function arg_118_1.onSingleLineUpdate_(arg_121_0)
			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(arg_118_1.actors_["4010ui_story"]) and arg_118_1.var_.characterEffect4010ui_story == nil then
				arg_118_1.var_.characterEffect4010ui_story = arg_118_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_0 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_0 and not isNil(arg_118_1.actors_["4010ui_story"]) then
				if arg_118_1.var_.characterEffect4010ui_story and not isNil(arg_118_1.actors_["4010ui_story"]) then
					arg_118_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_118_1.time_ >= 0 + var_121_0 and arg_118_1.time_ < 0 + var_121_0 + arg_121_0 and not isNil(arg_118_1.actors_["4010ui_story"]) and arg_118_1.var_.characterEffect4010ui_story then
				arg_118_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_121_2 = arg_118_1.actors_["3009ui_story"]

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect3009ui_story == nil then
				arg_118_1.var_.characterEffect3009ui_story = var_121_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_121_3 = 0.1

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_3 and not isNil(var_121_2) then
				if arg_118_1.var_.characterEffect3009ui_story and not isNil(var_121_2) then
					arg_118_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_118_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_118_1.time_ - 0) / var_121_3)
				end
			end

			if arg_118_1.time_ >= 0 + var_121_3 and arg_118_1.time_ < 0 + var_121_3 + arg_121_0 and not isNil(var_121_2) and arg_118_1.var_.characterEffect3009ui_story then
				arg_118_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_118_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_121_4 = arg_118_1.actors_["3009ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos3009ui_story = var_121_4.localPosition
			end

			local var_121_5 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_5 then
				var_121_4.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_118_1.time_ - 0) / var_121_5)
				var_121_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_4.position).x, (manager.ui.mainCamera.transform.position - var_121_4.position).y, (manager.ui.mainCamera.transform.position - var_121_4.position).z)
				var_121_4.localEulerAngles.z = 0
				var_121_4.localEulerAngles.x = 0
				var_121_4.localEulerAngles = var_121_4.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_5 and arg_118_1.time_ < 0 + var_121_5 + arg_121_0 then
				var_121_4.localPosition = Vector3.New(0, 100, 0)
				var_121_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_4.position).x, (manager.ui.mainCamera.transform.position - var_121_4.position).y, (manager.ui.mainCamera.transform.position - var_121_4.position).z)
				var_121_4.localEulerAngles.z = 0
				var_121_4.localEulerAngles.x = 0
				var_121_4.localEulerAngles = var_121_4.localEulerAngles
			end

			local var_121_6 = arg_118_1.actors_["4010ui_story"].transform

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1.var_.moveOldPos4010ui_story = var_121_6.localPosition
			end

			local var_121_7 = 0.001

			if 0 <= arg_118_1.time_ and arg_118_1.time_ < 0 + var_121_7 then
				var_121_6.localPosition = Vector3.Lerp(arg_118_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_118_1.time_ - 0) / var_121_7)
				var_121_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_6.position).x, (manager.ui.mainCamera.transform.position - var_121_6.position).y, (manager.ui.mainCamera.transform.position - var_121_6.position).z)
				var_121_6.localEulerAngles.z = 0
				var_121_6.localEulerAngles.x = 0
				var_121_6.localEulerAngles = var_121_6.localEulerAngles
			end

			if arg_118_1.time_ >= 0 + var_121_7 and arg_118_1.time_ < 0 + var_121_7 + arg_121_0 then
				var_121_6.localPosition = Vector3.New(0, -1.59, -5.2)
				var_121_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_121_6.position).x, (manager.ui.mainCamera.transform.position - var_121_6.position).y, (manager.ui.mainCamera.transform.position - var_121_6.position).z)
				var_121_6.localEulerAngles.z = 0
				var_121_6.localEulerAngles.x = 0
				var_121_6.localEulerAngles = var_121_6.localEulerAngles
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= 0 + arg_121_0 then
				arg_118_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_121_8 = 0
			local var_121_9 = 0.925

			if 0 < arg_118_1.time_ and arg_118_1.time_ <= var_121_8 + arg_121_0 then
				arg_118_1.talkMaxDuration = 0
				arg_118_1.dialogCg_.alpha = 1

				arg_118_1.dialog_:SetActive(true)
				SetActive(arg_118_1.leftNameGo_, true)

				arg_118_1.leftNameTxt_.text = arg_118_1:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_118_1.leftNameTxt_.transform)

				arg_118_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_118_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_118_1:RecordName(arg_118_1.leftNameTxt_.text)
				SetActive(arg_118_1.iconTrs_.gameObject, false)
				arg_118_1.callingController_:SetSelectedState("normal")

				local var_121_10 = arg_118_1:GetWordFromCfg(103102029)
				local var_121_11 = arg_118_1:FormatText(var_121_10.content)

				arg_118_1.text_.text = var_121_11

				LuaForUtil.ClearLinePrefixSymbol(arg_118_1.text_)

				local var_121_13 = 37 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 37)

				if (37 <= 0 and var_121_9 or var_121_9 * (utf8.len(var_121_11) / 37)) > 0 and var_121_9 < var_121_13 then
					arg_118_1.talkMaxDuration = var_121_13

					if var_121_13 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_13 + var_121_8
					end
				end

				arg_118_1.text_.text = var_121_11
				arg_118_1.typewritter.percent = 0

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102029", "story_v_out_103102.awb") ~= 0 then
					local var_121_14 = manager.audio:GetVoiceLength("story_v_out_103102", "103102029", "story_v_out_103102.awb") / 1000

					if var_121_14 + var_121_8 > arg_118_1.duration_ then
						arg_118_1.duration_ = var_121_14 + var_121_8
					end

					if var_121_10.prefab_name ~= "" and arg_118_1.actors_[var_121_10.prefab_name] ~= nil then
						local var_121_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_118_1.actors_[var_121_10.prefab_name].transform, "story_v_out_103102", "103102029", "story_v_out_103102.awb")

						arg_118_1:RecordAudio("103102029", var_121_15)
						arg_118_1:RecordAudio("103102029", var_121_15)
					else
						arg_118_1:AudioAction("play", "voice", "story_v_out_103102", "103102029", "story_v_out_103102.awb")
					end

					arg_118_1:RecordHistoryTalkVoice("story_v_out_103102", "103102029", "story_v_out_103102.awb")
				end

				arg_118_1:RecordContent(arg_118_1.text_.text)
			end

			local var_121_16 = math.max(var_121_9, arg_118_1.talkMaxDuration)

			if var_121_8 <= arg_118_1.time_ and arg_118_1.time_ < var_121_8 + var_121_16 then
				arg_118_1.typewritter.percent = (arg_118_1.time_ - var_121_8) / var_121_16

				arg_118_1.typewritter:SetDirty()
			end

			if arg_118_1.time_ >= var_121_8 + var_121_16 and arg_118_1.time_ < var_121_8 + var_121_16 + arg_121_0 then
				arg_118_1.typewritter.percent = 1

				arg_118_1.typewritter:SetDirty()
				arg_118_1:ShowNextGo(true)
			end
		end

		arg_118_1.nodeConfigList_ = {
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
			}
		}

		arg_118_1:InitPlayNodeList()
	end,
	Play103102030 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 103102030
		arg_122_1.duration_ = 2

		local var_122_0 = {
			ja = 1.999999999999,
			ko = 2,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_122_0:Play103102031(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story == nil then
				arg_122_1.var_.characterEffect1084ui_story = arg_122_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_0 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) then
				if arg_122_1.var_.characterEffect1084ui_story and not isNil(arg_122_1.actors_["1084ui_story"]) then
					arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_122_1.time_ >= 0 + var_125_0 and arg_122_1.time_ < 0 + var_125_0 + arg_125_0 and not isNil(arg_122_1.actors_["1084ui_story"]) and arg_122_1.var_.characterEffect1084ui_story then
				arg_122_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_125_2 = arg_122_1.actors_["4010ui_story"]

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect4010ui_story == nil then
				arg_122_1.var_.characterEffect4010ui_story = var_125_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_125_3 = 0.1

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_3 and not isNil(var_125_2) then
				if arg_122_1.var_.characterEffect4010ui_story and not isNil(var_125_2) then
					arg_122_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_122_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_122_1.time_ - 0) / var_125_3)
				end
			end

			if arg_122_1.time_ >= 0 + var_125_3 and arg_122_1.time_ < 0 + var_125_3 + arg_125_0 and not isNil(var_125_2) and arg_122_1.var_.characterEffect4010ui_story then
				arg_122_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_122_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_125_4 = arg_122_1.actors_["4010ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos4010ui_story = var_125_4.localPosition
			end

			local var_125_5 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_5 then
				var_125_4.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_122_1.time_ - 0) / var_125_5)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_5 and arg_122_1.time_ < 0 + var_125_5 + arg_125_0 then
				var_125_4.localPosition = Vector3.New(0, 100, 0)
				var_125_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_4.position).x, (manager.ui.mainCamera.transform.position - var_125_4.position).y, (manager.ui.mainCamera.transform.position - var_125_4.position).z)
				var_125_4.localEulerAngles.z = 0
				var_125_4.localEulerAngles.x = 0
				var_125_4.localEulerAngles = var_125_4.localEulerAngles
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			local var_125_6 = arg_122_1.actors_["1084ui_story"].transform

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1.var_.moveOldPos1084ui_story = var_125_6.localPosition

				arg_122_1:ShowWeapon(arg_122_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_125_7 = 0.001

			if 0 <= arg_122_1.time_ and arg_122_1.time_ < 0 + var_125_7 then
				var_125_6.localPosition = Vector3.Lerp(arg_122_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_122_1.time_ - 0) / var_125_7)
				var_125_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_6.position).x, (manager.ui.mainCamera.transform.position - var_125_6.position).y, (manager.ui.mainCamera.transform.position - var_125_6.position).z)
				var_125_6.localEulerAngles.z = 0
				var_125_6.localEulerAngles.x = 0
				var_125_6.localEulerAngles = var_125_6.localEulerAngles
			end

			if arg_122_1.time_ >= 0 + var_125_7 and arg_122_1.time_ < 0 + var_125_7 + arg_125_0 then
				var_125_6.localPosition = Vector3.New(0, -0.97, -6)
				var_125_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_125_6.position).x, (manager.ui.mainCamera.transform.position - var_125_6.position).y, (manager.ui.mainCamera.transform.position - var_125_6.position).z)
				var_125_6.localEulerAngles.z = 0
				var_125_6.localEulerAngles.x = 0
				var_125_6.localEulerAngles = var_125_6.localEulerAngles
			end

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_125_8 = 0
			local var_125_9 = 0.15

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_8 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, true)

				arg_122_1.leftNameTxt_.text = arg_122_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_122_1.leftNameTxt_.transform)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1.leftNameTxt_.text)
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_10 = arg_122_1:GetWordFromCfg(103102030)
				local var_125_11 = arg_122_1:FormatText(var_125_10.content)

				arg_122_1.text_.text = var_125_11

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_13 = 6 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 6)

				if (6 <= 0 and var_125_9 or var_125_9 * (utf8.len(var_125_11) / 6)) > 0 and var_125_9 < var_125_13 then
					arg_122_1.talkMaxDuration = var_125_13

					if var_125_13 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_13 + var_125_8
					end
				end

				arg_122_1.text_.text = var_125_11
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102030", "story_v_out_103102.awb") ~= 0 then
					local var_125_14 = manager.audio:GetVoiceLength("story_v_out_103102", "103102030", "story_v_out_103102.awb") / 1000

					if var_125_14 + var_125_8 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_14 + var_125_8
					end

					if var_125_10.prefab_name ~= "" and arg_122_1.actors_[var_125_10.prefab_name] ~= nil then
						local var_125_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_122_1.actors_[var_125_10.prefab_name].transform, "story_v_out_103102", "103102030", "story_v_out_103102.awb")

						arg_122_1:RecordAudio("103102030", var_125_15)
						arg_122_1:RecordAudio("103102030", var_125_15)
					else
						arg_122_1:AudioAction("play", "voice", "story_v_out_103102", "103102030", "story_v_out_103102.awb")
					end

					arg_122_1:RecordHistoryTalkVoice("story_v_out_103102", "103102030", "story_v_out_103102.awb")
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
				actorName = "1084ui_story",
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
	Play103102031 = function(arg_126_0, arg_126_1)
		arg_126_1.time_ = 0
		arg_126_1.frameCnt_ = 0
		arg_126_1.state_ = "playing"
		arg_126_1.curTalkId_ = 103102031
		arg_126_1.duration_ = 14.43

		local var_126_0 = {
			ja = 14.433,
			ko = 10.066,
			zh = 11.466,
			en = 9.5
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
				arg_126_0:Play103102032(arg_126_1)
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

			local var_129_2 = arg_126_1.actors_["1084ui_story"]

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1084ui_story == nil then
				arg_126_1.var_.characterEffect1084ui_story = var_129_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_129_3 = 0.1

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_3 and not isNil(var_129_2) then
				if arg_126_1.var_.characterEffect1084ui_story and not isNil(var_129_2) then
					arg_126_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_126_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_126_1.time_ - 0) / var_129_3)
				end
			end

			if arg_126_1.time_ >= 0 + var_129_3 and arg_126_1.time_ < 0 + var_129_3 + arg_129_0 and not isNil(var_129_2) and arg_126_1.var_.characterEffect1084ui_story then
				arg_126_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_126_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_129_4 = arg_126_1.actors_["1084ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos1084ui_story = var_129_4.localPosition

				arg_126_1:ShowWeapon(arg_126_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_129_5 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_5 then
				var_129_4.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_126_1.time_ - 0) / var_129_5)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_5 and arg_126_1.time_ < 0 + var_129_5 + arg_129_0 then
				var_129_4.localPosition = Vector3.New(0, 100, 0)
				var_129_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_4.position).x, (manager.ui.mainCamera.transform.position - var_129_4.position).y, (manager.ui.mainCamera.transform.position - var_129_4.position).z)
				var_129_4.localEulerAngles.z = 0
				var_129_4.localEulerAngles.x = 0
				var_129_4.localEulerAngles = var_129_4.localEulerAngles
			end

			local var_129_6 = arg_126_1.actors_["4010ui_story"].transform

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1.var_.moveOldPos4010ui_story = var_129_6.localPosition
			end

			local var_129_7 = 0.001

			if 0 <= arg_126_1.time_ and arg_126_1.time_ < 0 + var_129_7 then
				var_129_6.localPosition = Vector3.Lerp(arg_126_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_126_1.time_ - 0) / var_129_7)
				var_129_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_6.position).x, (manager.ui.mainCamera.transform.position - var_129_6.position).y, (manager.ui.mainCamera.transform.position - var_129_6.position).z)
				var_129_6.localEulerAngles.z = 0
				var_129_6.localEulerAngles.x = 0
				var_129_6.localEulerAngles = var_129_6.localEulerAngles
			end

			if arg_126_1.time_ >= 0 + var_129_7 and arg_126_1.time_ < 0 + var_129_7 + arg_129_0 then
				var_129_6.localPosition = Vector3.New(0, -1.59, -5.2)
				var_129_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_129_6.position).x, (manager.ui.mainCamera.transform.position - var_129_6.position).y, (manager.ui.mainCamera.transform.position - var_129_6.position).z)
				var_129_6.localEulerAngles.z = 0
				var_129_6.localEulerAngles.x = 0
				var_129_6.localEulerAngles = var_129_6.localEulerAngles
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= 0 + arg_129_0 then
				arg_126_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_129_8 = 0
			local var_129_9 = 1.3

			if 0 < arg_126_1.time_ and arg_126_1.time_ <= var_129_8 + arg_129_0 then
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

				local var_129_10 = arg_126_1:GetWordFromCfg(103102031)
				local var_129_11 = arg_126_1:FormatText(var_129_10.content)

				arg_126_1.text_.text = var_129_11

				LuaForUtil.ClearLinePrefixSymbol(arg_126_1.text_)

				local var_129_13 = 54 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 54)

				if (54 <= 0 and var_129_9 or var_129_9 * (utf8.len(var_129_11) / 54)) > 0 and var_129_9 < var_129_13 then
					arg_126_1.talkMaxDuration = var_129_13

					if var_129_13 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_13 + var_129_8
					end
				end

				arg_126_1.text_.text = var_129_11
				arg_126_1.typewritter.percent = 0

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102031", "story_v_out_103102.awb") ~= 0 then
					local var_129_14 = manager.audio:GetVoiceLength("story_v_out_103102", "103102031", "story_v_out_103102.awb") / 1000

					if var_129_14 + var_129_8 > arg_126_1.duration_ then
						arg_126_1.duration_ = var_129_14 + var_129_8
					end

					if var_129_10.prefab_name ~= "" and arg_126_1.actors_[var_129_10.prefab_name] ~= nil then
						local var_129_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_126_1.actors_[var_129_10.prefab_name].transform, "story_v_out_103102", "103102031", "story_v_out_103102.awb")

						arg_126_1:RecordAudio("103102031", var_129_15)
						arg_126_1:RecordAudio("103102031", var_129_15)
					else
						arg_126_1:AudioAction("play", "voice", "story_v_out_103102", "103102031", "story_v_out_103102.awb")
					end

					arg_126_1:RecordHistoryTalkVoice("story_v_out_103102", "103102031", "story_v_out_103102.awb")
				end

				arg_126_1:RecordContent(arg_126_1.text_.text)
			end

			local var_129_16 = math.max(var_129_9, arg_126_1.talkMaxDuration)

			if var_129_8 <= arg_126_1.time_ and arg_126_1.time_ < var_129_8 + var_129_16 then
				arg_126_1.typewritter.percent = (arg_126_1.time_ - var_129_8) / var_129_16

				arg_126_1.typewritter:SetDirty()
			end

			if arg_126_1.time_ >= var_129_8 + var_129_16 and arg_126_1.time_ < var_129_8 + var_129_16 + arg_129_0 then
				arg_126_1.typewritter.percent = 1

				arg_126_1.typewritter:SetDirty()
				arg_126_1:ShowNextGo(true)
			end
		end

		arg_126_1.nodeConfigList_ = {
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
	Play103102032 = function(arg_130_0, arg_130_1)
		arg_130_1.time_ = 0
		arg_130_1.frameCnt_ = 0
		arg_130_1.state_ = "playing"
		arg_130_1.curTalkId_ = 103102032
		arg_130_1.duration_ = 6.7

		local var_130_0 = {
			ja = 6.7,
			ko = 5.466,
			zh = 4.366,
			en = 6.266
		}
		local var_130_1 = manager.audio:GetLocalizationFlag()

		if var_130_0[var_130_1] ~= nil then
			arg_130_1.duration_ = var_130_0[var_130_1]
		end

		SetActive(arg_130_1.tipsGo_, false)

		function arg_130_1.onSingleLineFinish_()
			arg_130_1.onSingleLineUpdate_ = nil
			arg_130_1.onSingleLineFinish_ = nil
			arg_130_1.state_ = "waiting"
		end

		function arg_130_1.playNext_(arg_132_0)
			if arg_132_0 == 1 then
				arg_130_0:Play103102033(arg_130_1)
			end
		end

		function arg_130_1.onSingleLineUpdate_(arg_133_0)
			if arg_130_1.actors_["1036ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1036ui_story"))) then
				local var_133_0 = Object.Instantiate(Asset.Load("Char/" .. "1036ui_story"), arg_130_1.stage_.transform)

				var_133_0.name = "1036ui_story"
				var_133_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_130_1.actors_["1036ui_story"] = var_133_0

				local var_133_1 = var_133_0:GetComponentInChildren(typeof(CharacterEffect))

				var_133_1.enabled = true

				local var_133_2 = GameObjectTools.GetOrAddComponent(var_133_0, typeof(DynamicBoneHelper))

				if var_133_2 then
					var_133_2:EnableDynamicBone(false)
				end

				arg_130_1:ShowWeapon(var_133_1.transform, false)

				arg_130_1.var_["1036ui_story" .. "Animator"] = var_133_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_130_1.var_["1036ui_story" .. "Animator"].applyRootMotion = true
				arg_130_1.var_["1036ui_story" .. "LipSync"] = var_133_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_133_3 = arg_130_1.actors_["1036ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1036ui_story == nil then
				arg_130_1.var_.characterEffect1036ui_story = var_133_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_4 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_4 and not isNil(var_133_3) then
				if arg_130_1.var_.characterEffect1036ui_story and not isNil(var_133_3) then
					arg_130_1.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if arg_130_1.time_ >= 0 + var_133_4 and arg_130_1.time_ < 0 + var_133_4 + arg_133_0 and not isNil(var_133_3) and arg_130_1.var_.characterEffect1036ui_story then
				arg_130_1.var_.characterEffect1036ui_story.fillFlat = false
			end

			local var_133_6 = arg_130_1.actors_["4010ui_story"]

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect4010ui_story == nil then
				arg_130_1.var_.characterEffect4010ui_story = var_133_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_133_7 = 0.1

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_7 and not isNil(var_133_6) then
				if arg_130_1.var_.characterEffect4010ui_story and not isNil(var_133_6) then
					arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
					arg_130_1.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_130_1.time_ - 0) / var_133_7)
				end
			end

			if arg_130_1.time_ >= 0 + var_133_7 and arg_130_1.time_ < 0 + var_133_7 + arg_133_0 and not isNil(var_133_6) and arg_130_1.var_.characterEffect4010ui_story then
				arg_130_1.var_.characterEffect4010ui_story.fillFlat = true
				arg_130_1.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			local var_133_8 = arg_130_1.actors_["4010ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos4010ui_story = var_133_8.localPosition
			end

			local var_133_9 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_9 then
				var_133_8.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (arg_130_1.time_ - 0) / var_133_9)
				var_133_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_8.position).x, (manager.ui.mainCamera.transform.position - var_133_8.position).y, (manager.ui.mainCamera.transform.position - var_133_8.position).z)
				var_133_8.localEulerAngles.z = 0
				var_133_8.localEulerAngles.x = 0
				var_133_8.localEulerAngles = var_133_8.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_9 and arg_130_1.time_ < 0 + var_133_9 + arg_133_0 then
				var_133_8.localPosition = Vector3.New(0, 100, 0)
				var_133_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_8.position).x, (manager.ui.mainCamera.transform.position - var_133_8.position).y, (manager.ui.mainCamera.transform.position - var_133_8.position).z)
				var_133_8.localEulerAngles.z = 0
				var_133_8.localEulerAngles.x = 0
				var_133_8.localEulerAngles = var_133_8.localEulerAngles
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/story1036/story1036action/1036action5_1")
			end

			local var_133_10 = arg_130_1.actors_["1036ui_story"].transform

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1.var_.moveOldPos1036ui_story = var_133_10.localPosition
			end

			local var_133_11 = 0.001

			if 0 <= arg_130_1.time_ and arg_130_1.time_ < 0 + var_133_11 then
				var_133_10.localPosition = Vector3.Lerp(arg_130_1.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (arg_130_1.time_ - 0) / var_133_11)
				var_133_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_10.position).x, (manager.ui.mainCamera.transform.position - var_133_10.position).y, (manager.ui.mainCamera.transform.position - var_133_10.position).z)
				var_133_10.localEulerAngles.z = 0
				var_133_10.localEulerAngles.x = 0
				var_133_10.localEulerAngles = var_133_10.localEulerAngles
			end

			if arg_130_1.time_ >= 0 + var_133_11 and arg_130_1.time_ < 0 + var_133_11 + arg_133_0 then
				var_133_10.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				var_133_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_133_10.position).x, (manager.ui.mainCamera.transform.position - var_133_10.position).y, (manager.ui.mainCamera.transform.position - var_133_10.position).z)
				var_133_10.localEulerAngles.z = 0
				var_133_10.localEulerAngles.x = 0
				var_133_10.localEulerAngles = var_133_10.localEulerAngles
			end

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= 0 + arg_133_0 then
				arg_130_1:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_133_12 = 0
			local var_133_13 = 0.65

			if 0 < arg_130_1.time_ and arg_130_1.time_ <= var_133_12 + arg_133_0 then
				arg_130_1.talkMaxDuration = 0
				arg_130_1.dialogCg_.alpha = 1

				arg_130_1.dialog_:SetActive(true)
				SetActive(arg_130_1.leftNameGo_, true)

				arg_130_1.leftNameTxt_.text = arg_130_1:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_130_1.leftNameTxt_.transform)

				arg_130_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_130_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_130_1:RecordName(arg_130_1.leftNameTxt_.text)
				SetActive(arg_130_1.iconTrs_.gameObject, false)
				arg_130_1.callingController_:SetSelectedState("normal")

				local var_133_14 = arg_130_1:GetWordFromCfg(103102032)
				local var_133_15 = arg_130_1:FormatText(var_133_14.content)

				arg_130_1.text_.text = var_133_15

				LuaForUtil.ClearLinePrefixSymbol(arg_130_1.text_)

				local var_133_17 = 25 <= 0 and var_133_13 or var_133_13 * (utf8.len(var_133_15) / 25)

				if (25 <= 0 and var_133_13 or var_133_13 * (utf8.len(var_133_15) / 25)) > 0 and var_133_13 < var_133_17 then
					arg_130_1.talkMaxDuration = var_133_17

					if var_133_17 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_17 + var_133_12
					end
				end

				arg_130_1.text_.text = var_133_15
				arg_130_1.typewritter.percent = 0

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102032", "story_v_out_103102.awb") ~= 0 then
					local var_133_18 = manager.audio:GetVoiceLength("story_v_out_103102", "103102032", "story_v_out_103102.awb") / 1000

					if var_133_18 + var_133_12 > arg_130_1.duration_ then
						arg_130_1.duration_ = var_133_18 + var_133_12
					end

					if var_133_14.prefab_name ~= "" and arg_130_1.actors_[var_133_14.prefab_name] ~= nil then
						local var_133_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_130_1.actors_[var_133_14.prefab_name].transform, "story_v_out_103102", "103102032", "story_v_out_103102.awb")

						arg_130_1:RecordAudio("103102032", var_133_19)
						arg_130_1:RecordAudio("103102032", var_133_19)
					else
						arg_130_1:AudioAction("play", "voice", "story_v_out_103102", "103102032", "story_v_out_103102.awb")
					end

					arg_130_1:RecordHistoryTalkVoice("story_v_out_103102", "103102032", "story_v_out_103102.awb")
				end

				arg_130_1:RecordContent(arg_130_1.text_.text)
			end

			local var_133_20 = math.max(var_133_13, arg_130_1.talkMaxDuration)

			if var_133_12 <= arg_130_1.time_ and arg_130_1.time_ < var_133_12 + var_133_20 then
				arg_130_1.typewritter.percent = (arg_130_1.time_ - var_133_12) / var_133_20

				arg_130_1.typewritter:SetDirty()
			end

			if arg_130_1.time_ >= var_133_12 + var_133_20 and arg_130_1.time_ < var_133_12 + var_133_20 + arg_133_0 then
				arg_130_1.typewritter.percent = 1

				arg_130_1.typewritter:SetDirty()
				arg_130_1:ShowNextGo(true)
			end
		end

		arg_130_1.nodeConfigList_ = {
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
				actorName = "1036ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_130_1:InitPlayNodeList()
	end,
	Play103102033 = function(arg_134_0, arg_134_1)
		arg_134_1.time_ = 0
		arg_134_1.frameCnt_ = 0
		arg_134_1.state_ = "playing"
		arg_134_1.curTalkId_ = 103102033
		arg_134_1.duration_ = 2

		SetActive(arg_134_1.tipsGo_, false)

		function arg_134_1.onSingleLineFinish_()
			arg_134_1.onSingleLineUpdate_ = nil
			arg_134_1.onSingleLineFinish_ = nil
			arg_134_1.state_ = "waiting"
		end

		function arg_134_1.playNext_(arg_136_0)
			if arg_136_0 == 1 then
				arg_134_0:Play103102034(arg_134_1)
			end
		end

		function arg_134_1.onSingleLineUpdate_(arg_137_0)
			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(arg_134_1.actors_["1084ui_story"]) and arg_134_1.var_.characterEffect1084ui_story == nil then
				arg_134_1.var_.characterEffect1084ui_story = arg_134_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_0 = 0.1

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_0 and not isNil(arg_134_1.actors_["1084ui_story"]) then
				if arg_134_1.var_.characterEffect1084ui_story and not isNil(arg_134_1.actors_["1084ui_story"]) then
					arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_134_1.time_ >= 0 + var_137_0 and arg_134_1.time_ < 0 + var_137_0 + arg_137_0 and not isNil(arg_134_1.actors_["1084ui_story"]) and arg_134_1.var_.characterEffect1084ui_story then
				arg_134_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_137_2 = arg_134_1.actors_["1036ui_story"]

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1036ui_story == nil then
				arg_134_1.var_.characterEffect1036ui_story = var_137_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_137_3 = 0.1

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_3 and not isNil(var_137_2) then
				if arg_134_1.var_.characterEffect1036ui_story and not isNil(var_137_2) then
					arg_134_1.var_.characterEffect1036ui_story.fillFlat = true
					arg_134_1.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_134_1.time_ - 0) / var_137_3)
				end
			end

			if arg_134_1.time_ >= 0 + var_137_3 and arg_134_1.time_ < 0 + var_137_3 + arg_137_0 and not isNil(var_137_2) and arg_134_1.var_.characterEffect1036ui_story then
				arg_134_1.var_.characterEffect1036ui_story.fillFlat = true
				arg_134_1.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			local var_137_4 = arg_134_1.actors_["1084ui_story"].transform

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1.var_.moveOldPos1084ui_story = var_137_4.localPosition

				arg_134_1:ShowWeapon(arg_134_1.var_["1084ui_story" .. "Animator"].transform, false)
			end

			local var_137_5 = 0.001

			if 0 <= arg_134_1.time_ and arg_134_1.time_ < 0 + var_137_5 then
				var_137_4.localPosition = Vector3.Lerp(arg_134_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_134_1.time_ - 0) / var_137_5)
				var_137_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_4.position).x, (manager.ui.mainCamera.transform.position - var_137_4.position).y, (manager.ui.mainCamera.transform.position - var_137_4.position).z)
				var_137_4.localEulerAngles.z = 0
				var_137_4.localEulerAngles.x = 0
				var_137_4.localEulerAngles = var_137_4.localEulerAngles
			end

			if arg_134_1.time_ >= 0 + var_137_5 and arg_134_1.time_ < 0 + var_137_5 + arg_137_0 then
				var_137_4.localPosition = Vector3.New(0.7, -0.97, -6)
				var_137_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_137_4.position).x, (manager.ui.mainCamera.transform.position - var_137_4.position).y, (manager.ui.mainCamera.transform.position - var_137_4.position).z)
				var_137_4.localEulerAngles.z = 0
				var_137_4.localEulerAngles.x = 0
				var_137_4.localEulerAngles = var_137_4.localEulerAngles
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= 0 + arg_137_0 then
				arg_134_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_137_6 = 0
			local var_137_7 = 0.175

			if 0 < arg_134_1.time_ and arg_134_1.time_ <= var_137_6 + arg_137_0 then
				arg_134_1.talkMaxDuration = 0
				arg_134_1.dialogCg_.alpha = 1

				arg_134_1.dialog_:SetActive(true)
				SetActive(arg_134_1.leftNameGo_, true)

				arg_134_1.leftNameTxt_.text = arg_134_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_134_1.leftNameTxt_.transform)

				arg_134_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_134_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_134_1:RecordName(arg_134_1.leftNameTxt_.text)
				SetActive(arg_134_1.iconTrs_.gameObject, false)
				arg_134_1.callingController_:SetSelectedState("normal")

				local var_137_8 = arg_134_1:GetWordFromCfg(103102033)
				local var_137_9 = arg_134_1:FormatText(var_137_8.content)

				arg_134_1.text_.text = var_137_9

				LuaForUtil.ClearLinePrefixSymbol(arg_134_1.text_)

				local var_137_11 = 7 <= 0 and var_137_7 or var_137_7 * (utf8.len(var_137_9) / 7)

				if (7 <= 0 and var_137_7 or var_137_7 * (utf8.len(var_137_9) / 7)) > 0 and var_137_7 < var_137_11 then
					arg_134_1.talkMaxDuration = var_137_11

					if var_137_11 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_11 + var_137_6
					end
				end

				arg_134_1.text_.text = var_137_9
				arg_134_1.typewritter.percent = 0

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102033", "story_v_out_103102.awb") ~= 0 then
					local var_137_12 = manager.audio:GetVoiceLength("story_v_out_103102", "103102033", "story_v_out_103102.awb") / 1000

					if var_137_12 + var_137_6 > arg_134_1.duration_ then
						arg_134_1.duration_ = var_137_12 + var_137_6
					end

					if var_137_8.prefab_name ~= "" and arg_134_1.actors_[var_137_8.prefab_name] ~= nil then
						local var_137_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_134_1.actors_[var_137_8.prefab_name].transform, "story_v_out_103102", "103102033", "story_v_out_103102.awb")

						arg_134_1:RecordAudio("103102033", var_137_13)
						arg_134_1:RecordAudio("103102033", var_137_13)
					else
						arg_134_1:AudioAction("play", "voice", "story_v_out_103102", "103102033", "story_v_out_103102.awb")
					end

					arg_134_1:RecordHistoryTalkVoice("story_v_out_103102", "103102033", "story_v_out_103102.awb")
				end

				arg_134_1:RecordContent(arg_134_1.text_.text)
			end

			local var_137_14 = math.max(var_137_7, arg_134_1.talkMaxDuration)

			if var_137_6 <= arg_134_1.time_ and arg_134_1.time_ < var_137_6 + var_137_14 then
				arg_134_1.typewritter.percent = (arg_134_1.time_ - var_137_6) / var_137_14

				arg_134_1.typewritter:SetDirty()
			end

			if arg_134_1.time_ >= var_137_6 + var_137_14 and arg_134_1.time_ < var_137_6 + var_137_14 + arg_137_0 then
				arg_134_1.typewritter.percent = 1

				arg_134_1.typewritter:SetDirty()
				arg_134_1:ShowNextGo(true)
			end
		end

		arg_134_1.nodeConfigList_ = {
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

		arg_134_1:InitPlayNodeList()
	end,
	Play103102034 = function(arg_138_0, arg_138_1)
		arg_138_1.time_ = 0
		arg_138_1.frameCnt_ = 0
		arg_138_1.state_ = "playing"
		arg_138_1.curTalkId_ = 103102034
		arg_138_1.duration_ = 6.6

		local var_138_0 = {
			ja = 6.6,
			ko = 4.466,
			zh = 5.766,
			en = 3.366
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
			arg_138_1.auto_ = false
		end

		function arg_138_1.playNext_(arg_140_0)
			arg_138_1.onStoryFinished_()
		end

		function arg_138_1.onSingleLineUpdate_(arg_141_0)
			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(arg_138_1.actors_["4010ui_story"]) and arg_138_1.var_.characterEffect4010ui_story == nil then
				arg_138_1.var_.characterEffect4010ui_story = arg_138_1.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_0 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_0 and not isNil(arg_138_1.actors_["4010ui_story"]) then
				if arg_138_1.var_.characterEffect4010ui_story and not isNil(arg_138_1.actors_["4010ui_story"]) then
					arg_138_1.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if arg_138_1.time_ >= 0 + var_141_0 and arg_138_1.time_ < 0 + var_141_0 + arg_141_0 and not isNil(arg_138_1.actors_["4010ui_story"]) and arg_138_1.var_.characterEffect4010ui_story then
				arg_138_1.var_.characterEffect4010ui_story.fillFlat = false
			end

			local var_141_2 = arg_138_1.actors_["1084ui_story"]

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1084ui_story == nil then
				arg_138_1.var_.characterEffect1084ui_story = var_141_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_141_3 = 0.1

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_3 and not isNil(var_141_2) then
				if arg_138_1.var_.characterEffect1084ui_story and not isNil(var_141_2) then
					arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_138_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_138_1.time_ - 0) / var_141_3)
				end
			end

			if arg_138_1.time_ >= 0 + var_141_3 and arg_138_1.time_ < 0 + var_141_3 + arg_141_0 and not isNil(var_141_2) and arg_138_1.var_.characterEffect1084ui_story then
				arg_138_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_138_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_141_4 = arg_138_1.actors_["1084ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1084ui_story = var_141_4.localPosition
			end

			local var_141_5 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_5 then
				var_141_4.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_5)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_5 and arg_138_1.time_ < 0 + var_141_5 + arg_141_0 then
				var_141_4.localPosition = Vector3.New(0, 100, 0)
				var_141_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_4.position).x, (manager.ui.mainCamera.transform.position - var_141_4.position).y, (manager.ui.mainCamera.transform.position - var_141_4.position).z)
				var_141_4.localEulerAngles.z = 0
				var_141_4.localEulerAngles.x = 0
				var_141_4.localEulerAngles = var_141_4.localEulerAngles
			end

			local var_141_6 = arg_138_1.actors_["1036ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos1036ui_story = var_141_6.localPosition
			end

			local var_141_7 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_7 then
				var_141_6.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (arg_138_1.time_ - 0) / var_141_7)
				var_141_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_6.position).x, (manager.ui.mainCamera.transform.position - var_141_6.position).y, (manager.ui.mainCamera.transform.position - var_141_6.position).z)
				var_141_6.localEulerAngles.z = 0
				var_141_6.localEulerAngles.x = 0
				var_141_6.localEulerAngles = var_141_6.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_7 and arg_138_1.time_ < 0 + var_141_7 + arg_141_0 then
				var_141_6.localPosition = Vector3.New(0, 100, 0)
				var_141_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_6.position).x, (manager.ui.mainCamera.transform.position - var_141_6.position).y, (manager.ui.mainCamera.transform.position - var_141_6.position).z)
				var_141_6.localEulerAngles.z = 0
				var_141_6.localEulerAngles.x = 0
				var_141_6.localEulerAngles = var_141_6.localEulerAngles
			end

			local var_141_8 = arg_138_1.actors_["4010ui_story"].transform

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1.var_.moveOldPos4010ui_story = var_141_8.localPosition
			end

			local var_141_9 = 0.001

			if 0 <= arg_138_1.time_ and arg_138_1.time_ < 0 + var_141_9 then
				var_141_8.localPosition = Vector3.Lerp(arg_138_1.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (arg_138_1.time_ - 0) / var_141_9)
				var_141_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_8.position).x, (manager.ui.mainCamera.transform.position - var_141_8.position).y, (manager.ui.mainCamera.transform.position - var_141_8.position).z)
				var_141_8.localEulerAngles.z = 0
				var_141_8.localEulerAngles.x = 0
				var_141_8.localEulerAngles = var_141_8.localEulerAngles
			end

			if arg_138_1.time_ >= 0 + var_141_9 and arg_138_1.time_ < 0 + var_141_9 + arg_141_0 then
				var_141_8.localPosition = Vector3.New(0, -1.59, -5.2)
				var_141_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_141_8.position).x, (manager.ui.mainCamera.transform.position - var_141_8.position).y, (manager.ui.mainCamera.transform.position - var_141_8.position).z)
				var_141_8.localEulerAngles.z = 0
				var_141_8.localEulerAngles.x = 0
				var_141_8.localEulerAngles = var_141_8.localEulerAngles
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= 0 + arg_141_0 then
				arg_138_1:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_141_10 = 0
			local var_141_11 = 0.375

			if 0 < arg_138_1.time_ and arg_138_1.time_ <= var_141_10 + arg_141_0 then
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

				local var_141_12 = arg_138_1:GetWordFromCfg(103102034)
				local var_141_13 = arg_138_1:FormatText(var_141_12.content)

				arg_138_1.text_.text = var_141_13

				LuaForUtil.ClearLinePrefixSymbol(arg_138_1.text_)

				local var_141_15 = 15 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_13) / 15)

				if (15 <= 0 and var_141_11 or var_141_11 * (utf8.len(var_141_13) / 15)) > 0 and var_141_11 < var_141_15 then
					arg_138_1.talkMaxDuration = var_141_15

					if var_141_15 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_15 + var_141_10
					end
				end

				arg_138_1.text_.text = var_141_13
				arg_138_1.typewritter.percent = 0

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_103102", "103102034", "story_v_out_103102.awb") ~= 0 then
					local var_141_16 = manager.audio:GetVoiceLength("story_v_out_103102", "103102034", "story_v_out_103102.awb") / 1000

					if var_141_16 + var_141_10 > arg_138_1.duration_ then
						arg_138_1.duration_ = var_141_16 + var_141_10
					end

					if var_141_12.prefab_name ~= "" and arg_138_1.actors_[var_141_12.prefab_name] ~= nil then
						local var_141_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_138_1.actors_[var_141_12.prefab_name].transform, "story_v_out_103102", "103102034", "story_v_out_103102.awb")

						arg_138_1:RecordAudio("103102034", var_141_17)
						arg_138_1:RecordAudio("103102034", var_141_17)
					else
						arg_138_1:AudioAction("play", "voice", "story_v_out_103102", "103102034", "story_v_out_103102.awb")
					end

					arg_138_1:RecordHistoryTalkVoice("story_v_out_103102", "103102034", "story_v_out_103102.awb")
				end

				arg_138_1:RecordContent(arg_138_1.text_.text)
			end

			local var_141_18 = math.max(var_141_11, arg_138_1.talkMaxDuration)

			if var_141_10 <= arg_138_1.time_ and arg_138_1.time_ < var_141_10 + var_141_18 then
				arg_138_1.typewritter.percent = (arg_138_1.time_ - var_141_10) / var_141_18

				arg_138_1.typewritter:SetDirty()
			end

			if arg_138_1.time_ >= var_141_10 + var_141_18 and arg_138_1.time_ < var_141_10 + var_141_18 + arg_141_0 then
				arg_138_1.typewritter.percent = 1

				arg_138_1.typewritter:SetDirty()
				arg_138_1:ShowNextGo(true)
			end
		end

		arg_138_1.nodeConfigList_ = {
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
				actorName = "4010ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.033,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_138_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B03d",
		"TextureConfig/Background/B03f"
	},
	voices = {
		"story_v_out_103102.awb"
	}
}
