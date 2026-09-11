return {
	Play102111001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 102111001
		arg_1_1.duration_ = 8.77

		local var_1_0 = {
			ja = 7.2,
			ko = 7.666,
			zh = 8.766,
			en = 7.666
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
				arg_1_0:Play102111002(arg_1_1)
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

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect1084ui_story == nil then
				arg_1_1.var_.characterEffect1084ui_story = var_4_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_4_9 = 0.1

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 and not isNil(var_4_8) then
				if arg_1_1.var_.characterEffect1084ui_story and not isNil(var_4_8) then
					arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 and not isNil(var_4_8) and arg_1_1.var_.characterEffect1084ui_story then
				arg_1_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_4_11 = "B08b"

			if arg_1_1.bgs_.B08b == nil then
				local var_4_12 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_12:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_11)
				var_4_12.name = var_4_11
				var_4_12.transform.parent = arg_1_1.stage_.transform
				var_4_12.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_11] = var_4_12
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_13 = arg_1_1.bgs_.B08b:GetComponent("SpriteRenderer")

				if var_4_13 then
					arg_1_1.var_.alphaOldValueB08b = var_4_13.color.a
					arg_1_1.var_.alphaMatValueB08b = var_4_13
				end

				arg_1_1.var_.alphaOldValueB08b = 0
			end

			local var_4_14 = 1.5

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_14 then
				if arg_1_1.var_.alphaMatValueB08b then
					arg_1_1.var_.alphaMatValueB08b.color.a = Mathf.Lerp(arg_1_1.var_.alphaOldValueB08b, 1, (arg_1_1.time_ - 0) / var_4_14)
					arg_1_1.var_.alphaMatValueB08b.color = arg_1_1.var_.alphaMatValueB08b.color
				end
			end

			if arg_1_1.time_ >= 0 + var_4_14 and arg_1_1.time_ < 0 + var_4_14 + arg_4_0 and arg_1_1.var_.alphaMatValueB08b then
				arg_1_1.var_.alphaMatValueB08b.color.a = 1
				arg_1_1.var_.alphaMatValueB08b.color = arg_1_1.var_.alphaMatValueB08b.color
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_15 = arg_1_1.bgs_.B08b

				arg_1_1.bgs_.B08b.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_15.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_16 = var_4_15:GetComponent("SpriteRenderer")

				if var_4_16 and var_4_16.sprite then
					local var_4_17 = 2 * (var_4_15.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_15.transform.localScale = Vector3.New(var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, var_4_17 / var_4_16.sprite.bounds.size.y < var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x and var_4_17 * manager.ui.mainCameraCom_.aspect / var_4_16.sprite.bounds.size.x or var_4_17 / var_4_16.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "B08b" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_18 = arg_1_1.actors_["1084ui_story"].transform

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1.var_.moveOldPos1084ui_story = var_4_18.localPosition
			end

			local var_4_19 = 0.001

			if 1.79999995231628 <= arg_1_1.time_ and arg_1_1.time_ < 1.79999995231628 + var_4_19 then
				var_4_18.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_1_1.time_ - 1.79999995231628) / var_4_19)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if arg_1_1.time_ >= 1.79999995231628 + var_4_19 and arg_1_1.time_ < 1.79999995231628 + var_4_19 + arg_4_0 then
				var_4_18.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_4_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_4_18.position).x, (manager.ui.mainCamera.transform.position - var_4_18.position).y, (manager.ui.mainCamera.transform.position - var_4_18.position).z)
				var_4_18.localEulerAngles.z = 0
				var_4_18.localEulerAngles.x = 0
				var_4_18.localEulerAngles = var_4_18.localEulerAngles
			end

			if 1.79999995231628 < arg_1_1.time_ and arg_1_1.time_ <= 1.79999995231628 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action12_1")
			end

			local var_4_20 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_20 + 2 and arg_1_1.time_ < var_4_20 + 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_21 = 2
			local var_4_22 = 0.675

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

				arg_1_1.leftNameTxt_.text = arg_1_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_1_1.leftNameTxt_.transform)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1.leftNameTxt_.text)
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_24 = arg_1_1:GetWordFromCfg(102111001)
				local var_4_25 = arg_1_1:FormatText(var_4_24.content)

				arg_1_1.text_.text = var_4_25

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_27 = 27 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 27)

				if (27 <= 0 and var_4_22 or var_4_22 * (utf8.len(var_4_25) / 27)) > 0 and var_4_22 < var_4_27 then
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

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111001", "story_v_out_102111.awb") ~= 0 then
					local var_4_28 = manager.audio:GetVoiceLength("story_v_out_102111", "102111001", "story_v_out_102111.awb") / 1000

					if var_4_28 + var_4_21 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_28 + var_4_21
					end

					if var_4_24.prefab_name ~= "" and arg_1_1.actors_[var_4_24.prefab_name] ~= nil then
						local var_4_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_1_1.actors_[var_4_24.prefab_name].transform, "story_v_out_102111", "102111001", "story_v_out_102111.awb")

						arg_1_1:RecordAudio("102111001", var_4_29)
						arg_1_1:RecordAudio("102111001", var_4_29)
					else
						arg_1_1:AudioAction("play", "voice", "story_v_out_102111", "102111001", "story_v_out_102111.awb")
					end

					arg_1_1:RecordHistoryTalkVoice("story_v_out_102111", "102111001", "story_v_out_102111.awb")
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
				startTime = 1.79999995231628,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play102111002 = function(arg_8_0, arg_8_1)
		arg_8_1.time_ = 0
		arg_8_1.frameCnt_ = 0
		arg_8_1.state_ = "playing"
		arg_8_1.curTalkId_ = 102111002
		arg_8_1.duration_ = 2.8

		local var_8_0 = {
			ja = 2.6,
			ko = 2.5,
			zh = 2.8,
			en = 2.666
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
				arg_8_0:Play102111003(arg_8_1)
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

			local var_11_8 = arg_8_1.actors_["1011ui_story"].transform

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1.var_.moveOldPos1011ui_story = var_11_8.localPosition
			end

			local var_11_9 = 0.001

			if 0 <= arg_8_1.time_ and arg_8_1.time_ < 0 + var_11_9 then
				var_11_8.localPosition = Vector3.Lerp(arg_8_1.var_.moveOldPos1011ui_story, Vector3.New(0.7, -0.71, -6), (arg_8_1.time_ - 0) / var_11_9)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if arg_8_1.time_ >= 0 + var_11_9 and arg_8_1.time_ < 0 + var_11_9 + arg_11_0 then
				var_11_8.localPosition = Vector3.New(0.7, -0.71, -6)
				var_11_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_11_8.position).x, (manager.ui.mainCamera.transform.position - var_11_8.position).y, (manager.ui.mainCamera.transform.position - var_11_8.position).z)
				var_11_8.localEulerAngles.z = 0
				var_11_8.localEulerAngles.x = 0
				var_11_8.localEulerAngles = var_11_8.localEulerAngles
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= 0 + arg_11_0 then
				arg_8_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_11_10 = 0
			local var_11_11 = 0.25

			if 0 < arg_8_1.time_ and arg_8_1.time_ <= var_11_10 + arg_11_0 then
				arg_8_1.talkMaxDuration = 0
				arg_8_1.dialogCg_.alpha = 1

				arg_8_1.dialog_:SetActive(true)
				SetActive(arg_8_1.leftNameGo_, true)

				arg_8_1.leftNameTxt_.text = arg_8_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_1.leftNameTxt_.transform)

				arg_8_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_8_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_8_1:RecordName(arg_8_1.leftNameTxt_.text)
				SetActive(arg_8_1.iconTrs_.gameObject, false)
				arg_8_1.callingController_:SetSelectedState("normal")

				local var_11_12 = arg_8_1:GetWordFromCfg(102111002)
				local var_11_13 = arg_8_1:FormatText(var_11_12.content)

				arg_8_1.text_.text = var_11_13

				LuaForUtil.ClearLinePrefixSymbol(arg_8_1.text_)

				local var_11_15 = 10 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 10)

				if (10 <= 0 and var_11_11 or var_11_11 * (utf8.len(var_11_13) / 10)) > 0 and var_11_11 < var_11_15 then
					arg_8_1.talkMaxDuration = var_11_15

					if var_11_15 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_15 + var_11_10
					end
				end

				arg_8_1.text_.text = var_11_13
				arg_8_1.typewritter.percent = 0

				arg_8_1.typewritter:SetDirty()
				arg_8_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111002", "story_v_out_102111.awb") ~= 0 then
					local var_11_16 = manager.audio:GetVoiceLength("story_v_out_102111", "102111002", "story_v_out_102111.awb") / 1000

					if var_11_16 + var_11_10 > arg_8_1.duration_ then
						arg_8_1.duration_ = var_11_16 + var_11_10
					end

					if var_11_12.prefab_name ~= "" and arg_8_1.actors_[var_11_12.prefab_name] ~= nil then
						local var_11_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_8_1.actors_[var_11_12.prefab_name].transform, "story_v_out_102111", "102111002", "story_v_out_102111.awb")

						arg_8_1:RecordAudio("102111002", var_11_17)
						arg_8_1:RecordAudio("102111002", var_11_17)
					else
						arg_8_1:AudioAction("play", "voice", "story_v_out_102111", "102111002", "story_v_out_102111.awb")
					end

					arg_8_1:RecordHistoryTalkVoice("story_v_out_102111", "102111002", "story_v_out_102111.awb")
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
				actorName = "1011ui_story",
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
	Play102111003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 102111003
		arg_12_1.duration_ = 5.83

		local var_12_0 = {
			ja = 5.433,
			ko = 5.066,
			zh = 4.4,
			en = 5.833
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
				arg_12_0:Play102111004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if arg_12_1.actors_["3008ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3008ui_story"))) then
				local var_15_0 = Object.Instantiate(Asset.Load("Char/" .. "3008ui_story"), arg_12_1.stage_.transform)

				var_15_0.name = "3008ui_story"
				var_15_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_12_1.actors_["3008ui_story"] = var_15_0

				local var_15_1 = var_15_0:GetComponentInChildren(typeof(CharacterEffect))

				var_15_1.enabled = true

				local var_15_2 = GameObjectTools.GetOrAddComponent(var_15_0, typeof(DynamicBoneHelper))

				if var_15_2 then
					var_15_2:EnableDynamicBone(false)
				end

				arg_12_1:ShowWeapon(var_15_1.transform, false)

				arg_12_1.var_["3008ui_story" .. "Animator"] = var_15_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_12_1.var_["3008ui_story" .. "Animator"].applyRootMotion = true
				arg_12_1.var_["3008ui_story" .. "LipSync"] = var_15_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_15_3 = arg_12_1.actors_["3008ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect3008ui_story == nil then
				arg_12_1.var_.characterEffect3008ui_story = var_15_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_4 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_4 and not isNil(var_15_3) then
				if arg_12_1.var_.characterEffect3008ui_story and not isNil(var_15_3) then
					arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_12_1.time_ >= 0 + var_15_4 and arg_12_1.time_ < 0 + var_15_4 + arg_15_0 and not isNil(var_15_3) and arg_12_1.var_.characterEffect3008ui_story then
				arg_12_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_15_6 = arg_12_1.actors_["1011ui_story"]

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1011ui_story == nil then
				arg_12_1.var_.characterEffect1011ui_story = var_15_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_7 = 0.1

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_7 and not isNil(var_15_6) then
				if arg_12_1.var_.characterEffect1011ui_story and not isNil(var_15_6) then
					arg_12_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_7)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_7 and arg_12_1.time_ < 0 + var_15_7 + arg_15_0 and not isNil(var_15_6) and arg_12_1.var_.characterEffect1011ui_story then
				arg_12_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_15_8 = arg_12_1.actors_["1011ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1011ui_story = var_15_8.localPosition
			end

			local var_15_9 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_9 then
				var_15_8.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_9)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_9 and arg_12_1.time_ < 0 + var_15_9 + arg_15_0 then
				var_15_8.localPosition = Vector3.New(0, 100, 0)
				var_15_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_8.position).x, (manager.ui.mainCamera.transform.position - var_15_8.position).y, (manager.ui.mainCamera.transform.position - var_15_8.position).z)
				var_15_8.localEulerAngles.z = 0
				var_15_8.localEulerAngles.x = 0
				var_15_8.localEulerAngles = var_15_8.localEulerAngles
			end

			local var_15_10 = arg_12_1.actors_["1084ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos1084ui_story = var_15_10.localPosition
			end

			local var_15_11 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_11 then
				var_15_10.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_12_1.time_ - 0) / var_15_11)
				var_15_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_10.position).x, (manager.ui.mainCamera.transform.position - var_15_10.position).y, (manager.ui.mainCamera.transform.position - var_15_10.position).z)
				var_15_10.localEulerAngles.z = 0
				var_15_10.localEulerAngles.x = 0
				var_15_10.localEulerAngles = var_15_10.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_11 and arg_12_1.time_ < 0 + var_15_11 + arg_15_0 then
				var_15_10.localPosition = Vector3.New(0, 100, 0)
				var_15_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_10.position).x, (manager.ui.mainCamera.transform.position - var_15_10.position).y, (manager.ui.mainCamera.transform.position - var_15_10.position).z)
				var_15_10.localEulerAngles.z = 0
				var_15_10.localEulerAngles.x = 0
				var_15_10.localEulerAngles = var_15_10.localEulerAngles
			end

			local var_15_12 = arg_12_1.actors_["3008ui_story"].transform

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1.var_.moveOldPos3008ui_story = var_15_12.localPosition
			end

			local var_15_13 = 0.001

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_13 then
				var_15_12.localPosition = Vector3.Lerp(arg_12_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_12_1.time_ - 0) / var_15_13)
				var_15_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_12.position).x, (manager.ui.mainCamera.transform.position - var_15_12.position).y, (manager.ui.mainCamera.transform.position - var_15_12.position).z)
				var_15_12.localEulerAngles.z = 0
				var_15_12.localEulerAngles.x = 0
				var_15_12.localEulerAngles = var_15_12.localEulerAngles
			end

			if arg_12_1.time_ >= 0 + var_15_13 and arg_12_1.time_ < 0 + var_15_13 + arg_15_0 then
				var_15_12.localPosition = Vector3.New(0, -1.51, -4.3)
				var_15_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_15_12.position).x, (manager.ui.mainCamera.transform.position - var_15_12.position).y, (manager.ui.mainCamera.transform.position - var_15_12.position).z)
				var_15_12.localEulerAngles.z = 0
				var_15_12.localEulerAngles.x = 0
				var_15_12.localEulerAngles = var_15_12.localEulerAngles
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 then
				arg_12_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_15_14 = 0
			local var_15_15 = 0.45

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_14 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, false)
				arg_12_1.callingController_:SetSelectedState("normal")

				local var_15_16 = arg_12_1:GetWordFromCfg(102111003)
				local var_15_17 = arg_12_1:FormatText(var_15_16.content)

				arg_12_1.text_.text = var_15_17

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_19 = 18 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_17) / 18)

				if (18 <= 0 and var_15_15 or var_15_15 * (utf8.len(var_15_17) / 18)) > 0 and var_15_15 < var_15_19 then
					arg_12_1.talkMaxDuration = var_15_19

					if var_15_19 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_19 + var_15_14
					end
				end

				arg_12_1.text_.text = var_15_17
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111003", "story_v_out_102111.awb") ~= 0 then
					local var_15_20 = manager.audio:GetVoiceLength("story_v_out_102111", "102111003", "story_v_out_102111.awb") / 1000

					if var_15_20 + var_15_14 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_20 + var_15_14
					end

					if var_15_16.prefab_name ~= "" and arg_12_1.actors_[var_15_16.prefab_name] ~= nil then
						local var_15_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_12_1.actors_[var_15_16.prefab_name].transform, "story_v_out_102111", "102111003", "story_v_out_102111.awb")

						arg_12_1:RecordAudio("102111003", var_15_21)
						arg_12_1:RecordAudio("102111003", var_15_21)
					else
						arg_12_1:AudioAction("play", "voice", "story_v_out_102111", "102111003", "story_v_out_102111.awb")
					end

					arg_12_1:RecordHistoryTalkVoice("story_v_out_102111", "102111003", "story_v_out_102111.awb")
				end

				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_22 = math.max(var_15_15, arg_12_1.talkMaxDuration)

			if var_15_14 <= arg_12_1.time_ and arg_12_1.time_ < var_15_14 + var_15_22 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_14) / var_15_22

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_14 + var_15_22 and arg_12_1.time_ < var_15_14 + var_15_22 + arg_15_0 then
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
				actorName = "3008ui_story",
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
	Play102111004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 102111004
		arg_16_1.duration_ = 3.37

		local var_16_0 = {
			ja = 1.999999999999,
			ko = 3.366,
			zh = 2.266,
			en = 2.166
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
				arg_16_0:Play102111005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1084ui_story"]) and arg_16_1.var_.characterEffect1084ui_story == nil then
				arg_16_1.var_.characterEffect1084ui_story = arg_16_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.1

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1084ui_story"]) then
				if arg_16_1.var_.characterEffect1084ui_story and not isNil(arg_16_1.actors_["1084ui_story"]) then
					arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1084ui_story"]) and arg_16_1.var_.characterEffect1084ui_story then
				arg_16_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_19_2 = arg_16_1.actors_["3008ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos3008ui_story = var_19_2.localPosition
			end

			local var_19_3 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_3 then
				var_19_2.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_16_1.time_ - 0) / var_19_3)
				var_19_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_2.position).x, (manager.ui.mainCamera.transform.position - var_19_2.position).y, (manager.ui.mainCamera.transform.position - var_19_2.position).z)
				var_19_2.localEulerAngles.z = 0
				var_19_2.localEulerAngles.x = 0
				var_19_2.localEulerAngles = var_19_2.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_3 and arg_16_1.time_ < 0 + var_19_3 + arg_19_0 then
				var_19_2.localPosition = Vector3.New(0, 100, 0)
				var_19_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_2.position).x, (manager.ui.mainCamera.transform.position - var_19_2.position).y, (manager.ui.mainCamera.transform.position - var_19_2.position).z)
				var_19_2.localEulerAngles.z = 0
				var_19_2.localEulerAngles.x = 0
				var_19_2.localEulerAngles = var_19_2.localEulerAngles
			end

			local var_19_4 = arg_16_1.actors_["1084ui_story"].transform

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1.var_.moveOldPos1084ui_story = var_19_4.localPosition
			end

			local var_19_5 = 0.001

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_5 then
				var_19_4.localPosition = Vector3.Lerp(arg_16_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_16_1.time_ - 0) / var_19_5)
				var_19_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_4.position).x, (manager.ui.mainCamera.transform.position - var_19_4.position).y, (manager.ui.mainCamera.transform.position - var_19_4.position).z)
				var_19_4.localEulerAngles.z = 0
				var_19_4.localEulerAngles.x = 0
				var_19_4.localEulerAngles = var_19_4.localEulerAngles
			end

			if arg_16_1.time_ >= 0 + var_19_5 and arg_16_1.time_ < 0 + var_19_5 + arg_19_0 then
				var_19_4.localPosition = Vector3.New(0, -0.97, -6)
				var_19_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_19_4.position).x, (manager.ui.mainCamera.transform.position - var_19_4.position).y, (manager.ui.mainCamera.transform.position - var_19_4.position).z)
				var_19_4.localEulerAngles.z = 0
				var_19_4.localEulerAngles.x = 0
				var_19_4.localEulerAngles = var_19_4.localEulerAngles
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_19_6 = 0
			local var_19_7 = 0.175

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_6 + arg_19_0 then
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

				local var_19_8 = arg_16_1:GetWordFromCfg(102111004)
				local var_19_9 = arg_16_1:FormatText(var_19_8.content)

				arg_16_1.text_.text = var_19_9

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_11 = 7 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 7)

				if (7 <= 0 and var_19_7 or var_19_7 * (utf8.len(var_19_9) / 7)) > 0 and var_19_7 < var_19_11 then
					arg_16_1.talkMaxDuration = var_19_11

					if var_19_11 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_11 + var_19_6
					end
				end

				arg_16_1.text_.text = var_19_9
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111004", "story_v_out_102111.awb") ~= 0 then
					local var_19_12 = manager.audio:GetVoiceLength("story_v_out_102111", "102111004", "story_v_out_102111.awb") / 1000

					if var_19_12 + var_19_6 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_12 + var_19_6
					end

					if var_19_8.prefab_name ~= "" and arg_16_1.actors_[var_19_8.prefab_name] ~= nil then
						local var_19_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_16_1.actors_[var_19_8.prefab_name].transform, "story_v_out_102111", "102111004", "story_v_out_102111.awb")

						arg_16_1:RecordAudio("102111004", var_19_13)
						arg_16_1:RecordAudio("102111004", var_19_13)
					else
						arg_16_1:AudioAction("play", "voice", "story_v_out_102111", "102111004", "story_v_out_102111.awb")
					end

					arg_16_1:RecordHistoryTalkVoice("story_v_out_102111", "102111004", "story_v_out_102111.awb")
				end

				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_14 = math.max(var_19_7, arg_16_1.talkMaxDuration)

			if var_19_6 <= arg_16_1.time_ and arg_16_1.time_ < var_19_6 + var_19_14 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_6) / var_19_14

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_6 + var_19_14 and arg_16_1.time_ < var_19_6 + var_19_14 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {
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
	Play102111005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 102111005
		arg_20_1.duration_ = 4.7

		local var_20_0 = {
			ja = 4,
			ko = 3.7,
			zh = 3.8,
			en = 4.7
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
				arg_20_0:Play102111006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action459")
			end

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 then
				arg_20_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_23_0 = 0
			local var_23_1 = 0.375

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_0 + arg_23_0 then
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

				local var_23_2 = arg_20_1:GetWordFromCfg(102111005)
				local var_23_3 = arg_20_1:FormatText(var_23_2.content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 15 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 15)

				if (15 <= 0 and var_23_1 or var_23_1 * (utf8.len(var_23_3) / 15)) > 0 and var_23_1 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_0
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111005", "story_v_out_102111.awb") ~= 0 then
					local var_23_6 = manager.audio:GetVoiceLength("story_v_out_102111", "102111005", "story_v_out_102111.awb") / 1000

					if var_23_6 + var_23_0 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_6 + var_23_0
					end

					if var_23_2.prefab_name ~= "" and arg_20_1.actors_[var_23_2.prefab_name] ~= nil then
						local var_23_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_20_1.actors_[var_23_2.prefab_name].transform, "story_v_out_102111", "102111005", "story_v_out_102111.awb")

						arg_20_1:RecordAudio("102111005", var_23_7)
						arg_20_1:RecordAudio("102111005", var_23_7)
					else
						arg_20_1:AudioAction("play", "voice", "story_v_out_102111", "102111005", "story_v_out_102111.awb")
					end

					arg_20_1:RecordHistoryTalkVoice("story_v_out_102111", "102111005", "story_v_out_102111.awb")
				end

				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_8 = math.max(var_23_1, arg_20_1.talkMaxDuration)

			if var_23_0 <= arg_20_1.time_ and arg_20_1.time_ < var_23_0 + var_23_8 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_0) / var_23_8

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_0 + var_23_8 and arg_20_1.time_ < var_23_0 + var_23_8 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play102111006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 102111006
		arg_24_1.duration_ = 6.87

		local var_24_0 = {
			ja = 4.466,
			ko = 6.866,
			zh = 5.4,
			en = 4.533
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
				arg_24_0:Play102111007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(arg_24_1.actors_["3008ui_story"]) and arg_24_1.var_.characterEffect3008ui_story == nil then
				arg_24_1.var_.characterEffect3008ui_story = arg_24_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_0 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 and not isNil(arg_24_1.actors_["3008ui_story"]) then
				if arg_24_1.var_.characterEffect3008ui_story and not isNil(arg_24_1.actors_["3008ui_story"]) then
					arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 and not isNil(arg_24_1.actors_["3008ui_story"]) and arg_24_1.var_.characterEffect3008ui_story then
				arg_24_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_27_2 = arg_24_1.actors_["1084ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1084ui_story == nil then
				arg_24_1.var_.characterEffect1084ui_story = var_27_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_3 = 0.1

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_3 and not isNil(var_27_2) then
				if arg_24_1.var_.characterEffect1084ui_story and not isNil(var_27_2) then
					arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_24_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_24_1.time_ - 0) / var_27_3)
				end
			end

			if arg_24_1.time_ >= 0 + var_27_3 and arg_24_1.time_ < 0 + var_27_3 + arg_27_0 and not isNil(var_27_2) and arg_24_1.var_.characterEffect1084ui_story then
				arg_24_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_24_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_27_4 = arg_24_1.actors_["1084ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1084ui_story = var_27_4.localPosition
			end

			local var_27_5 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_5 then
				var_27_4.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_24_1.time_ - 0) / var_27_5)
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

			local var_27_6 = arg_24_1.actors_["3008ui_story"].transform

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos3008ui_story = var_27_6.localPosition
			end

			local var_27_7 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_7 then
				var_27_6.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_24_1.time_ - 0) / var_27_7)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_7 and arg_24_1.time_ < 0 + var_27_7 + arg_27_0 then
				var_27_6.localPosition = Vector3.New(0, -1.51, -4.3)
				var_27_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_27_6.position).x, (manager.ui.mainCamera.transform.position - var_27_6.position).y, (manager.ui.mainCamera.transform.position - var_27_6.position).z)
				var_27_6.localEulerAngles.z = 0
				var_27_6.localEulerAngles.x = 0
				var_27_6.localEulerAngles = var_27_6.localEulerAngles
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_27_8 = 0
			local var_27_9 = 0.55

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_8 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_10 = arg_24_1:GetWordFromCfg(102111006)
				local var_27_11 = arg_24_1:FormatText(var_27_10.content)

				arg_24_1.text_.text = var_27_11

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_13 = 22 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_11) / 22)

				if (22 <= 0 and var_27_9 or var_27_9 * (utf8.len(var_27_11) / 22)) > 0 and var_27_9 < var_27_13 then
					arg_24_1.talkMaxDuration = var_27_13

					if var_27_13 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_13 + var_27_8
					end
				end

				arg_24_1.text_.text = var_27_11
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111006", "story_v_out_102111.awb") ~= 0 then
					local var_27_14 = manager.audio:GetVoiceLength("story_v_out_102111", "102111006", "story_v_out_102111.awb") / 1000

					if var_27_14 + var_27_8 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_14 + var_27_8
					end

					if var_27_10.prefab_name ~= "" and arg_24_1.actors_[var_27_10.prefab_name] ~= nil then
						local var_27_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_24_1.actors_[var_27_10.prefab_name].transform, "story_v_out_102111", "102111006", "story_v_out_102111.awb")

						arg_24_1:RecordAudio("102111006", var_27_15)
						arg_24_1:RecordAudio("102111006", var_27_15)
					else
						arg_24_1:AudioAction("play", "voice", "story_v_out_102111", "102111006", "story_v_out_102111.awb")
					end

					arg_24_1:RecordHistoryTalkVoice("story_v_out_102111", "102111006", "story_v_out_102111.awb")
				end

				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_16 = math.max(var_27_9, arg_24_1.talkMaxDuration)

			if var_27_8 <= arg_24_1.time_ and arg_24_1.time_ < var_27_8 + var_27_16 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_8) / var_27_16

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_8 + var_27_16 and arg_24_1.time_ < var_27_8 + var_27_16 + arg_27_0 then
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
				actorName = "3008ui_story",
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
	Play102111007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 102111007
		arg_28_1.duration_ = 7

		local var_28_0 = {
			ja = 6.6,
			ko = 4.233,
			zh = 5.4,
			en = 7
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
				arg_28_0:Play102111008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(arg_28_1.actors_["1011ui_story"]) and arg_28_1.var_.characterEffect1011ui_story == nil then
				arg_28_1.var_.characterEffect1011ui_story = arg_28_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_0 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 and not isNil(arg_28_1.actors_["1011ui_story"]) then
				if arg_28_1.var_.characterEffect1011ui_story and not isNil(arg_28_1.actors_["1011ui_story"]) then
					arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 and not isNil(arg_28_1.actors_["1011ui_story"]) and arg_28_1.var_.characterEffect1011ui_story then
				arg_28_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_31_2 = arg_28_1.actors_["3008ui_story"]

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect3008ui_story == nil then
				arg_28_1.var_.characterEffect3008ui_story = var_31_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_31_3 = 0.1

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_3 and not isNil(var_31_2) then
				if arg_28_1.var_.characterEffect3008ui_story and not isNil(var_31_2) then
					arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_28_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_28_1.time_ - 0) / var_31_3)
				end
			end

			if arg_28_1.time_ >= 0 + var_31_3 and arg_28_1.time_ < 0 + var_31_3 + arg_31_0 and not isNil(var_31_2) and arg_28_1.var_.characterEffect3008ui_story then
				arg_28_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_28_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_31_4 = arg_28_1.actors_["3008ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos3008ui_story = var_31_4.localPosition
			end

			local var_31_5 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_5 then
				var_31_4.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_28_1.time_ - 0) / var_31_5)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_5 and arg_28_1.time_ < 0 + var_31_5 + arg_31_0 then
				var_31_4.localPosition = Vector3.New(0, 100, 0)
				var_31_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_4.position).x, (manager.ui.mainCamera.transform.position - var_31_4.position).y, (manager.ui.mainCamera.transform.position - var_31_4.position).z)
				var_31_4.localEulerAngles.z = 0
				var_31_4.localEulerAngles.x = 0
				var_31_4.localEulerAngles = var_31_4.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action2_1")
			end

			local var_31_6 = arg_28_1.actors_["1011ui_story"].transform

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1011ui_story = var_31_6.localPosition
			end

			local var_31_7 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_7 then
				var_31_6.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_28_1.time_ - 0) / var_31_7)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_7 and arg_28_1.time_ < 0 + var_31_7 + arg_31_0 then
				var_31_6.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_31_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_31_6.position).x, (manager.ui.mainCamera.transform.position - var_31_6.position).y, (manager.ui.mainCamera.transform.position - var_31_6.position).z)
				var_31_6.localEulerAngles.z = 0
				var_31_6.localEulerAngles.x = 0
				var_31_6.localEulerAngles = var_31_6.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_31_8 = 0
			local var_31_9 = 0.575

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_8 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_10 = arg_28_1:GetWordFromCfg(102111007)
				local var_31_11 = arg_28_1:FormatText(var_31_10.content)

				arg_28_1.text_.text = var_31_11

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_13 = 23 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 23)

				if (23 <= 0 and var_31_9 or var_31_9 * (utf8.len(var_31_11) / 23)) > 0 and var_31_9 < var_31_13 then
					arg_28_1.talkMaxDuration = var_31_13

					if var_31_13 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_13 + var_31_8
					end
				end

				arg_28_1.text_.text = var_31_11
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111007", "story_v_out_102111.awb") ~= 0 then
					local var_31_14 = manager.audio:GetVoiceLength("story_v_out_102111", "102111007", "story_v_out_102111.awb") / 1000

					if var_31_14 + var_31_8 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_14 + var_31_8
					end

					if var_31_10.prefab_name ~= "" and arg_28_1.actors_[var_31_10.prefab_name] ~= nil then
						local var_31_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_28_1.actors_[var_31_10.prefab_name].transform, "story_v_out_102111", "102111007", "story_v_out_102111.awb")

						arg_28_1:RecordAudio("102111007", var_31_15)
						arg_28_1:RecordAudio("102111007", var_31_15)
					else
						arg_28_1:AudioAction("play", "voice", "story_v_out_102111", "102111007", "story_v_out_102111.awb")
					end

					arg_28_1:RecordHistoryTalkVoice("story_v_out_102111", "102111007", "story_v_out_102111.awb")
				end

				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_16 = math.max(var_31_9, arg_28_1.talkMaxDuration)

			if var_31_8 <= arg_28_1.time_ and arg_28_1.time_ < var_31_8 + var_31_16 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_8) / var_31_16

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_8 + var_31_16 and arg_28_1.time_ < var_31_8 + var_31_16 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
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
				actorName = "1011ui_story",
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
	Play102111008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 102111008
		arg_32_1.duration_ = 2.57

		local var_32_0 = {
			ja = 2.566,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_32_0:Play102111009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "1019ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1019ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["1019ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["1019ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["1019ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["1019ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1019ui_story == nil then
				arg_32_1.var_.characterEffect1019ui_story = var_35_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_4 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 and not isNil(var_35_3) then
				if arg_32_1.var_.characterEffect1019ui_story and not isNil(var_35_3) then
					arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 and not isNil(var_35_3) and arg_32_1.var_.characterEffect1019ui_story then
				arg_32_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_35_6 = arg_32_1.actors_["1011ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1011ui_story == nil then
				arg_32_1.var_.characterEffect1011ui_story = var_35_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_7 = 0.1

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_7 and not isNil(var_35_6) then
				if arg_32_1.var_.characterEffect1011ui_story and not isNil(var_35_6) then
					arg_32_1.var_.characterEffect1011ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_7)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_7 and arg_32_1.time_ < 0 + var_35_7 + arg_35_0 and not isNil(var_35_6) and arg_32_1.var_.characterEffect1011ui_story then
				arg_32_1.var_.characterEffect1011ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			local var_35_8 = arg_32_1.actors_["1019ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1019ui_story = var_35_8.localPosition
			end

			local var_35_9 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_9 then
				var_35_8.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_32_1.time_ - 0) / var_35_9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_9 and arg_32_1.time_ < 0 + var_35_9 + arg_35_0 then
				var_35_8.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_35_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_8.position).x, (manager.ui.mainCamera.transform.position - var_35_8.position).y, (manager.ui.mainCamera.transform.position - var_35_8.position).z)
				var_35_8.localEulerAngles.z = 0
				var_35_8.localEulerAngles.x = 0
				var_35_8.localEulerAngles = var_35_8.localEulerAngles
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_35_10 = 0
			local var_35_11 = 0.175

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_10 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_12 = arg_32_1:GetWordFromCfg(102111008)
				local var_35_13 = arg_32_1:FormatText(var_35_12.content)

				arg_32_1.text_.text = var_35_13

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_15 = 7 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 7)

				if (7 <= 0 and var_35_11 or var_35_11 * (utf8.len(var_35_13) / 7)) > 0 and var_35_11 < var_35_15 then
					arg_32_1.talkMaxDuration = var_35_15

					if var_35_15 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_15 + var_35_10
					end
				end

				arg_32_1.text_.text = var_35_13
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111008", "story_v_out_102111.awb") ~= 0 then
					local var_35_16 = manager.audio:GetVoiceLength("story_v_out_102111", "102111008", "story_v_out_102111.awb") / 1000

					if var_35_16 + var_35_10 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_10
					end

					if var_35_12.prefab_name ~= "" and arg_32_1.actors_[var_35_12.prefab_name] ~= nil then
						local var_35_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_32_1.actors_[var_35_12.prefab_name].transform, "story_v_out_102111", "102111008", "story_v_out_102111.awb")

						arg_32_1:RecordAudio("102111008", var_35_17)
						arg_32_1:RecordAudio("102111008", var_35_17)
					else
						arg_32_1:AudioAction("play", "voice", "story_v_out_102111", "102111008", "story_v_out_102111.awb")
					end

					arg_32_1:RecordHistoryTalkVoice("story_v_out_102111", "102111008", "story_v_out_102111.awb")
				end

				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_18 = math.max(var_35_11, arg_32_1.talkMaxDuration)

			if var_35_10 <= arg_32_1.time_ and arg_32_1.time_ < var_35_10 + var_35_18 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_10) / var_35_18

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_10 + var_35_18 and arg_32_1.time_ < var_35_10 + var_35_18 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
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

		arg_32_1:InitPlayNodeList()
	end,
	Play102111009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 102111009
		arg_36_1.duration_ = 3.07

		local var_36_0 = {
			ja = 3.066,
			ko = 2.4,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_36_0:Play102111010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1084ui_story"]) and arg_36_1.var_.characterEffect1084ui_story == nil then
				arg_36_1.var_.characterEffect1084ui_story = arg_36_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1084ui_story"]) then
				if arg_36_1.var_.characterEffect1084ui_story and not isNil(arg_36_1.actors_["1084ui_story"]) then
					arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1084ui_story"]) and arg_36_1.var_.characterEffect1084ui_story then
				arg_36_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_39_2 = arg_36_1.actors_["1019ui_story"]

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1019ui_story == nil then
				arg_36_1.var_.characterEffect1019ui_story = var_39_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_3 = 0.1

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_3 and not isNil(var_39_2) then
				if arg_36_1.var_.characterEffect1019ui_story and not isNil(var_39_2) then
					arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_3)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_3 and arg_36_1.time_ < 0 + var_39_3 + arg_39_0 and not isNil(var_39_2) and arg_36_1.var_.characterEffect1019ui_story then
				arg_36_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_39_4 = arg_36_1.actors_["1019ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1019ui_story = var_39_4.localPosition
			end

			local var_39_5 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_5 then
				var_39_4.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_5)
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
				var_39_6.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_36_1.time_ - 0) / var_39_7)
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

			local var_39_8 = arg_36_1.actors_["1084ui_story"].transform

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1.var_.moveOldPos1084ui_story = var_39_8.localPosition
			end

			local var_39_9 = 0.001

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_9 then
				var_39_8.localPosition = Vector3.Lerp(arg_36_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_36_1.time_ - 0) / var_39_9)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if arg_36_1.time_ >= 0 + var_39_9 and arg_36_1.time_ < 0 + var_39_9 + arg_39_0 then
				var_39_8.localPosition = Vector3.New(0, -0.97, -6)
				var_39_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_39_8.position).x, (manager.ui.mainCamera.transform.position - var_39_8.position).y, (manager.ui.mainCamera.transform.position - var_39_8.position).z)
				var_39_8.localEulerAngles.z = 0
				var_39_8.localEulerAngles.x = 0
				var_39_8.localEulerAngles = var_39_8.localEulerAngles
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action8_1")
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_39_10 = 0
			local var_39_11 = 0.175

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_10 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, false)
				arg_36_1.callingController_:SetSelectedState("normal")

				local var_39_12 = arg_36_1:GetWordFromCfg(102111009)
				local var_39_13 = arg_36_1:FormatText(var_39_12.content)

				arg_36_1.text_.text = var_39_13

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_15 = 7 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 7)

				if (7 <= 0 and var_39_11 or var_39_11 * (utf8.len(var_39_13) / 7)) > 0 and var_39_11 < var_39_15 then
					arg_36_1.talkMaxDuration = var_39_15

					if var_39_15 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_15 + var_39_10
					end
				end

				arg_36_1.text_.text = var_39_13
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111009", "story_v_out_102111.awb") ~= 0 then
					local var_39_16 = manager.audio:GetVoiceLength("story_v_out_102111", "102111009", "story_v_out_102111.awb") / 1000

					if var_39_16 + var_39_10 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_16 + var_39_10
					end

					if var_39_12.prefab_name ~= "" and arg_36_1.actors_[var_39_12.prefab_name] ~= nil then
						local var_39_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_36_1.actors_[var_39_12.prefab_name].transform, "story_v_out_102111", "102111009", "story_v_out_102111.awb")

						arg_36_1:RecordAudio("102111009", var_39_17)
						arg_36_1:RecordAudio("102111009", var_39_17)
					else
						arg_36_1:AudioAction("play", "voice", "story_v_out_102111", "102111009", "story_v_out_102111.awb")
					end

					arg_36_1:RecordHistoryTalkVoice("story_v_out_102111", "102111009", "story_v_out_102111.awb")
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
				actorName = "1084ui_story",
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
	Play102111010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 102111010
		arg_40_1.duration_ = 4.97

		local var_40_0 = {
			ja = 2.633,
			ko = 3.433,
			zh = 3.8,
			en = 4.966
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
				arg_40_0:Play102111011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(arg_40_1.actors_["1011ui_story"]) and arg_40_1.var_.characterEffect1011ui_story == nil then
				arg_40_1.var_.characterEffect1011ui_story = arg_40_1.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_0 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 and not isNil(arg_40_1.actors_["1011ui_story"]) then
				if arg_40_1.var_.characterEffect1011ui_story and not isNil(arg_40_1.actors_["1011ui_story"]) then
					arg_40_1.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 and not isNil(arg_40_1.actors_["1011ui_story"]) and arg_40_1.var_.characterEffect1011ui_story then
				arg_40_1.var_.characterEffect1011ui_story.fillFlat = false
			end

			local var_43_2 = arg_40_1.actors_["1084ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1084ui_story == nil then
				arg_40_1.var_.characterEffect1084ui_story = var_43_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_3 = 0.1

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_3 and not isNil(var_43_2) then
				if arg_40_1.var_.characterEffect1084ui_story and not isNil(var_43_2) then
					arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_40_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_40_1.time_ - 0) / var_43_3)
				end
			end

			if arg_40_1.time_ >= 0 + var_43_3 and arg_40_1.time_ < 0 + var_43_3 + arg_43_0 and not isNil(var_43_2) and arg_40_1.var_.characterEffect1084ui_story then
				arg_40_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_40_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_43_4 = arg_40_1.actors_["1084ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1084ui_story = var_43_4.localPosition
			end

			local var_43_5 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_5 then
				var_43_4.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_40_1.time_ - 0) / var_43_5)
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

			local var_43_6 = arg_40_1.actors_["1011ui_story"].transform

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1011ui_story = var_43_6.localPosition
			end

			local var_43_7 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_7 then
				var_43_6.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1011ui_story, Vector3.New(-0.7, -0.71, -6), (arg_40_1.time_ - 0) / var_43_7)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_7 and arg_40_1.time_ < 0 + var_43_7 + arg_43_0 then
				var_43_6.localPosition = Vector3.New(-0.7, -0.71, -6)
				var_43_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_43_6.position).x, (manager.ui.mainCamera.transform.position - var_43_6.position).y, (manager.ui.mainCamera.transform.position - var_43_6.position).z)
				var_43_6.localEulerAngles.z = 0
				var_43_6.localEulerAngles.x = 0
				var_43_6.localEulerAngles = var_43_6.localEulerAngles
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/story1011/story1011action/1011action6_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1011ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			local var_43_8 = 0
			local var_43_9 = 0.55

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_8 + arg_43_0 then
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

				local var_43_10 = arg_40_1:GetWordFromCfg(102111010)
				local var_43_11 = arg_40_1:FormatText(var_43_10.content)

				arg_40_1.text_.text = var_43_11

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_13 = 22 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 22)

				if (22 <= 0 and var_43_9 or var_43_9 * (utf8.len(var_43_11) / 22)) > 0 and var_43_9 < var_43_13 then
					arg_40_1.talkMaxDuration = var_43_13

					if var_43_13 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_13 + var_43_8
					end
				end

				arg_40_1.text_.text = var_43_11
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111010", "story_v_out_102111.awb") ~= 0 then
					local var_43_14 = manager.audio:GetVoiceLength("story_v_out_102111", "102111010", "story_v_out_102111.awb") / 1000

					if var_43_14 + var_43_8 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_14 + var_43_8
					end

					if var_43_10.prefab_name ~= "" and arg_40_1.actors_[var_43_10.prefab_name] ~= nil then
						local var_43_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_40_1.actors_[var_43_10.prefab_name].transform, "story_v_out_102111", "102111010", "story_v_out_102111.awb")

						arg_40_1:RecordAudio("102111010", var_43_15)
						arg_40_1:RecordAudio("102111010", var_43_15)
					else
						arg_40_1:AudioAction("play", "voice", "story_v_out_102111", "102111010", "story_v_out_102111.awb")
					end

					arg_40_1:RecordHistoryTalkVoice("story_v_out_102111", "102111010", "story_v_out_102111.awb")
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

		arg_40_1:InitPlayNodeList()
	end,
	Play102111011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 102111011
		arg_44_1.duration_ = 7.9

		local var_44_0 = {
			ja = 7.9,
			ko = 3.833,
			zh = 3.5,
			en = 3.633
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
				arg_44_0:Play102111012(arg_44_1)
			end
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

			local var_47_4 = arg_44_1.actors_["1019ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1019ui_story = var_47_4.localPosition
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_4.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (arg_44_1.time_ - 0) / var_47_5)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_4.localPosition = Vector3.New(0.7, -1.08, -5.9)
				var_47_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_4.position).x, (manager.ui.mainCamera.transform.position - var_47_4.position).y, (manager.ui.mainCamera.transform.position - var_47_4.position).z)
				var_47_4.localEulerAngles.z = 0
				var_47_4.localEulerAngles.x = 0
				var_47_4.localEulerAngles = var_47_4.localEulerAngles
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action6_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			local var_47_6 = 0
			local var_47_7 = 0.475

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_6 + arg_47_0 then
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

				local var_47_8 = arg_44_1:GetWordFromCfg(102111011)
				local var_47_9 = arg_44_1:FormatText(var_47_8.content)

				arg_44_1.text_.text = var_47_9

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_11 = 19 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 19)

				if (19 <= 0 and var_47_7 or var_47_7 * (utf8.len(var_47_9) / 19)) > 0 and var_47_7 < var_47_11 then
					arg_44_1.talkMaxDuration = var_47_11

					if var_47_11 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_11 + var_47_6
					end
				end

				arg_44_1.text_.text = var_47_9
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111011", "story_v_out_102111.awb") ~= 0 then
					local var_47_12 = manager.audio:GetVoiceLength("story_v_out_102111", "102111011", "story_v_out_102111.awb") / 1000

					if var_47_12 + var_47_6 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_12 + var_47_6
					end

					if var_47_8.prefab_name ~= "" and arg_44_1.actors_[var_47_8.prefab_name] ~= nil then
						local var_47_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_44_1.actors_[var_47_8.prefab_name].transform, "story_v_out_102111", "102111011", "story_v_out_102111.awb")

						arg_44_1:RecordAudio("102111011", var_47_13)
						arg_44_1:RecordAudio("102111011", var_47_13)
					else
						arg_44_1:AudioAction("play", "voice", "story_v_out_102111", "102111011", "story_v_out_102111.awb")
					end

					arg_44_1:RecordHistoryTalkVoice("story_v_out_102111", "102111011", "story_v_out_102111.awb")
				end

				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_14 = math.max(var_47_7, arg_44_1.talkMaxDuration)

			if var_47_6 <= arg_44_1.time_ and arg_44_1.time_ < var_47_6 + var_47_14 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_6) / var_47_14

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_6 + var_47_14 and arg_44_1.time_ < var_47_6 + var_47_14 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
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
	Play102111012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 102111012
		arg_48_1.duration_ = 7.47

		local var_48_0 = {
			ja = 7.466,
			ko = 3.533,
			zh = 3.166,
			en = 4.166
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
				arg_48_0:Play102111013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(arg_48_1.actors_["3008ui_story"]) and arg_48_1.var_.characterEffect3008ui_story == nil then
				arg_48_1.var_.characterEffect3008ui_story = arg_48_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_0 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_0 and not isNil(arg_48_1.actors_["3008ui_story"]) then
				if arg_48_1.var_.characterEffect3008ui_story and not isNil(arg_48_1.actors_["3008ui_story"]) then
					arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_0 and arg_48_1.time_ < 0 + var_51_0 + arg_51_0 and not isNil(arg_48_1.actors_["3008ui_story"]) and arg_48_1.var_.characterEffect3008ui_story then
				arg_48_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_51_2 = arg_48_1.actors_["1019ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1019ui_story == nil then
				arg_48_1.var_.characterEffect1019ui_story = var_51_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_3 = 0.1

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_3 and not isNil(var_51_2) then
				if arg_48_1.var_.characterEffect1019ui_story and not isNil(var_51_2) then
					arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_3)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_3 and arg_48_1.time_ < 0 + var_51_3 + arg_51_0 and not isNil(var_51_2) and arg_48_1.var_.characterEffect1019ui_story then
				arg_48_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_51_4 = arg_48_1.actors_["1019ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1019ui_story = var_51_4.localPosition
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_4.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_5)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_4.localPosition = Vector3.New(0, 100, 0)
				var_51_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_4.position).x, (manager.ui.mainCamera.transform.position - var_51_4.position).y, (manager.ui.mainCamera.transform.position - var_51_4.position).z)
				var_51_4.localEulerAngles.z = 0
				var_51_4.localEulerAngles.x = 0
				var_51_4.localEulerAngles = var_51_4.localEulerAngles
			end

			local var_51_6 = arg_48_1.actors_["1011ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1011ui_story = var_51_6.localPosition
			end

			local var_51_7 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_7 then
				var_51_6.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_7)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_7 and arg_48_1.time_ < 0 + var_51_7 + arg_51_0 then
				var_51_6.localPosition = Vector3.New(0, 100, 0)
				var_51_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_6.position).x, (manager.ui.mainCamera.transform.position - var_51_6.position).y, (manager.ui.mainCamera.transform.position - var_51_6.position).z)
				var_51_6.localEulerAngles.z = 0
				var_51_6.localEulerAngles.x = 0
				var_51_6.localEulerAngles = var_51_6.localEulerAngles
			end

			local var_51_8 = arg_48_1.actors_["3008ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos3008ui_story = var_51_8.localPosition
			end

			local var_51_9 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_9 then
				var_51_8.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos3008ui_story, Vector3.New(0, -1.51, -4.3), (arg_48_1.time_ - 0) / var_51_9)
				var_51_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_8.position).x, (manager.ui.mainCamera.transform.position - var_51_8.position).y, (manager.ui.mainCamera.transform.position - var_51_8.position).z)
				var_51_8.localEulerAngles.z = 0
				var_51_8.localEulerAngles.x = 0
				var_51_8.localEulerAngles = var_51_8.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_9 and arg_48_1.time_ < 0 + var_51_9 + arg_51_0 then
				var_51_8.localPosition = Vector3.New(0, -1.51, -4.3)
				var_51_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_8.position).x, (manager.ui.mainCamera.transform.position - var_51_8.position).y, (manager.ui.mainCamera.transform.position - var_51_8.position).z)
				var_51_8.localEulerAngles.z = 0
				var_51_8.localEulerAngles.x = 0
				var_51_8.localEulerAngles = var_51_8.localEulerAngles
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_51_10 = 0
			local var_51_11 = 0.3

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_10 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_12 = arg_48_1:GetWordFromCfg(102111012)
				local var_51_13 = arg_48_1:FormatText(var_51_12.content)

				arg_48_1.text_.text = var_51_13

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_15 = 12 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 12)

				if (12 <= 0 and var_51_11 or var_51_11 * (utf8.len(var_51_13) / 12)) > 0 and var_51_11 < var_51_15 then
					arg_48_1.talkMaxDuration = var_51_15

					if var_51_15 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_15 + var_51_10
					end
				end

				arg_48_1.text_.text = var_51_13
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111012", "story_v_out_102111.awb") ~= 0 then
					local var_51_16 = manager.audio:GetVoiceLength("story_v_out_102111", "102111012", "story_v_out_102111.awb") / 1000

					if var_51_16 + var_51_10 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_16 + var_51_10
					end

					if var_51_12.prefab_name ~= "" and arg_48_1.actors_[var_51_12.prefab_name] ~= nil then
						local var_51_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_48_1.actors_[var_51_12.prefab_name].transform, "story_v_out_102111", "102111012", "story_v_out_102111.awb")

						arg_48_1:RecordAudio("102111012", var_51_17)
						arg_48_1:RecordAudio("102111012", var_51_17)
					else
						arg_48_1:AudioAction("play", "voice", "story_v_out_102111", "102111012", "story_v_out_102111.awb")
					end

					arg_48_1:RecordHistoryTalkVoice("story_v_out_102111", "102111012", "story_v_out_102111.awb")
				end

				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_18 = math.max(var_51_11, arg_48_1.talkMaxDuration)

			if var_51_10 <= arg_48_1.time_ and arg_48_1.time_ < var_51_10 + var_51_18 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_10) / var_51_18

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_10 + var_51_18 and arg_48_1.time_ < var_51_10 + var_51_18 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
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
	Play102111013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 102111013
		arg_52_1.duration_ = 4.53

		local var_52_0 = {
			ja = 4.533,
			ko = 3.566,
			zh = 3.4,
			en = 3.266
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
				arg_52_0:Play102111014(arg_52_1)
			end
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if arg_52_1.actors_["2020_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2020_tpose"))) then
				local var_55_0 = Object.Instantiate(Asset.Load("Char/" .. "2020_tpose"), arg_52_1.stage_.transform)

				var_55_0.name = "2020_tpose"
				var_55_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_["2020_tpose"] = var_55_0

				local var_55_1 = var_55_0:GetComponentInChildren(typeof(CharacterEffect))

				var_55_1.enabled = true

				local var_55_2 = GameObjectTools.GetOrAddComponent(var_55_0, typeof(DynamicBoneHelper))

				if var_55_2 then
					var_55_2:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_1.transform, false)

				arg_52_1.var_["2020_tpose" .. "Animator"] = var_55_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_["2020_tpose" .. "Animator"].applyRootMotion = true
				arg_52_1.var_["2020_tpose" .. "LipSync"] = var_55_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_3 = arg_52_1.actors_["2020_tpose"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect2020_tpose == nil then
				arg_52_1.var_.characterEffect2020_tpose = var_55_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_4 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_4 and not isNil(var_55_3) then
				if arg_52_1.var_.characterEffect2020_tpose and not isNil(var_55_3) then
					arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_52_1.time_ >= 0 + var_55_4 and arg_52_1.time_ < 0 + var_55_4 + arg_55_0 and not isNil(var_55_3) and arg_52_1.var_.characterEffect2020_tpose then
				arg_52_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_55_6 = arg_52_1.actors_["3008ui_story"]

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect3008ui_story == nil then
				arg_52_1.var_.characterEffect3008ui_story = var_55_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_7 = 0.1

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_7 and not isNil(var_55_6) then
				if arg_52_1.var_.characterEffect3008ui_story and not isNil(var_55_6) then
					arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_52_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_7)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_7 and arg_52_1.time_ < 0 + var_55_7 + arg_55_0 and not isNil(var_55_6) and arg_52_1.var_.characterEffect3008ui_story then
				arg_52_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_52_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_55_8 = arg_52_1.actors_["3008ui_story"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos3008ui_story = var_55_8.localPosition
			end

			local var_55_9 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_9 then
				var_55_8.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_52_1.time_ - 0) / var_55_9)
				var_55_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_8.position).x, (manager.ui.mainCamera.transform.position - var_55_8.position).y, (manager.ui.mainCamera.transform.position - var_55_8.position).z)
				var_55_8.localEulerAngles.z = 0
				var_55_8.localEulerAngles.x = 0
				var_55_8.localEulerAngles = var_55_8.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_9 and arg_52_1.time_ < 0 + var_55_9 + arg_55_0 then
				var_55_8.localPosition = Vector3.New(0, 100, 0)
				var_55_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_8.position).x, (manager.ui.mainCamera.transform.position - var_55_8.position).y, (manager.ui.mainCamera.transform.position - var_55_8.position).z)
				var_55_8.localEulerAngles.z = 0
				var_55_8.localEulerAngles.x = 0
				var_55_8.localEulerAngles = var_55_8.localEulerAngles
			end

			local var_55_10 = arg_52_1.actors_["2020_tpose"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos2020_tpose = var_55_10.localPosition

				local var_55_11 = GameObjectTools.GetOrAddComponent(var_55_10.gameObject, typeof(DynamicBoneHelper))

				if var_55_11 then
					var_55_11:EnableDynamicBone(false)
				end
			end

			local var_55_12 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_12 then
				var_55_10.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (arg_52_1.time_ - 0) / var_55_12)
				var_55_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_10.position).x, (manager.ui.mainCamera.transform.position - var_55_10.position).y, (manager.ui.mainCamera.transform.position - var_55_10.position).z)
				var_55_10.localEulerAngles.z = 0
				var_55_10.localEulerAngles.x = 0
				var_55_10.localEulerAngles = var_55_10.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_12 and arg_52_1.time_ < 0 + var_55_12 + arg_55_0 then
				var_55_10.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				var_55_10.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_10.position).x, (manager.ui.mainCamera.transform.position - var_55_10.position).y, (manager.ui.mainCamera.transform.position - var_55_10.position).z)
				var_55_10.localEulerAngles.z = 0
				var_55_10.localEulerAngles.x = 0
				var_55_10.localEulerAngles = var_55_10.localEulerAngles

				local var_55_13 = GameObjectTools.GetOrAddComponent(var_55_10.gameObject, typeof(DynamicBoneHelper))

				if var_55_13 then
					var_55_13:EnableDynamicBone(true)
				end
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			local var_55_14 = "2030_tpose"

			if arg_52_1.actors_["2030_tpose"] == nil and not isNil((Asset.Load("Char/" .. "2030_tpose"))) then
				local var_55_15 = Object.Instantiate(Asset.Load("Char/" .. "2030_tpose"), arg_52_1.stage_.transform)

				var_55_15.name = var_55_14
				var_55_15.transform.localPosition = Vector3.New(0, 100, 0)
				arg_52_1.actors_[var_55_14] = var_55_15

				local var_55_16 = var_55_15:GetComponentInChildren(typeof(CharacterEffect))

				var_55_16.enabled = true

				local var_55_17 = GameObjectTools.GetOrAddComponent(var_55_15, typeof(DynamicBoneHelper))

				if var_55_17 then
					var_55_17:EnableDynamicBone(false)
				end

				arg_52_1:ShowWeapon(var_55_16.transform, false)

				arg_52_1.var_[var_55_14 .. "Animator"] = var_55_16.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_52_1.var_[var_55_14 .. "Animator"].applyRootMotion = true
				arg_52_1.var_[var_55_14 .. "LipSync"] = var_55_16.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_55_18 = arg_52_1.actors_["2030_tpose"].transform

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1.var_.moveOldPos2030_tpose = var_55_18.localPosition

				local var_55_19 = GameObjectTools.GetOrAddComponent(var_55_18.gameObject, typeof(DynamicBoneHelper))

				if var_55_19 then
					var_55_19:EnableDynamicBone(false)
				end
			end

			local var_55_20 = 0.001

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_20 then
				var_55_18.localPosition = Vector3.Lerp(arg_52_1.var_.moveOldPos2030_tpose, Vector3.New(0.7, -1.2, -4.2), (arg_52_1.time_ - 0) / var_55_20)
				var_55_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_18.position).x, (manager.ui.mainCamera.transform.position - var_55_18.position).y, (manager.ui.mainCamera.transform.position - var_55_18.position).z)
				var_55_18.localEulerAngles.z = 0
				var_55_18.localEulerAngles.x = 0
				var_55_18.localEulerAngles = var_55_18.localEulerAngles
			end

			if arg_52_1.time_ >= 0 + var_55_20 and arg_52_1.time_ < 0 + var_55_20 + arg_55_0 then
				var_55_18.localPosition = Vector3.New(0.7, -1.2, -4.2)
				var_55_18.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_55_18.position).x, (manager.ui.mainCamera.transform.position - var_55_18.position).y, (manager.ui.mainCamera.transform.position - var_55_18.position).z)
				var_55_18.localEulerAngles.z = 0
				var_55_18.localEulerAngles.x = 0
				var_55_18.localEulerAngles = var_55_18.localEulerAngles

				local var_55_21 = GameObjectTools.GetOrAddComponent(var_55_18.gameObject, typeof(DynamicBoneHelper))

				if var_55_21 then
					var_55_21:EnableDynamicBone(true)
				end
			end

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 then
				arg_52_1:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			local var_55_22 = 0
			local var_55_23 = 0.325

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_22 + arg_55_0 then
				arg_52_1.talkMaxDuration = 0
				arg_52_1.dialogCg_.alpha = 1

				arg_52_1.dialog_:SetActive(true)
				SetActive(arg_52_1.leftNameGo_, true)

				arg_52_1.leftNameTxt_.text = arg_52_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_52_1.leftNameTxt_.transform)

				arg_52_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_52_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_52_1:RecordName(arg_52_1.leftNameTxt_.text)
				SetActive(arg_52_1.iconTrs_.gameObject, false)
				arg_52_1.callingController_:SetSelectedState("normal")

				local var_55_24 = arg_52_1:GetWordFromCfg(102111013)
				local var_55_25 = arg_52_1:FormatText(var_55_24.content)

				arg_52_1.text_.text = var_55_25

				LuaForUtil.ClearLinePrefixSymbol(arg_52_1.text_)

				local var_55_27 = 13 <= 0 and var_55_23 or var_55_23 * (utf8.len(var_55_25) / 13)

				if (13 <= 0 and var_55_23 or var_55_23 * (utf8.len(var_55_25) / 13)) > 0 and var_55_23 < var_55_27 then
					arg_52_1.talkMaxDuration = var_55_27

					if var_55_27 + var_55_22 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_27 + var_55_22
					end
				end

				arg_52_1.text_.text = var_55_25
				arg_52_1.typewritter.percent = 0

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111013", "story_v_out_102111.awb") ~= 0 then
					local var_55_28 = manager.audio:GetVoiceLength("story_v_out_102111", "102111013", "story_v_out_102111.awb") / 1000

					if var_55_28 + var_55_22 > arg_52_1.duration_ then
						arg_52_1.duration_ = var_55_28 + var_55_22
					end

					if var_55_24.prefab_name ~= "" and arg_52_1.actors_[var_55_24.prefab_name] ~= nil then
						local var_55_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_52_1.actors_[var_55_24.prefab_name].transform, "story_v_out_102111", "102111013", "story_v_out_102111.awb")

						arg_52_1:RecordAudio("102111013", var_55_29)
						arg_52_1:RecordAudio("102111013", var_55_29)
					else
						arg_52_1:AudioAction("play", "voice", "story_v_out_102111", "102111013", "story_v_out_102111.awb")
					end

					arg_52_1:RecordHistoryTalkVoice("story_v_out_102111", "102111013", "story_v_out_102111.awb")
				end

				arg_52_1:RecordContent(arg_52_1.text_.text)
			end

			local var_55_30 = math.max(var_55_23, arg_52_1.talkMaxDuration)

			if var_55_22 <= arg_52_1.time_ and arg_52_1.time_ < var_55_22 + var_55_30 then
				arg_52_1.typewritter.percent = (arg_52_1.time_ - var_55_22) / var_55_30

				arg_52_1.typewritter:SetDirty()
			end

			if arg_52_1.time_ >= var_55_22 + var_55_30 and arg_52_1.time_ < var_55_22 + var_55_30 + arg_55_0 then
				arg_52_1.typewritter.percent = 1

				arg_52_1.typewritter:SetDirty()
				arg_52_1:ShowNextGo(true)
			end
		end

		arg_52_1.nodeConfigList_ = {
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
			}
		}

		arg_52_1:InitPlayNodeList()
	end,
	Play102111014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 102111014
		arg_56_1.duration_ = 4.83

		local var_56_0 = {
			ja = 4.833,
			ko = 4.3,
			zh = 3.8,
			en = 3.633
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
				arg_56_0:Play102111015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(arg_56_1.actors_["2020_tpose"]) and arg_56_1.var_.characterEffect2020_tpose == nil then
				arg_56_1.var_.characterEffect2020_tpose = arg_56_1.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_0 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_0 and not isNil(arg_56_1.actors_["2020_tpose"]) then
				if arg_56_1.var_.characterEffect2020_tpose and not isNil(arg_56_1.actors_["2020_tpose"]) then
					arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if arg_56_1.time_ >= 0 + var_59_0 and arg_56_1.time_ < 0 + var_59_0 + arg_59_0 and not isNil(arg_56_1.actors_["2020_tpose"]) and arg_56_1.var_.characterEffect2020_tpose then
				arg_56_1.var_.characterEffect2020_tpose.fillFlat = false
			end

			local var_59_2 = arg_56_1.actors_["2030_tpose"]

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect2030_tpose == nil then
				arg_56_1.var_.characterEffect2030_tpose = var_59_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_59_3 = 0.1

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_3 and not isNil(var_59_2) then
				if arg_56_1.var_.characterEffect2030_tpose and not isNil(var_59_2) then
					arg_56_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_56_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_56_1.time_ - 0) / var_59_3)
				end
			end

			if arg_56_1.time_ >= 0 + var_59_3 and arg_56_1.time_ < 0 + var_59_3 + arg_59_0 and not isNil(var_59_2) and arg_56_1.var_.characterEffect2030_tpose then
				arg_56_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_56_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_59_4 = 0
			local var_59_5 = 0.5

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= var_59_4 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, false)
				arg_56_1.callingController_:SetSelectedState("normal")

				local var_59_6 = arg_56_1:GetWordFromCfg(102111014)
				local var_59_7 = arg_56_1:FormatText(var_59_6.content)

				arg_56_1.text_.text = var_59_7

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_9 = 20 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 20)

				if (20 <= 0 and var_59_5 or var_59_5 * (utf8.len(var_59_7) / 20)) > 0 and var_59_5 < var_59_9 then
					arg_56_1.talkMaxDuration = var_59_9

					if var_59_9 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_9 + var_59_4
					end
				end

				arg_56_1.text_.text = var_59_7
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111014", "story_v_out_102111.awb") ~= 0 then
					local var_59_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111014", "story_v_out_102111.awb") / 1000

					if var_59_10 + var_59_4 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_10 + var_59_4
					end

					if var_59_6.prefab_name ~= "" and arg_56_1.actors_[var_59_6.prefab_name] ~= nil then
						local var_59_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_56_1.actors_[var_59_6.prefab_name].transform, "story_v_out_102111", "102111014", "story_v_out_102111.awb")

						arg_56_1:RecordAudio("102111014", var_59_11)
						arg_56_1:RecordAudio("102111014", var_59_11)
					else
						arg_56_1:AudioAction("play", "voice", "story_v_out_102111", "102111014", "story_v_out_102111.awb")
					end

					arg_56_1:RecordHistoryTalkVoice("story_v_out_102111", "102111014", "story_v_out_102111.awb")
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
	Play102111015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 102111015
		arg_60_1.duration_ = 5

		local var_60_0 = {
			ja = 5,
			ko = 3.733,
			zh = 3.033,
			en = 3.233
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
				arg_60_0:Play102111016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(arg_60_1.actors_["2030_tpose"]) and arg_60_1.var_.characterEffect2030_tpose == nil then
				arg_60_1.var_.characterEffect2030_tpose = arg_60_1.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_0 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_0 and not isNil(arg_60_1.actors_["2030_tpose"]) then
				if arg_60_1.var_.characterEffect2030_tpose and not isNil(arg_60_1.actors_["2030_tpose"]) then
					arg_60_1.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_0 and arg_60_1.time_ < 0 + var_63_0 + arg_63_0 and not isNil(arg_60_1.actors_["2030_tpose"]) and arg_60_1.var_.characterEffect2030_tpose then
				arg_60_1.var_.characterEffect2030_tpose.fillFlat = false
			end

			local var_63_2 = arg_60_1.actors_["2020_tpose"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect2020_tpose == nil then
				arg_60_1.var_.characterEffect2020_tpose = var_63_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_3 = 0.1

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_3 and not isNil(var_63_2) then
				if arg_60_1.var_.characterEffect2020_tpose and not isNil(var_63_2) then
					arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
					arg_60_1.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_60_1.time_ - 0) / var_63_3)
				end
			end

			if arg_60_1.time_ >= 0 + var_63_3 and arg_60_1.time_ < 0 + var_63_3 + arg_63_0 and not isNil(var_63_2) and arg_60_1.var_.characterEffect2020_tpose then
				arg_60_1.var_.characterEffect2020_tpose.fillFlat = true
				arg_60_1.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			local var_63_4 = 0
			local var_63_5 = 0.5

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_4 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_6 = arg_60_1:GetWordFromCfg(102111015)
				local var_63_7 = arg_60_1:FormatText(var_63_6.content)

				arg_60_1.text_.text = var_63_7

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_9 = 20 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 20)

				if (20 <= 0 and var_63_5 or var_63_5 * (utf8.len(var_63_7) / 20)) > 0 and var_63_5 < var_63_9 then
					arg_60_1.talkMaxDuration = var_63_9

					if var_63_9 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_9 + var_63_4
					end
				end

				arg_60_1.text_.text = var_63_7
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111015", "story_v_out_102111.awb") ~= 0 then
					local var_63_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111015", "story_v_out_102111.awb") / 1000

					if var_63_10 + var_63_4 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_4
					end

					if var_63_6.prefab_name ~= "" and arg_60_1.actors_[var_63_6.prefab_name] ~= nil then
						local var_63_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_60_1.actors_[var_63_6.prefab_name].transform, "story_v_out_102111", "102111015", "story_v_out_102111.awb")

						arg_60_1:RecordAudio("102111015", var_63_11)
						arg_60_1:RecordAudio("102111015", var_63_11)
					else
						arg_60_1:AudioAction("play", "voice", "story_v_out_102111", "102111015", "story_v_out_102111.awb")
					end

					arg_60_1:RecordHistoryTalkVoice("story_v_out_102111", "102111015", "story_v_out_102111.awb")
				end

				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_12 = math.max(var_63_5, arg_60_1.talkMaxDuration)

			if var_63_4 <= arg_60_1.time_ and arg_60_1.time_ < var_63_4 + var_63_12 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_4) / var_63_12

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_4 + var_63_12 and arg_60_1.time_ < var_63_4 + var_63_12 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {}

		arg_60_1:InitPlayNodeList()
	end,
	Play102111016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 102111016
		arg_64_1.duration_ = 6.43

		local var_64_0 = {
			ja = 6.433,
			ko = 2.233,
			zh = 2.8,
			en = 2.533
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
				arg_64_0:Play102111017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story == nil then
				arg_64_1.var_.characterEffect1084ui_story = arg_64_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) then
				if arg_64_1.var_.characterEffect1084ui_story and not isNil(arg_64_1.actors_["1084ui_story"]) then
					arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1084ui_story"]) and arg_64_1.var_.characterEffect1084ui_story then
				arg_64_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_67_2 = arg_64_1.actors_["2030_tpose"]

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect2030_tpose == nil then
				arg_64_1.var_.characterEffect2030_tpose = var_67_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_3 = 0.1

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_3 and not isNil(var_67_2) then
				if arg_64_1.var_.characterEffect2030_tpose and not isNil(var_67_2) then
					arg_64_1.var_.characterEffect2030_tpose.fillFlat = true
					arg_64_1.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_3)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_3 and arg_64_1.time_ < 0 + var_67_3 + arg_67_0 and not isNil(var_67_2) and arg_64_1.var_.characterEffect2030_tpose then
				arg_64_1.var_.characterEffect2030_tpose.fillFlat = true
				arg_64_1.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			local var_67_4 = arg_64_1.actors_["2030_tpose"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos2030_tpose = var_67_4.localPosition

				local var_67_5 = GameObjectTools.GetOrAddComponent(var_67_4.gameObject, typeof(DynamicBoneHelper))

				if var_67_5 then
					var_67_5:EnableDynamicBone(false)
				end
			end

			local var_67_6 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_6 then
				var_67_4.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_6)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_6 and arg_64_1.time_ < 0 + var_67_6 + arg_67_0 then
				var_67_4.localPosition = Vector3.New(0, 100, 0)
				var_67_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_4.position).x, (manager.ui.mainCamera.transform.position - var_67_4.position).y, (manager.ui.mainCamera.transform.position - var_67_4.position).z)
				var_67_4.localEulerAngles.z = 0
				var_67_4.localEulerAngles.x = 0
				var_67_4.localEulerAngles = var_67_4.localEulerAngles

				local var_67_7 = GameObjectTools.GetOrAddComponent(var_67_4.gameObject, typeof(DynamicBoneHelper))

				if var_67_7 then
					var_67_7:EnableDynamicBone(true)
				end
			end

			local var_67_8 = arg_64_1.actors_["2020_tpose"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos2020_tpose = var_67_8.localPosition

				local var_67_9 = GameObjectTools.GetOrAddComponent(var_67_8.gameObject, typeof(DynamicBoneHelper))

				if var_67_9 then
					var_67_9:EnableDynamicBone(false)
				end
			end

			local var_67_10 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_10 then
				var_67_8.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (arg_64_1.time_ - 0) / var_67_10)
				var_67_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_8.position).x, (manager.ui.mainCamera.transform.position - var_67_8.position).y, (manager.ui.mainCamera.transform.position - var_67_8.position).z)
				var_67_8.localEulerAngles.z = 0
				var_67_8.localEulerAngles.x = 0
				var_67_8.localEulerAngles = var_67_8.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_10 and arg_64_1.time_ < 0 + var_67_10 + arg_67_0 then
				var_67_8.localPosition = Vector3.New(0, 100, 0)
				var_67_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_8.position).x, (manager.ui.mainCamera.transform.position - var_67_8.position).y, (manager.ui.mainCamera.transform.position - var_67_8.position).z)
				var_67_8.localEulerAngles.z = 0
				var_67_8.localEulerAngles.x = 0
				var_67_8.localEulerAngles = var_67_8.localEulerAngles

				local var_67_11 = GameObjectTools.GetOrAddComponent(var_67_8.gameObject, typeof(DynamicBoneHelper))

				if var_67_11 then
					var_67_11:EnableDynamicBone(true)
				end
			end

			local var_67_12 = arg_64_1.actors_["1084ui_story"].transform

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1.var_.moveOldPos1084ui_story = var_67_12.localPosition
			end

			local var_67_13 = 0.001

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_13 then
				var_67_12.localPosition = Vector3.Lerp(arg_64_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_64_1.time_ - 0) / var_67_13)
				var_67_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_12.position).x, (manager.ui.mainCamera.transform.position - var_67_12.position).y, (manager.ui.mainCamera.transform.position - var_67_12.position).z)
				var_67_12.localEulerAngles.z = 0
				var_67_12.localEulerAngles.x = 0
				var_67_12.localEulerAngles = var_67_12.localEulerAngles
			end

			if arg_64_1.time_ >= 0 + var_67_13 and arg_64_1.time_ < 0 + var_67_13 + arg_67_0 then
				var_67_12.localPosition = Vector3.New(0, -0.97, -6)
				var_67_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_67_12.position).x, (manager.ui.mainCamera.transform.position - var_67_12.position).y, (manager.ui.mainCamera.transform.position - var_67_12.position).z)
				var_67_12.localEulerAngles.z = 0
				var_67_12.localEulerAngles.x = 0
				var_67_12.localEulerAngles = var_67_12.localEulerAngles
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action5_1")
			end

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 then
				arg_64_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_67_14 = 0
			local var_67_15 = 0.25

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_14 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, false)
				arg_64_1.callingController_:SetSelectedState("normal")

				local var_67_16 = arg_64_1:GetWordFromCfg(102111016)
				local var_67_17 = arg_64_1:FormatText(var_67_16.content)

				arg_64_1.text_.text = var_67_17

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_19 = 10 <= 0 and var_67_15 or var_67_15 * (utf8.len(var_67_17) / 10)

				if (10 <= 0 and var_67_15 or var_67_15 * (utf8.len(var_67_17) / 10)) > 0 and var_67_15 < var_67_19 then
					arg_64_1.talkMaxDuration = var_67_19

					if var_67_19 + var_67_14 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_19 + var_67_14
					end
				end

				arg_64_1.text_.text = var_67_17
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111016", "story_v_out_102111.awb") ~= 0 then
					local var_67_20 = manager.audio:GetVoiceLength("story_v_out_102111", "102111016", "story_v_out_102111.awb") / 1000

					if var_67_20 + var_67_14 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_20 + var_67_14
					end

					if var_67_16.prefab_name ~= "" and arg_64_1.actors_[var_67_16.prefab_name] ~= nil then
						local var_67_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_64_1.actors_[var_67_16.prefab_name].transform, "story_v_out_102111", "102111016", "story_v_out_102111.awb")

						arg_64_1:RecordAudio("102111016", var_67_21)
						arg_64_1:RecordAudio("102111016", var_67_21)
					else
						arg_64_1:AudioAction("play", "voice", "story_v_out_102111", "102111016", "story_v_out_102111.awb")
					end

					arg_64_1:RecordHistoryTalkVoice("story_v_out_102111", "102111016", "story_v_out_102111.awb")
				end

				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_22 = math.max(var_67_15, arg_64_1.talkMaxDuration)

			if var_67_14 <= arg_64_1.time_ and arg_64_1.time_ < var_67_14 + var_67_22 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_14) / var_67_22

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_14 + var_67_22 and arg_64_1.time_ < var_67_14 + var_67_22 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {
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
				actorName = "1084ui_story",
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
	Play102111017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 102111017
		arg_68_1.duration_ = 2.27

		local var_68_0 = {
			ja = 2.266,
			ko = 1.433,
			zh = 2.033,
			en = 1.6
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
				arg_68_0:Play102111018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story == nil then
				arg_68_1.var_.characterEffect1084ui_story = arg_68_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_71_0 = 0.1

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) then
				if arg_68_1.var_.characterEffect1084ui_story and not isNil(arg_68_1.actors_["1084ui_story"]) then
					arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_68_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_68_1.time_ - 0) / var_71_0)
				end
			end

			if arg_68_1.time_ >= 0 + var_71_0 and arg_68_1.time_ < 0 + var_71_0 + arg_71_0 and not isNil(arg_68_1.actors_["1084ui_story"]) and arg_68_1.var_.characterEffect1084ui_story then
				arg_68_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_68_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_71_1 = 0
			local var_71_2 = 0.2

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= var_71_1 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[41].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_3 = arg_68_1:GetWordFromCfg(102111017)
				local var_71_4 = arg_68_1:FormatText(var_71_3.content)

				arg_68_1.text_.text = var_71_4

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_6 = 8 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_4) / 8)

				if (8 <= 0 and var_71_2 or var_71_2 * (utf8.len(var_71_4) / 8)) > 0 and var_71_2 < var_71_6 then
					arg_68_1.talkMaxDuration = var_71_6

					if var_71_6 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_6 + var_71_1
					end
				end

				arg_68_1.text_.text = var_71_4
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111017", "story_v_out_102111.awb") ~= 0 then
					local var_71_7 = manager.audio:GetVoiceLength("story_v_out_102111", "102111017", "story_v_out_102111.awb") / 1000

					if var_71_7 + var_71_1 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_7 + var_71_1
					end

					if var_71_3.prefab_name ~= "" and arg_68_1.actors_[var_71_3.prefab_name] ~= nil then
						local var_71_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_68_1.actors_[var_71_3.prefab_name].transform, "story_v_out_102111", "102111017", "story_v_out_102111.awb")

						arg_68_1:RecordAudio("102111017", var_71_8)
						arg_68_1:RecordAudio("102111017", var_71_8)
					else
						arg_68_1:AudioAction("play", "voice", "story_v_out_102111", "102111017", "story_v_out_102111.awb")
					end

					arg_68_1:RecordHistoryTalkVoice("story_v_out_102111", "102111017", "story_v_out_102111.awb")
				end

				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_9 = math.max(var_71_2, arg_68_1.talkMaxDuration)

			if var_71_1 <= arg_68_1.time_ and arg_68_1.time_ < var_71_1 + var_71_9 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - var_71_1) / var_71_9

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= var_71_1 + var_71_9 and arg_68_1.time_ < var_71_1 + var_71_9 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play102111018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 102111018
		arg_72_1.duration_ = 2.8

		local var_72_0 = {
			ja = 2.8,
			ko = 1.866,
			zh = 1.7,
			en = 1.9
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
				arg_72_0:Play102111019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1084ui_story = arg_72_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).z)
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles = arg_72_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_72_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1084ui_story"].transform.position).z)
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1084ui_story"].transform.localEulerAngles = arg_72_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_75_1 = 0
			local var_75_2 = 0.2

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_1 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, true)
				arg_72_1.iconController_:SetSelectedState("hero")

				arg_72_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				arg_72_1.callingController_:SetSelectedState("normal")

				arg_72_1.keyicon_.color = Color.New(1, 1, 1)
				arg_72_1.icon_.color = Color.New(1, 1, 1)

				local var_75_3 = arg_72_1:GetWordFromCfg(102111018)
				local var_75_4 = arg_72_1:FormatText(var_75_3.content)

				arg_72_1.text_.text = var_75_4

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_6 = 8 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 8)

				if (8 <= 0 and var_75_2 or var_75_2 * (utf8.len(var_75_4) / 8)) > 0 and var_75_2 < var_75_6 then
					arg_72_1.talkMaxDuration = var_75_6

					if var_75_6 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_6 + var_75_1
					end
				end

				arg_72_1.text_.text = var_75_4
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111018", "story_v_out_102111.awb") ~= 0 then
					local var_75_7 = manager.audio:GetVoiceLength("story_v_out_102111", "102111018", "story_v_out_102111.awb") / 1000

					if var_75_7 + var_75_1 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_7 + var_75_1
					end

					if var_75_3.prefab_name ~= "" and arg_72_1.actors_[var_75_3.prefab_name] ~= nil then
						local var_75_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_72_1.actors_[var_75_3.prefab_name].transform, "story_v_out_102111", "102111018", "story_v_out_102111.awb")

						arg_72_1:RecordAudio("102111018", var_75_8)
						arg_72_1:RecordAudio("102111018", var_75_8)
					else
						arg_72_1:AudioAction("play", "voice", "story_v_out_102111", "102111018", "story_v_out_102111.awb")
					end

					arg_72_1:RecordHistoryTalkVoice("story_v_out_102111", "102111018", "story_v_out_102111.awb")
				end

				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_9 = math.max(var_75_2, arg_72_1.talkMaxDuration)

			if var_75_1 <= arg_72_1.time_ and arg_72_1.time_ < var_75_1 + var_75_9 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_1) / var_75_9

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_1 + var_75_9 and arg_72_1.time_ < var_75_1 + var_75_9 + arg_75_0 then
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
	Play102111019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 102111019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play102111020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:AudioAction("play", "effect", "se_story_2", "se_story_2_knives", "")
			end

			local var_79_1 = 0
			local var_79_2 = 0.15

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_1 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, false)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_3 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(102111019).content)

				arg_76_1.text_.text = var_79_3

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_5 = 6 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 6)

				if (6 <= 0 and var_79_2 or var_79_2 * (utf8.len(var_79_3) / 6)) > 0 and var_79_2 < var_79_5 then
					arg_76_1.talkMaxDuration = var_79_5

					if var_79_5 + var_79_1 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_5 + var_79_1
					end
				end

				arg_76_1.text_.text = var_79_3
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_6 = math.max(var_79_2, arg_76_1.talkMaxDuration)

			if var_79_1 <= arg_76_1.time_ and arg_76_1.time_ < var_79_1 + var_79_6 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_1) / var_79_6

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_1 + var_79_6 and arg_76_1.time_ < var_79_1 + var_79_6 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play102111020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 102111020
		arg_80_1.duration_ = 2.47

		local var_80_0 = {
			ja = 2.233,
			ko = 2.266,
			zh = 2.166,
			en = 2.466
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
				arg_80_0:Play102111021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story == nil then
				arg_80_1.var_.characterEffect1084ui_story = arg_80_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_0 = 0.1

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) then
				if arg_80_1.var_.characterEffect1084ui_story and not isNil(arg_80_1.actors_["1084ui_story"]) then
					arg_80_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 and not isNil(arg_80_1.actors_["1084ui_story"]) and arg_80_1.var_.characterEffect1084ui_story then
				arg_80_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_83_2 = arg_80_1.actors_["1084ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1084ui_story = var_83_2.localPosition
			end

			local var_83_3 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_3 then
				var_83_2.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_80_1.time_ - 0) / var_83_3)
				var_83_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_2.position).x, (manager.ui.mainCamera.transform.position - var_83_2.position).y, (manager.ui.mainCamera.transform.position - var_83_2.position).z)
				var_83_2.localEulerAngles.z = 0
				var_83_2.localEulerAngles.x = 0
				var_83_2.localEulerAngles = var_83_2.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_3 and arg_80_1.time_ < 0 + var_83_3 + arg_83_0 then
				var_83_2.localPosition = Vector3.New(0, -0.97, -6)
				var_83_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_2.position).x, (manager.ui.mainCamera.transform.position - var_83_2.position).y, (manager.ui.mainCamera.transform.position - var_83_2.position).z)
				var_83_2.localEulerAngles.z = 0
				var_83_2.localEulerAngles.x = 0
				var_83_2.localEulerAngles = var_83_2.localEulerAngles
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action4_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			local var_83_4 = 0
			local var_83_5 = 0.25

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_4 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_6 = arg_80_1:GetWordFromCfg(102111020)
				local var_83_7 = arg_80_1:FormatText(var_83_6.content)

				arg_80_1.text_.text = var_83_7

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_9 = 10 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 10)

				if (10 <= 0 and var_83_5 or var_83_5 * (utf8.len(var_83_7) / 10)) > 0 and var_83_5 < var_83_9 then
					arg_80_1.talkMaxDuration = var_83_9

					if var_83_9 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_9 + var_83_4
					end
				end

				arg_80_1.text_.text = var_83_7
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111020", "story_v_out_102111.awb") ~= 0 then
					local var_83_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111020", "story_v_out_102111.awb") / 1000

					if var_83_10 + var_83_4 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_10 + var_83_4
					end

					if var_83_6.prefab_name ~= "" and arg_80_1.actors_[var_83_6.prefab_name] ~= nil then
						local var_83_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_80_1.actors_[var_83_6.prefab_name].transform, "story_v_out_102111", "102111020", "story_v_out_102111.awb")

						arg_80_1:RecordAudio("102111020", var_83_11)
						arg_80_1:RecordAudio("102111020", var_83_11)
					else
						arg_80_1:AudioAction("play", "voice", "story_v_out_102111", "102111020", "story_v_out_102111.awb")
					end

					arg_80_1:RecordHistoryTalkVoice("story_v_out_102111", "102111020", "story_v_out_102111.awb")
				end

				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_12 = math.max(var_83_5, arg_80_1.talkMaxDuration)

			if var_83_4 <= arg_80_1.time_ and arg_80_1.time_ < var_83_4 + var_83_12 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_4) / var_83_12

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_4 + var_83_12 and arg_80_1.time_ < var_83_4 + var_83_12 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
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

		arg_80_1:InitPlayNodeList()
	end,
	Play102111021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 102111021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play102111022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) and arg_84_1.var_.characterEffect1084ui_story == nil then
				arg_84_1.var_.characterEffect1084ui_story = arg_84_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_0 = 0.1

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) then
				if arg_84_1.var_.characterEffect1084ui_story and not isNil(arg_84_1.actors_["1084ui_story"]) then
					arg_84_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_0)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_0 and arg_84_1.time_ < 0 + var_87_0 + arg_87_0 and not isNil(arg_84_1.actors_["1084ui_story"]) and arg_84_1.var_.characterEffect1084ui_story then
				arg_84_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_87_1 = arg_84_1.actors_["1084ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1084ui_story = var_87_1.localPosition
			end

			local var_87_2 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_2 then
				var_87_1.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_2)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_2 and arg_84_1.time_ < 0 + var_87_2 + arg_87_0 then
				var_87_1.localPosition = Vector3.New(0, 100, 0)
				var_87_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_1.position).x, (manager.ui.mainCamera.transform.position - var_87_1.position).y, (manager.ui.mainCamera.transform.position - var_87_1.position).z)
				var_87_1.localEulerAngles.z = 0
				var_87_1.localEulerAngles.x = 0
				var_87_1.localEulerAngles = var_87_1.localEulerAngles
			end

			local var_87_3 = 0
			local var_87_4 = 0.8

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_3 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, false)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_5 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(102111021).content)

				arg_84_1.text_.text = var_87_5

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_7 = 32 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 32)

				if (32 <= 0 and var_87_4 or var_87_4 * (utf8.len(var_87_5) / 32)) > 0 and var_87_4 < var_87_7 then
					arg_84_1.talkMaxDuration = var_87_7

					if var_87_7 + var_87_3 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_7 + var_87_3
					end
				end

				arg_84_1.text_.text = var_87_5
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_8 = math.max(var_87_4, arg_84_1.talkMaxDuration)

			if var_87_3 <= arg_84_1.time_ and arg_84_1.time_ < var_87_3 + var_87_8 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_3) / var_87_8

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_3 + var_87_8 and arg_84_1.time_ < var_87_3 + var_87_8 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
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

		arg_84_1:InitPlayNodeList()
	end,
	Play102111022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 102111022
		arg_88_1.duration_ = 10.1

		local var_88_0 = {
			ja = 10.1,
			ko = 6.933,
			zh = 8.666,
			en = 9
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
				arg_88_0:Play102111023(arg_88_1)
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

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_91_2 = arg_88_1.actors_["1019ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1019ui_story = var_91_2.localPosition
			end

			local var_91_3 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_3 then
				var_91_2.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_88_1.time_ - 0) / var_91_3)
				var_91_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_2.position).x, (manager.ui.mainCamera.transform.position - var_91_2.position).y, (manager.ui.mainCamera.transform.position - var_91_2.position).z)
				var_91_2.localEulerAngles.z = 0
				var_91_2.localEulerAngles.x = 0
				var_91_2.localEulerAngles = var_91_2.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_3 and arg_88_1.time_ < 0 + var_91_3 + arg_91_0 then
				var_91_2.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_91_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_2.position).x, (manager.ui.mainCamera.transform.position - var_91_2.position).y, (manager.ui.mainCamera.transform.position - var_91_2.position).z)
				var_91_2.localEulerAngles.z = 0
				var_91_2.localEulerAngles.x = 0
				var_91_2.localEulerAngles = var_91_2.localEulerAngles
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_91_4 = 0
			local var_91_5 = 0.9

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_4 + arg_91_0 then
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

				local var_91_6 = arg_88_1:GetWordFromCfg(102111022)
				local var_91_7 = arg_88_1:FormatText(var_91_6.content)

				arg_88_1.text_.text = var_91_7

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_9 = 36 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 36)

				if (36 <= 0 and var_91_5 or var_91_5 * (utf8.len(var_91_7) / 36)) > 0 and var_91_5 < var_91_9 then
					arg_88_1.talkMaxDuration = var_91_9

					if var_91_9 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_9 + var_91_4
					end
				end

				arg_88_1.text_.text = var_91_7
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111022", "story_v_out_102111.awb") ~= 0 then
					local var_91_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111022", "story_v_out_102111.awb") / 1000

					if var_91_10 + var_91_4 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_10 + var_91_4
					end

					if var_91_6.prefab_name ~= "" and arg_88_1.actors_[var_91_6.prefab_name] ~= nil then
						local var_91_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_88_1.actors_[var_91_6.prefab_name].transform, "story_v_out_102111", "102111022", "story_v_out_102111.awb")

						arg_88_1:RecordAudio("102111022", var_91_11)
						arg_88_1:RecordAudio("102111022", var_91_11)
					else
						arg_88_1:AudioAction("play", "voice", "story_v_out_102111", "102111022", "story_v_out_102111.awb")
					end

					arg_88_1:RecordHistoryTalkVoice("story_v_out_102111", "102111022", "story_v_out_102111.awb")
				end

				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_12 = math.max(var_91_5, arg_88_1.talkMaxDuration)

			if var_91_4 <= arg_88_1.time_ and arg_88_1.time_ < var_91_4 + var_91_12 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_4) / var_91_12

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_4 + var_91_12 and arg_88_1.time_ < var_91_4 + var_91_12 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
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
	Play102111023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 102111023
		arg_92_1.duration_ = 6.73

		local var_92_0 = {
			ja = 6.733,
			ko = 5.433,
			zh = 5.9,
			en = 4.533
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
				arg_92_0:Play102111024(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["3008ui_story"]) and arg_92_1.var_.characterEffect3008ui_story == nil then
				arg_92_1.var_.characterEffect3008ui_story = arg_92_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.1

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["3008ui_story"]) then
				if arg_92_1.var_.characterEffect3008ui_story and not isNil(arg_92_1.actors_["3008ui_story"]) then
					arg_92_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["3008ui_story"]) and arg_92_1.var_.characterEffect3008ui_story then
				arg_92_1.var_.characterEffect3008ui_story.fillFlat = false
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

			local var_95_5 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_5 then
				var_95_4.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_92_1.time_ - 0) / var_95_5)
				var_95_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_4.position).x, (manager.ui.mainCamera.transform.position - var_95_4.position).y, (manager.ui.mainCamera.transform.position - var_95_4.position).z)
				var_95_4.localEulerAngles.z = 0
				var_95_4.localEulerAngles.x = 0
				var_95_4.localEulerAngles = var_95_4.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_5 and arg_92_1.time_ < 0 + var_95_5 + arg_95_0 then
				var_95_4.localPosition = Vector3.New(0, 100, 0)
				var_95_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_4.position).x, (manager.ui.mainCamera.transform.position - var_95_4.position).y, (manager.ui.mainCamera.transform.position - var_95_4.position).z)
				var_95_4.localEulerAngles.z = 0
				var_95_4.localEulerAngles.x = 0
				var_95_4.localEulerAngles = var_95_4.localEulerAngles
			end

			local var_95_6 = arg_92_1.actors_["3008ui_story"].transform

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos3008ui_story = var_95_6.localPosition
			end

			local var_95_7 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_7 then
				var_95_6.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos3008ui_story, Vector3.New(-0.7, -1.51, -4.3), (arg_92_1.time_ - 0) / var_95_7)
				var_95_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_6.position).x, (manager.ui.mainCamera.transform.position - var_95_6.position).y, (manager.ui.mainCamera.transform.position - var_95_6.position).z)
				var_95_6.localEulerAngles.z = 0
				var_95_6.localEulerAngles.x = 0
				var_95_6.localEulerAngles = var_95_6.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_7 and arg_92_1.time_ < 0 + var_95_7 + arg_95_0 then
				var_95_6.localPosition = Vector3.New(-0.7, -1.51, -4.3)
				var_95_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_95_6.position).x, (manager.ui.mainCamera.transform.position - var_95_6.position).y, (manager.ui.mainCamera.transform.position - var_95_6.position).z)
				var_95_6.localEulerAngles.z = 0
				var_95_6.localEulerAngles.x = 0
				var_95_6.localEulerAngles = var_95_6.localEulerAngles
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_95_8 = 0
			local var_95_9 = 0.625

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_8 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_10 = arg_92_1:GetWordFromCfg(102111023)
				local var_95_11 = arg_92_1:FormatText(var_95_10.content)

				arg_92_1.text_.text = var_95_11

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_13 = 24 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 24)

				if (24 <= 0 and var_95_9 or var_95_9 * (utf8.len(var_95_11) / 24)) > 0 and var_95_9 < var_95_13 then
					arg_92_1.talkMaxDuration = var_95_13

					if var_95_13 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_13 + var_95_8
					end
				end

				arg_92_1.text_.text = var_95_11
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111023", "story_v_out_102111.awb") ~= 0 then
					local var_95_14 = manager.audio:GetVoiceLength("story_v_out_102111", "102111023", "story_v_out_102111.awb") / 1000

					if var_95_14 + var_95_8 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_14 + var_95_8
					end

					if var_95_10.prefab_name ~= "" and arg_92_1.actors_[var_95_10.prefab_name] ~= nil then
						local var_95_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_92_1.actors_[var_95_10.prefab_name].transform, "story_v_out_102111", "102111023", "story_v_out_102111.awb")

						arg_92_1:RecordAudio("102111023", var_95_15)
						arg_92_1:RecordAudio("102111023", var_95_15)
					else
						arg_92_1:AudioAction("play", "voice", "story_v_out_102111", "102111023", "story_v_out_102111.awb")
					end

					arg_92_1:RecordHistoryTalkVoice("story_v_out_102111", "102111023", "story_v_out_102111.awb")
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

		arg_92_1:InitPlayNodeList()
	end,
	Play102111024 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 102111024
		arg_96_1.duration_ = 6.57

		local var_96_0 = {
			ja = 6.566,
			ko = 4.3,
			zh = 5.433,
			en = 5.066
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
				arg_96_0:Play102111025(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if arg_96_1.actors_["3009ui_story"] == nil and not isNil((Asset.Load("Char/" .. "3009ui_story"))) then
				local var_99_0 = Object.Instantiate(Asset.Load("Char/" .. "3009ui_story"), arg_96_1.stage_.transform)

				var_99_0.name = "3009ui_story"
				var_99_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_96_1.actors_["3009ui_story"] = var_99_0

				local var_99_1 = var_99_0:GetComponentInChildren(typeof(CharacterEffect))

				var_99_1.enabled = true

				local var_99_2 = GameObjectTools.GetOrAddComponent(var_99_0, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(false)
				end

				arg_96_1:ShowWeapon(var_99_1.transform, false)

				arg_96_1.var_["3009ui_story" .. "Animator"] = var_99_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_96_1.var_["3009ui_story" .. "Animator"].applyRootMotion = true
				arg_96_1.var_["3009ui_story" .. "LipSync"] = var_99_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_99_3 = arg_96_1.actors_["3009ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect3009ui_story == nil then
				arg_96_1.var_.characterEffect3009ui_story = var_99_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 and not isNil(var_99_3) then
				if arg_96_1.var_.characterEffect3009ui_story and not isNil(var_99_3) then
					arg_96_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect3009ui_story then
				arg_96_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_99_6 = arg_96_1.actors_["3008ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect3008ui_story == nil then
				arg_96_1.var_.characterEffect3008ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_7 = 0.1

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 and not isNil(var_99_6) then
				if arg_96_1.var_.characterEffect3008ui_story and not isNil(var_99_6) then
					arg_96_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_96_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_7)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect3008ui_story then
				arg_96_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_96_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			local var_99_8 = arg_96_1.actors_["3009ui_story"].transform

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos3009ui_story = var_99_8.localPosition

				arg_96_1:ShowWeapon(arg_96_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_99_9 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_9 then
				var_99_8.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (arg_96_1.time_ - 0) / var_99_9)
				var_99_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_8.position).x, (manager.ui.mainCamera.transform.position - var_99_8.position).y, (manager.ui.mainCamera.transform.position - var_99_8.position).z)
				var_99_8.localEulerAngles.z = 0
				var_99_8.localEulerAngles.x = 0
				var_99_8.localEulerAngles = var_99_8.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_9 and arg_96_1.time_ < 0 + var_99_9 + arg_99_0 then
				var_99_8.localPosition = Vector3.New(0.7, -1.75, -4.8)
				var_99_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_99_8.position).x, (manager.ui.mainCamera.transform.position - var_99_8.position).y, (manager.ui.mainCamera.transform.position - var_99_8.position).z)
				var_99_8.localEulerAngles.z = 0
				var_99_8.localEulerAngles.x = 0
				var_99_8.localEulerAngles = var_99_8.localEulerAngles
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/story3009action/3009action2_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_99_10 = 0
			local var_99_11 = 0.675

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_10 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_12 = arg_96_1:GetWordFromCfg(102111024)
				local var_99_13 = arg_96_1:FormatText(var_99_12.content)

				arg_96_1.text_.text = var_99_13

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_15 = 27 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 27)

				if (27 <= 0 and var_99_11 or var_99_11 * (utf8.len(var_99_13) / 27)) > 0 and var_99_11 < var_99_15 then
					arg_96_1.talkMaxDuration = var_99_15

					if var_99_15 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_15 + var_99_10
					end
				end

				arg_96_1.text_.text = var_99_13
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111024", "story_v_out_102111.awb") ~= 0 then
					local var_99_16 = manager.audio:GetVoiceLength("story_v_out_102111", "102111024", "story_v_out_102111.awb") / 1000

					if var_99_16 + var_99_10 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_16 + var_99_10
					end

					if var_99_12.prefab_name ~= "" and arg_96_1.actors_[var_99_12.prefab_name] ~= nil then
						local var_99_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_96_1.actors_[var_99_12.prefab_name].transform, "story_v_out_102111", "102111024", "story_v_out_102111.awb")

						arg_96_1:RecordAudio("102111024", var_99_17)
						arg_96_1:RecordAudio("102111024", var_99_17)
					else
						arg_96_1:AudioAction("play", "voice", "story_v_out_102111", "102111024", "story_v_out_102111.awb")
					end

					arg_96_1:RecordHistoryTalkVoice("story_v_out_102111", "102111024", "story_v_out_102111.awb")
				end

				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_18 = math.max(var_99_11, arg_96_1.talkMaxDuration)

			if var_99_10 <= arg_96_1.time_ and arg_96_1.time_ < var_99_10 + var_99_18 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_10) / var_99_18

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_10 + var_99_18 and arg_96_1.time_ < var_99_10 + var_99_18 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play102111025 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 102111025
		arg_100_1.duration_ = 6.47

		local var_100_0 = {
			ja = 6.2,
			ko = 5.766,
			zh = 6.466,
			en = 5.866
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
				arg_100_0:Play102111026(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["3008ui_story"]) and arg_100_1.var_.characterEffect3008ui_story == nil then
				arg_100_1.var_.characterEffect3008ui_story = arg_100_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["3008ui_story"]) then
				if arg_100_1.var_.characterEffect3008ui_story and not isNil(arg_100_1.actors_["3008ui_story"]) then
					arg_100_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["3008ui_story"]) and arg_100_1.var_.characterEffect3008ui_story then
				arg_100_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_103_2 = arg_100_1.actors_["3009ui_story"]

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect3009ui_story == nil then
				arg_100_1.var_.characterEffect3009ui_story = var_103_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_3 = 0.1

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_3 and not isNil(var_103_2) then
				if arg_100_1.var_.characterEffect3009ui_story and not isNil(var_103_2) then
					arg_100_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_100_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_3)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_3 and arg_100_1.time_ < 0 + var_103_3 + arg_103_0 and not isNil(var_103_2) and arg_100_1.var_.characterEffect3009ui_story then
				arg_100_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_100_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 then
				arg_100_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action7_2")
			end

			local var_103_4 = 0
			local var_103_5 = 0.825

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_4 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, false)
				arg_100_1.callingController_:SetSelectedState("normal")

				local var_103_6 = arg_100_1:GetWordFromCfg(102111025)
				local var_103_7 = arg_100_1:FormatText(var_103_6.content)

				arg_100_1.text_.text = var_103_7

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_9 = 33 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 33)

				if (33 <= 0 and var_103_5 or var_103_5 * (utf8.len(var_103_7) / 33)) > 0 and var_103_5 < var_103_9 then
					arg_100_1.talkMaxDuration = var_103_9

					if var_103_9 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_9 + var_103_4
					end
				end

				arg_100_1.text_.text = var_103_7
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111025", "story_v_out_102111.awb") ~= 0 then
					local var_103_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111025", "story_v_out_102111.awb") / 1000

					if var_103_10 + var_103_4 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_10 + var_103_4
					end

					if var_103_6.prefab_name ~= "" and arg_100_1.actors_[var_103_6.prefab_name] ~= nil then
						local var_103_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_100_1.actors_[var_103_6.prefab_name].transform, "story_v_out_102111", "102111025", "story_v_out_102111.awb")

						arg_100_1:RecordAudio("102111025", var_103_11)
						arg_100_1:RecordAudio("102111025", var_103_11)
					else
						arg_100_1:AudioAction("play", "voice", "story_v_out_102111", "102111025", "story_v_out_102111.awb")
					end

					arg_100_1:RecordHistoryTalkVoice("story_v_out_102111", "102111025", "story_v_out_102111.awb")
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
	Play102111026 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 102111026
		arg_104_1.duration_ = 4.53

		local var_104_0 = {
			ja = 4.4,
			ko = 4.166,
			zh = 4.533,
			en = 3.6
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
				arg_104_0:Play102111027(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(arg_104_1.actors_["3009ui_story"]) and arg_104_1.var_.characterEffect3009ui_story == nil then
				arg_104_1.var_.characterEffect3009ui_story = arg_104_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_0 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_0 and not isNil(arg_104_1.actors_["3009ui_story"]) then
				if arg_104_1.var_.characterEffect3009ui_story and not isNil(arg_104_1.actors_["3009ui_story"]) then
					arg_104_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_104_1.time_ >= 0 + var_107_0 and arg_104_1.time_ < 0 + var_107_0 + arg_107_0 and not isNil(arg_104_1.actors_["3009ui_story"]) and arg_104_1.var_.characterEffect3009ui_story then
				arg_104_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_107_2 = arg_104_1.actors_["3008ui_story"]

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect3008ui_story == nil then
				arg_104_1.var_.characterEffect3008ui_story = var_107_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_107_3 = 0.1

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_3 and not isNil(var_107_2) then
				if arg_104_1.var_.characterEffect3008ui_story and not isNil(var_107_2) then
					arg_104_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_104_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_104_1.time_ - 0) / var_107_3)
				end
			end

			if arg_104_1.time_ >= 0 + var_107_3 and arg_104_1.time_ < 0 + var_107_3 + arg_107_0 and not isNil(var_107_2) and arg_104_1.var_.characterEffect3008ui_story then
				arg_104_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_104_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_107_4 = 0
			local var_107_5 = 0.5

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= var_107_4 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, false)
				arg_104_1.callingController_:SetSelectedState("normal")

				local var_107_6 = arg_104_1:GetWordFromCfg(102111026)
				local var_107_7 = arg_104_1:FormatText(var_107_6.content)

				arg_104_1.text_.text = var_107_7

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_9 = 20 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 20)

				if (20 <= 0 and var_107_5 or var_107_5 * (utf8.len(var_107_7) / 20)) > 0 and var_107_5 < var_107_9 then
					arg_104_1.talkMaxDuration = var_107_9

					if var_107_9 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_9 + var_107_4
					end
				end

				arg_104_1.text_.text = var_107_7
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111026", "story_v_out_102111.awb") ~= 0 then
					local var_107_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111026", "story_v_out_102111.awb") / 1000

					if var_107_10 + var_107_4 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_10 + var_107_4
					end

					if var_107_6.prefab_name ~= "" and arg_104_1.actors_[var_107_6.prefab_name] ~= nil then
						local var_107_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_104_1.actors_[var_107_6.prefab_name].transform, "story_v_out_102111", "102111026", "story_v_out_102111.awb")

						arg_104_1:RecordAudio("102111026", var_107_11)
						arg_104_1:RecordAudio("102111026", var_107_11)
					else
						arg_104_1:AudioAction("play", "voice", "story_v_out_102111", "102111026", "story_v_out_102111.awb")
					end

					arg_104_1:RecordHistoryTalkVoice("story_v_out_102111", "102111026", "story_v_out_102111.awb")
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
	Play102111027 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 102111027
		arg_108_1.duration_ = 4.57

		local var_108_0 = {
			ja = 4.566,
			ko = 3.7,
			zh = 3.9,
			en = 3.3
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
				arg_108_0:Play102111028(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(arg_108_1.actors_["3008ui_story"]) and arg_108_1.var_.characterEffect3008ui_story == nil then
				arg_108_1.var_.characterEffect3008ui_story = arg_108_1.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_0 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_0 and not isNil(arg_108_1.actors_["3008ui_story"]) then
				if arg_108_1.var_.characterEffect3008ui_story and not isNil(arg_108_1.actors_["3008ui_story"]) then
					arg_108_1.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_0 and arg_108_1.time_ < 0 + var_111_0 + arg_111_0 and not isNil(arg_108_1.actors_["3008ui_story"]) and arg_108_1.var_.characterEffect3008ui_story then
				arg_108_1.var_.characterEffect3008ui_story.fillFlat = false
			end

			local var_111_2 = arg_108_1.actors_["3009ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect3009ui_story == nil then
				arg_108_1.var_.characterEffect3009ui_story = var_111_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_3 = 0.1

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_3 and not isNil(var_111_2) then
				if arg_108_1.var_.characterEffect3009ui_story and not isNil(var_111_2) then
					arg_108_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_108_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_108_1.time_ - 0) / var_111_3)
				end
			end

			if arg_108_1.time_ >= 0 + var_111_3 and arg_108_1.time_ < 0 + var_111_3 + arg_111_0 and not isNil(var_111_2) and arg_108_1.var_.characterEffect3009ui_story then
				arg_108_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_108_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/story3008/story3008action/3008action2_1")
			end

			local var_111_4 = 0
			local var_111_5 = 0.3

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_4 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_6 = arg_108_1:GetWordFromCfg(102111027)
				local var_111_7 = arg_108_1:FormatText(var_111_6.content)

				arg_108_1.text_.text = var_111_7

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_9 = 12 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 12)

				if (12 <= 0 and var_111_5 or var_111_5 * (utf8.len(var_111_7) / 12)) > 0 and var_111_5 < var_111_9 then
					arg_108_1.talkMaxDuration = var_111_9

					if var_111_9 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_9 + var_111_4
					end
				end

				arg_108_1.text_.text = var_111_7
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111027", "story_v_out_102111.awb") ~= 0 then
					local var_111_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111027", "story_v_out_102111.awb") / 1000

					if var_111_10 + var_111_4 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_4
					end

					if var_111_6.prefab_name ~= "" and arg_108_1.actors_[var_111_6.prefab_name] ~= nil then
						local var_111_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_108_1.actors_[var_111_6.prefab_name].transform, "story_v_out_102111", "102111027", "story_v_out_102111.awb")

						arg_108_1:RecordAudio("102111027", var_111_11)
						arg_108_1:RecordAudio("102111027", var_111_11)
					else
						arg_108_1:AudioAction("play", "voice", "story_v_out_102111", "102111027", "story_v_out_102111.awb")
					end

					arg_108_1:RecordHistoryTalkVoice("story_v_out_102111", "102111027", "story_v_out_102111.awb")
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
	Play102111028 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 102111028
		arg_112_1.duration_ = 6.07

		local var_112_0 = {
			ja = 6.066,
			ko = 3.533,
			zh = 4.1,
			en = 3.433
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
				arg_112_0:Play102111029(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(arg_112_1.actors_["3009ui_story"]) and arg_112_1.var_.characterEffect3009ui_story == nil then
				arg_112_1.var_.characterEffect3009ui_story = arg_112_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_0 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_0 and not isNil(arg_112_1.actors_["3009ui_story"]) then
				if arg_112_1.var_.characterEffect3009ui_story and not isNil(arg_112_1.actors_["3009ui_story"]) then
					arg_112_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_0 and arg_112_1.time_ < 0 + var_115_0 + arg_115_0 and not isNil(arg_112_1.actors_["3009ui_story"]) and arg_112_1.var_.characterEffect3009ui_story then
				arg_112_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_115_2 = arg_112_1.actors_["3008ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect3008ui_story == nil then
				arg_112_1.var_.characterEffect3008ui_story = var_115_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_3 = 0.1

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_3 and not isNil(var_115_2) then
				if arg_112_1.var_.characterEffect3008ui_story and not isNil(var_115_2) then
					arg_112_1.var_.characterEffect3008ui_story.fillFlat = true
					arg_112_1.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_3)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_3 and arg_112_1.time_ < 0 + var_115_3 + arg_115_0 and not isNil(var_115_2) and arg_112_1.var_.characterEffect3008ui_story then
				arg_112_1.var_.characterEffect3008ui_story.fillFlat = true
				arg_112_1.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_115_4 = 0
			local var_115_5 = 0.4

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_4 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_6 = arg_112_1:GetWordFromCfg(102111028)
				local var_115_7 = arg_112_1:FormatText(var_115_6.content)

				arg_112_1.text_.text = var_115_7

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_9 = 16 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 16)

				if (16 <= 0 and var_115_5 or var_115_5 * (utf8.len(var_115_7) / 16)) > 0 and var_115_5 < var_115_9 then
					arg_112_1.talkMaxDuration = var_115_9

					if var_115_9 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_9 + var_115_4
					end
				end

				arg_112_1.text_.text = var_115_7
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111028", "story_v_out_102111.awb") ~= 0 then
					local var_115_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111028", "story_v_out_102111.awb") / 1000

					if var_115_10 + var_115_4 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_10 + var_115_4
					end

					if var_115_6.prefab_name ~= "" and arg_112_1.actors_[var_115_6.prefab_name] ~= nil then
						local var_115_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_112_1.actors_[var_115_6.prefab_name].transform, "story_v_out_102111", "102111028", "story_v_out_102111.awb")

						arg_112_1:RecordAudio("102111028", var_115_11)
						arg_112_1:RecordAudio("102111028", var_115_11)
					else
						arg_112_1:AudioAction("play", "voice", "story_v_out_102111", "102111028", "story_v_out_102111.awb")
					end

					arg_112_1:RecordHistoryTalkVoice("story_v_out_102111", "102111028", "story_v_out_102111.awb")
				end

				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_12 = math.max(var_115_5, arg_112_1.talkMaxDuration)

			if var_115_4 <= arg_112_1.time_ and arg_112_1.time_ < var_115_4 + var_115_12 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_4) / var_115_12

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_4 + var_115_12 and arg_112_1.time_ < var_115_4 + var_115_12 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {}

		arg_112_1:InitPlayNodeList()
	end,
	Play102111029 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 102111029
		arg_116_1.duration_ = 5.53

		local var_116_0 = {
			ja = 5.533,
			ko = 4.233,
			zh = 4.533,
			en = 3.6
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
				arg_116_0:Play102111030(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(arg_116_1.actors_["1019ui_story"]) and arg_116_1.var_.characterEffect1019ui_story == nil then
				arg_116_1.var_.characterEffect1019ui_story = arg_116_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_0 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_0 and not isNil(arg_116_1.actors_["1019ui_story"]) then
				if arg_116_1.var_.characterEffect1019ui_story and not isNil(arg_116_1.actors_["1019ui_story"]) then
					arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_116_1.time_ >= 0 + var_119_0 and arg_116_1.time_ < 0 + var_119_0 + arg_119_0 and not isNil(arg_116_1.actors_["1019ui_story"]) and arg_116_1.var_.characterEffect1019ui_story then
				arg_116_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_119_2 = arg_116_1.actors_["3009ui_story"]

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect3009ui_story == nil then
				arg_116_1.var_.characterEffect3009ui_story = var_119_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_119_3 = 0.1

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_3 and not isNil(var_119_2) then
				if arg_116_1.var_.characterEffect3009ui_story and not isNil(var_119_2) then
					arg_116_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_116_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_116_1.time_ - 0) / var_119_3)
				end
			end

			if arg_116_1.time_ >= 0 + var_119_3 and arg_116_1.time_ < 0 + var_119_3 + arg_119_0 and not isNil(var_119_2) and arg_116_1.var_.characterEffect3009ui_story then
				arg_116_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_116_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_119_4 = arg_116_1.actors_["3009ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos3009ui_story = var_119_4.localPosition
			end

			local var_119_5 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_5 then
				var_119_4.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_5)
				var_119_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_4.position).x, (manager.ui.mainCamera.transform.position - var_119_4.position).y, (manager.ui.mainCamera.transform.position - var_119_4.position).z)
				var_119_4.localEulerAngles.z = 0
				var_119_4.localEulerAngles.x = 0
				var_119_4.localEulerAngles = var_119_4.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_5 and arg_116_1.time_ < 0 + var_119_5 + arg_119_0 then
				var_119_4.localPosition = Vector3.New(0, 100, 0)
				var_119_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_4.position).x, (manager.ui.mainCamera.transform.position - var_119_4.position).y, (manager.ui.mainCamera.transform.position - var_119_4.position).z)
				var_119_4.localEulerAngles.z = 0
				var_119_4.localEulerAngles.x = 0
				var_119_4.localEulerAngles = var_119_4.localEulerAngles
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action5_1")
			end

			local var_119_6 = arg_116_1.actors_["1019ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1019ui_story = var_119_6.localPosition
			end

			local var_119_7 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_7 then
				var_119_6.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_116_1.time_ - 0) / var_119_7)
				var_119_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_6.position).x, (manager.ui.mainCamera.transform.position - var_119_6.position).y, (manager.ui.mainCamera.transform.position - var_119_6.position).z)
				var_119_6.localEulerAngles.z = 0
				var_119_6.localEulerAngles.x = 0
				var_119_6.localEulerAngles = var_119_6.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_7 and arg_116_1.time_ < 0 + var_119_7 + arg_119_0 then
				var_119_6.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_119_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_6.position).x, (manager.ui.mainCamera.transform.position - var_119_6.position).y, (manager.ui.mainCamera.transform.position - var_119_6.position).z)
				var_119_6.localEulerAngles.z = 0
				var_119_6.localEulerAngles.x = 0
				var_119_6.localEulerAngles = var_119_6.localEulerAngles
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_119_8 = arg_116_1.actors_["3008ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos3008ui_story = var_119_8.localPosition
			end

			local var_119_9 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_9 then
				var_119_8.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_9)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_9 and arg_116_1.time_ < 0 + var_119_9 + arg_119_0 then
				var_119_8.localPosition = Vector3.New(0, 100, 0)
				var_119_8.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_8.position).x, (manager.ui.mainCamera.transform.position - var_119_8.position).y, (manager.ui.mainCamera.transform.position - var_119_8.position).z)
				var_119_8.localEulerAngles.z = 0
				var_119_8.localEulerAngles.x = 0
				var_119_8.localEulerAngles = var_119_8.localEulerAngles
			end

			local var_119_10 = 0
			local var_119_11 = 0.55

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_10 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0
				arg_116_1.dialogCg_.alpha = 1

				arg_116_1.dialog_:SetActive(true)
				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_12 = arg_116_1:GetWordFromCfg(102111029)
				local var_119_13 = arg_116_1:FormatText(var_119_12.content)

				arg_116_1.text_.text = var_119_13

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_15 = 22 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 22)

				if (22 <= 0 and var_119_11 or var_119_11 * (utf8.len(var_119_13) / 22)) > 0 and var_119_11 < var_119_15 then
					arg_116_1.talkMaxDuration = var_119_15

					if var_119_15 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_15 + var_119_10
					end
				end

				arg_116_1.text_.text = var_119_13
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111029", "story_v_out_102111.awb") ~= 0 then
					local var_119_16 = manager.audio:GetVoiceLength("story_v_out_102111", "102111029", "story_v_out_102111.awb") / 1000

					if var_119_16 + var_119_10 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_16 + var_119_10
					end

					if var_119_12.prefab_name ~= "" and arg_116_1.actors_[var_119_12.prefab_name] ~= nil then
						local var_119_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_116_1.actors_[var_119_12.prefab_name].transform, "story_v_out_102111", "102111029", "story_v_out_102111.awb")

						arg_116_1:RecordAudio("102111029", var_119_17)
						arg_116_1:RecordAudio("102111029", var_119_17)
					else
						arg_116_1:AudioAction("play", "voice", "story_v_out_102111", "102111029", "story_v_out_102111.awb")
					end

					arg_116_1:RecordHistoryTalkVoice("story_v_out_102111", "102111029", "story_v_out_102111.awb")
				end

				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_18 = math.max(var_119_11, arg_116_1.talkMaxDuration)

			if var_119_10 <= arg_116_1.time_ and arg_116_1.time_ < var_119_10 + var_119_18 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_10) / var_119_18

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_10 + var_119_18 and arg_116_1.time_ < var_119_10 + var_119_18 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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
				actorName = "3008ui_story",
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
	Play102111030 = function(arg_120_0, arg_120_1)
		arg_120_1.time_ = 0
		arg_120_1.frameCnt_ = 0
		arg_120_1.state_ = "playing"
		arg_120_1.curTalkId_ = 102111030
		arg_120_1.duration_ = 3.87

		local var_120_0 = {
			ja = 3.866,
			ko = 2.733,
			zh = 3.4,
			en = 2.133
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
				arg_120_0:Play102111031(arg_120_1)
			end
		end

		function arg_120_1.onSingleLineUpdate_(arg_123_0)
			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(arg_120_1.actors_["3009ui_story"]) and arg_120_1.var_.characterEffect3009ui_story == nil then
				arg_120_1.var_.characterEffect3009ui_story = arg_120_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_0 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_0 and not isNil(arg_120_1.actors_["3009ui_story"]) then
				if arg_120_1.var_.characterEffect3009ui_story and not isNil(arg_120_1.actors_["3009ui_story"]) then
					arg_120_1.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if arg_120_1.time_ >= 0 + var_123_0 and arg_120_1.time_ < 0 + var_123_0 + arg_123_0 and not isNil(arg_120_1.actors_["3009ui_story"]) and arg_120_1.var_.characterEffect3009ui_story then
				arg_120_1.var_.characterEffect3009ui_story.fillFlat = false
			end

			local var_123_2 = arg_120_1.actors_["1019ui_story"]

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1019ui_story == nil then
				arg_120_1.var_.characterEffect1019ui_story = var_123_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_123_3 = 0.1

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_3 and not isNil(var_123_2) then
				if arg_120_1.var_.characterEffect1019ui_story and not isNil(var_123_2) then
					arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_120_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_120_1.time_ - 0) / var_123_3)
				end
			end

			if arg_120_1.time_ >= 0 + var_123_3 and arg_120_1.time_ < 0 + var_123_3 + arg_123_0 and not isNil(var_123_2) and arg_120_1.var_.characterEffect1019ui_story then
				arg_120_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_120_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_123_4 = arg_120_1.actors_["1019ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos1019ui_story = var_123_4.localPosition
			end

			local var_123_5 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_5 then
				var_123_4.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_120_1.time_ - 0) / var_123_5)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_5 and arg_120_1.time_ < 0 + var_123_5 + arg_123_0 then
				var_123_4.localPosition = Vector3.New(0, 100, 0)
				var_123_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_4.position).x, (manager.ui.mainCamera.transform.position - var_123_4.position).y, (manager.ui.mainCamera.transform.position - var_123_4.position).z)
				var_123_4.localEulerAngles.z = 0
				var_123_4.localEulerAngles.x = 0
				var_123_4.localEulerAngles = var_123_4.localEulerAngles
			end

			local var_123_6 = arg_120_1.actors_["3009ui_story"].transform

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1.var_.moveOldPos3009ui_story = var_123_6.localPosition

				arg_120_1:ShowWeapon(arg_120_1.var_["3009ui_story" .. "Animator"].transform, true)
			end

			local var_123_7 = 0.001

			if 0 <= arg_120_1.time_ and arg_120_1.time_ < 0 + var_123_7 then
				var_123_6.localPosition = Vector3.Lerp(arg_120_1.var_.moveOldPos3009ui_story, Vector3.New(0, -1.75, -4.8), (arg_120_1.time_ - 0) / var_123_7)
				var_123_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_6.position).x, (manager.ui.mainCamera.transform.position - var_123_6.position).y, (manager.ui.mainCamera.transform.position - var_123_6.position).z)
				var_123_6.localEulerAngles.z = 0
				var_123_6.localEulerAngles.x = 0
				var_123_6.localEulerAngles = var_123_6.localEulerAngles
			end

			if arg_120_1.time_ >= 0 + var_123_7 and arg_120_1.time_ < 0 + var_123_7 + arg_123_0 then
				var_123_6.localPosition = Vector3.New(0, -1.75, -4.8)
				var_123_6.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_123_6.position).x, (manager.ui.mainCamera.transform.position - var_123_6.position).y, (manager.ui.mainCamera.transform.position - var_123_6.position).z)
				var_123_6.localEulerAngles.z = 0
				var_123_6.localEulerAngles.x = 0
				var_123_6.localEulerAngles = var_123_6.localEulerAngles
			end

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= 0 + arg_123_0 then
				arg_120_1:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_123_8 = 0
			local var_123_9 = 0.225

			if 0 < arg_120_1.time_ and arg_120_1.time_ <= var_123_8 + arg_123_0 then
				arg_120_1.talkMaxDuration = 0
				arg_120_1.dialogCg_.alpha = 1

				arg_120_1.dialog_:SetActive(true)
				SetActive(arg_120_1.leftNameGo_, true)

				arg_120_1.leftNameTxt_.text = arg_120_1:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_120_1.leftNameTxt_.transform)

				arg_120_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_120_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_120_1:RecordName(arg_120_1.leftNameTxt_.text)
				SetActive(arg_120_1.iconTrs_.gameObject, false)
				arg_120_1.callingController_:SetSelectedState("normal")

				local var_123_10 = arg_120_1:GetWordFromCfg(102111030)
				local var_123_11 = arg_120_1:FormatText(var_123_10.content)

				arg_120_1.text_.text = var_123_11

				LuaForUtil.ClearLinePrefixSymbol(arg_120_1.text_)

				local var_123_13 = 9 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 9)

				if (9 <= 0 and var_123_9 or var_123_9 * (utf8.len(var_123_11) / 9)) > 0 and var_123_9 < var_123_13 then
					arg_120_1.talkMaxDuration = var_123_13

					if var_123_13 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_13 + var_123_8
					end
				end

				arg_120_1.text_.text = var_123_11
				arg_120_1.typewritter.percent = 0

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111030", "story_v_out_102111.awb") ~= 0 then
					local var_123_14 = manager.audio:GetVoiceLength("story_v_out_102111", "102111030", "story_v_out_102111.awb") / 1000

					if var_123_14 + var_123_8 > arg_120_1.duration_ then
						arg_120_1.duration_ = var_123_14 + var_123_8
					end

					if var_123_10.prefab_name ~= "" and arg_120_1.actors_[var_123_10.prefab_name] ~= nil then
						local var_123_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_120_1.actors_[var_123_10.prefab_name].transform, "story_v_out_102111", "102111030", "story_v_out_102111.awb")

						arg_120_1:RecordAudio("102111030", var_123_15)
						arg_120_1:RecordAudio("102111030", var_123_15)
					else
						arg_120_1:AudioAction("play", "voice", "story_v_out_102111", "102111030", "story_v_out_102111.awb")
					end

					arg_120_1:RecordHistoryTalkVoice("story_v_out_102111", "102111030", "story_v_out_102111.awb")
				end

				arg_120_1:RecordContent(arg_120_1.text_.text)
			end

			local var_123_16 = math.max(var_123_9, arg_120_1.talkMaxDuration)

			if var_123_8 <= arg_120_1.time_ and arg_120_1.time_ < var_123_8 + var_123_16 then
				arg_120_1.typewritter.percent = (arg_120_1.time_ - var_123_8) / var_123_16

				arg_120_1.typewritter:SetDirty()
			end

			if arg_120_1.time_ >= var_123_8 + var_123_16 and arg_120_1.time_ < var_123_8 + var_123_16 + arg_123_0 then
				arg_120_1.typewritter.percent = 1

				arg_120_1.typewritter:SetDirty()
				arg_120_1:ShowNextGo(true)
			end
		end

		arg_120_1.nodeConfigList_ = {
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
				actorName = "3009ui_story",
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
	Play102111031 = function(arg_124_0, arg_124_1)
		arg_124_1.time_ = 0
		arg_124_1.frameCnt_ = 0
		arg_124_1.state_ = "playing"
		arg_124_1.curTalkId_ = 102111031
		arg_124_1.duration_ = 5

		SetActive(arg_124_1.tipsGo_, false)

		function arg_124_1.onSingleLineFinish_()
			arg_124_1.onSingleLineUpdate_ = nil
			arg_124_1.onSingleLineFinish_ = nil
			arg_124_1.state_ = "waiting"
		end

		function arg_124_1.playNext_(arg_126_0)
			if arg_126_0 == 1 then
				arg_124_0:Play102111032(arg_124_1)
			end
		end

		function arg_124_1.onSingleLineUpdate_(arg_127_0)
			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 and not isNil(arg_124_1.actors_["3009ui_story"]) and arg_124_1.var_.characterEffect3009ui_story == nil then
				arg_124_1.var_.characterEffect3009ui_story = arg_124_1.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_127_0 = 0.1

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_0 and not isNil(arg_124_1.actors_["3009ui_story"]) then
				if arg_124_1.var_.characterEffect3009ui_story and not isNil(arg_124_1.actors_["3009ui_story"]) then
					arg_124_1.var_.characterEffect3009ui_story.fillFlat = true
					arg_124_1.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_124_1.time_ - 0) / var_127_0)
				end
			end

			if arg_124_1.time_ >= 0 + var_127_0 and arg_124_1.time_ < 0 + var_127_0 + arg_127_0 and not isNil(arg_124_1.actors_["3009ui_story"]) and arg_124_1.var_.characterEffect3009ui_story then
				arg_124_1.var_.characterEffect3009ui_story.fillFlat = true
				arg_124_1.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			local var_127_1 = arg_124_1.actors_["3009ui_story"].transform

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1.var_.moveOldPos3009ui_story = var_127_1.localPosition
			end

			local var_127_2 = 0.001

			if 0 <= arg_124_1.time_ and arg_124_1.time_ < 0 + var_127_2 then
				var_127_1.localPosition = Vector3.Lerp(arg_124_1.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (arg_124_1.time_ - 0) / var_127_2)
				var_127_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_1.position).x, (manager.ui.mainCamera.transform.position - var_127_1.position).y, (manager.ui.mainCamera.transform.position - var_127_1.position).z)
				var_127_1.localEulerAngles.z = 0
				var_127_1.localEulerAngles.x = 0
				var_127_1.localEulerAngles = var_127_1.localEulerAngles
			end

			if arg_124_1.time_ >= 0 + var_127_2 and arg_124_1.time_ < 0 + var_127_2 + arg_127_0 then
				var_127_1.localPosition = Vector3.New(0, 100, 0)
				var_127_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_127_1.position).x, (manager.ui.mainCamera.transform.position - var_127_1.position).y, (manager.ui.mainCamera.transform.position - var_127_1.position).z)
				var_127_1.localEulerAngles.z = 0
				var_127_1.localEulerAngles.x = 0
				var_127_1.localEulerAngles = var_127_1.localEulerAngles
			end

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= 0 + arg_127_0 then
				arg_124_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			local var_127_3 = 0
			local var_127_4 = 0.775

			if 0 < arg_124_1.time_ and arg_124_1.time_ <= var_127_3 + arg_127_0 then
				arg_124_1.talkMaxDuration = 0
				arg_124_1.dialogCg_.alpha = 1

				arg_124_1.dialog_:SetActive(true)
				SetActive(arg_124_1.leftNameGo_, false)

				arg_124_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_124_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_124_1:RecordName(arg_124_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_124_1.iconTrs_.gameObject, false)
				arg_124_1.callingController_:SetSelectedState("normal")

				local var_127_5 = arg_124_1:FormatText(arg_124_1:GetWordFromCfg(102111031).content)

				arg_124_1.text_.text = var_127_5

				LuaForUtil.ClearLinePrefixSymbol(arg_124_1.text_)

				local var_127_7 = 31 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 31)

				if (31 <= 0 and var_127_4 or var_127_4 * (utf8.len(var_127_5) / 31)) > 0 and var_127_4 < var_127_7 then
					arg_124_1.talkMaxDuration = var_127_7

					if var_127_7 + var_127_3 > arg_124_1.duration_ then
						arg_124_1.duration_ = var_127_7 + var_127_3
					end
				end

				arg_124_1.text_.text = var_127_5
				arg_124_1.typewritter.percent = 0

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(false)
				arg_124_1:RecordContent(arg_124_1.text_.text)
			end

			local var_127_8 = math.max(var_127_4, arg_124_1.talkMaxDuration)

			if var_127_3 <= arg_124_1.time_ and arg_124_1.time_ < var_127_3 + var_127_8 then
				arg_124_1.typewritter.percent = (arg_124_1.time_ - var_127_3) / var_127_8

				arg_124_1.typewritter:SetDirty()
			end

			if arg_124_1.time_ >= var_127_3 + var_127_8 and arg_124_1.time_ < var_127_3 + var_127_8 + arg_127_0 then
				arg_124_1.typewritter.percent = 1

				arg_124_1.typewritter:SetDirty()
				arg_124_1:ShowNextGo(true)
			end
		end

		arg_124_1.nodeConfigList_ = {
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

		arg_124_1:InitPlayNodeList()
	end,
	Play102111032 = function(arg_128_0, arg_128_1)
		arg_128_1.time_ = 0
		arg_128_1.frameCnt_ = 0
		arg_128_1.state_ = "playing"
		arg_128_1.curTalkId_ = 102111032
		arg_128_1.duration_ = 6.47

		local var_128_0 = {
			ja = 6.466,
			ko = 2.866,
			zh = 5.666,
			en = 5.533
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
			arg_128_1.auto_ = false
		end

		function arg_128_1.playNext_(arg_130_0)
			arg_128_1.onStoryFinished_()
		end

		function arg_128_1.onSingleLineUpdate_(arg_131_0)
			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 and not isNil(arg_128_1.actors_["1019ui_story"]) and arg_128_1.var_.characterEffect1019ui_story == nil then
				arg_128_1.var_.characterEffect1019ui_story = arg_128_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_131_0 = 0.1

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_0 and not isNil(arg_128_1.actors_["1019ui_story"]) then
				if arg_128_1.var_.characterEffect1019ui_story and not isNil(arg_128_1.actors_["1019ui_story"]) then
					arg_128_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_128_1.time_ >= 0 + var_131_0 and arg_128_1.time_ < 0 + var_131_0 + arg_131_0 and not isNil(arg_128_1.actors_["1019ui_story"]) and arg_128_1.var_.characterEffect1019ui_story then
				arg_128_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			local var_131_2 = arg_128_1.actors_["1019ui_story"].transform

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1.var_.moveOldPos1019ui_story = var_131_2.localPosition
			end

			local var_131_3 = 0.001

			if 0 <= arg_128_1.time_ and arg_128_1.time_ < 0 + var_131_3 then
				var_131_2.localPosition = Vector3.Lerp(arg_128_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_128_1.time_ - 0) / var_131_3)
				var_131_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_2.position).x, (manager.ui.mainCamera.transform.position - var_131_2.position).y, (manager.ui.mainCamera.transform.position - var_131_2.position).z)
				var_131_2.localEulerAngles.z = 0
				var_131_2.localEulerAngles.x = 0
				var_131_2.localEulerAngles = var_131_2.localEulerAngles
			end

			if arg_128_1.time_ >= 0 + var_131_3 and arg_128_1.time_ < 0 + var_131_3 + arg_131_0 then
				var_131_2.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_131_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_131_2.position).x, (manager.ui.mainCamera.transform.position - var_131_2.position).y, (manager.ui.mainCamera.transform.position - var_131_2.position).z)
				var_131_2.localEulerAngles.z = 0
				var_131_2.localEulerAngles.x = 0
				var_131_2.localEulerAngles = var_131_2.localEulerAngles
			end

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= 0 + arg_131_0 then
				arg_128_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			local var_131_4 = 0
			local var_131_5 = 0.5

			if 0 < arg_128_1.time_ and arg_128_1.time_ <= var_131_4 + arg_131_0 then
				arg_128_1.talkMaxDuration = 0
				arg_128_1.dialogCg_.alpha = 1

				arg_128_1.dialog_:SetActive(true)
				SetActive(arg_128_1.leftNameGo_, true)

				arg_128_1.leftNameTxt_.text = arg_128_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_128_1.leftNameTxt_.transform)

				arg_128_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_128_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_128_1:RecordName(arg_128_1.leftNameTxt_.text)
				SetActive(arg_128_1.iconTrs_.gameObject, false)
				arg_128_1.callingController_:SetSelectedState("normal")

				local var_131_6 = arg_128_1:GetWordFromCfg(102111032)
				local var_131_7 = arg_128_1:FormatText(var_131_6.content)

				arg_128_1.text_.text = var_131_7

				LuaForUtil.ClearLinePrefixSymbol(arg_128_1.text_)

				local var_131_9 = 20 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 20)

				if (20 <= 0 and var_131_5 or var_131_5 * (utf8.len(var_131_7) / 20)) > 0 and var_131_5 < var_131_9 then
					arg_128_1.talkMaxDuration = var_131_9

					if var_131_9 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_9 + var_131_4
					end
				end

				arg_128_1.text_.text = var_131_7
				arg_128_1.typewritter.percent = 0

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_102111", "102111032", "story_v_out_102111.awb") ~= 0 then
					local var_131_10 = manager.audio:GetVoiceLength("story_v_out_102111", "102111032", "story_v_out_102111.awb") / 1000

					if var_131_10 + var_131_4 > arg_128_1.duration_ then
						arg_128_1.duration_ = var_131_10 + var_131_4
					end

					if var_131_6.prefab_name ~= "" and arg_128_1.actors_[var_131_6.prefab_name] ~= nil then
						local var_131_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_128_1.actors_[var_131_6.prefab_name].transform, "story_v_out_102111", "102111032", "story_v_out_102111.awb")

						arg_128_1:RecordAudio("102111032", var_131_11)
						arg_128_1:RecordAudio("102111032", var_131_11)
					else
						arg_128_1:AudioAction("play", "voice", "story_v_out_102111", "102111032", "story_v_out_102111.awb")
					end

					arg_128_1:RecordHistoryTalkVoice("story_v_out_102111", "102111032", "story_v_out_102111.awb")
				end

				arg_128_1:RecordContent(arg_128_1.text_.text)
			end

			local var_131_12 = math.max(var_131_5, arg_128_1.talkMaxDuration)

			if var_131_4 <= arg_128_1.time_ and arg_128_1.time_ < var_131_4 + var_131_12 then
				arg_128_1.typewritter.percent = (arg_128_1.time_ - var_131_4) / var_131_12

				arg_128_1.typewritter:SetDirty()
			end

			if arg_128_1.time_ >= var_131_4 + var_131_12 and arg_128_1.time_ < var_131_4 + var_131_12 + arg_131_0 then
				arg_128_1.typewritter.percent = 1

				arg_128_1.typewritter:SetDirty()
				arg_128_1:ShowNextGo(true)
			end
		end

		arg_128_1.nodeConfigList_ = {
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

		arg_128_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/B08b"
	},
	voices = {
		"story_v_out_102111.awb"
	}
}
