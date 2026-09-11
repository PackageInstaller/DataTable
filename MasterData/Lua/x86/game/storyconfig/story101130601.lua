return {
	Play113061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 113061001
		arg_1_1.duration_ = 7.6

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play113061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.F01 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "F01")
				var_4_0.name = "F01"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.F01 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.F01

				arg_1_1.bgs_.F01.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "F01" then
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

			local var_4_8 = manager.ui.mainCamera.transform

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.var_.shakeOldPos = var_4_8.localPosition
			end

			local var_4_9 = 0.6

			if 2 <= arg_1_1.time_ and arg_1_1.time_ < 2 + var_4_9 then
				local var_4_10, var_4_11 = math.modf((arg_1_1.time_ - 2) / 0.066)

				var_4_8.localPosition = Vector3.New(var_4_11 * 0.13, var_4_11 * 0.13, var_4_11 * 0.13) + arg_1_1.var_.shakeOldPos
			end

			if arg_1_1.time_ >= 2 + var_4_9 and arg_1_1.time_ < 2 + var_4_9 + arg_4_0 then
				var_4_8.localPosition = arg_1_1.var_.shakeOldPos
			end

			if 0.766666666666667 < arg_1_1.time_ and arg_1_1.time_ <= 0.766666666666667 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_10", "se_story_10_knock", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_15 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_15 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_15

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_15
						arg_1_1.bgmTxt2_.text = var_4_15
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

			if 2.6 < arg_1_1.time_ and arg_1_1.time_ <= 2.6 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")

				local var_4_18 = manager.audio:GetAudioName("bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_18 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_18

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_18
						arg_1_1.bgmTxt2_.text = var_4_18
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

			local var_4_19 = 2.6
			local var_4_20 = 0.75

			if 2.6 < arg_1_1.time_ and arg_1_1.time_ <= var_4_19 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_21 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_21:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_22 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(113061001).content)

				arg_1_1.text_.text = var_4_22

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_24 = 30 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 30)

				if (30 <= 0 and var_4_20 or var_4_20 * (utf8.len(var_4_22) / 30)) > 0 and var_4_20 < var_4_24 then
					arg_1_1.talkMaxDuration = var_4_24
					var_4_19 = var_4_19 + 0.3

					if var_4_24 + var_4_19 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_24 + var_4_19
					end
				end

				arg_1_1.text_.text = var_4_22
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_25 = var_4_19 + 0.3
			local var_4_26 = math.max(var_4_20, arg_1_1.talkMaxDuration)

			if var_4_19 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_25 + var_4_26 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_25) / var_4_26

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_25 + var_4_26 and arg_1_1.time_ < var_4_25 + var_4_26 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play113061002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 113061002
		arg_9_1.duration_ = 6.47

		local var_9_0 = {
			ja = 6.466,
			ko = 5.733,
			zh = 4.6,
			en = 4.533
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
				arg_9_0:Play113061003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1084ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1084ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1084ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1084ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1084ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1084ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1084ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1084ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1084ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1084ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -0.97, -6)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_12_5 = arg_9_1.actors_["1084ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story == nil then
				arg_9_1.var_.characterEffect1084ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.2

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1084ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1084ui_story then
				arg_9_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_12_8 = 0
			local var_12_9 = 0.55

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:GetWordFromCfg(113061002)
				local var_12_11 = arg_9_1:FormatText(var_12_10.content)

				arg_9_1.text_.text = var_12_11

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_13 = 22 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 22)

				if (22 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_11) / 22)) > 0 and var_12_9 < var_12_13 then
					arg_9_1.talkMaxDuration = var_12_13

					if var_12_13 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_13 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_11
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061002", "story_v_out_113061.awb") ~= 0 then
					local var_12_14 = manager.audio:GetVoiceLength("story_v_out_113061", "113061002", "story_v_out_113061.awb") / 1000

					if var_12_14 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_14 + var_12_8
					end

					if var_12_10.prefab_name ~= "" and arg_9_1.actors_[var_12_10.prefab_name] ~= nil then
						local var_12_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_9_1.actors_[var_12_10.prefab_name].transform, "story_v_out_113061", "113061002", "story_v_out_113061.awb")

						arg_9_1:RecordAudio("113061002", var_12_15)
						arg_9_1:RecordAudio("113061002", var_12_15)
					else
						arg_9_1:AudioAction("play", "voice", "story_v_out_113061", "113061002", "story_v_out_113061.awb")
					end

					arg_9_1:RecordHistoryTalkVoice("story_v_out_113061", "113061002", "story_v_out_113061.awb")
				end

				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_16 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_16 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_16

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_16 and arg_9_1.time_ < var_12_8 + var_12_16 + arg_12_0 then
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
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_9_1:InitPlayNodeList()
	end,
	Play113061003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 113061003
		arg_13_1.duration_ = 9.23

		local var_13_0 = {
			ja = 8.733,
			ko = 6.866,
			zh = 7.2,
			en = 9.233
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
				arg_13_0:Play113061004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story == nil then
				arg_13_1.var_.characterEffect1084ui_story = arg_13_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_0 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) then
				if arg_13_1.var_.characterEffect1084ui_story and not isNil(arg_13_1.actors_["1084ui_story"]) then
					arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_0)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_0 and arg_13_1.time_ < 0 + var_16_0 + arg_16_0 and not isNil(arg_13_1.actors_["1084ui_story"]) and arg_13_1.var_.characterEffect1084ui_story then
				arg_13_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_16_1 = "1097ui_story"

			if arg_13_1.actors_["1097ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1097ui_story"))) then
				local var_16_2 = Object.Instantiate(Asset.Load("Char/" .. "1097ui_story"), arg_13_1.stage_.transform)

				var_16_2.name = var_16_1
				var_16_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_[var_16_1] = var_16_2

				local var_16_3 = var_16_2:GetComponentInChildren(typeof(CharacterEffect))

				var_16_3.enabled = true

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_2, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_3.transform, false)

				arg_13_1.var_[var_16_1 .. "Animator"] = var_16_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_[var_16_1 .. "Animator"].applyRootMotion = true
				arg_13_1.var_[var_16_1 .. "LipSync"] = var_16_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_5 = arg_13_1.actors_["1097ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1097ui_story = var_16_5.localPosition
			end

			local var_16_6 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 then
				var_16_5.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_13_1.time_ - 0) / var_16_6)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 then
				var_16_5.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_16_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_5.position).x, (manager.ui.mainCamera.transform.position - var_16_5.position).y, (manager.ui.mainCamera.transform.position - var_16_5.position).z)
				var_16_5.localEulerAngles.z = 0
				var_16_5.localEulerAngles.x = 0
				var_16_5.localEulerAngles = var_16_5.localEulerAngles
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action4_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1304cva")
			end

			local var_16_7 = arg_13_1.actors_["1097ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1097ui_story == nil then
				arg_13_1.var_.characterEffect1097ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.2

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect1097ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1097ui_story then
				arg_13_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_16_10 = 0
			local var_16_11 = 0.5

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_10 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_12 = arg_13_1:GetWordFromCfg(113061003)
				local var_16_13 = arg_13_1:FormatText(var_16_12.content)

				arg_13_1.text_.text = var_16_13

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_15 = 20 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 20)

				if (20 <= 0 and var_16_11 or var_16_11 * (utf8.len(var_16_13) / 20)) > 0 and var_16_11 < var_16_15 then
					arg_13_1.talkMaxDuration = var_16_15

					if var_16_15 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_15 + var_16_10
					end
				end

				arg_13_1.text_.text = var_16_13
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061003", "story_v_out_113061.awb") ~= 0 then
					local var_16_16 = manager.audio:GetVoiceLength("story_v_out_113061", "113061003", "story_v_out_113061.awb") / 1000

					if var_16_16 + var_16_10 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_10
					end

					if var_16_12.prefab_name ~= "" and arg_13_1.actors_[var_16_12.prefab_name] ~= nil then
						local var_16_17 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_12.prefab_name].transform, "story_v_out_113061", "113061003", "story_v_out_113061.awb")

						arg_13_1:RecordAudio("113061003", var_16_17)
						arg_13_1:RecordAudio("113061003", var_16_17)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_113061", "113061003", "story_v_out_113061.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_113061", "113061003", "story_v_out_113061.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_18 = math.max(var_16_11, arg_13_1.talkMaxDuration)

			if var_16_10 <= arg_13_1.time_ and arg_13_1.time_ < var_16_10 + var_16_18 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_10) / var_16_18

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_10 + var_16_18 and arg_13_1.time_ < var_16_10 + var_16_18 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play113061004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 113061004
		arg_17_1.duration_ = 12.3

		local var_17_0 = {
			ja = 10.466,
			ko = 11.433,
			zh = 9.866,
			en = 12.3
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
				arg_17_0:Play113061005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1084ui_story = arg_17_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).z)
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles = arg_17_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1084ui_story"].transform.position).z)
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1084ui_story"].transform.localEulerAngles = arg_17_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1097ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1097ui_story = var_20_1.localPosition
			end

			local var_20_2 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 then
				var_20_1.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_2)
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

			local var_20_3 = "1042ui_story"

			if arg_17_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_20_4 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_17_1.stage_.transform)

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

			local var_20_7 = arg_17_1.actors_["1042ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1042ui_story = var_20_7.localPosition
			end

			local var_20_8 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_8 then
				var_20_7.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1042ui_story, Vector3.New(0, -1.06, -6.2), (arg_17_1.time_ - 0) / var_20_8)
				var_20_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_7.position).x, (manager.ui.mainCamera.transform.position - var_20_7.position).y, (manager.ui.mainCamera.transform.position - var_20_7.position).z)
				var_20_7.localEulerAngles.z = 0
				var_20_7.localEulerAngles.x = 0
				var_20_7.localEulerAngles = var_20_7.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_8 and arg_17_1.time_ < 0 + var_20_8 + arg_20_0 then
				var_20_7.localPosition = Vector3.New(0, -1.06, -6.2)
				var_20_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_7.position).x, (manager.ui.mainCamera.transform.position - var_20_7.position).y, (manager.ui.mainCamera.transform.position - var_20_7.position).z)
				var_20_7.localEulerAngles.z = 0
				var_20_7.localEulerAngles.x = 0
				var_20_7.localEulerAngles = var_20_7.localEulerAngles
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_20_9 = arg_17_1.actors_["1042ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1042ui_story == nil then
				arg_17_1.var_.characterEffect1042ui_story = var_20_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_10 = 0.2

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_10 and not isNil(var_20_9) then
				if arg_17_1.var_.characterEffect1042ui_story and not isNil(var_20_9) then
					arg_17_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_17_1.time_ >= 0 + var_20_10 and arg_17_1.time_ < 0 + var_20_10 + arg_20_0 and not isNil(var_20_9) and arg_17_1.var_.characterEffect1042ui_story then
				arg_17_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_20_12 = 0
			local var_20_13 = 1.125

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_12 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_14 = arg_17_1:GetWordFromCfg(113061004)
				local var_20_15 = arg_17_1:FormatText(var_20_14.content)

				arg_17_1.text_.text = var_20_15

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_17 = 45 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 45)

				if (45 <= 0 and var_20_13 or var_20_13 * (utf8.len(var_20_15) / 45)) > 0 and var_20_13 < var_20_17 then
					arg_17_1.talkMaxDuration = var_20_17

					if var_20_17 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_17 + var_20_12
					end
				end

				arg_17_1.text_.text = var_20_15
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061004", "story_v_out_113061.awb") ~= 0 then
					local var_20_18 = manager.audio:GetVoiceLength("story_v_out_113061", "113061004", "story_v_out_113061.awb") / 1000

					if var_20_18 + var_20_12 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_18 + var_20_12
					end

					if var_20_14.prefab_name ~= "" and arg_17_1.actors_[var_20_14.prefab_name] ~= nil then
						local var_20_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_17_1.actors_[var_20_14.prefab_name].transform, "story_v_out_113061", "113061004", "story_v_out_113061.awb")

						arg_17_1:RecordAudio("113061004", var_20_19)
						arg_17_1:RecordAudio("113061004", var_20_19)
					else
						arg_17_1:AudioAction("play", "voice", "story_v_out_113061", "113061004", "story_v_out_113061.awb")
					end

					arg_17_1:RecordHistoryTalkVoice("story_v_out_113061", "113061004", "story_v_out_113061.awb")
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
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play113061005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 113061005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play113061006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1042ui_story = arg_21_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1042ui_story"].transform.position).z)
				arg_21_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1042ui_story"].transform.localEulerAngles = arg_21_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1042ui_story"].transform.position).z)
				arg_21_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1042ui_story"].transform.localEulerAngles = arg_21_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:AudioAction("play", "effect", "se_story_10", "se_story_10_disappear", "")
			end

			local var_24_2 = 0
			local var_24_3 = 0.725

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_2 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, false)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_4 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(113061005).content)

				arg_21_1.text_.text = var_24_4

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_6 = 29 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 29)

				if (29 <= 0 and var_24_3 or var_24_3 * (utf8.len(var_24_4) / 29)) > 0 and var_24_3 < var_24_6 then
					arg_21_1.talkMaxDuration = var_24_6

					if var_24_6 + var_24_2 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_6 + var_24_2
					end
				end

				arg_21_1.text_.text = var_24_4
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_7 = math.max(var_24_3, arg_21_1.talkMaxDuration)

			if var_24_2 <= arg_21_1.time_ and arg_21_1.time_ < var_24_2 + var_24_7 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_2) / var_24_7

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_2 + var_24_7 and arg_21_1.time_ < var_24_2 + var_24_7 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
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
	Play113061006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 113061006
		arg_25_1.duration_ = 9

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play113061007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_0 = 2

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				local var_28_1 = Color.New(0, 0, 0)

				var_28_1.a = Mathf.Lerp(0, 1, (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.mask_.color = var_28_1
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				local var_28_2 = Color.New(0, 0, 0)

				var_28_2.a = 1
				arg_25_1.mask_.color = var_28_2
			end

			local var_28_3 = 2

			if 2 < arg_25_1.time_ and arg_25_1.time_ <= var_28_3 + arg_28_0 then
				arg_25_1.mask_.enabled = true
				arg_25_1.mask_.raycastTarget = true

				arg_25_1:SetGaussion(false)
			end

			local var_28_4 = 2

			if var_28_3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_3 + var_28_4 then
				local var_28_5 = Color.New(0, 0, 0)

				var_28_5.a = Mathf.Lerp(1, 0, (arg_25_1.time_ - var_28_3) / var_28_4)
				arg_25_1.mask_.color = var_28_5
			end

			if arg_25_1.time_ >= var_28_3 + var_28_4 and arg_25_1.time_ < var_28_3 + var_28_4 + arg_28_0 then
				local var_28_6 = Color.New(0, 0, 0)

				arg_25_1.mask_.enabled = false
				var_28_6.a = 0
				arg_25_1.mask_.color = var_28_6
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_7 = 4
			local var_28_8 = 1.225

			if 4 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_9 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_9:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_9:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_9:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(113061006).content)

				arg_25_1.text_.text = var_28_10

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_12 = 49 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 49)

				if (49 <= 0 and var_28_8 or var_28_8 * (utf8.len(var_28_10) / 49)) > 0 and var_28_8 < var_28_12 then
					arg_25_1.talkMaxDuration = var_28_12
					var_28_7 = var_28_7 + 0.3

					if var_28_12 + var_28_7 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_12 + var_28_7
					end
				end

				arg_25_1.text_.text = var_28_10
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_13 = var_28_7 + 0.3
			local var_28_14 = math.max(var_28_8, arg_25_1.talkMaxDuration)

			if var_28_7 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_13 + var_28_14 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_13) / var_28_14

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_13 + var_28_14 and arg_25_1.time_ < var_28_13 + var_28_14 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play113061007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 113061007
		arg_31_1.duration_ = 10.3

		local var_31_0 = {
			ja = 10.3,
			ko = 8.1,
			zh = 10.233,
			en = 10.2
		}
		local var_31_1 = manager.audio:GetLocalizationFlag()

		if var_31_0[var_31_1] ~= nil then
			arg_31_1.duration_ = var_31_0[var_31_1]
		end

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play113061008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if arg_31_1.actors_["1041ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1041ui_story"))) then
				local var_34_0 = Object.Instantiate(Asset.Load("Char/" .. "1041ui_story"), arg_31_1.stage_.transform)

				var_34_0.name = "1041ui_story"
				var_34_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_31_1.actors_["1041ui_story"] = var_34_0

				local var_34_1 = var_34_0:GetComponentInChildren(typeof(CharacterEffect))

				var_34_1.enabled = true

				local var_34_2 = GameObjectTools.GetOrAddComponent(var_34_0, typeof(DynamicBoneHelper))

				if var_34_2 then
					var_34_2:EnableDynamicBone(false)
				end

				arg_31_1:ShowWeapon(var_34_1.transform, false)

				arg_31_1.var_["1041ui_story" .. "Animator"] = var_34_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_31_1.var_["1041ui_story" .. "Animator"].applyRootMotion = true
				arg_31_1.var_["1041ui_story" .. "LipSync"] = var_34_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_34_3 = arg_31_1.actors_["1041ui_story"].transform

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1041ui_story = var_34_3.localPosition
			end

			local var_34_4 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_4 then
				var_34_3.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_31_1.time_ - 0) / var_34_4)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_4 and arg_31_1.time_ < 0 + var_34_4 + arg_34_0 then
				var_34_3.localPosition = Vector3.New(0, -1.11, -5.9)
				var_34_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_34_3.position).x, (manager.ui.mainCamera.transform.position - var_34_3.position).y, (manager.ui.mainCamera.transform.position - var_34_3.position).z)
				var_34_3.localEulerAngles.z = 0
				var_34_3.localEulerAngles.x = 0
				var_34_3.localEulerAngles = var_34_3.localEulerAngles
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_34_5 = arg_31_1.actors_["1041ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1041ui_story == nil then
				arg_31_1.var_.characterEffect1041ui_story = var_34_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_6 = 0.2

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_6 and not isNil(var_34_5) then
				if arg_31_1.var_.characterEffect1041ui_story and not isNil(var_34_5) then
					arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_6 and arg_31_1.time_ < 0 + var_34_6 + arg_34_0 and not isNil(var_34_5) and arg_31_1.var_.characterEffect1041ui_story then
				arg_31_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_34_8 = 0
			local var_34_9 = 1.25

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_8 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_10 = arg_31_1:GetWordFromCfg(113061007)
				local var_34_11 = arg_31_1:FormatText(var_34_10.content)

				arg_31_1.text_.text = var_34_11

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_13 = 50 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 50)

				if (50 <= 0 and var_34_9 or var_34_9 * (utf8.len(var_34_11) / 50)) > 0 and var_34_9 < var_34_13 then
					arg_31_1.talkMaxDuration = var_34_13

					if var_34_13 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_13 + var_34_8
					end
				end

				arg_31_1.text_.text = var_34_11
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061007", "story_v_out_113061.awb") ~= 0 then
					local var_34_14 = manager.audio:GetVoiceLength("story_v_out_113061", "113061007", "story_v_out_113061.awb") / 1000

					if var_34_14 + var_34_8 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_14 + var_34_8
					end

					if var_34_10.prefab_name ~= "" and arg_31_1.actors_[var_34_10.prefab_name] ~= nil then
						local var_34_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_31_1.actors_[var_34_10.prefab_name].transform, "story_v_out_113061", "113061007", "story_v_out_113061.awb")

						arg_31_1:RecordAudio("113061007", var_34_15)
						arg_31_1:RecordAudio("113061007", var_34_15)
					else
						arg_31_1:AudioAction("play", "voice", "story_v_out_113061", "113061007", "story_v_out_113061.awb")
					end

					arg_31_1:RecordHistoryTalkVoice("story_v_out_113061", "113061007", "story_v_out_113061.awb")
				end

				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_16 = math.max(var_34_9, arg_31_1.talkMaxDuration)

			if var_34_8 <= arg_31_1.time_ and arg_31_1.time_ < var_34_8 + var_34_16 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_8) / var_34_16

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_8 + var_34_16 and arg_31_1.time_ < var_34_8 + var_34_16 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_31_1:InitPlayNodeList()
	end,
	Play113061008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 113061008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play113061009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1041ui_story = arg_35_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1041ui_story"].transform.position).z)
				arg_35_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1041ui_story"].transform.localEulerAngles = arg_35_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1041ui_story"].transform.position).z)
				arg_35_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1041ui_story"].transform.localEulerAngles = arg_35_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_38_1 = 0
			local var_38_2 = 0.775

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_1 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, false)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_35_1.iconTrs_.gameObject, false)
				arg_35_1.callingController_:SetSelectedState("normal")

				local var_38_3 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(113061008).content)

				arg_35_1.text_.text = var_38_3

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_5 = 31 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 31)

				if (31 <= 0 and var_38_2 or var_38_2 * (utf8.len(var_38_3) / 31)) > 0 and var_38_2 < var_38_5 then
					arg_35_1.talkMaxDuration = var_38_5

					if var_38_5 + var_38_1 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_5 + var_38_1
					end
				end

				arg_35_1.text_.text = var_38_3
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_6 = math.max(var_38_2, arg_35_1.talkMaxDuration)

			if var_38_1 <= arg_35_1.time_ and arg_35_1.time_ < var_38_1 + var_38_6 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_1) / var_38_6

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_1 + var_38_6 and arg_35_1.time_ < var_38_1 + var_38_6 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_35_1:InitPlayNodeList()
	end,
	Play113061009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 113061009
		arg_39_1.duration_ = 8.1

		local var_39_0 = {
			ja = 5.933,
			ko = 5.9,
			zh = 4.8,
			en = 8.1
		}
		local var_39_1 = manager.audio:GetLocalizationFlag()

		if var_39_0[var_39_1] ~= nil then
			arg_39_1.duration_ = var_39_0[var_39_1]
		end

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play113061010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.var_.moveOldPos1042ui_story = arg_39_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_42_0 = 0.001

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_0 then
				arg_39_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_39_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_39_1.time_ - 0) / var_42_0)
				arg_39_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1042ui_story"].transform.position).z)
				arg_39_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1042ui_story"].transform.localEulerAngles = arg_39_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_39_1.time_ >= 0 + var_42_0 and arg_39_1.time_ < 0 + var_42_0 + arg_42_0 then
				arg_39_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_39_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_39_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_39_1.actors_["1042ui_story"].transform.position).z)
				arg_39_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_39_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_39_1.actors_["1042ui_story"].transform.localEulerAngles = arg_39_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_42_1 = arg_39_1.actors_["1084ui_story"]

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1084ui_story == nil then
				arg_39_1.var_.characterEffect1084ui_story = var_42_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_42_2 = 0.2

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_2 and not isNil(var_42_1) then
				if arg_39_1.var_.characterEffect1084ui_story and not isNil(var_42_1) then
					arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_39_1.time_ >= 0 + var_42_2 and arg_39_1.time_ < 0 + var_42_2 + arg_42_0 and not isNil(var_42_1) and arg_39_1.var_.characterEffect1084ui_story then
				arg_39_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_42_4 = 0
			local var_42_5 = 0.575

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_4 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, false)
				arg_39_1.callingController_:SetSelectedState("normal")

				local var_42_6 = arg_39_1:GetWordFromCfg(113061009)
				local var_42_7 = arg_39_1:FormatText(var_42_6.content)

				arg_39_1.text_.text = var_42_7

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_9 = 23 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 23)

				if (23 <= 0 and var_42_5 or var_42_5 * (utf8.len(var_42_7) / 23)) > 0 and var_42_5 < var_42_9 then
					arg_39_1.talkMaxDuration = var_42_9

					if var_42_9 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_9 + var_42_4
					end
				end

				arg_39_1.text_.text = var_42_7
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061009", "story_v_out_113061.awb") ~= 0 then
					local var_42_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061009", "story_v_out_113061.awb") / 1000

					if var_42_10 + var_42_4 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_10 + var_42_4
					end

					if var_42_6.prefab_name ~= "" and arg_39_1.actors_[var_42_6.prefab_name] ~= nil then
						local var_42_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_39_1.actors_[var_42_6.prefab_name].transform, "story_v_out_113061", "113061009", "story_v_out_113061.awb")

						arg_39_1:RecordAudio("113061009", var_42_11)
						arg_39_1:RecordAudio("113061009", var_42_11)
					else
						arg_39_1:AudioAction("play", "voice", "story_v_out_113061", "113061009", "story_v_out_113061.awb")
					end

					arg_39_1:RecordHistoryTalkVoice("story_v_out_113061", "113061009", "story_v_out_113061.awb")
				end

				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_12 = math.max(var_42_5, arg_39_1.talkMaxDuration)

			if var_42_4 <= arg_39_1.time_ and arg_39_1.time_ < var_42_4 + var_42_12 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - var_42_4) / var_42_12

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= var_42_4 + var_42_12 and arg_39_1.time_ < var_42_4 + var_42_12 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_39_1:InitPlayNodeList()
	end,
	Play113061010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 113061010
		arg_43_1.duration_ = 2.4

		local var_43_0 = {
			ja = 2.4,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
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
				arg_43_0:Play113061011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(arg_43_1.actors_["1042ui_story"]) and arg_43_1.var_.characterEffect1042ui_story == nil then
				arg_43_1.var_.characterEffect1042ui_story = arg_43_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_0 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_0 and not isNil(arg_43_1.actors_["1042ui_story"]) then
				if arg_43_1.var_.characterEffect1042ui_story and not isNil(arg_43_1.actors_["1042ui_story"]) then
					arg_43_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_43_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_43_1.time_ - 0) / var_46_0)
				end
			end

			if arg_43_1.time_ >= 0 + var_46_0 and arg_43_1.time_ < 0 + var_46_0 + arg_46_0 and not isNil(arg_43_1.actors_["1042ui_story"]) and arg_43_1.var_.characterEffect1042ui_story then
				arg_43_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_43_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_46_1 = arg_43_1.actors_["1041ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos1041ui_story = var_46_1.localPosition
			end

			local var_46_2 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_2 then
				var_46_1.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos1041ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_43_1.time_ - 0) / var_46_2)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_2 and arg_43_1.time_ < 0 + var_46_2 + arg_46_0 then
				var_46_1.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_46_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_1.position).x, (manager.ui.mainCamera.transform.position - var_46_1.position).y, (manager.ui.mainCamera.transform.position - var_46_1.position).z)
				var_46_1.localEulerAngles.z = 0
				var_46_1.localEulerAngles.x = 0
				var_46_1.localEulerAngles = var_46_1.localEulerAngles
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_46_3 = arg_43_1.actors_["1084ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1084ui_story == nil then
				arg_43_1.var_.characterEffect1084ui_story = var_46_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_4 = 0.2

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_4 and not isNil(var_46_3) then
				if arg_43_1.var_.characterEffect1084ui_story and not isNil(var_46_3) then
					arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_4 and arg_43_1.time_ < 0 + var_46_4 + arg_46_0 and not isNil(var_46_3) and arg_43_1.var_.characterEffect1084ui_story then
				arg_43_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_46_6 = 0
			local var_46_7 = 0.1

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_6 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_8 = arg_43_1:GetWordFromCfg(113061010)
				local var_46_9 = arg_43_1:FormatText(var_46_8.content)

				arg_43_1.text_.text = var_46_9

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_11 = 4 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_9) / 4)

				if (4 <= 0 and var_46_7 or var_46_7 * (utf8.len(var_46_9) / 4)) > 0 and var_46_7 < var_46_11 then
					arg_43_1.talkMaxDuration = var_46_11

					if var_46_11 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_11 + var_46_6
					end
				end

				arg_43_1.text_.text = var_46_9
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061010", "story_v_out_113061.awb") ~= 0 then
					local var_46_12 = manager.audio:GetVoiceLength("story_v_out_113061", "113061010", "story_v_out_113061.awb") / 1000

					if var_46_12 + var_46_6 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_12 + var_46_6
					end

					if var_46_8.prefab_name ~= "" and arg_43_1.actors_[var_46_8.prefab_name] ~= nil then
						local var_46_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_43_1.actors_[var_46_8.prefab_name].transform, "story_v_out_113061", "113061010", "story_v_out_113061.awb")

						arg_43_1:RecordAudio("113061010", var_46_13)
						arg_43_1:RecordAudio("113061010", var_46_13)
					else
						arg_43_1:AudioAction("play", "voice", "story_v_out_113061", "113061010", "story_v_out_113061.awb")
					end

					arg_43_1:RecordHistoryTalkVoice("story_v_out_113061", "113061010", "story_v_out_113061.awb")
				end

				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_14 = math.max(var_46_7, arg_43_1.talkMaxDuration)

			if var_46_6 <= arg_43_1.time_ and arg_43_1.time_ < var_46_6 + var_46_14 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_6) / var_46_14

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_6 + var_46_14 and arg_43_1.time_ < var_46_6 + var_46_14 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_43_1:InitPlayNodeList()
	end,
	Play113061011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 113061011
		arg_47_1.duration_ = 16.57

		local var_47_0 = {
			ja = 16.566,
			ko = 8.533,
			zh = 9.7,
			en = 9.666
		}
		local var_47_1 = manager.audio:GetLocalizationFlag()

		if var_47_0[var_47_1] ~= nil then
			arg_47_1.duration_ = var_47_0[var_47_1]
		end

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play113061012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action424")
			end

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 then
				arg_47_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_50_0 = arg_47_1.actors_["1042ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1042ui_story == nil then
				arg_47_1.var_.characterEffect1042ui_story = var_50_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_1 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_1 and not isNil(var_50_0) then
				if arg_47_1.var_.characterEffect1042ui_story and not isNil(var_50_0) then
					arg_47_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_47_1.time_ >= 0 + var_50_1 and arg_47_1.time_ < 0 + var_50_1 + arg_50_0 and not isNil(var_50_0) and arg_47_1.var_.characterEffect1042ui_story then
				arg_47_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_50_3 = arg_47_1.actors_["1041ui_story"]

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1041ui_story == nil then
				arg_47_1.var_.characterEffect1041ui_story = var_50_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_4 = 0.2

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_4 and not isNil(var_50_3) then
				if arg_47_1.var_.characterEffect1041ui_story and not isNil(var_50_3) then
					arg_47_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_47_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_4)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_4 and arg_47_1.time_ < 0 + var_50_4 + arg_50_0 and not isNil(var_50_3) and arg_47_1.var_.characterEffect1041ui_story then
				arg_47_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_47_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_50_5 = 0
			local var_50_6 = 1.15

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_5 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, false)
				arg_47_1.callingController_:SetSelectedState("normal")

				local var_50_7 = arg_47_1:GetWordFromCfg(113061011)
				local var_50_8 = arg_47_1:FormatText(var_50_7.content)

				arg_47_1.text_.text = var_50_8

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_10 = 46 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 46)

				if (46 <= 0 and var_50_6 or var_50_6 * (utf8.len(var_50_8) / 46)) > 0 and var_50_6 < var_50_10 then
					arg_47_1.talkMaxDuration = var_50_10

					if var_50_10 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_10 + var_50_5
					end
				end

				arg_47_1.text_.text = var_50_8
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061011", "story_v_out_113061.awb") ~= 0 then
					local var_50_11 = manager.audio:GetVoiceLength("story_v_out_113061", "113061011", "story_v_out_113061.awb") / 1000

					if var_50_11 + var_50_5 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_11 + var_50_5
					end

					if var_50_7.prefab_name ~= "" and arg_47_1.actors_[var_50_7.prefab_name] ~= nil then
						local var_50_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_47_1.actors_[var_50_7.prefab_name].transform, "story_v_out_113061", "113061011", "story_v_out_113061.awb")

						arg_47_1:RecordAudio("113061011", var_50_12)
						arg_47_1:RecordAudio("113061011", var_50_12)
					else
						arg_47_1:AudioAction("play", "voice", "story_v_out_113061", "113061011", "story_v_out_113061.awb")
					end

					arg_47_1:RecordHistoryTalkVoice("story_v_out_113061", "113061011", "story_v_out_113061.awb")
				end

				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_13 = math.max(var_50_6, arg_47_1.talkMaxDuration)

			if var_50_5 <= arg_47_1.time_ and arg_47_1.time_ < var_50_5 + var_50_13 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_5) / var_50_13

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_5 + var_50_13 and arg_47_1.time_ < var_50_5 + var_50_13 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play113061012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 113061012
		arg_51_1.duration_ = 2.17

		local var_51_0 = {
			ja = 2.166,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play113061013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_54_0 = arg_51_1.actors_["1041ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1041ui_story == nil then
				arg_51_1.var_.characterEffect1041ui_story = var_54_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_1 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_1 and not isNil(var_54_0) then
				if arg_51_1.var_.characterEffect1041ui_story and not isNil(var_54_0) then
					arg_51_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= 0 + var_54_1 and arg_51_1.time_ < 0 + var_54_1 + arg_54_0 and not isNil(var_54_0) and arg_51_1.var_.characterEffect1041ui_story then
				arg_51_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_54_3 = arg_51_1.actors_["1042ui_story"]

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1042ui_story == nil then
				arg_51_1.var_.characterEffect1042ui_story = var_54_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_4 = 0.2

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 and not isNil(var_54_3) then
				if arg_51_1.var_.characterEffect1042ui_story and not isNil(var_54_3) then
					arg_51_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_51_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_51_1.time_ - 0) / var_54_4)
				end
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 and not isNil(var_54_3) and arg_51_1.var_.characterEffect1042ui_story then
				arg_51_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_51_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_54_5 = 0
			local var_54_6 = 0.125

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_7 = arg_51_1:GetWordFromCfg(113061012)
				local var_54_8 = arg_51_1:FormatText(var_54_7.content)

				arg_51_1.text_.text = var_54_8

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_10 = 5 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 5)

				if (5 <= 0 and var_54_6 or var_54_6 * (utf8.len(var_54_8) / 5)) > 0 and var_54_6 < var_54_10 then
					arg_51_1.talkMaxDuration = var_54_10

					if var_54_10 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_10 + var_54_5
					end
				end

				arg_51_1.text_.text = var_54_8
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061012", "story_v_out_113061.awb") ~= 0 then
					local var_54_11 = manager.audio:GetVoiceLength("story_v_out_113061", "113061012", "story_v_out_113061.awb") / 1000

					if var_54_11 + var_54_5 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_11 + var_54_5
					end

					if var_54_7.prefab_name ~= "" and arg_51_1.actors_[var_54_7.prefab_name] ~= nil then
						local var_54_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_7.prefab_name].transform, "story_v_out_113061", "113061012", "story_v_out_113061.awb")

						arg_51_1:RecordAudio("113061012", var_54_12)
						arg_51_1:RecordAudio("113061012", var_54_12)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_113061", "113061012", "story_v_out_113061.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_113061", "113061012", "story_v_out_113061.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_13 = math.max(var_54_6, arg_51_1.talkMaxDuration)

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_13 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_5) / var_54_13

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_5 + var_54_13 and arg_51_1.time_ < var_54_5 + var_54_13 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play113061013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 113061013
		arg_55_1.duration_ = 13.97

		local var_55_0 = {
			ja = 9.133,
			ko = 13.966,
			zh = 9.966,
			en = 11.2
		}
		local var_55_1 = manager.audio:GetLocalizationFlag()

		if var_55_0[var_55_1] ~= nil then
			arg_55_1.duration_ = var_55_0[var_55_1]
		end

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play113061014(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			local var_58_0 = arg_55_1.actors_["1042ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1042ui_story == nil then
				arg_55_1.var_.characterEffect1042ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_1 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 and not isNil(var_58_0) then
				if arg_55_1.var_.characterEffect1042ui_story and not isNil(var_58_0) then
					arg_55_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 and not isNil(var_58_0) and arg_55_1.var_.characterEffect1042ui_story then
				arg_55_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_58_3 = arg_55_1.actors_["1041ui_story"]

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1041ui_story == nil then
				arg_55_1.var_.characterEffect1041ui_story = var_58_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_4 = 0.2

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_4 and not isNil(var_58_3) then
				if arg_55_1.var_.characterEffect1041ui_story and not isNil(var_58_3) then
					arg_55_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_55_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_55_1.time_ - 0) / var_58_4)
				end
			end

			if arg_55_1.time_ >= 0 + var_58_4 and arg_55_1.time_ < 0 + var_58_4 + arg_58_0 and not isNil(var_58_3) and arg_55_1.var_.characterEffect1041ui_story then
				arg_55_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_55_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_58_5 = 0
			local var_58_6 = 1.25

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_5 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, true)

				arg_55_1.leftNameTxt_.text = arg_55_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_55_1.leftNameTxt_.transform)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1.leftNameTxt_.text)
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_7 = arg_55_1:GetWordFromCfg(113061013)
				local var_58_8 = arg_55_1:FormatText(var_58_7.content)

				arg_55_1.text_.text = var_58_8

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 50 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 50)

				if (50 <= 0 and var_58_6 or var_58_6 * (utf8.len(var_58_8) / 50)) > 0 and var_58_6 < var_58_10 then
					arg_55_1.talkMaxDuration = var_58_10

					if var_58_10 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_10 + var_58_5
					end
				end

				arg_55_1.text_.text = var_58_8
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061013", "story_v_out_113061.awb") ~= 0 then
					local var_58_11 = manager.audio:GetVoiceLength("story_v_out_113061", "113061013", "story_v_out_113061.awb") / 1000

					if var_58_11 + var_58_5 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_11 + var_58_5
					end

					if var_58_7.prefab_name ~= "" and arg_55_1.actors_[var_58_7.prefab_name] ~= nil then
						local var_58_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_55_1.actors_[var_58_7.prefab_name].transform, "story_v_out_113061", "113061013", "story_v_out_113061.awb")

						arg_55_1:RecordAudio("113061013", var_58_12)
						arg_55_1:RecordAudio("113061013", var_58_12)
					else
						arg_55_1:AudioAction("play", "voice", "story_v_out_113061", "113061013", "story_v_out_113061.awb")
					end

					arg_55_1:RecordHistoryTalkVoice("story_v_out_113061", "113061013", "story_v_out_113061.awb")
				end

				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_6, arg_55_1.talkMaxDuration)

			if var_58_5 <= arg_55_1.time_ and arg_55_1.time_ < var_58_5 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_5) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_5 + var_58_13 and arg_55_1.time_ < var_58_5 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end

		arg_55_1.nodeConfigList_ = {}

		arg_55_1:InitPlayNodeList()
	end,
	Play113061014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 113061014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play113061015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1041ui_story = arg_59_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1041ui_story"].transform.position).z)
				arg_59_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1041ui_story"].transform.localEulerAngles = arg_59_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_59_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1041ui_story"].transform.position).z)
				arg_59_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1041ui_story"].transform.localEulerAngles = arg_59_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1042ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1042ui_story = var_62_1.localPosition
			end

			local var_62_2 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 then
				var_62_1.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_59_1.time_ - 0) / var_62_2)
				var_62_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_1.position).x, (manager.ui.mainCamera.transform.position - var_62_1.position).y, (manager.ui.mainCamera.transform.position - var_62_1.position).z)
				var_62_1.localEulerAngles.z = 0
				var_62_1.localEulerAngles.x = 0
				var_62_1.localEulerAngles = var_62_1.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 then
				var_62_1.localPosition = Vector3.New(0, 100, 0)
				var_62_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_1.position).x, (manager.ui.mainCamera.transform.position - var_62_1.position).y, (manager.ui.mainCamera.transform.position - var_62_1.position).z)
				var_62_1.localEulerAngles.z = 0
				var_62_1.localEulerAngles.x = 0
				var_62_1.localEulerAngles = var_62_1.localEulerAngles
			end

			local var_62_3 = 0
			local var_62_4 = 1.175

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_3 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_5 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(113061014).content)

				arg_59_1.text_.text = var_62_5

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_7 = 47 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_5) / 47)

				if (47 <= 0 and var_62_4 or var_62_4 * (utf8.len(var_62_5) / 47)) > 0 and var_62_4 < var_62_7 then
					arg_59_1.talkMaxDuration = var_62_7

					if var_62_7 + var_62_3 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_7 + var_62_3
					end
				end

				arg_59_1.text_.text = var_62_5
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_8 = math.max(var_62_4, arg_59_1.talkMaxDuration)

			if var_62_3 <= arg_59_1.time_ and arg_59_1.time_ < var_62_3 + var_62_8 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_3) / var_62_8

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_3 + var_62_8 and arg_59_1.time_ < var_62_3 + var_62_8 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play113061015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 113061015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play113061016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.375

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_63_1.callingController_:SetSelectedState("normal")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(113061015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 15 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 15)

				if (15 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 15)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play113061016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 113061016
		arg_67_1.duration_ = 6.8

		local var_67_0 = {
			ja = 4.533,
			ko = 4.6,
			zh = 6.8,
			en = 5.266
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
				arg_67_0:Play113061017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1084ui_story = arg_67_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1084ui_story"].transform.position).z)
				arg_67_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1084ui_story"].transform.localEulerAngles = arg_67_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_67_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1084ui_story"].transform.position).z)
				arg_67_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1084ui_story"].transform.localEulerAngles = arg_67_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_1")
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_70_1 = arg_67_1.actors_["1084ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1084ui_story == nil then
				arg_67_1.var_.characterEffect1084ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.2

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1084ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1084ui_story then
				arg_67_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_70_4 = 0
			local var_70_5 = 0.3

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_4 + arg_70_0 then
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

				local var_70_6 = arg_67_1:GetWordFromCfg(113061016)
				local var_70_7 = arg_67_1:FormatText(var_70_6.content)

				arg_67_1.text_.text = var_70_7

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_9 = 12 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 12)

				if (12 <= 0 and var_70_5 or var_70_5 * (utf8.len(var_70_7) / 12)) > 0 and var_70_5 < var_70_9 then
					arg_67_1.talkMaxDuration = var_70_9

					if var_70_9 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_9 + var_70_4
					end
				end

				arg_67_1.text_.text = var_70_7
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061016", "story_v_out_113061.awb") ~= 0 then
					local var_70_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061016", "story_v_out_113061.awb") / 1000

					if var_70_10 + var_70_4 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_10 + var_70_4
					end

					if var_70_6.prefab_name ~= "" and arg_67_1.actors_[var_70_6.prefab_name] ~= nil then
						local var_70_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_6.prefab_name].transform, "story_v_out_113061", "113061016", "story_v_out_113061.awb")

						arg_67_1:RecordAudio("113061016", var_70_11)
						arg_67_1:RecordAudio("113061016", var_70_11)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_113061", "113061016", "story_v_out_113061.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_113061", "113061016", "story_v_out_113061.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_12 = math.max(var_70_5, arg_67_1.talkMaxDuration)

			if var_70_4 <= arg_67_1.time_ and arg_67_1.time_ < var_70_4 + var_70_12 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_4) / var_70_12

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_4 + var_70_12 and arg_67_1.time_ < var_70_4 + var_70_12 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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
	Play113061017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 113061017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play113061018(arg_71_1)
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

			local var_74_1 = 0
			local var_74_2 = 0.125

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, true)
				arg_71_1.iconController_:SetSelectedState("hero")

				arg_71_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_71_1.callingController_:SetSelectedState("normal")

				arg_71_1.keyicon_.color = Color.New(1, 1, 1)
				arg_71_1.icon_.color = Color.New(1, 1, 1)

				local var_74_3 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(113061017).content)

				arg_71_1.text_.text = var_74_3

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_5 = 5 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 5)

				if (5 <= 0 and var_74_2 or var_74_2 * (utf8.len(var_74_3) / 5)) > 0 and var_74_2 < var_74_5 then
					arg_71_1.talkMaxDuration = var_74_5

					if var_74_5 + var_74_1 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_5 + var_74_1
					end
				end

				arg_71_1.text_.text = var_74_3
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_6 = math.max(var_74_2, arg_71_1.talkMaxDuration)

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_6 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_1) / var_74_6

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_1 + var_74_6 and arg_71_1.time_ < var_74_1 + var_74_6 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play113061018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 113061018
		arg_75_1.duration_ = 5.87

		local var_75_0 = {
			ja = 3.1,
			ko = 5.866,
			zh = 4.366,
			en = 4.766
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
				arg_75_0:Play113061019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_78_0 = arg_75_1.actors_["1084ui_story"]

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1084ui_story == nil then
				arg_75_1.var_.characterEffect1084ui_story = var_78_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_78_1 = 0.2

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_1 and not isNil(var_78_0) then
				if arg_75_1.var_.characterEffect1084ui_story and not isNil(var_78_0) then
					arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_75_1.time_ >= 0 + var_78_1 and arg_75_1.time_ < 0 + var_78_1 + arg_78_0 and not isNil(var_78_0) and arg_75_1.var_.characterEffect1084ui_story then
				arg_75_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_78_3 = 0
			local var_78_4 = 0.45

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				arg_75_1.leftNameTxt_.text = arg_75_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:GetWordFromCfg(113061018)
				local var_78_6 = arg_75_1:FormatText(var_78_5.content)

				arg_75_1.text_.text = var_78_6

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_8 = 18 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_6) / 18)

				if (18 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_6) / 18)) > 0 and var_78_4 < var_78_8 then
					arg_75_1.talkMaxDuration = var_78_8

					if var_78_8 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_6
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061018", "story_v_out_113061.awb") ~= 0 then
					local var_78_9 = manager.audio:GetVoiceLength("story_v_out_113061", "113061018", "story_v_out_113061.awb") / 1000

					if var_78_9 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_9 + var_78_3
					end

					if var_78_5.prefab_name ~= "" and arg_75_1.actors_[var_78_5.prefab_name] ~= nil then
						local var_78_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_5.prefab_name].transform, "story_v_out_113061", "113061018", "story_v_out_113061.awb")

						arg_75_1:RecordAudio("113061018", var_78_10)
						arg_75_1:RecordAudio("113061018", var_78_10)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_113061", "113061018", "story_v_out_113061.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_113061", "113061018", "story_v_out_113061.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_11 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_11 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_11

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_11 and arg_75_1.time_ < var_78_3 + var_78_11 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {}

		arg_75_1:InitPlayNodeList()
	end,
	Play113061019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 113061019
		arg_79_1.duration_ = 8.5

		local var_79_0 = {
			ja = 7.8,
			ko = 6.5,
			zh = 6.133,
			en = 8.5
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
				arg_79_0:Play113061020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_82_0 = 0
			local var_82_1 = 0.5

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_0 + arg_82_0 then
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

				local var_82_2 = arg_79_1:GetWordFromCfg(113061019)
				local var_82_3 = arg_79_1:FormatText(var_82_2.content)

				arg_79_1.text_.text = var_82_3

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_5 = 20 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 20)

				if (20 <= 0 and var_82_1 or var_82_1 * (utf8.len(var_82_3) / 20)) > 0 and var_82_1 < var_82_5 then
					arg_79_1.talkMaxDuration = var_82_5

					if var_82_5 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_5 + var_82_0
					end
				end

				arg_79_1.text_.text = var_82_3
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061019", "story_v_out_113061.awb") ~= 0 then
					local var_82_6 = manager.audio:GetVoiceLength("story_v_out_113061", "113061019", "story_v_out_113061.awb") / 1000

					if var_82_6 + var_82_0 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_6 + var_82_0
					end

					if var_82_2.prefab_name ~= "" and arg_79_1.actors_[var_82_2.prefab_name] ~= nil then
						local var_82_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_2.prefab_name].transform, "story_v_out_113061", "113061019", "story_v_out_113061.awb")

						arg_79_1:RecordAudio("113061019", var_82_7)
						arg_79_1:RecordAudio("113061019", var_82_7)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_113061", "113061019", "story_v_out_113061.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_113061", "113061019", "story_v_out_113061.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_8 = math.max(var_82_1, arg_79_1.talkMaxDuration)

			if var_82_0 <= arg_79_1.time_ and arg_79_1.time_ < var_82_0 + var_82_8 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_0) / var_82_8

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_0 + var_82_8 and arg_79_1.time_ < var_82_0 + var_82_8 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {}

		arg_79_1:InitPlayNodeList()
	end,
	Play113061020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 113061020
		arg_83_1.duration_ = 4.83

		local var_83_0 = {
			ja = 4.666,
			ko = 2.833,
			zh = 3.8,
			en = 4.833
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
				arg_83_0:Play113061021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1084ui_story = arg_83_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_86_0 = 0.5

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_0 then
				arg_83_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_83_1.time_ - 0) / var_86_0)
				arg_83_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).z)
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles = arg_83_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_0 and arg_83_1.time_ < 0 + var_86_0 + arg_86_0 then
				arg_83_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_83_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_83_1.actors_["1084ui_story"].transform.position).z)
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_83_1.actors_["1084ui_story"].transform.localEulerAngles = arg_83_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_86_1 = "1038ui_story"

			if arg_83_1.actors_["1038ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1038ui_story"))) then
				local var_86_2 = Object.Instantiate(Asset.Load("Char/" .. "1038ui_story"), arg_83_1.stage_.transform)

				var_86_2.name = var_86_1
				var_86_2.transform.localPosition = Vector3.New(0, 100, 0)
				arg_83_1.actors_[var_86_1] = var_86_2

				local var_86_3 = var_86_2:GetComponentInChildren(typeof(CharacterEffect))

				var_86_3.enabled = true

				local var_86_4 = GameObjectTools.GetOrAddComponent(var_86_2, typeof(DynamicBoneHelper))

				if var_86_4 then
					var_86_4:EnableDynamicBone(false)
				end

				arg_83_1:ShowWeapon(var_86_3.transform, false)

				arg_83_1.var_[var_86_1 .. "Animator"] = var_86_3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_83_1.var_[var_86_1 .. "Animator"].applyRootMotion = true
				arg_83_1.var_[var_86_1 .. "LipSync"] = var_86_3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_86_5 = arg_83_1.actors_["1038ui_story"].transform

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.var_.moveOldPos1038ui_story = var_86_5.localPosition
			end

			local var_86_6 = 0.001

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_6 then
				var_86_5.localPosition = Vector3.Lerp(arg_83_1.var_.moveOldPos1038ui_story, Vector3.New(0.7, -1.11, -5.9), (arg_83_1.time_ - 0) / var_86_6)
				var_86_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_5.position).x, (manager.ui.mainCamera.transform.position - var_86_5.position).y, (manager.ui.mainCamera.transform.position - var_86_5.position).z)
				var_86_5.localEulerAngles.z = 0
				var_86_5.localEulerAngles.x = 0
				var_86_5.localEulerAngles = var_86_5.localEulerAngles
			end

			if arg_83_1.time_ >= 0 + var_86_6 and arg_83_1.time_ < 0 + var_86_6 + arg_86_0 then
				var_86_5.localPosition = Vector3.New(0.7, -1.11, -5.9)
				var_86_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_86_5.position).x, (manager.ui.mainCamera.transform.position - var_86_5.position).y, (manager.ui.mainCamera.transform.position - var_86_5.position).z)
				var_86_5.localEulerAngles.z = 0
				var_86_5.localEulerAngles.x = 0
				var_86_5.localEulerAngles = var_86_5.localEulerAngles
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action1_1")
			end

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_86_7 = arg_83_1.actors_["1038ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.characterEffect1038ui_story == nil then
				arg_83_1.var_.characterEffect1038ui_story = var_86_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_8 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_8 and not isNil(var_86_7) then
				if arg_83_1.var_.characterEffect1038ui_story and not isNil(var_86_7) then
					arg_83_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_83_1.time_ >= 0 + var_86_8 and arg_83_1.time_ < 0 + var_86_8 + arg_86_0 and not isNil(var_86_7) and arg_83_1.var_.characterEffect1038ui_story then
				arg_83_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_86_10 = arg_83_1.actors_["1084ui_story"]

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 and not isNil(var_86_10) and arg_83_1.var_.characterEffect1084ui_story == nil then
				arg_83_1.var_.characterEffect1084ui_story = var_86_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_86_11 = 0.2

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_11 and not isNil(var_86_10) then
				if arg_83_1.var_.characterEffect1084ui_story and not isNil(var_86_10) then
					arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_83_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_83_1.time_ - 0) / var_86_11)
				end
			end

			if arg_83_1.time_ >= 0 + var_86_11 and arg_83_1.time_ < 0 + var_86_11 + arg_86_0 and not isNil(var_86_10) and arg_83_1.var_.characterEffect1084ui_story then
				arg_83_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_83_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_86_12 = 0
			local var_86_13 = 0.425

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_12 + arg_86_0 then
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

				local var_86_14 = arg_83_1:GetWordFromCfg(113061020)
				local var_86_15 = arg_83_1:FormatText(var_86_14.content)

				arg_83_1.text_.text = var_86_15

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_17 = 17 <= 0 and var_86_13 or var_86_13 * (utf8.len(var_86_15) / 17)

				if (17 <= 0 and var_86_13 or var_86_13 * (utf8.len(var_86_15) / 17)) > 0 and var_86_13 < var_86_17 then
					arg_83_1.talkMaxDuration = var_86_17

					if var_86_17 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_17 + var_86_12
					end
				end

				arg_83_1.text_.text = var_86_15
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061020", "story_v_out_113061.awb") ~= 0 then
					local var_86_18 = manager.audio:GetVoiceLength("story_v_out_113061", "113061020", "story_v_out_113061.awb") / 1000

					if var_86_18 + var_86_12 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_18 + var_86_12
					end

					if var_86_14.prefab_name ~= "" and arg_83_1.actors_[var_86_14.prefab_name] ~= nil then
						local var_86_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_14.prefab_name].transform, "story_v_out_113061", "113061020", "story_v_out_113061.awb")

						arg_83_1:RecordAudio("113061020", var_86_19)
						arg_83_1:RecordAudio("113061020", var_86_19)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_113061", "113061020", "story_v_out_113061.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_113061", "113061020", "story_v_out_113061.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_20 = math.max(var_86_13, arg_83_1.talkMaxDuration)

			if var_86_12 <= arg_83_1.time_ and arg_83_1.time_ < var_86_12 + var_86_20 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_12) / var_86_20

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_12 + var_86_20 and arg_83_1.time_ < var_86_12 + var_86_20 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1084ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.5,
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

		arg_83_1:InitPlayNodeList()
	end,
	Play113061021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 113061021
		arg_87_1.duration_ = 11.3

		local var_87_0 = {
			ja = 11.3,
			ko = 6.733,
			zh = 6.1,
			en = 9.133
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
				arg_87_0:Play113061022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(arg_87_1.actors_["1038ui_story"]) and arg_87_1.var_.characterEffect1038ui_story == nil then
				arg_87_1.var_.characterEffect1038ui_story = arg_87_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_0 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_0 and not isNil(arg_87_1.actors_["1038ui_story"]) then
				if arg_87_1.var_.characterEffect1038ui_story and not isNil(arg_87_1.actors_["1038ui_story"]) then
					arg_87_1.var_.characterEffect1038ui_story.fillFlat = true
					arg_87_1.var_.characterEffect1038ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_87_1.time_ - 0) / var_90_0)
				end
			end

			if arg_87_1.time_ >= 0 + var_90_0 and arg_87_1.time_ < 0 + var_90_0 + arg_90_0 and not isNil(arg_87_1.actors_["1038ui_story"]) and arg_87_1.var_.characterEffect1038ui_story then
				arg_87_1.var_.characterEffect1038ui_story.fillFlat = true
				arg_87_1.var_.characterEffect1038ui_story.fillRatio = 0.5
			end

			local var_90_1 = arg_87_1.actors_["1084ui_story"]

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1084ui_story == nil then
				arg_87_1.var_.characterEffect1084ui_story = var_90_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_2 = 0.2

			if 0 <= arg_87_1.time_ and arg_87_1.time_ < 0 + var_90_2 and not isNil(var_90_1) then
				if arg_87_1.var_.characterEffect1084ui_story and not isNil(var_90_1) then
					arg_87_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= 0 + var_90_2 and arg_87_1.time_ < 0 + var_90_2 + arg_90_0 and not isNil(var_90_1) and arg_87_1.var_.characterEffect1084ui_story then
				arg_87_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action476")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_90_4 = 0
			local var_90_5 = 0.575

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_4 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_6 = arg_87_1:GetWordFromCfg(113061021)
				local var_90_7 = arg_87_1:FormatText(var_90_6.content)

				arg_87_1.text_.text = var_90_7

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_9 = 23 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 23)

				if (23 <= 0 and var_90_5 or var_90_5 * (utf8.len(var_90_7) / 23)) > 0 and var_90_5 < var_90_9 then
					arg_87_1.talkMaxDuration = var_90_9

					if var_90_9 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_9 + var_90_4
					end
				end

				arg_87_1.text_.text = var_90_7
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061021", "story_v_out_113061.awb") ~= 0 then
					local var_90_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061021", "story_v_out_113061.awb") / 1000

					if var_90_10 + var_90_4 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_10 + var_90_4
					end

					if var_90_6.prefab_name ~= "" and arg_87_1.actors_[var_90_6.prefab_name] ~= nil then
						local var_90_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_6.prefab_name].transform, "story_v_out_113061", "113061021", "story_v_out_113061.awb")

						arg_87_1:RecordAudio("113061021", var_90_11)
						arg_87_1:RecordAudio("113061021", var_90_11)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_113061", "113061021", "story_v_out_113061.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_113061", "113061021", "story_v_out_113061.awb")
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

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play113061022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 113061022
		arg_91_1.duration_ = 6.8

		local var_91_0 = {
			ja = 6.533,
			ko = 6.8,
			zh = 5.9,
			en = 6.033
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
				arg_91_0:Play113061023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(arg_91_1.actors_["1038ui_story"]) and arg_91_1.var_.characterEffect1038ui_story == nil then
				arg_91_1.var_.characterEffect1038ui_story = arg_91_1.actors_["1038ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_0 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_0 and not isNil(arg_91_1.actors_["1038ui_story"]) then
				if arg_91_1.var_.characterEffect1038ui_story and not isNil(arg_91_1.actors_["1038ui_story"]) then
					arg_91_1.var_.characterEffect1038ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 0 + var_94_0 and arg_91_1.time_ < 0 + var_94_0 + arg_94_0 and not isNil(arg_91_1.actors_["1038ui_story"]) and arg_91_1.var_.characterEffect1038ui_story then
				arg_91_1.var_.characterEffect1038ui_story.fillFlat = false
			end

			local var_94_2 = arg_91_1.actors_["1084ui_story"]

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect1084ui_story == nil then
				arg_91_1.var_.characterEffect1084ui_story = var_94_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_3 = 0.2

			if 0 <= arg_91_1.time_ and arg_91_1.time_ < 0 + var_94_3 and not isNil(var_94_2) then
				if arg_91_1.var_.characterEffect1084ui_story and not isNil(var_94_2) then
					arg_91_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_91_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_91_1.time_ - 0) / var_94_3)
				end
			end

			if arg_91_1.time_ >= 0 + var_94_3 and arg_91_1.time_ < 0 + var_94_3 + arg_94_0 and not isNil(var_94_2) and arg_91_1.var_.characterEffect1084ui_story then
				arg_91_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_91_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/story1038/story1038action/1038action5_1")
			end

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= 0 + arg_94_0 then
				arg_91_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_94_4 = 0
			local var_94_5 = 0.65

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0
				arg_91_1.dialogCg_.alpha = 1

				arg_91_1.dialog_:SetActive(true)
				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[94].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_6 = arg_91_1:GetWordFromCfg(113061022)
				local var_94_7 = arg_91_1:FormatText(var_94_6.content)

				arg_91_1.text_.text = var_94_7

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_9 = 25 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 25)

				if (25 <= 0 and var_94_5 or var_94_5 * (utf8.len(var_94_7) / 25)) > 0 and var_94_5 < var_94_9 then
					arg_91_1.talkMaxDuration = var_94_9

					if var_94_9 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_9 + var_94_4
					end
				end

				arg_91_1.text_.text = var_94_7
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061022", "story_v_out_113061.awb") ~= 0 then
					local var_94_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061022", "story_v_out_113061.awb") / 1000

					if var_94_10 + var_94_4 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_10 + var_94_4
					end

					if var_94_6.prefab_name ~= "" and arg_91_1.actors_[var_94_6.prefab_name] ~= nil then
						local var_94_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_6.prefab_name].transform, "story_v_out_113061", "113061022", "story_v_out_113061.awb")

						arg_91_1:RecordAudio("113061022", var_94_11)
						arg_91_1:RecordAudio("113061022", var_94_11)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_113061", "113061022", "story_v_out_113061.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_113061", "113061022", "story_v_out_113061.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_12 = math.max(var_94_5, arg_91_1.talkMaxDuration)

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_12 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_4) / var_94_12

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_4 + var_94_12 and arg_91_1.time_ < var_94_4 + var_94_12 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {}

		arg_91_1:InitPlayNodeList()
	end,
	Play113061023 = function(arg_95_0, arg_95_1)
		arg_95_1.time_ = 0
		arg_95_1.frameCnt_ = 0
		arg_95_1.state_ = "playing"
		arg_95_1.curTalkId_ = 113061023
		arg_95_1.duration_ = 7.1

		local var_95_0 = {
			ja = 4.1,
			ko = 7.1,
			zh = 4.6,
			en = 7
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
				arg_95_0:Play113061024(arg_95_1)
			end
		end

		function arg_95_1.onSingleLineUpdate_(arg_98_0)
			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1038ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= 0 + arg_98_0 then
				arg_95_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_98_0 = 0
			local var_98_1 = 0.625

			if 0 < arg_95_1.time_ and arg_95_1.time_ <= var_98_0 + arg_98_0 then
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

				local var_98_2 = arg_95_1:GetWordFromCfg(113061023)
				local var_98_3 = arg_95_1:FormatText(var_98_2.content)

				arg_95_1.text_.text = var_98_3

				LuaForUtil.ClearLinePrefixSymbol(arg_95_1.text_)

				local var_98_5 = 24 <= 0 and var_98_1 or var_98_1 * (utf8.len(var_98_3) / 24)

				if (24 <= 0 and var_98_1 or var_98_1 * (utf8.len(var_98_3) / 24)) > 0 and var_98_1 < var_98_5 then
					arg_95_1.talkMaxDuration = var_98_5

					if var_98_5 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_5 + var_98_0
					end
				end

				arg_95_1.text_.text = var_98_3
				arg_95_1.typewritter.percent = 0

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061023", "story_v_out_113061.awb") ~= 0 then
					local var_98_6 = manager.audio:GetVoiceLength("story_v_out_113061", "113061023", "story_v_out_113061.awb") / 1000

					if var_98_6 + var_98_0 > arg_95_1.duration_ then
						arg_95_1.duration_ = var_98_6 + var_98_0
					end

					if var_98_2.prefab_name ~= "" and arg_95_1.actors_[var_98_2.prefab_name] ~= nil then
						local var_98_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_95_1.actors_[var_98_2.prefab_name].transform, "story_v_out_113061", "113061023", "story_v_out_113061.awb")

						arg_95_1:RecordAudio("113061023", var_98_7)
						arg_95_1:RecordAudio("113061023", var_98_7)
					else
						arg_95_1:AudioAction("play", "voice", "story_v_out_113061", "113061023", "story_v_out_113061.awb")
					end

					arg_95_1:RecordHistoryTalkVoice("story_v_out_113061", "113061023", "story_v_out_113061.awb")
				end

				arg_95_1:RecordContent(arg_95_1.text_.text)
			end

			local var_98_8 = math.max(var_98_1, arg_95_1.talkMaxDuration)

			if var_98_0 <= arg_95_1.time_ and arg_95_1.time_ < var_98_0 + var_98_8 then
				arg_95_1.typewritter.percent = (arg_95_1.time_ - var_98_0) / var_98_8

				arg_95_1.typewritter:SetDirty()
			end

			if arg_95_1.time_ >= var_98_0 + var_98_8 and arg_95_1.time_ < var_98_0 + var_98_8 + arg_98_0 then
				arg_95_1.typewritter.percent = 1

				arg_95_1.typewritter:SetDirty()
				arg_95_1:ShowNextGo(true)
			end
		end

		arg_95_1.nodeConfigList_ = {}

		arg_95_1:InitPlayNodeList()
	end,
	Play113061024 = function(arg_99_0, arg_99_1)
		arg_99_1.time_ = 0
		arg_99_1.frameCnt_ = 0
		arg_99_1.state_ = "playing"
		arg_99_1.curTalkId_ = 113061024
		arg_99_1.duration_ = 5

		SetActive(arg_99_1.tipsGo_, false)

		function arg_99_1.onSingleLineFinish_()
			arg_99_1.onSingleLineUpdate_ = nil
			arg_99_1.onSingleLineFinish_ = nil
			arg_99_1.state_ = "waiting"
		end

		function arg_99_1.playNext_(arg_101_0)
			if arg_101_0 == 1 then
				arg_99_0:Play113061025(arg_99_1)
			end
		end

		function arg_99_1.onSingleLineUpdate_(arg_102_0)
			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1084ui_story = arg_99_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_102_0 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_0 then
				arg_99_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_0)
				arg_99_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).z)
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles = arg_99_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_0 and arg_99_1.time_ < 0 + var_102_0 + arg_102_0 then
				arg_99_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_99_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_99_1.actors_["1084ui_story"].transform.position).z)
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_99_1.actors_["1084ui_story"].transform.localEulerAngles = arg_99_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_102_1 = arg_99_1.actors_["1038ui_story"].transform

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= 0 + arg_102_0 then
				arg_99_1.var_.moveOldPos1038ui_story = var_102_1.localPosition
			end

			local var_102_2 = 0.001

			if 0 <= arg_99_1.time_ and arg_99_1.time_ < 0 + var_102_2 then
				var_102_1.localPosition = Vector3.Lerp(arg_99_1.var_.moveOldPos1038ui_story, Vector3.New(0, 100, 0), (arg_99_1.time_ - 0) / var_102_2)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			if arg_99_1.time_ >= 0 + var_102_2 and arg_99_1.time_ < 0 + var_102_2 + arg_102_0 then
				var_102_1.localPosition = Vector3.New(0, 100, 0)
				var_102_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_102_1.position).x, (manager.ui.mainCamera.transform.position - var_102_1.position).y, (manager.ui.mainCamera.transform.position - var_102_1.position).z)
				var_102_1.localEulerAngles.z = 0
				var_102_1.localEulerAngles.x = 0
				var_102_1.localEulerAngles = var_102_1.localEulerAngles
			end

			local var_102_3 = 0
			local var_102_4 = 0.725

			if 0 < arg_99_1.time_ and arg_99_1.time_ <= var_102_3 + arg_102_0 then
				arg_99_1.talkMaxDuration = 0
				arg_99_1.dialogCg_.alpha = 1

				arg_99_1.dialog_:SetActive(true)
				SetActive(arg_99_1.leftNameGo_, false)

				arg_99_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_99_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_99_1:RecordName(arg_99_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_99_1.iconTrs_.gameObject, false)
				arg_99_1.callingController_:SetSelectedState("normal")

				local var_102_5 = arg_99_1:FormatText(arg_99_1:GetWordFromCfg(113061024).content)

				arg_99_1.text_.text = var_102_5

				LuaForUtil.ClearLinePrefixSymbol(arg_99_1.text_)

				local var_102_7 = 29 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 29)

				if (29 <= 0 and var_102_4 or var_102_4 * (utf8.len(var_102_5) / 29)) > 0 and var_102_4 < var_102_7 then
					arg_99_1.talkMaxDuration = var_102_7

					if var_102_7 + var_102_3 > arg_99_1.duration_ then
						arg_99_1.duration_ = var_102_7 + var_102_3
					end
				end

				arg_99_1.text_.text = var_102_5
				arg_99_1.typewritter.percent = 0

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(false)
				arg_99_1:RecordContent(arg_99_1.text_.text)
			end

			local var_102_8 = math.max(var_102_4, arg_99_1.talkMaxDuration)

			if var_102_3 <= arg_99_1.time_ and arg_99_1.time_ < var_102_3 + var_102_8 then
				arg_99_1.typewritter.percent = (arg_99_1.time_ - var_102_3) / var_102_8

				arg_99_1.typewritter:SetDirty()
			end

			if arg_99_1.time_ >= var_102_3 + var_102_8 and arg_99_1.time_ < var_102_3 + var_102_8 + arg_102_0 then
				arg_99_1.typewritter.percent = 1

				arg_99_1.typewritter:SetDirty()
				arg_99_1:ShowNextGo(true)
			end
		end

		arg_99_1.nodeConfigList_ = {
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
				actorName = "1038ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_99_1:InitPlayNodeList()
	end,
	Play113061025 = function(arg_103_0, arg_103_1)
		arg_103_1.time_ = 0
		arg_103_1.frameCnt_ = 0
		arg_103_1.state_ = "playing"
		arg_103_1.curTalkId_ = 113061025
		arg_103_1.duration_ = 14.07

		local var_103_0 = {
			ja = 14.066,
			ko = 9.133,
			zh = 8.8,
			en = 8.866
		}
		local var_103_1 = manager.audio:GetLocalizationFlag()

		if var_103_0[var_103_1] ~= nil then
			arg_103_1.duration_ = var_103_0[var_103_1]
		end

		SetActive(arg_103_1.tipsGo_, false)

		function arg_103_1.onSingleLineFinish_()
			arg_103_1.onSingleLineUpdate_ = nil
			arg_103_1.onSingleLineFinish_ = nil
			arg_103_1.state_ = "waiting"
		end

		function arg_103_1.playNext_(arg_105_0)
			if arg_105_0 == 1 then
				arg_103_0:Play113061026(arg_103_1)
			end
		end

		function arg_103_1.onSingleLineUpdate_(arg_106_0)
			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1.var_.moveOldPos1042ui_story = arg_103_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_106_0 = 0.001

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_0 then
				arg_103_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_103_1.var_.moveOldPos1042ui_story, Vector3.New(-0.7, -1.06, -6.2), (arg_103_1.time_ - 0) / var_106_0)
				arg_103_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1042ui_story"].transform.position).z)
				arg_103_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1042ui_story"].transform.localEulerAngles = arg_103_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_103_1.time_ >= 0 + var_106_0 and arg_103_1.time_ < 0 + var_106_0 + arg_106_0 then
				arg_103_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(-0.7, -1.06, -6.2)
				arg_103_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_103_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_103_1.actors_["1042ui_story"].transform.position).z)
				arg_103_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_103_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_103_1.actors_["1042ui_story"].transform.localEulerAngles = arg_103_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action4_1")
			end

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 then
				arg_103_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_106_1 = arg_103_1.actors_["1042ui_story"]

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= 0 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1042ui_story == nil then
				arg_103_1.var_.characterEffect1042ui_story = var_106_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_106_2 = 0.2

			if 0 <= arg_103_1.time_ and arg_103_1.time_ < 0 + var_106_2 and not isNil(var_106_1) then
				if arg_103_1.var_.characterEffect1042ui_story and not isNil(var_106_1) then
					arg_103_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_103_1.time_ >= 0 + var_106_2 and arg_103_1.time_ < 0 + var_106_2 + arg_106_0 and not isNil(var_106_1) and arg_103_1.var_.characterEffect1042ui_story then
				arg_103_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_106_4 = 0
			local var_106_5 = 0.975

			if 0 < arg_103_1.time_ and arg_103_1.time_ <= var_106_4 + arg_106_0 then
				arg_103_1.talkMaxDuration = 0
				arg_103_1.dialogCg_.alpha = 1

				arg_103_1.dialog_:SetActive(true)
				SetActive(arg_103_1.leftNameGo_, true)

				arg_103_1.leftNameTxt_.text = arg_103_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_103_1.leftNameTxt_.transform)

				arg_103_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_103_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_103_1:RecordName(arg_103_1.leftNameTxt_.text)
				SetActive(arg_103_1.iconTrs_.gameObject, false)
				arg_103_1.callingController_:SetSelectedState("normal")

				local var_106_6 = arg_103_1:GetWordFromCfg(113061025)
				local var_106_7 = arg_103_1:FormatText(var_106_6.content)

				arg_103_1.text_.text = var_106_7

				LuaForUtil.ClearLinePrefixSymbol(arg_103_1.text_)

				local var_106_9 = 39 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 39)

				if (39 <= 0 and var_106_5 or var_106_5 * (utf8.len(var_106_7) / 39)) > 0 and var_106_5 < var_106_9 then
					arg_103_1.talkMaxDuration = var_106_9

					if var_106_9 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_9 + var_106_4
					end
				end

				arg_103_1.text_.text = var_106_7
				arg_103_1.typewritter.percent = 0

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061025", "story_v_out_113061.awb") ~= 0 then
					local var_106_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061025", "story_v_out_113061.awb") / 1000

					if var_106_10 + var_106_4 > arg_103_1.duration_ then
						arg_103_1.duration_ = var_106_10 + var_106_4
					end

					if var_106_6.prefab_name ~= "" and arg_103_1.actors_[var_106_6.prefab_name] ~= nil then
						local var_106_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_103_1.actors_[var_106_6.prefab_name].transform, "story_v_out_113061", "113061025", "story_v_out_113061.awb")

						arg_103_1:RecordAudio("113061025", var_106_11)
						arg_103_1:RecordAudio("113061025", var_106_11)
					else
						arg_103_1:AudioAction("play", "voice", "story_v_out_113061", "113061025", "story_v_out_113061.awb")
					end

					arg_103_1:RecordHistoryTalkVoice("story_v_out_113061", "113061025", "story_v_out_113061.awb")
				end

				arg_103_1:RecordContent(arg_103_1.text_.text)
			end

			local var_106_12 = math.max(var_106_5, arg_103_1.talkMaxDuration)

			if var_106_4 <= arg_103_1.time_ and arg_103_1.time_ < var_106_4 + var_106_12 then
				arg_103_1.typewritter.percent = (arg_103_1.time_ - var_106_4) / var_106_12

				arg_103_1.typewritter:SetDirty()
			end

			if arg_103_1.time_ >= var_106_4 + var_106_12 and arg_103_1.time_ < var_106_4 + var_106_12 + arg_106_0 then
				arg_103_1.typewritter.percent = 1

				arg_103_1.typewritter:SetDirty()
				arg_103_1:ShowNextGo(true)
			end
		end

		arg_103_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_103_1:InitPlayNodeList()
	end,
	Play113061026 = function(arg_107_0, arg_107_1)
		arg_107_1.time_ = 0
		arg_107_1.frameCnt_ = 0
		arg_107_1.state_ = "playing"
		arg_107_1.curTalkId_ = 113061026
		arg_107_1.duration_ = 3.7

		local var_107_0 = {
			ja = 3.4,
			ko = 2.733,
			zh = 2.933,
			en = 3.7
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
				arg_107_0:Play113061027(arg_107_1)
			end
		end

		function arg_107_1.onSingleLineUpdate_(arg_110_0)
			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) and arg_107_1.var_.characterEffect1042ui_story == nil then
				arg_107_1.var_.characterEffect1042ui_story = arg_107_1.actors_["1042ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_0 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) then
				if arg_107_1.var_.characterEffect1042ui_story and not isNil(arg_107_1.actors_["1042ui_story"]) then
					arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_107_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_107_1.time_ - 0) / var_110_0)
				end
			end

			if arg_107_1.time_ >= 0 + var_110_0 and arg_107_1.time_ < 0 + var_110_0 + arg_110_0 and not isNil(arg_107_1.actors_["1042ui_story"]) and arg_107_1.var_.characterEffect1042ui_story then
				arg_107_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_107_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_110_1 = arg_107_1.actors_["1084ui_story"].transform

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1.var_.moveOldPos1084ui_story = var_110_1.localPosition
			end

			local var_110_2 = 0.001

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_2 then
				var_110_1.localPosition = Vector3.Lerp(arg_107_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_107_1.time_ - 0) / var_110_2)
				var_110_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_1.position).x, (manager.ui.mainCamera.transform.position - var_110_1.position).y, (manager.ui.mainCamera.transform.position - var_110_1.position).z)
				var_110_1.localEulerAngles.z = 0
				var_110_1.localEulerAngles.x = 0
				var_110_1.localEulerAngles = var_110_1.localEulerAngles
			end

			if arg_107_1.time_ >= 0 + var_110_2 and arg_107_1.time_ < 0 + var_110_2 + arg_110_0 then
				var_110_1.localPosition = Vector3.New(0.7, -0.97, -6)
				var_110_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_110_1.position).x, (manager.ui.mainCamera.transform.position - var_110_1.position).y, (manager.ui.mainCamera.transform.position - var_110_1.position).z)
				var_110_1.localEulerAngles.z = 0
				var_110_1.localEulerAngles.x = 0
				var_110_1.localEulerAngles = var_110_1.localEulerAngles
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action13_1")
			end

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 then
				arg_107_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_110_3 = arg_107_1.actors_["1084ui_story"]

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= 0 + arg_110_0 and not isNil(var_110_3) and arg_107_1.var_.characterEffect1084ui_story == nil then
				arg_107_1.var_.characterEffect1084ui_story = var_110_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_110_4 = 0.2

			if 0 <= arg_107_1.time_ and arg_107_1.time_ < 0 + var_110_4 and not isNil(var_110_3) then
				if arg_107_1.var_.characterEffect1084ui_story and not isNil(var_110_3) then
					arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_107_1.time_ >= 0 + var_110_4 and arg_107_1.time_ < 0 + var_110_4 + arg_110_0 and not isNil(var_110_3) and arg_107_1.var_.characterEffect1084ui_story then
				arg_107_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_110_6 = 0
			local var_110_7 = 0.25

			if 0 < arg_107_1.time_ and arg_107_1.time_ <= var_110_6 + arg_110_0 then
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

				local var_110_8 = arg_107_1:GetWordFromCfg(113061026)
				local var_110_9 = arg_107_1:FormatText(var_110_8.content)

				arg_107_1.text_.text = var_110_9

				LuaForUtil.ClearLinePrefixSymbol(arg_107_1.text_)

				local var_110_11 = 10 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 10)

				if (10 <= 0 and var_110_7 or var_110_7 * (utf8.len(var_110_9) / 10)) > 0 and var_110_7 < var_110_11 then
					arg_107_1.talkMaxDuration = var_110_11

					if var_110_11 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_11 + var_110_6
					end
				end

				arg_107_1.text_.text = var_110_9
				arg_107_1.typewritter.percent = 0

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061026", "story_v_out_113061.awb") ~= 0 then
					local var_110_12 = manager.audio:GetVoiceLength("story_v_out_113061", "113061026", "story_v_out_113061.awb") / 1000

					if var_110_12 + var_110_6 > arg_107_1.duration_ then
						arg_107_1.duration_ = var_110_12 + var_110_6
					end

					if var_110_8.prefab_name ~= "" and arg_107_1.actors_[var_110_8.prefab_name] ~= nil then
						local var_110_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_107_1.actors_[var_110_8.prefab_name].transform, "story_v_out_113061", "113061026", "story_v_out_113061.awb")

						arg_107_1:RecordAudio("113061026", var_110_13)
						arg_107_1:RecordAudio("113061026", var_110_13)
					else
						arg_107_1:AudioAction("play", "voice", "story_v_out_113061", "113061026", "story_v_out_113061.awb")
					end

					arg_107_1:RecordHistoryTalkVoice("story_v_out_113061", "113061026", "story_v_out_113061.awb")
				end

				arg_107_1:RecordContent(arg_107_1.text_.text)
			end

			local var_110_14 = math.max(var_110_7, arg_107_1.talkMaxDuration)

			if var_110_6 <= arg_107_1.time_ and arg_107_1.time_ < var_110_6 + var_110_14 then
				arg_107_1.typewritter.percent = (arg_107_1.time_ - var_110_6) / var_110_14

				arg_107_1.typewritter:SetDirty()
			end

			if arg_107_1.time_ >= var_110_6 + var_110_14 and arg_107_1.time_ < var_110_6 + var_110_14 + arg_110_0 then
				arg_107_1.typewritter.percent = 1

				arg_107_1.typewritter:SetDirty()
				arg_107_1:ShowNextGo(true)
			end
		end

		arg_107_1.nodeConfigList_ = {
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

		arg_107_1:InitPlayNodeList()
	end,
	Play113061027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 113061027
		arg_111_1.duration_ = 11.4

		local var_111_0 = {
			ja = 10.466,
			ko = 11.4,
			zh = 9.533,
			en = 10.1
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play113061028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) and arg_111_1.var_.characterEffect1084ui_story == nil then
				arg_111_1.var_.characterEffect1084ui_story = arg_111_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_0 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) then
				if arg_111_1.var_.characterEffect1084ui_story and not isNil(arg_111_1.actors_["1084ui_story"]) then
					arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_111_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_111_1.time_ - 0) / var_114_0)
				end
			end

			if arg_111_1.time_ >= 0 + var_114_0 and arg_111_1.time_ < 0 + var_114_0 + arg_114_0 and not isNil(arg_111_1.actors_["1084ui_story"]) and arg_111_1.var_.characterEffect1084ui_story then
				arg_111_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_111_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_114_1 = arg_111_1.actors_["1042ui_story"]

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1042ui_story == nil then
				arg_111_1.var_.characterEffect1042ui_story = var_114_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_2 = 0.2

			if 0 <= arg_111_1.time_ and arg_111_1.time_ < 0 + var_114_2 and not isNil(var_114_1) then
				if arg_111_1.var_.characterEffect1042ui_story and not isNil(var_114_1) then
					arg_111_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= 0 + var_114_2 and arg_111_1.time_ < 0 + var_114_2 + arg_114_0 and not isNil(var_114_1) and arg_111_1.var_.characterEffect1042ui_story then
				arg_111_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042actionlink/1042action442")
			end

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= 0 + arg_114_0 then
				arg_111_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_114_4 = 0
			local var_114_5 = 1.2

			if 0 < arg_111_1.time_ and arg_111_1.time_ <= var_114_4 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				arg_111_1.leftNameTxt_.text = arg_111_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_6 = arg_111_1:GetWordFromCfg(113061027)
				local var_114_7 = arg_111_1:FormatText(var_114_6.content)

				arg_111_1.text_.text = var_114_7

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_9 = 48 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 48)

				if (48 <= 0 and var_114_5 or var_114_5 * (utf8.len(var_114_7) / 48)) > 0 and var_114_5 < var_114_9 then
					arg_111_1.talkMaxDuration = var_114_9

					if var_114_9 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_9 + var_114_4
					end
				end

				arg_111_1.text_.text = var_114_7
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061027", "story_v_out_113061.awb") ~= 0 then
					local var_114_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061027", "story_v_out_113061.awb") / 1000

					if var_114_10 + var_114_4 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_10 + var_114_4
					end

					if var_114_6.prefab_name ~= "" and arg_111_1.actors_[var_114_6.prefab_name] ~= nil then
						local var_114_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_6.prefab_name].transform, "story_v_out_113061", "113061027", "story_v_out_113061.awb")

						arg_111_1:RecordAudio("113061027", var_114_11)
						arg_111_1:RecordAudio("113061027", var_114_11)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_113061", "113061027", "story_v_out_113061.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_113061", "113061027", "story_v_out_113061.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_12 = math.max(var_114_5, arg_111_1.talkMaxDuration)

			if var_114_4 <= arg_111_1.time_ and arg_111_1.time_ < var_114_4 + var_114_12 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_4) / var_114_12

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_4 + var_114_12 and arg_111_1.time_ < var_114_4 + var_114_12 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end

		arg_111_1.nodeConfigList_ = {}

		arg_111_1:InitPlayNodeList()
	end,
	Play113061028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 113061028
		arg_115_1.duration_ = 17

		local var_115_0 = {
			ja = 17,
			ko = 9.1,
			zh = 8.3,
			en = 11
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
				arg_115_0:Play113061029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			if 0 < arg_115_1.time_ and arg_115_1.time_ <= 0 + arg_118_0 then
				arg_115_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_118_0 = 0
			local var_118_1 = 1

			if 0 < arg_115_1.time_ and arg_115_1.time_ <= var_118_0 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, true)

				arg_115_1.leftNameTxt_.text = arg_115_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_115_1.leftNameTxt_.transform)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1.leftNameTxt_.text)
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_2 = arg_115_1:GetWordFromCfg(113061028)
				local var_118_3 = arg_115_1:FormatText(var_118_2.content)

				arg_115_1.text_.text = var_118_3

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_5 = 40 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 40)

				if (40 <= 0 and var_118_1 or var_118_1 * (utf8.len(var_118_3) / 40)) > 0 and var_118_1 < var_118_5 then
					arg_115_1.talkMaxDuration = var_118_5

					if var_118_5 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_5 + var_118_0
					end
				end

				arg_115_1.text_.text = var_118_3
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061028", "story_v_out_113061.awb") ~= 0 then
					local var_118_6 = manager.audio:GetVoiceLength("story_v_out_113061", "113061028", "story_v_out_113061.awb") / 1000

					if var_118_6 + var_118_0 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_6 + var_118_0
					end

					if var_118_2.prefab_name ~= "" and arg_115_1.actors_[var_118_2.prefab_name] ~= nil then
						local var_118_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_115_1.actors_[var_118_2.prefab_name].transform, "story_v_out_113061", "113061028", "story_v_out_113061.awb")

						arg_115_1:RecordAudio("113061028", var_118_7)
						arg_115_1:RecordAudio("113061028", var_118_7)
					else
						arg_115_1:AudioAction("play", "voice", "story_v_out_113061", "113061028", "story_v_out_113061.awb")
					end

					arg_115_1:RecordHistoryTalkVoice("story_v_out_113061", "113061028", "story_v_out_113061.awb")
				end

				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_8 = math.max(var_118_1, arg_115_1.talkMaxDuration)

			if var_118_0 <= arg_115_1.time_ and arg_115_1.time_ < var_118_0 + var_118_8 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_0) / var_118_8

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_0 + var_118_8 and arg_115_1.time_ < var_118_0 + var_118_8 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end

		arg_115_1.nodeConfigList_ = {}

		arg_115_1:InitPlayNodeList()
	end,
	Play113061029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 113061029
		arg_119_1.duration_ = 8.5

		local var_119_0 = {
			ja = 8.5,
			ko = 4.533,
			zh = 3.766,
			en = 3.7
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
				arg_119_0:Play113061030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			if 0 < arg_119_1.time_ and arg_119_1.time_ <= 0 + arg_122_0 then
				arg_119_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_122_0 = 0
			local var_122_1 = 0.4

			if 0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, true)

				arg_119_1.leftNameTxt_.text = arg_119_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_119_1.leftNameTxt_.transform)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1.leftNameTxt_.text)
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(113061029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_5 = 16 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_3) / 16)

				if (16 <= 0 and var_122_1 or var_122_1 * (utf8.len(var_122_3) / 16)) > 0 and var_122_1 < var_122_5 then
					arg_119_1.talkMaxDuration = var_122_5

					if var_122_5 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_5 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061029", "story_v_out_113061.awb") ~= 0 then
					local var_122_6 = manager.audio:GetVoiceLength("story_v_out_113061", "113061029", "story_v_out_113061.awb") / 1000

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end

					if var_122_2.prefab_name ~= "" and arg_119_1.actors_[var_122_2.prefab_name] ~= nil then
						local var_122_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_119_1.actors_[var_122_2.prefab_name].transform, "story_v_out_113061", "113061029", "story_v_out_113061.awb")

						arg_119_1:RecordAudio("113061029", var_122_7)
						arg_119_1:RecordAudio("113061029", var_122_7)
					else
						arg_119_1:AudioAction("play", "voice", "story_v_out_113061", "113061029", "story_v_out_113061.awb")
					end

					arg_119_1:RecordHistoryTalkVoice("story_v_out_113061", "113061029", "story_v_out_113061.awb")
				end

				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_8 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_8 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_8

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_8 and arg_119_1.time_ < var_122_0 + var_122_8 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end

		arg_119_1.nodeConfigList_ = {}

		arg_119_1:InitPlayNodeList()
	end,
	Play113061030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 113061030
		arg_123_1.duration_ = 8.1

		local var_123_0 = {
			ja = 8.1,
			ko = 7.2,
			zh = 7.733,
			en = 7.3
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
				arg_123_0:Play113061031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084actionlink/1084action4136")
			end

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 then
				arg_123_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_126_0 = arg_123_1.actors_["1084ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1084ui_story == nil then
				arg_123_1.var_.characterEffect1084ui_story = var_126_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_1 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_1 and not isNil(var_126_0) then
				if arg_123_1.var_.characterEffect1084ui_story and not isNil(var_126_0) then
					arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_123_1.time_ >= 0 + var_126_1 and arg_123_1.time_ < 0 + var_126_1 + arg_126_0 and not isNil(var_126_0) and arg_123_1.var_.characterEffect1084ui_story then
				arg_123_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_126_3 = arg_123_1.actors_["1042ui_story"]

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= 0 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect1042ui_story == nil then
				arg_123_1.var_.characterEffect1042ui_story = var_126_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_126_4 = 0.2

			if 0 <= arg_123_1.time_ and arg_123_1.time_ < 0 + var_126_4 and not isNil(var_126_3) then
				if arg_123_1.var_.characterEffect1042ui_story and not isNil(var_126_3) then
					arg_123_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_123_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_123_1.time_ - 0) / var_126_4)
				end
			end

			if arg_123_1.time_ >= 0 + var_126_4 and arg_123_1.time_ < 0 + var_126_4 + arg_126_0 and not isNil(var_126_3) and arg_123_1.var_.characterEffect1042ui_story then
				arg_123_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_123_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_126_5 = 0
			local var_126_6 = 0.7

			if 0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_5 + arg_126_0 then
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

				local var_126_7 = arg_123_1:GetWordFromCfg(113061030)
				local var_126_8 = arg_123_1:FormatText(var_126_7.content)

				arg_123_1.text_.text = var_126_8

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_10 = 27 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 27)

				if (27 <= 0 and var_126_6 or var_126_6 * (utf8.len(var_126_8) / 27)) > 0 and var_126_6 < var_126_10 then
					arg_123_1.talkMaxDuration = var_126_10

					if var_126_10 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_10 + var_126_5
					end
				end

				arg_123_1.text_.text = var_126_8
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061030", "story_v_out_113061.awb") ~= 0 then
					local var_126_11 = manager.audio:GetVoiceLength("story_v_out_113061", "113061030", "story_v_out_113061.awb") / 1000

					if var_126_11 + var_126_5 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_11 + var_126_5
					end

					if var_126_7.prefab_name ~= "" and arg_123_1.actors_[var_126_7.prefab_name] ~= nil then
						local var_126_12 = LuaForUtil.PlayVoiceWithCriLipsync(arg_123_1.actors_[var_126_7.prefab_name].transform, "story_v_out_113061", "113061030", "story_v_out_113061.awb")

						arg_123_1:RecordAudio("113061030", var_126_12)
						arg_123_1:RecordAudio("113061030", var_126_12)
					else
						arg_123_1:AudioAction("play", "voice", "story_v_out_113061", "113061030", "story_v_out_113061.awb")
					end

					arg_123_1:RecordHistoryTalkVoice("story_v_out_113061", "113061030", "story_v_out_113061.awb")
				end

				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_13 = math.max(var_126_6, arg_123_1.talkMaxDuration)

			if var_126_5 <= arg_123_1.time_ and arg_123_1.time_ < var_126_5 + var_126_13 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_5) / var_126_13

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_5 + var_126_13 and arg_123_1.time_ < var_126_5 + var_126_13 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end

		arg_123_1.nodeConfigList_ = {}

		arg_123_1:InitPlayNodeList()
	end,
	Play113061031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 113061031
		arg_127_1.duration_ = 12.1

		local var_127_0 = {
			ja = 9.233,
			ko = 11.1,
			zh = 12.1,
			en = 10.866
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
				arg_127_0:Play113061032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1042ui_story = arg_127_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_130_0 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_0 then
				arg_127_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_127_1.time_ - 0) / var_130_0)
				arg_127_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1042ui_story"].transform.position).z)
				arg_127_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1042ui_story"].transform.localEulerAngles = arg_127_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_0 and arg_127_1.time_ < 0 + var_130_0 + arg_130_0 then
				arg_127_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_127_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_127_1.actors_["1042ui_story"].transform.position).z)
				arg_127_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_127_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_127_1.actors_["1042ui_story"].transform.localEulerAngles = arg_127_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_130_1 = arg_127_1.actors_["1041ui_story"].transform

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1.var_.moveOldPos1041ui_story = var_130_1.localPosition
			end

			local var_130_2 = 0.001

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_2 then
				var_130_1.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_127_1.time_ - 0) / var_130_2)
				var_130_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_1.position).x, (manager.ui.mainCamera.transform.position - var_130_1.position).y, (manager.ui.mainCamera.transform.position - var_130_1.position).z)
				var_130_1.localEulerAngles.z = 0
				var_130_1.localEulerAngles.x = 0
				var_130_1.localEulerAngles = var_130_1.localEulerAngles
			end

			if arg_127_1.time_ >= 0 + var_130_2 and arg_127_1.time_ < 0 + var_130_2 + arg_130_0 then
				var_130_1.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_130_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_130_1.position).x, (manager.ui.mainCamera.transform.position - var_130_1.position).y, (manager.ui.mainCamera.transform.position - var_130_1.position).z)
				var_130_1.localEulerAngles.z = 0
				var_130_1.localEulerAngles.x = 0
				var_130_1.localEulerAngles = var_130_1.localEulerAngles
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_130_3 = arg_127_1.actors_["1041ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1041ui_story == nil then
				arg_127_1.var_.characterEffect1041ui_story = var_130_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_4 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_4 and not isNil(var_130_3) then
				if arg_127_1.var_.characterEffect1041ui_story and not isNil(var_130_3) then
					arg_127_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= 0 + var_130_4 and arg_127_1.time_ < 0 + var_130_4 + arg_130_0 and not isNil(var_130_3) and arg_127_1.var_.characterEffect1041ui_story then
				arg_127_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 then
				arg_127_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action6_2")
			end

			local var_130_6 = arg_127_1.actors_["1084ui_story"]

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= 0 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1084ui_story == nil then
				arg_127_1.var_.characterEffect1084ui_story = var_130_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_7 = 0.2

			if 0 <= arg_127_1.time_ and arg_127_1.time_ < 0 + var_130_7 and not isNil(var_130_6) then
				if arg_127_1.var_.characterEffect1084ui_story and not isNil(var_130_6) then
					arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_127_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_127_1.time_ - 0) / var_130_7)
				end
			end

			if arg_127_1.time_ >= 0 + var_130_7 and arg_127_1.time_ < 0 + var_130_7 + arg_130_0 and not isNil(var_130_6) and arg_127_1.var_.characterEffect1084ui_story then
				arg_127_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_127_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_130_8 = 0
			local var_130_9 = 1.4

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_8 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				arg_127_1.leftNameTxt_.text = arg_127_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_10 = arg_127_1:GetWordFromCfg(113061031)
				local var_130_11 = arg_127_1:FormatText(var_130_10.content)

				arg_127_1.text_.text = var_130_11

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_13 = 56 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 56)

				if (56 <= 0 and var_130_9 or var_130_9 * (utf8.len(var_130_11) / 56)) > 0 and var_130_9 < var_130_13 then
					arg_127_1.talkMaxDuration = var_130_13

					if var_130_13 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_13 + var_130_8
					end
				end

				arg_127_1.text_.text = var_130_11
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061031", "story_v_out_113061.awb") ~= 0 then
					local var_130_14 = manager.audio:GetVoiceLength("story_v_out_113061", "113061031", "story_v_out_113061.awb") / 1000

					if var_130_14 + var_130_8 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_14 + var_130_8
					end

					if var_130_10.prefab_name ~= "" and arg_127_1.actors_[var_130_10.prefab_name] ~= nil then
						local var_130_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_10.prefab_name].transform, "story_v_out_113061", "113061031", "story_v_out_113061.awb")

						arg_127_1:RecordAudio("113061031", var_130_15)
						arg_127_1:RecordAudio("113061031", var_130_15)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_113061", "113061031", "story_v_out_113061.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_113061", "113061031", "story_v_out_113061.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_16 = math.max(var_130_9, arg_127_1.talkMaxDuration)

			if var_130_8 <= arg_127_1.time_ and arg_127_1.time_ < var_130_8 + var_130_16 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_8) / var_130_16

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_8 + var_130_16 and arg_127_1.time_ < var_130_8 + var_130_16 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_127_1:InitPlayNodeList()
	end,
	Play113061032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 113061032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play113061033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 and not isNil(arg_131_1.actors_["1041ui_story"]) and arg_131_1.var_.characterEffect1041ui_story == nil then
				arg_131_1.var_.characterEffect1041ui_story = arg_131_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_0 = 0.2

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_0 and not isNil(arg_131_1.actors_["1041ui_story"]) then
				if arg_131_1.var_.characterEffect1041ui_story and not isNil(arg_131_1.actors_["1041ui_story"]) then
					arg_131_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_131_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_131_1.time_ - 0) / var_134_0)
				end
			end

			if arg_131_1.time_ >= 0 + var_134_0 and arg_131_1.time_ < 0 + var_134_0 + arg_134_0 and not isNil(arg_131_1.actors_["1041ui_story"]) and arg_131_1.var_.characterEffect1041ui_story then
				arg_131_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_131_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_134_1 = 0
			local var_134_2 = 0.95

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_3 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(113061032).content)

				arg_131_1.text_.text = var_134_3

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_5 = 38 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 38)

				if (38 <= 0 and var_134_2 or var_134_2 * (utf8.len(var_134_3) / 38)) > 0 and var_134_2 < var_134_5 then
					arg_131_1.talkMaxDuration = var_134_5

					if var_134_5 + var_134_1 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_5 + var_134_1
					end
				end

				arg_131_1.text_.text = var_134_3
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_6 = math.max(var_134_2, arg_131_1.talkMaxDuration)

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_6 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_1) / var_134_6

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_1 + var_134_6 and arg_131_1.time_ < var_134_1 + var_134_6 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play113061033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 113061033
		arg_135_1.duration_ = 2.93

		local var_135_0 = {
			ja = 2.933,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_135_0:Play113061034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_138_0 = arg_135_1.actors_["1041ui_story"]

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1041ui_story == nil then
				arg_135_1.var_.characterEffect1041ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_1 = 0.2

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_1 and not isNil(var_138_0) then
				if arg_135_1.var_.characterEffect1041ui_story and not isNil(var_138_0) then
					arg_135_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= 0 + var_138_1 and arg_135_1.time_ < 0 + var_138_1 + arg_138_0 and not isNil(var_138_0) and arg_135_1.var_.characterEffect1041ui_story then
				arg_135_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_138_3 = 0
			local var_138_4 = 0.15

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= var_138_3 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				arg_135_1.leftNameTxt_.text = arg_135_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_5 = arg_135_1:GetWordFromCfg(113061033)
				local var_138_6 = arg_135_1:FormatText(var_138_5.content)

				arg_135_1.text_.text = var_138_6

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_8 = 6 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_6) / 6)

				if (6 <= 0 and var_138_4 or var_138_4 * (utf8.len(var_138_6) / 6)) > 0 and var_138_4 < var_138_8 then
					arg_135_1.talkMaxDuration = var_138_8

					if var_138_8 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_8 + var_138_3
					end
				end

				arg_135_1.text_.text = var_138_6
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061033", "story_v_out_113061.awb") ~= 0 then
					local var_138_9 = manager.audio:GetVoiceLength("story_v_out_113061", "113061033", "story_v_out_113061.awb") / 1000

					if var_138_9 + var_138_3 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_9 + var_138_3
					end

					if var_138_5.prefab_name ~= "" and arg_135_1.actors_[var_138_5.prefab_name] ~= nil then
						local var_138_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_5.prefab_name].transform, "story_v_out_113061", "113061033", "story_v_out_113061.awb")

						arg_135_1:RecordAudio("113061033", var_138_10)
						arg_135_1:RecordAudio("113061033", var_138_10)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_113061", "113061033", "story_v_out_113061.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_113061", "113061033", "story_v_out_113061.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_11 = math.max(var_138_4, arg_135_1.talkMaxDuration)

			if var_138_3 <= arg_135_1.time_ and arg_135_1.time_ < var_138_3 + var_138_11 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_3) / var_138_11

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_3 + var_138_11 and arg_135_1.time_ < var_138_3 + var_138_11 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play113061034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 113061034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play113061035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1041ui_story = arg_139_1.actors_["1041ui_story"].transform.localPosition
			end

			local var_142_0 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 then
				arg_139_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_0)
				arg_139_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).z)
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles = arg_139_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 then
				arg_139_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_139_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_139_1.actors_["1041ui_story"].transform.position).z)
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_139_1.actors_["1041ui_story"].transform.localEulerAngles = arg_139_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_142_1 = arg_139_1.actors_["1084ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos1084ui_story = var_142_1.localPosition
			end

			local var_142_2 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_2 then
				var_142_1.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_139_1.time_ - 0) / var_142_2)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_2 and arg_139_1.time_ < 0 + var_142_2 + arg_142_0 then
				var_142_1.localPosition = Vector3.New(0, 100, 0)
				var_142_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_1.position).x, (manager.ui.mainCamera.transform.position - var_142_1.position).y, (manager.ui.mainCamera.transform.position - var_142_1.position).z)
				var_142_1.localEulerAngles.z = 0
				var_142_1.localEulerAngles.x = 0
				var_142_1.localEulerAngles = var_142_1.localEulerAngles
			end

			local var_142_3 = 0
			local var_142_4 = 1.375

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_3 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, false)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_5 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(113061034).content)

				arg_139_1.text_.text = var_142_5

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_7 = 55 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 55)

				if (55 <= 0 and var_142_4 or var_142_4 * (utf8.len(var_142_5) / 55)) > 0 and var_142_4 < var_142_7 then
					arg_139_1.talkMaxDuration = var_142_7

					if var_142_7 + var_142_3 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_7 + var_142_3
					end
				end

				arg_139_1.text_.text = var_142_5
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_8 = math.max(var_142_4, arg_139_1.talkMaxDuration)

			if var_142_3 <= arg_139_1.time_ and arg_139_1.time_ < var_142_3 + var_142_8 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_3) / var_142_8

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_3 + var_142_8 and arg_139_1.time_ < var_142_3 + var_142_8 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
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

		arg_139_1:InitPlayNodeList()
	end,
	Play113061035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 113061035
		arg_143_1.duration_ = 4.5

		local var_143_0 = {
			ja = 3.866,
			ko = 4.5,
			zh = 2.866,
			en = 2.933
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
				arg_143_0:Play113061036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1097ui_story = arg_143_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_146_0 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 then
				arg_143_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1097ui_story, Vector3.New(-0.7, -0.54, -6.3), (arg_143_1.time_ - 0) / var_146_0)
				arg_143_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1097ui_story"].transform.position).z)
				arg_143_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1097ui_story"].transform.localEulerAngles = arg_143_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 then
				arg_143_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(-0.7, -0.54, -6.3)
				arg_143_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_143_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_143_1.actors_["1097ui_story"].transform.position).z)
				arg_143_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_143_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_143_1.actors_["1097ui_story"].transform.localEulerAngles = arg_143_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_146_1 = arg_143_1.actors_["1097ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1097ui_story == nil then
				arg_143_1.var_.characterEffect1097ui_story = var_146_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_2 = 0.2

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_2 and not isNil(var_146_1) then
				if arg_143_1.var_.characterEffect1097ui_story and not isNil(var_146_1) then
					arg_143_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_2 and arg_143_1.time_ < 0 + var_146_2 + arg_146_0 and not isNil(var_146_1) and arg_143_1.var_.characterEffect1097ui_story then
				arg_143_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_146_4 = 0
			local var_146_5 = 0.25

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_4 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_6 = arg_143_1:GetWordFromCfg(113061035)
				local var_146_7 = arg_143_1:FormatText(var_146_6.content)

				arg_143_1.text_.text = var_146_7

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_9 = 10 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 10)

				if (10 <= 0 and var_146_5 or var_146_5 * (utf8.len(var_146_7) / 10)) > 0 and var_146_5 < var_146_9 then
					arg_143_1.talkMaxDuration = var_146_9

					if var_146_9 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_4
					end
				end

				arg_143_1.text_.text = var_146_7
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061035", "story_v_out_113061.awb") ~= 0 then
					local var_146_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061035", "story_v_out_113061.awb") / 1000

					if var_146_10 + var_146_4 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_4
					end

					if var_146_6.prefab_name ~= "" and arg_143_1.actors_[var_146_6.prefab_name] ~= nil then
						local var_146_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_6.prefab_name].transform, "story_v_out_113061", "113061035", "story_v_out_113061.awb")

						arg_143_1:RecordAudio("113061035", var_146_11)
						arg_143_1:RecordAudio("113061035", var_146_11)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_113061", "113061035", "story_v_out_113061.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_113061", "113061035", "story_v_out_113061.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_12 = math.max(var_146_5, arg_143_1.talkMaxDuration)

			if var_146_4 <= arg_143_1.time_ and arg_143_1.time_ < var_146_4 + var_146_12 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_4) / var_146_12

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_4 + var_146_12 and arg_143_1.time_ < var_146_4 + var_146_12 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
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

		arg_143_1:InitPlayNodeList()
	end,
	Play113061036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 113061036
		arg_147_1.duration_ = 13.2

		local var_147_0 = {
			ja = 13.2,
			ko = 11,
			zh = 11.2,
			en = 11.366
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
				arg_147_0:Play113061037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1.var_.moveOldPos1084ui_story = arg_147_1.actors_["1084ui_story"].transform.localPosition
			end

			local var_150_0 = 0.001

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 then
				arg_147_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (arg_147_1.time_ - 0) / var_150_0)
				arg_147_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).z)
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles = arg_147_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 then
				arg_147_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0.7, -0.97, -6)
				arg_147_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_147_1.actors_["1084ui_story"].transform.position).z)
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_147_1.actors_["1084ui_story"].transform.localEulerAngles = arg_147_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action7_1")
			end

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 then
				arg_147_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			local var_150_1 = arg_147_1.actors_["1084ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1084ui_story == nil then
				arg_147_1.var_.characterEffect1084ui_story = var_150_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_2 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_2 and not isNil(var_150_1) then
				if arg_147_1.var_.characterEffect1084ui_story and not isNil(var_150_1) then
					arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= 0 + var_150_2 and arg_147_1.time_ < 0 + var_150_2 + arg_150_0 and not isNil(var_150_1) and arg_147_1.var_.characterEffect1084ui_story then
				arg_147_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_150_4 = arg_147_1.actors_["1097ui_story"]

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect1097ui_story == nil then
				arg_147_1.var_.characterEffect1097ui_story = var_150_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_5 = 0.2

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_5 and not isNil(var_150_4) then
				if arg_147_1.var_.characterEffect1097ui_story and not isNil(var_150_4) then
					arg_147_1.var_.characterEffect1097ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1097ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_5)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_5 and arg_147_1.time_ < 0 + var_150_5 + arg_150_0 and not isNil(var_150_4) and arg_147_1.var_.characterEffect1097ui_story then
				arg_147_1.var_.characterEffect1097ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1097ui_story.fillRatio = 0.5
			end

			local var_150_6 = 0
			local var_150_7 = 1.25

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_6 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				arg_147_1.leftNameTxt_.text = arg_147_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_8 = arg_147_1:GetWordFromCfg(113061036)
				local var_150_9 = arg_147_1:FormatText(var_150_8.content)

				arg_147_1.text_.text = var_150_9

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_11 = 50 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 50)

				if (50 <= 0 and var_150_7 or var_150_7 * (utf8.len(var_150_9) / 50)) > 0 and var_150_7 < var_150_11 then
					arg_147_1.talkMaxDuration = var_150_11

					if var_150_11 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_11 + var_150_6
					end
				end

				arg_147_1.text_.text = var_150_9
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061036", "story_v_out_113061.awb") ~= 0 then
					local var_150_12 = manager.audio:GetVoiceLength("story_v_out_113061", "113061036", "story_v_out_113061.awb") / 1000

					if var_150_12 + var_150_6 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_12 + var_150_6
					end

					if var_150_8.prefab_name ~= "" and arg_147_1.actors_[var_150_8.prefab_name] ~= nil then
						local var_150_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_8.prefab_name].transform, "story_v_out_113061", "113061036", "story_v_out_113061.awb")

						arg_147_1:RecordAudio("113061036", var_150_13)
						arg_147_1:RecordAudio("113061036", var_150_13)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_113061", "113061036", "story_v_out_113061.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_113061", "113061036", "story_v_out_113061.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_14 = math.max(var_150_7, arg_147_1.talkMaxDuration)

			if var_150_6 <= arg_147_1.time_ and arg_147_1.time_ < var_150_6 + var_150_14 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_6) / var_150_14

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_6 + var_150_14 and arg_147_1.time_ < var_150_6 + var_150_14 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {
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

		arg_147_1:InitPlayNodeList()
	end,
	Play113061037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 113061037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play113061038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story == nil then
				arg_151_1.var_.characterEffect1084ui_story = arg_151_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.2

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) then
				if arg_151_1.var_.characterEffect1084ui_story and not isNil(arg_151_1.actors_["1084ui_story"]) then
					arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_151_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_151_1.time_ - 0) / var_154_0)
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["1084ui_story"]) and arg_151_1.var_.characterEffect1084ui_story then
				arg_151_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_151_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_154_1 = 0
			local var_154_2 = 0.425

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, true)
				arg_151_1.iconController_:SetSelectedState("hero")

				arg_151_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin")

				arg_151_1.callingController_:SetSelectedState("normal")

				arg_151_1.keyicon_.color = Color.New(1, 1, 1)
				arg_151_1.icon_.color = Color.New(1, 1, 1)

				local var_154_3 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(113061037).content)

				arg_151_1.text_.text = var_154_3

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_5 = 17 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 17)

				if (17 <= 0 and var_154_2 or var_154_2 * (utf8.len(var_154_3) / 17)) > 0 and var_154_2 < var_154_5 then
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
	Play113061038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 113061038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play113061039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1097ui_story = arg_155_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_158_0 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_0 then
				arg_155_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_0)
				arg_155_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).z)
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles = arg_155_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_0 and arg_155_1.time_ < 0 + var_158_0 + arg_158_0 then
				arg_155_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_155_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_155_1.actors_["1097ui_story"].transform.position).z)
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_155_1.actors_["1097ui_story"].transform.localEulerAngles = arg_155_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_158_1 = arg_155_1.actors_["1084ui_story"].transform

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1.var_.moveOldPos1084ui_story = var_158_1.localPosition
			end

			local var_158_2 = 0.001

			if 0 <= arg_155_1.time_ and arg_155_1.time_ < 0 + var_158_2 then
				var_158_1.localPosition = Vector3.Lerp(arg_155_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_155_1.time_ - 0) / var_158_2)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			if arg_155_1.time_ >= 0 + var_158_2 and arg_155_1.time_ < 0 + var_158_2 + arg_158_0 then
				var_158_1.localPosition = Vector3.New(0, 100, 0)
				var_158_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_158_1.position).x, (manager.ui.mainCamera.transform.position - var_158_1.position).y, (manager.ui.mainCamera.transform.position - var_158_1.position).z)
				var_158_1.localEulerAngles.z = 0
				var_158_1.localEulerAngles.x = 0
				var_158_1.localEulerAngles = var_158_1.localEulerAngles
			end

			local var_158_3 = 0
			local var_158_4 = 0.95

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_3 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, false)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_5 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(113061038).content)

				arg_155_1.text_.text = var_158_5

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_7 = 38 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 38)

				if (38 <= 0 and var_158_4 or var_158_4 * (utf8.len(var_158_5) / 38)) > 0 and var_158_4 < var_158_7 then
					arg_155_1.talkMaxDuration = var_158_7

					if var_158_7 + var_158_3 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_7 + var_158_3
					end
				end

				arg_155_1.text_.text = var_158_5
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_8 = math.max(var_158_4, arg_155_1.talkMaxDuration)

			if var_158_3 <= arg_155_1.time_ and arg_155_1.time_ < var_158_3 + var_158_8 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_3) / var_158_8

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_3 + var_158_8 and arg_155_1.time_ < var_158_3 + var_158_8 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {
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

		arg_155_1:InitPlayNodeList()
	end,
	Play113061039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 113061039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play113061040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 1.05

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, false)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_1 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(113061039).content)

				arg_159_1.text_.text = var_162_1

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_3 = 42 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 42)

				if (42 <= 0 and var_162_0 or var_162_0 * (utf8.len(var_162_1) / 42)) > 0 and var_162_0 < var_162_3 then
					arg_159_1.talkMaxDuration = var_162_3

					if var_162_3 + 0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_3 + 0
					end
				end

				arg_159_1.text_.text = var_162_1
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_4 = math.max(var_162_0, arg_159_1.talkMaxDuration)

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_4 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - 0) / var_162_4

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= 0 + var_162_4 and arg_159_1.time_ < 0 + var_162_4 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play113061040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 113061040
		arg_163_1.duration_ = 2.33

		local var_163_0 = {
			ja = 2.333,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.2
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play113061041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1.var_.moveOldPos1041ui_story = arg_163_1.actors_["1041ui_story"].transform.localPosition

				arg_163_1:ShowWeapon(arg_163_1.var_["1041ui_story" .. "Animator"].transform, true)
			end

			local var_166_0 = 0.001

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 then
				arg_163_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos1041ui_story, Vector3.New(0, -1.11, -5.9), (arg_163_1.time_ - 0) / var_166_0)
				arg_163_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1041ui_story"].transform.position).z)
				arg_163_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1041ui_story"].transform.localEulerAngles = arg_163_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 then
				arg_163_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, -1.11, -5.9)
				arg_163_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_163_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_163_1.actors_["1041ui_story"].transform.position).z)
				arg_163_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_163_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_163_1.actors_["1041ui_story"].transform.localEulerAngles = arg_163_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action8_1")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_166_1 = arg_163_1.actors_["1084ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1084ui_story == nil then
				arg_163_1.var_.characterEffect1084ui_story = var_166_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_2 = 0.2

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_2 and not isNil(var_166_1) then
				if arg_163_1.var_.characterEffect1084ui_story and not isNil(var_166_1) then
					arg_163_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_2 and arg_163_1.time_ < 0 + var_166_2 + arg_166_0 and not isNil(var_166_1) and arg_163_1.var_.characterEffect1084ui_story then
				arg_163_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_166_6 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_163_1.bgmTxt_.text ~= var_166_6 and arg_163_1.bgmTxt_.text ~= "" then
						if arg_163_1.bgmTxt2_.text ~= "" then
							arg_163_1.bgmTxt_.text = arg_163_1.bgmTxt2_.text
						end

						arg_163_1.bgmTxt2_.text = var_166_6

						arg_163_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_163_1.bgmTxt_.text = var_166_6
						arg_163_1.bgmTxt2_.text = var_166_6
					end

					if arg_163_1.bgmTimer then
						arg_163_1.bgmTimer:Stop()

						arg_163_1.bgmTimer = nil
					end

					if arg_163_1.settingData.show_music_name == 1 then
						arg_163_1.musicController:SetSelectedState("show")
						arg_163_1.musicAnimator_:Play("open", 0, 0)

						if arg_163_1.settingData.music_time ~= 0 then
							arg_163_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_163_1.settingData.music_time), function()
								if arg_163_1 == nil or isNil(arg_163_1.bgmTxt_) then
									return
								end

								arg_163_1.musicController:SetSelectedState("hide")
								arg_163_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_166_7 = 0
			local var_166_8 = 0.075

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_7 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_9 = arg_163_1:GetWordFromCfg(113061040)
				local var_166_10 = arg_163_1:FormatText(var_166_9.content)

				arg_163_1.text_.text = var_166_10

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_12 = 3 <= 0 and var_166_8 or var_166_8 * (utf8.len(var_166_10) / 3)

				if (3 <= 0 and var_166_8 or var_166_8 * (utf8.len(var_166_10) / 3)) > 0 and var_166_8 < var_166_12 then
					arg_163_1.talkMaxDuration = var_166_12

					if var_166_12 + var_166_7 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_12 + var_166_7
					end
				end

				arg_163_1.text_.text = var_166_10
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061040", "story_v_out_113061.awb") ~= 0 then
					local var_166_13 = manager.audio:GetVoiceLength("story_v_out_113061", "113061040", "story_v_out_113061.awb") / 1000

					if var_166_13 + var_166_7 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_13 + var_166_7
					end

					if var_166_9.prefab_name ~= "" and arg_163_1.actors_[var_166_9.prefab_name] ~= nil then
						local var_166_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_9.prefab_name].transform, "story_v_out_113061", "113061040", "story_v_out_113061.awb")

						arg_163_1:RecordAudio("113061040", var_166_14)
						arg_163_1:RecordAudio("113061040", var_166_14)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_113061", "113061040", "story_v_out_113061.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_113061", "113061040", "story_v_out_113061.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_15 = math.max(var_166_8, arg_163_1.talkMaxDuration)

			if var_166_7 <= arg_163_1.time_ and arg_163_1.time_ < var_166_7 + var_166_15 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_7) / var_166_15

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_7 + var_166_15 and arg_163_1.time_ < var_166_7 + var_166_15 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_163_1:InitPlayNodeList()
	end,
	Play113061041 = function(arg_168_0, arg_168_1)
		arg_168_1.time_ = 0
		arg_168_1.frameCnt_ = 0
		arg_168_1.state_ = "playing"
		arg_168_1.curTalkId_ = 113061041
		arg_168_1.duration_ = 5.6

		SetActive(arg_168_1.tipsGo_, false)

		function arg_168_1.onSingleLineFinish_()
			arg_168_1.onSingleLineUpdate_ = nil
			arg_168_1.onSingleLineFinish_ = nil
			arg_168_1.state_ = "waiting"
		end

		function arg_168_1.playNext_(arg_170_0)
			if arg_170_0 == 1 then
				arg_168_0:Play113061042(arg_168_1)
			end
		end

		function arg_168_1.onSingleLineUpdate_(arg_171_0)
			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.moveOldPos1041ui_story = arg_168_1.actors_["1041ui_story"].transform.localPosition

				arg_168_1:ShowWeapon(arg_168_1.var_["1041ui_story" .. "Animator"].transform, false)
			end

			local var_171_0 = 0.001

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_0 then
				arg_168_1.actors_["1041ui_story"].transform.localPosition = Vector3.Lerp(arg_168_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_168_1.time_ - 0) / var_171_0)
				arg_168_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1041ui_story"].transform.position).z)
				arg_168_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1041ui_story"].transform.localEulerAngles = arg_168_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			if arg_168_1.time_ >= 0 + var_171_0 and arg_168_1.time_ < 0 + var_171_0 + arg_171_0 then
				arg_168_1.actors_["1041ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_168_1.actors_["1041ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_168_1.actors_["1041ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1041ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_168_1.actors_["1041ui_story"].transform.position).z)
				arg_168_1.actors_["1041ui_story"].transform.localEulerAngles.z = 0
				arg_168_1.actors_["1041ui_story"].transform.localEulerAngles.x = 0
				arg_168_1.actors_["1041ui_story"].transform.localEulerAngles = arg_168_1.actors_["1041ui_story"].transform.localEulerAngles
			end

			local var_171_1 = manager.ui.mainCamera.transform

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1.var_.shakeOldPos = var_171_1.localPosition
			end

			local var_171_2 = 0.6

			if 0 <= arg_168_1.time_ and arg_168_1.time_ < 0 + var_171_2 then
				local var_171_3, var_171_4 = math.modf((arg_168_1.time_ - 0) / 0.066)

				var_171_1.localPosition = Vector3.New(var_171_4 * 0.13, var_171_4 * 0.13, var_171_4 * 0.13) + arg_168_1.var_.shakeOldPos
			end

			if arg_168_1.time_ >= 0 + var_171_2 and arg_168_1.time_ < 0 + var_171_2 + arg_171_0 then
				var_171_1.localPosition = arg_168_1.var_.shakeOldPos
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:AudioAction("play", "effect", "se_story_10", "se_story_10_sword04", "")
			end

			if 0 < arg_168_1.time_ and arg_168_1.time_ <= 0 + arg_171_0 then
				arg_168_1:AudioAction("play", "music", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle.awb")

				local var_171_8 = manager.audio:GetAudioName("bgm_activity_1_3_story_battle", "bgm_activity_1_3_story_battle")

				if "" ~= "" then
					if arg_168_1.bgmTxt_.text ~= var_171_8 and arg_168_1.bgmTxt_.text ~= "" then
						if arg_168_1.bgmTxt2_.text ~= "" then
							arg_168_1.bgmTxt_.text = arg_168_1.bgmTxt2_.text
						end

						arg_168_1.bgmTxt2_.text = var_171_8

						arg_168_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_168_1.bgmTxt_.text = var_171_8
						arg_168_1.bgmTxt2_.text = var_171_8
					end

					if arg_168_1.bgmTimer then
						arg_168_1.bgmTimer:Stop()

						arg_168_1.bgmTimer = nil
					end

					if arg_168_1.settingData.show_music_name == 1 then
						arg_168_1.musicController:SetSelectedState("show")
						arg_168_1.musicAnimator_:Play("open", 0, 0)

						if arg_168_1.settingData.music_time ~= 0 then
							arg_168_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_168_1.settingData.music_time), function()
								if arg_168_1 == nil or isNil(arg_168_1.bgmTxt_) then
									return
								end

								arg_168_1.musicController:SetSelectedState("hide")
								arg_168_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_168_1.frameCnt_ <= 1 then
				arg_168_1.dialog_:SetActive(false)
			end

			local var_171_9 = 0.6
			local var_171_10 = 0.975

			if 0.6 < arg_168_1.time_ and arg_168_1.time_ <= var_171_9 + arg_171_0 then
				arg_168_1.talkMaxDuration = 0

				arg_168_1.dialog_:SetActive(true)

				arg_168_1.dialogCg_.alpha = 0

				local var_171_11 = LeanTween.value(arg_168_1.dialog_, 0, 1, 0.3)

				var_171_11:setOnUpdate(LuaHelper.FloatAction(function(arg_173_0)
					arg_168_1.dialogCg_.alpha = arg_173_0
				end))
				var_171_11:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_168_1.dialog_)
					var_171_11:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_168_1.duration_ = arg_168_1.duration_ + 0.3

				SetActive(arg_168_1.leftNameGo_, false)

				arg_168_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_168_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_168_1:RecordName(arg_168_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_168_1.iconTrs_.gameObject, false)
				arg_168_1.callingController_:SetSelectedState("normal")

				local var_171_12 = arg_168_1:FormatText(arg_168_1:GetWordFromCfg(113061041).content)

				arg_168_1.text_.text = var_171_12

				LuaForUtil.ClearLinePrefixSymbol(arg_168_1.text_)

				local var_171_14 = 39 <= 0 and var_171_10 or var_171_10 * (utf8.len(var_171_12) / 39)

				if (39 <= 0 and var_171_10 or var_171_10 * (utf8.len(var_171_12) / 39)) > 0 and var_171_10 < var_171_14 then
					arg_168_1.talkMaxDuration = var_171_14
					var_171_9 = var_171_9 + 0.3

					if var_171_14 + var_171_9 > arg_168_1.duration_ then
						arg_168_1.duration_ = var_171_14 + var_171_9
					end
				end

				arg_168_1.text_.text = var_171_12
				arg_168_1.typewritter.percent = 0

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(false)
				arg_168_1:RecordContent(arg_168_1.text_.text)
			end

			local var_171_15 = var_171_9 + 0.3
			local var_171_16 = math.max(var_171_10, arg_168_1.talkMaxDuration)

			if var_171_9 + 0.3 <= arg_168_1.time_ and arg_168_1.time_ < var_171_15 + var_171_16 then
				arg_168_1.typewritter.percent = (arg_168_1.time_ - var_171_15) / var_171_16

				arg_168_1.typewritter:SetDirty()
			end

			if arg_168_1.time_ >= var_171_15 + var_171_16 and arg_168_1.time_ < var_171_15 + var_171_16 + arg_171_0 then
				arg_168_1.typewritter.percent = 1

				arg_168_1.typewritter:SetDirty()
				arg_168_1:ShowNextGo(true)
			end
		end

		arg_168_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_168_1:InitPlayNodeList()
	end,
	Play113061042 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 113061042
		arg_175_1.duration_ = 2.1

		local var_175_0 = {
			ja = 2.066,
			ko = 2.033,
			zh = 1.999999999999,
			en = 2.1
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play113061043(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.var_.moveOldPos1084ui_story = arg_175_1.actors_["1084ui_story"].transform.localPosition

				arg_175_1:ShowWeapon(arg_175_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_178_0 = 0.001

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_0 then
				arg_175_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_175_1.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (arg_175_1.time_ - 0) / var_178_0)
				arg_175_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).z)
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles = arg_175_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_175_1.time_ >= 0 + var_178_0 and arg_175_1.time_ < 0 + var_178_0 + arg_178_0 then
				arg_175_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, -0.97, -6)
				arg_175_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_175_1.actors_["1084ui_story"].transform.position).z)
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_175_1.actors_["1084ui_story"].transform.localEulerAngles = arg_175_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_178_1 = arg_175_1.actors_["1084ui_story"]

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1084ui_story == nil then
				arg_175_1.var_.characterEffect1084ui_story = var_178_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_178_2 = 0.2

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_2 and not isNil(var_178_1) then
				if arg_175_1.var_.characterEffect1084ui_story and not isNil(var_178_1) then
					arg_175_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_175_1.time_ >= 0 + var_178_2 and arg_175_1.time_ < 0 + var_178_2 + arg_178_0 and not isNil(var_178_1) and arg_175_1.var_.characterEffect1084ui_story then
				arg_175_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_178_4 = 0
			local var_178_5 = 0.15

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_4 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_6 = arg_175_1:GetWordFromCfg(113061042)
				local var_178_7 = arg_175_1:FormatText(var_178_6.content)

				arg_175_1.text_.text = var_178_7

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_9 = 6 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 6)

				if (6 <= 0 and var_178_5 or var_178_5 * (utf8.len(var_178_7) / 6)) > 0 and var_178_5 < var_178_9 then
					arg_175_1.talkMaxDuration = var_178_9

					if var_178_9 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_9 + var_178_4
					end
				end

				arg_175_1.text_.text = var_178_7
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061042", "story_v_out_113061.awb") ~= 0 then
					local var_178_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061042", "story_v_out_113061.awb") / 1000

					if var_178_10 + var_178_4 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_10 + var_178_4
					end

					if var_178_6.prefab_name ~= "" and arg_175_1.actors_[var_178_6.prefab_name] ~= nil then
						local var_178_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_6.prefab_name].transform, "story_v_out_113061", "113061042", "story_v_out_113061.awb")

						arg_175_1:RecordAudio("113061042", var_178_11)
						arg_175_1:RecordAudio("113061042", var_178_11)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_113061", "113061042", "story_v_out_113061.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_113061", "113061042", "story_v_out_113061.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_12 = math.max(var_178_5, arg_175_1.talkMaxDuration)

			if var_178_4 <= arg_175_1.time_ and arg_175_1.time_ < var_178_4 + var_178_12 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_4) / var_178_12

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_4 + var_178_12 and arg_175_1.time_ < var_178_4 + var_178_12 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {
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

		arg_175_1:InitPlayNodeList()
	end,
	Play113061043 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 113061043
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play113061044(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos1084ui_story = arg_179_1.actors_["1084ui_story"].transform.localPosition

				arg_179_1:ShowWeapon(arg_179_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_182_0 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 then
				arg_179_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_179_1.time_ - 0) / var_182_0)
				arg_179_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).z)
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles = arg_179_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 then
				arg_179_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_179_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_179_1.actors_["1084ui_story"].transform.position).z)
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_179_1.actors_["1084ui_story"].transform.localEulerAngles = arg_179_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			local var_182_1 = 0
			local var_182_2 = 1.25

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

				local var_182_3 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(113061043).content)

				arg_179_1.text_.text = var_182_3

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_5 = 50 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 50)

				if (50 <= 0 and var_182_2 or var_182_2 * (utf8.len(var_182_3) / 50)) > 0 and var_182_2 < var_182_5 then
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

		arg_179_1.nodeConfigList_ = {
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

		arg_179_1:InitPlayNodeList()
	end,
	Play113061044 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 113061044
		arg_183_1.duration_ = 4.17

		local var_183_0 = {
			ja = 4.066,
			ko = 3.166,
			zh = 2.133,
			en = 4.166
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
				arg_183_0:Play113061045(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_186_0 = 0.6

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 then
				local var_186_1, var_186_2 = math.modf((arg_183_1.time_ - 0) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_186_2 * 0.13, var_186_2 * 0.13, var_186_2 * 0.13) + arg_183_1.var_.shakeOldPos
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 then
				manager.ui.mainCamera.transform.localPosition = arg_183_1.var_.shakeOldPos
			end

			local var_186_3 = 0
			local var_186_4 = 0.25

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_3 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				arg_183_1.leftNameTxt_.text = arg_183_1:FormatText(StoryNameCfg[212].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, true)
				arg_183_1.iconController_:SetSelectedState("hero")

				arg_183_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10006")

				arg_183_1.callingController_:SetSelectedState("normal")

				arg_183_1.keyicon_.color = Color.New(1, 1, 1)
				arg_183_1.icon_.color = Color.New(1, 1, 1)

				local var_186_5 = arg_183_1:GetWordFromCfg(113061044)
				local var_186_6 = arg_183_1:FormatText(var_186_5.content)

				arg_183_1.text_.text = var_186_6

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_8 = 10 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 10)

				if (10 <= 0 and var_186_4 or var_186_4 * (utf8.len(var_186_6) / 10)) > 0 and var_186_4 < var_186_8 then
					arg_183_1.talkMaxDuration = var_186_8

					if var_186_8 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_8 + var_186_3
					end
				end

				arg_183_1.text_.text = var_186_6
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061044", "story_v_out_113061.awb") ~= 0 then
					local var_186_9 = manager.audio:GetVoiceLength("story_v_out_113061", "113061044", "story_v_out_113061.awb") / 1000

					if var_186_9 + var_186_3 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_9 + var_186_3
					end

					if var_186_5.prefab_name ~= "" and arg_183_1.actors_[var_186_5.prefab_name] ~= nil then
						local var_186_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_5.prefab_name].transform, "story_v_out_113061", "113061044", "story_v_out_113061.awb")

						arg_183_1:RecordAudio("113061044", var_186_10)
						arg_183_1:RecordAudio("113061044", var_186_10)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_113061", "113061044", "story_v_out_113061.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_113061", "113061044", "story_v_out_113061.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_11 = math.max(var_186_4, arg_183_1.talkMaxDuration)

			if var_186_3 <= arg_183_1.time_ and arg_183_1.time_ < var_186_3 + var_186_11 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_3) / var_186_11

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_3 + var_186_11 and arg_183_1.time_ < var_186_3 + var_186_11 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play113061045 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 113061045
		arg_187_1.duration_ = 5

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play113061046(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = 0.8

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, false)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_1 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(113061045).content)

				arg_187_1.text_.text = var_190_1

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_3 = 32 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 32)

				if (32 <= 0 and var_190_0 or var_190_0 * (utf8.len(var_190_1) / 32)) > 0 and var_190_0 < var_190_3 then
					arg_187_1.talkMaxDuration = var_190_3

					if var_190_3 + 0 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_3 + 0
					end
				end

				arg_187_1.text_.text = var_190_1
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_4 = math.max(var_190_0, arg_187_1.talkMaxDuration)

			if 0 <= arg_187_1.time_ and arg_187_1.time_ < 0 + var_190_4 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - 0) / var_190_4

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= 0 + var_190_4 and arg_187_1.time_ < 0 + var_190_4 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {}

		arg_187_1:InitPlayNodeList()
	end,
	Play113061046 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 113061046
		arg_191_1.duration_ = 2.83

		local var_191_0 = {
			ja = 2.833,
			ko = 2.7,
			zh = 1.999999999999,
			en = 1.999999999999
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
				arg_191_0:Play113061047(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1.var_.moveOldPos1084ui_story = arg_191_1.actors_["1084ui_story"].transform.localPosition

				arg_191_1:ShowWeapon(arg_191_1.var_["1084ui_story" .. "Animator"].transform, true)
			end

			local var_194_0 = 0.001

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_0 then
				arg_191_1.actors_["1084ui_story"].transform.localPosition = Vector3.Lerp(arg_191_1.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (arg_191_1.time_ - 0) / var_194_0)
				arg_191_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).z)
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles = arg_191_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if arg_191_1.time_ >= 0 + var_194_0 and arg_191_1.time_ < 0 + var_194_0 + arg_194_0 then
				arg_191_1.actors_["1084ui_story"].transform.localPosition = Vector3.New(-0.7, -0.97, -6)
				arg_191_1.actors_["1084ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_191_1.actors_["1084ui_story"].transform.position).z)
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.z = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles.x = 0
				arg_191_1.actors_["1084ui_story"].transform.localEulerAngles = arg_191_1.actors_["1084ui_story"].transform.localEulerAngles
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/story1084/story1084action/1084action11_1")
			end

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 then
				arg_191_1:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_194_1 = arg_191_1.actors_["1084ui_story"]

			if 0 < arg_191_1.time_ and arg_191_1.time_ <= 0 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1084ui_story == nil then
				arg_191_1.var_.characterEffect1084ui_story = var_194_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.2

			if 0 <= arg_191_1.time_ and arg_191_1.time_ < 0 + var_194_2 and not isNil(var_194_1) then
				if arg_191_1.var_.characterEffect1084ui_story and not isNil(var_194_1) then
					arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= 0 + var_194_2 and arg_191_1.time_ < 0 + var_194_2 + arg_194_0 and not isNil(var_194_1) and arg_191_1.var_.characterEffect1084ui_story then
				arg_191_1.var_.characterEffect1084ui_story.fillFlat = false
			end

			local var_194_4 = 0
			local var_194_5 = 0.2

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

				local var_194_6 = arg_191_1:GetWordFromCfg(113061046)
				local var_194_7 = arg_191_1:FormatText(var_194_6.content)

				arg_191_1.text_.text = var_194_7

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_9 = 8 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 8)

				if (8 <= 0 and var_194_5 or var_194_5 * (utf8.len(var_194_7) / 8)) > 0 and var_194_5 < var_194_9 then
					arg_191_1.talkMaxDuration = var_194_9

					if var_194_9 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_9 + var_194_4
					end
				end

				arg_191_1.text_.text = var_194_7
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061046", "story_v_out_113061.awb") ~= 0 then
					local var_194_10 = manager.audio:GetVoiceLength("story_v_out_113061", "113061046", "story_v_out_113061.awb") / 1000

					if var_194_10 + var_194_4 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_10 + var_194_4
					end

					if var_194_6.prefab_name ~= "" and arg_191_1.actors_[var_194_6.prefab_name] ~= nil then
						local var_194_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_6.prefab_name].transform, "story_v_out_113061", "113061046", "story_v_out_113061.awb")

						arg_191_1:RecordAudio("113061046", var_194_11)
						arg_191_1:RecordAudio("113061046", var_194_11)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_113061", "113061046", "story_v_out_113061.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_113061", "113061046", "story_v_out_113061.awb")
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

		arg_191_1.nodeConfigList_ = {
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

		arg_191_1:InitPlayNodeList()
	end,
	Play113061047 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 113061047
		arg_195_1.duration_ = 11.07

		local var_195_0 = {
			ja = 11.066,
			ko = 5.766,
			zh = 5.566,
			en = 8.4
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
				arg_195_0:Play113061048(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) and arg_195_1.var_.characterEffect1084ui_story == nil then
				arg_195_1.var_.characterEffect1084ui_story = arg_195_1.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_0 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) then
				if arg_195_1.var_.characterEffect1084ui_story and not isNil(arg_195_1.actors_["1084ui_story"]) then
					arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
					arg_195_1.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_195_1.time_ - 0) / var_198_0)
				end
			end

			if arg_195_1.time_ >= 0 + var_198_0 and arg_195_1.time_ < 0 + var_198_0 + arg_198_0 and not isNil(arg_195_1.actors_["1084ui_story"]) and arg_195_1.var_.characterEffect1084ui_story then
				arg_195_1.var_.characterEffect1084ui_story.fillFlat = true
				arg_195_1.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			local var_198_1 = arg_195_1.actors_["1042ui_story"].transform

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1.var_.moveOldPos1042ui_story = var_198_1.localPosition
			end

			local var_198_2 = 0.001

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_2 then
				var_198_1.localPosition = Vector3.Lerp(arg_195_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_195_1.time_ - 0) / var_198_2)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			if arg_195_1.time_ >= 0 + var_198_2 and arg_195_1.time_ < 0 + var_198_2 + arg_198_0 then
				var_198_1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_198_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_198_1.position).x, (manager.ui.mainCamera.transform.position - var_198_1.position).y, (manager.ui.mainCamera.transform.position - var_198_1.position).z)
				var_198_1.localEulerAngles.z = 0
				var_198_1.localEulerAngles.x = 0
				var_198_1.localEulerAngles = var_198_1.localEulerAngles
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 then
				arg_195_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			local var_198_3 = arg_195_1.actors_["1042ui_story"]

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= 0 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect1042ui_story == nil then
				arg_195_1.var_.characterEffect1042ui_story = var_198_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_4 = 0.2

			if 0 <= arg_195_1.time_ and arg_195_1.time_ < 0 + var_198_4 and not isNil(var_198_3) then
				if arg_195_1.var_.characterEffect1042ui_story and not isNil(var_198_3) then
					arg_195_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= 0 + var_198_4 and arg_195_1.time_ < 0 + var_198_4 + arg_198_0 and not isNil(var_198_3) and arg_195_1.var_.characterEffect1042ui_story then
				arg_195_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_198_6 = 0
			local var_198_7 = 0.65

			if 0 < arg_195_1.time_ and arg_195_1.time_ <= var_198_6 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				arg_195_1.leftNameTxt_.text = arg_195_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_8 = arg_195_1:GetWordFromCfg(113061047)
				local var_198_9 = arg_195_1:FormatText(var_198_8.content)

				arg_195_1.text_.text = var_198_9

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_11 = 26 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 26)

				if (26 <= 0 and var_198_7 or var_198_7 * (utf8.len(var_198_9) / 26)) > 0 and var_198_7 < var_198_11 then
					arg_195_1.talkMaxDuration = var_198_11

					if var_198_11 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_11 + var_198_6
					end
				end

				arg_195_1.text_.text = var_198_9
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061047", "story_v_out_113061.awb") ~= 0 then
					local var_198_12 = manager.audio:GetVoiceLength("story_v_out_113061", "113061047", "story_v_out_113061.awb") / 1000

					if var_198_12 + var_198_6 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_12 + var_198_6
					end

					if var_198_8.prefab_name ~= "" and arg_195_1.actors_[var_198_8.prefab_name] ~= nil then
						local var_198_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_8.prefab_name].transform, "story_v_out_113061", "113061047", "story_v_out_113061.awb")

						arg_195_1:RecordAudio("113061047", var_198_13)
						arg_195_1:RecordAudio("113061047", var_198_13)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_113061", "113061047", "story_v_out_113061.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_113061", "113061047", "story_v_out_113061.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_14 = math.max(var_198_7, arg_195_1.talkMaxDuration)

			if var_198_6 <= arg_195_1.time_ and arg_195_1.time_ < var_198_6 + var_198_14 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_6) / var_198_14

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_6 + var_198_14 and arg_195_1.time_ < var_198_6 + var_198_14 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end

		arg_195_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_195_1:InitPlayNodeList()
	end,
	Play113061048 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 113061048
		arg_199_1.duration_ = 13.83

		local var_199_0 = {
			ja = 7.766,
			ko = 8.333,
			zh = 9.766,
			en = 13.833
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play113061049(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1042ui_story = arg_199_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_202_0 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_0 then
				arg_199_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_0)
				arg_199_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1042ui_story"].transform.position).z)
				arg_199_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1042ui_story"].transform.localEulerAngles = arg_199_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_0 and arg_199_1.time_ < 0 + var_202_0 + arg_202_0 then
				arg_199_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_199_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_199_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_199_1.actors_["1042ui_story"].transform.position).z)
				arg_199_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_199_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_199_1.actors_["1042ui_story"].transform.localEulerAngles = arg_199_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_202_1 = arg_199_1.actors_["1084ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1084ui_story = var_202_1.localPosition
			end

			local var_202_2 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_2 then
				var_202_1.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (arg_199_1.time_ - 0) / var_202_2)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_2 and arg_199_1.time_ < 0 + var_202_2 + arg_202_0 then
				var_202_1.localPosition = Vector3.New(0, 100, 0)
				var_202_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_1.position).x, (manager.ui.mainCamera.transform.position - var_202_1.position).y, (manager.ui.mainCamera.transform.position - var_202_1.position).z)
				var_202_1.localEulerAngles.z = 0
				var_202_1.localEulerAngles.x = 0
				var_202_1.localEulerAngles = var_202_1.localEulerAngles
			end

			local var_202_3 = arg_199_1.actors_["1041ui_story"].transform

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1.var_.moveOldPos1041ui_story = var_202_3.localPosition
			end

			local var_202_4 = 0.001

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_4 then
				var_202_3.localPosition = Vector3.Lerp(arg_199_1.var_.moveOldPos1041ui_story, Vector3.New(-0.7, -1.11, -5.9), (arg_199_1.time_ - 0) / var_202_4)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			if arg_199_1.time_ >= 0 + var_202_4 and arg_199_1.time_ < 0 + var_202_4 + arg_202_0 then
				var_202_3.localPosition = Vector3.New(-0.7, -1.11, -5.9)
				var_202_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_202_3.position).x, (manager.ui.mainCamera.transform.position - var_202_3.position).y, (manager.ui.mainCamera.transform.position - var_202_3.position).z)
				var_202_3.localEulerAngles.z = 0
				var_202_3.localEulerAngles.x = 0
				var_202_3.localEulerAngles = var_202_3.localEulerAngles
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/story1041/story1041action/1041action1_1")
			end

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 then
				arg_199_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_202_5 = arg_199_1.actors_["1041ui_story"]

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= 0 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.characterEffect1041ui_story == nil then
				arg_199_1.var_.characterEffect1041ui_story = var_202_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_6 = 0.2

			if 0 <= arg_199_1.time_ and arg_199_1.time_ < 0 + var_202_6 and not isNil(var_202_5) then
				if arg_199_1.var_.characterEffect1041ui_story and not isNil(var_202_5) then
					arg_199_1.var_.characterEffect1041ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= 0 + var_202_6 and arg_199_1.time_ < 0 + var_202_6 + arg_202_0 and not isNil(var_202_5) and arg_199_1.var_.characterEffect1041ui_story then
				arg_199_1.var_.characterEffect1041ui_story.fillFlat = false
			end

			local var_202_8 = 0
			local var_202_9 = 1.15

			if 0 < arg_199_1.time_ and arg_199_1.time_ <= var_202_8 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				arg_199_1.leftNameTxt_.text = arg_199_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_10 = arg_199_1:GetWordFromCfg(113061048)
				local var_202_11 = arg_199_1:FormatText(var_202_10.content)

				arg_199_1.text_.text = var_202_11

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_13 = 46 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 46)

				if (46 <= 0 and var_202_9 or var_202_9 * (utf8.len(var_202_11) / 46)) > 0 and var_202_9 < var_202_13 then
					arg_199_1.talkMaxDuration = var_202_13

					if var_202_13 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_13 + var_202_8
					end
				end

				arg_199_1.text_.text = var_202_11
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061048", "story_v_out_113061.awb") ~= 0 then
					local var_202_14 = manager.audio:GetVoiceLength("story_v_out_113061", "113061048", "story_v_out_113061.awb") / 1000

					if var_202_14 + var_202_8 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_14 + var_202_8
					end

					if var_202_10.prefab_name ~= "" and arg_199_1.actors_[var_202_10.prefab_name] ~= nil then
						local var_202_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_10.prefab_name].transform, "story_v_out_113061", "113061048", "story_v_out_113061.awb")

						arg_199_1:RecordAudio("113061048", var_202_15)
						arg_199_1:RecordAudio("113061048", var_202_15)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_113061", "113061048", "story_v_out_113061.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_113061", "113061048", "story_v_out_113061.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_16 = math.max(var_202_9, arg_199_1.talkMaxDuration)

			if var_202_8 <= arg_199_1.time_ and arg_199_1.time_ < var_202_8 + var_202_16 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_8) / var_202_16

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_8 + var_202_16 and arg_199_1.time_ < var_202_8 + var_202_16 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end

		arg_199_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_199_1:InitPlayNodeList()
	end,
	Play113061049 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 113061049
		arg_203_1.duration_ = 5.37

		local var_203_0 = {
			ja = 5.366,
			ko = 2.9,
			zh = 2.5,
			en = 3.233
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
				arg_203_0:Play113061050(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			if 0 < arg_203_1.time_ and arg_203_1.time_ <= 0 + arg_206_0 then
				arg_203_1:PlayTimeline("1041ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			local var_206_0 = 0
			local var_206_1 = 0.3

			if 0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				arg_203_1.leftNameTxt_.text = arg_203_1:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_2 = arg_203_1:GetWordFromCfg(113061049)
				local var_206_3 = arg_203_1:FormatText(var_206_2.content)

				arg_203_1.text_.text = var_206_3

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 12 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 12)

				if (12 <= 0 and var_206_1 or var_206_1 * (utf8.len(var_206_3) / 12)) > 0 and var_206_1 < var_206_5 then
					arg_203_1.talkMaxDuration = var_206_5

					if var_206_5 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_5 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_3
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061049", "story_v_out_113061.awb") ~= 0 then
					local var_206_6 = manager.audio:GetVoiceLength("story_v_out_113061", "113061049", "story_v_out_113061.awb") / 1000

					if var_206_6 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_6 + var_206_0
					end

					if var_206_2.prefab_name ~= "" and arg_203_1.actors_[var_206_2.prefab_name] ~= nil then
						local var_206_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_2.prefab_name].transform, "story_v_out_113061", "113061049", "story_v_out_113061.awb")

						arg_203_1:RecordAudio("113061049", var_206_7)
						arg_203_1:RecordAudio("113061049", var_206_7)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_113061", "113061049", "story_v_out_113061.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_113061", "113061049", "story_v_out_113061.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_8 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_8 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_8

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_8 and arg_203_1.time_ < var_206_0 + var_206_8 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end

		arg_203_1.nodeConfigList_ = {}

		arg_203_1:InitPlayNodeList()
	end,
	Play113061050 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 113061050
		arg_207_1.duration_ = 8.93

		local var_207_0 = {
			ja = 8.933,
			ko = 7.3,
			zh = 4.3,
			en = 7.8
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
				arg_207_0:Play113061051(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(arg_207_1.actors_["1041ui_story"]) and arg_207_1.var_.characterEffect1041ui_story == nil then
				arg_207_1.var_.characterEffect1041ui_story = arg_207_1.actors_["1041ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_0 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_0 and not isNil(arg_207_1.actors_["1041ui_story"]) then
				if arg_207_1.var_.characterEffect1041ui_story and not isNil(arg_207_1.actors_["1041ui_story"]) then
					arg_207_1.var_.characterEffect1041ui_story.fillFlat = true
					arg_207_1.var_.characterEffect1041ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_207_1.time_ - 0) / var_210_0)
				end
			end

			if arg_207_1.time_ >= 0 + var_210_0 and arg_207_1.time_ < 0 + var_210_0 + arg_210_0 and not isNil(arg_207_1.actors_["1041ui_story"]) and arg_207_1.var_.characterEffect1041ui_story then
				arg_207_1.var_.characterEffect1041ui_story.fillFlat = true
				arg_207_1.var_.characterEffect1041ui_story.fillRatio = 0.5
			end

			local var_210_1 = arg_207_1.actors_["1097ui_story"].transform

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1.var_.moveOldPos1097ui_story = var_210_1.localPosition
			end

			local var_210_2 = 0.001

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_2 then
				var_210_1.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos1097ui_story, Vector3.New(0.7, -0.54, -6.3), (arg_207_1.time_ - 0) / var_210_2)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if arg_207_1.time_ >= 0 + var_210_2 and arg_207_1.time_ < 0 + var_210_2 + arg_210_0 then
				var_210_1.localPosition = Vector3.New(0.7, -0.54, -6.3)
				var_210_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_210_1.position).x, (manager.ui.mainCamera.transform.position - var_210_1.position).y, (manager.ui.mainCamera.transform.position - var_210_1.position).z)
				var_210_1.localEulerAngles.z = 0
				var_210_1.localEulerAngles.x = 0
				var_210_1.localEulerAngles = var_210_1.localEulerAngles
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/story1097/story1097action/1097action6_1")
			end

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 then
				arg_207_1:PlayTimeline("1097ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			local var_210_3 = arg_207_1.actors_["1097ui_story"]

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= 0 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1097ui_story == nil then
				arg_207_1.var_.characterEffect1097ui_story = var_210_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_4 = 0.2

			if 0 <= arg_207_1.time_ and arg_207_1.time_ < 0 + var_210_4 and not isNil(var_210_3) then
				if arg_207_1.var_.characterEffect1097ui_story and not isNil(var_210_3) then
					arg_207_1.var_.characterEffect1097ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= 0 + var_210_4 and arg_207_1.time_ < 0 + var_210_4 + arg_210_0 and not isNil(var_210_3) and arg_207_1.var_.characterEffect1097ui_story then
				arg_207_1.var_.characterEffect1097ui_story.fillFlat = false
			end

			local var_210_6 = 0
			local var_210_7 = 0.45

			if 0 < arg_207_1.time_ and arg_207_1.time_ <= var_210_6 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				arg_207_1.leftNameTxt_.text = arg_207_1:FormatText(StoryNameCfg[216].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_8 = arg_207_1:GetWordFromCfg(113061050)
				local var_210_9 = arg_207_1:FormatText(var_210_8.content)

				arg_207_1.text_.text = var_210_9

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_11 = 18 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 18)

				if (18 <= 0 and var_210_7 or var_210_7 * (utf8.len(var_210_9) / 18)) > 0 and var_210_7 < var_210_11 then
					arg_207_1.talkMaxDuration = var_210_11

					if var_210_11 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_11 + var_210_6
					end
				end

				arg_207_1.text_.text = var_210_9
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_113061", "113061050", "story_v_out_113061.awb") ~= 0 then
					local var_210_12 = manager.audio:GetVoiceLength("story_v_out_113061", "113061050", "story_v_out_113061.awb") / 1000

					if var_210_12 + var_210_6 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_12 + var_210_6
					end

					if var_210_8.prefab_name ~= "" and arg_207_1.actors_[var_210_8.prefab_name] ~= nil then
						local var_210_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_8.prefab_name].transform, "story_v_out_113061", "113061050", "story_v_out_113061.awb")

						arg_207_1:RecordAudio("113061050", var_210_13)
						arg_207_1:RecordAudio("113061050", var_210_13)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_113061", "113061050", "story_v_out_113061.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_113061", "113061050", "story_v_out_113061.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_14 = math.max(var_210_7, arg_207_1.talkMaxDuration)

			if var_210_6 <= arg_207_1.time_ and arg_207_1.time_ < var_210_6 + var_210_14 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_6) / var_210_14

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_6 + var_210_14 and arg_207_1.time_ < var_210_6 + var_210_14 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end

		arg_207_1.nodeConfigList_ = {
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

		arg_207_1:InitPlayNodeList()
	end,
	Play113061051 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 113061051
		arg_211_1.duration_ = 5.72

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
			arg_211_1.auto_ = false
		end

		function arg_211_1.playNext_(arg_213_0)
			arg_211_1.onStoryFinished_()
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1097ui_story = arg_211_1.actors_["1097ui_story"].transform.localPosition
			end

			local var_214_0 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_0 then
				arg_211_1.actors_["1097ui_story"].transform.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1097ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_0)
				arg_211_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).z)
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles = arg_211_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_0 and arg_211_1.time_ < 0 + var_214_0 + arg_214_0 then
				arg_211_1.actors_["1097ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.actors_["1097ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_211_1.actors_["1097ui_story"].transform.position).z)
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.z = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles.x = 0
				arg_211_1.actors_["1097ui_story"].transform.localEulerAngles = arg_211_1.actors_["1097ui_story"].transform.localEulerAngles
			end

			local var_214_1 = arg_211_1.actors_["1041ui_story"].transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.moveOldPos1041ui_story = var_214_1.localPosition
			end

			local var_214_2 = 0.001

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_2 then
				var_214_1.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos1041ui_story, Vector3.New(0, 100, 0), (arg_211_1.time_ - 0) / var_214_2)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			if arg_211_1.time_ >= 0 + var_214_2 and arg_211_1.time_ < 0 + var_214_2 + arg_214_0 then
				var_214_1.localPosition = Vector3.New(0, 100, 0)
				var_214_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_214_1.position).x, (manager.ui.mainCamera.transform.position - var_214_1.position).y, (manager.ui.mainCamera.transform.position - var_214_1.position).z)
				var_214_1.localEulerAngles.z = 0
				var_214_1.localEulerAngles.x = 0
				var_214_1.localEulerAngles = var_214_1.localEulerAngles
			end

			local var_214_3 = manager.ui.mainCamera.transform

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				arg_211_1.var_.shakeOldPos = var_214_3.localPosition
			end

			local var_214_4 = 2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_4 then
				local var_214_5, var_214_6 = math.modf((arg_211_1.time_ - 0) / 0.066)

				var_214_3.localPosition = Vector3.New(var_214_6 * 0.13, var_214_6 * 0.13, var_214_6 * 0.13) + arg_211_1.var_.shakeOldPos
			end

			if arg_211_1.time_ >= 0 + var_214_4 and arg_211_1.time_ < 0 + var_214_4 + arg_214_0 then
				var_214_3.localPosition = arg_211_1.var_.shakeOldPos
			end

			local var_214_7 = 0

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= var_214_7 + arg_214_0 then
				arg_211_1.allBtn_.enabled = false
			end

			if arg_211_1.time_ >= var_214_7 + 2 and arg_211_1.time_ < var_214_7 + 2 + arg_214_0 then
				arg_211_1.allBtn_.enabled = true
			end

			local var_214_8 = "F03"

			if arg_211_1.bgs_.F03 == nil then
				local var_214_9 = Object.Instantiate(arg_211_1.paintGo_)

				var_214_9:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_214_8)
				var_214_9.name = var_214_8
				var_214_9.transform.parent = arg_211_1.stage_.transform
				var_214_9.transform.localPosition = Vector3.New(0, 100, 0)
				arg_211_1.bgs_[var_214_8] = var_214_9
			end

			if 0 < arg_211_1.time_ and arg_211_1.time_ <= 0 + arg_214_0 then
				local var_214_10 = arg_211_1.bgs_.F03:GetComponent("SpriteRenderer")

				if var_214_10 then
					arg_211_1.var_.alphaOldValueF03 = var_214_10.color.a
					arg_211_1.var_.alphaMatValueF03 = var_214_10
				end

				arg_211_1.var_.alphaOldValueF03 = 1
			end

			local var_214_11 = 2

			if 0 <= arg_211_1.time_ and arg_211_1.time_ < 0 + var_214_11 then
				if arg_211_1.var_.alphaMatValueF03 then
					arg_211_1.var_.alphaMatValueF03.color.a = Mathf.Lerp(arg_211_1.var_.alphaOldValueF03, 0, (arg_211_1.time_ - 0) / var_214_11)
					arg_211_1.var_.alphaMatValueF03.color = arg_211_1.var_.alphaMatValueF03.color
				end
			end

			if arg_211_1.time_ >= 0 + var_214_11 and arg_211_1.time_ < 0 + var_214_11 + arg_214_0 and arg_211_1.var_.alphaMatValueF03 then
				arg_211_1.var_.alphaMatValueF03.color.a = 0
				arg_211_1.var_.alphaMatValueF03.color = arg_211_1.var_.alphaMatValueF03.color
			end

			if arg_211_1.frameCnt_ <= 1 then
				arg_211_1.dialog_:SetActive(false)
			end

			local var_214_12 = 0.725
			local var_214_13 = 1.275

			if 0.725 < arg_211_1.time_ and arg_211_1.time_ <= var_214_12 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0

				arg_211_1.dialog_:SetActive(true)

				arg_211_1.dialogCg_.alpha = 0

				local var_214_14 = LeanTween.value(arg_211_1.dialog_, 0, 1, 0.3)

				var_214_14:setOnUpdate(LuaHelper.FloatAction(function(arg_215_0)
					arg_211_1.dialogCg_.alpha = arg_215_0
				end))
				var_214_14:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_211_1.dialog_)
					var_214_14:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_211_1.duration_ = arg_211_1.duration_ + 0.3

				SetActive(arg_211_1.leftNameGo_, false)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_15 = arg_211_1:FormatText(arg_211_1:GetWordFromCfg(113061051).content)

				arg_211_1.text_.text = var_214_15

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_17 = 51 <= 0 and var_214_13 or var_214_13 * (utf8.len(var_214_15) / 51)

				if (51 <= 0 and var_214_13 or var_214_13 * (utf8.len(var_214_15) / 51)) > 0 and var_214_13 < var_214_17 then
					arg_211_1.talkMaxDuration = var_214_17
					var_214_12 = var_214_12 + 0.3

					if var_214_17 + var_214_12 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_17 + var_214_12
					end
				end

				arg_211_1.text_.text = var_214_15
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)
				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_18 = var_214_12 + 0.3
			local var_214_19 = math.max(var_214_13, arg_211_1.talkMaxDuration)

			if var_214_12 + 0.3 <= arg_211_1.time_ and arg_211_1.time_ < var_214_18 + var_214_19 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_18) / var_214_19

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_18 + var_214_19 and arg_211_1.time_ < var_214_18 + var_214_19 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end

		arg_211_1.nodeConfigList_ = {
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
				actorName = "1041ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_211_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/F01"
	},
	voices = {
		"story_v_out_113061.awb"
	}
}
